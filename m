Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55968E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvIK-00014Z-Oi; Thu, 09 Jan 2025 11:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVvIJ-00014K-4y
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:22:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVvIH-0007nV-Mh
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 11:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736439718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fN+4TdjP7HtOpl49VrL2EVFEZTxb8UBK18WC8i1qmo8=;
 b=a+1Z7bIqH/V7zklsZUoznyTq99vxCMIuwT00Z1lGRTBPWsk7HGsRqb8mIeOoOQo1NQUoOe
 2kkXrfkadfgyymoslkIqIqtJw4P/WJuuWuZk7vjD2BmCWMJBHdV0ZZk9JyI0AoMdX7eJUD
 iHsZq6BkS3alw0VxI4kMtJnv7fuSj88=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-rpjs2njSN5aF08nuTvzd0Q-1; Thu, 09 Jan 2025 11:21:56 -0500
X-MC-Unique: rpjs2njSN5aF08nuTvzd0Q-1
X-Mimecast-MFC-AGG-ID: rpjs2njSN5aF08nuTvzd0Q
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e1c50ef1so149025185a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 08:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736439716; x=1737044516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fN+4TdjP7HtOpl49VrL2EVFEZTxb8UBK18WC8i1qmo8=;
 b=ak3zsoLCVP2GXoxkvQAdF0xKj19Rbk3SmcOTELc7VxZ0TnvKZunXNpO9qVak++Vh/u
 fdyDxiY1NyK6kAAYr/sZBuW9Rsxex4V4D9fNl4q3Au8OAxuGPCTfgYs3g2DHUpPlXXIp
 lYx9plLaJ9KCvlmm3fJo8Vj3tAM8EwfZH83nE08gn+JoJnv0a3wRRdcazvco1meleLSB
 MwmIdkrGEwLTRW3kZ2lVTmqjMdzj5I/xm7Bu664d7iN1nDyv0FKicqcuSprc7HuWGTYU
 b+02AledMCOguMoLJvYIkU+pmo8yF4qucGhiLGlawGMF+JAo/yv+W20m4wRgjfpThNuL
 4Ftw==
X-Gm-Message-State: AOJu0YzZWq6bDXJxekRxHV8Cqk82XbSccP7wcsrhcATq1j5d/vgOA7Qv
 aeGbBxeXThSEPSqd7SZZIKC1MK+OZdJqZR5HHUDy5WwTYuuRDnuqXRgH4jDvElVCeQemHo23qby
 v6IEBhIWVcxGj1yfCChqFeusZvNoiOo9rfJnifvzGFTfiHX7TDjccI2iwW458
X-Gm-Gg: ASbGncuIhljMkz8Ras6YE7oDSJlgBTYWt9KlNyrPwYT63IczUmNMRQ7JwS0I+B1Oxs6
 1dQd5PMmM8dbsK04/irSyvL7kCxbW+yQgpZvDkcmvPvPZt5IrO5fSE5YHiG/SOOrTO/mL4Fx/dA
 s2clELaLDfPbxcHfZrNHHSgKc13ynVx3/B578lNIJG3aPFSSlhT+qajgJRs1HoHwui/QA91MDct
 bhWu8TNxamDPCFUErRuGRL1MAypA8I18RAabp5xdqGekPfmJ9QXVLCpUisaGY5WCx5RFJdTk3zG
 /CwW5qDajGg6/QHvjw==
X-Received: by 2002:a05:620a:f06:b0:7b0:6e8:94ef with SMTP id
 af79cd13be357-7bcd96146cemr1096046985a.0.1736439715804; 
 Thu, 09 Jan 2025 08:21:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELeWyWdfxWQ8diW5LMuRkDy5832xJwTwatpllWKS7jERXKrEA1YZzmrEbphLG+IbZ+wcwh+w==
X-Received: by 2002:a05:620a:f06:b0:7b0:6e8:94ef with SMTP id
 af79cd13be357-7bcd96146cemr1096044385a.0.1736439715497; 
 Thu, 09 Jan 2025 08:21:55 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3516193sm81275485a.117.2025.01.09.08.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:21:55 -0800 (PST)
Date: Thu, 9 Jan 2025 11:21:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 6/7] migration: Fix arrays of pointers in JSON writer
Message-ID: <Z3_3oPAypaz2HOfW@x1n>
References: <20250109140959.19464-1-farosas@suse.de>
 <20250109140959.19464-7-farosas@suse.de> <Z3_eZId2Ylj3bCU2@x1n>
 <87r05c2c9m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r05c2c9m.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 09, 2025 at 01:16:37PM -0300, Fabiano Rosas wrote:
> > Btw, since the new code will process it correctly with non-array below,
> > IIUC here we can make it simple:
> >
> >   if 'index' in field:
> >       self.data[fname] = fdata
> >
> 
> Sorry, I don't understand what you mean here. I changed it now to:
> 
>     if fname not in self.data:
>         if 'index' in field:
>             self.data[fname] = [fdata]
>         else:
>             self.data[fname] = fdata
>     elif type(self.data[fname]) == list:
>         self.data[fname].append(fdata)
>     else:
>         tmp = self.data[fname]
>         self.data[fname] = [tmp, fdata]

I meant we could avoid checking "index" completely now with the new code
knowing how to expand, so IIUC it can be simplified to:

  if fname not in self.data:
      self.data[fname] = fdata
  elif type(self.data[fname]) == list:
      self.data[fname].append(fdata)
  else:
      tmp = self.data[fname]
      self.data[fname] = [tmp, fdata]

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF11E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVaIA-0001hV-9L; Wed, 08 Jan 2025 12:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVaI8-0001ff-KP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:56:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVaI6-0007dL-Dm
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736358984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EyExCrp9HZfZ1zLyeVE/Us+rWBBj2/lkllMMyuJd5Ag=;
 b=MBksZg++Nu9bvwvfh5zriVMMPEBIvCgHEXTZ8AG64Cts7FYQvWGfeM9Thg+0QomAzUkZ7p
 +ikc+GtSimb5SeiO+EmiL78JKkGzktSFZMNFGzgGYKx71rKldmziBOFGpdiezxBDM2m6O5
 Ndma/4iDjxXWiu9odcq+12Q74yLoUOA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-JlQvHG3sONWNG85PH63Nzg-1; Wed, 08 Jan 2025 12:56:22 -0500
X-MC-Unique: JlQvHG3sONWNG85PH63Nzg-1
X-Mimecast-MFC-AGG-ID: JlQvHG3sONWNG85PH63Nzg
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467ae19e34bso240948751cf.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 09:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736358982; x=1736963782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyExCrp9HZfZ1zLyeVE/Us+rWBBj2/lkllMMyuJd5Ag=;
 b=EClCcUtulsHYvckYxnwOVbZ0CcIERnRJyIvtbA8fsqHN/ogrYHp1cb3+H6T60XBBcR
 YahnP7ui5flC/ZOxs2fBw2yRRc55iZdNL4JPIrxqtsYEclaVst5fs66sz95Swciy/BJy
 53QldkNBNZQ2RZ45QeWC7YjA1c07fGjzWHo/b3aWdtkaKfWU+1LPdUYuS/bTi6nHDI03
 pErBg9bZuATtyTzlGa6aWSaMpmUsjah3zubHFaYOKV58rv1Q2UmYhM4ZjVVCC5D3l8UL
 u1NtLjsQcIWL/LWXJUShvDUl9QTQNjc5ZWbFMHqlAexkY74wWF5UChSjJCEbCSNAIdWv
 HY8w==
X-Gm-Message-State: AOJu0YyisMAZnTPSGlKShCWa3JH+jujiJzCvGhKAVD7U9aJrNlE0p3e+
 TBdtBIB8J/A5W3J7Hx3d7VKPl7jG9zyf7bRdYHR4uF8EcUbC8hlNMZvCNerxalt/fLn1FaVdnVz
 HrmexcqRtXFvFb8a1bodKBX55c1gnW4tAT4LbXsiBMoYZdlVE1vBI
X-Gm-Gg: ASbGnct0HmqZi4Gf9IaBC4FVsuM9KEs6vsQYjXBX8c4968SbZy4KFXCFvq4gyklTvnC
 Dy/9YeUbPMo66aFo8HoX5fFaivIbe6qXyordU4I46aCRGAHkhafx68NEudOW06MKKatiiIjssw6
 AXW+LDmjfTTcatn3m+VzSkb5KkWfyZM9GRZkKbV8Y4dnMQxGfGx6zt85Mqe+rtA7Xm0+E4BSC8i
 5NcDPKoGDh3ws+CFCSIWJzpXbWuavwA/MX8+L3WMFO7UBmnIVzv2cB+EGsU/TAHvQjqkfb5m+nL
 zmptBWw8ZvCkzBxx3Q==
X-Received: by 2002:a05:622a:1a0d:b0:467:7cda:9388 with SMTP id
 d75a77b69052e-46c7102ff29mr63430001cf.31.1736358982098; 
 Wed, 08 Jan 2025 09:56:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+t5Bx+mpyykZ1zNFoa5D8SZPNrwd6/DbEOPjZ1W6zRn5Mub4raVylQrxasZc1VPjQaNHsjg==
X-Received: by 2002:a05:622a:1a0d:b0:467:7cda:9388 with SMTP id
 d75a77b69052e-46c7102ff29mr63429771cf.31.1736358981850; 
 Wed, 08 Jan 2025 09:56:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e64b845sm198724861cf.6.2025.01.08.09.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 09:56:20 -0800 (PST)
Date: Wed, 8 Jan 2025 12:56:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 6/7] migration: Fix arrays of pointers in JSON writer
Message-ID: <Z368QjYRk9aqJefd@x1n>
References: <20250107195025.9951-1-farosas@suse.de>
 <20250107195025.9951-7-farosas@suse.de> <Z3231YxnKrjtwX6h@x1n>
 <87cygx4dlt.fsf@suse.de> <Z36kScJti9LrWVU7@x1n>
 <875xmp447s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xmp447s.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 08, 2025 at 02:15:19PM -0300, Fabiano Rosas wrote:
> >> >>              else:
> >> >> -                self.data[field['name']] = field['data']
> >> >> +                # There could be multiple entries for the same field
> >> >> +                # name, e.g. when a compressed array was broken in
> >> >> +                # more than one piece.
> >> >> +                if (field['name'] in self.data and
> >> >> +                    type(self.data[field['name']]) == list):
> >> >> +                    self.data[field['name']].append(field['data'])
> >> >> +                else:
> >> >> +                    self.data[field['name']] = field['data']

[...]

> The last nullptr overwrites everything else:
> 
>     "s390_css (14)": {
>         "pending_crws": "00",
>         "sei_pending": false,
>         "do_crw_mchk": true,
>         "crws_lost": false,
>         "max_cssid": "0x00",
>         "max_ssid": "0x00",
>         "chnmon_active": false,
>         "chnmon_area": "0x0000000000000000",
> -->     "css": "nullptr",
>         "default_cssid": "0xfe"
>     },

Oh I see what you meant..

Then I am guessing the current change may not always work, e.g. when the
1st entry only contains one element rather than an array, like:

  {"name": "css", "type": "uint8", "size": 1},
  {"name": "css", "type": "struct", "struct": {"vmsd_name": "s390_css_img", ... }, "size": 768},
  {"name": "css", "array_len": 254, "type": "uint8", "size": 1},

Here we may need something like:

   name = field['name']
   if (name in self.data):
       if (type(self.data[name]) is not list):
          self.data[name] = [self.data[name]]
       self.data[name].append(field['data'])
   else:
       self.data[name] = field['data']

-- 
Peter Xu



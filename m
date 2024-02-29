Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551A0C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfX9U-0006AG-R3; Wed, 28 Feb 2024 22:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfX9T-00069O-7C
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfX9R-00083m-Tw
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709177525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ytlz5Ncdp0dTIEgPG1vXFVNPl9dhaResdhloODn0LGA=;
 b=JWSvtmA4wLX+CRct+1wx+y9KTZRTU45A4fgGSwjikKT0+MbloPQ5vc8vdDOlFhtv8jltKQ
 AYlR3tYEBCS1OA2Rs0PH+q8dMDz1HVP68KWxkYyLsoO6XWRj+onUUlZz00S02atFN8hBzr
 2we59aNoKMIj1Bi/67fUgdbPlTJObM8=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-WpPDhAJgPHC37R3tp_HXhA-1; Wed, 28 Feb 2024 22:32:03 -0500
X-MC-Unique: WpPDhAJgPHC37R3tp_HXhA-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7c7a9a1829fso5167739f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 19:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709177523; x=1709782323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytlz5Ncdp0dTIEgPG1vXFVNPl9dhaResdhloODn0LGA=;
 b=deqjlo/coaBAU1SN2ezs78rROPdbWzapIr8hiXdxUarKBN20EJnPw0ghpo/0hhflOe
 dY3E/h9rOy0VngdOBKPBcd0uXl5OoMhj9cdvePZyfaUX5r3eqVv2fx8wg9olQrMMv3hX
 kdpPFwLemYOZvAclMUs4KYn+lQEqB2/KxAu1trmDoEcmP9cBTMA5iNrtEpes8+b4B9zZ
 /yVbIdS1SuyQuRcmbVKNPKUtNEyWuMngNeLyqsAqqSRVp+hE2CUuv8UhU1Kq38tgKcfV
 0EeRTqp+ZzGQK+drEpnqES44R5/+MpY3Z1Xy0i4+RNjAChRzaClUROnK2juKWPsqhOcx
 T2GA==
X-Gm-Message-State: AOJu0Yz46k+c5vbWmjRLJYNG46EDvBWVcKgrWV1dr2F2wL2RtAE7r+fH
 B6oGzaM6uzJVV+gwqAgHT3SKCADSUOOhvJj9mj/CE4PtICsHjbu1J73J0nyLcOgK0DaECTFJe9L
 C1mXmNXJLctwCxAKwvsd9svr4h+MYv4iRxg0s2cJSMx4awayDVP4I
X-Received: by 2002:a05:6e02:20e8:b0:35f:bc09:c56b with SMTP id
 q8-20020a056e0220e800b0035fbc09c56bmr1318026ilv.2.1709177522878; 
 Wed, 28 Feb 2024 19:32:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2pLsum2Lc8x7pZFWnmzdk8Pt31csDG6Uf5jBZO4viJmH2/cQoa0XcGdqE8fjTZQsW2HrBbQ==
X-Received: by 2002:a05:6e02:20e8:b0:35f:bc09:c56b with SMTP id
 q8-20020a056e0220e800b0035fbc09c56bmr1318012ilv.2.1709177522603; 
 Wed, 28 Feb 2024 19:32:02 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 y7-20020a62f247000000b006e4cf04e501sm194354pfl.13.2024.02.28.19.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 19:32:02 -0800 (PST)
Date: Thu, 29 Feb 2024 11:31:54 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 22/23] migration/multifd: Add mapped-ram support to
 fd: URI
Message-ID: <Zd_6qussKb21Yo0g@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-23-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228152127.18769-23-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 12:21:26PM -0300, Fabiano Rosas wrote:
> If we receive a file descriptor that points to a regular file, there's
> nothing stopping us from doing multifd migration with mapped-ram to
> that file.
> 
> Enable the fd: URI to work with multifd + mapped-ram.
> 
> Note that the fds passed into multifd are duplicated because we want
> to avoid cross-thread effects when doing cleanup (i.e. close(fd)). The
> original fd doesn't need to be duplicated because monitor_get_fd()
> transfers ownership to the caller.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



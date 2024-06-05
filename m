Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09749C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 13:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEqq2-0003fj-O4; Wed, 05 Jun 2024 09:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEqq1-0003f5-23
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEqpy-0003l1-Of
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717594676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b6xw6YXRsGr5/ueWe1rb065BvntpKcPQZx7QBM6A3uE=;
 b=f3J7PEMZa1rGYNmbpjdmL0ydqWeaftpK+CoQacfNrGLv4N8FhAZBMoHd7Pgtj5XkJ9Dk3n
 XOPl3IxAeHyJ64bOb9r6QkgQ15N2ZxlKN4RunCAA6DoFhdCsula6dpBdhVs+YnrBTGSuiC
 6CLDIpkEYo5hoKol/hS75tR5wbys9AA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-gZzeipLENW6trwDCNRDkkg-1; Wed, 05 Jun 2024 09:37:54 -0400
X-MC-Unique: gZzeipLENW6trwDCNRDkkg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-421580a28d1so4788235e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 06:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717594670; x=1718199470;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6xw6YXRsGr5/ueWe1rb065BvntpKcPQZx7QBM6A3uE=;
 b=Ur/J5yIS+dOqfY0rIUn+sSov/rg299r924fNsA3rx3L+jnX/u2QbkMRt06TB5PhuTM
 mGummNjyuaVWspW8cHv6Ayp8x0ov0r+zIJmYj+MEsORqWnAEKgepZMnkcjoTiNZx1sEy
 U5bkYcSdo7PwBw93fq+LWDSvAQ3ZDvWSz77+zPgwWHH52oZMbZVX3/cgWj2RPI+42G3I
 LjJPAof462adNlxtOmDyOecOYJ/s4k4NGcEPqOciBrPWPP1V30kcCFYDgaHFMOHQulie
 giW0pFN6WV9vsnygXdPRcf4OYi/4TT9nVVnitrcSXA4FjsZ2ZuoHIRBbavUvmBXQvg7z
 pr7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSkbW4KFWttheYMQp9zKZQ+JXrBLqcyB6hElq/zzqf+b9LjIO7Q7m8dEBLm/5CwvkFkBKaZ/dWG9EoEaH0jGF3d582D5w=
X-Gm-Message-State: AOJu0YzWIvKNWS6gD/YC+DEmyF6yEyDq6zcK/DKJ7ffffpqaoQww7+6C
 3No8LuYJWFAVCnmgmoXYObDbjMdt+EAkYAXORoIC7m3Uq8bykzziOBzy/QRrgUgz9RIAx0nx3fI
 P9Nsto7YLaz/n8L1W+bL6kwfAXJ0tAaUf3Abeue/6oJsqHLZuY1EJ
X-Received: by 2002:a05:600c:4f84:b0:421:5352:690e with SMTP id
 5b1f17b1804b1-4215632d104mr19342195e9.25.1717594669954; 
 Wed, 05 Jun 2024 06:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7qoHw0INh4GBFo7qnPo3ROqraLXvl4eieufz3EGh+xEalsAd+rFVtjhniBuJCZG4nd6ZVOg==
X-Received: by 2002:a05:600c:4f84:b0:421:5352:690e with SMTP id
 5b1f17b1804b1-4215632d104mr19342055e9.25.1717594669603; 
 Wed, 05 Jun 2024 06:37:49 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158102aabsm22747685e9.13.2024.06.05.06.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 06:37:49 -0700 (PDT)
Message-ID: <53920fad-888c-441b-b301-ca177f04f0fa@redhat.com>
Date: Wed, 5 Jun 2024 15:37:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] s390x: Enable and document boot device fallback on
 panic
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, nsg@linux.ibm.com,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240529154311.734548-1-jrossi@linux.ibm.com>
 <20240529154311.734548-6-jrossi@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240529154311.734548-6-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 29/05/2024 17.43, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> On a panic during IPL (i.e. a device failed to boot) check for another device
> to boot from, as indicated by the presence of an unused IPLB.
> 
> If an IPLB is successfully loaded, then jump to the start of BIOS, restarting
> IPL using the updated IPLB.  Otherwise enter disabled wait.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   docs/system/bootindex.rst         | 7 ++++---
>   docs/system/s390x/bootdevices.rst | 9 ++++++---
>   pc-bios/s390-ccw/s390-ccw.h       | 6 ++++++
>   3 files changed, 16 insertions(+), 6 deletions(-)

Could you please split the documentation changes into a separate patch in v2 
? ... I think that would be cleaner.

> diff --git a/docs/system/bootindex.rst b/docs/system/bootindex.rst
> index 8b057f812f..de597561bd 100644
> --- a/docs/system/bootindex.rst
> +++ b/docs/system/bootindex.rst
> @@ -50,9 +50,10 @@ Limitations
>   
>   Some firmware has limitations on which devices can be considered for
>   booting.  For instance, the PC BIOS boot specification allows only one
> -disk to be bootable.  If boot from disk fails for some reason, the BIOS
> -won't retry booting from other disk.  It can still try to boot from
> -floppy or net, though.
> +disk to be bootable, except for on s390x machines. If boot from disk fails for
> +some reason, the BIOS won't retry booting from other disk.  It can still try to
> +boot from floppy or net, though.  In the case of s390x, the BIOS will try up to
> +8 total devices, any number of which may be disks.

Since the old text was already talking about "PC BIOS", I'd rather leave 
that paragraph as it is (maybe just replace "PC BIOS" with "x86 PC BIOS"), 
and add a separate paragraph afterwards about s390x instead.

> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index c977a52b50..de3d1f0d5a 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -43,6 +43,7 @@ typedef unsigned long long u64;
>   #include "iplb.h"
>   
>   /* start.s */
> +extern char _start[];
>   void disabled_wait(void) __attribute__ ((__noreturn__));
>   void consume_sclp_int(void);
>   void consume_io_int(void);
> @@ -88,6 +89,11 @@ __attribute__ ((__noreturn__))
>   static inline void panic(const char *string)
>   {
>       sclp_print(string);
> +    if (load_next_iplb()) {
> +        sclp_print("\nTrying next boot device...");
> +        jump_to_IPL_code((long)_start);
> +    }
> +
>       disabled_wait();
>   }

Honestly, I am unsure whether this is a really cool idea or a very ugly hack 
... but I think I tend towards the latter, sorry. Jumping back to the 
startup code might cause various problem, e.g. pre-initialized variables 
don't get their values reset, causing different behavior when the s390-ccw 
bios runs a function a second time this way. Thus this sounds very fragile. 
Could we please try to get things cleaned up correctly, so that functions 
return with error codes instead of panicking when we can continue with 
another boot device? Even if its more work right now, I think this will be 
much more maintainable in the future.

  Thomas



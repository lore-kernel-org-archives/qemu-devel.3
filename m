Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32901C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 14:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3FiV-00007x-SE; Fri, 11 Apr 2025 10:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3FiP-00007D-FW
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 10:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3FiN-0003wI-AK
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 10:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744383042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X+z50ZBg4YGZ5ng4dh3ANbgvE9YP8YpvMuKP5HhpZVE=;
 b=hknnRVa7BvafeCxtIeLbOsaz5VZyNmzWCt/0s22tXMKsLh0N6x3Z1rju+TNltfsad3fIE3
 +BOZnNwU0qpaTKBteSOxUaeolh5uTwpiu5hVC8ozHzIWrAbFDy3v/gI3UH3ZsH3/sgPBlJ
 6TScT3XqG8H7XDGDeIrKMLxDHvDPNfI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-6S5_G0YMM5eftGg6jSVCKw-1; Fri, 11 Apr 2025 10:50:39 -0400
X-MC-Unique: 6S5_G0YMM5eftGg6jSVCKw-1
X-Mimecast-MFC-AGG-ID: 6S5_G0YMM5eftGg6jSVCKw_1744383038
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-391492acb59so1211176f8f.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 07:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383038; x=1744987838;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X+z50ZBg4YGZ5ng4dh3ANbgvE9YP8YpvMuKP5HhpZVE=;
 b=cWGgc56qDgbQa/7xSjHiwRChL/sMNm1d5jEyRMOMe/HZrqd9SP5M4Qtccoio1joACI
 C1uNL27GcUkdhWLWLLh1vutU7Si68ParlseAt0TMhmQ8QVucrvFj4krlhkZZWdiRZove
 FKUoLkxfjemUMBHpRXy2Y2K6B+jth5UExSHDvRdum6NAZipi55Nzhan3wPpH4NHt17CG
 l1ZrqoPV1I37YrXJJlN/cyPPAr3Bny6EfED9K6A2zBHSYFNSlKvjnzLct9ulsp4AqkL/
 2CdkJ1ft0cJhRrec9jUVfwCTKotSj2xIMZ1uYhDYxKa+lNDLobvtWsGkJQQi246ePGNr
 1G8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ/isEfe54LWaJM38MFDfTzNHKKR1YX7dVJciEVsJ71Fqh+8Adrz900zUhDDhHyMncww9xYG1pqk4b@nongnu.org
X-Gm-Message-State: AOJu0YxZHKVYpju8RE/M+I7i6PEYfNkRphqxhioUba1HxHgdAcj1t3Uy
 B5gKvNlsXgYncePy8GgIGnnHeA4ZqyW72osvQIbZ8F48RR3esp5SXqpBiNaKHr2zA8nBo39pl0A
 LFJp6svDFNdaq3fMlR0/zMvGL3smsyhCgRy5kbruLuK3S2AZ4ZCyE
X-Gm-Gg: ASbGncsOYdKG+Yd6pXH7W1ke20F1hlNCE0DLFcH0RW2L/0vgGue7u7xd1mEkdFboaap
 2GDwgodSuI9nfckrU9YiVmpD97FYkpjbqwd9IaXNP60i/Lj/0k3GLyzN+ZOgwRR3yL1YK9VA8Hh
 uxnbhgpV3w9px0CykvDkMvT+C0XD8sGt2IaG3tDOUX7BLcq8QPcdshRakuFM6TpRyNfrXQTGyFp
 0ElJAfWZBYWII8xF5wrXroQk9SVCe7oMYmUK7MU2gr64vPWFWLFOqSRs+XeBNfl/1wQ16UTn9W5
 2eWiBqDPvdVhaNDbrmJpNLIqKvB0DaJSK5DW86HvB2Q=
X-Received: by 2002:a05:6000:430a:b0:390:f358:85db with SMTP id
 ffacd0b85a97d-39ea52155f0mr2487090f8f.30.1744383038550; 
 Fri, 11 Apr 2025 07:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH675Yr9GDJxHk8FVdldn1uw6Vet4HyOGdyEFKzpyf+ENSGXou6O+EhnGhoyv3usW8Nb0YGeg==
X-Received: by 2002:a05:6000:430a:b0:390:f358:85db with SMTP id
 ffacd0b85a97d-39ea52155f0mr2487073f8f.30.1744383038244; 
 Fri, 11 Apr 2025 07:50:38 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae979835sm2234234f8f.57.2025.04.11.07.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 07:50:37 -0700 (PDT)
Message-ID: <ed9239d8-987c-4117-a302-6219b3d57f52@redhat.com>
Date: Fri, 11 Apr 2025 16:50:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 20/24] Add -secure-boot on|off option in QEMU command
 line
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-21-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250408155527.123341-21-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/04/2025 17.55, Zhuoying Cai wrote:
> The `-secure-boot on|off` command line option is implemented
> to enable secure IPL.
> 
> By default, -secure-boot is set to false if not specified in
> the command line.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   qemu-options.hx |  8 ++++++++
>   system/vl.c     | 21 +++++++++++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b460c63490..02d2f4d513 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1262,6 +1262,14 @@ SRST
>       A colon may be used to delineate multiple paths.
>   ERST
>   
> +DEF("secure-boot", HAS_ARG, QEMU_OPTION_secure_boot,
> +    "-secure-boot on|off\n"
> +    "             enable/disable secure boot\n", QEMU_ARCH_S390X)
> +SRST
> +``-secure-boot on|off``
> +    Enable/disable secure boot. Default is off.
> +ERST

As with patch 1, please try to turn this into a machine option instead.

  Thanks,
   Thomas



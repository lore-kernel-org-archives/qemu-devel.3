Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FADCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64I2-0005Us-Th; Tue, 07 Oct 2025 05:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v64I2-0005UP-5C
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v64I0-0002ug-I6
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759830443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=19gi+9qB+yJilMywPzFl79bNvPomxA5cHIXFvhphP2k=;
 b=GQxWbFJl9XvwhOW3RDq7sRcNc+oXn3aKdG6ub2fltnb81tvLCbzWqhGnpZRBqSiPxRHlhn
 C2yOjoBYfY+9sTPQAUHUmHhXZiJl5W51f543F3WWMcPVwLIE6N3UmRk0mWs49AzxOOite4
 sRyWJYJ5jccaidVMdI8aEzvKwLDn9mc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-an3aQDRIM4WcVLgIzIyanA-1; Tue, 07 Oct 2025 05:47:21 -0400
X-MC-Unique: an3aQDRIM4WcVLgIzIyanA-1
X-Mimecast-MFC-AGG-ID: an3aQDRIM4WcVLgIzIyanA_1759830440
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f3787688b0so3196576f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 02:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759830440; x=1760435240;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=19gi+9qB+yJilMywPzFl79bNvPomxA5cHIXFvhphP2k=;
 b=r72b3q2h35If3Nf6a9J7/U6T4B9hCn8eGBN86urVe3mx0JHTOoDxf2zLT5x+OYrG7L
 fOU8R0vxIKT6z1Y5g1tm3ycLPQBY2P2CBqdy3mx09PbpltUHpTPx/syRbJW1V3AVBeqk
 MEVlFXKw7162AwR/npzoyfjiLHIiLXtuaYbovd7D4Et5++H4bhMlcYGT1n392rzIvxSz
 sjCESPLJwnRBd0mThKheqTvT/IoKF+il57qZYQXZLvLHn6p3Y30TL56ORn2yrFMsIUUh
 CYb4Egsc2/eOVYAKTfMrslZQ0Kls+gV6+lXjRK6Cy0Q0Htt+rCzZiryDXDMVFUgO5Zs9
 8AKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlX8QuJ8QkVqxzDDgN1HeWBHiPTOCGOLvAe3qIqHnAClkCEhmVbW3aWpvODUM9qYxjtVsSZ3jvvztB@nongnu.org
X-Gm-Message-State: AOJu0Yw+fV0GfDtT3FrfPIhcvhexcRJXcQUtv9NEIjbls9+f0nzlnUqR
 sdwA1b+1hH475X8Pa/mWMhDdOao38y67xyi2E1HYpHER7BeLe2iPCG4VA0P1UGeaY245oBhfV/r
 2lFH5a0vsXgFoXRpjZ7iGE+mM6u/HPhm1L/02GeeLdX5/pVqHJRFil1cU
X-Gm-Gg: ASbGncv/svKlYdHQrSM2EpbHnSC1QQz0YgUakun5m1WpJ58TT/+iJ5EXYpCcHMdhkW6
 MmQlFUXXbcp+jJqsVBjbF7BuXleWLf+AkOkRWSf2RVj4XEwl8bbM6583QS6nqy8xJZyFcMbsQ7T
 yq55/+RfWcOs3OwdHihQg4zgItTFkBUq0pm7AoFOQ32hbjS0SMsENwq21sJ9MHAgPBz+TQ//XVB
 kSsz8uBlskFh7piF12V04WMLtERyj1pAsFvMqktvAVKmxwWcohEKYahMBuyICk8KnrrKplYcWY8
 52ispFofWss6Jxd7Xx+ejt3S5RmYkGvmgu9z12ej4Hzl9yJ6LwUGUPa5k6U7MViu7YJT4DA=
X-Received: by 2002:a05:6000:2509:b0:3de:78c8:120e with SMTP id
 ffacd0b85a97d-42567136297mr8883794f8f.6.1759830440173; 
 Tue, 07 Oct 2025 02:47:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELyS5WGSTxEXv5m5nUI7f0sbYCWHfK+Wse22P1Oawa6ZLzi/NxP/lsJbeGghUX/t3vOqcr6g==
X-Received: by 2002:a05:6000:2509:b0:3de:78c8:120e with SMTP id
 ffacd0b85a97d-42567136297mr8883777f8f.6.1759830439703; 
 Tue, 07 Oct 2025 02:47:19 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e5fdsm200019325e9.6.2025.10.07.02.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 02:47:19 -0700 (PDT)
Message-ID: <45084e29-1d7d-4922-8bf3-25ead6236549@redhat.com>
Date: Tue, 7 Oct 2025 11:47:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/28] s390x/diag: Introduce DIAG 508 for secure IPL
 operations
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-11-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-11-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> From: Collin Walling <walling@linux.ibm.com>
> 
> In order to support secure IPL (aka secure boot) for the s390-ccw BIOS,
> a new s390 DIAGNOSE instruction is introduced to leverage QEMU for
> handling operations such as signature verification and certificate
> retrieval.
> 
> Currently, only subcode 0 is supported with this patch, which is used to
> query a bitmap of which subcodes are supported.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 18 ++++++++++++++++++
>   include/hw/s390x/ipl/diag508.h  | 15 +++++++++++++++
>   target/s390x/diag.c             | 27 +++++++++++++++++++++++++++
>   target/s390x/kvm/kvm.c          | 14 ++++++++++++++
>   target/s390x/s390x-internal.h   |  2 ++
>   target/s390x/tcg/misc_helper.c  |  7 +++++++
>   6 files changed, 83 insertions(+)
>   create mode 100644 include/hw/s390x/ipl/diag508.h
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index e28f0b40d7..0919425e9a 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -48,3 +48,21 @@ Subcode 2 - store verification certificates
>       storage specified in the VCB input length field.
>   
>       VCE contains various information of a VC from the CS.
> +
> +
> +Secure IPL Data Structures, Facilities, and Functions
> +=====================================================
> +
> +DIAGNOSE function code 'X'508' - KVM IPL extensions
> +---------------------------------------------------
> +
> +DIAGNOSE 'X'508' is reserved for KVM guest use in order to facilitate
> +communication of additional IPL operations that cannot be handled by userspace,
> +such as signature verification for secure IPL.
> +
> +If the function code specifies 0x508, KVM IPL extension functions are performed.
> +These functions are meant to provide extended functionality for s390 guest boot
> +that requires assistance from QEMU.
> +
> +Subcode 0 - query installed subcodes
> +    Returns a 64-bit mask indicating which subcodes are supported.

Technically, this works also without KVM, right? In that case, I'd maybe 
avoid the term "KVM" here, and just talk about "IPL extensions" and "guest", 
to avoid the confusion about whether this feature can be used with TCG, too, 
or not.

  Thomas



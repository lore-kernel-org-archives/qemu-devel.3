Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEE0C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFEHA-0000bV-Rs; Wed, 14 May 2025 11:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFE5u-0004Vb-9o
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFE5q-0001A0-AK
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747236743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9I2Ae++q3e7qQPkI8PqmjDyCOw60TogaMewg6s/InaQ=;
 b=d3ocRGH/MCZLLjnLx0kDGoo1Bf6fj0mNkjzk7dDIgnKl3iXYPuvLNMIJa8w0KdJffH4fLc
 bRbwm9rdbkHjJlOTo0ueLFkRZ3YqvaQBtUpjI+yg5ZYcN85fsmm0DrWGzkL5alt2ciOMbW
 UPplQqzQn6mbb1byy5X0a9vKvDJUvPY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-kCq2h72WON221GuQG30hPA-1; Wed, 14 May 2025 11:32:21 -0400
X-MC-Unique: kCq2h72WON221GuQG30hPA-1
X-Mimecast-MFC-AGG-ID: kCq2h72WON221GuQG30hPA_1747236741
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5fbb82101d4so6055409a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 08:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747236740; x=1747841540;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9I2Ae++q3e7qQPkI8PqmjDyCOw60TogaMewg6s/InaQ=;
 b=NgE+JgSY2t0IvUSsIMDeRU1UNZ8n5HDJoqrAjk7Dyi/uq0L5Od34Ic23IVHz1s33lf
 m39Kd8wDLrxOrvJvYh1bWQzlHB3yTvahkqXmn7AU0DR04NI4FPg9HA2/TMS53paQtWNu
 fPW8BAmxDQrXeANYN4vOIRWHjlRWClJtE+/VF9T92eLY5Yzey0JX4CsvxT6TzuSZsBrI
 DSQW2HEwNdoFhGmdAqY0QhyeDjyYn1B/kTtMMlsEQ5agAWqDF3lqbWEWqvSycANLl0gM
 jvqY24U92ooH3d//nncxazOvhIMy5d0KdkZAwUttNeDjrnXFOmNMrFXUJNMxaJt4vvyS
 iXNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEGd9hLecS3ZAmySWlofUIzaCDh1OKPoADUWM/PH0fERiu9EIVo1fQ+R6TGBYemsmArvSm/8txPQD2@nongnu.org
X-Gm-Message-State: AOJu0YzjFwtLq03EMsFLujvILizF+YB1dIKh77to4lReP2ybsfLuIj/l
 ThS5uAblMnxXUj0KIo2pNcmQQ59RhA+dm7PTTjrdCEDuUaedzBCeblHQcXQsf3DNkL3hk420gcv
 xbzO6rcgCmok+o8JJnPhj5jMvYcJrG+yzWE1haQgliLoI/Y4mnENs
X-Gm-Gg: ASbGnctwRz2KH9JPGPS12BXGmksIninL63bBQf821yHmoTnqKQ6cBosUXMT7DhloHCR
 HdfV7zMsREKUhScT9w/LP2K8zeH/OdiDtlEkhJJBYQGOq8wCQHjyFFNfINXt+2QOvH6whgZ0HSQ
 zwLYzqJ9oNQFf+jMrkeCFb5sEuGBSlyeT5b3AO16ZxBIOyTuYuE2GhwGLydSVze1JkGM0vlrMj7
 gMFu1h+xABb053SZc6O4Lr/biTwr0wQfyNcm2W72nbnH+7MsW+SZqXDBdAlaNVeFZYpY3xmN3pE
 XKkspG0aRKkGh9/tc4hAiKL7SJ6KEqAl+Nt8Mo7g460=
X-Received: by 2002:a05:6402:280d:b0:5fe:e393:808d with SMTP id
 4fb4d7f45d1cf-5ff988a53eemr2735249a12.9.1747236740440; 
 Wed, 14 May 2025 08:32:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+/UaopRWPHGkNV7lqxKvbbxchXXSflkAfneAZcv8FhxTa064+kJH8Y55KUzERglKdY78J6w==
X-Received: by 2002:a05:6402:280d:b0:5fe:e393:808d with SMTP id
 4fb4d7f45d1cf-5ff988a53eemr2735234a12.9.1747236739985; 
 Wed, 14 May 2025 08:32:19 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-129.web.vodafone.de.
 [109.42.48.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ff969f67c2sm1458948a12.60.2025.05.14.08.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 08:32:19 -0700 (PDT)
Message-ID: <aa0dd561-b217-480d-a993-e8ca50fb7f22@redhat.com>
Date: Wed, 14 May 2025 17:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/25] s390x/diag: Implement DIAG 320 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-7-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250508225042.313672-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09/05/2025 00.50, Zhuoying Cai wrote:
> DIAG 320 subcode 1 provides information needed to determine
> the amount of storage to store one or more certificates.
> 
> The subcode value is denoted by setting the left-most bit
> of an 8-byte field.
> 
> The verification-certificate-storage-size block (VCSSB) contains
> the output data when the operation completes successfully.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   include/hw/s390x/ipl/diag320.h | 25 ++++++++++++++++++++++
>   target/s390x/diag.c            | 38 +++++++++++++++++++++++++++++++++-
>   2 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index 713570545d..e91eb7238c 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -11,7 +11,32 @@
>   #define S390X_DIAG320_H
>   
>   #define DIAG_320_SUBC_QUERY_ISM     0
> +#define DIAG_320_SUBC_QUERY_VCSI    1
>   
>   #define DIAG_320_RC_OK              0x0001
> +#define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
> +
> +#define VCSSB_MAX_LEN   128
> +#define VCE_HEADER_LEN  128
> +#define VCB_HEADER_LEN  64
> +
> +#define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
> +
> +struct VCStorageSizeBlock {
> +    uint32_t length;
> +    uint8_t reserved0[3];
> +    uint8_t version;
> +    uint32_t reserved1[6];
> +    uint16_t total_vc_ct;
> +    uint16_t max_vc_ct;
> +    uint32_t reserved3[7];
> +    uint32_t max_vce_len;
> +    uint32_t reserved4[3];
> +    uint32_t max_single_vcb_len;
> +    uint32_t total_vcb_len;
> +    uint32_t reserved5[10];
> +} QEMU_PACKED;

Please try to avoid QEMU_PACKED as long as it is not really necessary. The 
compiler can create better code without it and we have less trouble on 
exotic host architectures that way.

Here, all members seem to have proper natural alignment, so you don't need 
it. You can use something like this to make sure that there is no unexpected 
padding in the structure:

QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != ...,
                           "size of VCStorageSizeBlock is wrong");

> +typedef struct VCStorageSizeBlock \
> +VCStorageSizeBlock;

That looks like it fits into one line.

>   #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 9d249831b3..0743f5ec0e 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -194,6 +194,7 @@ out:
>   void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   {
>       S390CPU *cpu = env_archcpu(env);
> +    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
>       uint64_t subcode = env->regs[r3];
>       uint64_t addr = env->regs[r1];
>       int rc;
> @@ -215,13 +216,48 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   
>       switch (subcode) {
>       case DIAG_320_SUBC_QUERY_ISM:
> -        uint64_t ism =  0;
> +        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI);
>   
>           if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
>               s390_cpu_virt_mem_handle_exc(cpu, ra);
>               return;
>           }
>   
> +        rc = DIAG_320_RC_OK;
> +        break;
> +    case DIAG_320_SUBC_QUERY_VCSI:
> +        VCStorageSizeBlock vcssb;
> +
> +        if (!diag_parm_addr_valid(addr, sizeof(VCStorageSizeBlock),
> +                                  true)) {
> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +            return;
> +        }
> +
> +        if (!qcs || !qcs->count) {
> +            vcssb.length = 4;

You missed the cpu_to_be32() here.

> +        } else {
> +            vcssb.length = cpu_to_be32(VCSSB_MAX_LEN);
> +            vcssb.version = 0;
> +            vcssb.total_vc_ct = cpu_to_be16(qcs->count);
> +            vcssb.max_vc_ct = cpu_to_be16(MAX_CERTIFICATES);
> +            vcssb.max_vce_len = cpu_to_be32(VCE_HEADER_LEN + qcs->max_cert_size);
> +            vcssb.max_single_vcb_len = cpu_to_be32(VCB_HEADER_LEN + VCE_HEADER_LEN +
> +                                                   qcs->max_cert_size);
> +            vcssb.total_vcb_len = cpu_to_be32(VCB_HEADER_LEN +
> +                                              qcs->count * VCE_HEADER_LEN +
> +                                              qcs->total_bytes);
> +        }
> +
> +        if (be32_to_cpu(vcssb.length) > 4 && be32_to_cpu(vcssb.length) < 128) {

How is this supposed to happen? There are only two hard-coded values for 
this field above?

> +            rc = DIAG_320_RC_INVAL_VCSSB_LEN;
> +            break;
> +        }
> +
> +        if (s390_cpu_virt_mem_write(cpu, addr, r1, &vcssb, sizeof(VCStorageSizeBlock))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
>           rc = DIAG_320_RC_OK;
>           break;
>       default:

  Thomas



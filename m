Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA599CD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmsJw-0002qC-Ax; Wed, 20 Mar 2024 05:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmsJt-0002ph-PQ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmsJs-0003WS-7n
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710927191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=th52bfC6LCFFNLFEwwaZwkFyfyLJ9ZK4d36Pw1IlIDU=;
 b=DxoopooNsEP1xJxFspnjDZ1AaDOalmmVVXl0UL91mBCJk54KI6fMOL9x7F1XRdQdBTEo+3
 16T6KVpbDdYtYl1wk0IEkxOfCA3iIoQAj18pCx1PbmfHlbvNW6WvcIdNSx3HH/AJ+drOi8
 Eac9Gy0W7E2ZTyFRSkbsx1a2JjAUCU4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-L7VlUCPZP4uN29QSjUF7wQ-1; Wed, 20 Mar 2024 05:33:08 -0400
X-MC-Unique: L7VlUCPZP4uN29QSjUF7wQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a46b82df33cso212253066b.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 02:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710927187; x=1711531987;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=th52bfC6LCFFNLFEwwaZwkFyfyLJ9ZK4d36Pw1IlIDU=;
 b=kQgE+M4cGNM6SyQKssFO7j3Z7FGiBqhl6EHY+9E8BpeWWkgXYxXKsbDu3ulTMZB6RO
 stTbQrkMiV/Hb5oroJO1WCPXLH1R/dbSJX6VQwEErILbuEmqjhFBjvN2SE6TMQDeFHP5
 dYOvECIW5AdiOoJFetVkNbs8+R0fOAP3Tg2Gk9yq/SAe4wTwyv6hXrvmeovtzAfJA3Xf
 ND3QWuK0ryuyxET5fFQ/11fZtwCItEQ6fA8xAQsgx095td77o/+uGvASg1c/cL8HuxyW
 xHjF7gSaPYNPf2W5BA8nIYZg7AtQTUnQCnb5bmPMaawfGNZeiwsz1JeQu1n3zl7OKJ1u
 kI6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn9VMCHVqiL93gJtSP9vlDuddbUBe4FCih0bCxT/CHt5ZmSbTFPxWhchxX+DcG39zvECw1vwir8RgjXOlob14e3HqiqaM=
X-Gm-Message-State: AOJu0Yxy0eOWMu/viZRJ8Pnybbp5UcOBe+n/WQdMy3MBlI3JSCS2w+YY
 TaxyukzJhOz+s7tUtqPjRkcXkQGWvDnqAuf2i+DD3/fOjQn79uQKv5KsuHww0DDMgGVg4ZhQfQY
 B/xZH2n8tyewNgoIEv+5PBY8qcImoHC58uhG+m0de2F9RWnqe8yWF
X-Received: by 2002:a17:906:2acf:b0:a46:efe6:40b with SMTP id
 m15-20020a1709062acf00b00a46efe6040bmr1151062eje.24.1710927187723; 
 Wed, 20 Mar 2024 02:33:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsyBkSiUii2DxnglBCUyZ7+j2fZ4op1TOtiUIDlLIm2EyyBwLSs22FP+e7Ip18OluO+/aIHQ==
X-Received: by 2002:a17:906:2acf:b0:a46:efe6:40b with SMTP id
 m15-20020a1709062acf00b00a46efe6040bmr1151048eje.24.1710927187312; 
 Wed, 20 Mar 2024 02:33:07 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 wt1-20020a170906ee8100b00a46bef6f920sm3294036ejb.102.2024.03.20.02.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 02:33:06 -0700 (PDT)
Message-ID: <8c0ac9cc-b180-48ca-9843-1866e873ce7d@redhat.com>
Date: Wed, 20 Mar 2024 10:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/49] target/i386: Add handling for KVM_X86_SNP_VM VM
 type
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-25-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240320083945.991426-25-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/20/24 09:39, Michael Roth wrote:
> An SNP VM requires VM type KVM_X86_SNP_VM to be passed to
> kvm_ioctl(KVM_CREATE_VM). Add it to the list of supported VM types, and
> return it appropriately via X86ConfidentialGuestClass->kvm_type().
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   target/i386/kvm/kvm.c |  1 +
>   target/i386/sev.c     | 10 ++++++++--
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e109648f26..59e9048e61 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -164,6 +164,7 @@ static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
>   
>   static const char *vm_type_name[] = {
>       [KVM_X86_DEFAULT_VM] = "default",
> +    [KVM_X86_SNP_VM] = "snp"
>   };
>   
>   bool kvm_is_vm_type_supported(int type)
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 2eb13ba639..61af312a11 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -853,14 +853,20 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
>   static int sev_kvm_type(X86ConfidentialGuest *cg)
>   {
>       SevCommonState *sev_common = SEV_COMMON(cg);
> -    SevGuestState *sev_guest = SEV_GUEST(sev_common);
>       int kvm_type;
>   
>       if (sev_common->kvm_type != -1) {
>           goto out;
>       }
>   
> -    kvm_type = (sev_guest->policy & SEV_POLICY_ES) ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
> +    if (sev_snp_enabled()) {
> +        kvm_type = KVM_X86_SNP_VM;
> +    } else if (sev_es_enabled()) {
> +        kvm_type = KVM_X86_SEV_ES_VM;
> +    } else {
> +        kvm_type = KVM_X86_SEV_VM;
> +    }

I don't really like this, the kvm_type method can be implemented 
separately in sev-guest and sev-snp-guest.

This is for two reasons:

1) it makes sev_kvm_type self-contained, instead of poking in 
current_machine via sev_*_enabled()

2) sev-snp-guest can just return KVM_X86_SNP_VM, relying on the "vm type 
supported" checks from common target/i386/kvm/kvm.c code.  Instead, 
sev-guest has to check kvm_is_vm_type_supported() in order to support 
the legacy ioctls (and that is why my patches didn't add the SEV/SEV-ES 
types to vm_type_name[], too).

Thanks,

Paolo

> +
>       if (kvm_is_vm_type_supported(kvm_type)) {
>           sev_common->kvm_type = kvm_type;
>       } else {



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B074FC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmC0N-0007cP-OP; Tue, 21 Jul 2026 11:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmC0I-0007VM-Ln
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wmC0F-0003gR-QP
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784646205;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AljakpZ1zPJEZ1/BQ+JkJtG/8jB+hyqekVs37VGAoBE=;
 b=MmAviGzM1LEHlQVRv5gmtDUs2X7Xmay7/SEwQOJpEEqJz59DMRX6U/igcW75m56I3rHEoy
 jURSWVdYrtKjdABkq/nchP2Iu3YML3kfjP9szwevTL/xQj5Q+iskp7Ztu4FHFKyIqTEOaK
 AjIM3rhEpXbZzoRIxarKABBcs/ER5eA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-jcVsntJwMzKjbLHC38FVsg-1; Tue, 21 Jul 2026 11:03:23 -0400
X-MC-Unique: jcVsntJwMzKjbLHC38FVsg-1
X-Mimecast-MFC-AGG-ID: jcVsntJwMzKjbLHC38FVsg_1784646203
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f5a972b0eso4449850f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784646202; x=1785251002;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AljakpZ1zPJEZ1/BQ+JkJtG/8jB+hyqekVs37VGAoBE=;
 b=l6nKhgeij/LxfSjQwBT5aPcgBVULZdt1aer+/WhJ/KFCWQTjwlDUpHl3JsvorphYxT
 s1VJaqD/ogmQHt7mOOvX/OHoPajOFpP7IV5A5B55lKQN77L4ucataCIadtB3/V37a6xg
 mOBEOoaauAGUou9j6KsyEOyk4OhIfOcEPRGpRTYvUvrU2xt14Kfp+4ORpYe/ULQLFGl0
 SKjdJeGBvV6IhT6CaELYOtGEwY98vW/szfj0rXSfRo5EhvCObfdikILUhPEZW7F6M5/S
 /7EDdTecHCp9bN6ijVwMVaKgqxDNt5r6pO0h8yMc56fOVf462JGUMD0SgUtWWpDD22R0
 JtGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqximMZq8eJ4OzYtLE+xyL4wycqneBViQ4Tz8Ycm4kdgutS8PIA+deh8IVz/BJjnNE0hZw57rkcCmfH@nongnu.org
X-Gm-Message-State: AOJu0Yz9ymbgnU3jYZ3yVtNgY3Xl2ZPH1OfAroGNveBzBF6Wr2fjeKT1
 EzfjcB3ciUBiIqs93AifcI5kR1yAPOW1Emm0FM6YWDGhzqCYhuUZ0xrUuvBi7sIJQM0WNDC/FyY
 FnjRXne1o7uTi6iF1fn4lgpYV88PLKRzrfw4b9hWzVmJHL4d0jMdl9uco
X-Gm-Gg: AR+sD11TEYVmXzUp7ardAIT1zXOMpqOkAMNlyxZPetTXK7NyFTq/oZIcaGh6RxThS6R
 vJ5e5BuQ2GY1qUtI3EJyjpQarJKRUoX6EomVDnNLEjz1oJc5vj0wC9IFd1Ln4mlRSZDRU/damgz
 ii29K10MR457UkWAQBOeSfhD6DsBNV/gZqrGfa0qEzDa6SvdeRbZghWjZN18cJL+e8sglGXGAv+
 G2NGYy01rzIjvgKAX+fg0Fqu4cfyKHJV0qHIPm3p7SJMk8wMrabFdHGHo2xcNbFYKFWFMMrqrKS
 86NYYwyZZkbA4WvqwxDX3YcGE2nfDQzyrRA0UVv0MxqInxcEy21GAskFDnPqwsDJWQ8pU+7pjb/
 Rm3/jdIMQkiwhhxbaIi1TJFEGeIg+B6UYEVx2y1+8DPiSt2uF
X-Received: by 2002:a05:6000:26c5:b0:47f:6f89:7dae with SMTP id
 ffacd0b85a97d-47f6f8982e7mr16829478f8f.6.1784646202538; 
 Tue, 21 Jul 2026 08:03:22 -0700 (PDT)
X-Received: by 2002:a05:6000:26c5:b0:47f:6f89:7dae with SMTP id
 ffacd0b85a97d-47f6f8982e7mr16829417f8f.6.1784646202167; 
 Tue, 21 Jul 2026 08:03:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e519f4sm38082413f8f.14.2026.07.21.08.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 08:03:21 -0700 (PDT)
Message-ID: <da8487e6-2253-43ef-967e-b4d3daf3808b@redhat.com>
Date: Tue, 21 Jul 2026 17:03:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/19] target/arm/kvm: enable writable
 implementation ID registers
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 prerna.saxena@nutanix.com
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-6-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260716213858.609699-6-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 7/16/26 11:38 PM, Khushit Shah wrote:
> Enable KVM_CAP_ARM_WRITABLE_IMP_ID_REGS if the host kernel supports it.
> This allows QEMU to write implementation-defined ID registers (MIDR,
> REVIDR) so that named CPU models can present the correct values to the
> guest instead of inheriting the host's identity.
This is a subset of 
[RFC PATCH RESEND 0/4] hw/arm/virt: Add support for Target
Implementation CPUs
https://lore.kernel.org/all/20250801074730.28329-1-shameerkolothum@gmail.com/

and especially 1/4

Thanks

Eric
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/kvm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 76583db3f0..63b3727e05 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -741,6 +741,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
>  
> +    if (kvm_check_extension(s, KVM_CAP_ARM_WRITABLE_IMP_ID_REGS)) {
> +        if (kvm_vm_enable_cap(s, KVM_CAP_ARM_WRITABLE_IMP_ID_REGS, 0)) {
> +            error_report("Failed to enable "
> +                         "KVM_CAP_ARM_WRITABLE_IMP_ID_REGS cap");
> +        }
> +    }
> +
>      if (s->kvm_eager_split_size) {
>          uint32_t sizes;
>  



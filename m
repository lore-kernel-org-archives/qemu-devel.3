Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD746C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 05:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpJhA-0008Hp-8n; Thu, 30 Jul 2026 01:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1wpJWw-0006Px-UV; Thu, 30 Jul 2026 01:42:07 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com ([139.138.36.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <enju.kohei@fujitsu.com>)
 id 1wpJWu-0003Bg-JW; Thu, 30 Jul 2026 01:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1785390124; x=1816926124;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gtNqmtlz11YTaHAOeuf6yPhikX581JactO7gbwX6u/Q=;
 b=QuIiehdsf3m6hGDnnSsyadm6PKenJOjgOTstIQUrh21Ldm9QWhd4JYXV
 kW/k0UaEab5KBGRzZcw6U4cO48EwLzVd7R8eojl8nux3RcLxUbTkJOkKb
 et/FPFDi5mTiwCbvEF+75+Y1cyEYthCkNWYO57gy5UqToq0E+AysHqNAB
 ku2Q97TyWxXa9sFVc7yLqr0vR+728vZoy++ymP9FwL6am8mlK3pWyKezE
 ah2kdSisdClM4gH3u04zu4YKCh2sr316jaWX9kVoGyu8JhZ+HMnO+31q8
 RcPYpvMxPYrGxIukaiFR6v9XUmzy9yqdKb0s0q0cDk1Bvm94g7kOxPmgh Q==;
X-CSE-ConnectionGUID: Nc4f42AQQteZL55DotcPUQ==
X-CSE-MsgGUID: avkgNO4/TVK7QH8i6Cljqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="236534164"
X-IronPort-AV: E=Sophos;i="6.25,193,1779116400"; d="scan'208";a="236534164"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 14:42:00 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 4A280C00549;
 Thu, 30 Jul 2026 05:42:00 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id F0697C07171;
 Thu, 30 Jul 2026 05:41:59 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.194.125])
 by az2nlsmom3.fujitsu.com (Postfix) with SMTP id 7009E100151C;
 Thu, 30 Jul 2026 05:41:54 +0000 (UTC)
Date: Thu, 30 Jul 2026 14:41:46 +0900
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com, 
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, 
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
 lorenzo.pieralisi@linaro.org, gshan@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v2 01/24] linux-headers: Add RME related definitions
Message-ID: <amrhioS_O_0ztjb_@FCCLS0092175.localdomain>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
 <20260728192630.240375-2-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728192630.240375-2-mathieu.poirier@linaro.org>
Received-SPF: pass client-ip=139.138.36.223;
 envelope-from=enju.kohei@fujitsu.com; helo=esa9.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 30 Jul 2026 01:52:28 -0400
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
Reply-to:  Kohei Enju <enju.kohei@fujitsu.com>
From:  Kohei Enju via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 07/28 13:26, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> This is a temporary patch intended for testing purposes only. It provides
> definitions related to supporting Realms by the QEMU-VMM.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  linux-headers/asm-arm64/kvm.h |  9 +++++++++
>  linux-headers/linux/kvm.h     | 10 +++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> index 6aefe7973814..4c08631ec7d2 100644
> --- a/linux-headers/asm-arm64/kvm.h
> +++ b/linux-headers/asm-arm64/kvm.h
> @@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
>  	__u64 reserved;
>  };
>  
> +#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
> +struct kvm_arm_rmi_populate {
> +	__u64 base;
> +	__u64 size;
> +	__u64 source_uaddr;
> +	__u32 flags;
> +	__u32 reserved;
> +};
> +
>  #define KVM_ARM_TAGS_TO_GUEST		0
>  #define KVM_ARM_TAGS_FROM_GUEST		1
>  
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index dd52e2a65bfd..cdd5ad11f85a 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -689,14 +689,19 @@ struct kvm_enable_cap {
>   * address size for the VM. Bits[7-0] are reserved for the guest
>   * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>   * value 0 implies the default IPA size, 40bits.
> + *
> + * Bits[30-31] are reserved for the VM type
>   */
>  #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
>  #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
>  	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
>  
> +#define KVM_VM_TYPE_ARM_NORMAL		0
> +#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
>  #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
>  #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
> -					 KVM_VM_TYPE_ARM_PROTECTED)
> +					 KVM_VM_TYPE_ARM_PROTECTED | \
> +					 KVM_VM_TYPE_ARM_REALM)
>  
>  /*
>   * ioctls for /dev/kvm fds:
> @@ -719,6 +724,8 @@ struct kvm_enable_cap {
>  #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
>  #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
>  
> +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
> +
>  /*
>   * Extension capability list.
>   */
> @@ -986,6 +993,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
>  #define KVM_CAP_S390_HPAGE_2G 249
> +#define KVM_CAP_ARM_RMI 250

Not a big deal, but a note for anyone testing this series:

Use Linaro's Linux kernel tree, as mentioned in the cover letter:
https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v2?ref_type=heads

Alternetively, if you're using Arm's tree or other trees with Steven
Price's v14 series as I am:

You'll need to adjust the definition of KVM_CAP_ARM_RMI, since it uses a
differenct capability number.

>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> -- 
> 2.43.0
> 


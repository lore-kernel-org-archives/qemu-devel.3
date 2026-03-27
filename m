Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E6F10F284C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69k8-000154-C4; Fri, 27 Mar 2026 12:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w69jx-00014U-Dc
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w69ju-0007ub-8k
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774627728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wE4eljjJqYpnPhfBQtoAdiC6tqCnaHtnHp906Z8hIJo=;
 b=QSyaVmNhibriUC2QXX+A4lNsuJh3ptAlpSbDwuddjl9KFtT3il+RtT2D4txs3fBZDa3WUb
 gab7ioAkvX6CAsSSDTdnBtykUIb2k4Z08JF6cHQlJj4cKrvyou2SyL4xIC816zRABQqdgj
 1OZ3vJyq5G5ixXrNGWNlXxNmFs0Wd3Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-aiVkFHVaNN6GE14KwTjxxQ-1; Fri,
 27 Mar 2026 12:08:45 -0400
X-MC-Unique: aiVkFHVaNN6GE14KwTjxxQ-1
X-Mimecast-MFC-AGG-ID: aiVkFHVaNN6GE14KwTjxxQ_1774627724
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00CE719560B8; Fri, 27 Mar 2026 16:08:44 +0000 (UTC)
Received: from [10.45.224.71] (unknown [10.45.224.71])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CF1F19560B1; Fri, 27 Mar 2026 16:08:36 +0000 (UTC)
Message-ID: <c0ce6be5-3a03-4020-9ca3-51d178dfa1ed@redhat.com>
Date: Fri, 27 Mar 2026 17:08:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] accel/mshv: disable la57 (5lvl paging)
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
 <20260323115711.353793-10-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260323115711.353793-10-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/23/26 12:57, Magnus Kulke wrote:
> This change disable la57 paging on the mshv hypervisor on both the
> mshv processor feature bitmap and mask the cpuid feature leaf to the
> guest.
> 
> Since the removal of hypervisor-assisted gva=>gpa translation in
> 1c85a4a3d7 we have seen MMIO errors in guests on la57-enabled hw. We
> will have to investigate and test this further.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Is this still true with the latest target/i386/emulate changes from 11.0?

Paolo

> ---
>   accel/mshv/mshv-all.c       |  7 +++++++
>   include/system/mshv_int.h   |  2 ++
>   target/i386/mshv/mshv-cpu.c | 12 ++++++++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index c50641f174..a557623531 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -142,6 +142,8 @@ static int create_partition(int mshv_fd, int *vm_fd)
>       int ret;
>       uint64_t pt_flags, host_proc_features;
>       union hv_partition_processor_xsave_features disabled_xsave_features;
> +    union hv_partition_processor_features disabled_partition_features = {0};
> +
>       struct mshv_create_partition_v2 args = {0};
>   
>       QEMU_BUILD_BUG_ON(MSHV_NUM_CPU_FEATURES_BANKS != 2);
> @@ -177,6 +179,11 @@ static int create_partition(int mshv_fd, int *vm_fd)
>       }
>       args.pt_cpu_fbanks[1] = ~host_proc_features;
>   
> +    /* arch-specific features we disable regardless of host support */
> +    mshv_arch_disable_partition_proc_features(&disabled_partition_features);
> +    args.pt_cpu_fbanks[0] |= disabled_partition_features.as_uint64[0];
> +    args.pt_cpu_fbanks[1] |= disabled_partition_features.as_uint64[1];
> +
>       /* populate args structure */
>       args.pt_flags = pt_flags;
>       args.pt_isolation = MSHV_PT_ISOLATION_NONE;
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 35386c422f..ca156cdf4b 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -94,6 +94,8 @@ void mshv_arch_init_vcpu(CPUState *cpu);
>   void mshv_arch_destroy_vcpu(CPUState *cpu);
>   void mshv_arch_amend_proc_features(
>       union hv_partition_synthetic_processor_features *features);
> +void mshv_arch_disable_partition_proc_features(
> +     union hv_partition_processor_features *disabled_features);
>   int mshv_arch_post_init_vm(int vm_fd);
>   
>   typedef struct mshv_root_hvcall mshv_root_hvcall;
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 2c66a52709..433f7a4069 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1111,6 +1111,12 @@ void mshv_arch_amend_proc_features(
>       features->access_guest_idle_reg = 1;
>   }
>   
> +void mshv_arch_disable_partition_proc_features(
> +     union hv_partition_processor_features *disabled_features)
> +{
> +    disabled_features->la57_support = 1;
> +}
> +
>   static int set_memory_info(const struct hyperv_message *msg,
>                              struct hv_x64_memory_intercept_message *info)
>   {
> @@ -1677,6 +1683,12 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
>        */
>       if (func == 0x07 && idx == 0 && reg == R_ECX) {
>           ret &= ~CPUID_7_0_ECX_CET_SHSTK;
> +        /*
> +         * LA57 (5-level paging) causes incorrect GVA=>GPA translations
> +         * in the instruction decoder/emulator. Disable until page table
> +         * walk in x86_mmu.c works w/ 5-level paging.
> +         */
> +        ret &= ~CPUID_7_0_ECX_LA57;
>       }
>       if (func == 0x07 && idx == 0 && reg == R_EDX) {
>           ret &= ~CPUID_7_0_EDX_CET_IBT;



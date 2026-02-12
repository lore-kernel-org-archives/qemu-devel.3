Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D57EE368D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXGn-000861-JC; Thu, 12 Feb 2026 09:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1vqWoI-00017w-0f
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 08:32:46 -0500
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1vqWoF-0006N5-Ps
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 08:32:45 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1770903149; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kVbsIVKBrSvQDXeVUFviIyfyqFgaZOnDV5hlbyG/962GzJzEDmsVuQaCDPonYRBjCn/1Qq9p7AHXaygvkPbA+yzXnRxJeBK88lMPdp+YJUHBbbzUDpBk46hiBaZ5EJc/Ai82Oe0/N1QgB2OnLuEolGYgIiSHGif69BZjoXbpJBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770903149;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ckyJe/NvYYAshLX7GmYAIzxhlYpz0Q4HBnXyVw/LBHw=; 
 b=Mc+K0w09snXE2Tn6DDceXDJo9LhWwzJExMII56pBa4qaNmvXKZLnyV+vlMO4Dw4MgB3nWmgk4iG5XjDDs5HOzZU1zGT+s4m6lwRDLH4VF3/51bUAgRSrK0vuOXL8Z02tR8fuTocF5chUIusa9m5TUajg/bTzOC89ymIyq5DSsro=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770903149; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=ckyJe/NvYYAshLX7GmYAIzxhlYpz0Q4HBnXyVw/LBHw=;
 b=NKoCiVE17fw1A7fQ+6RJ1+3jVUz6rtiWlEtSuSfGZG+Xmg1GufAmHRaDS7Dx36dI
 mp2+wmjZCxzPMVjMeZEozQlQXv1KtJaGTUY/fLflkiqS5mLf7Rd6/l6lAlG0Xl83jz5
 LE/8h1p3w4gg21Nnw5Kg864SGcJMfDoOXo7kiKuA=
Received: by mx.zohomail.com with SMTPS id 1770903146499721.7335443435236;
 Thu, 12 Feb 2026 05:32:26 -0800 (PST)
Date: Thu, 12 Feb 2026 13:32:22 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH 03/10] accel/mshv: use mshv_create_partition_v2 payload
Message-ID: <aY3WZg1JedxHtze2@anirudh-surface.localdomain>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-4-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211155410.203883-4-magnuskulke@linux.microsoft.com>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Feb 2026 09:02:09 -0500
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

On Wed, Feb 11, 2026 at 04:54:03PM +0100, Magnus Kulke wrote:
> When using the extended request format we can instruct the hypervisor to
> provision enough space for requested XSAVE features. This is required
> for supporting QEMU models provided via the -cpu flag properly.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c          |  35 +++++--
>  include/hw/hyperv/hvgdk_mini.h |   2 +
>  include/hw/hyperv/hvhdk.h      | 185 +++++++++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index bed0fa298e..8446f7128a 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -112,19 +112,38 @@ static int resume_vm(int vm_fd)
>  
>  static int create_partition(int mshv_fd, int *vm_fd)
>  {
> -    int ret;
> -    struct mshv_create_partition args = {0};
> +    int ret, i;
> +    uint64_t pt_flags;
> +    union hv_partition_processor_xsave_features disabled_xsave_features;
> +    union hv_partition_processor_features disabled_processor_features;
> +    struct mshv_create_partition_v2 args = {0};
>  
>      /* Initialize pt_flags with the desired features */
> -    uint64_t pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
> -                        (1ULL << MSHV_PT_BIT_X2APIC) |
> -                        (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES);
> +    pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
> +               (1ULL << MSHV_PT_BIT_X2APIC) |
> +               (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES) |
> +               (1ULL << MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES);
>  
> -    /* Set default isolation type */
> -    uint64_t pt_isolation = MSHV_PT_ISOLATION_NONE;
> +    /* enable all */
> +    disabled_xsave_features.as_uint64 = 0;
>  
> +    /* Enable all proc features by default */

Instead of enabling all features by default, we could query which
features are supported by the hypervisor on this host and enable only
those.

To query supported features get the HvPartitionPropertyProcessorFeatures
property via HvCallGetPartitionProperty (with HV_PARTITION_ID_SELF).

I think this would be more robust. This is what Cloud Hypervisor (well,
technically, the mshv crate) does.

Thanks,
Anirudh.

> +    for (i = 0; i < MSHV_NUM_CPU_FEATURES_BANKS; i++) {
> +        disabled_processor_features.as_uint64[i] = 0;
> +    }
> +    disabled_processor_features.reserved_bank0 = 1;
> +    for (i = 0; i < MSHV_NUM_CPU_FEATURES_BANKS; i++) {
> +        disabled_processor_features.as_uint64[i] = 0;
> +    }
> +
> +    /* populate args structure */
>      args.pt_flags = pt_flags;
> -    args.pt_isolation = pt_isolation;
> +    args.pt_isolation = MSHV_PT_ISOLATION_NONE;
> +    args.pt_disabled_xsave = disabled_xsave_features.as_uint64;
> +    args.pt_num_cpu_fbanks = MSHV_NUM_CPU_FEATURES_BANKS;
> +    for (i = 0; i < MSHV_NUM_CPU_FEATURES_BANKS; i++) {
> +        args.pt_cpu_fbanks[i] = disabled_processor_features.as_uint64[i];
> +    }
>  
>      ret = ioctl(mshv_fd, MSHV_CREATE_PARTITION, &args);
>      if (ret < 0) {
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> index 7d7b2e9b36..a8d4b2b2b1 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -456,6 +456,8 @@ typedef struct hv_input_set_vp_registers {
>      struct hv_register_assoc elements[];
>  } QEMU_PACKED hv_input_set_vp_registers;
>  
> +#define MSHV_VP_MAX_REGISTERS   128
> +
>  union hv_interrupt_control {
>      uint64_t as_uint64;
>      struct {
> diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
> index bf2f8cbc27..83f12a8781 100644
> --- a/include/hw/hyperv/hvhdk.h
> +++ b/include/hw/hyperv/hvhdk.h
> @@ -163,6 +163,191 @@ union hv_partition_synthetic_processor_features {
>      };
>  };
>  
> +union hv_partition_processor_xsave_features {
> +    struct {
> +        uint64_t xsave_support:1;
> +        uint64_t xsaveopt_support:1;
> +        uint64_t avx_support:1;
> +        uint64_t avx2_support:1;
> +        uint64_t fma_support:1;
> +        uint64_t mpx_support:1;
> +        uint64_t avx512_support:1;
> +        uint64_t avx512_dq_support:1;
> +        uint64_t avx512_cd_support:1;
> +        uint64_t avx512_bw_support:1;
> +        uint64_t avx512_vl_support:1;
> +        uint64_t xsave_comp_support:1;
> +        uint64_t xsave_supervisor_support:1;
> +        uint64_t xcr1_support:1;
> +        uint64_t avx512_bitalg_support:1;
> +        uint64_t avx512_i_fma_support:1;
> +        uint64_t avx512_v_bmi_support:1;
> +        uint64_t avx512_v_bmi2_support:1;
> +        uint64_t avx512_vnni_support:1;
> +        uint64_t gfni_support:1;
> +        uint64_t vaes_support:1;
> +        uint64_t avx512_v_popcntdq_support:1;
> +        uint64_t vpclmulqdq_support:1;
> +        uint64_t avx512_bf16_support:1;
> +        uint64_t avx512_vp2_intersect_support:1;
> +        uint64_t avx512_fp16_support:1;
> +        uint64_t xfd_support:1;
> +        uint64_t amx_tile_support:1;
> +        uint64_t amx_bf16_support:1;
> +        uint64_t amx_int8_support:1;
> +        uint64_t avx_vnni_support:1;
> +        uint64_t avx_ifma_support:1;
> +        uint64_t avx_ne_convert_support:1;
> +        uint64_t avx_vnni_int8_support:1;
> +        uint64_t avx_vnni_int16_support:1;
> +        uint64_t avx10_1_256_support:1;
> +        uint64_t avx10_1_512_support:1;
> +        uint64_t amx_fp16_support:1;
> +        uint64_t reserved1:26;
> +    };
> +    uint64_t as_uint64;
> +};
> +
> +#define HV_PARTITION_PROCESSOR_FEATURES_BANKS 2
> +#define HV_PARTITION_PROCESSOR_FEATURES_RESERVEDBANK1_BITFIELD_COUNT 4
> +
> +
> +union hv_partition_processor_features {
> +    uint64_t as_uint64[HV_PARTITION_PROCESSOR_FEATURES_BANKS];
> +    struct {
> +        uint64_t sse3_support:1;
> +        uint64_t lahf_sahf_support:1;
> +        uint64_t ssse3_support:1;
> +        uint64_t sse4_1_support:1;
> +        uint64_t sse4_2_support:1;
> +        uint64_t sse4a_support:1;
> +        uint64_t xop_support:1;
> +        uint64_t pop_cnt_support:1;
> +        uint64_t cmpxchg16b_support:1;
> +        uint64_t altmovcr8_support:1;
> +        uint64_t lzcnt_support:1;
> +        uint64_t mis_align_sse_support:1;
> +        uint64_t mmx_ext_support:1;
> +        uint64_t amd3dnow_support:1;
> +        uint64_t extended_amd3dnow_support:1;
> +        uint64_t page_1gb_support:1;
> +        uint64_t aes_support:1;
> +        uint64_t pclmulqdq_support:1;
> +        uint64_t pcid_support:1;
> +        uint64_t fma4_support:1;
> +        uint64_t f16c_support:1;
> +        uint64_t rd_rand_support:1;
> +        uint64_t rd_wr_fs_gs_support:1;
> +        uint64_t smep_support:1;
> +        uint64_t enhanced_fast_string_support:1;
> +        uint64_t bmi1_support:1;
> +        uint64_t bmi2_support:1;
> +        uint64_t hle_support_deprecated:1;
> +        uint64_t rtm_support_deprecated:1;
> +        uint64_t movbe_support:1;
> +        uint64_t npiep1_support:1;
> +        uint64_t dep_x87_fpu_save_support:1;
> +        uint64_t rd_seed_support:1;
> +        uint64_t adx_support:1;
> +        uint64_t intel_prefetch_support:1;
> +        uint64_t smap_support:1;
> +        uint64_t hle_support:1;
> +        uint64_t rtm_support:1;
> +        uint64_t rdtscp_support:1;
> +        uint64_t clflushopt_support:1;
> +        uint64_t clwb_support:1;
> +        uint64_t sha_support:1;
> +        uint64_t x87_pointers_saved_support:1;
> +        uint64_t invpcid_support:1;
> +        uint64_t ibrs_support:1;
> +        uint64_t stibp_support:1;
> +        uint64_t ibpb_support:1;
> +        uint64_t unrestricted_guest_support:1;
> +        uint64_t mdd_support:1;
> +        uint64_t fast_short_rep_mov_support:1;
> +        uint64_t l1dcache_flush_support:1;
> +        uint64_t rdcl_no_support:1;
> +        uint64_t ibrs_all_support:1;
> +        uint64_t skip_l1df_support:1;
> +        uint64_t ssb_no_support:1;
> +        uint64_t rsb_a_no_support:1;
> +        uint64_t virt_spec_ctrl_support:1;
> +        uint64_t rd_pid_support:1;
> +        uint64_t umip_support:1;
> +        uint64_t mbs_no_support:1;
> +        uint64_t mb_clear_support:1;
> +        uint64_t taa_no_support:1;
> +        uint64_t tsx_ctrl_support:1;
> +        uint64_t reserved_bank0:1;
> +
> +        /* N.B. Begin bank 1 processor features. */
> +        uint64_t a_count_m_count_support:1;
> +        uint64_t tsc_invariant_support:1;
> +        uint64_t cl_zero_support:1;
> +        uint64_t rdpru_support:1;
> +        uint64_t la57_support:1;
> +        uint64_t mbec_support:1;
> +        uint64_t nested_virt_support:1;
> +        uint64_t psfd_support:1;
> +        uint64_t cet_ss_support:1;
> +        uint64_t cet_ibt_support:1;
> +        uint64_t vmx_exception_inject_support:1;
> +        uint64_t enqcmd_support:1;
> +        uint64_t umwait_tpause_support:1;
> +        uint64_t movdiri_support:1;
> +        uint64_t movdir64b_support:1;
> +        uint64_t cldemote_support:1;
> +        uint64_t serialize_support:1;
> +        uint64_t tsc_deadline_tmr_support:1;
> +        uint64_t tsc_adjust_support:1;
> +        uint64_t fzl_rep_movsb:1;
> +        uint64_t fs_rep_stosb:1;
> +        uint64_t fs_rep_cmpsb:1;
> +        uint64_t tsx_ld_trk_support:1;
> +        uint64_t vmx_ins_outs_exit_info_support:1;
> +        uint64_t hlat_support:1;
> +        uint64_t sbdr_ssdp_no_support:1;
> +        uint64_t fbsdp_no_support:1;
> +        uint64_t psdp_no_support:1;
> +        uint64_t fb_clear_support:1;
> +        uint64_t btc_no_support:1;
> +        uint64_t ibpb_rsb_flush_support:1;
> +        uint64_t stibp_always_on_support:1;
> +        uint64_t perf_global_ctrl_support:1;
> +        uint64_t npt_execute_only_support:1;
> +        uint64_t npt_ad_flags_support:1;
> +        uint64_t npt1_gb_page_support:1;
> +        uint64_t amd_processor_topology_node_id_support:1;
> +        uint64_t local_machine_check_support:1;
> +        uint64_t extended_topology_leaf_fp256_amd_support:1;
> +        uint64_t gds_no_support:1;
> +        uint64_t cmpccxadd_support:1;
> +        uint64_t tsc_aux_virtualization_support:1;
> +        uint64_t rmp_query_support:1;
> +        uint64_t bhi_no_support:1;
> +        uint64_t bhi_dis_support:1;
> +        uint64_t prefetch_i_support:1;
> +        uint64_t sha512_support:1;
> +        uint64_t mitigation_ctrl_support:1;
> +        uint64_t rfds_no_support:1;
> +        uint64_t rfds_clear_support:1;
> +        uint64_t sm3_support:1;
> +        uint64_t sm4_support:1;
> +        uint64_t secure_avic_support:1;
> +        uint64_t guest_intercept_ctrl_support:1;
> +        uint64_t sbpb_supported:1;
> +        uint64_t ibpb_br_type_supported:1;
> +        uint64_t srso_no_supported:1;
> +        uint64_t srso_user_kernel_no_supported:1;
> +        uint64_t vrew_clear_supported:1;
> +        uint64_t tsa_l1_no_supported:1;
> +        uint64_t tsa_sq_no_supported:1;
> +        uint64_t lass_support:1;
> +        uint64_t idle_hlt_intercept_support:1;
> +        uint64_t msr_list_support:1;
> +    };
> +};
> +
>  enum hv_translate_gva_result_code {
>      HV_TRANSLATE_GVA_SUCCESS                    = 0,
>  
> -- 
> 2.34.1
> 
> 


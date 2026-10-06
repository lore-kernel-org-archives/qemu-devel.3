Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC5CCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMKd-0005v6-Ix; Wed, 07 Oct 2026 03:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEGec-0005h5-B5; Tue, 06 Oct 2026 21:41:34 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEGeB-0000is-VN; Tue, 06 Oct 2026 21:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=njGK9zBHI4u311p4O5Evxf6MG7bRo0x1PCKcPxGZfdY=; b=mXMiSRlz4e2T4Ch
 0fRXGSKbN0MZaYV23vzlO4Im23LJVAL3/osGKZl2Fj9f1/HfJ7/uAmeZ+MqZTuEeJ2UFgqXI96z62
 igjlBb1bv1QezS1JZ6HiCpoJkLYDvX1E7/QLzwTjBTjYNdVJxQzoYS1QxRDoVAoeN4uxj2hxzLRMs
 sY=;
Date: Wed, 7 Oct 2026 01:15:14 +0200
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
Subject: Re: [PATCH 07/18] target/riscv: Runtime register MAX and BARE CPUs
Message-ID: <asUMlHlLI7j5MTUf@hive.localdomain>
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-7-ea69b07afd31@rev.ng>
 <CAE2XoE_ag1RR_JFwgcg+9zPed+qpO2skf7W1_kiqvwB=Vf9aAQ@mail.gmail.com>
 <f8f27bc3-83ce-4ccf-ae38-a43188b2ebc5@oss.qualcomm.com>
 <ar_AzEWpF9XDGNdg@hive.localdomain>
 <CAE2XoE_vsVDXH2qggECnqHC8dMpo7zyTTg9w64uvjnPeXE9y6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE_vsVDXH2qggECnqHC8dMpo7zyTTg9w64uvjnPeXE9y6A@mail.gmail.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 02/10/26, Yonggang Luo wrote:
> target/riscv: resolve target-dependent CPU definition fields
> 
> The class-base initializer later reads def->misa_mxl_max and passes
> def->cfg to riscv_cpu_cfg_merge(), which merges max_satp_mode. Resolve
> both chooser results in a mutable copy so those steps use the selected
> values without modifying the const TypeInfo class data.
> 
> 
> defer riscv_cpu_validate_misa_mxl is not enough, mainly
> def->misa_mxl_max is accessed in
> riscv_cpu_class_base_init, for exactly match previous behavior, add
> two callback for each value

Right, we would have to move more stuff to instance init which isn't the
best idea.  Personally I'm still not keen on adding more callbacks to
initialize two fields for two cpus, surely this is solvable with the
current machinery.  I'll submit a v2 and try defining two tables for
MAX/BARE instead, similar to ARM.

> 
> On Fri, Oct 2, 2026 at 11:36 PM Anton Johansson <anjo@rev.ng> wrote:
> >
> > On 02/10/26, Pierrick Bouvier wrote:
> > > On 10/1/2026 9:28 AM, Yonggang Luo wrote:
> > > > On Thu, Oct 1, 2026 at 11:55 PM Anton Johansson via qemu development
> > > > <qemu-devel@nongnu.org> wrote:
> > > >>
> > > >> Moves initialization of satp and mxl fields to a class initialization
> > > >> function that checks target_riscv64().
> > > >>
> > > >> Note: I'm aware the current iteration of this patch is rather hacky, I
> > > >> don't like the introduction of runtime_misa_mxl_max, but I'm keeping
> > > >> this in to get the series out there and collect feedback.
> > > >>
> > > >> Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > >> ---
> > > >>  target/riscv/cpu.h |  1 +
> > > >>  target/riscv/cpu.c | 90 +++++++++++++++++++++++++++++++++++-------------------
> > > >>  2 files changed, 59 insertions(+), 32 deletions(-)
> > > >>
> > > >
> > > > This patch is how I handle these, just for reference, not a review.
> > >
> > > Yonggang approach looks cleaner, I would favor this one.
> >
> > I'm personally not a huge fan, it still feels rather hacky. Why add a
> > completely new RISCVCPUDef::target_init just to make sure fields are
> > initialized before riscv_cpu_validate_misa_mxl()? Wouldn't moving the
> > check to a later point, maybe .instance_init, be better? Then for
> > riscv_cpu_init() we get
> >
> >   riscv_cpu_validate_misa_mxl(mcc);
> >   env->misa_mxl = mcc->def->misa_mxl_max;
> >
> > misa_mxl_max would be verified only during instance rather than
> > class initialization, which seems like a decent tradeoff for a simpler
> > solution.
> >
> > --
> > Anton Johansson
> > rev.ng Labs Srl.
> 
> 
> 
> -- 
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo

> From 31138892fe5cf878da9818cf93535ce10b125cb0 Mon Sep 17 00:00:00 2001
> From: Yonggang Luo <luoyonggang@gmail.com>
> Date: Sat, 3 Oct 2026 01:54:52 +0800
> Subject: [PATCH] target/riscv: resolve target-dependent CPU definition fields
> 
> The class-base initializer later reads def->misa_mxl_max and passes
> def->cfg to riscv_cpu_cfg_merge(), which merges max_satp_mode. Resolve
> both chooser results in a mutable copy so those steps use the selected
> values without modifying the const TypeInfo class data.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  target/riscv/cpu.c | 40 +++++++++++++++++++++++++++-------------
>  target/riscv/cpu.h |  2 ++
>  2 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c6f1739075..754f158250 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3092,6 +3092,8 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>  
>      if (pcc->def) {
>          mcc->def = g_memdup2(pcc->def, sizeof(*pcc->def));
> +        mcc->def->max_satp_mode_choose = NULL;
> +        mcc->def->misa_mxl_max_choose = NULL;
>      } else {
>          mcc->def = g_new0(RISCVCPUDef, 1);
>      }
> @@ -3108,7 +3110,16 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>  #endif
>  
>      if (data) {
> -        const RISCVCPUDef *def = data;
> +        RISCVCPUDef def_data = *(const RISCVCPUDef *)data;
> +        RISCVCPUDef *def = &def_data;
> +
> +        if (def->max_satp_mode_choose) {
> +            def->cfg.max_satp_mode = def->max_satp_mode_choose(def);
> +        }
> +        if (def->misa_mxl_max_choose) {
> +            def->misa_mxl_max = def->misa_mxl_max_choose(def);
> +        }
> +
>          mcc->def->bare |= def->bare;
>          if (def->profile) {
>              assert(profile_extends(def->profile, mcc->def->profile));
> @@ -3299,6 +3310,18 @@ static void riscv_cpu_instance_finalize(Object *obj)
>      g_clear_pointer(&cpu->multi_ext_user_opts, g_hash_table_destroy);
>  }
>  
> +static int8_t riscv_cpu_max_satp_mode_choose(const RISCVCPUDef *def)
> +{
> +    (void)def;
> +    return target_riscv32() ? VM_1_10_SV32 : VM_1_10_SV57;
> +}
> +
> +static RISCVMXL riscv_cpu_misa_mxl_max_choose(const RISCVCPUDef *def)
> +{
> +    (void)def;
> +    return target_riscv32() ? MXL_RV32 : MXL_RV64;
> +}
> +
>  static const TypeInfo riscv_cpu_type_infos[] = {
>      {
>          .name = TYPE_RISCV_CPU,
> @@ -3339,21 +3362,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           * only MBARE will be available if the user doesn't enable
>           * a mode manually (see riscv_cpu_satp_mode_finalize()).
>           */
> -#ifdef TARGET_RISCV32
> -        .cfg.max_satp_mode = VM_1_10_SV32,
> -#else
> -        .cfg.max_satp_mode = VM_1_10_SV57,
> -#endif
> +        .max_satp_mode_choose = riscv_cpu_max_satp_mode_choose,
>      ),
>  
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
> -#if defined(TARGET_RISCV32)
> -        .misa_mxl_max = MXL_RV32,
> -        .cfg.max_satp_mode = VM_1_10_SV32,
> -#elif defined(TARGET_RISCV64)
> -        .misa_mxl_max = MXL_RV64,
> -        .cfg.max_satp_mode = VM_1_10_SV57,
> -#endif
> +        .max_satp_mode_choose = riscv_cpu_max_satp_mode_choose,
> +        .misa_mxl_max_choose = riscv_cpu_misa_mxl_max_choose,
>      ),
>  
>      DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR_CPU,
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 034d7e96c4..b6b5f679c9 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -597,6 +597,8 @@ typedef struct RISCVCPUDef {
>  #endif
>      /* This is just a setter for env->num_triggers.  */
>      uint32_t num_triggers;
> +    int8_t (*max_satp_mode_choose)(const struct RISCVCPUDef *def);
> +    RISCVMXL (*misa_mxl_max_choose)(const struct RISCVCPUDef *def);
>  } RISCVCPUDef;
>  
>  /**
> -- 
> 2.55.0.windows.3
> 


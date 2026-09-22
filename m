Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91B3C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97hI-0007CL-Hl; Tue, 22 Sep 2026 17:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x97hD-0007Bn-6I; Tue, 22 Sep 2026 17:06:36 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x97hA-0005EO-Vs; Tue, 22 Sep 2026 17:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=oCHdUhMh/QnUw6msFQr9ApVOKEaCtkEr0e5fKB06hjw=; b=AX5TC6fDds9WMsH
 QVKrYDoliT2quA6mpytsksZGc9HRrKCIRTYpKjxumu3msNNoAvqzlUnCll1gJa0V8aQx4noDEPRk8
 eZsiIPU5zRcJ4XMQOeb/gdkyERBNxprgi0s01qZrPjHA2OkxSiJq9udLuVWJEuWV4g9KKGd9Dus+U
 mg=;
Date: Tue, 22 Sep 2026 23:12:00 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com
Subject: Re: [PATCH v5 03/11] target/riscv: Replace TARGET_LONG_BITS in
 header exposed to common code
Message-ID: <arLsea9pWtG-DQGG@hive.localdomain>
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
 <20260918-hw-riscv-cpu-int-v5-3-f98c5a244636@rev.ng>
 <3539b4ac-aeda-4c90-935a-1c5e105713e7@oss.qualcomm.com>
 <5957fc53-99eb-4cad-89b6-0dae6e2a6d85@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5957fc53-99eb-4cad-89b6-0dae6e2a6d85@oss.qualcomm.com>
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

On 22/09/26, Philippe Mathieu-Daudé wrote:
> On 21/9/26 16:02, Philippe Mathieu-DaudÃ© wrote:
> > Hi Anton,
> > 
> > On 2026-09-18 0:04, Anton Johansson wrote:
> > > IRQ_LOCAL_GUEST_MAX depends on TARGET_LONG_BITS and is used in
> > > hw/intc/riscv_imsic.c.  The macro is replaced by a field in RISCVCPUDef
> > > initialized in riscv_cpu_class_base_init().
> > > 
> > > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > ---
> > >   target/riscv/cpu.h      |  5 ++++-
> > >   target/riscv/cpu_bits.h |  2 --
> > >   hw/intc/riscv_imsic.c   |  4 +++-
> > >   target/riscv/cpu.c      | 16 ++++++++++++++--
> > >   4 files changed, 21 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > index e2e0547eef..a820ec2f6e 100644
> > > --- a/target/riscv/cpu.h
> > > +++ b/target/riscv/cpu.h
> > > @@ -589,8 +589,11 @@ typedef struct RISCVCPUDef {
> > >       int32_t vext_spec;
> > >       RISCVCPUConfig cfg;
> > >       bool bare;
> > > -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> > > +#if !defined(CONFIG_USER_ONLY)
> > > +#if defined(CONFIG_TCG)
> > >       const RISCVCSR *custom_csrs;
> > > +#endif
> > > +    uint8_t irq_local_guest_max;
> > 
> > If it is variable, we shouldn't have it in the def. IMO we
> > simply want a helper on the CPU class:
> > 
> >    uint8_t riscv_imsic_irq_local_guest_max(RISCVCPUClass *rcc);
> 
> Even uint8_t riscv_imsic_irq_local_guest_max(const RISCVCPUClass *rcc).
> 
> > 
> > WDYT?
> 
> Pierrick told me this suggestion is not clear. See below...
> 
> > 
> > >   #endif
> > >       /* This is just a setter for env->num_triggers.  */
> > >       uint32_t num_triggers;
> > > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > > index c01050ce2b..9c499e33f2 100644
> > > --- a/target/riscv/cpu_bits.h
> > > +++ b/target/riscv/cpu_bits.h
> > > @@ -811,8 +811,6 @@ typedef enum RISCVException {
> > >   #define IRQ_S_GEXT                         12
> > >   #define IRQ_PMU_OVF                        13
> > >   #define IRQ_LOCAL_MAX                      64
> > > -/* -1 is due to bit zero of hgeip and hgeie being ROZ. */
> > > -#define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
> > >   /* RNMI causes */
> > >   #define RNMI_MAX                           16
> > > diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> > > index cb9ce9612c..bf0434e96f 100644
> > > --- a/hw/intc/riscv_imsic.c
> > > +++ b/hw/intc/riscv_imsic.c
> > > @@ -501,13 +501,15 @@ DeviceState *riscv_imsic_create(MemoryRegion
> > > *container, hwaddr addr,
> > >   {
> > >       DeviceState *dev = qdev_new(TYPE_RISCV_IMSIC);
> > >       CPUState *cpu = cpu_by_arch_id(hartid);
> > > +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(RISCV_CPU(cpu));
> > >       uint32_t i;
> > >       assert(!(addr & (IMSIC_MMIO_PAGE_SZ - 1)));
> > >       if (mmode) {
> > >           assert(num_pages == 1);
> > >       } else {
> > > -        assert(num_pages >= 1 && num_pages <= (IRQ_LOCAL_GUEST_MAX
> > > + 1));
> > > +        assert(num_pages >= 1 &&
> > > +               num_pages <= (mcc->def->irq_local_guest_max + 1));
> > >       }
> > >       assert(IMSIC_MIN_ID <= num_ids);
> > >       assert(num_ids <= IMSIC_MAX_ID);
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index 5fff9d745e..4f58e91b62 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -1416,6 +1416,7 @@ void riscv_add_satp_mode_properties(Object *obj)
> > >   static void riscv_cpu_set_irq(void *opaque, int irq, int level)
> > >   {
> > > +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
> > >       RISCVCPU *cpu = RISCV_CPU(opaque);
> > >       CPURISCVState *env = &cpu->env;
> > > @@ -1454,7 +1455,7 @@ static void riscv_cpu_set_irq(void *opaque,
> > > int irq, int level)
> > >           default:
> > >               g_assert_not_reached();
> > >           }
> > > -    } else if (irq < (IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX)) {
> > > +    } else if (irq < (IRQ_LOCAL_MAX + mcc->def->irq_local_guest_max)) {
> > >           /* Require H-extension for handling guest local interrupts */
> > >           if (!riscv_has_ext(env, RVH)) {
> > >               g_assert_not_reached();
> > > @@ -1501,7 +1502,7 @@ static void riscv_cpu_init(Object *obj)
> > >   #ifndef CONFIG_USER_ONLY
> > >       qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
> > > -                      IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
> > > +                      IRQ_LOCAL_MAX + mcc->def->irq_local_guest_max);
> > >       if (mcc->def->num_triggers) {
> > >           env->num_triggers = mcc->def->num_triggers;
> > >       }
> > > @@ -3092,6 +3093,17 @@ static void
> > > riscv_cpu_class_base_init(ObjectClass *c, const void *data)
> > >           mcc->def = g_new0(RISCVCPUDef, 1);
> > >       }
> > > +#ifndef CONFIG_USER_ONLY
> > > +    /*
> > > +     * RISCVCPUDef::irq_local_guest_max is initialized to
> > > +     * `target_long_bits()-1` due to bit zero of hgeip and hgeie
> > > +     * being ROZ.
> > > +     *
> > > +     * This value does not vary between CPU types.
> > > +     */
> > > +    mcc->def->irq_local_guest_max = target_long_bits() - 1;
> 
> ... here I'm worried this change the behavior of qemu-system-riscv32
> vs qemu-system-riscv64, in particular when instantiating a RV32 with
> the qemu-system-riscv64 binary. Maybe the change doesn't trigger any
> bug, but this is a change and we committed to not do any when
> introducing the single binary. Or at least we should mention the
> change in the commit description. But again, introducing
> riscv_imsic_irq_local_guest_max() then we don't need this RISCVCPUDef
> field and no behavioral change at all.

Hmm I'm not against introducing a helper function but I'm not 100% sure
I see the problem.  The current patch retains irq_local_guest_max == 31
for rv32 on qemu-riscv32, and irq_local_guest_max == 63 for rv32/64 on
qemu-riscv64.  If we e.g. instead derive the field from def->misa_mxl_max,
that would introduce a behavioural change.  Am I missing something
here?

> 
> > > +#endif
> > > +
> > >       if (data) {
> > >           const RISCVCPUDef *def = data;
> > >           mcc->def->bare |= def->bare;
> > > 
> > 
> > 
> 


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F53BC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 00:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWlHh-0005LZ-0y; Tue, 01 Jul 2025 20:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uWlHb-0005Ji-BK; Tue, 01 Jul 2025 20:25:03 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uWlHY-0005Ev-TG; Tue, 01 Jul 2025 20:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=o1sevuZZlyZLuAIwYrrExY248AZ+Y4x1dseVvaw2EUY=; b=TGOV5g9vSgKp3PXX
 k2EctZRBwELT++ZLAcc1+xaG1poPJwV3ohiul52lnRseUStm3m3xWex56oKI/4geBHaNd8+bJdyKG
 QJNGaEIva1DM9/SJ1wQOFdnm5StV4nx+ceHEeSd3WMMcpdGilrcuwZNeihSPfe7iVJIvcEWQNXMXI
 U5OMFWiAT63cgLhhMvsUhTUB3PWKtew0SYgyOAruYlETruJ/f53gmSC20zs8TuCOgS72Gpc0lo54y
 euxbryZHOj7CjwAo01VnPPc+4svUfv+DfVZZaVdp3YmYK2TUvlwwoZHlp144AQaaB1d055twyxDWX
 uZJsSY/AGc9tscR80g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uWlHT-00DR1U-1E;
 Wed, 02 Jul 2025 00:24:55 +0000
Date: Wed, 2 Jul 2025 00:24:55 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@dabbelt.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] hmp-cmds-target, target/riscv: add 'info register'
Message-ID: <aGR8V2DwnIfL0yMI@gallifrey>
References: <20250630132228.1276838-1-dbarboza@ventanamicro.com>
 <aGMmtqfqh7ZbJzdK@gallifrey>
 <df816967-721f-4d55-8bbf-7bfffb5d508f@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df816967-721f-4d55-8bbf-7bfffb5d508f@ventanamicro.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 00:23:32 up 65 days, 8:37, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Daniel Henrique Barboza (dbarboza@ventanamicro.com) wrote:
> 
> 
> On 6/30/25 9:07 PM, Dr. David Alan Gilbert wrote:
> > * Daniel Henrique Barboza (dbarboza@ventanamicro.com) wrote:
> > 
> > Hi Daniel,
> > 
> > > The RISC-V target has *a lot* of CPU registers, with more registers
> > > being added along the way when new extensions are added. In this world,
> > > 'info registers' will throw a wall of text that can be annoying to deal
> > > with when the user wants to verify the value of just a couple of
> > > registers.
> > > 
> > > Add a new 'info register' HMP command that prints a specific register.
> > > The semantics, and implementation, is similar to what 'info registers'
> > > already does, i.e. '-a' will print a register for all VCPUs and it's
> > > possible to print a reg for a specific VCPU.
> > > 
> > > A RISC-V implementation is included via riscv_cpu_dump_register().
> > > 
> > > Here's an example:
> > > 
> > > Welcome to Buildroot
> > > buildroot login: QEMU 10.0.50 monitor - type 'help' for more information
> > > (qemu) info register mstatus
> > > 
> > > CPU#0
> > >   mstatus  0000000a000000a0
> > > (qemu) info register mstatus -a
> > > 
> > > CPU#0
> > >   mstatus  0000000a000000a0
> > > 
> > > CPU#1
> > >   mstatus  0000000a000000a0
> > > (qemu)
> > 
> > OK, that makes some sense; some comments:
> > 
> >     a) I'd make that a list of register names so you can print a handful out
> > for whatever you're debugging.
> >         info register gpr0,gpr1,pc
> >     b) (But then you start wondering if having some predefined like 'gprs'
> > would work)
> >     c) It turns out there's an old, but limited similar thing called MonitorDef's
> > where a target can define a list of registers; so you might want to define
> > target_monitor_defs() OR target_get_monitor_def() for your architecture anyway,
> > on x86 you can do things like
> >            p/x $pc
> >            x/10i $pc
> >            p/x $eax
> > 
> >        It doesn't seem very well maintained in the architectures though; the x86
> >    one is prehistoric for example.
> 
> But it's a cool API to have it seems. If we couple this with 'cpu N' commands we can
> print registers from multiple CPUs.
> 
> Perhaps we still want an 'info registers' or an 'info registers -r reg1,reg2...' to
> print multiple registers anyway, but I don't see a reason to not support the MonitorDef
> API in RISC-V too. I'll take a look.

If you were doing MonitorDef, I think of the two interfaces, target_get_monitor_def
looks easier to me, but I might be wrong.

> >    d) Another way would be to modify info registers to take an optional
> >       -r register-list
> > 
> > Anyway, those are _suggestions_ only.
> 
> 
> I don't mind adding new options in 'info registers' to do what this new API I'm
> proposing. In fact that was my original idea, and the reason I added a new API was
> more in a fear of adding too much stuff into it and the potential pushback.
> 
> IIUC from the feedbacks we have so far, we could augment 'info registers' as follows:
> 
> - add a '-h' option to print the names of all available registers
> - add a '-r' option followed by a list of registers to be dumped

Yeh.

> In parallel I'll take a look in MonitorDef too. Thanks,

Nice.

Dave

> 
> Daniel
> 
> 
> 
> 
> 
> > 
> > Dave
> > 
> > > The API is introduced as TARGET_RISCV only.
> > > 
> > > Cc: Dr. David Alan Gilbert <dave@treblig.org>
> > > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > > Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > ---
> > >   hmp-commands-info.hx         | 17 +++++++++++++
> > >   hw/core/cpu-common.c         |  8 ++++++
> > >   include/hw/core/cpu.h        | 11 +++++++++
> > >   include/monitor/hmp-target.h |  1 +
> > >   monitor/hmp-cmds-target.c    | 30 ++++++++++++++++++++++
> > >   target/riscv/cpu.c           | 48 ++++++++++++++++++++++++++++++++++++
> > >   6 files changed, 115 insertions(+)
> > > 
> > > diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> > > index 639a450ee5..f3561e4a02 100644
> > > --- a/hmp-commands-info.hx
> > > +++ b/hmp-commands-info.hx
> > > @@ -113,6 +113,23 @@ SRST
> > >       Show the cpu registers.
> > >   ERST
> > > +#if defined(TARGET_RISCV)
> > > +    {
> > > +        .name       = "register",
> > > +        .args_type  = "register:s,cpustate_all:-a,vcpu:i?",
> > > +        .params     = "[register|-a|vcpu]",
> > > +        .help       = "show a cpu register (-a: show the register value for all cpus;"
> > > +                      " vcpu: specific vCPU to query; show the current CPU's register if"
> > > +                      " no vcpu is specified)",
> > > +        .cmd        = hmp_info_register,
> > > +    },
> > > +
> > > +SRST
> > > +  ``info register``
> > > +    Show a cpu register.
> > > +ERST
> > > +#endif
> > > +
> > >   #if defined(TARGET_I386)
> > >       {
> > >           .name       = "lapic",
> > > diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> > > index 39e674aca2..9c65ce1537 100644
> > > --- a/hw/core/cpu-common.c
> > > +++ b/hw/core/cpu-common.c
> > > @@ -108,6 +108,14 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
> > >       }
> > >   }
> > > +void cpu_dump_register(CPUState *cpu, const char *reg, FILE *f)
> > > +{
> > > +    if (cpu->cc->dump_register) {
> > > +        cpu_synchronize_state(cpu);
> > > +        cpu->cc->dump_register(cpu, reg, f);
> > > +    }
> > > +}
> > > +
> > >   void cpu_reset(CPUState *cpu)
> > >   {
> > >       device_cold_reset(DEVICE(cpu));
> > > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > > index 33296a1c08..b9ddce22bd 100644
> > > --- a/include/hw/core/cpu.h
> > > +++ b/include/hw/core/cpu.h
> > > @@ -160,6 +160,7 @@ struct CPUClass {
> > >       int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
> > >                              uint8_t *buf, size_t len, bool is_write);
> > >       void (*dump_state)(CPUState *cpu, FILE *, int flags);
> > > +    void (*dump_register)(CPUState *cpu, const char *reg, FILE *);
> > >       void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
> > >       int64_t (*get_arch_id)(CPUState *cpu);
> > >       void (*set_pc)(CPUState *cpu, vaddr value);
> > > @@ -693,6 +694,16 @@ enum CPUDumpFlags {
> > >    */
> > >   void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
> > > +/**
> > > + * cpu_dump_register:
> > > + * @cpu: The CPU whose register state is to be dumped.
> > > + * @reg: CPU register name to be dumped.
> > > + * @f: If non-null, dump to this stream, else to current print sink.
> > > + *
> > > + * Dumps CPU register state.
> > > + */
> > > +void cpu_dump_register(CPUState *cpu, const char *reg, FILE *f);
> > > +
> > >   /**
> > >    * cpu_get_phys_page_attrs_debug:
> > >    * @cpu: The CPU to obtain the physical page address for.
> > > diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> > > index b679aaebbf..da9d690f89 100644
> > > --- a/include/monitor/hmp-target.h
> > > +++ b/include/monitor/hmp-target.h
> > > @@ -57,6 +57,7 @@ void hmp_info_via(Monitor *mon, const QDict *qdict);
> > >   void hmp_memory_dump(Monitor *mon, const QDict *qdict);
> > >   void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
> > >   void hmp_info_registers(Monitor *mon, const QDict *qdict);
> > > +void hmp_info_register(Monitor *mon, const QDict *qdict);
> > >   void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
> > >   void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
> > >   void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
> > > diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> > > index 8eaf70d9c9..43f509aa60 100644
> > > --- a/monitor/hmp-cmds-target.c
> > > +++ b/monitor/hmp-cmds-target.c
> > > @@ -121,6 +121,36 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
> > >       }
> > >   }
> > > +/*
> > > + * Based on hmp_info_registers().
> > > + */
> > > +void hmp_info_register(Monitor *mon, const QDict *qdict)
> > > +{
> > > +    const char *reg = qdict_get_try_str(qdict, "register");
> > > +    bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
> > > +    int vcpu = qdict_get_try_int(qdict, "vcpu", -1);
> > > +    CPUState *cs;
> > > +
> > > +    if (all_cpus) {
> > > +        CPU_FOREACH(cs) {
> > > +            cpu_dump_register(cs, reg, NULL);
> > > +        }
> > > +    } else {
> > > +        cs = vcpu >= 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
> > > +
> > > +        if (!cs) {
> > > +            if (vcpu >= 0) {
> > > +                monitor_printf(mon, "CPU#%d not available\n", vcpu);
> > > +            } else {
> > > +                monitor_printf(mon, "No CPU available\n");
> > > +            }
> > > +            return;
> > > +        }
> > > +
> > > +        cpu_dump_register(cs, reg, NULL);
> > > +    }
> > > +}
> > > +
> > >   static void memory_dump(Monitor *mon, int count, int format, int wsize,
> > >                           hwaddr addr, int is_physical)
> > >   {
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index e3f8ecef68..8b3edf7b23 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -640,6 +640,53 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> > >       }
> > >   }
> > > +static void riscv_cpu_dump_register(CPUState *cs, const char *reg, FILE *f)
> > > +{
> > > +    RISCVCPU *cpu = RISCV_CPU(cs);
> > > +    CPURISCVState *env = &cpu->env;
> > > +    bool match_found = false;
> > > +    int i;
> > > +
> > > +    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
> > > +        RISCVException res;
> > > +        target_ulong val = 0;
> > > +        int csrno = i;
> > > +
> > > +        /*
> > > +         * Early skip when possible since we're going
> > > +         * through a lot of NULL entries.
> > > +         */
> > > +        if (csr_ops[csrno].predicate == NULL) {
> > > +            continue;
> > > +        }
> > > +
> > > +        /*
> > > +         * We're doing partial register name matching,
> > > +         * e.g. 'mhpm' will match all registers that
> > > +         * starts with 'mhpm'.
> > > +         */
> > > +        if (strncasecmp(csr_ops[csrno].name, reg, strlen(reg)) != 0) {
> > > +            continue;
> > > +        }
> > > +
> > > +        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
> > > +
> > > +        /*
> > > +         * Rely on the smode, hmode, etc, predicates within csr.c
> > > +         * to do the filtering of the registers that are present.
> > > +         */
> > > +        if (res == RISCV_EXCP_NONE) {
> > > +            if (!match_found) {
> > > +                match_found = true;
> > > +                qemu_fprintf(f, "\nCPU#%d\n", cs->cpu_index);
> > > +            }
> > > +
> > > +            qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
> > > +                         csr_ops[csrno].name, val);
> > > +        }
> > > +    }
> > > +}
> > > +
> > >   static void riscv_cpu_set_pc(CPUState *cs, vaddr value)
> > >   {
> > >       RISCVCPU *cpu = RISCV_CPU(cs);
> > > @@ -2690,6 +2737,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
> > >       cc->class_by_name = riscv_cpu_class_by_name;
> > >       cc->dump_state = riscv_cpu_dump_state;
> > > +    cc->dump_register = riscv_cpu_dump_register;
> > >       cc->set_pc = riscv_cpu_set_pc;
> > >       cc->get_pc = riscv_cpu_get_pc;
> > >       cc->gdb_read_register = riscv_cpu_gdb_read_register;
> > > -- 
> > > 2.49.0
> > > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0107C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVZpI-0007Bq-5X; Thu, 01 Feb 2024 11:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rVZpG-0007BR-FU
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:22:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rVZpD-0004L6-4i
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:22:06 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQkcD1MwJz688sb;
 Fri,  2 Feb 2024 00:18:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id EC08F140D26;
 Fri,  2 Feb 2024 00:21:51 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 16:21:51 +0000
Date: Thu, 1 Feb 2024 16:21:50 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Sajjan Rao
 <sajjanr@gmail.com>, Gregory Price <gregory.price@memverge.com>, "Dimitrios
 Palyvos" <dimitrios.palyvos@zptcorp.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <richard.henderson@linaro.org>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
Message-ID: <20240201162150.000022cf@huawei.com>
In-Reply-To: <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com>
 <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com>
 <ZbPTL00WOo7UC0e6@memverge.com>
 <20240126171233.00002a2e@Huawei.com>
 <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
 <20240201130438.00001384@Huawei.com>
 <CAFEAcA-rgFmaE4Ea7hZ-On4uyaqjWoo-OwwfNrUOdp=+Q5ckXA@mail.gmail.com>
 <20240201140100.000016ce@huawei.com>
 <CAFEAcA9DW8AuMwDr_qyDXPWJcLsvD773XTr1stwuagHWc6p72g@mail.gmail.com>
 <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 1 Feb 2024 16:00:56 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 1 Feb 2024 at 15:17, Alex Benn=E9e <alex.bennee@linaro.org> wrote:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes: =20
> > > So, that looks like:
> > >  * we call cpu_tb_exec(), which executes some generated code
> > >  * that generated code calls the lookup_tb_ptr helper to see
> > >    if we have a generated TB already for the address we're going
> > >    to execute next
> > >  * lookup_tb_ptr probes the TLB to see if we know the host RAM
> > >    address for the guest address
> > >  * this results in a TLB walk for an instruction fetch
> > >  * the page table descriptor load is to IO memory
> > >  * io_prepare assumes it needs to do a TLB recompile, because
> > >    can_do_io is clear
> > >
> > > I am not surprised that the corner case of "the guest put its
> > > page tables in an MMIO device" has not yet come up :-)
> > >
> > > I'm really not sure how the icount handling should interact
> > > with that... =20
> >
> > Its not just icount - we need to handle it for all modes now. That said
> > seeing as we are at the end of a block shouldn't can_do_io be set? =20
>=20
> The lookup_tb_ptr helper gets called from tcg_gen_goto_tb(),
> which happens earlier than the tb_stop callback (it can
> happen in the trans function for branch etc insns, for
> example).
>=20
> I think it should be OK to clear can_do_io at the start
> of the lookup_tb_ptr helper, something like:
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 977576ca143..7818537f318 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -396,6 +396,15 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>      uint64_t cs_base;
>      uint32_t flags, cflags;
>=20
> +    /*
> +     * By definition we've just finished a TB, so I/O is OK.
> +     * Avoid the possibility of calling cpu_io_recompile() if
> +     * a page table walk triggered by tb_lookup() calling
> +     * probe_access_internal() happens to touch an MMIO device.
> +     * The next TB, if we chain to it, will clear the flag again.
> +     */
> +    cpu->neg.can_do_io =3D true;
> +
>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>=20
>      cflags =3D curr_cflags(cpu);
>=20
> -- PMM

No joy.  Seems like a very similar backtrace.

Thread 5 "qemu-system-x86" received signal SIGABRT, Aborted.
[Switching to Thread 0x7ffff4efe6c0 (LWP 23937)]
__pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<optimized=
 out>) at ./nptl/pthread_kill.c:44
44      ./nptl/pthread_kill.c: No such file or directory.
(gdb) bt
#0  __pthread_kill_implementation (no_tid=3D0, signo=3D6, threadid=3D<optim=
ized out>) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=3D6, threadid=3D<optimized out>) at ./np=
tl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=3D<optimized out>, signo=3Dsigno@entry=3D=
6) at ./nptl/pthread_kill.c:89
#3  0x00007ffff77c43b6 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/po=
six/raise.c:26
#4  0x00007ffff77aa87c in __GI_abort () at ./stdlib/abort.c:79
#5  0x0000555555c4d19e in cpu_abort (cpu=3Dcpu@entry=3D0x5555578e0cb0, fmt=
=3Dfmt@entry=3D0x555556048ee8 "cpu_io_recompile: could not find TB for pc=
=3D%p") at ../../cpu-target.c:373
#6  0x0000555555c9cb25 in cpu_io_recompile (cpu=3Dcpu@entry=3D0x5555578e0cb=
0, retaddr=3Dretaddr@entry=3D0) at ../../accel/tcg/translate-all.c:611
#7  0x0000555555c9f744 in io_prepare (retaddr=3D0, addr=3D19595790664, attr=
s=3D..., xlat=3D<optimized out>, cpu=3D0x5555578e0cb0, out_offset=3D<synthe=
tic pointer>) at ../../accel/tcg/cputlb.c:1339
#8  do_ld_mmio_beN (cpu=3D0x5555578e0cb0, full=3D0x7ffe88012890, ret_be=3Dr=
et_be@entry=3D0, addr=3D19595790664, size=3Dsize@entry=3D8, mmu_idx=3D4, ty=
pe=3DMMU_DATA_LOAD, ra=3D0) at ../../accel/tcg/cputlb.c:2030
#9  0x0000555555ca0ecd in do_ld_8 (cpu=3Dcpu@entry=3D0x5555578e0cb0, p=3Dp@=
entry=3D0x7ffff4efcdd0, mmu_idx=3D<optimized out>, type=3Dtype@entry=3DMMU_=
DATA_LOAD, memop=3D<optimized out>, ra=3Dra@entry=3D0) at ../../accel/tcg/c=
putlb.c:2356
#10 0x0000555555ca332f in do_ld8_mmu (cpu=3Dcpu@entry=3D0x5555578e0cb0, add=
r=3Daddr@entry=3D19595790664, oi=3Doi@entry=3D52, ra=3Dra@entry=3D0, access=
_type=3Daccess_type@entry=3DMMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
#11 0x0000555555ca5e69 in cpu_ldq_mmu (ra=3D0, oi=3D52, addr=3D19595790664,=
 env=3D0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
#12 cpu_ldq_le_mmuidx_ra (env=3D0x5555578e3470, addr=3D19595790664, mmu_idx=
=3D<optimized out>, ra=3Dra@entry=3D0) at ../../accel/tcg/ldst_common.c.inc=
:301
#13 0x0000555555b4b5de in ptw_ldq (in=3D0x7ffff4efcf10) at ../../target/i38=
6/tcg/sysemu/excp_helper.c:98
#14 ptw_ldq (in=3D0x7ffff4efcf10) at ../../target/i386/tcg/sysemu/excp_help=
er.c:93
#15 mmu_translate (env=3Denv@entry=3D0x5555578e3470, in=3D0x7ffff4efcfd0, o=
ut=3D0x7ffff4efcfa0, err=3Derr@entry=3D0x7ffff4efcfb0) at ../../target/i386=
/tcg/sysemu/excp_helper.c:173
#16 0x0000555555b4c3f3 in get_physical_address (err=3D0x7ffff4efcfb0, out=
=3D0x7ffff4efcfa0, mmu_idx=3D0, access_type=3DMMU_DATA_STORE, addr=3D183864=
91786698339392, env=3D0x5555578e3470) at ../../target/i386/tcg/sysemu/excp_=
helper.c:578
#17 x86_cpu_tlb_fill (cs=3D0x5555578e0cb0, addr=3D18386491786698339392, siz=
e=3D<optimized out>, access_type=3DMMU_DATA_STORE, mmu_idx=3D0, probe=3D<op=
timized out>, retaddr=3D140736029817822) at ../../target/i386/tcg/sysemu/ex=
cp_helper.c:604
#18 0x0000555555ca0df9 in tlb_fill (retaddr=3D140736029817822, mmu_idx=3D0,=
 access_type=3DMMU_DATA_STORE, size=3D<optimized out>, addr=3D1838649178669=
8339392, cpu=3D0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1315
#19 mmu_lookup1 (cpu=3Dcpu@entry=3D0x5555578e0cb0, data=3Ddata@entry=3D0x7f=
fff4efd120, mmu_idx=3D0, access_type=3Daccess_type@entry=3DMMU_DATA_STORE, =
ra=3Dra@entry=3D140736029817822) at ../../accel/tcg/cputlb.c:1713
#20 0x0000555555ca2b71 in mmu_lookup (cpu=3D0x5555578e0cb0, addr=3D18386491=
786698339392, oi=3D<optimized out>, ra=3D140736029817822, type=3DMMU_DATA_S=
TORE, l=3D0x7ffff4efd120) at ../../accel/tcg/cputlb.c:1803
#21 0x0000555555ca3e5d in do_st8_mmu (cpu=3D0x5555578e0cb0, addr=3D23937, v=
al=3D18386491784638059520, oi=3D6, ra=3D140736029817822) at ../../accel/tcg=
/cputlb.c:2853
#22 0x00007fffa9107c63 in code_gen_buffer ()
#23 0x0000555555c9395b in cpu_tb_exec (cpu=3Dcpu@entry=3D0x5555578e0cb0, it=
b=3Ditb@entry=3D0x7fffa9107980 <code_gen_buffer+17856851>, tb_exit=3Dtb_exi=
t@entry=3D0x7ffff4efd718) at ../../accel/tcg/cpu-exec.c:442
#24 0x0000555555c93ec0 in cpu_loop_exec_tb (tb_exit=3D0x7ffff4efd718, last_=
tb=3D<synthetic pointer>, pc=3D<optimized out>, tb=3D0x7fffa9107980 <code_g=
en_buffer+17856851>, cpu=3D0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:897
#25 cpu_exec_loop (cpu=3Dcpu@entry=3D0x5555578e0cb0, sc=3Dsc@entry=3D0x7fff=
f4efd7b0) at ../../accel/tcg/cpu-exec.c:1012
#26 0x0000555555c946d1 in cpu_exec_setjmp (cpu=3Dcpu@entry=3D0x5555578e0cb0=
, sc=3Dsc@entry=3D0x7ffff4efd7b0) at ../../accel/tcg/cpu-exec.c:1029
#27 0x0000555555c94ebc in cpu_exec (cpu=3Dcpu@entry=3D0x5555578e0cb0) at ..=
/../accel/tcg/cpu-exec.c:1055
#28 0x0000555555cb8f53 in tcg_cpu_exec (cpu=3Dcpu@entry=3D0x5555578e0cb0) a=
t ../../accel/tcg/tcg-accel-ops.c:76
#29 0x0000555555cb90b0 in mttcg_cpu_thread_fn (arg=3Darg@entry=3D0x5555578e=
0cb0) at ../../accel/tcg/tcg-accel-ops-mttcg.c:95
#30 0x0000555555e57180 in qemu_thread_start (args=3D0x555557956000) at ../.=
./util/qemu-thread-posix.c:541
#31 0x00007ffff78176ba in start_thread (arg=3D<optimized out>) at ./nptl/pt=
hread_create.c:444
#32 0x00007ffff78a60d0 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/cl=
one3.S:81


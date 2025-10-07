Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680CFCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v65qp-00064z-Tm; Tue, 07 Oct 2025 07:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v65qn-00064P-S3
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:27:25 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v65ql-00075R-Qo
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=hzccDbA+pRow3ZPAD1oMmkDdTzOwFpfIyF4KmTyY+K0=; b=QmFmVW+yftRUPzT
 lB+95jOuhZnMkKsVGsIjIsBbfLFSLa27tJzlJiXMg29n3cQYFd4J4cNeh64gHjlYqNOi9o4+5OTuT
 WTDk+nimuEsnVjhwni+pvykDXvTkS6NBtgeJr2aUGpqR/XTIiVSTYOTfx3XARwvunqDinNrGJBGVN
 xk=;
Date: Tue, 7 Oct 2025 13:29:56 +0200
To: Alistair Francis <alistair23@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 philmd@linaro.org, richard.henderson@linaro.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com
Subject: Re: [PATCH v2 05/33] target/riscv: Combine mhpmevent and mhpmeventh
Message-ID: <kyj3vdvzzrk653mxdi3xhxtcaulzchfnaxs3ajmzycukkzjegt@yzemdwra52m2>
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-6-anjo@rev.ng>
 <e1748ad3-3475-4cce-8add-2a1d76994f0b@linaro.org>
 <cbc22e4a-84dd-4209-82fd-ec56ea138d27@linaro.org>
 <CAKmqyKO6rvjBe56pDPaa_TQn8z9npQ6h_F=JkVLWBA8qHciQig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKO6rvjBe56pDPaa_TQn8z9npQ6h_F=JkVLWBA8qHciQig@mail.gmail.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/10/25, Alistair Francis wrote:
> On Fri, Oct 3, 2025 at 5:37 AM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > On 10/2/25 12:08 PM, Pierrick Bouvier wrote:
> > > On 10/1/25 12:32 AM, Anton Johansson wrote:
> > >> According to version 20250508 of the privileged specification,
> > >> mhpmeventn is 64 bits in size and mhpmeventnh is only ever used
> > >> when XLEN == 32 and accesses the top 32 bits of the 64-bit
> > >> mhpmeventn registers. Combine the two arrays of target_ulong
> > >> mhpmeventh[] and mhpmevent[] to a single array of uint64_t.
> > >>
> > >> This also allows for some minor code simplification where branches
> > >> handling either mhpmeventh[] or mhpmevent[] could be combined.
> > >>
> > >> Signed-off-by: Anton Johansson <anjo@rev.ng>
> > >> ---
> > >>    target/riscv/cpu.h     | 10 +++----
> > >>    target/riscv/csr.c     | 67 +++++++++++++++---------------------------
> > >>    target/riscv/machine.c |  3 +-
> > >>    target/riscv/pmu.c     | 53 ++++++++-------------------------
> > >>    4 files changed, 42 insertions(+), 91 deletions(-)
> > >>
> > >> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > >> index 3235108112..64b9964028 100644
> > >> --- a/target/riscv/cpu.h
> > >> +++ b/target/riscv/cpu.h
> > >> @@ -427,11 +427,11 @@ struct CPUArchState {
> > >>        /* PMU counter state */
> > >>        PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
> > >>
> > >> -    /* PMU event selector configured values. First three are unused */
> > >> -    target_ulong mhpmevent_val[RV_MAX_MHPMEVENTS];
> > >> -
> > >> -    /* PMU event selector configured values for RV32 */
> > >> -    target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
> > >> +    /*
> > >> +     * PMU event selector configured values. First three are unused.
> > >> +     * For RV32 top 32 bits are accessed via the mhpmeventh CSR.
> > >> +     */
> > >> +    uint64_t mhpmevent_val[RV_MAX_MHPMEVENTS];
> > >>
> > >>        PMUFixedCtrState pmu_fixed_ctrs[2];
> > >>
> > >> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > >> index 859f89aedd..2d8916ee40 100644
> > >> --- a/target/riscv/csr.c
> > >> +++ b/target/riscv/csr.c
> > >> @@ -1166,8 +1166,9 @@ static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
> > >>                                         target_ulong *val)
> > >>    {
> > >>        int evt_index = csrno - CSR_MCOUNTINHIBIT;
> > >> +    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
> > >>
> > >> -    *val = env->mhpmevent_val[evt_index];
> > >> +    *val = extract64(env->mhpmevent_val[evt_index], 0, rv32 ? 32 : 64);
> > >>
> > >>        return RISCV_EXCP_NONE;
> > >>    }
> > >> @@ -1176,13 +1177,11 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
> > >>                                          target_ulong val, uintptr_t ra)
> > >>    {
> > >>        int evt_index = csrno - CSR_MCOUNTINHIBIT;
> > >> -    uint64_t mhpmevt_val = val;
> > >> +    uint64_t mhpmevt_val;
> > >>        uint64_t inh_avail_mask;
> > >>
> > >>        if (riscv_cpu_mxl(env) == MXL_RV32) {
> > >> -        env->mhpmevent_val[evt_index] = val;
> > >> -        mhpmevt_val = mhpmevt_val |
> > >> -                      ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
> > >> +        mhpmevt_val = deposit64(env->mhpmevent_val[evt_index], 0, 32, val);
> > >
> > > Maybe I missed something, but should it be:
> > > deposit64(env->mhpmevent_val[evt_index], 32, 32, val)
> > > instead?
> > >
> > > Reading the rest of the patch, I'm a bit confused about which bits are
> > > supposed to be used in 32/64 mode.
> >
> > Indeed I missed something, it's more clear with next patchs combining
> > low/high parts.
> 
> Besides this missed part the patch looks good.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 

Did I miss something here? Isn't writing the lower 32 bits correct?

> > The concern I have that is left is regarding the definition of
> > MHPMEVENT_BIT_OF. It seems to be out of sync with what we have now given
> > that we now keep lower part in lower bits.
> 
> That might be a bug, it should be using MHPMEVENTH_BIT_OF with mhpmeventh_val
> 
> 
> Alistair

I'll take a look at the flags, thanks!:)


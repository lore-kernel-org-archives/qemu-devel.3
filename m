Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9A6CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESq2-0001Xk-Jq; Wed, 07 Oct 2026 10:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xESpi-0001Kd-7b; Wed, 07 Oct 2026 10:41:28 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xESpf-0002R8-OW; Wed, 07 Oct 2026 10:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=pFhKOmw8FKQUv1y/X7fJODk8vc9bBcgYJQce7Gg3hkk=; b=HMnK6VCl1dqrP4M
 vU9y52VaDY9RK6blfdGp2VSK6r+NlvSEfysFX6YVuRcJgq9YzgFFlLJzRjYIcsN78o5VHiDUTDfpA
 kwIOYLzMyJIptM1kIp0RQG5zRBp8KCc9icwcQZlOWU3yfaEYbWR8gNlyUf/hBATXsYsNczy1/J1Gf
 NI=;
Date: Wed, 7 Oct 2026 16:47:03 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: luoyonggang@gmail.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com
Subject: Re: [PATCH v2 14/18] target/riscv: Compile pmp.c once
Message-ID: <asZX2DtHzflInjWt@hive.localdomain>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-14-8a2f0f296a7f@rev.ng>
 <17cb7c7c-5f22-4a03-8855-4d1ec91d347a@oss.qualcomm.com>
 <CAE2XoE9eXXKQGZZ0kvmex88+tjch1-+H_-MgB6JEu+4bdPZq8g@mail.gmail.com>
 <9bf8945c-6472-462e-a275-f0b74912d3ed@oss.qualcomm.com>
 <CAE2XoE9QzGda8J9QCQysRL8OoxBrR86Ft426Rf4TXJxnPm+Vsg@mail.gmail.com>
 <2874719a-ca6d-473f-a29f-e40f56016fc9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2874719a-ca6d-473f-a29f-e40f56016fc9@oss.qualcomm.com>
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

On 07/10/26, Philippe Mathieu-Daudé wrote:
> Phil.
> 
> Regards,
> 
> I missed it, but again Anton's comment were in this patch
> description I wouldn't had barked.
> 
> How does this will work in heterogeneous binary with one
> RV32 and another RV64 cores running together?
> 
> [we tend to avoid top-posting on technical lists]

Ah my bad I should have mentioned it here also.

riscv_cpu_mxl_bits() vs target_long_bits() is, from my understanding,
one of the main discrepancies between rv32 on qemu-riscv32 vs qemu-riscv64,
and they are not equivalent since 32-bit code on qemu-riscv64 will
still have target_long_bits() == 64, but riscv_cpu_mxl_bits() == 32.

For the time being using target_long_bits() preserves the original
behaviour.  In a heterogeneous setting qemu-riscv64 can already run
RV32 and RV64 code despite target_long_bits() == 64, but I'll take a
pass over the code to check for incorrect uses of target_long_bits()
and submit that separately since that would change behaviour.

//Anton

> 
> On 7/10/26 15:39, Yonggang Luo wrote:
> > It's here https://lore.kernel.org/qemu-devel/ar9WZip2Q2G0qvQI@hive.localdomain/
> > 
> > From: Anton Johansson via qemu development <qemu-devel@nongnu.org>
> > 
> > 
> > I wouldn't be surprised if that's the case, although I'm personally a
> > bit scared of riscv_cpu_mxl_bits() since it returns 128 for MXL_128, so
> > if it's not used carefully or on clear MXL_[32|64] paths you could easily
> > get UB.
> > 
> > 
> > On Wed, Oct 7, 2026 at 9:26 PM Philippe Mathieu-Daudé
> > <philmd@oss.qualcomm.com> wrote:
> > > 
> > > On 7/10/26 13:51, Yonggang Luo wrote:
> > > > On Wed, Oct 7, 2026 at 6:25 PM Philippe Mathieu-Daudé
> > > > <philmd@oss.qualcomm.com> wrote:
> > > > > 
> > > > > On 7/10/26 10:43, Anton Johansson wrote:
> > > > > > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > > > > > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > > > > ---
> > > > > >     target/riscv/tcg/pmp.c       | 5 +++--
> > > > > >     target/riscv/tcg/meson.build | 2 +-
> > > > > >     2 files changed, 4 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
> > > > > > index 99345d63dc..2d7194de10 100644
> > > > > > --- a/target/riscv/tcg/pmp.c
> > > > > > +++ b/target/riscv/tcg/pmp.c
> > > > > > @@ -638,19 +638,20 @@ uint64_t pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
> > > > > >         if (addr_index < pmp_regions) {
> > > > > >             val = env->pmp_state.pmp[addr_index].addr_reg;
> > > > > >             int g = pmp_get_granularity_g(env);
> > > > > > +        const unsigned long_bits = target_long_bits();
> > > > > 
> > > > > We need to fetch this information from @env. Maybe riscv_cpu_mxl_bits()?
> > > > 
> > > > discussed before, there is possible be 128bits
> > > 
> > > Please point me to the discussion (directly, saving us a ping / pong),
> > > as:
> > > 
> > >     '''
> > >     This was already discussed on v42:
> > > 
> > >     https://lore.kernel.org/qemu-devel/some-message-id-v42-20128438/
> > >     '''
> > > 
> > > Having the discussion decision resumed in the patch description will
> > > prevent further reviewers to ask again the same.
> > > 
> > > What do you mean by "possible be 128bits"? If we want to cap the
> > > value we can use MIN(64, riscv_cpu_mxl_bits(env)).
> > > 
> > > > 
> > > > > >             switch (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg_reg)) {
> > > > > >             case PMP_AMATCH_OFF:
> > > > > >                 /* fallthrough */
> > > > > >             case PMP_AMATCH_TOR:
> > > > > >                 /* Bit [g-1:0] read all zero */
> > > > > > -            if (g >= 1 && g < TARGET_LONG_BITS) {
> > > > > > +            if (g >= 1 && g < long_bits) {
> > > > > >                     uint64_t granule = 1ULL << g;
> > > > > >                     val = ROUND_DOWN(val, granule);
> > > > > >                 }
> > > > > >                 break;
> > > > > >             case PMP_AMATCH_NAPOT:
> > > > > >                 /* Bit [g-2:0] read all one */
> > > > > > -            if (g >= 2 && g < TARGET_LONG_BITS) {
> > > > > > +            if (g >= 2 && g < long_bits) {
> > > > > >                     val = deposit64(val, 0, g - 1, -1ULL);
> > > > > >                 }
> > > > > >                 break;
> > > > > 
> > > > 
> > > > 
> > > 
> > 
> > 
> 


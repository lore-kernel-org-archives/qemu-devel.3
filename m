Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D76CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfJh-0004uf-Bo; Fri, 02 Oct 2026 11:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCfJg-0004uQ-GF; Fri, 02 Oct 2026 11:36:56 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xCfJe-0000M3-Or; Fri, 02 Oct 2026 11:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=2bgH812fgd+y00jZ5h6viDKL24irD/innIGyZyBXMAw=; b=P89iaz0pYQJm6Uz
 Zpvsjqq2z+BKDY0S+D/OYvq7LqWb9clANvBDtJ1zYD+xdU2jiFt+L182rcnAohajEYJsjKPMMgXYw
 hV1SWaxgwb8PWj//ze75QTgVoubtuwnwfXV8cEgDDl/L79NBKpNssTGx7KeZrllHCiwCoTcN7rGYJ
 qE=;
Date: Fri, 2 Oct 2026 17:42:34 +0200
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: luoyonggang@gmail.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
Subject: Re: [PATCH 07/18] target/riscv: Runtime register MAX and BARE CPUs
Message-ID: <ar_AzEWpF9XDGNdg@hive.localdomain>
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-7-ea69b07afd31@rev.ng>
 <CAE2XoE_ag1RR_JFwgcg+9zPed+qpO2skf7W1_kiqvwB=Vf9aAQ@mail.gmail.com>
 <f8f27bc3-83ce-4ccf-ae38-a43188b2ebc5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8f27bc3-83ce-4ccf-ae38-a43188b2ebc5@oss.qualcomm.com>
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

On 02/10/26, Pierrick Bouvier wrote:
> On 10/1/2026 9:28 AM, Yonggang Luo wrote:
> > On Thu, Oct 1, 2026 at 11:55 PM Anton Johansson via qemu development
> > <qemu-devel@nongnu.org> wrote:
> >>
> >> Moves initialization of satp and mxl fields to a class initialization
> >> function that checks target_riscv64().
> >>
> >> Note: I'm aware the current iteration of this patch is rather hacky, I
> >> don't like the introduction of runtime_misa_mxl_max, but I'm keeping
> >> this in to get the series out there and collect feedback.
> >>
> >> Signed-off-by: Anton Johansson <anjo@rev.ng>
> >> ---
> >>  target/riscv/cpu.h |  1 +
> >>  target/riscv/cpu.c | 90 +++++++++++++++++++++++++++++++++++-------------------
> >>  2 files changed, 59 insertions(+), 32 deletions(-)
> >>
> > 
> > This patch is how I handle these, just for reference, not a review.
> 
> Yonggang approach looks cleaner, I would favor this one.

I'm personally not a huge fan, it still feels rather hacky. Why add a
completely new RISCVCPUDef::target_init just to make sure fields are
initialized before riscv_cpu_validate_misa_mxl()? Wouldn't moving the
check to a later point, maybe .instance_init, be better? Then for
riscv_cpu_init() we get

  riscv_cpu_validate_misa_mxl(mcc);
  env->misa_mxl = mcc->def->misa_mxl_max;

misa_mxl_max would be verified only during instance rather than
class initialization, which seems like a decent tradeoff for a simpler
solution.

-- 
Anton Johansson
rev.ng Labs Srl.


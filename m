Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C252D7878A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 15:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWcLb-0001cs-Ro; Fri, 19 Dec 2025 10:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vWcLa-0001bz-1U
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 10:24:50 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vWcLY-0001en-Hl
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 10:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=rvIOmWKKteYFxcxqy76DtqNO/DRpOwiCshi3g+ts2wM=; b=KFm/G3hSsuD4NhC
 9AxU99OffWhyA6SV2qazjSg/dvPAC1XCF12bloUIWsBqDKzXuzU90mfhyMIVi9TgGlg9oubOU3+mV
 4aes5HebiUx2E+XgfFHIeK1xVNPQ/NpqHxwNcpxHZE7xWL0izrSE7wGtOIJYB4XnDa1RexnEL9fTn
 V8=;
Date: Fri, 19 Dec 2025 16:27:56 +0100
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com
Subject: Re: [PATCH 07/14] target/riscv: Replace TYPE_RISCV_CPU_BASE
Message-ID: <owv5bslwggdhicnomhxrdpxaom76v6ux2gtla2ocwovqqgb3vc@kner23aosqmx>
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-7-d24a4048d3aa@rev.ng>
 <72480685-f451-496a-a3c7-03d8d82a58fb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72480685-f451-496a-a3c7-03d8d82a58fb@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 17/12/25, Pierrick Bouvier wrote:
> On 12/16/25 3:51 PM, Anton Johansson wrote:
> > TYPE_RISCV_CPU_BASE is used only to initialize the correct default
> > machine for 3 machines. Replace it with a runtime check.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   include/hw/riscv/virt.h         | 11 +++++++++++
> >   target/riscv/cpu.h              |  6 ------
> >   hw/riscv/microblaze-v-generic.c |  3 ++-
> >   hw/riscv/spike.c                |  3 ++-
> >   hw/riscv/virt.c                 |  2 +-
> >   5 files changed, 16 insertions(+), 9 deletions(-)
> Using directly class->default_cpu_type instead of callback
> class->get_default_cpu_type() works here compared to hw/arm/virt because
> default cpu type does not depend on accelerator used, and we already will
> know what would be the runtime target at this point.

Ah I see, appreciate the context!:)


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAA1E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 12:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt33g-0001rc-26; Thu, 19 Feb 2026 07:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vt30K-000706-1Z
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:19:37 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vt30H-0003uy-Ue
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Rhb+9xezX/8bnrHkCX6f43dyJD2tWxWJp/K27LCC/UM=; b=hxtJ73vWLjWgUVa
 QFHlJSM+0NQ0Dx8z1llO19g+4UYgRdaImyrOEr+/6lG7GAvn0gnllG+2eac2iqvkNDQlVK4fIyM/P
 ik6P/ykFIQ8oA6qQADBtKYc297IK609AT2KKYEb84o0/YCqaJWd6h/8vldzMOtmJqqrVvX/vglJ/T
 Z0=;
Date: Thu, 19 Feb 2026 13:23:00 +0100
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 4/4] hw/hppa: Add emulation for the 64-bit A400 server
Message-ID: <aZb_DyARtND6sIat@hive.localdomain>
References: <20260218201221.20958-1-deller@kernel.org>
 <20260218201221.20958-5-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260218201221.20958-5-deller@kernel.org>
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

On 18/02/26, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The A400 machine is the very first 64-bit-only machines which uses the 64-bit
> PAT firmware and desn't support 32-bit PDC any longer.  Long-term goal is to

                   doesn't



> support the MPE and HP-UX 11iv3 operating systems, which both require a machine
> with PAT firmware.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/hppa/machine.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Anyway, nice! I'll rebase my series then.

Reviewed-by: Anton Johansson <anjo@rev.ng>


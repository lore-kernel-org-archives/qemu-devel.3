Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1526FCD4F5E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNVV-00087c-20; Tue, 19 May 2026 12:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wPNVC-00086v-5x
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:41:07 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wPNVA-0005qv-Dy
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=SAsP1q8KEcu2kqrT3UX0B6YzhbM06Rt8yPVprS9d6CI=; b=pnnxlQVd2mZNPqR
 /sTHLk7NhDq+TbFmzpLjgP7nGr0CdbQMB+qwWlxSoCdjA5j515YWdhqQE1UxPRArtZjlqUN8/GBlN
 NidSl/aUPZ06otsTLM8ISLlPfDpzeCwFSr7HERkVF9Uq9Yi31Q00mPcCtggNwqSYnnSnNQaaj5/H4
 OI=;
Date: Tue, 19 May 2026 18:45:37 +0200
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com
Subject: Re: [PATCH v6 00/27] single-binary: Make riscv cpu.h target
 independent
Message-ID: <agyQqYrIfNDPFxq4@hive.localdomain>
References: <20260515180437.23620-1-anjo@rev.ng>
 <CAKmqyKMZWH0cBp4gNoVpM-emEb4-BEvUb5BdBAFpc+XRB3kF+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMZWH0cBp4gNoVpM-emEb4-BEvUb5BdBAFpc+XRB3kF+Q@mail.gmail.com>
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

On 18/05/26, Alistair Francis wrote:
> On Sat, May 16, 2026 at 4:02 AM Anton Johansson via qemu development
> <qemu-devel@nongnu.org> wrote:
> >
> > Hi,
> >
> > this is a first patchset moving towards single-binary support for riscv.
> > Additional patchsets for hw/ and target/ are based on this one so it's
> > best to make sure the approach taken is ok.  Most patches in this set
> > concern fields in CPUArchState which are either widened (usually to
> > uint64_t) or fixed to a smaller size which handles all use cases.
> >
> > General purpose registers and fields mapped to TCG are dealt with by
> > widening the type and applying an offset to tcg_global_mem_new() to
> > correctly handle 32-bit targets on big endian hosts.
> >
> > Quick question to correct my understanding. AFAICT riscv64-softmmu is a
> > superset of riscv32-softmmu which handles 32-, 64, and 128-bit ISAs, so
> > concerning single-binary do we for the time being only need to support
> > riscv64-softmmu?
> 
> That's mostly right.
> 
> In an ideal world there would be no riscv32-softmmu, just a
> riscv64-softmmu which could handle all bit lengths.
> 
> There are currently corner cases where riscv64-softmmu doesn't work as
> well for 32-bit bit (I heard GDB debugging a 32-bit guest either
> doesn't work or has problems).
> 
> But focusing on riscv64-softmmu with the goal of dropping
> riscv32-softmmu in the future is fine with me
> 
> Alistair

Thanks for the clarification! Do you know if there's any performance
regression to running 32-bit code under riscv64-softmmu? I assume
there's more extensions/truncations?

-- 
Anton Johansson
rev.ng Labs Srl.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57527CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRgW-00031l-7Y; Mon, 27 Oct 2025 14:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRgU-00031O-GC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:11:10 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRgN-00035y-3X
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=wTzrWEl196YCnWFNLxxsg+B/W/yAGbS9+wI4PHj4gmU=; b=aFi0FcKWYsRIHra
 hMBhFd4DB28tpKinjB8nOAeHKo11lnZuV9WObAemGgNexF5Hnt4LdC2+5khCTnJ8M1yv/pUfMK2zl
 EUwro9HR103041xEFwq9kfJ2Dq22amT62F2kVV5IKWE9ZuFX7RMGljkjPJiS30FcPclRK7e9uxA5M
 cM=;
Date: Mon, 27 Oct 2025 19:13:51 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, palmer@dabbelt.com
Subject: Re: [PATCH v2 1/3] hw/riscv: Use generic hwaddr for firmware
 addressses
Message-ID: <dbckje34qpaiwaqz5kafl73fwia7m7fpspk7kkudeea56z7gml@fqedf4dblk4i>
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
 <20251027-feature-single-binary-hw-v1-v2-1-44478d589ae9@rev.ng>
 <2d408ff2-5f5c-4de9-a33b-904a25496b8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d408ff2-5f5c-4de9-a33b-904a25496b8b@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 27/10/25, Philippe Mathieu-Daudé wrote:
> Typo addres[s]ses ;)

Ah dang!

[...]

> >   void riscv_load_kernel(MachineState *machine,
> >                          RISCVBootInfo *info,
> > -                       target_ulong kernel_start_addr,
> > +                       hwaddr kernel_start_addr,
> 
> but can we have this single change in a distinct patch please,
> so we can better describe it than "firmware address" and it
> doesn't block the rest?

Of course will do, thanks!


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AC8D2502F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 14:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vewAR-0002M6-Tz; Sun, 11 Jan 2026 09:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vewAP-0002LR-PE; Sun, 11 Jan 2026 09:11:41 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vewAO-00028l-1r; Sun, 11 Jan 2026 09:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=ioG69/GtrWYK1SDvXNBCpr0/tF+/m/pe5JE6q8DF188=; b=BKDMHQNS+rpd0hAB
 kMOUSQBdfEndwxEz39ARIAWZiSRD4PmIGxiUmmK0YFRfgi5zky2pmZMILlPtgYbK1CiYQt1Cd7KX+
 hYo8AVwqeGlVLU2iEPwAMHUdUzZKhLtVTDb+SfnPnYVEh72ASuMCKw87whvXu25P929IpmLCTGo/S
 Dwmqo8IMt2ZBpqz6paWzp2dSb4dMrnatgwjmLuHlcI/Xo8kpj8F1aRi1cRlntEo6ox/Ve30bRBFiH
 IKv2BrooisymFgsCgAD0UQSxIRCoOWNcMyb3UB6P9e2hIjuEayMamNcyp3AV1iVg2u3trB770enAM
 5n1NDvLo09Ugo4CqrQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vewAF-0000000DtGN-1OrJ;
 Sun, 11 Jan 2026 14:11:31 +0000
Date: Sun, 11 Jan 2026 14:11:31 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Max Filippov <jcmvbkbc@gmail.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] monitor/hmp: Reduce target-specific definitions
Message-ID: <aWOvk527PkZzLtSp@gallifrey>
References: <20260107182019.51769-1-philmd@linaro.org>
 <20260107182019.51769-3-philmd@linaro.org>
 <87jyxsczyk.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyxsczyk.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 14:06:23 up 76 days, 13:42,  2 users,  load average: 0.16, 0.04, 0.01
User-Agent: Mutt/2.2.13 (2024-03-09)
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > From "monitor/hmp-target.h", only the MonitorDef structure
> > is target specific (by using the 'target_long' type). All
> > the rest (even target_monitor_defs and target_get_monitor_def)
> > can be exposed to target-agnostic units, allowing to build
> > some of them in meson common source set.
> >
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> The only use of the ->get_value() callback I can see is in
> get_monitor_def(), to implement HMP's $register feature.  I can't see
> the callback being set.  Is it dead?

I think I see that being used in ppc;
target/ppc/ppc-qmp-cmds.c

const MonitorDef monitor_defs[] = {
    { "fpscr", offsetof(CPUPPCState, fpscr) },
    /* Next instruction pointer */
    { "nip|pc", offsetof(CPUPPCState, nip) },
    { "lr", offsetof(CPUPPCState, lr) },
    { "ctr", offsetof(CPUPPCState, ctr) },
    { "decr", 0, &monitor_get_decr, },
    { "ccr|cr", 0, &monitor_get_ccr, },
    /* Machine state register */
    { "xer", 0, &monitor_get_xer },
    { "msr", offsetof(CPUPPCState, msr) },
    { "tbu", 0, &monitor_get_tbu, },
#if defined(TARGET_PPC64)
    { "tb", 0, &monitor_get_tbl, },
#else
    { "tbl", 0, &monitor_get_tbl, },
#endif
    { NULL },
};

those monitor_get_* functions are that get_value() aren't they?

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


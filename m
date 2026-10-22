Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37403606A328
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=treblig.org header.i=@treblig.org header.a=rsa-sha256 header.s=bytemarkmx header.b=OKFBh8DM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK2Iy-0006HW-AB; Thu, 22 Oct 2026 19:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1xK2Iw-0006HF-Ei; Thu, 22 Oct 2026 19:34:38 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1xK2Iu-0006rg-Ia; Thu, 22 Oct 2026 19:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=J+CdFJ+T5/iPYV5+nMs5ZJs/SnS81MtldlylrX1bu+I=; b=OKFBh8DMHVKCF+vF
 khMdazGtsjUU+WyZWSGlDb0YDfMjKGniRXaviZrHeFXYcze/RwL0US+9ljIIBYIh5gjF/bEap2XlV
 cLCfNCgj4sSMlvYsijY3Ky8HLPuNNJF/QnLfmdlpHmfxE2zXefQwjLp6lJRQHReSITymQtdwVXIDz
 RkuiyQkJKDq7J9Co4B/JlyWJW2X7bmfsl33NAocmMK7bwEE7tfKy9Sf4ZtS2xESvR4Y3BeJgag38b
 MQBgO1pJM5E3Lvg/ksND8XbSOsGAoxgiG/DYn/+d4i1qYXhBqh3yWTsrkzFcbww7Ff41JR0eg3E7J
 bMp4LPBOoTNR783LFg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1xK2Ii-00000001zA1-484R;
 Thu, 22 Oct 2026 23:34:24 +0000
Date: Thu, 22 Oct 2026 23:34:24 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3 11/18] target/i386: drop HMP $pc
Message-ID: <atqdgESEVhYYsz5e@gallifrey>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
 <20261022-query-reg-v3-11-7ad902b9a7cf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022-query-reg-v3-11-7ad902b9a7cf@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.113+deb13-amd64 (x86_64)
X-Uptime: 23:23:42 up 6 days, 8:44, 2 users, load average: 0.01, 0.02, 0.00
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* Marc-André Lureau (marcandre.lureau@redhat.com) wrote:
> The to be deprecated MonitorDef provided a synthetic $pc alias on
> x86 (which begin as an $eip alias). Preserving it requires x86-specific
> semantics (CPUClass::get_pc() omits the historical truncation).
> Use $eip or $rip instead, adding $cs.base as required.
> 
> It was never a documented feature, HMP is not a stable API, x86-only,
> and the replacement ($rip/$eip + $cs.base) is arguably more correct.
> Nobody asked for a deprecation window on ML either.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

<snip>

> diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
> index a523dbb446ce..b3f8fd58612d 100644
> --- a/tests/qtest/test-hmp.c
> +++ b/tests/qtest/test-hmp.c
> @@ -58,7 +58,6 @@ static const char *hmp_cmds[] = {
>      "object_del mem1",
>      "one-insn-per-tb on",
>      "pmemsave 0 4096 \"/dev/null\"",
> -    "p $pc + 8",

That leaves us with no test of the 'p' command, and no test of reading
a register.
Given how much you're changing accessing the registers you
should still have a basic test by the end.

How does this test work on S390 where 'info registers' shows
NIP but 'p $pc' works but 'p $nip' doesn't?

I assume gdb also has some concept of a 'pc' at it's end?

Dave


>      "qom-list /",
>      "qom-set /machine initrd test",
>      "qom-get /machine initrd",
> 
> -- 
> 2.56.0.116.g6de20f6092dc
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


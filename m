Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBD7C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 16:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpUgy-0000Cv-Nf; Tue, 04 Mar 2025 11:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tpUgl-0008VQ-RI
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 11:00:15 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tpUgZ-00048Y-BU
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 11:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=smIvdHf/6nwNQp3+Ih/cg0k/JFgEiTixy8bZ2FZYKC4=; b=JxOsNxn7tdXhR9p
 vVbMTvA5Z4huUU3g2rsvHYnl8vTk1pa72opEEsxYAMlpd6jNctZsN6LjrU8TS2Kf8qDZQaZYLDdGY
 Z6+Iq3mzeVzp7eYi1yO1uo0F3cIyN50F8r0SDLt9dCiBf5Ftxzda5aua5hXMdLo67EFEef7y1Sxqr
 s4=;
Date: Tue, 4 Mar 2025 16:59:53 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 ale@rev.ng, richard.henderson@linaro.org, quic_mathbern@quicinc.com, 
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com, alex.bennee@linaro.org, 
 quic_mburton@quicinc.com, sidneym@quicinc.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/8] target/hexagon: add build config for softmmu
Message-ID: <jetaxporncldan2t5bei2nqsskahysqcumflsarxhe6xcrn5k6@jujafnmkfqbx>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-7-brian.cain@oss.qualcomm.com>
 <d95ebf5d-c1f6-42c5-8aeb-65764fa87125@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d95ebf5d-c1f6-42c5-8aeb-65764fa87125@linaro.org>
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

On 04/03/25, Philippe Mathieu-Daudé wrote:
>
> On default macOS I get:
> 
>   Program bison found: NO found 2.3 but need: '>=3.0' (/usr/bin/bison)
> 
> Fixed by installing via brew and:
> 
>   export PATH=/opt/homebrew/opt/bison/bin:$PATH
> 
> > @@ -401,3 +409,4 @@ analyze_funcs_generated = custom_target(
> >   hexagon_ss.add(analyze_funcs_generated)
> >   target_arch += {'hexagon': hexagon_ss}
> > +target_system_arch += {'hexagon': hexagon_softmmu_ss}
> 
> But then I get:
> [1/1980] Generating target/hexagon/idef_parser_input.preprocessed.h.inc with
> a custom command
> FAILED: target/hexagon/idef_parser_input.preprocessed.h.inc
> target/hexagon/idef-parser/prepare target/hexagon/idef_parser_input.h.inc
> -Itarget/hexagon/idef-parser -o
> target/hexagon/idef_parser_input.preprocessed.h.inc
> target/hexagon/idef_parser_input.h.inc:1:10: fatal error: 'macros.h.inc'
> file not found
>     1 | #include "macros.h.inc"
>       |          ^~~~~~~~~~~~~~
> # 1 "target/hexagon/idef_parser_input.h.inc"
> # 1 "<built-in>" 1
> # 1 "<built-in>" 3
> # 423 "<built-in>" 3
> # 1 "<command line>" 1
> # 1 "<built-in>" 2
> # 1 "target/hexagon/idef_parser_input.h.inc" 2
> 
> 
> J4_hintjumpr(in RsV) {
>     {fHINTJR(RsV);}
> }
> 
> J2_loop0r(in RsV, riV) {
>     { fIMMEXT(riV); fPCALIGN(riV); fWRITE_LOOP_REGS0( fREAD_PC()+riV, RsV);
> fSET_LPCFG(0); }
> }
> [...]
> 
> $ find . -name macros.h.inc
> ./target/hexagon/idef-parser/macros.h.inc
> 
> $ cat target/hexagon/idef-parser/prepare
> #!/usr/bin/env bash
> ...
> # Run the preprocessor and drop comments
> cpp "$@"
> 
> $ which cpp
> /usr/bin/cpp
> 
> $ cpp --version
> Apple clang version 16.0.0 (clang-1600.0.26.6)
> 
> Since this works on Linux for user emulation, I suppose this is a
> macOS vs Linux issue with default cpp command line arguments...


Hi Phil,

yes this is an issue of default arguments added by cpp on mac, I ran
into this a little while ago on a downstream fork.

cpp on mac expands  clang ... -traditional-cpp which alsos break
macro concatenation..

I carry a patch which:

* Removes indent pass on idef-parser output, as indent is not available
  on mac;
* Replaces cpp with ${compiler} ... -E ... where compiler is gotten from
  meson.

I'm a bit sad about the default meson version being outdated though..:(

-- 
Anton Johansson
rev.ng Labs Srl.


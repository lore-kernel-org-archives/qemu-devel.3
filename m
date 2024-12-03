Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCA6E74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIY3o-0004xC-H7; Tue, 03 Dec 2024 13:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIY3i-0004uG-9o
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:55:44 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIY3g-0001Ki-Di
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=oHbrP/BozD/jXWwFZMeh9b/n5BqTPmqxwWpXUyYO/L8=; b=u6rZEWqV6K4ss3F
 Ib7xgms3pmzaah/buMwOy5Zq/joHGKsKJ7YJ/GC/ZkVk6tDHAgYRh5bw1jwpTy6Mf/LhWLln8LZDI
 KnoFc0GdloQZL0kgfVdn1BnKO+o2Y3ByMLS25ND0E/FJCKPJtcKd6D4hkmPsFUhjRIUeAib/VFIMI
 GI=;
Date: Tue, 3 Dec 2024 19:58:43 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, 
 bcain@quicinc.com, richard.henderson@linaro.org, alex.bennee@linaro.org, 
 Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH v1 00/43] Introduce helper-to-tcg
Message-ID: <drtoe2le3d3ewaefgo6c5tsmvi3mkwwgoikv5iw5n4ivnwox4l@4zwasgbjv4pq>
References: <20241121014947.18666-1-anjo@rev.ng>
 <73638525-4f0d-45a1-bdf8-f271fcc015d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73638525-4f0d-45a1-bdf8-f271fcc015d0@linaro.org>
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

On 25/11/24, Philippe Mathieu-Daudé wrote:
> On 21/11/24 02:49, Anton Johansson wrote:
> 
> >   create mode 100644 subprojects/helper-to-tcg/README.md
> >   create mode 100755 subprojects/helper-to-tcg/get-llvm-ir.py
> >   create mode 100644 subprojects/helper-to-tcg/include/CmdLineOptions.h
> >   create mode 100644 subprojects/helper-to-tcg/include/Error.h
> >   create mode 100644 subprojects/helper-to-tcg/include/FunctionAnnotation.h
> >   create mode 100644 subprojects/helper-to-tcg/include/PrepareForOptPass.h
> >   create mode 100644 subprojects/helper-to-tcg/include/PrepareForTcgPass.h
> >   create mode 100644 subprojects/helper-to-tcg/include/TcgGlobalMap.h
> >   create mode 100644 subprojects/helper-to-tcg/meson.build
> >   create mode 100644 subprojects/helper-to-tcg/meson_options.txt
> >   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
> >   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/CanonicalizeIR.cpp
> >   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/CanonicalizeIR.h
> >   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.cpp
> >   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/IdentityMap.h
> >   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
> >   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.cpp
> >   create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.h
> >   create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.cpp
> >   create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.h
> >   create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.inc
> >   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgEmit.cpp
> >   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgEmit.h
> >   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgGenPass.cpp
> >   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgGenPass.h
> >   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.cpp
> >   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgTempAllocationPass.h
> >   create mode 100644 subprojects/helper-to-tcg/passes/backend/TcgType.h
> >   create mode 100644 subprojects/helper-to-tcg/passes/llvm-compat.cpp
> >   create mode 100644 subprojects/helper-to-tcg/passes/llvm-compat.h
> >   create mode 100644 subprojects/helper-to-tcg/pipeline/Pipeline.cpp
> >   create mode 100644 subprojects/helper-to-tcg/tests/cpustate.c
> >   create mode 100644 subprojects/helper-to-tcg/tests/ldst.c
> >   create mode 100644 subprojects/helper-to-tcg/tests/meson.build
> >   create mode 100644 subprojects/helper-to-tcg/tests/scalar.c
> >   create mode 100644 subprojects/helper-to-tcg/tests/tcg-global-mappings.h
> >   create mode 100644 subprojects/helper-to-tcg/tests/vector.c
> 
> Just wondering, could we name the subproject C++ headers using the .hpp
> suffix to have checkpatch easily skip them?

Oh sure, not a problem.
//Anton


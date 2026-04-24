Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA0CFB44C6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBC3-0002HQ-8f; Fri, 24 Apr 2026 03:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGBBz-0002D0-AW
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:43:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGBBx-0004dm-N0
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:43:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d7213b6ebso4942549f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 00:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777016592; x=1777621392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=14KuYVGLmHAuezwvtJ6LG5O4sa7Z0ECI6R6C8/0j3nY=;
 b=r9ztRLee6Ib6m/POAUib2enagsdqtTbPauB8x+2Zh+1iLeS4zYIwROb6jISwgAcxdp
 0EY1LqBe/Gs9EOOGV/pk7BdBdg5s6UaZgSZwdkEpxibu+F+Lcz5rkrHsPYGCt/qDzeOW
 SG7g+YTyAfeciDpzbO9fvc2wuRLKRxe73soT37FYh3hRlHj4bdu1XU9ApDbQVgN61rEe
 ++j5vMb5w2zw3GcKl4dRygPEIK62A8Ue8eJ3rLibhF11l81xd4bybidaLIXMiS4oJyJK
 3lugnFY6ZQ9LEd8MyEbiMO4hOCy/q/ETVCSuWHMI5LoUwrtrzh9GSos9Cd29qL2Zjnbn
 J8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777016592; x=1777621392;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=14KuYVGLmHAuezwvtJ6LG5O4sa7Z0ECI6R6C8/0j3nY=;
 b=tMPMZTCGaJaRksyHbmKspznSEnfjmVcqW1TtOgjLvHrZ+wwbfrXMapiraK/L4RtZkD
 iR+EHknDPDWgup070sRrTSSbJk0WFBRX4kiumisW2ndZFimE7iux1wDYwxmUM/eaDcgO
 pTZWi3ITO1OGpOhEIiwaFZDovIkaKZ3ifNTd/XQrxb78dssqTk28HRjSVT8ARY3KM7HV
 mB+lnK3CkiIdmlICjTxWkYNgDFH9PV8jWGUOLalGj8gwckonSZGsr7dHTrzx1wKo3prg
 E89TN5uOrtWDV2LsOy1Xkbe4dIvGsv7iUmX4DQnYd/Gowc+nRqJVNsCwnhhoKvv6hrAG
 8ERQ==
X-Gm-Message-State: AOJu0Yx13d4ADpccZe8ZMYHec3OaLWOTDKoBHIoUlMkhf6946DJgARpX
 hccZsO5cKINkgHgTfuIYSkPalBF1JzkHtrZ27nYGWD8O6AfxQ9d/R17djs7i2Ds7WA3TTBsdOfP
 vI3yxvLo=
X-Gm-Gg: AeBDiettiJqK0mTkoVNBcnM+Vcm2BBDgXbvc6Jo1aB4El1ujMC7b43/CgXG94Mv6Gya
 qLjxZZp2cxu9ifcMucbJAwncOEY0olaUju3VpHdXdwduqtVX0TgOYZctxiv6VjyjKSBbN60SLq+
 JWuNiohI/mK2x4loobPnrYsATssoTCB2Dz898urtBTL+H02AmaDYxjKQsgmsJz+MdwbKhnbv2dx
 Pdi2frWotrI3VIlhwflWpr+IzUId9uKga2iFDx90wskr8Wr+M+V6FNWMHqk/8rcz8TSX8RD0rMH
 ci1A1Ljv0STORuF6mxIXVV4BQnbGFFZtIp/5np9G4DvsttpN0Su7xF0UgV26BoMFu5nPPFBeHGt
 rxt5SOpKUN7tm/id6hJdO2FPDtyTlbrgKj3Kdiq0DfAJAgHyp6HRaHj666Fw4maivGQvQQfwsXz
 TsxxzZuBcjihNn447/5WqGvuMHzewzyp6oBJhzoO6HMxvlFvs7Xh2xH2YyukWXOG44jsvqRrd3S
 oYzq8CKrtAHLRj6GDkhFWHy04WKwbDspGlE8zNc8EVsxQ+4fBAiMWMEtTuKIQ==
X-Received: by 2002:a05:6000:2308:b0:43f:e9e2:efac with SMTP id
 ffacd0b85a97d-43fe9e2f02amr41616689f8f.5.1777016591621; 
 Fri, 24 Apr 2026 00:43:11 -0700 (PDT)
Received: from meli-email.org (athedsl-338307.home.otenet.gr. [85.72.177.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb13a0sm58448505f8f.8.2026.04.24.00.43.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:43:11 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:41:21 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] contrib/plugins/uftrace_symbols.py: fix symbols
 reading
User-Agent: meli/0.8.13
References: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
 <20260423213838.780814-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260423213838.780814-2-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tdzmry.259an10v60tlz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 24 Apr 2026 00:38, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>When running this on hexagon binary, we observe some undefined symbols
>without any address or size.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---
> contrib/plugins/uftrace_symbols.py | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
>index 02d1221228c..895fa1a6b7a 100755
>--- a/contrib/plugins/uftrace_symbols.py
>+++ b/contrib/plugins/uftrace_symbols.py
>@@ -36,8 +36,8 @@ def get_symbols(elf_file):
>     out = out.strip().split('\n')
>     for line in out:
>         info = line.split(' ')
>-        if len(info) == 3:
>-            # missing size information
>+        if len(info) < 4:
>+            # missing size/address information

On a second thought, shouldn't this be != 4? Otherwise the unpacking 
will fail with ValueError: too many values to unpack (expected 4)

>             continue
>         addr, size, type, name = info
>         # add only symbols from .text section
>-- 
>2.47.3
>
>


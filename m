Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7D3606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=GbmEeW0G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VKuIwGzo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRo3d-0007pA-TQ; Fri, 13 Nov 2026 04:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRo3b-0007nW-9L
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:58:55 -0500
Received: from flow-a1-smtp.messagingengine.com ([103.168.172.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xRo3X-0004KM-Fj
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:58:54 -0500
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailflow.phl.internal (Postfix) with ESMTP id B7BF013821C9
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 04:58:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Fri, 13 Nov 2026 04:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1794563929; x=1794571129; bh=nVmYktA8t1eOd53iv0UrOPA7DSnRVRWa
 HMJpT2eQqDI=; b=GbmEeW0Gywhzb36A9qe2N4oGRkWxL1B22wKVfqYL0EC80xLl
 sKixfRrOrAcpWAnRGgSoFJjTElkV3HGATBUSsryTgFlVmVWl9HerkSihfT8DfbTi
 r1guW0g2Ld3eALxxSyC+QOhUCmpuaYz9o7AcYWPmaKaP6xukJIiVYmipGcwDx8TU
 xWnrbNwflh18ZKf4CL2Am8h8b7bpmEtWJYL3BwtapZHIoeyEn0rXfciyci6LW5B0
 p5XCwTQt9hSEYSE6hid48gOL8IxT1aiyq/ToeWeLgkeCeM12yT+wsJlkuds73jq7
 sami+b10QtwWoiHNQpWBjAuty0wM9P7vSI9wRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794563929; x=
 1794571129; bh=nVmYktA8t1eOd53iv0UrOPA7DSnRVRWaHMJpT2eQqDI=; b=V
 KuIwGzoXnjMcFZ0Cv626wG9gNsE3sjOjggpZTuHmkoyGZahyLiBlC/gE4XfkicOZ
 864eroKe46SR2Inqnrlfg9fgjeCmN9Bg01PsuSm/3KTcD4edzgEHNLN6ZlYLiYtE
 6QULau74wuNN2cqVbkHnwLNIdOAJDb8CU2vVSEukAon/EPzcGdiVemRfxaPWbGlu
 Hv2D3BAcIpEJ3iWHkXkbEYciFQQBviJBMCWdL8CIEjR1Z5gNVepl1ixs64/fVAlG
 ZGkK0c01bCIaHTHEIdV2cDqK4XGE/JnfKhVNicE4M7o2OALxnJEfQ8b0ianakPQH
 IzfV4gg95byJIE22gleqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794563929; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:E36WeUldzw5O9xmvPneH4k5EW+88/3y9t9zpMkquk3Oxrci
 iw48FcQvTXnBh1lLFEKCiOw27dv5sgkNMikINnLU5XeulPF8/cTZu3kFoNvK+0NQ
 /zysUIeFToUXd9CYtHx7HYE8hWKjEBGOloA5ukgrfhG2AQL2c+uskWqbhtfq/TTD
 loo3NfEp5V4AZGrnXU+UAkrSf7bAcmR3nkuElsvb+at0tt1VSmCrf7LliL13FuiF
 RxMSfHcPNCcaVva/Ip/vkg2MPJ5SR+Q3+RxHeQTIWTIvFBf7fp4dfj4SsjAoqONx
 2yHFDKsjkanTIkBBsM3h1/eg5ieVmB+kU5D6/IA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:3u6WUtEQAutfnDI64cIKqZxZsNFOhIJES/pL852DrvM=:H/MmiMwLsTOYRLtcqbbtct6AhL2xt+sRmnYl+/E/W58=;
X-ME-Sender: <xms:Wd_2ajhIxA0xIfbgTJ5Dmsvn17YIZipt-DuGhPi8UGnYTyJGJJovaw>
 <xme:Wd_2aq8uReicfZzlgPQKHSv2CO_TjI8R9c3lhd9wp-_BDnrCp95TGdYN29E33tFYF
 FhIQNz1qyNmjbHIud8FIf0PZJjUclvEcSNWNBygsfLBjaavNF07HjHH>
X-ME-Received: <xmr:Wd_2aiGRwuZKIZXXyxB42ZFwSQxMIoNrsZwJmbgW-hY3rMaJo2aCSJ_NXRaOlhPcmenUGIA6x_gjpXi1TPbfYGTD>
X-ME-Proxy-Cause: dmFkZTGoW/r+HHkPvpDPhLJ23+QC4nYba1HxO91KJlnQiR9zkGCwEYw+hslx7rW1vDbE4+
 kz5VFVK/snpzGpHFah5+BrQC5Odi347Kgy2Mlr5HAFrBCN6MezvbAWNNiSKcqirBY4p9YX
 Ku8dAAjbQsE4uZSQQ2Syh0wYsOxS/RAvnuRHNaXbbHga8A5xc+kCsfPUk9C/MLQ0RFzI+V
 28Zx/R3JCwUdoXIA8xPHpDV9qjOGPp4XXUOEV6BJxGO/m3rCoWoHVH2BcSg1+XollOGVCj
 rAyb3zo9XG9yafFAn9+wIglY5hkk3wGupF0KxnPeauCJX1uNNPPE5qwh7TjjzAKlG28qE6
 8s65zwI1GEr9/CFCQblC05kMRtq/ajGmzi49SzewJTjBID3zInbIsy3EBKHgBaoDvJGw5e
 fpxqD5ABdYcNSEqURabEOqk9NTRGbMCR9WC++bfdKcOxYlsIVDG20hh+SkkaOddsdD/HUR
 3uVFhCVyGmfmP4uR2q10Q1gGQ8DwkxzgelZ9hu87qrb3kpUzrlG8+46R7578AueA779GI/
 SY9gVou+lD6hLIk+0maSIR+3eliqyXIgjyxKtpHNjIx88Xun52lsA+XtSjEucTYsUdUYeo
 +KITeKsBcIKJceO4ed+qNEwmdfEJ2ADBzQMLUAfGmA+1WLhex7qG2JitkGjA
X-ME-Proxy: <xmx:Wd_2all1dXaQ4kJ7NCgTMPN5qY_C5IUYr3OO5e1SPQK3wG0Cn0FeuQ>
 <xmx:Wd_2aubIwD6HWCiFtnOPum6e4K6nGB_pai5K7Q52oov1CbkP6Rioyw>
 <xmx:Wd_2aiGcSyOiRBW9nuGtagW3UHKOgWuJIa7RWvDdqN6nOGUBtJedaw>
 <xmx:Wd_2anL0l8kxO4LPzEL2E2FxAqBrHw4Z30F3AhmZZyOBe_28Sv7C3Q>
 <xmx:Wd_2ankcOXFFrO5mUX5Cj-gjaQyqrr-_XHCwiSMGavp4Kp26zj95cWeT>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 04:58:48 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Fri, 13 Nov 2026 10:58:38 +0100
Subject: [PATCH v2 1/3] hw/nvme: reject fdp.runs smaller than the lba data size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-nvme-for-rc-v2-1-e458fd0e12ca@samsung.com>
References: <20261113-nvme-for-rc-v2-0-e458fd0e12ca@samsung.com>
In-Reply-To: <20261113-nvme-for-rc-v2-0-e458fd0e12ca@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=iNIXmPlJnOBBz/SNrN6gqSNgOkoUEOj6CpNh7QXtGck=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3IyMzFWUXV6NWV3Y1liWWZERG8xTEJyOGowClV3d0hUVUpQK2orLzdxMFVx
 U2ZTK0lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcTl0OVZ
 BQW9KRUUzaHJ6RnRUdzNwOTl3SC9SYjE5NjFxbUpNQmZZVWpCUHdsV1l3U1E4ZmIzd29OUFQ2Kw
 pvRGZ2NVJDU2NNMHY1RGNTUi9IWmxkU0szVzZpSTZmSkxmKzcwRE1aWWlBZ2NqUzJRVkF0L0R5T
 lYyVkd4Q0RvCkdtNWJGT3RoancyZVFjMXJmWGdxQTJPbVpMWEU5Tnh1RXVFQmhpSEZSRGVxVU16
 Q3VSSi9WRW5YQitUVXRWNWoKZE15MEpBSXB1c3g4Q2hVa1M2eGpIM1M5dW1RT0tGWDU5eG00T21
 3bXBMTzEvNmdvSUdBOFVEVjJoLy9RYzhoTgplUGY2RlRjQTZrMVp5R25qZUlRdk9qMHdsL0lLOD
 hFNk1WTnRLSnRLQmFUR2xJRnI5Zmtib21Da1Vwa3VOS1BDCnh6RTZRbE95NmZjOHNFRmFxYnVYN
 W81djNhMDFjenY2WTJFdlkwUlpMQVRGek9QZEcwOVo0cWZNCj1kcmY3Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.136; envelope-from=its@irrelevant.dk;
 helo=flow-a1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

The reclaim unit accounting in nvme_do_write_fdp spins forever if RUNS
is configured to be smaller than LBADS.

Reject such an invalid configuration upfront.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 2ae26a9acbd0..37d45bb4d533 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -485,6 +485,12 @@ static bool nvme_ns_init_fdp(NvmeNamespace *ns, Error **errp)
     char *r, *p;
     uint16_t *ph;
 
+    if (endgrp->fdp.runs < nvme_l2b(ns, 1)) {
+        error_setg(errp, "fdp.runs must be greater than or equal to the "
+                   "lba data size of the namespace");
+        return false;
+    }
+
     if (!ns->params.fdp.ruhs) {
         ns->fdp.nphs = 1;
         ph = ns->fdp.phs = g_new(uint16_t, 1);

-- 
2.53.0



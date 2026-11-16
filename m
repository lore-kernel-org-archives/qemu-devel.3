Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A68606A339
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KjB54yk2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSueq-0003yE-8e; Mon, 16 Nov 2026 06:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueG-0003pl-Mr
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:21 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueC-00028G-Cj
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:20 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-491971ac844so2911069f8f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827595; x=1795432395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jW4FwOrNyMRAp5MwOlDG5ApuPE9Vl4v1defYt6joA24=;
 b=KjB54yk2q9i6hE0/WuQUyeTE0gdmZaRodemN1SVoaRb0Xf/RrDVoY3FSZpI8nwGSIk
 AybVa1r+NbxwpR65cWgIbC9yW/Iim8fKXFTmcxB6AgfIAA9eKPx2e8efL80F3PD+bbUX
 H5zXWZAG+o28Z0vVFylovz9NzHx2P+YErhTidLMPE/jtcXQSphhRZ5uJxp0vNEWlQga6
 0BRo0DrFWRyO5oIN9K4nWCi4Qfk0y1rMEeTYewWV22KM3mshOYG/eCH+Hx+P86rpdNUC
 77QKonVjClTGAZ3uZDgvCkG9O1xl7RG54TQza15if0GPWRZmUu8C8mMvr0lVvF+Tt7SA
 G+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827595; x=1795432395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jW4FwOrNyMRAp5MwOlDG5ApuPE9Vl4v1defYt6joA24=;
 b=hzBZoJlIDKvAadSBiFhdtGDHoqFPRUmTWRy7AyYLuAKIyvMgfZ8dEIEVI0oixt6q6b
 yL6FEenvjcIUcuCVpZl/C3idLlfLLUwZ/1rj5UVKtGoOO54cqDrz2SylHkiLVdyA6x3k
 329Xq8DmtfPAE/q660BNJwYNarTEwNAIfcYD9DH3RShpL34QK3eEaeyl/AAfladnrbrb
 Ui6KSX16eqaL8QrWiddcfC/C7kLa3MGJN6s3DibzyIlppzZb2/VvGsi+u7M8ZMsQUQ88
 te9fY3+lwPEpKWx3mbcHZ+hrVokd+yi47E6pV1PMjBGpey2Uat30gntLLzOI4QhAPHS6
 N6ng==
X-Gm-Message-State: APuU4Z9OxU+psGUj6Kdyqu0/lUStjcRlJSybXmE9R76ekwP1Tm+a8Sn4
 Os6c3DqEbqrxy3ye+kVkj9OPcbZYuoNel+/Axz3uuvMqjpVS0TKoj90vQHBOMnk++Vrw3vCd5eI
 kC28JqxE=
X-Gm-Gg: AZFdTZfSHvrmzKgJUbDExRNYadEhaNEade+Ajy6wrQ66kdU0QabltAIJ+jKKnYfbs2V
 BRxeTW+fg1b4EHSrK00YTeipY5pKgZiTxBcF3WpDcB6GJ99Wct9C/HdJvPwRndl6ACATVcBuPRE
 vp9er2Xr3TQ8eRBqS2YriWwNOd4+Evkz43XEoVao5cqkiHrXjrdNrPXFsoP13Gmnr7wSyXdqmw1
 Yh+o0a4btuh21vsv0OgXyiI22FQ2M6FtLIw1HopNI/hMRz6ZEimO5HUnN7V3tNQHb3x3nr43Mww
 fISTBmzutAZyq2te34OcYp9NPkNacrWsxk9jcA6M79o9pk4WhWI2DCvFwKgfarb7moFaTFfFr7D
 Lee1GXUuyRVgd4ogundcXPOpfM7BODBPcCoFm/lvXs+jywkbEdt4mdcvOQBpf37nAoeDqpMvmWd
 URzu8Fakeo0ysV8IflQSoDtU/XoxEYc0xmbdn8k2eTjdH98gy0N4M/J68uI77uc7G5aRpQeqEOw
 5sn7Euu9xp0dnqWlVJ40ClGJLUuYKU2GGUDdMbvQGlBDjodbVYY3crO8LWbppg9cewNhyAl+Ovv
 j79uUMcD72QORExM8QMUoLQCEaNGHbI8IBI90eIckGY6zcJSIox1EQGaby6r/8txA6qTGqIPyDm
 UfH1PpKZ10nwNe6NT3BJOaWduSOgzfwQkxw==
X-Received: by 2002:a05:6000:2087:b0:488:57ad:d5c8 with SMTP id
 ffacd0b85a97d-49c6d453dbbmr27879732f8f.3.1794827594648; 
 Mon, 16 Nov 2026 03:13:14 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/33] include/hw/core/ptimer.h: Fix 'version' argument of
 VMSTATE_PTIMER
Date: Mon, 16 Nov 2026 11:12:39 +0000
Message-ID: <20261116111303.1692832-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The VMSTATE_PTIMER macro is defined to pass a 'version' argument of 1
to VMSTATE_STRUCT_POINTER_TEST_V.  This means that the field will
only be used in migration when the vmstate struct that uses
VMSTATE_PTIMER has a version_id of at least 1.  This doesn't match
how we define other VMSTATE_FOO which don't take an explicit
version_id, which is to use a version argument of 0 (e.g. all the
common macros like VMSTATE_UINT32 are written to pass 0 to their
VMSTATE_UINT32_V counterparts, and so on). It also doesn't match
how we define VMSTATE_PTIMER_ARRAY.

The practical effect of this is that users of VMSTATE_PTIMER in
vmstate structs which explicitly or implicitly have a version_id of 0
were actually not getting their ptimers migrated.

This affects:
 vmstate_xlnx_csu_dma in wh/dma/xlnx_csu_dma.c
 vmstate_k230_wdt in hw/watchdog/k230_wdt.c

which are used in:
 * Arm Xilinx versal and zynq machines
 * RISC-V K230 machine

Most ptimer users are unaffected because they took the usual approach
of explicitly setting their starting version_id to 1.

Fix the version_id in this field.  This is a migration compatibility
break for all the above listed devices/machines.  Since the timers
involved are in devices where the timer is usually stopped (e.g.  the
watchdogs only have the timer active when the watchdog is enabled and
counting down), the consequences of the bug are likely not visible to
most users.

We could perhaps attempt to preserve migration compatibility here,
but none of the affected machine types are versioned and so we do not
promise cross-version compatibility, so do the simple thing.  Bump
the version_id and version_id on the two affected vmstate structs so
that attempted migration between old and new QEMU fails cleanly.

Fixes: 852f771ec9e5c ("vmstate: port pmtimer")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4705
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20261106163657.3825938-3-peter.maydell@linaro.org
---
 include/hw/core/ptimer.h | 2 +-
 hw/dma/xlnx_csu_dma.c    | 4 ++--
 hw/watchdog/k230_wdt.c   | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/ptimer.h b/include/hw/core/ptimer.h
index 4dc02b0de47..8513f8917e3 100644
--- a/include/hw/core/ptimer.h
+++ b/include/hw/core/ptimer.h
@@ -300,7 +300,7 @@ void ptimer_stop(ptimer_state *s);
 extern const VMStateDescription vmstate_ptimer;
 
 #define VMSTATE_PTIMER(_field, _state) \
-    VMSTATE_STRUCT_POINTER_V(_field, _state, 1, vmstate_ptimer, ptimer_state)
+    VMSTATE_STRUCT_POINTER_V(_field, _state, 0, vmstate_ptimer, ptimer_state)
 
 #define VMSTATE_PTIMER_ARRAY(_f, _s, _n)                                \
     VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, 0,                   \
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index 436f9915e02..ea703dc00ce 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -679,8 +679,8 @@ static void xlnx_csu_dma_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_xlnx_csu_dma = {
     .name = TYPE_XLNX_CSU_DMA,
-    .version_id = 0,
-    .minimum_version_id = 0,
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(src_timer, XlnxCSUDMA),
         VMSTATE_UINT16(width, XlnxCSUDMA),
diff --git a/hw/watchdog/k230_wdt.c b/hw/watchdog/k230_wdt.c
index 1f83b499e82..fba2013b8f3 100644
--- a/hw/watchdog/k230_wdt.c
+++ b/hw/watchdog/k230_wdt.c
@@ -234,6 +234,8 @@ static const MemoryRegionOps k230_wdt_ops = {
 
 static const VMStateDescription vmstate_k230_wdt = {
     .name = "k230.wdt",
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, K230WdtState),
         VMSTATE_UINT32(cr, K230WdtState),
-- 
2.43.0



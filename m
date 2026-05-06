Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7D0CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcwa-0006Vv-Df; Wed, 06 May 2026 10:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwS-0006ED-5d
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcwP-0002Ec-NB
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48374014a77so77062165e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076570; x=1778681370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q4WjpvxxBANzYXoyOWgi5EeaV2D4FlJx0zSnbtFPWpM=;
 b=tm5Ya7cVL4wO8+CYCsZnNCMtIrZlLvzCErwbm4j6zxPuzpV9sJeXMPdsRyA77g1mVC
 wE2B/VBCRx327tkjCFEWVz/5AJn9zG90IckY+oiemrZI1HEGRVISLxFxLfrkcyM19qdD
 V8SZIka7aWFJMa35Sc0QeV/xQdy6FtP3i1NEci/zNMA+39ISWaV0lD8OtsXxkjML51Sv
 tdgM6xBTwlPG+G9yOvyk3m/F0/lykh5379sbOczRerGeCQtHg8VCNU1JCmVtZgKnqWYc
 7RaYOFwnqpP61KwWK9tWrdO3A4nTKaccy74quf1Svk+lfxQCje0fBwHylNTEOMPlfy3J
 4XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076570; x=1778681370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q4WjpvxxBANzYXoyOWgi5EeaV2D4FlJx0zSnbtFPWpM=;
 b=nQL7bFEg6deVkd8ct2zcUFa32pBzq2GkAOzFqaPuIOiKlDJubmGCyBNOWOHVtm2L7c
 wozlRxEqXFl3DUgtjl6KLzQthxzpioBwf0PTEqugRELuSdhwew2p0b3fwshnt+V9R6Kt
 jqTgbaZNbYXa/B2l97xMHSjB5Uo6ZBhkVUlZZPRVCIt67qUTOFwjyC2X77fQZrFekdZQ
 Gs4wluDGOcdYukwdjwy95DjI9IvIP4SQQ5NtrjFnRQK59TNSyP0tAJWBktkUb1EBIDMA
 WJUg3Zugh4RSfF+g7skxIkPvNFMAOPjEMOcpr2Uw7Uon3dVN4VlA1C+wHYPaEm3YfzJu
 939Q==
X-Gm-Message-State: AOJu0Yw8SlEe5NYAV6em2c9fvgrdq4VqysDCNX18uYNyI2muJeeWA47O
 mb8VUhXB+msI/gi/j2ISKr4fkvbVwfZZFM16XwG6JMG6piRCqez/+Dqsi4rII46hesxvOY2d2mC
 Bldb6myk=
X-Gm-Gg: AeBDietrbW5uUTRfHpeIMPa1PKnHE0/67VjlegGg+nh6rFbCjeeHlmdhvNmdvtmRP+a
 iAVVgA8V/QWW+4RctN16+58uvMpQNIbBacteLngJtFgURr/aPfVU9PirBlFZxi1PcO/0xZtlAhS
 dSA0hhvYcpJtMSEaH62snAivhS9SnrZkyv5EfsfNMVzn58yIapJXsHhMuArkaYCtbeQrPYxzzcW
 MOeQPxNSAGldCp5E+Shsv92Stxm2/ep3Imy8fONzgn/QzGdLjALos/tqRs8hnT4PkTNGFLQlD8X
 ZcspQXblIhmB+uFkLpWNVp2pEHvu73tjkAbM32xX7GW4FqeaxxSJOm85sB9+qDDGOOTXCdHwYNp
 crnibl/W0jDoW+vNcavJ2D0OHVD6vXrNZB5GuPZo+cKKkq97IZNFuybDWvsQlKBXt2RfzATafJZ
 7Rp2zkwmQW5wB/XbLblG9Jdopj5uyDM0+6iCIQwi3bP7LlnaJpDrC8GCSaCJRatrXot9W92MS4l
 oQyf+XwQw4=
X-Received: by 2002:a05:600c:4755:b0:48a:7b55:12a6 with SMTP id
 5b1f17b1804b1-48e51dd5ef5mr62345115e9.0.1778076570252; 
 Wed, 06 May 2026 07:09:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53147bc2sm28929625e9.6.2026.05.06.07.09.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:09:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 107/110] cocci: Do not initialize variable used by
 QTAILQ_FOREACH macro
Date: Wed,  6 May 2026 15:55:19 +0200
Message-ID: <20260506135524.20617-108-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The QTAILQ_FOREACH() macro, defined in "qemu/queue.h",
always assigns its iterator variable when entering the
loop. Remove the pointless and possibly misleading
assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260415215539.92629-5-philmd@linaro.org>
---
 hw/ppc/spapr.c                   | 2 +-
 hw/ppc/spapr_events.c            | 4 ++--
 net/colo-compare.c               | 4 ++--
 net/net.c                        | 2 +-
 target/s390x/kvm/stsi-topology.c | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 428b491a7df..d40af312fae 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3685,7 +3685,7 @@ struct SpaprDimmState {
 static SpaprDimmState *spapr_pending_dimm_unplugs_find(SpaprMachineState *s,
                                                        PCDIMMDevice *dimm)
 {
-    SpaprDimmState *dimm_state = NULL;
+    SpaprDimmState *dimm_state;
 
     QTAILQ_FOREACH(dimm_state, &s->pending_dimm_unplugs, next) {
         if (dimm_state->dimm == dimm) {
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 1a21ac7bbf8..ab23e3f477b 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -460,7 +460,7 @@ static void rtas_event_log_queue(SpaprMachineState *spapr,
 static SpaprEventLogEntry *rtas_event_log_dequeue(SpaprMachineState *spapr,
                                                   uint32_t event_mask)
 {
-    SpaprEventLogEntry *entry = NULL;
+    SpaprEventLogEntry *entry;
 
     QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
         const SpaprEventSource *source =
@@ -482,7 +482,7 @@ static SpaprEventLogEntry *rtas_event_log_dequeue(SpaprMachineState *spapr,
 
 static bool rtas_event_log_contains(SpaprMachineState *spapr, uint32_t event_mask)
 {
-    SpaprEventLogEntry *entry = NULL;
+    SpaprEventLogEntry *entry;
 
     QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
         const SpaprEventSource *source =
diff --git a/net/colo-compare.c b/net/colo-compare.c
index c356419d6a8..abc1326b704 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1396,7 +1396,7 @@ static void colo_compare_init(Object *obj)
 
 void colo_compare_cleanup(void)
 {
-    CompareState *tmp = NULL;
+    CompareState *tmp;
     CompareState *n = NULL;
 
     QTAILQ_FOREACH_SAFE(tmp, &net_compares, next, n) {
@@ -1407,7 +1407,7 @@ void colo_compare_cleanup(void)
 static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
-    CompareState *tmp = NULL;
+    CompareState *tmp;
 
     qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
diff --git a/net/net.c b/net/net.c
index a176936f9bc..2892f1730d1 100644
--- a/net/net.c
+++ b/net/net.c
@@ -653,7 +653,7 @@ static ssize_t filter_receive_iov(NetClientState *nc,
                                   NetPacketSent *sent_cb)
 {
     ssize_t ret = 0;
-    NetFilterState *nf = NULL;
+    NetFilterState *nf;
 
     if (direction == NET_FILTER_DIRECTION_TX) {
         QTAILQ_FOREACH(nf, &nc->filters, next) {
diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
index c8d6389cd87..301d41b68d2 100644
--- a/target/s390x/kvm/stsi-topology.c
+++ b/target/s390x/kvm/stsi-topology.c
@@ -285,7 +285,7 @@ static void s390_topology_fill_list_sorted(S390TopologyList *topology_list)
  */
 static void s390_topology_empty_list(S390TopologyList *topology_list)
 {
-    S390TopologyEntry *entry = NULL;
+    S390TopologyEntry *entry;
     S390TopologyEntry *tmp = NULL;
 
     QTAILQ_FOREACH_SAFE(entry, topology_list, next, tmp) {
-- 
2.53.0



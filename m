Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B40BCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfn6-0002SI-Ux; Mon, 05 Oct 2026 06:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmA-0002EM-5e
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfm8-0000ul-0M
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so15289945e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195505; x=1791800305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j4820QCIrYVrPZCmpkAS3lL2mCezM1T4rfhN7ttYHh0=;
 b=fm6PoKB+A8XMyS811EZRvU3l9dfqYCTHZLlmNAoUHrMDJKnJ3jascT0HeePv6H87X1
 XxfELkE4JPLO6Y6rIGpgx61r43rqsUSDszs5zBDaLdjbmLYK28Lo5wJ8RLsEnGYZ5S5w
 4ZbrsUbjCZFCaDNYTNTG/xm/B4k9b2crEX8yCWYCYVpl2va55f2mNCsdEQrMccZkWxIC
 t95PI49b58F8EEXtjEM2H1XPiv2dJ5+JGBipdtCjq+JCZcbqOTDizxVlBZnXfdC4ytmb
 lLQPkZ2k4HPnmy6AUs2foR5DPQLe76QUNWpaVeckviXYBo0XVicc0BrNliZQQN5QHItw
 kZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195505; x=1791800305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j4820QCIrYVrPZCmpkAS3lL2mCezM1T4rfhN7ttYHh0=;
 b=VhoMu/97ASUnIV/4fPHL1mP01ZngcbmyUUBVPSVasjycVeaPfaYu7n90wNnR97ReNg
 WFD//i4MZYYnIwu3V5mD7wK9EB6q+1nC5GkRMTNMDaXMPkaNR/jv1konnZpcqqpPPicM
 S1SP1i0EgTSQJWIpdjwk3aU9MFcrdodE5XkG5X5V9Xg9y8kK1Fk0+hpHP6XqbHIzlOup
 qr0JA2KMoN83pKqmUz8GQKtCTQJxPYmt51SfbvPJVy2qSzUzLV8Y2DL0cxvTuYQz8eaq
 12f+KhgfJ/8f4xyWQLRs1LStnAKCj4+gLlAdfL21iI7Ee2bGie/FaYysQM4rHZYGTymd
 Ztgw==
X-Gm-Message-State: AFuF++lV88KEtibd2cO251V10NQMfmaz90wP15vPhhsghhsN1PlNlOv0
 1fUIxjbza4hUcYJwgyjbl99GuMAwlhugZp3kwGDAE25ydRcipiNCGoKE758DFA==
X-Gm-Gg: AYBFou2JfaI4ygFX+L/Biff73ilufpxMRLNnHJ4vWT1+RnPvM4w8aH+8zDuzvNOmFkx
 YqpFIpSAsVlSWSS444I5Qf7Te9P0Rau7Teg96puqbyUbSijbUjnyWE2+HrrLORHoQAIJ7hRs4Vn
 x1WSL9/xWC97h0vASjClMPWBAOD7FwCQ4gO64jmO0Rw7dueUvsyrzDcAc8azgFVxKTvvrTvtKOX
 0eKJxsUz7cUfaqHn/9oEpCA33zNXwpQAPVAKMEkvqGjaB+AuXsHsnROTqw1kWlKc8xUbIME3dm5
 zKsPjQHIuT1K8Pux712xuDNUoXlwaSg1j175FJcLRXF3QxdWZd5/vCNbnaw4CCqivhCwmN1lWU1
 1k/MYmviA+/+JAVDVCJZTZyk6nbEcMh2wH4dtM2vo/xN9vIbI/3s4k8VIod6MjoXD94a9RVclOY
 l6medY3L3LE9RHq1hIKt880Fpeeh+SvgrDWiTRygClocKMxIj0gcTdy7u6Xmgz36ErruasHUOUJ
 nrX0kTkBCnqX9wAnTTdkLCvm/AYMhYcnkq7d6ZUzRaPWqfY
X-Received: by 2002:a05:600c:3485:b0:4a1:6916:798 with SMTP id
 5b1f17b1804b1-4a176ca18femr5639455e9.14.1791195504660; 
 Mon, 05 Oct 2026 03:18:24 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:23 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 04/31] hw/watchdog/wdt_imx2: Remove redundant attributes
Date: Mon,  5 Oct 2026 12:17:31 +0200
Message-ID: <20261005101800.10821-5-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Since WDT and WDE are write one once bits, their values always
correspond with their respective locked attributes. Thus, the attributes
are redundant. Take advantage of this observation to simplify the code.

Note that removing the attributes changes the vmstate structure which
constitutes a migration break. This is allowed since QEMU does not
guarantee migration compatibility for i.MX devices between feature
releases.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/watchdog/wdt_imx2.h |  2 --
 hw/watchdog/wdt_imx2.c         | 21 ++++-----------------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index fc01fc46e7..0bf2903959 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -84,8 +84,6 @@ struct IMX2WdtState {
     uint16_t wmcr;
 
     bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
-    bool wcr_wde_locked;        /* affects WDE */
-    bool wcr_wdt_locked;        /* affects WDT, cleared on POR */
 };
 
 #endif /* WDT_IMX2_H */
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index a15f452d48..e9cb5819e4 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -59,8 +59,6 @@ static void imx2_wdt_reset(DeviceState *dev)
 
     s->wicr_locked = false;
     s->wcr_locked = false;
-    s->wcr_wde_locked = false;
-    s->wcr_wdt_locked = false;
 
     s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
     s->wsr = 0;
@@ -156,24 +154,14 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
     switch (addr) {
     case IMX2_WDT_WCR:
         if (s->wcr_locked) {
+            /* WDZST, WDBG, and WDW are write-once bits */
             value &= ~IMX2_WDT_WCR_LOCK_MASK;
             value |= (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
         }
         s->wcr_locked = true;
-        if (s->wcr_wde_locked) {
-            value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wcr & IMX2_WDT_WCR_WDE);
-        } else if (value & IMX2_WDT_WCR_WDE) {
-            s->wcr_wde_locked = true;
-        }
-        if (s->wcr_wdt_locked) {
-            value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wcr & IMX2_WDT_WCR_WDT);
-        } else if (value & IMX2_WDT_WCR_WDT) {
-            s->wcr_wdt_locked = true;
-        }
 
-        s->wcr = value;
+        /* WDT and WDE are write one once bits */
+        s->wcr = value | (s->wcr & (IMX2_WDT_WCR_WDT | IMX2_WDT_WCR_WDE));
         if (!(value & IMX2_WDT_WCR_SRS)) {
             s->wrsr = IMX2_WDT_WRSR_SFTW;
         }
@@ -234,13 +222,12 @@ static const MemoryRegionOps imx2_wdt_ops = {
 
 static const VMStateDescription vmstate_imx2_wdt = {
     .name = "imx2.wdt",
+    .version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, IMX2WdtState),
         VMSTATE_PTIMER(itimer, IMX2WdtState),
         VMSTATE_BOOL(wicr_locked, IMX2WdtState),
         VMSTATE_BOOL(wcr_locked, IMX2WdtState),
-        VMSTATE_BOOL(wcr_wde_locked, IMX2WdtState),
-        VMSTATE_BOOL(wcr_wdt_locked, IMX2WdtState),
         VMSTATE_UINT16(wcr, IMX2WdtState),
         VMSTATE_UINT16(wsr, IMX2WdtState),
         VMSTATE_UINT16(wrsr, IMX2WdtState),
-- 
2.56.0



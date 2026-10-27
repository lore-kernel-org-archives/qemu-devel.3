Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3C606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=brRhb9ow
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiDi-0008Vf-Ph; Tue, 27 Oct 2026 10:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCa-0007Jd-QD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:31:05 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xLiCU-00058s-8S
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:30:57 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-93f269e335eso436853285a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111453; x=1793716253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p7WbNU0cpQP7rnZCYZ9mXiCyI9Be0mIvVXNIhPI6SwI=;
 b=brRhb9owMPPiFHAImM9t5HYI5UpHZXoYM22e4FIMj356CCU1XCzHcXw/hKwXPfrFBX
 9SbWsRW/9zGWU4Omvo08521HZKvfduqGKn9hLoAt79V5OXc+l+qVrYbGngApUXKI+U6Y
 SdGXd+FUBWI34clskNsmMCB+55+jYEq4Knm/zfb1fAiFwfMzT8k4HgMVfb+QMTkamBJW
 Nh5rU+CZVU95PrgXNpgDWRP0Z5/Z35/Xvova9IDqN3IEl1hM2TZSctx9oMBgSmgv8WOC
 WtJm58djPfR0itQwUpwBe4Zeaf2RLxbe/Y3OYMx88ezBJojd1wwhjQASDwn6v2epVEtI
 BKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111453; x=1793716253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p7WbNU0cpQP7rnZCYZ9mXiCyI9Be0mIvVXNIhPI6SwI=;
 b=NZ3H9cJdABIqDJMPJh4LL3iP1l3+bnb+AqXv5lPiKC4K82yq950NVTL2tQ+yHSq4r3
 XIuSPedaCriMifZkmBtuaqpRMFQj/Uu7YcgJjC4zFYgGOvLtE96fYPSr4tU2Gy4U/pSp
 3xhBrDJiSS7vWDIKRroUBpXgy9irRiLMfdjRYx5viKiDh4j1EHiFUwmkffGrrKYbeaeD
 21jXqH9u3thP5h+fbVnZwZcPl33TVUiRAd4mJZ4ZpymT7g21RJ2s9PPOe3R0PSyaCBLM
 tfeBDQkFkumSM7D8Q2u2SKbirmdLJ6dajXMjagb20aIy6DRCkO8juN25UuaBaDCrhKiz
 BjgQ==
X-Gm-Message-State: AFq9FYLipBVvELbyszONQm84kGOeTeLaFOZ9YLO/5cT9c51rVNTpmTpB
 64qCj2dQsfAmZcNgXCfFVYYnHCKXj5rqMpis5R15hI7fVNKeBDiO2VM17HcolP/P
X-Gm-Gg: AYBFou3rzm+CZRsv6+k6xD9dBGJaF7VE2p2osMdpGY/zwg6Rtok3gg0+vYRJH2uW5AT
 GjIqZ0TokPkJXXB/XtzB7cMhYFNwE1D+IBFkHoj+o6yBQ3c7xXVJBijkPiPyCvK5eZ3lNnErEkk
 ThEUHwOs5NJCqQSOaR4U6ILZ4g/ydCrEzjfhFogmREYowxGlHKkcDZgSecYF/9p+UV5JPnqCao9
 wVI6pRtZvv2A4VoRXoxARLqT77usf7kdhpk/dGfU8z/oO1E8CMXVv6zW8VtM06SvqVz5A/ckI8L
 QpJSCKqBQqJsThf6kC0Ch7e2O/LyVMM0fh3qmi7AkTQlm+g+cwbWOu32rw7CwVkZzPIBVnvalLY
 DDpc7AoBZm+mKW0gE3bou0lDDAfOWPX5fpaJlfuTfxzngUvSDBFUP+H6KB3srtqaK7NXWclMXZZ
 3b53IsFcOrxjKQVxLNh6QdrkqNdFp11lS6Mu89B2jG+mUPodE+brcpf102wNFs3gjH8JyXTqho3
 pTG+c48gSPrntKYNQdS1NlGkLM0n9/4fBmlM9BLnqEO3suWo1QH9xdTZATlGrg6HnQ2yKhzxhDi
 JrPT3jJsdnnyjlT9QZJ1+2NxR+e9Jw1yHJ92CgzhcAn27D0+ZB8=
X-Received: by 2002:a05:620a:4043:b0:93e:c12c:fbbe with SMTP id
 af79cd13be357-940ef9559b3mr1626960185a.75.1793111453092; 
 Tue, 27 Oct 2026 07:30:53 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:9872:3600:589:5f3a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0a78c06sm986400885a.35.2026.10.27.07.30.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 07:30:52 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v6 08/17] hw/net/bcm2838_genet: add GENET register structs,
 part 4/4
Date: Tue, 27 Oct 2026 10:30:27 -0400
Message-ID: <20261027143036.44973-9-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027143036.44973-1-marcelomanzo@gmail.com>
References: <20261027143036.44973-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sergey Kambalin <serg.oker@gmail.com>

Add the PHY "shadow" register structs (BCM54213PE PHY-specific
clock control, RGMII mode, LED, and expansion-block registers
accessed via the AUX_CTL/EXP_SHD indirection scheme) used by the
MDIO emulation added in a later patch.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/bcm2838_genet.h | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index fedfbde066..2c3c62a9dd 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -25,6 +25,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_HFB_FILTER_CNT      48
 #define BCM2838_GENET_HFB_FILTER_SIZE     128
 
+#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
+
+#define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT 256
+#define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT   256
+
 typedef struct {
     uint32_t rev_ctrl;
     uint32_t port_ctrl;
@@ -273,6 +279,32 @@ typedef struct {
     uint16_t rdb_data;
 } BCM2838GenetPhyRegs;
 
+typedef struct {
+    uint16_t reserved_0_2[3];
+    uint16_t clk_ctl;
+    uint16_t scr2;
+    uint16_t scr3;
+    uint16_t reserved_6_9[4];
+    uint16_t apd;
+    uint16_t rgmii_mode;
+    uint16_t reserved_12;
+    uint16_t leds1;
+    uint16_t reserved_14_18[5];
+    uint16_t _100fx_ctrl;
+    uint16_t ssd;
+    uint16_t reserved_21_30[10];
+    uint16_t mode;
+} BCM2838GenetPhyShdRegs;
+
+typedef struct {
+    uint16_t regs[BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE];
+} BCM2838GenetPhyAuxShdRegs;
+
+typedef struct {
+    uint16_t regs[BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT]
+                 [BCM2838_GENET_PHY_EXP_SHD_REGS_CNT];
+} BCM2838GenetPhyExpShdRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -284,6 +316,9 @@ struct BCM2838GenetState {
 
     BCM2838GenetRegs regs;
     BCM2838GenetPhyRegs phy_regs;
+    BCM2838GenetPhyShdRegs phy_shd_regs;
+    BCM2838GenetPhyAuxShdRegs phy_aux_ctl_shd_regs;
+    BCM2838GenetPhyExpShdRegs phy_exp_shd_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FF1F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcvL-0005aR-NJ; Mon, 09 Mar 2026 11:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvE-0005Bl-Fk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvC-0008FP-Ns
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439aeed8a5bso9200468f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071609; x=1773676409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pgpA3PHGmA2cywOmnIHp4QQstzRdLHRlcUMp4w2UsrY=;
 b=hw05L4sm07BFjE1hsZoDVU/p1m5aPvMWfElezukKU0/Ezpa6htKlSyjpg4QagPvAVy
 r6G3Afk6xtTh49tJy7/OXvQDYBrTnQ+YAiKvXgkn/FlvQ0B4ogxcKmKPcYm8bJHDh35m
 CQJzIu7k23fTU8aa/WdW09qy768Ljdkhi5tC/y4cSRDA6FzIAeWWMgNh8nQ3u+wteOUp
 nqJJZD0529sH+SZS6H6REX0EOs8eNkBOfTugSZ+Wu+4nE3/0NFEBoJ7p3ruEAMDdY9Pa
 p9R9oE5RH9SWzd1yFwTn/PCp7yKuMg3B5EOVDy8cRCUZX7bNJGLp8gGmoZGj2B7AhlBx
 ziWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071609; x=1773676409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pgpA3PHGmA2cywOmnIHp4QQstzRdLHRlcUMp4w2UsrY=;
 b=gNdT4JA2zNyiQAWz2Y/JJJn1VsoqdeJVEUbR7i/F0XpVW/+QachoB+sj89uFHq8YXv
 l61p+ldYbv/mrqyI8eJCFcj5B1TXDXzb0pUGHrdENGSXnNFD2nNDEKExcx9YF7pV34pS
 X60D69tb81ZyiwdVN71V16SN35whEe5bteyGdpNSfChgVLlOE2Kjkyc2QWKbDGkDf/E1
 MXc18Ss3Fm/hoDVbROA60nGzDT45otxsh42y8fow8JeIZGvzyyIuiil6WRFwodc87AkS
 zKNK4A8reKaqwkIE41L8E8vkEWWxq/4EruBrhtp7WGqrcEhHpNZoaGvZ2js9NJKGkB88
 Ijgg==
X-Gm-Message-State: AOJu0Yzl7bs2Qv3A4KngIG+I0Q2tX2k/G3us8R8lR+VUqjmNtt4xb3CZ
 9SrLkEqRtgEI4wX5qMBAZuNfpbRDB83/TKxHQdfHWVHSW1iQT3uJwYddgimiskBy57yEHTxwBt8
 3UJSj+l4=
X-Gm-Gg: ATEYQzyP+WpeviDGrwDQNl9F/ZABKAgO0DXbLDvee7YRo29CpnUn8otTHTiT/LpszAS
 2LvG69GOUIbWr8NY7vvEYScF7E/4p/fYvQKDNo1zw0KEGjpluf5piakPATWBjbH09JEF0LlizSX
 bYNJ777y1ww9BlSR379PYnjytmEyHORidc9cAytHZ8nK3itPr1l4iEXuVUT98cNuDexVuLBYbgc
 47PjEWMg3SfL8FeBpvG1Ip5eUC5W91J653HpyN5x+aWlb5eW8Azc67cwH5d4s9ENkN7qwyXJ2iw
 4WkESHZ7IjY6H79b2wGqQo7KFPrDsgX4z5Zd4M+QSl3Z4XVdyLY58ArDpFHg3lOjXVYgH6JneCt
 MZW+7xR+30sNqux1AGBxSOpDnNgoNokYZ5vNKFQsRp/i7VQf2t1SSIguasm+bEElNJv/B9fwEl2
 tKALddNzKmDd5puuyN2ZgVY3qQ4IWPClYO7r6+a2TNPok2PAr/Yk35THIe5+O6Ve/C2DhLdMS5h
 vaXIyEm3kg=
X-Received: by 2002:a05:6000:40cb:b0:439:cc01:c9ee with SMTP id
 ffacd0b85a97d-439da5554a3mr18488588f8f.3.1773071608643; 
 Mon, 09 Mar 2026 08:53:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9d8sm28693381f8f.21.2026.03.09.08.53.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:53:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/49] hw/pci-bridge/pcie_rp: Remove PCIESlot::disable_acs field
Date: Mon,  9 Mar 2026 16:51:40 +0100
Message-ID: <20260309155219.62400-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

The PCIESlot::disable_acs boolean was only set in the
hw_compat_3_1[] array, via the 'disable-acs=true' property.
We removed all machines using that array, lets remove that
property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-10-philmd@linaro.org>
---
 include/hw/pci/pcie_port.h     | 3 ---
 hw/pci-bridge/pcie_root_port.c | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 53cd64c5edf..b28af067a66 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -60,9 +60,6 @@ struct PCIESlot {
     PCIExpLinkWidth width;
     bool flitmode;
 
-    /* Disable ACS (really for a pcie_root_port) */
-    bool        disable_acs;
-
     /* Indicates whether any type of hot-plug is allowed on the slot */
     bool        hotplug;
 
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index fe3ced56851..7c3e78010b4 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -117,7 +117,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
     pcie_aer_root_init(d);
     rp_aer_vector_update(d);
 
-    if (rpc->acs_offset && !s->disable_acs) {
+    if (rpc->acs_offset) {
         pcie_acs_init(d, rpc->acs_offset);
     }
     return;
@@ -151,7 +151,6 @@ static void rp_exit(PCIDevice *d)
 static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
-    DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
 };
 
 static void rp_instance_post_init(Object *obj)
-- 
2.53.0



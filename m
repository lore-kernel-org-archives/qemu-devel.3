Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AC3C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrt-0006SY-54; Mon, 21 Sep 2026 17:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lro-0006NC-D9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:04 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrm-0000Iv-J2
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:03 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso29547675e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027271; x=1790632071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TSR3J357qCAnKna/ltpzsAD/Xo6H3LWF4T6WfRDdd9U=;
 b=HtxR7822GodVM0BiCK7PbAMg68Mq0sdA8SkVii/M1wkQf1e4v8jcyhVHwVnHZaf7AR
 YVkd5liJKIoqyY/x9wvXIPl1XBOs13ndRQWGPrnqFTZpJZVBLVgrk5Ui/9WKkXiuAx/A
 Q6/GsuCVfVFUk06Zple98N0VVHiT1bhEvfydDs+pmAG2oBwt/D2lX3GA70d7X3fi9+ww
 r0PFaWTELtfSUvkuqWPFsKCGNxMXKYkt310cf1p+DF8Zy/M9wbd9iv8shpvN8n1xYDjM
 PisFVNXuamO9BMvF70ocZtdRZHB5P5rakITp28TbH+LTZFfeBzconsmTUMxS9gphxapG
 QHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027271; x=1790632071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TSR3J357qCAnKna/ltpzsAD/Xo6H3LWF4T6WfRDdd9U=;
 b=gqBn1roBtDx/W/eMVXSXxxjHGcdiEbqTXHj8Rm+VVD1NsU0Z7tyXWEK7PFO3bkY5Lf
 UFX+RqGCJBKtSNx+SFMrppaXQCQ43cdUxsrDJBh8F28L5ih2lReK61vJyRDx2CTzy2Qb
 tE1tUk8coX0JeagzX1jlLMZgZRDCNOpUEf1wVoqi01XaHJoSOk6sJSG5kMKLSraemtIy
 RbjQmhj1fpmtRkDZT/MnpLSqjlrZRdVRumjLSgLNQaB2hYfMVt8kNI4EK8J5U+/dGe7x
 GO5y2ug9/qu6KHkHNThaSaAQUSHxQCAAy1/G/lb7gboHL8PEtEVa+pq0zS7/90PlLJqF
 Bcgw==
X-Gm-Message-State: AFuF++k/I8shD8KEvgbl8NDln4zDv9+RP8qedhj1NoJAxZAIQQc323qF
 p2uw0IgV9RqqZmjJqdxRkTx6aFtc4uPqxnnnw0QJA+Zya3l8vyDu8IhyPQy2nw==
X-Gm-Gg: AYBFou2m0WEFaH2QdLOynPVC+HwAxI/cqlqWtRcdQ1/F5WtM7dhhoZunGPhvL70D+Tm
 M7su1imxQwAe4b4ctRgxmyX6sUgiqiBpiNOSpq3vO5RjshKliQX0CiofABAjs2c90e3z14UeGUK
 hl+WbVjNByU4p3i7PevnKtezvK9uFpy5HUQLotwXpkMXWDe1OGCUSTpfB5Wfix3g+yFTi9TtrBW
 onLln2cdRebPhZFXLctjkibh2s6Tvg4reqA8ULlcBujTahNukO/KZ+14gPk6r6J0QTSD5VRMVHw
 Eon94LzZ8ohitSOtZ7hONhDpbVtd3XES6wh/DhKYIxvZ4FO6he3q52ulpWqCbRplXyQ+8cwuurz
 lG4eP59+SLJShqCUqXw1G3w4YMIIIspaRYa8FP2mJK0QCTvFK80r0ZP1wK2x+4ukfg75uyxFCfc
 GF1wvG+SW50uHR51XDfAMXcws7sE9Gx2Q3a07S+d+GJpoD1zUjgK10iMHUKVJot6JkA1/5D5jxn
 SUvwlt/R9nOuveK3Z1YTf6DCv3KabKdHEObN12uA2F3vOF1c7+CU1tdTQuzYQnuAVfvtPLtxa9j
 S2Q=
X-Received: by 2002:a05:600c:358a:b0:49c:fa20:cc08 with SMTP id
 5b1f17b1804b1-49fc5741844mr187164415e9.31.1790027271071; 
 Mon, 21 Sep 2026 14:47:51 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:50 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 18/42] hw/arm/Kconfig: Select missing UNIMP in config
 FSL_IMX8MM
Date: Mon, 21 Sep 2026 23:46:46 +0200
Message-ID: <20260921214710.29422-19-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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

TYPE_FSL_IMX8MM models the whole address space by representing
unimplemented devices with TYPE_UNIMPLEMENTED_DEVICE. This means that
UNIMP needs to be selected by config FSL_IMX8MM which is currently
missing. Fix that.

Fixes: 7bcd1f30bc83 ("hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index eae06369b0..ad4b997abb 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -626,6 +626,7 @@ config FSL_IMX8MM
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
+    select UNIMP
     select USB_DWC3
     select WDT_IMX2
 
-- 
2.55.0



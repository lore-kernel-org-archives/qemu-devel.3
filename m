Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BEECC6B10
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY9f-0002TL-Ex; Tue, 13 Oct 2026 04:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4a-0001k6-N7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4X-0008IC-NE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso24468155e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880880; x=1792485680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4um6vfgWs9h9kp00xbqJa6oHTA9SbTpa0Ruq+mXG+G0=;
 b=fMhJP55lr+f1v0emdF0UCSQIH9vjE37/YGzLS0sxrkVLNmK2QgubE9C/142PiWvQP5
 EE4piIec9usMdBEdfVn33mqYYMsqXhFSUGzltU7qQ8hxEH0YOsiLmcY1a2wSiUEbFHqc
 cVWWpIBD+7H5wA/HcS+dOLhIabF3z3h5b3BDn2+wvF71JoQdxDyqJWycVaarMXkzOmza
 2SpzvI3FtMB+bM30bcMddjjU8nqPWqB3AyAichWse4fpafyt+/jDJ0N3mWTRORf7yiYt
 6b4RDnQjs+cGz34biU8E5ENEyscWusZTEXwuofk4K2Yo1yl+IIuOkAJBOlh53LtA3Hl2
 3xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880880; x=1792485680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4um6vfgWs9h9kp00xbqJa6oHTA9SbTpa0Ruq+mXG+G0=;
 b=vAYWm23iLgBjOfyiWJGuu7RQ1jL6Dn7b8qY0QSfyOI7Gjq+Nxc8JQI/QmbJ2iFwY/l
 BBfoVJt9ErgqNz+geag0ubxYOOpa2JoXVg9LFQHrcQW5tGrtNx5iW8H5LowgTKJn8otK
 z2ZIixQNFFg67yDuclQBz4yu1o9rbL9ch9nXXfXokfX7PqrYySO6UHlEsh8FNGw5M2Ie
 uc2eXQMwhds33rVhkbZ0Ql3VErDe6VOAdLoqJIrdqRQR4mh8mRi0k7vVA0AFZNUprTzI
 pKzfBHFJQzEAVknS4HT8nYeDu+XKfx/jIO/1qw8bh44DzQeHT5xhQRj4YShhPHfPX/Hy
 OyjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzH8eJSzRqFoX2gDhoibJg+W5nYaMeFnR9KOvU4sNtP1B+UY7sGvwgOfyaP6K24X7Ay3bNAcmGaLCLE@nongnu.org
X-Gm-Message-State: AFq9FYJb9HbDUbPaRihzETnKUvOtaK5mnyPazOYLctGIBIonFpX05/hH
 aflvD6kLuqh6BiiDib0A9MCqvdAsxDIaZ79iuZ1CaSYi15vZHDEkmIhjX+Is3X7T4txG7cqpKPC
 t9s4zEgw=
X-Gm-Gg: AYBFou0V7SnWJt1F8n8DLa+pPiMravmktrP/CJelUulzUmMFjtKbUZFgJQOiD+84ULm
 lbXQRqM7+c8lLFXWVh2DHoj3eAoywIX17fYUAJpjQ7La8B7JzObpgbQ6B+yR3HMj2Z8WxvCfDo0
 Hlbdux6ZtdGdIqTwQgrqoDifq1pwx3t8+9t99g71QzmHbR4TEiG5t1ICC06kN5NT/iXuGpoDI/o
 yE90OArC6m5jhSLhv+kNxo+PpoffGQEizYHUSzC5S0/jtmHQ19dRtWwZGzBMxAKBwpZYArcSOTQ
 3AH59XVak8m6TxBiUtQYz3tOalQzroFd0tf34XD2CsH7Coo2bMj4BkJOm2hzv2gAlWWKZ3SkofZ
 smQzm7seynH7qX/Q2zzQHiDYcJrOjo75r0XYX8+gjsZOfI3uO34wq4olR/F2aLkAgE1WhS0L5Bt
 rS/DAKm7NfONKsT9qgyARS5x12MeQJK2sk5okjNHNPngJXrXL1mn2j/u/TzZWkSUQnpOinWj1nB
 ToXzotDf/ZLz9wAtzlveGQ3rxuD037VQDxjB13ynObOJXwlaV3rilb2nbPsOu6F5uqSgm32su5c
 fAs=
X-Received: by 2002:a05:600c:6383:b0:4a1:a6e0:4ce4 with SMTP id
 5b1f17b1804b1-4a1a6e04d7cmr36094065e9.33.1791880878575; 
 Tue, 13 Oct 2026 01:41:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 80/86] hw/intc/arm_gicv5: Implement IRS_VPE_HPPIR
Date: Tue, 13 Oct 2026 09:39:27 +0100
Message-ID: <20261013083933.1024405-81-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Now we are calculating and storing the vHPPI for each VPE, we can
implement IRS_VPE_HPPIR, which allows the guest to read the current
vHPPI for the VPE it has selected using IRS_VPE_SELR.

The specification allows the IRS to return the current vHPPI on
reads, rather than having to sample and hold the vHPPI at the point
when a VPE is selected by writing to IRS_VPE_SELR.  We choose to do
this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index ab0cd1d80e5..b3ce8a87e81 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -2319,6 +2319,21 @@ static void irs_vpe_selr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     cs->irs_vpe_statusr[domain] = status;
 }
 
+static uint64_t irs_vpe_hppir_read(GICv5 *s, GICv5Domain domain)
+{
+    /*
+     * The spec allows the IRS to update IRS_VPE_HPPIR as the VPE's
+     * vHPPI changes, rather than sampling it when IRS_VPE_SELR
+     * is written like e.g. IRS_VPE_DBR. That's what we choose to do.
+     */
+    VPE *vpe = vpe_from_selr(s, domain);
+
+    if (vpe && vpe->vhppi.prio != PRIO_IDLE) {
+        return vpe->vhppi.intid | R_IRS_VPE_HPPIR_HPPIV_MASK;
+    }
+    return 0;
+}
+
 static void irs_vpe_dbr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
@@ -2617,6 +2632,22 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_VPE_HPPIR:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = extract64(irs_vpe_hppir_read(s, domain), 0, 32);
+        } else {
+            /* RAZ if no virt */
+            *data = 0;
+        }
+        return true;
+    case A_IRS_VPE_HPPIR + 4:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = extract64(irs_vpe_hppir_read(s, domain), 32, 32);
+        } else {
+            /* RAZ if no virt */
+            *data = 0;
+        }
+        return true;
     case A_IRS_VPE_CR0:
         /* RES0 when VIRT_ONE_N is not implemented */
         *data = 0;
@@ -2962,6 +2993,14 @@ static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_VPE_HPPIR:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = irs_vpe_hppir_read(s, domain);
+        } else {
+            /* RAZ if no virt */
+            *data = 0;
+        }
+        return true;
     }
 
     return false;
-- 
2.43.0



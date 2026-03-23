Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3526F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iXe-0005Pq-LG; Mon, 23 Mar 2026 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXa-0005Ap-HE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXZ-0000bg-0I
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso27507535e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284847; x=1774889647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HxZq9kuwV2EPeGqBtGUjPbFp7Ne2hS6lS30xXSScbwA=;
 b=csI/04/qSKUKg5FwMqNBgKpRQOIt/rcyspTGnH4kA7xfqz2s5ro9d8FXasMZUinQIg
 I06n+9oQ9r33vs55m9Ng41p6CIKu8igpaWcHiCb5Ete6Vf2M0qRKVunq+GdQPfzsEZHW
 p6bnzK1TcZ+F0wORfsWBfJXDq6ohD4Q0p10FgBiuH9X+qWSSdbrxfvaHkt5JW9iVShV1
 Foph4Ojv9oGy1U2O4ECXPvF+hNn1l/rQNPMFtIW6IMNw3FvQ9EUYJCZiZF1WM2HwgWct
 TlPXebjvlZf/FcPxcLGfBYWycRYriJypmSlFv1AKLVQ+19G01UMge93q8qSArMstgJid
 1bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284847; x=1774889647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HxZq9kuwV2EPeGqBtGUjPbFp7Ne2hS6lS30xXSScbwA=;
 b=KulkaDcD/bGqsENVsrbNEWP/OZFvbThqv8UdaAjSM3JBbduD6DawCoFdoW+K4+S035
 /6xZogBw1dl4L06HQM6LyfsPc6J4tM1C57qgSml0cV5ogF55kuuhsxXftB1KYWDEgx1q
 GPswKyR/Sa/e2/9fEtQlHW1LLd+QsMvVK1TJCBz2ex4mRgIhKXMt4kjJ8rSVgQhUQ19t
 w5FOI8F54YFsOd49YcDXKAx/Rl2C+P6WXBt/rWJAAOd81drtPbAO/074uVAoeavI1LX3
 4sFwb2rOulH+2ntSgIqro2S+aJ4mXxBSHpjhYuA/vKCVLYQHEOswMFV2ENEO9qXst4oc
 nq8A==
X-Gm-Message-State: AOJu0Yx4PYUGbH1D4cYTFXpRqRfIi6fGloRWS84ve25wgkgCAzJ06AKM
 +a5oidwVLxdoANMISr5GviiqBG5lYGK8WJiJPhELoJqwAxHYMDuhbBlFfFBubNshihzHc+HzgJk
 t4wCeJH0=
X-Gm-Gg: ATEYQzxn3nlQL10QRJqHI1/ynvLgPvFHB2G23GduXxPAub72M2CxzLC+KNTVeidiNRx
 7owDMc8ZdGvknKwXJUBTwJHRuxsyOuKLU5w7osjmDpysRB29yvSfYpFouJPoqvzr+AvlZqAzBYs
 fJo1XTpFAvue0rJNsTN3ym7oHUlY/CwFYgMTFYXiFn/iqm/vn2u4MsSa/bZEj/xSJNCh/SClI+F
 7IVbq6Pa7UyLMMiqvzbRImpvhzy926QWURdkwvhPR5NGALMIbZFqjZs0tymolpNfV13x0Flno1g
 bl6rjdVVFZEblsbPSyM1ebl4/KOT1tQ18XyQZcKgIhneSB1uvpYiaIbQ74ygcz/iXfKhCBdbZRZ
 OAIQFmIuwh3cCfChrS0qkrafKFWZSo8+Yjd0ghKiFZM5+e5UiFJml8cZSla25H0icK0jGrrjLCV
 2A1/1NPa9g+GNydzxuJJx8HVIoqH8g6Hd13fU/BGQfpgfPdGjnpQ0oNhVGggbKmeUrR3h/IVMOT
 KEA9Vv5T1E=
X-Received: by 2002:a05:600c:3546:b0:486:fbdb:b718 with SMTP id
 5b1f17b1804b1-486fee29536mr182910175e9.25.1774284847005; 
 Mon, 23 Mar 2026 09:54:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe8359acsm291324285e9.12.2026.03.23.09.54.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:54:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/27] hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop
Date: Mon, 23 Mar 2026 17:52:07 +0100
Message-ID: <20260323165218.96607-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Jenny Guanni Qu <qguanni@gmail.com>

When a guest sets MaxPacketSize to 0 in an OHCI Endpoint Descriptor,
ohci_service_td() transfers 0 bytes per iteration. The Transfer
Descriptor never completes because CBP never advances toward BE,
causing ohci_service_ed_list() to loop indefinitely and hang QEMU.

Add a check for MPS==0 after extracting the field from ED flags.
If MPS is zero, call ohci_die() to reset the controller and return
an error, preventing the infinite loop.

Fixes: CVE-2026-3890
Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260321000444.909451-1-qguanni@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ohci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 1aeed9286f5..6ed8046fc20 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -956,6 +956,17 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         if (len && dir != OHCI_TD_DIR_IN) {
             /* The endpoint may not allow us to transfer it all now */
             pktlen = (ed->flags & OHCI_ED_MPS_MASK) >> OHCI_ED_MPS_SHIFT;
+            /*
+             * The OHCI spec does not say what to do if the guest hands us
+             * an endpoint descriptor which specifies a MaximumPacketSize
+             * of zero, which would mean we can never actually make forward
+             * progress transferring data to it. We choose to treat it as
+             * an error.
+             */
+            if (pktlen == 0) {
+                ohci_die(ohci);
+                return 1;
+            }
             if (pktlen > len) {
                 pktlen = len;
             }
-- 
2.53.0



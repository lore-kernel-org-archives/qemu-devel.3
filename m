Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66085FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLV2-0002IS-G5; Mon, 27 Apr 2026 08:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0008BM-R6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNw-0005j4-JP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so60562415e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294100; x=1777898900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DTW9JTovBn9qcOa6N2q6qfwrq5ih1ehtyvkagKiaSQo=;
 b=VouNavDco28xUESC9Vqf35FXq+cnL3YuarR0h1Ahg79+ESKOXipA2kNbwnixDb9ejM
 fItlauSpaXZuXRSuU2a8CZivLFLAjmSU/oHY4aX0mjph3yuXyt5Dkpy+fwX5p0el3Nty
 Mb5tyk1aUYV//ONhAw/LlYbLaeaCmtLcyRsZ+smKQ5XU5SNsPP0i+uJ0B1HFPy/cLFOE
 8Asv3N9Q3+yMl0APPCD8MTfNNW6tCplOcL9GdgZWOcS0RP0emEaSQM21ZICrZpPQdLIT
 NhJHKrEigzCKvYISZvITkC0Z2z+wgzxCzqaNN9c2eGWZnLDyWyYyo60d7LhulQjF+O5h
 7dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294100; x=1777898900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DTW9JTovBn9qcOa6N2q6qfwrq5ih1ehtyvkagKiaSQo=;
 b=cU0v7yU1eEBafOYToi8yzSg9Vq0Xxx/106qyRYx2RqybwT0tXromrbMrH2e6TRyum9
 acLoCLGwkwoDNkZLIGPyMqKp50ZmKnzOLBYc+jamQ7/pk3eZlGVUdnOrimwcr8fOK4Gh
 /2upYdDzMr2011q6r3kgf0dF1qYAOml6jLltjClNTd8D3LROAdkjXLsik9gP98N9UU1l
 zGvZ2s+/d+diiMrWydBLmPfKjV4UwggsJIQUWv14dSifZSDLRsDZsAKo3oM67JKgEi30
 036Mk3LDggGh9TBoAEZR8PssH1CzgFjV11Vlo9F2dcr1JsEmZ4ulGT9N3KJ7RDajaTt8
 ZyPA==
X-Gm-Message-State: AOJu0YxQd3wEJf/d6inOFzV/ObL71i+mybP+w+3Qc6e9enm7tXnsbUjm
 Y6EPgOWln4IThQwf3Yt6HAvoy9m+KvGmoz7oGw9zyAYlAeN4vWJsKOFdQFt872a0CBGRHjXfDFd
 +Rk3g
X-Gm-Gg: AeBDiesT28ssgF/H0k7zfzWVT/xw3ocUOROnsj6bViV6WIJEibsSgGf/u+plZJN6Pna
 JZxUVBb8I7SkuPqy/ASOGpZs0p04kLCeoS8T7uYq6Wboreo2FMaTHAKB4cvxLADkNHWZCdDV37p
 TW6XfV13tHzdCYh/8WbfAg+xbfEejAL60vPdcgzQNqkvUOaMT/E4+FILz0LPZdcuXzXI2GoTtzL
 CATnXuUWtNTQmD2Z+lZPha470qa3BmOon6V9nkF/hrbKqyfuOmq1pKd7sOs3B+Wy6NgWU7F+DfR
 xGwQ3Gbi3vb5v/ev0dxiGuawcwGQoDGI0ojA4tVr32DgMGx2LhGpVqPze4wPvUaBmRQS+IxXzNe
 j6iZrCxpdR1u8l+E4Gf+9zG0Gu1Ggn4t3OVxIYh9tDXapsv9gRQJ30pxsixf2kfBI0VtylIipfy
 l9VzfAJhrdoh3jBir96aO1m7/jeA50RAX4mJ7p71dGV+jiONwAELBdAEyK2ghmW3FZhmBTl7sEm
 lT2YLTN9c/EKzq+23YrcuIMgtY4Xo90rExm+fyq9HYhHXgHNpxS
X-Received: by 2002:a05:600c:5254:b0:488:8bdd:cfcc with SMTP id
 5b1f17b1804b1-488fb6e62a8mr649474085e9.0.1777294100287; 
 Mon, 27 Apr 2026 05:48:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/63] target/arm: migrate eret trap syndromes to registerfields
Date: Mon, 27 Apr 2026 13:47:18 +0100
Message-ID: <20260427124738.966578-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Alex Bennée <alex.bennee@linaro.org>

For simplicity keep the OP as a two bit field rather than the two
interlinked fields in the docs (ERET/ERETA).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-5-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 72051443d5..63c8e66ea9 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -367,12 +367,21 @@ static inline uint32_t syn_sve_access_trap(void)
 }
 
 /*
+ * ISS encoding for an exception from an ERET, ERETAA or ERETAB
+ * instructions.
+ *
  * eret_op is bits [1:0] of the ERET instruction, so:
  * 0 for ERET, 2 for ERETAA, 3 for ERETAB.
  */
+FIELD(ERET_ISS, OP, 0, 2)
+
 static inline uint32_t syn_erettrap(int eret_op)
 {
-    return (EC_ERETTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | eret_op;
+    uint32_t res = syn_set_ec(0, EC_ERETTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, ERET_ISS, OP, eret_op);
+
+    return res;
 }
 
 static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
-- 
2.43.0



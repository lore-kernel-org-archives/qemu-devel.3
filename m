Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1103DD6552E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxU-0007XO-9h; Tue, 26 Nov 2024 12:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxR-0007Or-PH
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:37 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxQ-00021S-4J
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a90fed23so3700665e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732640554; x=1733245354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0cbrcWqiZcZEEu28Dctl5YQCYg/B0KzZI5DzhtcRSiQ=;
 b=JPDIOoAG97shjTCz7ajK2SC7RYg9afZw8CpcNfJE3OLD9nuWz5Ji6YfMh12yn7Ct3C
 wtLiX2mqbz3XckqaOiQT+GTYMOqe3hjw6btcMixbSwbbIBO5GApw3AhE+KCSvxiRwFgw
 dzQOQYRF5aCRDTlpP3tQqF1yF2tcEi6rEYOTatgiixuCaX7w9S6HiEMM79x6o4b6lPwh
 Kv++tpxDCmWhbQPa8VYdmuZbamIrzFniu6hwFyHq+SqP4vIyzM9n4ruRzgM7uicvMccS
 +nPVW+gvfi0wGEnM/R6U3wt6HdstBSJpGOamYL02sA9dTd6d12esq2ff/WEt0bue9+6C
 ISYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732640554; x=1733245354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cbrcWqiZcZEEu28Dctl5YQCYg/B0KzZI5DzhtcRSiQ=;
 b=Y2IfchK/V5ULUkFkKbM3IYXDJRprQL+PDGwSADzouM96XfLJvUz/IkTJYjedL/equD
 KX8cHQzRIRbv+AJEp6IP8t8D1SIWUUWHxp1twgsfx8Mrs5llKhMAR8MLgwQn4G4zST2y
 pEUa45GqhYIRBfJuQDERkcXXsOqa+QdYQ62dBZ+vGLEBRgXXM5zyPuDY2pgrmzTHjXey
 CIHrWmjH1FGZGhzqRgQkeKHP/4LN1WKy5ZrR2n4FkYOlef3b1bMZBA/Y7ncuqt/tV3rA
 h7/aoXP86qlHFBVZeY5RLHB7LPIppK3owHLOcqZzRvZ++T86qi1btn3rHL/Gdvsu/0RX
 OSeg==
X-Gm-Message-State: AOJu0YyxNAezbIfbFmAodRuItiAWAUrWrVc0uZyjqz7Lt1oTehtglVfB
 OVHJmlRbu8dAEExCTaFwG01/TkVZ1WMfZaS9KHWkZs9dHTb7+lAllXpqsVp6IO8v7tipWUw3djP
 o
X-Gm-Gg: ASbGnctSl7GRmkWT3s/uMQYVxfm05ain1EWTWh7FhzDvzcVQZ2Ll+K3/4LUZaECs57Q
 O2h49pUle7/khYwCofVub6wiObS7rZP6oV+Zs9FgDOWI+w/bt++Y5rh7EmSn6Z0eu9C7xcGBson
 8dY7CFqL01/DoMD/jGaT8dUvqzNSTAJROUx8bCczfjBIWDRUN/0byVUcZNyryZshXvZ22xJflWs
 YkBTWEnRxZ26odo/B6LeO4d3ur1jiohMhYQcuox1t+H7MvYtua2D9Gt
X-Google-Smtp-Source: AGHT+IHFOJKkNgcrgbekbouSgClvfxrimqJGEgpSt6Xb1OVUGRunXJoAwWkaYsreNXR6/2vsqry7oA==
X-Received: by 2002:a05:6000:1562:b0:382:51c4:e2db with SMTP id
 ffacd0b85a97d-38260b45de8mr13346432f8f.12.1732640552008; 
 Tue, 26 Nov 2024 09:02:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm43017865e9.44.2024.11.26.09.02.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:02:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] docs/system/arm/: add FEAT_MTE_ASYNC
Date: Tue, 26 Nov 2024 17:02:21 +0000
Message-Id: <20241126170224.2926917-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126170224.2926917-1-peter.maydell@linaro.org>
References: <20241126170224.2926917-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We already implement FEAT_MTE_ASYNC; we just forgot to list it
in the documentation.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241122225049.1617774-6-pierrick.bouvier@linaro.org
[PMM: expand commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 50d0250b1eb..47f5123a31d 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -94,6 +94,7 @@ the following architecture extensions:
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
 - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
+- FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
 - FEAT_NMI (Non-maskable Interrupt)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)
-- 
2.34.1



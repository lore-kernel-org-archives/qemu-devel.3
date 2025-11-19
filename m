Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E82CF31AF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgXl-0002yS-L7; Wed, 19 Nov 2025 06:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXc-0002uE-JV
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:06 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXY-0001u4-Un
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:03 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso4590325e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552399; x=1764157199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5q4Dq8gSBDW8LjZ2RVoouNTkYtodcyLrqkBLjbu9ck=;
 b=HgL4DTDPJfy1qs+b1ofQLe+iuwuWXx+sojSKoI2i4EtBz+nhM+d/uY+wV8AZVnqtgT
 EqPSP/1ARbYHwdpB93cT+JiR3pA0KVHtcQXrg4z79PaRTGrComzT17iRDJokcgkuqLfm
 5M//EVjxzPZmP7by1T1CF//8t6N8Rxx0VzCGemAQyjs2JkF8ztOFbSDdjXQarG45ssmO
 qigT91U6Wh3sdoAT9UgobE/BkSUjZkcKtL2o+OL7J18gQHTWLgtLaXDXMaOri3PKKH4S
 Wb2JaK5+zzx8VfJw4+q6Z0+TEeFRLrrE1++KJdcdcA5myybwiSa9HlaVF9071NlyYYX9
 Pbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552399; x=1764157199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g5q4Dq8gSBDW8LjZ2RVoouNTkYtodcyLrqkBLjbu9ck=;
 b=nJEfcPrm6/3gVXehxR2nAw+TWTP3JfrmV2jni2MmeYY4gWKfMEXnjREgrVNYNjJ3Hp
 Y91o6ZfKKqeU7GVeIWHd1fMhW3bCLMSrzXSoiqrxSNahEQw4G7fYo1xogGTLF41pOX2S
 FuBsAebfnZErFePwgMx6NB5g0q5Xszkd3IyB1bS4F3asXSpRbNnuRilCNaWx/JFcEjbo
 NxUeHPVAT5gO1rCKx+N+4SowNqCOnOkvW1DAaI+Q5K2RaQNQg8GVupmtGjRcmTjSd4fX
 3itO9m5CObo5vGyn0u65oxfGF4U7YsDo5jLYGS6m/DMSvxUcrPFG1x9qbgLy8AKQ4n5U
 8xkw==
X-Gm-Message-State: AOJu0YzEGkXAlD0d5FW2VfaUJyRStXsUgFnWP1906Mv/IyS1H26tIf01
 SImG5tfJKTWtlxdMuBEbyiBVI4bh4JHAKrs6+P5xFSuSiz5nA0lLcS7pk6LFW3u/KDc=
X-Gm-Gg: ASbGncv0T1s2KzcuELu/ZOyxHiAKU6feG+nKqqL+YsXOjWnxtg+KmlLhvYTf4lEiZ7x
 jmPDP6Z9CmRerE9GGRte8XAF5+AssRQamP2BCKtxPQX0x3pzuNYthBv4cz9ZxAoSbGPATsdwih6
 DfsLlEofdGG52noCPexgC9oDcS0ryu3I99YbdxY3rk+Qn/ushJTJXSDpqP7YiNPj7rCPFoIVqXv
 srBlRv+XzErrUpsRHKuVUgrx4sqR3YvriP6DLhGZSVQtfbHBzwKun7g2jMlEjC6XASzLEJv03Qk
 KIXE+3YXUA5KWi05IYi1wbMHvBuwnf1i1ohBBkzjN7EbcIkzbP36bDKC9w0j4MQBqK/QYC5qI/Q
 4kJLQZ5nKKKPBSohel0tP5xK4caipGrbZH8M4m6fABom1UziEPqWrIkFGh3PxRFcjCxhoPd/3K8
 9ZCmoMAs+LWAk=
X-Google-Smtp-Source: AGHT+IH7tiIO/aHt8k4xnECUS1iwz+XokqDBy3rEJAZsiad27Mu5WOxS8imnCSTAl4SIj3rpNCIqrg==
X-Received: by 2002:a05:600c:3baa:b0:477:94e3:8a96 with SMTP id
 5b1f17b1804b1-477b746f2c3mr4634035e9.20.1763552399467; 
 Wed, 19 Nov 2025 03:39:59 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b10260adsm42429365e9.7.2025.11.19.03.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:39:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D81125F929;
 Wed, 19 Nov 2025 11:39:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?=20Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Damien Bergamini <damien.bergamini@eviden.com>
Subject: [PATCH 6/9] contrib/gitdm: add mapping for Eviden
Date: Wed, 19 Nov 2025 11:39:49 +0000
Message-ID: <20251119113953.1432303-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119113953.1432303-1-alex.bennee@linaro.org>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc:  Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: Damien Bergamini <damien.bergamini@eviden.com>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index bf1dce03fde..4e67c3e484d 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -19,6 +19,7 @@ crudebyte.com   Crudebyte
 chinatelecom.cn China Telecom
 daynix.com      Daynix
 eldorado.org.br Instituto de Pesquisas Eldorado
+eviden.com      Eviden
 fb.com          Facebook
 fujitsu.com     Fujitsu
 google.com      Google
-- 
2.47.3



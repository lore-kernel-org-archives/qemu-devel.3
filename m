Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70450C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjgk-0007jt-S8; Thu, 09 Jul 2026 04:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgj-0007jU-N0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:53 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgh-0008BA-Qw
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:53 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47df440fcd5so628131f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783584050; x=1784188850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PhQhokogISznbkoXu4VfQMqeiJ6bfCrXnyK47waKuXA=;
 b=pDqCG0SFqSockjnnaj1QXlWyB/a7p4JMgBCQVq0n94cSlDDNz9/L+56FbESGsEif1K
 9JNubj0T8YtcdzTxfv03Kr340O8kgEl0M0SywcssIXyPw4fO26wSc7zl78Ya1b6xkxpp
 RTtKmD93V6pf+s777RBFw3qMijUsu2NgTiRYemAMOD5ERzdnhbLMd6cTQUGjIIsJvg4g
 v4NjeG5D1WEZcWxoObeB0b6KT8DiORiR5mb5XPAv4uqJrwLS8uX1H/N5DpfwbEfJMK0g
 19G+PYRk3PIDcHqtoEwrz3oWelDthsbimS9pRwiDcoTd8Qco6pFRZgtFzotebwAaOTu2
 484Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783584050; x=1784188850;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PhQhokogISznbkoXu4VfQMqeiJ6bfCrXnyK47waKuXA=;
 b=XDq9pF1jT7XQNwEbS5IxRtJOp4bYFzt5ypEtmxcujdwTr+3WrBh5rYAcTrAl3Us/qJ
 OmzbA74G6odf3yNwuS4VVv+DkpiIFZIqy59R2pBN39FyBENFazNDaywnoaSY5p1PrZSj
 nFvWj3MSZ9YGiqAkJQvLEkbYc5TmYEEsM89PdtBxrHjKnRoxBUCCLVWL+vLvkRhTR6OT
 WGfDVUXHSNy24U9dmM8O0C/CBss2E8vrqdjbcmKHFd8H5/CEnU7KYVK5curwvsKzWA+0
 BWn+wuk/HAS6bCPloTJgToKREnpwtA+nHdNWhrP1tjgO/TcwQ8RzKgl5gz1uHAaO9HDy
 /oVg==
X-Gm-Message-State: AOJu0YziORPT38VL5HI7OK/BpGMYGblnfWXpyv244d8spMx2cnzx1RPD
 lq1zsaZHRRYLsWGdrOogS6fqA6lWFZslduMqhfNtJO6Fqu7A/JOedfFHrmnYRvWKIMU=
X-Gm-Gg: AfdE7cnr7MpxZgeBUUjxlKRo0ot7IqJXj7nIcJ0WCFQBOkIcPpS9d23BeZoUulsWS/h
 gh+3W1t8pfs1IKVCwptyW1SfpSqBcy8VjMQPLWifzRLuZ2EjVRDzPU8PDre16wrfE7T2hEc2wJ7
 yhGUXPZ8Gj5AcLXx0KVtGwcuMYseyOEtryRFQSXSqwyd/dP98Rspz/wwgB+Gh9xUTsahBhmqObz
 zevE6RCq7dS3p/4yBB/GatuhbR1dDWQJCLA4M4SaP3OuonARzprAv3t6+GL6n0G1AGBP4cM1ljf
 bGksU63X34mCQ7wsmEgpWLyuPBoZSH6SaYk811mRbYFgpCxWY873xyvHaM7Wy09F+MPDLA1vyRz
 nCpkwOdRnwPy/ePwidzD5ha7HJmafyrgwLpvplA7YmjMaIqA2V9DVTtLX/dW5I5V7m0yhMIluyu
 VTBNqjOLTKXwtc
X-Received: by 2002:a05:600c:3115:b0:493:c862:3f2d with SMTP id
 5b1f17b1804b1-493ed78e5bfmr9452105e9.5.1783584049543; 
 Thu, 09 Jul 2026 01:00:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f2e56sm48230945e9.13.2026.07.09.01.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:00:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CEB066013D;
 Thu, 09 Jul 2026 09:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Amarjargal Gundjalam <amarjargal16@gmail.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, Julian Ganz <neither@nut.email>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Jackson Donaldson <jackson88044@gmail.com>,
 Weifeng Liu <weifeng.liu.z@gmail.com>, Roman Penyaev <r.peniaev@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 7/9] contrib/gitdm: add more individual contributors
Date: Thu,  9 Jul 2026 09:00:37 +0100
Message-ID: <20260709080040.4157324-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709080040.4157324-1-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

I'll only add names explicitly acked here as its quite possible people
are using different addresses than their company affiliation. Let me
know if you want contributions mapped to a company or academia instead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Amarjargal Gundjalam <amarjargal16@gmail.com>
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: Tomita Moeko <tomitamoeko@gmail.com>
Cc: Julian Ganz <neither@nut.email>
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Jackson Donaldson <jackson88044@gmail.com>
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: Roman Penyaev <r.peniaev@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Tanish Desai <tanishdesai37@gmail.com>
---
 contrib/gitdm/group-map-individuals | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index 178b393b8c3..42bee15d933 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -46,3 +46,14 @@ amarjargal16@gmail.com
 me@sean.taipei
 kosasihwilliam4@gmail.com
 philmd@mailo.com
+soumyajyotisarkar23@gmail.com
+tomitamoeko@gmail.com
+neither@nut.email
+ktokunaga.mail@gmail.com
+roy.hopkins@randomman.co.uk
+phil@philjordan.eu
+jackson88044@gmail.com
+weifeng.liu.z@gmail.com
+r.peniaev@gmail.com
+linux@roeck-us.net
+tanishdesai37@gmail.com
-- 
2.47.3



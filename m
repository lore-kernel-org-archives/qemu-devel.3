Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50AFD3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 16:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZtTn-0001kQ-BN; Sun, 28 Dec 2025 11:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtTl-0001k4-Ox
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:18:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtTk-00079l-Cf
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:18:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so63862835e9.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766938726; x=1767543526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GT54nZ9xmvP9oNeVAwz9xyAGQyRqv62EmxxVW6/IKg8=;
 b=pP/5BuFYULjUJihWc/vR2Ix4g9StY5Vqk3boJyI/i8LnUzaaSPXlpe+gw+jkYa1Sqk
 pMxnH9V3m6LYaPQPw1KqnmE06O1QtQ7WmfABdDUg+W6LkzxXeKzqx5WUtUb6HR3l5L0x
 b3YouPrgZ7lXhk3dNLajn37kBxPrs73gim4PIEpg4HbfUaOvvac0TW5qQMjeUoBQ1ZnQ
 zWOVYZe6i4/u47KUpUWw7lQlLCjN4M/9JwNXEEW6ViJLtKOMvCOvFq7fR/OPqOvmm/5Z
 6/KSYSpMEZuJTwbrgxzcZZ66oKuDPg0KyKYKApkllXFs0c4vyD4sHAZVMLHR3xJenXOB
 QnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766938726; x=1767543526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GT54nZ9xmvP9oNeVAwz9xyAGQyRqv62EmxxVW6/IKg8=;
 b=ibFYV3xH7qmlqt7JyXCzdHx7axweebQQIkLFhz+Eg9KKRdFaSqgALlhKJM7DKIks/l
 BIvpApt95AVjJvBQDDkQ10iTfE7m32Mfhx2MZVapUL1S50MNTFrzs+srd6A6xCXEO0Hj
 G3LLotVI8RHRjKhCXuNaUeDGNNQY32vx+n1BV+GcL0rWIUnnL0/uRssWxvS/LaIc1gjI
 ipcCimG/mEnw6b7manO8jhY6ZS/txP4YsGiN1z0ZL1t5O8Nlzbpal/nN0bWs+meoTJLT
 bm63+eK6X6P7+9lYEU9tNuJWXa2JvV3YsRmSB5Sb3Kpk1C7Eg3E+JVChv99xxq8uacnP
 zSTw==
X-Gm-Message-State: AOJu0YxZNM+8mQOaNooXXrslQHmw82ODUx04WUlaYwrODt7TjJwdJSkH
 vHFtxIn2n5akpARu5XHMgXzPGCZGRVIhZtSNrUh5d6KLzDZ243J9aTF1I6YKohsA8I4VXdhEsdQ
 /O+BL
X-Gm-Gg: AY/fxX4Zu3vQBZopKiu+jXXC4gZkYZe22ZvW96ZRXJDNktwNuHDku9M22Jj781RoyWe
 2PBMEfF1Hr+UOWPmDnpBdIL+JrjrNHLzc2P1AOInq3ZfD3gEFW8z4ICIlXWVPhD2mWlFKSC8wKc
 F2dhvBUoPvRp5ANRnjL51P5d6suefqlSRVTdwoj7GWgg4Wxl2X4ar5w1SyylSa3mCS9FlPquIEU
 SfaxSpU0WzAgeQ2UR581pCZ9M6ynzD0lQTrwZRcdQSJQxjIOhISWRsn4n1oKRVExbvS7lVqEhay
 zPawv0MQuA4G50f4L+r3FAna1s2r47OlGcicaSRHDdGzphp/38kZmceL9TjoZIldWU4Ey81kSJW
 JDFMyVj8f4EiJmG/jzvedFA5Jm0Yy8S8qKefmLOB5LzJgU93Ymz3b9Laj5RaWB6JszDDziY0uwT
 QOc3klY+bIuDYYN9Gza+YsU8/SYhROLRkGtAglCLEsPK7gIf57XfRZ
X-Google-Smtp-Source: AGHT+IE5da6Nvd2Pe0jEZMKPwqDlROZ4wC/JSfLP/9njPuqrR2LmOlmsFbYeFe75zANT3LOnuGKinA==
X-Received: by 2002:a05:600c:1d0a:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-47d1959f72amr328931545e9.30.1766938726529; 
 Sun, 28 Dec 2025 08:18:46 -0800 (PST)
Received: from m1.home (alyon-655-1-564-32.w80-9.abo.wanadoo.fr. [80.9.105.32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b82a58sm23855256f8f.6.2025.12.28.08.18.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Dec 2025 08:18:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/3] system/memory: Remove ldn_he_p() and stn_he_p() helpers
Date: Sun, 28 Dec 2025 17:18:34 +0100
Message-ID: <20251228161837.12413-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251228161837.12413-1-philmd@linaro.org>
References: <20251228161837.12413-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

ldn_he_p() and stn_he_p() helpers expand to a plain
memcpy(), but in a convoluted way. We are not using
them, just remove so we are not tempted to start to.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/bswap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 65a1b3634f4..b77ea955de5 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -412,7 +412,6 @@ static inline void stq_be_p(void *ptr, uint64_t v)
         }                                                               \
     }
 
-DO_STN_LDN_P(he)
 DO_STN_LDN_P(le)
 DO_STN_LDN_P(be)
 
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D47C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDSy-000798-2Q; Wed, 29 Jul 2026 19:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GYlqagYKCjAfUfgedSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--titusr.bounces.google.com>)
 id 1wpDSw-00077D-9x
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:34 -0400
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GYlqagYKCjAfUfgedSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--titusr.bounces.google.com>)
 id 1wpDSt-0007Gv-MI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:13:33 -0400
Received: by mail-pj1-x1047.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so2520245a91.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 16:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785366810; x=1785971610; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N9LG6dG3goSjvKzksT9K58D3H3jHh9Zchpi/PnZxLks=;
 b=G1s5wXREBPyZ7YywoSAAVWDbLW53jukNZVfqkyMUUYVpw5EdZC7NqGAbtp6tMNvsRw
 Tz1nDZx0WWN2uC3JxIFef4N1VKwMxx20CMIKRvUYu7B01EN9BksYkFzLAqBb/9a2VOKK
 dGiv66k/wZ5wRyUl9vZ68ksanN0PTDF3ranu6eZaK4TcBDU8s1G9XYFF4/zBPqXNE2C1
 P493XdYQ0513dREdjzdReyHT5mtgB/f4+2ORc8KpXfw9DUoHXRN/se4GZDyfFV9xEoKy
 AGOvagA4FbsZyhvwzipbOkosheS1/P1qY6dPC4sHYV0Q+OARJSrLlw4cV9b5bbr+Igd0
 Va3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785366810; x=1785971610;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N9LG6dG3goSjvKzksT9K58D3H3jHh9Zchpi/PnZxLks=;
 b=SNbJ4NVFGcoRM9XeLDGyBYM5zCFiyjcxevpDRjKYNEYXRO0iM726lwUeMG2dYf6OPi
 uUGHzfkwYBUsjaLxQTtrgaaq3XhWnGsoBETlLcGIi8laWubRrol25eawjjU0KfrdzqOJ
 6KPgbXRgjDCwFTUA6JfZK55+hOQ+vpI2TL6SABMm9Wt2yNVKatL0a2COSCnLuAJk0Gcc
 fP8tDWdSiTWj9/ROrhFj8hl8X8DqcL6x5YNQhYZi53H/HHIPv6WnLfcw0tlsYLqr3u85
 /2CiYKSZLQmuV0hz076DeGBrKyDlYjhLaE8+iK0LozlHINd6RRrAUvzo3SM2NlD37IyO
 Hr3w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpitO0iJVh0M0OO8BrtIgVtNrnAfioQWtgLgedWMHF70nbZW2RFjhkCRZ7FFInNjcSFbTgzNaPatBrE@nongnu.org
X-Gm-Message-State: AOJu0YxRg5dy0dKSv6DN4i4BOh61zBgheMPsHbx36NIyBEqZJTXp/2gp
 HBHZPj1EiKLQmPsDyF0hd0IMyYT4Eh6EiwAb+JS3xtfN1CMIIcg2qZx6VA2nfS9gINsGM0/Aoua
 h3Dbi6g==
X-Received: from dybdr30.prod.google.com
 ([2002:a05:7300:b29e:b0:313:d984:da01])
 (user=titusr job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b84:b0:38e:5964:97a8
 with SMTP id 98e67ed59e1d1-38f9bd87177mr213677a91.16.1785366809728; Wed, 29
 Jul 2026 16:13:29 -0700 (PDT)
Date: Wed, 29 Jul 2026 23:13:16 +0000
In-Reply-To: <20260729231325.3808993-1-titusr@google.com>
Mime-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260729231325.3808993-2-titusr@google.com>
Subject: [PATCH 1/8] osdep: add DIV_ROUND_CLOSEST
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1047;
 envelope-from=3GYlqagYKCjAfUfgedSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--titusr.bounces.google.com;
 helo=mail-pj1-x1047.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This is taken from linux/include/uapi/linux/const.h to match the driver
behaviour when reading sensor values.

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 include/qemu/osdep.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1ec5b42230..08f87c9d61 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -522,6 +522,19 @@ void QEMU_ERROR("code path is reachable")
 #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #endif
 
+#ifndef DIV_ROUND_CLOSEST
+#define DIV_ROUND_CLOSEST(n, d) \
+({ \
+    typeof(n) __n = n; \
+    typeof(d) __d = d; \
+    (((typeof(n))-1) > 0 || \
+     ((typeof(d))-1) > 0 || \
+     (((__n) > 0) == ((__d) > 0))) ? \
+        (((__n) + ((__d) / 2)) / (__d)) : \
+        (((__n) - ((__d) / 2)) / (__d)); \
+})
+#endif
+
 /*
  * &(x)[0] is always a pointer - if it's same type as x then the argument is a
  * pointer, not an array.
-- 
2.55.0.508.g3f0d502094-goog



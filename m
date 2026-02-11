Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F192ECD6C7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 17:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqDrF-0002tT-ED; Wed, 11 Feb 2026 12:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqDrD-0002tB-MO
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:18:31 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqDrB-0007vB-3t
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:18:31 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-824a6f2d816so282950b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 09:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770830307; x=1771435107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whxGahBJxkeYo6ktKSANd1JATKJnGCD6q8wLBcqW7y8=;
 b=Kg9xSCrWy7mQIvloFvizUxE5u6F2NXkxkJzZ1GMb6dgS+gw3gGhPBaXf1DE4BfaIja
 RBue14t2YorqMk4w2b6OrZzouvzKZ2Is2570hdllcpRSW2nqudWmYYgGV5pHGa7j2cj7
 eDIq4qVmXQ2eP16kMd+043kncZlt1ADhijIwKS+R2ExeRnGVIS15dxvI9tE6Fna20Fjd
 /HEE25x8K9JTJXWDmw9wWgYdTZZYCGFizM2VOPqE8ch23p8WW+fHI9o7EADZgHgd1Zla
 hq/7JdVWq2vtFYo9TpjlQ+3Fd0udytcHzFbRcz5njjZg1jGDzk+PVbdcrBXDmDASnkzG
 edDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770830307; x=1771435107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=whxGahBJxkeYo6ktKSANd1JATKJnGCD6q8wLBcqW7y8=;
 b=UywX6igpNFKcWTMPsp7lNqQij9maV2fBQxAN8I9Eb9Xw29lTAvZby1Uc+AA5G6Waaz
 4wWMLa8zyicN2/b/IvHMKaWMB++hyvmJyCthZ/xt1/GW1OQUeIogQ3di+dN1mvOnr/8m
 IFyFoCwDK3RBQiUsuusA2uA2qq8nLWIaXoOUXY4wkJMIX5itLcGULcUxJjzCZ5nHE3Sz
 Vxr7U/JJJI+md7z68M3voQ0cv3xCCVPF27X4VFF+il9qriY8SAjjkuq7OPODi8YiPoqq
 paF/8MO7SuzD8Xn344bHy4JKVM9/oBwlxkb/KTzB1p5Iy8CtC4VqDPL8+HF2Lf4PNZir
 Z4Mg==
X-Gm-Message-State: AOJu0Yy6UKcbSA+O06hj+xdpYzSyc7p7AvDgkgURV4mtAyflSBDPLE5J
 y/fP5/iB102w8VerT4tM4JbIi2wY9KuOUSqTVsyxqnaQo3arX0j1yrhB3f8Fmf/3lRJQO5TPyw0
 QzeNT
X-Gm-Gg: AZuq6aIXf721KQXCPdtYvvxFDBi/sOGgzVO1ZavOeyN5FcFZbrcjCZIpmUGbjQKnjTt
 2BkHOz/jR23OeGMoex9OdQwQkiczOk19IVuGxcOQOtMY/QoQ9CLSVh7JoCvqOflOpEpt0KYmLEV
 wSnf7nZnXLe3LSsB6xJ95IgDTE7qiir/R4Nem718D7RAL/BpsVaWuRDOc+qYjt1YXMJy+pMIPd7
 GkREoPF/9soFE5Bo70EkfWwtxvEka86AzrLNAg6kuwXnryYFQ2MdMzRrR+1J6u0MkcATaJ/0JfR
 OLue4FAeTr//HNs+8Mh8sU1qtUnu4/pfqX6wpQ64x0Mg9HJQyD8MLwCnM7kt43bECQx2Tfl7lBa
 FTSArkR+PmyDkeXknPxuvr9z26tz8+2xFc+WVy4mXX6DGmqdXXgrLqMT7cDmQG1KHBCVPM0AKua
 /XWDeeFFgfcSmu7xqk+KkY4qjbQMoA5+swcPZ93UoRrtlWpJKmqUijyy+W2OLfeDNvSTEQLrvuf
 ROo
X-Received: by 2002:a05:6a20:c793:b0:38e:9405:beff with SMTP id
 adf61e73a8af0-393ad3b6d6bmr18248142637.65.1770830306630; 
 Wed, 11 Feb 2026 09:18:26 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e197f5e17sm2730459a12.25.2026.02.11.09.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 09:18:26 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/2] docs/devel: s/most/most recent/ ``probe_target_compiler``
 call
Date: Wed, 11 Feb 2026 09:18:16 -0800
Message-ID: <20260211171817.3089906-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211171817.3089906-1-pierrick.bouvier@linaro.org>
References: <20260211171817.3089906-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260114102522.4044591-1-alex.bennee@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/build-system.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index b9797a374c7..e746bf81873 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -88,7 +88,7 @@ and operating systems:
   ``$target_ar``, etc. to non-empty values.
 
 ``write_target_makefile``
-  Write a Makefile fragment to stdout, exposing the result of the most
+  Write a Makefile fragment to stdout, exposing the result of the most recent
   ``probe_target_compiler`` call as the usual Make variables (``CC``,
   ``AR``, ``LD``, etc.).
 
-- 
2.47.3



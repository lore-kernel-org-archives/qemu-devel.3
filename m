Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C98BD33994
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsZ-0005aw-2W; Fri, 05 Dec 2025 11:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsC-0005Vu-KI
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsA-0005kv-TG
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:36 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso19698495e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952893; x=1765557693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sObp8UBrI/xfgGGLKvYX8yVXYXP1HQDePXzaB7T+dOo=;
 b=z3Dv0nZA2M8Rjq+FzKRdOpK0m+pyRPzGC2myen4RslNUCEwjrl3FoJLxILFJ5QGnmU
 xjgsGvvwfychwLwEuXY2AB7p9o5UxrjyY+ajW2jI40RVquz+qLpSEfoH/E8hHQRGTrYi
 GceiDOJO962YqpIhhWZ5asRC+PDeQBupvqbkccsufiPR9DbaMRL5jfrnG+9t8LKL8uzy
 AqOnoinp8+LA4rCshrh0VEeLrkqGQGey6cS8OIZvrbR7Tf/HWO+v8hLek46z+d1tvIOi
 5E76/3kp28gerDjKk3cU+fWqucgPU3eoNiKAx3/ISWhMyNeIuNJFUlM7JiGQ8m3fXu+k
 v+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952893; x=1765557693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sObp8UBrI/xfgGGLKvYX8yVXYXP1HQDePXzaB7T+dOo=;
 b=RaDoNB7h7vnyxwqRawJkN4FihWZfVzkefqDWGHnTP2EO92Tgj5EOGrcnEvVx1x8i3+
 uX6eLbTEVZvJomDD4G2cVxV2UgTQggSl5w3pJFsEynTlifZr03RyIkphKbXeVPeOSl9H
 ow0u1jjd7t4LSpeymz2r2OSO4FZtMQjRrbBExU8VyU1hofFgHtq6x90jddg2Qy7dPy8U
 NRcxPri0IgAyLP5ZRirITD3pG3d7Q46PuF5T7kNJLQvEh0RectFo9ew/g3A7ubtrYyru
 FWxku5DEgeVwgW/FwE57myC4m7FCYrCyGUMgLDHaSBa6lNVHjTUxWqWmuRHk+Upfenwq
 MM8w==
X-Gm-Message-State: AOJu0YwF8ZublO/oXUd63GLo0Ky1ltaAiYcHVC711t57iN2rXpSpkvyB
 e9oqCAgX9/ghkySSJx4yqpFW/oM/Tm27Drlncp+vLY/2OsdC9S81pmIj/m6e/B8kvDkN6YI74KQ
 sgQQr
X-Gm-Gg: ASbGnct+9dC17+STgVsuP79V+0PmoL/dfTqW9jJZkUViRY3vDb8Umd2FkGJLq+hy/Nf
 iK2KqUXekCkU3wvMZonUBKbNLUwRpTekkfwSrn7C0ihrLf3YlEJcuhhjha9DGEK8X1DFHv135FZ
 gDhI/1dq1YXQfe6i79aB/Q+m46TnbapTqLy3CuCHrdANWRGBHEUiXWuWszZsJb1zktXhGJPO33L
 4g8hZPfpUa3qVF0gF9E9ClLf0B5hm5Rypu5mItXPmIZOzKMmWjYDQtnB8ZZcvBl7pxNTVeOv/B9
 5UaGjYNbXOeXSXu7QehQtuNXRgIHj9NmyONGYJRI2HUlW6AO85T7cff1S3XROCLR07teTUDX+bn
 G8HrfoZFILj3r+cMharPnC5k4yYeq50rpKAKXZlAnEVIFcQ49cg6JeS6a5FdrOJL9LFZQl0snsG
 bzj4Uw6S8Z5S4=
X-Google-Smtp-Source: AGHT+IHtwhlq0bKrqskxc85ZA7g4TVrIWY2d6mw1vXwIpNss7AXqpn0XaNkfXahrrBF9dnguQhUyTg==
X-Received: by 2002:a05:600c:3151:b0:479:255f:8805 with SMTP id
 5b1f17b1804b1-4792eb10e97mr79887495e9.4.1764952892827; 
 Fri, 05 Dec 2025 08:41:32 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4793091c740sm87256255e9.3.2025.12.05.08.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E90BA5F90B;
 Fri, 05 Dec 2025 16:41:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alano Song <AlanoSong@163.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 10/14] docs/devel: Correct typo
Date: Fri,  5 Dec 2025 16:41:21 +0000
Message-ID: <20251205164125.2122504-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Alano Song <AlanoSong@163.com>

Correct typo in atomics.rst

Signed-off-by: Alano Song <AlanoSong@163.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[AJB: fixed author entry]
Message-ID: <20251204194902.1340008-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index 95c7b77c01e..ea4ede4b8c4 100644
--- a/docs/devel/atomics.rst
+++ b/docs/devel/atomics.rst
@@ -266,7 +266,7 @@ Splitting a loop can also be useful to reduce the number of barriers:
     |   n = 0;                                 |     smp_mb_release();            |
     |   for (i = 0; i < 10; i++) {             |     for (i = 0; i < 10; i++)     |
     |     qatomic_store_release(&a[i], false); |       qatomic_set(&a[i], false); |
-    |     smp_mb();                            |     smb_mb();                    |
+    |     smp_mb();                            |     smp_mb();                    |
     |     n += qatomic_read(&b[i]);            |     n = 0;                       |
     |   }                                      |     for (i = 0; i < 10; i++)     |
     |                                          |       n += qatomic_read(&b[i]);  |
@@ -283,7 +283,7 @@ as well) ``smp_wmb()``:
     |                                          |     smp_mb_release();            |
     |   for (i = 0; i < 10; i++) {             |     for (i = 0; i < 10; i++)     |
     |     qatomic_store_release(&a[i], false); |       qatomic_set(&a[i], false); |
-    |     qatomic_store_release(&b[i], false); |     smb_wmb();                   |
+    |     qatomic_store_release(&b[i], false); |     smp_wmb();                   |
     |   }                                      |     for (i = 0; i < 10; i++)     |
     |                                          |       qatomic_set(&b[i], false); |
     +------------------------------------------+----------------------------------+
-- 
2.47.3



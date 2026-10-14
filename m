Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952F1CC6B30
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6xQ-00007T-8B; Wed, 14 Oct 2026 17:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xH6xK-000078-P7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:56:14 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xH6xJ-0005Jb-0X
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:56:14 -0400
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3D6D33F920
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792014969;
 bh=G2hpG13YabfCyUAcMOEObGBz9CyjT9IcqeL+5/8o7RA=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
 In-Reply-To:To:Cc;
 b=BuJoVRa8cTjsr2SE3859V/x30jt3dK09APzv2OopV/NVR+LJofUMI37IEUwMg48TS
 WWeV8WvC7e1vOn3XE9qjg/J39lf53VQnMRQflvoz5wf7fZNZ9Iacz2YevZGB+wE1+r
 5tNpOEP8K4XB95cCzhEPDZnXUgvnX4ZXG8RcnY6wxRPt7xtzzJbu6ruUPfxK1DNTqh
 7c0nS23UYf7PynI0IfQm00SzHYBH3jT26YvncbzKw35N5ttHMMG1S8rPDu3ztbDc1M
 omIeIqtUGmWa4viNFoW+PpyRZRfdS117vvp4oyPdofE+3W954evd5ZMUn/lFs2ccRT
 ReRy85KU9qE3m5HnwVPDMSRWEPVJ3NIEs28S+dKBujpUv1B0TbG7/i8y1DlH4Aidbf
 jtdLUASAC54SCrCx6sYf18gQTi7MiIT+/x9w/IBuqOeOvTdOVCYuq+N1GjjJc+uqeb
 MwspvecB+0w5phtBizGJBM41LemiM+//4T4Hac8yUkn7nr6xMZJ/el+yz5FH1baRSn
 mWNpczj8nms1OAQHsu09LwgyqRHr9pa/UHLAM64DG0XAx0AbiQ26eGsjwedkp4pyeJ
 r6X8gLmRiRBpzsZCC9g0no3OWFeu0IrG0DfCCwMsw+0J4A9O0gTEfPdFz4ovxmrIYa
 Pve5ZlPZkj9YJQcGapzn8YOI=
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8ace1d95f5eso58042557b3.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792014968; x=1792619768;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G2hpG13YabfCyUAcMOEObGBz9CyjT9IcqeL+5/8o7RA=;
 b=Z4OmRUv4b4jXnUSAd17Tj/V0BYdW0R/EzOKBJd1FiGoGBuoN3Gnwyd7hLp/FN9wKI6
 XXT0TJk5DNFArCc51rKDSZiN7v5baQvLuAmPRZOFBE5HRpW2Ccytt0L/XZIIFcJRa8z5
 64xM3dwUCdsEL8jyB2y+9PFI/HImBRDF8LpH8v2GT7N4/8ikv83YkJeuguo+bo97TVue
 Sc4mZuYibqNU0v2kSHAtTODhaPaxGOm3M7/qOg3X84rqSn7X/vtNWNzl35iIGLQeebVx
 yBGvvJ/odxl/odtv8KOZVeaAul+FV0ysx6DmKA2JKxQFYIm3UWKbzeiCOAE8ngmodYK4
 JAPg==
X-Gm-Message-State: AFq9FYJfD1LmNW3BmX6SGHfPaD10d8IQraSo+/1n9zkA+ercg6IXTCYp
 6swjit7xyCzp7T6gtDzcvpuN1Hq/3f1gOcvuYjO39LxP7Ffhcj3fEHrgId3fwXrxMkhjJieoHz0
 HyzXWBNTr+xftoG2D4mZDdi9nTRQzaGbHTrL+RkaIYyMfZHsrScLqXw8IqDp3tRo8gRygaqTe
X-Gm-Gg: AYBFou0tOYtyEc0LnqjbtFXQZpPZAbKn6H3AhRC5htDUurS2tx/UnhfIGNjLJwGNIC6
 2Qbje0iJsmWkFLknNfL38yzUomjhPI8R5HbdeMfySdp/QCGcCOLZwrxvh3d6v+/wynYfo01G3hp
 N5VHvZggFUv5rzr+S5eDk7XJ8M2e2D14hu0Y5Qgc+ZKI+sUNZKsa2uEybpWKCjrvfPhBM4Ej0Ld
 sXWUGyEuGh7Jk+IGzogRIIuRp8Wh/AhpjEP1mC41CGSwPxmgNb+ImQpUO44vd337EeaWwSmW6L5
 1+TlkVxRTVkllCPneBJDWkEMy4CIej9llFZsSZWxO867443ivDnFSGGQqlUuo4QvInHktWvNQps
 3fS9yXGQTEQ/Xgnr5x0ECCdhIWknORle7cGvjm1xSIe3mmwC2Yji/FA==
X-Received: by 2002:a05:690e:1446:b0:679:9afd:c0d7 with SMTP id
 956f58d0204a3-6799afdc9famr648710d50.18.1792014967997; 
 Wed, 14 Oct 2026 14:56:07 -0700 (PDT)
X-Received: by 2002:a05:690e:1446:b0:679:9afd:c0d7 with SMTP id
 956f58d0204a3-6799afdc9famr648701d50.18.1792014967684; 
 Wed, 14 Oct 2026 14:56:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:6c45:3000:1420:7d2b:a0a2:5b86:60e4])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6799df67495sm201283d50.0.2026.10.14.14.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 14:56:07 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Wed, 14 Oct 2026 16:55:45 -0500
Subject: [PATCH v4 1/2] util/coroutine: trim sysctl's max_map_count newline
 before parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-set-default-pool-size-v4-1-a3aff89b94f0@canonical.com>
References: <20261014-set-default-pool-size-v4-0-a3aff89b94f0@canonical.com>
In-Reply-To: <20261014-set-default-pool-size-v4-0-a3aff89b94f0@canonical.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hector Cao <hector.cao@canonical.com>, 
 =?utf-8?q?Alex_Ram=C3=ADrez?= <alex.ramirez@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=cnXWUgGXywRy8ir9sJQn0UoozXdGanK56QieQtHLDm0=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBqz/p0L+4312y70H63fjvPk3YCyTF9C4VOzNhcX
 7rfqshY1fKJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCas/6dAAKCRD5KICs4jod
 ufpOC/9QWdgP63/6RIBuQDcOf//zuONYca/I8Y8RYqN9McfytOV0TI4LsmqzgzjyKmj2sg7VP5S
 RD9kUjKQmRfmLXWA4fWASsFQJULuZQgnBnoNEuK8OhRkWZ4E7einEHppV2QaxhIQQulW7x99yFD
 tnQOtOGmTyUHYjjcdYITEFmryMoVJZOD8z5mb/zUyoNrWvHExP/nbG8Uq0SqoqKOWhh8zGFOdSx
 Tdt3zrdRsH3UdELiYBc960fPCfaYJTTkkIBUzI+ad8PFCAGAxOJn3A2iMhlBvtHLB+3wa72ACgb
 LIl19uA+qOGhXwXaGcNyDdI+hKwqi5gPWNz1bnssv1Prfrrl/m3rojY5UiSS74bCAA5v6/f5V51
 HQS+s42NPy+dXbU4Q3j2FMJNDqQn4cNANoemZH/U9yegjxezuHQijoGOOhrCl0hZYxZNGGIHM67
 XlKimGEt0MCCLsIPn0djjXV3ptlxw/WWqrn4lMOiZ+sTAL67SzgW4ToobkDgypa71R/KE=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Hector Cao <hector.cao@canonical.com>

Strip trailing whitespace from max_map_count before passing it to
qemu_strtoi(), allowing the strict full-string parse to succeed.
Otherwise, qemu_strtoi() fails to parse the string and returns -22,
making the global cache pool cap size set to UINT_MAX.

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Signed-off-by: Hector Cao <hector.cao@canonical.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
 util/qemu-coroutine.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d17135f585a..5af61995437 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -374,8 +374,12 @@ static unsigned int get_global_pool_hard_max_size(void)
      * VMAs.
      */
     if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
-                            NULL) &&
-        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
+                            NULL)) {
+        /* contents has trailing newline, remove it before conversion */
+        g_strchomp(contents);
+        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
+            return UINT_MAX;
+        }
         /*
          * This is an upper bound that avoids exceeding max_map_count. Leave a
          * fixed amount for non-coroutine users like library dependencies,

-- 
2.53.0



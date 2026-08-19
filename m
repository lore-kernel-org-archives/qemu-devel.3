Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2B8C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdr-00087k-Ib; Wed, 19 Aug 2026 08:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2319317080@qq.com>) id 1wweUd-0004xC-T2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:30:03 -0400
Received: from out203-205-221-242.mail.qq.com ([203.205.221.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2319317080@qq.com>) id 1wweUb-0006J3-Il
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1787138993; bh=OtzBvSYVhAgFr5IyNJf2uKh3cJwzQOkntG30sP2/gfo=;
 h=From:To:Cc:Subject:Date;
 b=WbnbIDEo2C81NqwxKLGMuSxb9FBfdKrVoviTNGHTtHtrSGLdUZOtVGi51E61mK1H5
 TsbRKZPUU1f8SPoxxupWbgMl06+EPATWRzf49QhJU1UxMrRzGHZZg0Q8QeM0K5vkMt
 1qZR0U9D4koPorlY7ZB8gqiLUETBGy1ITWin1mTA=
Received: from LAPTOP-IGSEAVHO.localdomain ([120.230.140.136])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 72A26C13; Wed, 19 Aug 2026 19:28:42 +0800
X-QQ-mid: xmsmtpt1787138922tyu70yifc
Message-ID: <tencent_693FBF28366A6CFA191E6B69C200324A3608@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2maQVV27RqWbAaFoAb0VACqPqnA4OKMNIUaVpsoBlV7jwupRPXh
 NxBlb8bMIauT4n8z48t+lkFRIG5tuae7GKag6YojmqPCs439+aALQMVrtMP8S0+v1g7o52/VhKSu
 RS2s3E42XBHOx10PT+4J9BFLUapATqyVhn3ZGwCKSy+f5NQwhB+Ug45KAbPOGf6/0opkEkzBRVWP
 p/izcwCPqnkSMVWcu+FapzAzNZWR0X5/D/Iq2Igk3XIgyydBi4rtg1xfoQ5uaW8df/iJm3v3pOf5
 cydq66sKqaS9OTFkSBzxE8O+vzydo25+POqhvHDPHyiJhwVOxOFXWrC10EGvVjmiO92K3+wahSJ6
 SAlx3stahxQMU0XvBcP/ouSsABZ0/zqiLCKtl1b6NG86+1R2EYvV1TwBsAAGNutQyO8miFP0PvCZ
 RfXRIBKfF8tAHwksZESB9PkHrinbjm8L4K3n8bbeaXJT0lo0Vfh7LpCjHPyiuPh3HnS2D/nyNwLC
 X9eAGO25rKZWuNymwlQMkNWBE2aYmaqV9znVpDutcXOcrENY1FKxNmUKtKDC4RzBls9ExqE7ASnC
 X3OaH1hMlB4F2hoywU7zwgTahtD2BjlxEv06W9WcdusX6OJqY38wdjh4pzwJ3a5wuWTQxuSJzikl
 mMofFPMUF7E5dT7dACzVBSEmc5UYprGEKbnA2DNFaFRZMdUwLX3KsyTXnsrjSn0U1D+FWexJktFS
 XFHT3pw/P1tWybCT6SukOn8p5B8aUyr2TLZwerZIo2+vf6wjmVkcSTaOYlqZ7Z51zcBolmRKpLF5
 LaZmi7t52j1zDLxkg3wuc0Y0/QmaCZ1vMyLCkBmJ5x2zjsuguqwzL9RWP/dUhrTmjviWN5J43Uy4
 QsoVVTG9MnHBHFABAIY3N8O6VzlHThXX5OfmAoxJWNixubgRaEGRRcnFgO40vIYq/kS33rJNVveC
 tILEFLUifgxwxA7GR4GuHUWJ1API8tNG42Ael7KVoSx/BitR4l2yfmTVdYomdSta7mZfvpqoiZO3
 R6ZDrfr/YOYCJxJU9YkZJH7D3jll1YigwIvTTiBAMdh8wUDNjCRjMaQbI7pIfNs9cq9BYVpw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: CMoments <2319317080@qq.com>
To: qemu-devel@nongnu.org
Cc: caojunze424@gmail.com,
	CMoments <2319317080@qq.com>
Subject: [PATCH] util/log: Fix rust_fwrite() to return bytes written
Date: Wed, 19 Aug 2026 19:28:40 +0800
X-OQ-MSGID: <20260819112840.8270-1-2319317080@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.242; envelope-from=2319317080@qq.com;
 helo=out203-205-221-242.mail.qq.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:43:31 -0400
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

---
 util/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/log.c b/util/log.c
index 7cffbc1bf89..0a8800f8d2c 100644
--- a/util/log.c
+++ b/util/log.c
@@ -593,6 +593,6 @@ ssize_t rust_fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream)
      * portable access to errno. :(
      */
     int ret = fwrite(ptr, size, nmemb, stream);
-    return ret < 0 ? -errno : 0;
+    return ret < 0 ? -errno : (ssize_t)(ret * size);
 }
 #endif
-- 
Signed-off-by: CMoments <2319317080@qq.com>
Cc: caojunze424@gmail.com
2.34.1



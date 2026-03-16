Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644FDF506D0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28GU-0000Ln-PP; Mon, 16 Mar 2026 09:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1w28GE-0000KZ-5g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:45:36 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1w28GB-0007jn-BC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:45:32 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c73967cf77aso1893237a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773668725; x=1774273525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lKzaHx+Wi52OVl+z1xZ02SryYfJJFZ8nqsl4Qmpqnhg=;
 b=DYZuiX+VIPW+7PMSgHkQf8IjHsnLZpyXpXd+YSDJtiMKdvOGaJBxSSu8L83S8pIOdS
 1plOi6yskNzgXKF0R27P7urVE3+0MNT2lAbf4URxYXCcNY6At+raVoLDd9vNb5Xl+a6a
 4teRF3mF6WUWOxNxTjs9QyaAKQ3QVrOm41LeTfWzICu0W4hOaeq0KYOlO4WFElIUVXUi
 9P5s0pKxELgAbNnFMVbdrkurCiyjZEygmwItqgviLwudPQXRx6mjEuS14BT7LfeTXJ1F
 KrKniFHLkxjPodX/NGrt72YkmMyrKhJy+Uvuw/drOq0H96ROg07KDp4LG7UuLFZ0snBI
 u0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773668725; x=1774273525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKzaHx+Wi52OVl+z1xZ02SryYfJJFZ8nqsl4Qmpqnhg=;
 b=tNywzmAeu5oVsFPUdw1lzfl1UJbRRtfJSGMXnLb5NcObNGZBuxo9uiIURXWlufRQ+r
 1oFKD/5O9pAtT3vJY6mkb0tE6tS4yJ+kXQtqP1uxEvME78dTvFs659MFER5r2cXKF6M5
 TTQdfX3H0TMRvRLw37tnk1fchYd2Pk3XYo26sN85zJlcSGsb9C+kDyET0+tc6X7KZOLH
 ssn6QDRTDScPgaN2+Zgb4bxlVhTXGWgND2LhsaHfgGtg7v0cwCEyZIT37hVQkv5qoRzH
 H/UmrqshyqkvlBpK0S2LrJ1A2YWiO2yFe/IcX02UKk1vUhMzbQ8QvL/8yZ2PH6bFouZ3
 Jctg==
X-Gm-Message-State: AOJu0Yz0Ces3GGihX2wsFp4LSvjNmUvmoQgtDngs7TaNNOe6zuhTV6hG
 6ZL7DnDKlVXQlsFzuzWwaQ7o0AC/Ub/f9z8l0vwa99q1BlOocZvvqLr3aE+yheRPgEY=
X-Gm-Gg: ATEYQzx4Delg/GAILBb2M9G+0tOZb7LOI9AVr8IE6WK04+0P3EXBUqj9qcPbTjUYb/U
 /idDxMc1qg1jRcCmuBRD6wYWGQnNja3EecC32kdwrY3KFKq824am9NFqvWsJi3LslFaFgkiUxw+
 WZqCdGqioUkP5RYxb/0CU/nG/rN8xwez3KSVn9D6FIPqPnNVv8Ac4/Aqtb12A9A2srxTF38ERQP
 cqyLnw5TVzDHtXuFM6P8sPCgqXcBQGS4AGf2pzvDo090Yb9kJqkT0zDFYQwvTJMWCX0ng47vpeh
 /VJcQ/A5MaSx/qw/FEylIcYngPWh+UizbgVngFzkn/0fAFXs4hUzfUgpOSJob8zY5Rub7MJaheY
 StHV1jkOyC8D72hhOlGPc/pPYcTTwJGg6SsrpYyh8BcS0Qaj5gmDHjVAMQOUyHulCXyDb7+c7Pg
 dA1Z/G5XTC157ZOpUyptlBAsYsvoX6Ei2MZg==
X-Received: by 2002:a05:6a20:3d8a:b0:398:7866:e8e8 with SMTP id
 adf61e73a8af0-398ecb32b63mr12663503637.31.1773668724928; 
 Mon, 16 Mar 2026 06:45:24 -0700 (PDT)
Received: from setun ([2401:4900:57f5:298b:f6c1:986a:6482:b685])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73eb998e42sm9139848a12.12.2026.03.16.06.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 06:45:23 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH] migration: fix implicit integer division in
 migration_update_counters
Date: Mon, 16 Mar 2026 19:15:09 +0530
Message-ID: <20260316134509.157964-1-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

switchover_bw is a uint64_t, so switchover_bw / 1000 results in an
integer division. This value is then assigned to expected_bw_per_ms
which is of type double. This results in losing precision and is type
unsafe. Adding explicit cast ensures floating-point division.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index f949708629..7094080285 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3134,7 +3134,7 @@ static void migration_update_counters(MigrationState *s,
          * If the user specified a switchover bandwidth, let's trust the
          * user so that can be more accurate than what we estimated.
          */
-        expected_bw_per_ms = switchover_bw / 1000;
+        expected_bw_per_ms = (double)switchover_bw / 1000;
     } else {
         /* If the user doesn't specify bandwidth, we use the estimated */
         expected_bw_per_ms = bandwidth;
-- 
2.53.0



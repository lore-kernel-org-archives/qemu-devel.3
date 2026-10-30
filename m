Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CE606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ixFbBRi0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMold-0001SX-BL; Fri, 30 Oct 2026 11:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMolU-0001Qt-FL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:43:37 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMolT-0002gI-3Y
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:43:36 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-35b2c599f43so2023743eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793375014; x=1793979814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4oJslCqw5QT26/0bSkwr8n680kMYH56AQ1nDMmhvXXk=;
 b=ixFbBRi0fbCOFuRrPm+liyPvF6h3JSU2Bu2I46WxW44viPsyYDlxmFkhe49TCOYjVL
 ulFUfkLuNo2wBcSXJs7rPZzSpZWS7nYT9YIHBSkgaNWClEzVEEeTLdhRTI6556dXv+fV
 J4lnYd+xqllwMQrDT92Hwz9bsqC+OqB14I2sgU+gCYbMi6n9G+ar62ev0/6ACBrDh7JT
 fkechKqrxK1BpJSUaH31vxr9ndKYzCralpqNf5nU3ZbzXKYfEQ3P/C3mLpOqC4f0QWed
 iZqIioVFNiWsUHtyP5oCWVmmEEv1RtWXfgQbeToA3oOYZPcNizzaVu1/SlPmEYpfmgZ7
 TnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793375014; x=1793979814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4oJslCqw5QT26/0bSkwr8n680kMYH56AQ1nDMmhvXXk=;
 b=rh4w7wcOOhXkepJybmzFbs7L9zEIjyxPdFcxeLgjlMYsywP1T6WVHMjIhfl3kEgfWZ
 z39vYtzHykM+LbZEqje9xW487KSY3WckeLCJwc7Smhsriy3BIRWcbDPkydqjA6zG54eP
 GKXs/1Ww1Hh1tDdntuVR30DVMpEGMJr8haX+na05c313a9bmvqrg6+Ed+dC8ggd90SKY
 Pp90SlNSy5PVW7eheUlc+B0zdDT/HgNxl+/6vyYNKnc7wvAUylIsV8Qp4RM/ZCjpRXPG
 UfgpQBc56e2nSyInrDa1Rjo3ec1zY6WJ8LRf5o2rMQHWtsaxWUVSrE5QfXEuhOj5PN+/
 FmBQ==
X-Gm-Message-State: AFq9FYJ7cj2kBI1kbTVeddAZjZ+Sw7n4iDVUbCoT/9ogA7lIlf3q5tQQ
 FRORjlnhX2KBYvwTAineDgzmKPlq9+ef46q7W+OG5lb/9VyHMlJz7i8lTkDfidCk
X-Gm-Gg: AYBFou1wlWdw8yCJoBRkZdyt7eaD6lCFNMpawHktUY520zJoNtRt6sKQ3t+WWoOJmux
 30jS+QtEj4DvY5AaCRRc5KjU+l4LSjpjH/STyvp47BK+J/yveG6bGBhKPSApw8a+uPWQxADeCYQ
 FUD0zWcnngPdX+Sbl9WNRMqGeLoH/38ekH4r/xoBI1SJdmHEn6ZIR1qkQaHKQe2CXe5ib7qKWJR
 V4OarUrfCKF2+2POVHOHbwec2b1wrqycwr9tBkLFZgAnU+34RpmlQjBB6MoMXrf9kUX991lcxLS
 8kqxFY6z3qZw29FdU3y6s+zHmRp1lmSCWHC8bJU4EhwzOKlx1KJhwmuPje7qihJUptKqfhm7e9I
 vLdV/4jy+A/CHxlL9BOdgfmwgp9Dj/kkWdv1XyGEiof7LoZ3jkzpLHW5EMIIwF2DsVZoIgdXNoM
 3eWpQOhTXR41L0gRjnsrZKUoEjSeQbDOdqM5ocOo7n37AmcX9pZUP22WM3kQeXxmWBhb4e1Eunh
 Jywfyo9zaRZZSC6aVYBR+treFK4/fdH2cXRCU21RKZkUO2X5AYgmYCKJfikK2oF4FR5KPlpznji
 1SYibJhKS3F+I1we+8sTuIBug582Wj0zQP6EQm3qOJcGedoDVxBC9le7vrcw8BN1ZWhkWw==
X-Received: by 2002:a05:693c:87cc:10b0:369:36c9:5848 with SMTP id
 5a478bee46e88-36a4235f7f1mr4065040eec.12.1793375013504; 
 Fri, 30 Oct 2026 08:43:33 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a42a61a0csm9620706eec.22.2026.10.30.08.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:43:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/3] tests/qtest: give device-plug-test a 240-second timeout
Date: Fri, 30 Oct 2026 23:43:15 +0800
Message-ID: <20261030154317.1807-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030154317.1807-1-luoyonggang@gmail.com>
References: <20261030154317.1807-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c2dd5e5ef2b..6c710f8d1bd 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -4,6 +4,7 @@ slow_qtests = {
   'bios-tables-test' : 910,
   'cdrom-test' : 610,
   'device-introspect-test' : 720,
+  'device-plug-test': 240,
   'ide-test' : 120,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
-- 
2.55.0.windows.3



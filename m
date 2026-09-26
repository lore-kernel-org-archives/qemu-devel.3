Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47DAC98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMWt-00042V-27; Sat, 26 Sep 2026 03:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRj-0005JU-1Q
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:51 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRg-0000eo-AB
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:41 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-33be7dfcfc1so2109987eec.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406219; x=1791011019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7wEmknfoBmg3TeWeQqrxAB6fpgRVpCKeiHIEFEVt1/A=;
 b=Vu6gjm/6BrMZ/agQ3kP4OYimlBoDqmd5T8bMKJo7V/L+kxuXoGfu22bMRbJuBzPo86
 bEuq3xAYRxBmiREk7PMG9KtXKuS3pgOjFhJ7GcmypqGVUml9kmYA2l3Ibp+LnVXQom2Y
 oH8uLRAnGPOEH3AtwWwDZ2ktBM0S88ilAqhOwdCH0wqtvYDobn31apzynlt7Cww76hxy
 lMhtAl9v7KYkvyNY9rbvMMATBM+9Zq1KD0Vl+r4ne765zgYUTyk5o6FQZ2vGlA8GK6Pf
 bydtRtSPviWFzXQRrNFU4gP5nZ7ZCZa6CB3sJUgRw4QfPyZuDikuU9Ho3QgiemiI7CcN
 e6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406219; x=1791011019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7wEmknfoBmg3TeWeQqrxAB6fpgRVpCKeiHIEFEVt1/A=;
 b=uJAjavFK7anNbfUQHFn6rMeTinMsla+HzOex6m0sxd4xHiWRssjA5KpZrKPNumAYnq
 IwSzMWGPBFMUd3CcGs5rI3r0wkgHWHQCUOztsVnuCH68KOhlHTjUBNRvtXZTn42xABVv
 RS+k8y/S/jOMfKuukj0qOMIYtgLUDUu5rmkh/Pxk9Ouu3tfinwMV1xyyJcD98FZbiRe0
 nbXj5YLfs0OrIr3x/5HiX2dlCfnoUkGau/ke2zAEay2p7sWlShMn2LFQpSO+GncrH+Bp
 4/ELhYFILHQXTTPougj01RYpd4+n/XK7wu0UZqYTVtLtlcxHu3ffoplwHk3sQES0v0BQ
 ugZQ==
X-Gm-Message-State: AFuF++mZag2y+YGscL0nHpqcg/XChMv+Q6r3hs0Pq70zjIdyrOioABak
 tU+KDOYB1cfK//cVbXzj+BAbPhWZTUrsVhr8OZngB7Q831HldNfkljW5h8kCLD1k
X-Gm-Gg: AYBFou3PA6FVLWdghAwlrY4PA0cfD+X42QflODbWZkmKYLmaJNSX6H5FMa0y/dhf7jM
 yC7E6Xpy687QG9XIWcaCyzHGejbYvGOEHVhideBfyoWjsLgqmhIjFNRGWui2rkt1STg/FuspaOl
 8MrieTI70k0w4lj+GdLxZWURypWxHYGFP5Rbn9xgoYWOtjd49L76hoXJA4I3OUcc5zuaFXXryDI
 J55KRzMziTjXxBtrf2y0E2JuI8jffTCfVAt25ZmhsbF17nUXoql6nI+d/lRua1nUCnO5rHUo3mO
 2D6rtqhcj1idJ4MWLpBIGKXNPJDyIg7FaUtZXDZXg6bfToWJTeeN2Jghz8yw5HQovo7lsHTRYec
 0ODWETw5fy2jLEgjd7hOQtIsRR/ndeJcei4KfOcz7N6QP1Y1hxJol7ww83dlk1m8h88z6Z8LmD0
 y2TGysqTwBax99YJ7Uw3ijnHVhdSQkriqIviGo3Z3P4QTtksCHj2sHuLpuUDIAvveiJxVFcdoOj
 W7x6ScI35qsvL4UbaakIiBLDARl4aY=
X-Received: by 2002:a05:7301:4201:b0:33b:ea8c:811b with SMTP id
 5a478bee46e88-3426fbbeb5dmr2159328eec.5.1790406218912; 
 Sat, 26 Sep 2026 00:03:38 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:03:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 39/55] target/microblaze: fold system sources into common
 source sets
Date: Sat, 26 Sep 2026 15:00:38 +0800
Message-ID: <20260926070057.1234-40-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add microblaze_system_ss to microblaze_common_system_ss and drop
target_system_arch so mmu.c and machine.c are not built per target.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/microblaze/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 9c1ecd1cf1c..93138637bf2 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -21,7 +21,7 @@ microblaze_system_ss.add(files(
   'mmu.c',
   'machine.c',
 ))
+microblaze_common_system_ss.add_all(microblaze_system_ss)
 
 target_user_arch += {'microblaze': microblaze_user_ss}
-target_system_arch += {'microblaze': microblaze_system_ss}
 target_common_system_arch += {'microblaze': microblaze_common_system_ss}
-- 
2.52.0.windows.1



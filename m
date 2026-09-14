Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1F6C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Bgn-0000px-Eg; Mon, 14 Sep 2026 14:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6BgV-0000aQ-Om
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:45:49 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6BgS-00069a-Q2
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:45:43 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso7236725e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789411539; x=1790016339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tgqLGCDswHOXNMCiczOi8KUqwHoDwkmN/cvWbKRFtdA=;
 b=FBR+ADTEcx9MdJ43jm8j6Qn04ZS89VtOzpMlyiziRaWjZbza82EF7fI3Bgjh2jakNX
 D+xdzthpI+5D9z7DZrIaa5rPsBVUgpGrgZ3vqzoaDY/kWeDpKDt42OgKlqPv0YyqVFRf
 HCv3vp+KRIK+oO62uejDR6K3iB+bpVZQ7zj3KcULKVApW8tbnZafUoUgZda/YDqcX793
 M2DHlhWiiqCxQr/uhsrIAKyAHtnwl4LXqzlJKbgXbutaUcZxlpko2RXnMgaNTk4qAdOf
 Ne7h5I3K/en7tGZzD7XNdfOGl58UJymrUL5XJ3ELvdNm4c3sqIMoPFmbjx1lQiBv/lPB
 8fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789411539; x=1790016339;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tgqLGCDswHOXNMCiczOi8KUqwHoDwkmN/cvWbKRFtdA=;
 b=1eUn9CubqkX59P1j2gsD2TYVb8E2eTpi9udgM3PUs3DLHbSBookfZnaTuVG+Tzrr70
 pC/yBedQbf/o7IU3tuQCFMFllUEd/nYnVbNa4jNGumRzhsxQVRnUpoDxONpq/16Gn/wv
 iAa4VNdAqjsuTqSiKrsMSU7zzt62maf8XWBPItOT7SQY5mXaMCB7Zpab+3fEFDqYmlr0
 So6UYgt6oV3bhMGMpojVBWSM7QE6F7n4AIHW+Rl+Dn6/M99u3XE/6UvoUZklt7dh13hf
 1X0iz7pB0OJ2WkYMbLkodU6JUZv8x1D7CDHacKlBRf3+LMS9CfVA2WjyeAQXC5BPjjkt
 9BDA==
X-Gm-Message-State: AFuF++n/3GXcI57/XSeWoDIehnKIbJSGXR/L0e2FQQm7gCUGDtfQtsxo
 G3/W7OTAC6zZ28/coJUhFc7X+DUmC/doFX1FzN6jMtggQ4Uwn4ZfZgW1fTlGhF+jJjsFczsRW6X
 jenf+v2c=
X-Gm-Gg: AYBFou141fiDIyhlmiUZbXP77v4SS22JZkPWSDpRpMiRGmGcwaqQDxscnGuZeiVcYA1
 N/0kUhbEwPeiFK33GUPfb/Bet7GOBuUfEX1BpGaS7u3U1omtyZYt2RA2laCAFFAiYSUgjfEq7el
 A/zO9ydWJ9K/rzgTN4nX1i9wAYO43qtonaav5od8IJ1f4n343SIQwWDR/TJoSuMbnAnJmzFAmQE
 TjICY4eahKTBq8Fva5wIQeA6BDbgWWunNAyLKmCSocneX4IwsnLlAi2+Lm0UyjXoiBjajON8hla
 RXZLtm4rrFFARtgtsYUiCUGOAj4iajfRLiIpYR+84Ayll6EIyDC7H9D3oFeJbWPuXGRQUl4MeLV
 25bpOKy4b5YdBuRGnzKrFnAQWEwHiMGTWaDZiWTN0uL3c8rGBUJ4zEIvD5cBIE63EVE8cqhZzNS
 NhR6UYld1Zna9k7gHUODfrndsEcRvlp9wD2nr2lswOBLVTLO5VlydYx7xss10vGpjI6YQlB80=
X-Received: by 2002:a05:600c:4514:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49e7d72ab29mr9335135e9.4.1789411538779; 
 Mon, 14 Sep 2026 11:45:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d68f556sm12623225e9.15.2026.09.14.11.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 11:45:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 43A835F81D;
 Mon, 14 Sep 2026 19:45:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] gitlab: update the @user id mapping file
Date: Mon, 14 Sep 2026 19:45:34 +0100
Message-ID: <20260914184534.706637-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

I needed to fix a POSIX-ism in the script as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-map-auto          | 8 +++++---
 scripts/gitlab-map-update | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/.gitlab-map-auto b/.gitlab-map-auto
index 28ce448f1bf..3f717a15d4e 100644
--- a/.gitlab-map-auto
+++ b/.gitlab-map-auto
@@ -12,11 +12,12 @@ a1xndr	Alexander Bulekov
 adi-g15-ibm	Aditya Gupta
 agraf	Alexander Graf
 alex.williamson	Alex Williamson
-aliang1	Aihua Liang
 alistair23	Alistair Francis
+amachhiw	Amit Machhiwal
 anisinha	Ani Sinha
 anthony-linaro	Anthony Roberts
 anthonyper	Anthony PERARD
+aroxell	Anders Roxell
 berrange	Daniel P. Berrangé
 birkelund	Klaus Jensen
 bonzini	Paolo Bonzini
@@ -36,10 +37,10 @@ dwmw2	David Woodhouse
 eauger1	Eric Auger
 ebblake	Eric Blake
 edgar.iglesias	Edgar E. Iglesias
+efarman	Eric Farman
 ehabkost	Eduardo Habkost
 eldondev	Eldon
 epilys	Manos Pitsidianakis
-famzheng	Fam Zheng
 farosas	Fabiano Rosas
 gautammenghani	Gautam Menghani
 gkurz	Greg Kurz
@@ -51,7 +52,6 @@ imammedo	Igor Mammedov
 jasowang	Jason Wang
 jmacarthur	Jim MacArthur
 jsnow	John Snow
-juan.quintela	Juan Quintela
 kbastian-qemu	Bastian Koppelmann
 kmwolf	Kevin Wolf
 kostyanf14	Kostiantyn Kostiuk
@@ -67,6 +67,7 @@ mauromatteo.cascella	Mauro Matteo Cascella
 mcayland	Mark Cave-Ayland
 mdroth	Michael Roth
 mediouni-m	M. Mediouni
+mjrosato	Matthew Rosato
 mjt0k	Michael Tokarev
 mstredhat	MST
 npiggin	npiggin
@@ -79,6 +80,7 @@ pipo.sk	Peter Krempa
 pkrempa	Peter Krempa (work)
 pm215	Peter Maydell
 qemu-janitor	Qemu Janitor
+raphael.s.norwitz	Raphael Norwitz
 rathc	Chinmay Rath
 rth7680	Richard Henderson
 schoenebeck	Christian Schoenebeck
diff --git a/scripts/gitlab-map-update b/scripts/gitlab-map-update
index c134c226aa2..743ad11900d 100755
--- a/scripts/gitlab-map-update
+++ b/scripts/gitlab-map-update
@@ -33,7 +33,7 @@ glab api --paginate /projects/qemu-project%2fqemu/members | \
     .gitlab-map-auto.tmp
 test $? != 0 && fail=1
 
-if test $fail == 0
+if test $fail -eq 0
 then
   grep '^#' .gitlab-map-auto > .gitlab-map-auto.new
   LC_ALL=C sort .gitlab-map-auto.tmp | uniq >> .gitlab-map-auto.new
-- 
2.47.3



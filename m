Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC62C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMPN-00028r-P9; Sat, 26 Sep 2026 03:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMPJ-00028L-S9
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:01:14 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMPH-0000ON-Eo
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:01:12 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-341d5303884so851452eec.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406070; x=1791010870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UNd0tofN11vkjQp4tb6Cnaia8Ve9dgyARU+ImhmM7as=;
 b=ARA3YGXhStVCnDbwiWPDMTHrzhicnPeS6vT0QfoWG6sEK/hR+eDxm6krmaImkxE7la
 4iQMnJ5pBRjf9FID7Iqnqgob8f3dzjKPoiIxZHMeyfI9BFSH4POrHofP8ttWuH4INfBf
 D7HOnGA8keAdcYcxPOBoZM3RS98e99nGfWeuTiGxv2CfkUBWwblL54K1Vq4/pZ200LJ8
 vThpgR5hSaQy6lLrcr5AHZXrvHW94jnuFexU2xPALgiQdKusNb4R6H4YhWN1oa3Mi7ab
 rB+wxhva2qLnWU7LvkbpCCHi4eZpjOlqbHQ7wqZhXZaOY6CYJrh1IlrjJBOwk9JdZRZd
 1wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406070; x=1791010870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UNd0tofN11vkjQp4tb6Cnaia8Ve9dgyARU+ImhmM7as=;
 b=lKtaUn5rtzSaIc80grR+Iuh8IHG0g6X9nuixAfDx6sbHt/ciPakmuf+q2Wn26WWHME
 nqVPYRnu/NS19bzBXzZT6w+wwNbm2r4m9jROqqKvenIdi4oQ46IxojVu8HcviG6sgMaI
 OgWtEaYFx4octbvyzBmd/DcOyBf180KcdnSC0fjgES4Y5a2ZlYkg/cDfSMguBTHepOcy
 z3rAEBp02Kq6iuohdXlOjUIABsOqOMk64OZP0J2tY7zu4bTAc7Pj4BEO56PPAUB79Hxs
 DVd5qyDILmtm//Jbd6zYfbjrX4nO/waVbuWsc0F7H6rDGYkYj6NGBQY2YOsaaELQXbUT
 +slg==
X-Gm-Message-State: AFuF++n3EVrkI6EVw7GjEu1UpQep4ElKMLYGjBnP5vWW1fB3rSXcutNm
 mAiQl/logEveYYYmCS5m9BR3Pw6cyg9/clL51yQFwzI6pAzxff2R1vykjyRb/N7C
X-Gm-Gg: AYBFou3B76rMyVUVIo3n96/6kqX0JSYyLZ8yU1iq0jECNDugkNAXrT8K2m0WARHDFJO
 Mka+8JvgzTmM5K7UngiI7uobZVv9xsQsHYa+qnc6hVoWjg6FdlQ567/niH/oVeGHdMqsGyVlkh0
 tDMIEaA97jy32mMDC1jT5Mk3vM4oID7KWnVvQ4kNN5nWQORmUXzqlslmZpJdmDx7zHMxHBO7oG1
 ij4srkXBXlb447fMrk6vW6xBjMPm3rJEKKnv9A6A49zvlDBL56AIQMuQ3MGrDMstISb0uPCxw0s
 q4x+AS+tnIjvrfYiJu0nfUpV0KVPT+V9F5M8q1jre/l16oPtOhUINjiFxUrC3FJth9mEmiqV4wq
 SxEAHTGlRus6coiSheunlg+upHb9vbPZpH9MwSCS6PACZXGGhLO8+9hY6TlcKlhuNOrwfDxQe7i
 HC3yOExKR7+WS8+hWMFRVQJHEC2k/+jf2HLaWN9gp6e80Vsxrb5rl6QFUrmaicZSbVwz+WQ2haH
 JPxst/Lg4HhQ+LhAg/o7BAmor3d4rdmUilBnSDLqg==
X-Received: by 2002:a05:693c:414d:10b0:33c:141b:73a5 with SMTP id
 5a478bee46e88-34272c6023bmr2305190eec.41.1790406069766; 
 Sat, 26 Sep 2026 00:01:09 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:01:09 -0700 (PDT)
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
Subject: [PATCH v4 01/55] target-info: Introduce target_riscv32
Date: Sat, 26 Sep 2026 15:00:00 +0800
Message-ID: <20260926070057.1234-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Anton Johansson via qemu development <qemu-devel@nongnu.org>

Will be used in the following commit to filter machines using
TypeInfo::is_available, so a simple !target_riscv64() is not sufficient.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index b23e5bc5865..c09e5d2a3ec 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -91,6 +91,13 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_riscv32:
+ *
+ * Returns whether the target architecture is riscv32
+ */
+bool target_riscv32(void);
+
 /**
  * target_riscv64:
  *
diff --git a/target-info.c b/target-info.c
index 012b384036d..bba4503151a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -89,6 +89,11 @@ bool target_s390x(void)
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
 
+bool target_riscv32(void)
+{
+    return target_arch() == SYS_EMU_TARGET_RISCV32;
+}
+
 bool target_riscv64(void)
 {
     return target_arch() == SYS_EMU_TARGET_RISCV64;
-- 
2.52.0.windows.1



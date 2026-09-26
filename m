Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A81EC9831E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMVw-0001uq-KZ; Sat, 26 Sep 2026 03:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMSV-0005sO-Nn
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:04:33 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMSU-0000l3-3B
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:04:31 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664b7528so1431165eec.2
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406269; x=1791011069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VCuHWY6Hw+A4Xk8E6Eag+wxaYi6gJJVKssV/rB0uMSY=;
 b=UeDX5Fjrat3UmTCrtOvJn0YSb3kiKZYXmS3GKyqTV1zwtOjBtzBV2PVhbOAAcZhBJV
 /tLtKXlqdpo/6Dfj3Yw1PBVZfxCGaJvwezw1QDQSa9TOonTV6cn+6fTweI4WSkpwdcUH
 CsJbhS+q6w3fVKOgbVlzYh62l0rKC8EdkYxtPusqRHbFoYHbmms0hPQDAY1JtE2qbwQx
 lmhsE+oxzXuMCX23XMS909cwqTHwYtSZgdVIumRllwIcs4PpUq6/OxYrk0Od5CzaHB8q
 yBgbaZ5AtgNv00XYsbqKqSxAcpsUglFyJ+sTykvlnsyi+U23IZsEP1D117dNVDWvo9eM
 jYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406269; x=1791011069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VCuHWY6Hw+A4Xk8E6Eag+wxaYi6gJJVKssV/rB0uMSY=;
 b=LvX+lwOnNH7r80X5CVHK5Oj3s5XtMqzOGOXkmE9M50cTiu5f9fz1RM0aC5gtievGO+
 +0Qmum4QcB7PFTRjYkn5t0oOLNnfQPaLforNrkhDgtFji6Xi3Up2VMaSJpm3YUyddbJW
 KMd4rSyk2E8WOlwbGZj8b9eC0TwzIxn25NcTh9G3ZWUjgnkn6RqLpCiLOn9QZV3RSq/6
 B9cmXx+V4ZWHvKtTjM13kDauT4tw3mbkGwLGblrmp9uTs5HEJ6M0ZOFJxUuj0G/AgfsY
 iXvDnBGXclnx/43Yw/r6eV+FF2XiDpnS9KEVcz7qx84TRnNXw6c0u0GcienzQ7j3/8Kd
 mp/w==
X-Gm-Message-State: AFuF++loegu7NEj8yC53vG8bpt3D5w8BLyj5cZTD6vk/0gbNTjL+mGau
 ywbxKGGijbpayM1HGOxlmgkGWWI89OZHjvoyE/owxWlAOmCEeopxSFkWJW7gHAtI
X-Gm-Gg: AYBFou2xcqnHKZbIQKZH+YIVANEW+/kBhYx55DXf+SM/l1nL8gLgpS70oG6lFKUg5cY
 Rj7lMvV9Ax3qNyLr3qTHpj+Gqn0/zLVvi/o5eTUIk44PFqMFAwsacDDGdgjsZBfPaGz3AFpRLpm
 1Vd+eUJHwkDxaBubd/vrZJE9TbHRUKNZHNnlUCaKwYLFByiDoVguuHFq/nwuuRZbHzoMEbzEmpq
 gCp/r09hTm5sUDW899T1E+3U28uwTUSUFrNCXplo7hWiobz/BUdKdI7NeKKUIjXQOsFYk9glLpw
 oHBJDEEWSJsScakhemsS7+BlYHeTK1rfuiV72y6E4YvFvppK8avTaY6cV98LmUBLJnyErNthaWd
 b0j0IBR6OjkGuiuUSfQoQws0Tmys7q6ntPAIv3C6X9BLvlk2FrvxhqacYbwoSdBg/NaG0MRkKjP
 ffkNKMl4WgcJoDjdr8LTYy93+C+x2xD+vkbyIOF+9DspcDlG356RT4AEwgl1pO/nJXK/55fMUnB
 l/9lQRIO40PcPLTB7XxDr59kVDc9YHk6m3X2AzCwA==
X-Received: by 2002:a05:7300:d941:b0:328:3542:b73e with SMTP id
 5a478bee46e88-342707b5de8mr1811320eec.15.1790406268100; 
 Sat, 26 Sep 2026 00:04:28 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:04:27 -0700 (PDT)
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
Subject: [PATCH v4 52/55] hw/arm: set virt TypeInfo.is_available
Date: Sat, 26 Sep 2026 15:00:51 +0800
Message-ID: <20260926070057.1234-53-luoyonggang@gmail.com>
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

Set TypeInfo.is_available to target_is_base_arm on
DEFINE_VIRT_MACHINE_IMPL.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3eecf094bcc..a0a954ce693 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -132,6 +132,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .is_available = target_is_base_arm, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
-- 
2.52.0.windows.1



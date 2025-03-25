Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66848C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 13:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx4fD-0004dM-VP; Tue, 25 Mar 2025 09:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabelova31@gmail.com>)
 id 1tx1tI-0001gM-BJ; Tue, 25 Mar 2025 06:52:16 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabelova31@gmail.com>)
 id 1tx1tG-0000Jt-Gh; Tue, 25 Mar 2025 06:52:15 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5499e3ec54dso6168411e87.0; 
 Tue, 25 Mar 2025 03:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742899929; x=1743504729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pHEcMVh/SYBIMGHrkkB/aUk+EIlj1RwdFO7FM1ymqiQ=;
 b=R/V+uPwtYaWivCdZFeGreRNceE3dxf7fGfrteqO60FMxkPk9AdxBI1Rj7rV5Kkrsik
 qPu04BdgP7me7hpCjAGwv61XNODVw9HtZENKJLvcD2pQLWu7Q1yKwDOLxmwquVzENZ29
 qHhC/lE0Fp/1DPf5vUuQ/96Yxa/WSlsVSUqPQvNklYb35O4qrRcrWae85xvq4iJaaMlf
 0otmU+YFF/eC/2qS29+VkgfapNzDp/BlEms0sth/tXluXk1n7Crs6pN6p2JZZe6lH+i8
 /YDwD5cQuquGVS3FwbpskemXq4J0jtYL5dlwVUw2oLF/+m9gT85WgAjSaJpPdNaWpKow
 GKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742899929; x=1743504729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pHEcMVh/SYBIMGHrkkB/aUk+EIlj1RwdFO7FM1ymqiQ=;
 b=VGVQqoP2V/Q+ELw7GX/tMskCaitT1eqj8XSy4T0zEYZEWXh389FJYnJ/m5djyYtnur
 7USthRTnDiwCYEaRmtARIcDHj0F2Ei316BvuelgTzJPE7W7f/V+g/rdMEOKrAN+Pma1L
 gLEjsKoR+vdpVQAW/PMBnGRr4aGzDbOpsD4G1WKpk3jJNXVm0I1WaG9YQj4OCNBKBemA
 uhPQLkzSZpH3Yum4FxOAJvAxGgh7Z4lZoDOk/vPlpkaTXgJPrI40GGDhe5XBuNC45HrY
 4gO3uA1qzIi707xNLZ2/nAalskGBiyM/ehVA6xybH+iocPi1dlwTsSUKmtoUJAhb1bUc
 qf0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcHv+3SqwOr3RwDZDQloxUSrDn8sPgah5f8jOArVfhg8TGzbDux0lyLIDqNftsG3llObJwNMYe6A==@nongnu.org
X-Gm-Message-State: AOJu0YxrVpR0qTGitiM9YaYEc0Y5+yIJFUc8yOI2a8q4STb6AHlzgo1Q
 iTSCmsvjfCFkY7I+cyICD65rAmP734vRm4JvlVmqVqVJ6TQqgzPQspH5ixSGxttYhA==
X-Gm-Gg: ASbGnctW25X4AkERf0um7GoVUPYjTUZlfw87bR4r7HVC1xbtvf7HjlQ9ZcZMwwgI3gW
 cwx/oGfLiMscUckOB4PBK2L6pR2m5+KbBD/Bn2/7IJ6anl0PT87jLJ4rY8qulUR8GGW3FmVPfiY
 5OZt9TYagmQoWhv/1cBx/zZW8aVWLVwnGkwQaF79qxDoR4dxMlifrCgSiv0eDL1pW8ddMutnOTe
 DVeUM9yv3Np0V9RhayHAb+JbpnN85OWrIxsPpI+Ay6AilVLd/FDP6OzCbV0wSsrNdYogMO8Ox95
 c4oKwqQY19bAOzfIZoSALQVYjxeH97VdssE7WhX/R+NAHd1mKhjv2f7R0zzq7SHA8ov+fbmLIXt
 8WsE=
X-Google-Smtp-Source: AGHT+IGmA7MhKflP/qlY7gXakCQ+NavqPexLT2yKcy/SGNabH4+9GKprgtyXW+6Lgvp4kkiJSZYO3A==
X-Received: by 2002:a05:6512:e84:b0:549:2ae5:99db with SMTP id
 2adb3069b0e04-54ad64f82ecmr5445217e87.45.1742899928951; 
 Tue, 25 Mar 2025 03:52:08 -0700 (PDT)
Received: from localhost.localdomain ([195.16.41.104])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ad6480ed6sm1450635e87.103.2025.03.25.03.52.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 03:52:08 -0700 (PDT)
From: Anastasia Belova <nabelova31@gmail.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Anastasia Belova <nabelova31@gmail.com>, qemu-arm@nongnu.org,
 sdl.qemu@linuxtesting.org, Anastasia Belova <abelova@astralinux.ru>
Subject: [PATCH test] target/arm: add bounding a->imm assertion
Date: Tue, 25 Mar 2025 13:52:03 +0300
Message-ID: <20250325105204.59368-1-nabelova31@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=nabelova31@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Mar 2025 09:49:44 -0400
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

Add an assertion similar to that in the do_shr_narrow().
This will make sure that functions from sshll_ops
have correct arguments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 target/arm/tcg/translate-sve.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d23be477b4..47ada85c92 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6250,6 +6250,7 @@ static bool do_shll_tb(DisasContext *s, arg_rri_esz *a,
     if (a->esz < 0 || a->esz > 2) {
         return false;
     }
+    assert(a->imm > 0 && a->imm <= (8 << a->esz));
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
         tcg_gen_gvec_2i(vec_full_reg_offset(s, a->rd),
-- 
2.47.0



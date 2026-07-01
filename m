Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99228C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2r-0004OR-BB; Wed, 01 Jul 2026 06:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2q-0004NN-7F
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:52 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2o-0004yj-Oi
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:51 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-137dd4cc208so402630c88.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901189; x=1783505989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xE7HXy43Gklb6MepKb4A0VpJiZBo298BbEebvJ0dj8=;
 b=knZsTsHpgDYXfpcpUu8rm/SZpaEOECQHuI3RgOWoau+a/da3WRIz6MVAEiJFRFBzVL
 81Yow/kbpdWTfpRw6MmHK8kIfXec8Oc/dG+pYNxAORVEekVi3ebQ0DfK+MUPMI69VUT9
 +BFld6kbM12AJtZRL5vVvkgKt9d2emUzT7qq7TK9Oyg8h97mFmJiB31snggpkYuo7izX
 W4QuF3/Q3VS/N1uJPraZdmFimYcT63OuVd3Xi+2eLe4+V4v7EJY85k97FI9BdakJ9She
 Jpuj22GKE2JiYaWuZ2ha0JaBeLlJ2R40Ruxov3995S7koOraieKbvCSIptQMtdhckr8u
 t0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901189; x=1783505989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2xE7HXy43Gklb6MepKb4A0VpJiZBo298BbEebvJ0dj8=;
 b=rcR5VvAKNPcM4KWNOuUtgp14Y0bXJuaqvmXv8SCOfpqyO6W4FtQr4efkLnxpqLn2bN
 CyRJVQLVOXn7i8+2tsMGlHCAvgN26L7MxfGVm9xFWUbv3UqPg6x+BuxNX9ATl/rQ+qqU
 /Peyq/tdfTk3LAYXtIv+ZphY2dsz+xs8q9WBkiicZ0Rn8rLXyLCpbCFecuNeB6PpMWLu
 LyITm908WXoRTWQqZKoyF8K0DVGVAg3O+jqqjU7JpH+0TPTwPl9KZ1SxmMkcHxEIL5nC
 fWmI3o0PfJj5tNcBaWpXGsyj7PZgoNzN50yAFRGEEuIyqe91JPXsNJwE7O52iJ6B9CpK
 upZw==
X-Gm-Message-State: AOJu0YzQi88gSfgqQ4H8IaGEfbh5w8hKuqd2KbC4OKKBTFOb+PpRsgrb
 bchJpW588lU4DrjBGOum3AlbHdrVftKTo5+QSt2JVZeFfe3D41ZKgh03akUsjA==
X-Gm-Gg: AfdE7ckFFcOGsgcfAg9L30EM34xnIxBpdYBEIAkDRsmUN9sTtnk7eXY+AQ8ZTJ/ppeQ
 AMgr34EppLIgIGtj3NyfnIcV4icsODJLBZ8C7q2WJLtWDmV47+QBgJckudGuwlEQ0kyknJhosSc
 th9HbYyeczAWEXPIt0WhVDv+OdkaPn6JrVu+Y9xeqbUwCR50CM0M2fFOc4NYdbpwfcn4cHIOjbG
 rmWmpvcznjXC0MqzF08EcGV7xZ56A51RIlBT3oQBCiqK26eOVTadNJRuv+O0MsdTwPTCLK6GBhT
 y5rW9Rf81VhnSjhZoASwvTiWBR2b97lda2sX1Phc275mgd7HYT9RoHoMDsZ7XBn8o2nO0ZbjCM5
 XjDuLSWY/m8XFFcpiBu6eiE/44nhqe49PCtE6uDBOCMFtUNkeI6BNInREUMVzspwPEo+i8N+11Y
 CqWrOgr/gs/NEzyM+QimGkWitRhCBn6gAtU5MDOnqMsQ==
X-Received: by 2002:a05:7022:129:b0:139:b0a7:9df2 with SMTP id
 a92af1059eb24-13b38ee2c19mr322333c88.7.1782901189241; 
 Wed, 01 Jul 2026 03:19:49 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:48 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Nicholas Piggin <npiggin@gmail.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>
Subject: [PULL 32/39] target/riscv: tt-ascalon: Enable Zkr extension
Date: Wed,  1 Jul 2026 20:17:45 +1000
Message-ID: <20260701101752.2522962-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1230.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

Ascalon supports Zkr and the SEED CSR.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260630024952.1520546-7-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index de94f5d57e..4d2eb281bf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3251,6 +3251,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zba = true,
         .cfg.ext_zbb = true,
         .cfg.ext_zbs = true,
+        .cfg.ext_zkr = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zvbb = true,
         .cfg.ext_zvbc = true,
-- 
2.54.0



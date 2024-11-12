Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB37D42BB7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuph-0003Lw-KZ; Tue, 12 Nov 2024 12:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyS-0000Lv-0I
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:40 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyO-0007Ny-2l
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:39 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cec9acefb8so436352a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 08:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731429753; x=1732034553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRUAZltYZCx2K3m7pNvdKL4Y2gbZxFyPpCK3IX9jN3U=;
 b=Nz8rEq7tAoWNalMDgwiu62T3RXDgu+A/Sp1olX7C+Mi5DKK9rZYQY7sxED62t2oaLi
 mZtDcpOIOamB2YniSP8r73VL2pf4IH4aMLG7CMGgY0I8ptehShK26QCYKqaMbwkgbz0z
 6x2qLav5GiD1RvBKy8eJbGFlXBhwbI/LuDmP04SMrbOnKH1UgFOK6Ys+EIK67xtpEJXY
 pJ+ywOlNxHTD+n9LtdASrqNFqCeFh9NEjoRCK3og1/mS+Ula9UDLCV8pLswgMwaUFW1H
 5uewpvs+G/XfxTTQTtMLBhbcxwy9ODmsaZBSq/vU+4ITLKitebB3+k2jeKbqng1QAYWX
 d+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731429753; x=1732034553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRUAZltYZCx2K3m7pNvdKL4Y2gbZxFyPpCK3IX9jN3U=;
 b=h7BYNewsD5Wh44nRTitLNI5wkKo8pm8dFkUTkx1WpmxZr9eWgp68h26kvUD7Q93SA7
 /TY/ahtkW87R8uRmUFgaplbvGK0d80rL4WPW9m4MXy7pZTx8DFzb5JshdBZHTLOtWeBG
 QB3E8m0iCNkpqg8yI9n7bmUP5Lex3AawWOC+D/0d6JQ7qW3wh538BpBGQPZLvqqwLSe2
 jtEl/n5mlMjTuOxauLAMqBCd+iFtucj/9cvgdPX3B7R6OnUkyZ4w4JQAUJVhiUoBzCGj
 HAaupEMlBtwuFEMZBevQcANQyWOH++e+hfQimR3Twc6pOqecXqrRqOfPxBzvjZZioug+
 t1MQ==
X-Gm-Message-State: AOJu0YwB7kzn8mHjFdu3y+I/hrahoHh8OCaNQEmzF5VFwz3WRX49zkoA
 rc434HhmABnTVrP1ZgjcfsMGuKQMpOZH+l1y5nxN12yNZIWbLsb7bHMfasIT
X-Google-Smtp-Source: AGHT+IEJr0ShrYl5CNYi9tWuUsJRY7ryOB/z4PRYxEoJKvMGj19DzA9QIECemvHvBCu6QhQGl9RGJw==
X-Received: by 2002:a05:6402:2794:b0:5ce:d264:a425 with SMTP id
 4fb4d7f45d1cf-5cf0a32021cmr5026346a12.5.1731429753380; 
 Tue, 12 Nov 2024 08:42:33 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([193.104.68.137])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c8130dsm6137004a12.88.2024.11.12.08.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:42:32 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: qemu-devel@nongnu.org
Cc: aleksandar.rakic@htecgroup.com, djordje.todorovic@htecgroup.com,
 cfu@mips.com, arikalo@gmail.com, peter.maydell@linaro.org,
 philmd@linaro.org, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, pierrick.bouvier@linaro.org, berrange@redhat.com,
 Faraz Shahbazker <fshahbazker@wavecomp.com>
Subject: [PATCH v3 4/4] target/mips: Enable MSA ASE for mips64R2-generic
Date: Tue, 12 Nov 2024 17:41:30 +0100
Message-Id: <20241112164130.2396737-6-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
References: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 12:37:38 -0500
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

Enable MSA ASE for mips64R2-generic CPU.

Cherry-picked 60f6ae8d3d685ba1ea5d301222fb72b67f39264f
from  https://github.com/MIPS/gnutools-qemu

Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
---
 target/mips/cpu-defs.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 922fc39138..e77a327422 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -678,7 +678,9 @@ const mips_def_t mips_defs[] =
                        (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
                        (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
         .CP0_Config2 = MIPS_CONFIG2,
-        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA),
+        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA) |
+                       (1 << CP0C3_VInt) | (1 << CP0C3_MSAP),
+        .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn),
         .CP0_LLAddr_rw_bitmask = 0,
         .CP0_LLAddr_shift = 0,
         .SYNCI_Step = 32,
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E99C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB78m-000845-To; Mon, 28 Sep 2026 04:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoxiaoqiang007@gmail.com>)
 id 1xB78i-00082p-Gg
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:55:12 -0400
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhaoxiaoqiang007@gmail.com>)
 id 1xB78g-0002p3-Vn
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:55:12 -0400
Received: by mail-pz2-x2a.google.com with SMTP id
 d2e1a72fcca58-88286981a36so591722b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 01:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790585709; x=1791190509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SdlDTiGC4/sqRKZjmpMhM2xjUoJd3AagE/QbxuHIhFs=;
 b=YT5DJ07/0qrJbm+sTlVmAqchu8At8OKLThwrxivUoRvTEXLQ6JL9OegdfFTlCqm39o
 0Yu+7DtFXIdda4973F40+BQEb7/ykwU7dA/YmqsQFExeX3jsuxZTvhL2sJOzXupbvUm7
 VmLvu56B+nIltDVV/CSgpVAKTbb5VgKKDcpMhWUudrrmEeCKnhieln3fm6otYKSg1TaU
 j0lc6CTUGhA7Z/yGd4KLSi7qy7JP2FkybSDAJpKBchtD14qIw5ahskN6RBQ0HZbbguqD
 aDoec8zoXCx+SKmjVUGfZkzJ5wl5VuaoLcscGmtL7jXAvBvhX1J9IHlp4Jr+7B3Q7+9Z
 +b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790585709; x=1791190509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SdlDTiGC4/sqRKZjmpMhM2xjUoJd3AagE/QbxuHIhFs=;
 b=Tt98O0SG7hOAH0wL/lQnX1DE/czRiZJptAiTTrFVqTA2X+AnfGJV+3eYTBmPuW1KZr
 s2z5CpUlP6Dc9caCccVkJcoeNasKHKCF5o/X/BnJ8bP9oPJtMlOQ0filjN3T7k3RR7p9
 ZjonOTTkWfjkec9ZQVxYMG5TlCOAxpzuR9AeYT6q+wP2UPitgsiHNqrlD6lIFDulITpI
 dC1RH0bNUIHltp1aRpTA6ZsogvxloeBW2bdKxqUf82iEMg4FrIN4DKVwND//K96cwtbv
 W2QUC2qsF7lCqMs8GS4tAHS5ggqLURow/bDUZs1iIncDURKMSq8ep3S924h0xkcE85cN
 APZQ==
X-Gm-Message-State: AFuF++nKqappUv70aDDYj/eyWkRsZB/4RRamIpqwHripnI4qFLPUB6ZF
 jcFaGOT1/Ct8/zhYN2jKy/zzwuHdreaRInzIKF9EviTJazSfLpKNxlBMdIGUHH+O
X-Gm-Gg: AYBFou0x8dQm2afvR6pH/kuJ7tx2JxewoC5RKHmePFYhpGVU/+YSgg/BV92XliaOsKL
 TJKP8XpNbzxYdyeSIX7PEfW/farF3KXwzb6asFSl1ftEucVFOSJwCRroLVl67LpYiHKquv7I3NR
 zDZMBOvfvIV+pwnYUH8GBR52hQnqd5gjLauQbE2mZHUFbsXe7lMv0If62osDYRB6o5sezZzEByp
 OANOqYy2k/19zp2LdQbK8dsaQ732JWmexvdIPDawp+TsQsbvD1TkMa02cL7Kh0e417YbJwJpxy4
 4JiS81VUFHoFX3F/w0Cl4mnmS4z4tGm+XJAbuo4+a69wCDoL9FlbXGyk9dvZp24YxSWHn3TLmwG
 9qDziarUukHUzd12uMXDc6ShKe40+w4lLPhxBKHw60kIAIdHWN0H3yStMfvQDUlSnuclNJQ4HyA
 4ZM7cfc5YsZnmswEMRHy46RSa0bMYdg1Xq/N3JMgEb/LhZIMWucs4x3JDjegYH
X-Received: by 2002:a05:6a00:e16:b0:881:1fb6:a81 with SMTP id
 d2e1a72fcca58-8811fb62032mr4337590b3a.3.1790585709368; 
 Mon, 28 Sep 2026 01:55:09 -0700 (PDT)
Received: from debian ([1.203.174.67]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea18ff77sm3849500b3a.14.2026.09.28.01.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 01:55:08 -0700 (PDT)
From: xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>
X-Google-Original-From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, jiaxun.yang@flygoat.com,
 xiaoqiang zhao <zxq_yx_007@163.com>
Subject: [PATCH v2 3/3] tests/data/acpi/loongarch64: update expected SPCR blob
Date: Mon, 28 Sep 2026 16:54:19 +0800
Message-ID: <20260928085419.188886-4-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928085419.188886-1-zxq_yx_007@163.com>
References: <20260928085419.188886-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2a;
 envelope-from=zhaoxiaoqiang007@gmail.com; helo=mail-pz2-x2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

diffs from "iasl -d":

  * ACPI Data Table [SPCR]
  *
@@ -13,7 +13,7 @@
 [000h 0000 004h]                   Signature : "SPCR"    [Serial Port
Console Redirection Table]
 [004h 0004 004h]                Table Length : 00000050
 [008h 0008 001h]                    Revision : 02
-[009h 0009 001h]                    Checksum : C1
+[009h 0009 001h]                    Checksum : D9
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
@@ -25,7 +25,7 @@

 [028h 0040 00Ch]        Serial Port Register : [Generic Address
Structure]
 [028h 0040 001h]                    Space ID : 00 [SystemMemory]
-[029h 0041 001h]                   Bit Width : 20
+[029h 0041 001h]                   Bit Width : 08
 [02Ah 0042 001h]                  Bit Offset : 00
 [02Bh 0043 001h]        Encoded Access Width : 01 [Byte Access:8]
 [02Ch 0044 008h]                     Address : 000000001FE001E0

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 tests/data/acpi/loongarch64/virt/SPCR       | Bin 80 -> 80 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index 7bb819cd0d2ad20269e40e4a738709a45260cbb2..773433f240eced67530109035ef78a99945472d2 100644
GIT binary patch
delta 21
ccmWFt;0g|K4hmpkU|_mAkxQPDW1^NC05!G*vH$=8

delta 21
ccmWFt;0g|K4hmpkU|>2pkxQOYVWO5A05v`YvH$=8

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 53702282e5..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-tests/data/acpi/loongarch64/virt/SPCR
-- 
2.55.0



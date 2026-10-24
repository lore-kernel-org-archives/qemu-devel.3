Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1321606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=HkbSL+oZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKaTc-0001G4-Nv; Sat, 24 Oct 2026 08:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1xKaTY-0001AC-Fi; Sat, 24 Oct 2026 08:03:52 -0400
Received: from xmbghk7.mail.qq.com ([43.163.128.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qinzhengxiang@foxmail.com>)
 id 1xKaTU-0001N1-5m; Sat, 24 Oct 2026 08:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1792843415;
 bh=w8P0bksX95pThYjKkN+e3ElgSOEiFnRMOozPje2X4IQ=;
 h=From:To:Cc:Subject:Date;
 b=HkbSL+oZZmB/ReDM1C6VnIvk83j7eVSOckij8GWVKe7nwqB87MTNBFAXvzsnNJEdf
 7KHu59GA/+lkU0IKOlRP/U+vggsuLTEszMFqJfvZ4k5EjB2Tu2RtR4b2Enzd47x9k5
 v4l/Sa6Drr6KROitz5BIZ1W028DoL50pZZ0ddQiI=
Received: from ubuntu-vm.. ([122.9.98.96])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 8F108B2; Sat, 24 Oct 2026 20:02:15 +0800
X-QQ-mid: xmsmtpt1792843335tqcjgqs6r
Message-ID: <tencent_7F0BF077B0C2A71AE38EA05BC3F112773207@qq.com>
X-QQ-XMAILINFO: Od8VqZhFMB3NytNXxozFjeSZ3joUYLkcAVnhxs6O3FyqTYa8RRRUy1pn+/Ktn8
 AAsVvV2IulmnEwGcNQpN+nZLlp8zARVbMGa1VY63UebqS1Pu9nn+kKgVttdESbKcRk0YDmNH6s+a
 2IosIf0v0m/AE6k4cJi3NCvgExWCQx0R7kfbeVSf/h4gldOf00QyafbkcDgyupySfgeJfjfo3crj
 h0X5Tb90No0RnkrxZC6gRJZSW9RaUDES6KLPcTnpwqbckeGBuReocsBEz4iXdBh0smNgUxNBf/9Q
 lifI7pufs0WUar9ssz517hBBawyHmjC9ueoYsyT6Dhz78wMNSkDdDzxO1UV2Cwkq/KerZXpIdzWd
 aLmuyGOrnxXF/JL+zh1SXMFg6O/rjneQR9xST13aPvXe+vamOfZARk3be/Pc0stl+lGJ6pQUnqz8
 aH6Fbvk9Y6xh5ivdAyd30l+wawmg/f7HIICK+6gt7gMiZpP2RlSdzgBkzvttIlWjxA1WakmG3qJs
 W7NSXa0iSRmUtqOkzO614+N+gOI4GxhK4vvsy/Jm2PutOwf4zgNVafhAyWTrHpEbVeKnAQQVn4Xh
 /8OruprhOlKZUerI2KnUCwS3ImZVJxOm14vq/dS0AkGuGT4ByYDiIMy+H13yv8aR19r3RSOEO2q+
 0Z2j6A4N9fIUiuwj7zL9fTOSLtyXl43cmI4NftrpIfGQKUpFOI9f98H/ajuGYAsxItLejduU3lmA
 t30dt/NsTpL0cy3V0haDp3euiPGRk4NtMaXTdxxE2fzZ6ktagAsnKTtLzZk4ILcfN4ys3TKeEAMb
 yJUX35XdrCblAcElO8XpvBDZ3A3jZSNbIVUdx9arw9oCYBVEvWhpvyifvfJlQbtKf3VYFvkj92Mp
 XEpQCAkxV6Wen8ecZAuunUnAJ5zzomYLv8fSzzyeNc1kopc9QqsupSCv8kxMYbcEA4UDyVhIHYkr
 Qr1m26k6QN+g5y+uaRyGw/r3dTQd4n81ODfcYN7aHKOEC4cp3l+AYLvaO4dK54e+RSTl07j2Gs4H
 Fn31JluL4zi+OX0/+ihaUFk6nIgPQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: GavinQin <qinzhengxiang@foxmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 GavinQin <qinzhengxiang@foxmail.com>
Subject: [PATCH 1/3] target/riscv: Honor Zama16b for halfword AMOs
Date: Sat, 24 Oct 2026 12:02:09 +0000
X-OQ-MSGID: <20261024120211.236223-1-qinzhengxiang@foxmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.49;
 envelope-from=qinzhengxiang@foxmail.com; helo=xmbghk7.mail.qq.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gen_amo() only applies the Zama16b atomicity requirement to accesses
of at least 32 bits. Halfword AMOs therefore retain MO_ALIGN and
raise an address-misaligned exception even when the access is
contained within a naturally aligned 16-byte granule.

Include halfword accesses in the existing Zama16b handling.

Signed-off-by: GavinQin <qinzhengxiang@foxmail.com>
---
 target/riscv/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index ede9c2563f..70c1088338 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -1159,7 +1159,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     MemOp size = mop & MO_SIZE;
 
     mop |= ctx->mo_endianness;
-    if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
+    if (ctx->cfg_ptr->ext_zama16b && size >= MO_16) {
         mop |= MO_ATOM_WITHIN16;
     } else {
         mop |= MO_ALIGN;
-- 
2.34.1



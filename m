Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1D1C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysR2-0000ju-T8; Tue, 25 Aug 2026 10:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys39-00030g-77
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:51 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1wys37-0002FM-1t
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:22:50 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5b0115b9e17so4699816e87.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667767; x=1788272567; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VnF+nDQE1Id2poIia8XWf7bAfaVmktTinQp/48+p2s0=;
 b=NAoeYLCW06g+qdcBBcR5j2I3HXRKATHiBhnMJPI/9z+vnJoHPgZGb7jrZgRZe1gSrf
 cRLZ70pTHvkrZNprd4nVwiHUNaExY5YmcoumzWIH9CoNWAXGha5DWFL4U5oieFCNLqNn
 BFWgeiSoJJ060TqEtRaHRAqis06EwQq3SoxhNPDArqSkcQ5DLMfuR0LmWQvJmptx8WN/
 4fGXVIl5WYzVdrGZ8MuS5z193k8lXM6CKfwlWV/zijXx/ab0BclhBXH86jESi7L+GwA1
 jXHh0P3Z4/WncGe+PTYVUZZtxjP81saIQPbCZQFdfThg7STDNSlEpJTdAllwqG1luNxo
 Bckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667767; x=1788272567;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VnF+nDQE1Id2poIia8XWf7bAfaVmktTinQp/48+p2s0=;
 b=m0moT45GXtlxHnvr9lmQPDoeCxEiPt0UnagvWksbWg0kzni5oMaj6AOFW4GtE6kNhM
 At7H7yy6c/hwz4wha6+F0Hbf6IbHV9CZOkEdz3EmRnaMrHE0FtYDqNqRNNsulag5+9CS
 PTu4Vw9+7btTVuTN0DAF4nNnJURDC+PGRUzOpzinGDW1x9A3YeirJoST6gA7lx17qbp4
 X/ZGnUf1B35uU+YaLO7NT7I3HRSgWuL1P6zcCFsK6IaP8V8YAJK0O3X4kxHixCEcC1ix
 5fP8FDyZt6eC8uno8oHKiM4Zsb2oIujHHcNC1YpOSYx188uNbYrYgGMsC7aNqwn1EAkV
 Gr+A==
X-Gm-Message-State: AFuF++mGP2LTTjUZ5ByO7JDL0zec722JX2BzgQiptm+Unv62FRUfN+lF
 mnYL6ceMjCiEfpGui4u1D4x8TCuXQud9FDZCUgNcCYKF8NLq9ysVH1sE
X-Gm-Gg: AR+sD12xUWdoBQQ1yK2NIHMs6ggPeubq2KTd5wmnHw5xJiy4dznZQfbkMXHPUKtHLw2
 OD5EnFIIuYJ5EzSnv4Ll4Q/IrWUVR5InwM4YKvb9EOj0Ynn7Yi4l+f59DAYNC7Z/gxoaG3tJ3wc
 Q/q3U1hB1dNto76Dfy5Kk3rjXxxMgRb5xh+spsHBF3nsCW76dV4qQOxtd/C6jxU69M909sVM+YM
 GpJrJsf0RNpTflBjI8grUsAhUglUgkx10DRfFm18Fq9NP6pz9l/QHySPDjezbvpKICkQQGtAdh7
 SmpZBHeuOHggmJjiE1kk4n1O8qEIkAtQoZjyVZsE48/kk4nV5/6N4o1pMpo+svo0u/fOmGKUtgO
 YGOslrwqqgaosOULE/oKmqxQJEcsAUFGnjpgviizXysGqFs65HxZph9eEA5yT/E4WFascCENNq3
 rgOnbkXTkXxQM94fOIoCZQSM53cRsay5NTu8twkRsxzMjYLJfTnrBly/AK03HnIt/EwInmGbGuY
 bHMM9JUfRELMkBpLWJIF811lCLCAw==
X-Received: by 2002:a2e:a983:0:b0:38e:a12c:418c with SMTP id
 38308e7fff4ca-3a1ef5775bdmr16896011fa.11.1787667767095; 
 Tue, 25 Aug 2026 07:22:47 -0700 (PDT)
Received: from [127.0.1.1] (broadband-90-154-73-22.ip.moscow.rt.ru.
 [90.154.73.22]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c82f6b02sm22457551fa.41.2026.08.25.07.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:22:46 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Tue, 25 Aug 2026 17:22:35 +0300
Subject: [PATCH 11/13] hw/riscv/trace-encoder.c: add remaining fields to
 trace-encoder
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-upstream-ntrace_core-v1-11-f8be2f40d2fd@gmail.com>
References: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
In-Reply-To: <20260825-upstream-ntrace_core-v1-0-f8be2f40d2fd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexei Filippov <halip0503@gmail.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=antikostya2@gmail.com; 
 h=from:subject:message-id;
 bh=GerEqUwk7lEOA/Gc+A4C2wt0HgXJhrpEEgUdOrF75hg=; 
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqjaUjKyMVhhCHB0Ob1a4cDp36m0yTMkFjkXu/D
 dT7E0x73d6JAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCao2lIwAKCRBIiqVupVDe
 dueUD/wLioJCpD63aM4PfhBu02D6bGlCgNeLnTl+BbxPBddpEsrhdL4de0VWJM33v4V/L424A4T
 1gc7WxWUcdP2ZVvfDCQ3SmCHwRa8Y0B7fQFc74bbSbWsHsjO4SWhqzKF8oes+LD7/z9Ag6EiBEE
 11ErFDYeZNfEDFILJSjyir+iKXWZV9MlVMBwxiz2jvY5K7BOLzrfU0/Gnmlgt2urtGUnrh7ZMRp
 dxmVqByPwoIFlo/E3Z3rkR7juSU6Pp5b9ozSGlVgEEQTQuqNp6ZxDrM45aJ1zaV2RTw8uyTp80B
 ORBdNg2qgKdikehD440CQPAyKJoKGbQ/0d2Na9k+CCNeTWuS85mB1PyT3E/X70evmMPDKB4yyPT
 07TQb4RXJ3zf3qugkD7uW5tSozDNhyh7UeDDXsGKjbuf5Xdax2jDFE/SRdGmVgpe3w8TqUpe1Rj
 fnHQQd7hE9q6NSjIWUqqQx0iIB+AV40Tiycte3r2DUP81+0mdPjC7x7/+LoaiSS23lFuyd/l98c
 l/iUpseBevWZMApBYR5dJBoGs+10NwVAa3gDq9g756vYX2mGBxpXdADTnAuHK6uEgBkgnHgIZHb
 220NkqBLfdDWQ0/fYkm23pUV2J38NnkzjNL1oSgMcUR7KKjxBBqj2LqnEyGAoD3hUNAbTuQR5/E
 gUx5wr55Sr8daYA==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=antikostya2@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Aug 2026 10:47:29 -0400
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

Add remaining unsupported register bits to trace-encoder as read-only zero

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
---
 hw/riscv/trace-encoder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index c36d205f50..58ed4b2646 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -68,6 +68,8 @@ REG32(TR_TE_CONTROL, 0x0)
     FIELD(TR_TE_CONTROL, EMPTY, 3, 1)
     FIELD(TR_TE_CONTROL, INST_MODE, 4, 3)
     FIELD(TR_TE_CONTROL, CONTEXT, 9, 1)
+    FIELD(TR_TE_CONTROL, INST_TRIG_ENABLE, 11, 1)
+    FIELD(TR_TE_CONTROL, INST_STALL_OR_OVERFLOW, 12, 1)
     FIELD(TR_TE_CONTROL, INST_STALL_ENA, 13, 1)
     FIELD(TR_TE_CONTROL, INHIBIT_SRC, 15, 1)
     FIELD(TR_TE_CONTROL, INST_SYNC_MODE, 16, 2)
@@ -161,6 +163,8 @@ static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
 {
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0x6);
     input = FIELD_DP32(input, TR_TE_CONTROL, CONTEXT, 0);
+    input = FIELD_DP32(input, TR_TE_CONTROL, INST_TRIG_ENABLE, 0);
+    input = FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_OR_OVERFLOW, 0);
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_ENA, 0);
     input = FIELD_DP32(input, TR_TE_CONTROL, INHIBIT_SRC, 1);
 

-- 
2.43.0



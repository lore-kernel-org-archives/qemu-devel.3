Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D1606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TumIb6v9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLagJ-0001zC-4n; Tue, 27 Oct 2026 02:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagC-0001v3-Lg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagB-0008B9-5L
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:04 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so1572835a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082542; x=1793687342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QIIlT2yZh/vLQ2mBt3JruYnftG84FWqn+4P9suFB26g=;
 b=TumIb6v9igZhNLHWFjwcZnTQj3qdkIE3LUoJvpTQ9+lm7DeBaEuzIEKumqqHJU+ezD
 NCgHVo34HOgh18JDnDR7FnM08JOUyFv7351KRioVX3+51gB9ySAtT09iZ6g/0tCsLZTZ
 j8M1XlIFVM3J+EUu6kcqFt3aUnDlu5r7YB44PViP9cBcOzhKYA8d/rKKCszW8Os0U2Nz
 +UubYLG48xmB6JDr+Ac+pYT7aQaN0yOlM87Day5DzcdFDA0dBFJBxQlIh2J2NNELL2Hj
 PcP+oz7lv2IWo1hSGz8p+fuaeUKcjkNufHpoazG7OJAE2RDdzFfUMKLcWc2QdiF7JwbW
 bJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082542; x=1793687342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QIIlT2yZh/vLQ2mBt3JruYnftG84FWqn+4P9suFB26g=;
 b=mRvQecmG7MAtrKGFWwn4YuTfiOqnhoBij4gQnvt370NUoJkFeexWfhKVlv4U0Qlv6N
 /Bkd34DfE3gUNidZyTaT3gY1nydewXeLDs5swvuOophQX48EBQJvkInhkfDkfNEIgmCH
 qTtqJYkb0q9D16JJC5ltkS1000mCkZEvPWqTnh2W4qO6u0fCD8XYL7ykJKm6kxBhEAv8
 K2kVaUQqu8BzmARykhk8lFXg30O9dMKftdJFabL2kfOas5d7jLENBX6AWn516c9WzmKU
 EohmPRA03zGjR5bBCZlelaCVjMwXUwnfoQgrnrKU9IaYILPPqW4ktHUKTV/nmtqRBP/c
 R+DA==
X-Gm-Message-State: AFq9FYLW3tGjeEawyqN69R+yvEEnuc1oIesn5hEjAzVRZDVWWvR3nB6b
 6lCTnfjn/yxEENS9CFJksJ0uvtPdZWQaw1w6wHEPxZPEOk5+DByAZz1z935IUg==
X-Gm-Gg: AYBFou3H9dllBUrkj30BpXtijgJJMEBZJ/kg0jKvGy6b/CBMhBt5K4tNpCNPP50hlva
 /m6d9yyNjbpcYXqVlgXHceaX63O7KlZzEqtyMYZnlFGpMLDLQUucnrWaUNUmYstODdMpvS6+bPM
 e1EuPqKCswLhkDKxNBPuDudzF8qqqtvsNk3d7gzEuW31XAVgmWhn6fx7YwB1B/hrdakJnSDAZJh
 QeyYo4fCljwTF7BzVyvYfyL1e+X/B1x3yVPFHgQS8CoeKQ9X3Vaj8mNKOYuWXzHgAHWbO1D+bPT
 FoI2RMtkIxGy1qFabrfq4t2sLnvv6Mb0p3MwN2G96gJ3QYH3lBpXyOHXikBZBuCTjS2/pF20lJT
 6ZrBFFrFhTHP35CiIZEHuUD4NG5NkrqMHoTZTIQ+xlFqmjU+oEz5v8TB2GjRUEa6pxqZkhYSV01
 i2iS4L0VOv7NDMgEybEH3wCUCSeEdgX0g1FarCscTzz2nDeVcXD9kxbsEV60xLVY0jRn1+NqFTO
 ht3Mp4MmlruRwdqEJ5k2uKX3nFq4ab87Yss7rxtPTxo7Xm5F3OV99qqowCd40PdtKm02JokgCg=
X-Received: by 2002:a17:90b:524c:b0:3ac:8897:7ba4 with SMTP id
 98e67ed59e1d1-3adea0b02dbmr7180248a91.5.1793082541691; 
 Mon, 26 Oct 2026 23:29:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtaodtdt@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, Tao Ding <dingtao0430@163.com>
Subject: [PULL 11/29] hw/misc: fix calculating input address overflow in
 k230_decomp_gzip
Date: Tue, 27 Oct 2026 16:27:50 +1000
Message-ID: <20261027062808.1995205-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tao Ding <dingtaodtdt@gmail.com>

Use hwaddr for address calculations to avoid 32-bit overflow.

Resolves: Coverity CID 1685517

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
Message-ID: <20261018141006.16398-3-dingtao0430@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/misc/k230_decomp_gzip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
index ac06cc15711d..da4dc6f95497 100644
--- a/hw/misc/k230_decomp_gzip.c
+++ b/hw/misc/k230_decomp_gzip.c
@@ -59,7 +59,7 @@ static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
 
 static hwaddr k230_decomp_gzip_input_addr(K230DecompGzipState *s)
 {
-    return s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+    return (hwaddr) s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
            K230_DECOMP_GZIP_SRAM_IN_BASE;
 }
 
-- 
2.55.0



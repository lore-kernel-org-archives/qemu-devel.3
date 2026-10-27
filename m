Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7C606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m1p7TOvu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLah5-0003Tw-32; Tue, 27 Oct 2026 02:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagr-0003MG-LA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:45 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xLagp-0008Ea-O4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:29:45 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1115342a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082581; x=1793687381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uoZrsgUYxILG8rg677Fe2dlr0wp/H7vfP02z1iFoTag=;
 b=m1p7TOvuUriDLRnmEuLcdGMdwSme6LBQP7c3DAp98CsNE6POLYE8PxwdharsoGUfaM
 CHyj5iwZBiRvStneZMf+ViFfEYkk/eo2I/c9qYnAVUw+V5/J8U7z572b6cUPcUSnQG5c
 t/mIhUoDzO9r4AZh8ZvTDYRosuLKm6CvfDKaPDgA+TYzGQ0o8d8eCIDx41pcxxxEjCYE
 kWlHSVEt+eW8OXhraG1PJHF/EF4XTTbFXIh11wKqQKFx3br/5tIYtNXGttfds6vs/dsE
 VsTC0KzBQ7XTuX2STghTb9lxNDx+97xx4xxpunEXIZTBOGrTqTuU2kASv4mieD5XBHjf
 qvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082581; x=1793687381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uoZrsgUYxILG8rg677Fe2dlr0wp/H7vfP02z1iFoTag=;
 b=z6/IiawW3446nVfsPDnJfANeQk0bK83kGzj9XzTkNCwnwFqXpxxvECR5c0KaSBVHOw
 zCBXTzGBi2lZQRpqlyEx0BVJfWfD3THwbZDHfkD/ZXVa6Vt+1vuAJTlM0IkljP0ox26d
 hrMt7wi+MEj+TdzYT9PV3tx8VXS1l0h6FuW4UWxtDjsmUa18q7HeUhh8GoYzHs9mn0ZP
 qwqoEiCWEIiCQ/YOY6/NZgLWLmmT7ae2Wb1D4AxfgnKmwB0Sn5ODMHUFfl4s7K7BsG1f
 Q4kq4ao8wrA2uF5Nzabwj1MiSFMNlBaIrGEiB11yCYu5NTP8cf97BrgEyutoiFYeP9lj
 D5WA==
X-Gm-Message-State: AFq9FYKzwdaCtbjMZaFGMVAzLoZ88bn23vIyx2zJdOr0pOkhmuP8r/9x
 rzqg9yoKlKq7EkSh1VprymPNIvmWkuB3IY95rMf2/S/rF/IeKg5e+iF7jOTyIg==
X-Gm-Gg: AYBFou0OOgW1CUMe/+fJKznWgMW1vH6wZF4QAQr3ZYJtQhTZ/qQInR2pbAZflLcy8St
 IfKQyaUZ9sgEYY9pyGL35EKgQX0tz4EnCfIY0dAA9PQpCpKYEpCkHmoAhn3SHG9KqdU4mXxuBiB
 TKZbdyj1SlSBPNG4qawSI7jkfVTUiTrg0wrXNSzOpMcCwScBT554EtKwHQTOFADB2UJFpifQ8im
 BNk/WCqEkhV/NAu1yWF9A9ZdSOVt90+SaaiEzbJPR6Meb+axTMRkGiXzSaz0Vi/wwN/U/rYXVJX
 3nC/jggapLJqIPvlwg1IB1BFoAGFGJ+2M6vmXMf86yg+8NsvacEiHDco3H6lPT7ontcwHLYL2wb
 MCQiJg10O9XF/c/f+n/4i3YIH7RY3cLGAIIhFwSf2WME0XsoC7e06BC14r96DkbABuMjW6AsxM5
 bNjRQMhvyu43gOYDpFsCB0XCowk761FUz+sd+zYUzFu1rKHB0oVSMPxAKHpvjbRrLBH3v2TTMPv
 D9yn8pZl0Oq9V/3mDf6hT9PwR35VNIxisau/t9b7DvZW7EU1Du2T4poS3mIe7HDaQLqUY01S8t/
 zhZv4GYOGV9okelJyr88
X-Received: by 2002:a17:90b:5823:b0:3ac:8897:7b98 with SMTP id
 98e67ed59e1d1-3adeae7644emr7876219a91.32.1793082580904; 
 Mon, 26 Oct 2026 23:29:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae401bf352sm2358541a91.0.2026.10.26.23.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:29:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/29] target/riscv: Use 1ULL for a value we're going to shift
 by 63
Date: Tue, 27 Oct 2026 16:28:03 +1000
Message-ID: <20261027062808.1995205-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027062808.1995205-1-alistair.francis@wdc.com>
References: <20261027062808.1995205-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In prop_marchid_set() we set mxlen to either 32 or 64, and then
calculate
 invalid_val = 1LL << (mxlen - 1);

which shifts the signed value 1LL up into its sign bit when mxlen is
64, which Coverity complains about.

This is not UB for QEMU because we use -fwrapv, but it makes more
sense to use an explicitly unsigned 1ULL here when we clearly want to
be treating it as an unsigned value and the 'invalid_val' variable is
of type uint64_t.

Resolves: Coverity CID 1547552
Fixes: d6a427e2c0b24 ("target/riscv/cpu.c: restrict 'marchid' value")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20261022201037.764619-1-peter.maydell@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c162d2803367..5a0529fbdade 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2317,7 +2317,7 @@ static void prop_marchid_set(Object *obj, Visitor *v, const char *name,
         g_assert_not_reached();
     }
 
-    invalid_val = 1LL << (mxlen - 1);
+    invalid_val = 1ULL << (mxlen - 1);
 
     if (value == invalid_val) {
         error_setg(errp, "Unable to set marchid with MSB (%u) bit set "
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B07CFC27C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jm9-0000BZ-Fw; Tue, 15 Oct 2024 11:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jm6-0008Ev-NL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:54 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jm5-00014A-3i
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:47:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c8b557f91so45151285ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007271; x=1729612071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ng190dTBKHEnCOYKEZzpr313ucrQGKJ5Mjtr4qqtcdc=;
 b=PvDaiX4F68TKaKVDexUJyj46TUQY3uFbc5TIBhXf2nCfPB4MtGwhVSDuUKzGuvv4I/
 AFo5LP2euVdRmVrFxZ/OTBzhjxeUHLmc2DxIuHiOE2rIo0x5eFXejjxzHMpgkdaUuvB+
 y2mIMf0lXN9C9AOOTCt/Cb2P9/klGTyN9n1ySI50+PxQzQY59lsTTyqT5eqB4epgvwuj
 gkGzrWxZo9u5Sz9dKIdUH7O+6g9D+gaY0gQZRU6V6df6t0zROsnYdlMnexVK83xBEPTO
 aL4dEJeCC4m33/eYEDm73buuDsQRAw1EsfL+ieR9wgICkUzDEE5A1TfC91eG+lxc1GXg
 J61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007271; x=1729612071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ng190dTBKHEnCOYKEZzpr313ucrQGKJ5Mjtr4qqtcdc=;
 b=XJMJv78//lfldZf/oPsqtfTK3qibYgI+/Ir1T1623TtLmWyjaQWi7o7v+oBhNpLoZ7
 5IgfXfO+oe0atCHNQMTHHyOWqtT6wJMpKN+Bpm/lJbXFIBYME8h9BOIwtzBGra4fnU09
 fytW8Y3dI3lxJqhJVx9dEeSWsTLwVF0r1eF1pV95+QRlBEM0EXE+DEeEDOkUyyqcBb1J
 JirqzmaXRiRTOf82UCORHL1YMUlgWBTuz8mpjwvxc4KrDaIwzC+1d3bFCY+F7DSsaec6
 lUlMuiLTMD+fR+gq9JuVJagjHqUUyyWZxF1CeOrMBYWTlFfz2dHWVM3jaowBnbuA8cMT
 5yEA==
X-Gm-Message-State: AOJu0YwgIJN2nJhc2Pk0Y/pw9rR56Kw48Oz7HyMvIZXnkm2PI1l3iauH
 C/4bdqauJ9amcbcR9Db8FtjwvZPo+8EXlgSWQ+DczZUsPcpyqc3DcI55gnJrlYEztQfPb44xZQG
 f
X-Google-Smtp-Source: AGHT+IEJGJ45nvBF/19W/qtWHpqFVBg2wZnf2lGU0yg79DGADKXdSMa9jLKg1kHakg1jTZs+FgId4A==
X-Received: by 2002:a17:90b:17c2:b0:2e2:dd25:9b00 with SMTP id
 98e67ed59e1d1-2e3ab821dc7mr713390a91.22.1729007271431; 
 Tue, 15 Oct 2024 08:47:51 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2f037c72csm5716230a91.1.2024.10.15.08.47.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:47:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/33] target/mips: Introduce mo_endian() helper
Date: Tue, 15 Oct 2024 12:44:35 -0300
Message-ID: <20241015154443.71763-27-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

Introduce mo_endian() which returns the endian MemOp
corresponding to the vCPU DisasContext.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-10-philmd@linaro.org>
---
 target/mips/tcg/translate.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index c55f90e741b..49ff6b8cd80 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -240,6 +240,11 @@ static inline bool disas_is_bigendian(DisasContext *ctx)
     return extract32(ctx->CP0_Config0, CP0C0_BE, 1);
 }
 
+static inline MemOp mo_endian(DisasContext *dc)
+{
+    return disas_is_bigendian(dc) ? MO_BE : MO_LE;
+}
+
 static inline MemOp mo_endian_rev(DisasContext *dc, bool reversed)
 {
     return disas_is_bigendian(dc) ^ reversed ? MO_BE : MO_LE;
-- 
2.45.2



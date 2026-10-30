Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C66606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CENQrE+g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTX-0004JT-Tx; Fri, 30 Oct 2026 09:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSs-0002kF-WA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:18 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSq-0005W6-RE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:14 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-483c607ccb4so418261fac.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366166; x=1793970966; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UufAhb1eCSDnMmYHzX8h68pmrDRUz8YER2QPgDo1oN4=;
 b=CENQrE+gstcsbBKxh6+PcCPtzFfLTD46RtAdADQvca8bO+WRwbgN345rh455LjMjII
 7xEExFnz3sSdKAdfN3rDA3JsHUCtRkKoHjU37PJNaflbGI1dfvkgogvVse2aqhoWF+mZ
 NJmVZ3eJ+XgWQqLKZ1UWAnSnSHropDFDhJP1M5aI5nZfjbFtvgGujxZ6RzV9pGQoe+A4
 sFFKoJlZWH/28uTVcYzE6XEstyNQCGcEUzkFJ5kYWc5zjXFqa3qVMhZYp/s663W0kY3F
 7lBVwxWM+jaD3V5j7awW+FoHrdA0um5BJbBHxBcD5yDj42KTs4/NEnXO2827/gScNH6R
 /+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366166; x=1793970966;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UufAhb1eCSDnMmYHzX8h68pmrDRUz8YER2QPgDo1oN4=;
 b=0l2CjL+snGmdYdU60/OKKPptiCH2F87ATv2XDEvv8pJCyWtWSkKj7QhYku6DiKDaC5
 sqSKaVUAN/LhYOVwB/e5G5mcrt1KmXTpaNyyLMAVyqnZTcJIlY2HGne2zvP6nrQCcVfX
 tV3PE3jmnHr/QNu4XHWd8SS/4XCCVGzh/XqjW3kHSFVvAZo+2LMQKv/wyH5+5rD34AB5
 47otvCtR7IbRzU/AJz7ggEL4GPdcKHEat+ci1r7DUE0P7/qH4BSoSQhN51uA81H4WlLJ
 Qy/MOVDmVRYNgllGubS0Mh8Sfpx3hlwZRObrb5FiOov+vx94a7V2zw0CEP1G1oCY0WPp
 4l1A==
X-Gm-Message-State: AFq9FYLhStsNhQ5Ei6VwzLQOX3baXuPvFHh31yeUB78kltrGpv2yAMrR
 h6CwT5Uj/+fEmWDBeOyg/7vDVb6hfjJYg5f+fcvz9o5ktvz9/THl5uO4hCZLHX6pomnhp7eb396
 ZfWv5
X-Gm-Gg: AYBFou3oWEY0lTVr/8Xmw40Vr4gNVS8a5NnftkVlz7qsAxE0KQZ64ZpXC+7wij3GC5Q
 wX8EAhXA+Sx58PHVoYmNrKwUDmQf2z7OoTxUwxW41/bHNOhbj1WYOSwttaiX9Qi8mfY7SAOyocd
 FR5Z240J4hmX7leeV0FUWhIE70FHpffWthVCPWqsMtYWFluUTjDDXVszHu0ts8VMWn2oenam1rP
 OR1yUKatGpcwCLdh0aU/zWBzje4VY7zn1cWM4mFUNSBB8I6oqt9z2SvL2wBqfd/3/d7LVJ6cJP4
 BYYIYn1/SwjZ3vRZYnL7WWCCfYQWokXu+0IpvtwqAMbHP+NpDFJNNQ1lUbQpaOFaLMm5nBNFoW3
 Fh/9rq8cEfPiD1gfZHI0RLiwGDEToiuE+AMpyb43dYQPKyPTyM8AQtBFNUSSC5hOSnPvceV/cbk
 aDG9qN2a83skd8hb72V4YFCOBhMD+X4scfaq/fOpwK5EksvxyYX+c3DZsH5C/X6VnUBld5459mx
 0g4bwf/Jv/GaTnIlCg6teWfBrU/ojYyB1Z0NlOxH5TXcibYejQ2aLLJ33wqJ6ZfxCD9H6LkYoL8
 ieLhp/i56H4BLW2r+hjA6Pt3TCl9pg==
X-Received: by 2002:a05:6870:e090:b0:4a7:5eb7:ab97 with SMTP id
 586e51a60fabf-4a907704825mr1478668fac.32.1793366165933; 
 Fri, 30 Oct 2026 06:16:05 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 11/19] target/s390x: Use tcg_gen_lea_i64 in get_address
Date: Fri, 30 Oct 2026 08:15:46 -0500
Message-ID: <20261030131554.41208-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While there's no actual shift, use the compound function
to add two registers and an immediate in one step.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 474d604ed1..ce55edb93a 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -460,8 +460,8 @@ static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
      * displacements early we create larger immediate addends.
      */
     if (b2 && x2) {
-        tcg_gen_add_i64(tmp, regs[b2], regs[x2]);
-        gen_addi_and_wrap_i64(s, tmp, tmp, d2);
+        tcg_gen_lea_i64(tmp, regs[b2], regs[x2], 0, d2);
+        gen_addi_and_wrap_i64(s, tmp, tmp, 0);
     } else if (b2) {
         gen_addi_and_wrap_i64(s, tmp, regs[b2], d2);
     } else if (x2) {
-- 
2.53.0



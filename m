Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3901C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jhp-0002VN-9D; Wed, 02 Sep 2026 08:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1jhf-0002UC-2d
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:04:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1jhd-0007hM-Ax
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:04:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so622169f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788350668; x=1788955468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pH3G939DzcQw9XZQ2ox4honL/Bo1JBOKbYmXh2s86dk=;
 b=otpL3jRGpn0oiO8CGyCka9UH5Gl9P5/JMzNsMiq5tOTojrdtE4Y7zmLYJjNW9G+rhk
 Xvd2PMx7vi/Z50LBfy4d/kNbJP4PU9//Tm+dPq7Izm4WiQFHRefSwRXxXFr+Tc/9l9Mc
 bdMg+G8FmSxphv9g1a0e4AtQEAdQ5kh0ixHc3N74LX+iZz/Is2yPPAbordxpjOOoE9la
 su7z0A4talDiWAMhjzfWh0NqjvrzsT+ZYurGQT/fK/5OgBTUJ/FBR2SFuZmAlmG5vWOx
 eDmObZwj53sxDl71Nu8L4p1QOjDJsv6nG9iaMghfIcrH53u8TIai52LCy9+uPDIsZYB5
 MQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788350668; x=1788955468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pH3G939DzcQw9XZQ2ox4honL/Bo1JBOKbYmXh2s86dk=;
 b=mgGwHON5wNvzvbA2pxiZo/RikT0gjahbg1fJez7BfqpAdp5ROLFGAC/TZMky3i8Xue
 QVdoR0BkrDBtOA7q9uAGcqMHwZow1WoqKOgejqb0eRMz0AlBh4LgLEUoyJ75kJuKG/aH
 g/DiaAiikK1d6JeQKlN3RURQnbTBOvFSf3eWg4IQIHzhzu+g3782ZA7wqlxwa1Vab1RK
 la8aBaGnzbUQhRJf/GRNJSoYzWUDWwHm+ynKN3yk4+nZcicQYxJGd5XCESInJUlqQXSP
 dgE8FGOpXiu3QF9GA0T7pVxF3JPIsYWT7B5PnOej7E2gNNlzACvLqAzvVTrffQix6muU
 DVsQ==
X-Gm-Message-State: AFuF++kTWnzC6BH62TGZRSOR3XlkuZ+ibTETgnRhSNoSmKeBWpnFqQl+
 BNdSchxNgZ+gUSC3oxWVS5HqpnfTp8U05VqpBDwtQJty/n6BrOyn+WzqMmFIIGSY2ik=
X-Gm-Gg: AYBFou3Y0OCaPBeigbeNmf/fcmpEzx25Gc2n1xluUf90jMq/ye0Tj3+WzCbjYcbLjtc
 myvA+ybKGGNYNLKBmo1sfxhsYG9TkR6YIuqQjnF7ooNHI8AlqPZXnyvUVXOaWeCm7upylXzKJm4
 nyMjvyyNSR8JAjjNZYCH+UrjS5jiHxZEWmPBMeDWBG+iN9+u6L0htlXwBAMj/I+mdfVkhyp8UDh
 uJzcT/8r3i+Of+a0PhNoEfm3pb4Z6p4oZ+zBuORFdaNs2gtMmTMD3HDR6xSCTnrYn5y0b67AATa
 XIWKM5oX7EUUojTLwBqnwJwq58bdjPyXHstanTQcIspPWhAHq8De28H7N5hwIoDSMZgfkJqC8mH
 4pbuImquWQQhFct0aW+uaN29vNagAxGMeDsGuc7t10FhNZ83a98Y8c4TXshRpW4FRe2spoNKFHQ
 Z8dCqia0amWiBBEzNze+iZBK80UYaomJubeoNXYSNPrPhgib9iaSejMBRgAUvYzExm2E4BtMIco
 oClmIUsqs1p1wFqIWOmWdT3owqwI10Wl7CPpIJW8gaJVdB4ebd+8Qrb44Z7WAHatsQxBTaDzFcN
 kAZEbjitMbkoOKmsN9z8y12tVZYeQtk=
X-Received: by 2002:a05:6000:2586:b0:482:ea2b:c5a3 with SMTP id
 ffacd0b85a97d-48488efe58bmr7275725f8f.3.1788350667673; 
 Wed, 02 Sep 2026 05:04:27 -0700 (PDT)
Received: from simon-macbookpro.tugraz.local (tug-swl-225-161.tugraz.at.
 [129.27.225.161]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cdc37sm6504420f8f.34.2026.09.02.05.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:04:27 -0700 (PDT)
From: Simon Scherer <scherer.simon89@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 Simon Scherer <scherer.simon89@gmail.com>
Subject: [PATCH 1/2] target/i386: Update FPU tag word for FSTP
Date: Wed,  2 Sep 2026 14:04:18 +0200
Message-ID: <20260902120419.212855-2-scherer.simon89@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902120419.212855-1-scherer.simon89@gmail.com>
References: <20260902120419.212855-1-scherer.simon89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=scherer.simon89@gmail.com; helo=mail-wr1-x434.google.com
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

FSTP ST(i) copies the value in ST(0) into ST(i) and then pops the
register stack. ST(i) should end up marked valid in the FPU tag word
and the old ST(0) should end up marked empty.

helper_fmov_STN_ST0() copies the value into ST(i) but never touches
its tag. So if ST(i) happened to be tagged empty beforehand, it is
still wrongly tagged empty afterwards.

Mark the destination tag to valid in helper_fmov_STN_ST0().
This also fixes FST ST(i), which shares the same helper.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4400
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
---
 target/i386/tcg/fpu_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b812125efa..6ccc3c3b4e 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -510,6 +510,7 @@ void helper_fmov_ST0_STN(CPUX86State *env, int st_index)
 void helper_fmov_STN_ST0(CPUX86State *env, int st_index)
 {
     ST(st_index) = ST0;
+    env->fptags[(env->fpstt + st_index) & 7] = 0;
 }
 
 void helper_fxchg_ST0_STN(CPUX86State *env, int st_index)
-- 
2.53.0



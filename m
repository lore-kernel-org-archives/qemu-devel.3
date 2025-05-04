Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0867C3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvU-0002YZ-F7; Sun, 04 May 2025 01:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvH-0002Nc-IQ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:55 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvF-0004TO-Ox
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:55 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e15aea506so21472505ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336592; x=1746941392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dgq1OA4KuFLS5XceK9ZkHI9zBCVx2Be38qBE8eQ0ZbQ=;
 b=jKeAFxIIUDg1mx6rApIY4i02KjcKxdU8Dkj9f30DCeRa5UdpK2IYqXNf3SA0RXKmxN
 h635BTe+DSdeUnTaOfIEnD/R+Mr5etN0MX+wh2FupAruiY4rxJww9Gq6aUaeKPKCLA1s
 PzfuEJP1TZSkMw0T9/+Fmv7WMhlWyAVHRrzZ0R8OLvn1mCqei9hClf9mcurttpACLfTX
 k0TiJ7/QRO0X9TJ0NNrod6Nz0TWZoqtDZhtPkjY4amr/z77Id8dEwqIuIII7cwHc6Ds5
 yw8Yzgfzfc7SDKhr8PL4nviJART1EcAhuMmQz2OY21T3QZFxOY5gbOuKi7140hr9SKsm
 hdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336592; x=1746941392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dgq1OA4KuFLS5XceK9ZkHI9zBCVx2Be38qBE8eQ0ZbQ=;
 b=oQkRozoFaK4tbvSYuqd3rTOPksJM/PE0/vTzPY7YsV+YheQUCZ6T+pMZfo+GqNKtwk
 nGhOEantvYphMtzZzlC1UDNCaX/RaGREF5sYGibNSEdK8HGfZq3qT8AQEabzIG2sMGWU
 O6jKDEFrcytSMp/wDVJ8G+pQ2195F3nrkaZdpL6p6xdHQ8rPT1Q8hBvYTveYAXf2UsDm
 orTTiFdKQ6JxlSwVoYfMceahZQHwWBf7TKhTAEhARF17+qlOuADWMEsvbycgL/QrLROL
 qh9ajN3D2heemQjVvgZnb+KItwrka02Kfi6xmqHwCJ3NJVrpp16BZ+wClb0S7g3S39Yp
 Up8Q==
X-Gm-Message-State: AOJu0Yy5OrSigDMAt9F1FYg0+viPCK0K5NQpEv36cTkH3GDTiOaw0K1P
 BYbVdgrZUxwR1d2oFG1uvcY9lfLtp0GRURqwL+zRl92z3N5lNrkrrTAgjLA2tfUQDRc0pTjTv+M
 haYM=
X-Gm-Gg: ASbGnct2kbSBUUdeAe8Coxq54FV6lQObnNrCF1/u4bddikPRyfW2ud5SoXjfXf22qY/
 PMvEXYlVfTbi2Tr6PbhVWvIw2u/oN8hs0xgLisjX9PDdSNdpZdcEikMntHBui/zbVz2W7Aaw8vo
 M0L8C8NWXix45FDwpq1hjRIIEyMtqzRxe68MjrAXMCGdZYs+KM6dBsyYBmk7WyMrlpGu5Ej0woQ
 /3D/pcM1Z1Q6ouKxCRxWZujYKNj/Sp3iB/5DP9bkrQwXh9xvalX0VHiyJpXHRymQ07q4DpfjtQx
 kwZWb3LW3eXUZ9YTLNFpz6QplwCYwkbQpKDZRqhR
X-Google-Smtp-Source: AGHT+IH3PkRT437ZbtLEUIz8+9AOsGuVI8JqwVpnwH0hHYHJ1JXGA0CKFFoatJYNym7SpJ/H7Tlzqw==
X-Received: by 2002:a17:902:fc86:b0:227:ac2a:2472 with SMTP id
 d9443c01a7336-22e1ea7c667mr47948295ad.28.1746336592452; 
 Sat, 03 May 2025 22:29:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 37/40] target/arm/machine: remove TARGET_AARCH64 from
 migration state
Date: Sat,  3 May 2025 22:29:11 -0700
Message-ID: <20250504052914.3525365-38-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

This exposes two new subsections for arm: vmstate_sve and vmstate_za.
Those sections have a ".needed" callback, which already allow to skip
them when not needed.

vmstate_sve .needed is checking cpu_isar_feature(aa64_sve, cpu).
vmstate_za .needed is checking ZA flag in cpu->env.svcr.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/machine.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index f7956898fa1..868246a98c0 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -241,7 +241,6 @@ static const VMStateDescription vmstate_iwmmxt = {
     }
 };
 
-#ifdef TARGET_AARCH64
 /* The expression ARM_MAX_VQ - 2 is 0 for pure AArch32 build,
  * and ARMPredicateReg is actively empty.  This triggers errors
  * in the expansion of the VMSTATE macros.
@@ -321,7 +320,6 @@ static const VMStateDescription vmstate_za = {
         VMSTATE_END_OF_LIST()
     }
 };
-#endif /* AARCH64 */
 
 static bool serror_needed(void *opaque)
 {
@@ -1102,10 +1100,8 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_pmsav7,
         &vmstate_pmsav8,
         &vmstate_m_security,
-#ifdef TARGET_AARCH64
         &vmstate_sve,
         &vmstate_za,
-#endif
         &vmstate_serror,
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
-- 
2.47.2



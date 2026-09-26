Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6334AC98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMVF-0000Hy-2h; Sat, 26 Sep 2026 03:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMSM-0005fE-Fj
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:04:25 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMSF-0000im-4q
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:04:17 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e46a15703so1348988eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406253; x=1791011053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+A6CkIwPfSE+JT/uIHV8BW74dusgH/Hp+auhmSJ5o/0=;
 b=Z2ysJGauR8mBKOClVRny1YqcbLp7eeCvLOzWLZVXvW9eL1GONr0A0As5u+B68Crgei
 Y4clUtq9JoN4WkfTCaleoyUSJJWNRl+wcVi5qcPEkCZIdrz/1PkxzeQfOCwlOmm2WJgQ
 sPX70FccT4C95keJePeylC/uYNpn+MMiQUsTU02oD/8aLQZ5a9xU7brwm2JNBqMjpphK
 XhaQkj0NtXFgbgaKIaCnbUHtX6OwApqWpxb51sBR6iWxENK7aBCxdkhuxR6W9QLqeTMI
 ZLFG6wSB5DojWtDbuZDwVOEmhT8KjrehBzGbyp6pC1d+jdmhgG5kgGOAsiE8JOBhQ6of
 7HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406253; x=1791011053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+A6CkIwPfSE+JT/uIHV8BW74dusgH/Hp+auhmSJ5o/0=;
 b=mGGN3+qSQlwGw8P+fbpqmKE6kapuYxJGZt4OIyjUDMUFW4TReXtLKmz6DW0czJXzYg
 8lubX1CUkaej1zWKhGrroWNdK5zkMzI5piOyoyLWCfdrs4Wpeok/t4GYfgOWssWMnkyy
 mQHG2YaX1woDliqXv1GLKGeyRztwyQhvFMFYN/wiAGrZs6+O8o6bgVb2n7reB36FZAct
 6WYnIkg8nBKkWtJJ/R7tLfwyH2i8OkTsCNU98oduRbA4baTMWFor9nITM5JjSmwtUjpv
 EGyGm2UGmKeVKwDNLgfxO4Uu80MOkHXFN9mSYI+Dx0O8vwTEMtfeZIfJWW5rt03a8qog
 5BqQ==
X-Gm-Message-State: AFuF++nkxxMPW7qsDklayHXvnuILE7/KwcTMEC1W8J93/ucAIpNtHOkX
 O4ke2ISBv07g9p5wvQ7ctw0Z3RTps5v/Q4qhoX9IWLncXhke0lhZGIwveGLD7NQg
X-Gm-Gg: AYBFou3di0VKRb5/xvXjIHUgkbO3iWc8mVM8by18uEkkABIpue66WPoyFw7MNydOIkg
 wuicmsGNyeqfEScyUAqh/nqAauhFUH/6zxyGlHewA0XaByKTF1rZ1PLFC5otY44VkSxVB19XfpQ
 Wh9S/rOYaA9tKfPSe7pIbQJdfjaNF9r2rxYk21kwePYx/YUTy3vr9vGSCLX1ghlj4SmtB9QOxo8
 KGW4MhiAO45d4AtcNfJ5ROPy78qMjCKd7IRt7AtJxeh6ypt9S6CFmWWsW0mb7O1vjiH3VXdnBZV
 HcpnfqlUY1nswcveX6bXJ6mgH6kh62a6PlHKzhNYqToQsiJRgJ/GQZygLXe4EGKjUJAUXeH9Vk/
 QUTUT4aijwZfBB+ePYHmQfTGC2Hvu/tJYGZxdGJpxDOKGFRyosh5sQabfVL4JgacXFDXZgfLSj7
 Dl3Sa5dRkI5Q+NngEz4k1FcFXNbIMISgCJfalIlWw/4cjP6NRk3C4i0dYDz6YvDeVJ3czWWFKGw
 I7CrHUsawJWTPhY/QUk2D24DNBb9lPvHPKd/U5CXQ==
X-Received: by 2002:a05:7300:a987:b0:33c:1f00:358 with SMTP id
 5a478bee46e88-34270ac690bmr2902731eec.17.1790406252918; 
 Sat, 26 Sep 2026 00:04:12 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:04:12 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 48/55] hw/microblaze: set petalogix-s3adsp1800
 TypeInfo.is_available
Date: Sat, 26 Sep 2026 15:00:47 +0800
Message-ID: <20260926070057.1234-49-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Set TypeInfo.is_available on the petalogix-s3adsp1800 leaf to
target_is_microblaze.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f64319009..a1f41b10348 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -189,6 +189,7 @@ static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
         .name           = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
         .parent         = TYPE_MACHINE,
         .class_init     = petalogix_s3adsp1800_machine_class_init,
+        .is_available   = target_is_microblaze,
         .instance_size  = sizeof(S3Adsp1800MachineState),
     },
 };
-- 
2.52.0.windows.1



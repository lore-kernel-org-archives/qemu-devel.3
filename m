Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294B3C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyYd-0007o5-0a; Tue, 10 Jun 2025 08:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYB-0007OV-45
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyY8-0002gG-3c
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so64914925e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560273; x=1750165073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMlQwQj0IvSUVJlRfBARrapHZdCXw03PUrHdqVvfzZo=;
 b=BcwND4g/xEvykPd3NCGJH4e6BakUVkneAUcV9yk390DoyMG4J9Uj119trJOkbdrOt7
 jGy8O9cO2T5omKN3EyZGr/EHcWZpTSvXYQfhUgczSaNMQ71t1t5M+AtH/YoDJ9EFyhpn
 rJm/YqpMDRUfQ30HRESZF7iolPtZhEvQNDufJPrtNf8riJZNmfzf5U4nCQb9D7dUYsoE
 8h58qAufTBRhENxIzn3TyYaCBbHg/u0B/0NgxYPUButtrsQB6Q4JJFW85LJBlQJyxYl0
 avCB+07NgxsSTxE4Ap7jJsbaU0MlLf6T2W+TlfesgJ/9gZAFrI/O7WYH2ebJTJndzqdP
 xDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560273; x=1750165073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMlQwQj0IvSUVJlRfBARrapHZdCXw03PUrHdqVvfzZo=;
 b=szOsCXOaOHAgrWbIcyuHuryxjhbf1allchgcVzo+PEjx5ilincPIAGQqmuBk5tE+ER
 YeOnVgT98zpBtInvAnmSPS1I4+r7BWrDtUx52ol/QUGSSY4MilNA5aROHVM+VnCaHusW
 n0yow41VYHwPtPFivPNRO2pUu1IFspDLnljQHvj6hmHH18PFfrBpsvNjQuPSYRMo3rtl
 QE94ePGeDlwZ2ZHS2Sfu596NI0kiT/YR7D07m5gL7C1ovIX4+CVrJ/5pBfyS6I7SGju5
 ejbng9va9W4TNxGgDN3ngO4NJhydoTMSdPjnBZegLi2w5GM3gmHY93e9xpBzUpvCXvJw
 PZlg==
X-Gm-Message-State: AOJu0YzDH+jU5eoudIy6wXlZ/KUb2ATCkjBlNb+/T64GbxdHU/sJwQBU
 BDIO/csLWr0sPWEYcUDslX03FiPZVpvWcqrFhE8WbhVtlecRDvkzyLiHHsSF1zfR2ZJZ56Jy6oo
 yV/cJWrg=
X-Gm-Gg: ASbGnctE9sIhJ/3Snl6ZRt65jPKAK+SFpXRhxSrs4cGIRxIvSCVf2+23gmikkcMnWog
 IhwwniuCVDS/O1XpbqeEUUSnXkrtn0ido83gp5I6ND77SmP66Eidwd/WNlNUMSpURrsZWGB1xwa
 0eYcB5bTibWfFFzjEXMO+Rsvk4AJFW0xiPyzdSd8elUFtlt3Whe5XMm8v1dNgPHhMNBs/qAYyO+
 a7qB+H1V2ab0VOicPhNPi6qb++0i/nuykxFKxbjkJ/Bxw7HfIdq6ofvs4c71zRVqgO2RTqlOe1y
 xS4NYWZD2ABfd8ogmyEweBjb/mTcZIiYLk/uOIv0ABSK3cjbW1xqWULGSgREZO6ruXyJ1LrbSgj
 J0FmRzbLVlvzmZ9QiaZF7E687TTLThPFO7F9yvSs0ZB3ZyQEMwAP2
X-Google-Smtp-Source: AGHT+IHmyGVMVkcFPfrgkB6ZEz+YTkPV1qG+C63v7OFeVsfeDGXieLVn+yg8Fq9A5GrgVzAW/brsAw==
X-Received: by 2002:a05:6000:ecf:b0:3a5:5149:ed1a with SMTP id
 ffacd0b85a97d-3a55149ed48mr2303295f8f.59.1749560273211; 
 Tue, 10 Jun 2025 05:57:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de48sm12458281f8f.10.2025.06.10.05.57.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 17/24] tests/unit/test-char: Avoid using g_alloca()
Date: Tue, 10 Jun 2025 14:56:26 +0200
Message-ID: <20250610125633.24411-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Do not use g_alloca(), simply allocate the CharBackend
structure on the stack.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20250605193540.59874-4-philmd@linaro.org>
---
 tests/unit/test-char.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index 60a843b79d9..f30a39f61ff 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -993,7 +993,7 @@ static void char_udp_test_internal(Chardev *reuse_chr, int sock)
     struct sockaddr_in other;
     SocketIdleData d = { 0, };
     Chardev *chr;
-    CharBackend *be;
+    CharBackend stack_be, *be = &stack_be;
     socklen_t alen = sizeof(other);
     int ret;
     char buf[10];
@@ -1009,7 +1009,6 @@ static void char_udp_test_internal(Chardev *reuse_chr, int sock)
         chr = qemu_chr_new("client", tmp, NULL);
         g_assert_nonnull(chr);
 
-        be = g_alloca(sizeof(CharBackend));
         qemu_chr_fe_init(be, chr, &error_abort);
     }
 
-- 
2.49.0



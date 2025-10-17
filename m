Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4061CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kXv-00007Q-UC; Fri, 17 Oct 2025 09:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXt-00006e-Mk
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXj-0007zn-IL
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4712c6d9495so421875e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707846; x=1761312646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkTVJr9z+rZ8Ej16PgJskpCaibCQbwucKokBwl1LHIw=;
 b=rU+jEkFzI7qeyUvoYfi+HpwjnIIfEPp9HzJrPnas7coUTRy5WSqS0O2aQA3uvu87Qd
 BES1r19vPUKxxZCqIywGJmBxzmOAzfq9FgIux5jg3qfldCtR/YWxWJSNZTg5JwH1OVoV
 kkHaJja+JFhCCsDJL30jHaGhG4o5hK9hB0WkHYQV2uqQTqwnNtss6msFSXuBLUFs+F36
 FDb0JfMEPBo0OqTBYUm45z6zA2xdloWTCZei9PHDxnHPa6MfF+O8Fj2OaLX81fVrfx/R
 IfYTrT/++DxcJKPZKwZmM5YS14mJfYLR44eY0OMQeqea7ULK65ckufflHkQyjHnwehG5
 sf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707846; x=1761312646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lkTVJr9z+rZ8Ej16PgJskpCaibCQbwucKokBwl1LHIw=;
 b=LbeifvpPsizA4rkJ0ijRcE087BUpkZmWwuooTbt7HydeViNT1DoljUF1/zZvpyfCNi
 kw/HnMtQUP45RpCOcL35+0O4vita1iBNYllKwiCHP1W0YZzJtbpHKqAMCt/IMlZL/7Z1
 j0sXaqs/ZLMax6UoOrlspD8gIy6eDTwc9W90mxQnbTUNy0hZNP1qZgda7zPAt/Ccr1+s
 SHC/xN8YOPPfvc4Jk9oYbCwYZmuG8CAZn7alBSydjywkXvedejyd5o7U/EZQ1YHVfVbQ
 91Ri6FH6e7Ntv2uW6DULSeVXMukU8tGMtko6Fj5pyE44YNlYlFf4bRVib10r+NxQCpwv
 rrwQ==
X-Gm-Message-State: AOJu0Yxo3YEiQibxHp+UjBeqFhT3bnZCDd4rYFiRCyWowcTbgS13ZCxO
 4qn7PeX7J7egigpBTXyIH9iRRcMvXF8El9U23d8U3OdrcQdsdcfxfTeHPcuSGVP+PrhtczGA9nr
 SgaqxNNU=
X-Gm-Gg: ASbGnctLn0OdpzDx4f01aRgTiwRonoUvqw8czPlz2fLUa0yNTcKEOhuZ+R2oKtPTo2h
 i3/eyXjpJ7g6dudqojqHsQYPfrKoiMg2zTtfbxCRsHXXJjehmXglSlmz1sPQt8X0dABQ59a9VTN
 ZGJFUSAlw3JVY97/5LVzBCFFZOW6meAHZLANAvy5JNuywz86at6FvVUgyGuBUZ63g03Vgn9rRur
 wTautZE5P7sC7tU8cUEeV7ib6r54PDSniHkX63VGLlaomI37Q8Sr3oW/1LBIIR1oud1UHL8qlPq
 RtkPNbwnHsHZ43uvc3YIYOAoQGY0mmIs8HWbOK1VOyT3DVZ9SyIz3kV92dn3/lcPEToL+OM+tu1
 FUZ8EYHUA4EWSmByuOrlLs2Jl0yM1gUqUbMUpJKzxfDDuFlomer86hnzBzKcLaiWLv48EzdioTo
 aZrSZ53tPou3mzyLDjrcTCw7z3g7Iyyb4ckha9oDmPsqJml2arsw==
X-Google-Smtp-Source: AGHT+IEXCWNkuZjOsi72UpPYq6bjXmnWujQd/jZOVWoOv1YUc9u+hMx15V5Jf5TrcSqDNUY9ByJJJg==
X-Received: by 2002:a05:600c:8b62:b0:45d:d97c:235e with SMTP id
 5b1f17b1804b1-47117876bcdmr27022565e9.12.1760707846547; 
 Fri, 17 Oct 2025 06:30:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1024sm40422758f8f.42.2025.10.17.06.30.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/12] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-6.2
 machine
Date: Fri, 17 Oct 2025 15:29:57 +0200
Message-ID: <20251017133002.61410-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a22d1fbef36..319b597d12b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1061,21 +1061,6 @@ static void ccw_machine_7_0_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(7, 0);
 
-static void ccw_machine_6_2_instance_options(MachineState *machine)
-{
-    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V6_2 };
-
-    ccw_machine_7_0_instance_options(machine);
-    s390_set_qemu_cpu_model(0x3906, 14, 2, qemu_cpu_feat);
-}
-
-static void ccw_machine_6_2_class_options(MachineClass *mc)
-{
-    ccw_machine_7_0_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_6_2, hw_compat_6_2_len);
-}
-DEFINE_CCW_MACHINE(6, 2);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0



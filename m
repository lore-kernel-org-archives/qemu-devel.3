Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACE5D4899E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgjia-0000Mo-KQ; Fri, 16 Jan 2026 08:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgjiZ-0000MW-2H
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:18:23 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgjiX-0004RD-7j
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:18:22 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so1056992f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 05:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768569499; x=1769174299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gWO1do/b15zp8tnwWSEzOysFCA1vsuwaZ3tZ4MrlfQQ=;
 b=Bi5TabPPlV14i704/eRHjrckAQPaeTFUrh3Sp1nuONcP8agxon9HyfjDOdtjliWUZq
 jEy4fra2Rnls157Rwb/0nG6nw7otAXHEEIsa3CZCLGVh8d2yMlylYbUY9pj9p0G1XsXH
 I6HXyT29gXdLZ8BnrIK7oYGxrYoo+LePSOYH4it4dSXGlv/uI8ZwjTUYAFNrNtVUfd+t
 6jTQywp2JQmENx1IUQP64DLwqDTXAk2TNmRrSlftRA0MVPqyP2qZG9jRgZX29b7gHl+0
 lrIWoj2K5vu1zYGE6c+cNMW+5b1IpbewFrOOQ/p4AsIcz+GS5TcCRynuciXPCRXPlshF
 Tmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768569499; x=1769174299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWO1do/b15zp8tnwWSEzOysFCA1vsuwaZ3tZ4MrlfQQ=;
 b=pc4xQQ4RaJNGDLOgFOazoJvtas8ACsBi/xQFniK4LQEpuZq5V0g2pKDCGgOU2uDSPZ
 FAxmqSzpqAniy2y+p7+0nxK7AZdaEq6hR2Rge/Bw/GY9wFNX0zYqcGa4eFq5gGdCnbMr
 TVqktUzu8h9gL1tFxHrIVuJ4MTHoGqvnt0qVohVZD4dLx1SF3wFY5UeHpngSIwdANJyd
 lA2lRQIuMsTuEmYPRrD29doEVxQIMmjIxnECNrs4jyVMPBd+gAHZiqupYThrXs6UwrOu
 RMZVpr/2AGSIgS8UWYkqWGeoQxQ2lLtWSGWL5r58AwIiv8AOQ/+b+8vFCP6iA24BuFF3
 i4Fw==
X-Gm-Message-State: AOJu0Yxmgzm4XitCVGjbppz+yiBQwPK27xIZc6E3Hql9jE4tYPDek9rR
 A1uNOceNbUG27Q3Pb2+CSaftYEkE0THsEfzWxsyONctwpgZeaA6ZvrKnxEj4Axgkfq9FUk0QhZ4
 O1dEJZ0g=
X-Gm-Gg: AY/fxX6TN0yFSIQMj+c3Pgh2Om5uDXynLdfyyVOwPS+Af6spY7PC8ml1CRNy8B69EZp
 wR0fQiCP8gvMzAn0/KG+aE1kYzwMCfg/gT74Tvm0NmmlQM2iiUCLAfTrD/tMZNrelAVoS1AkEmi
 PzAPXpJx9wtEVUTpmeoDAo+PLhkLtfzbau/tgowKUQvOgMqhyGeuB12DBDqmHGC5eKMKrNatnU/
 FEzb0yJfxUy6jOy1Ik+qEUJ6+w7DfmkS5r+cMI5O1HmdTe1b2WkDQtzE3FQfE4c1UFrtBOs0XqM
 D1hPorSpZW3Z7/nhJF6jQyUiqD6KZkY+C6GxJ1WuNxfK0Cqqev55o+NIzMogduMZH7WwSedtDJX
 WfeNQ49eCWVzqeydsjxAOCjH2p94DyOlKQBQRxMtSSAYRHolFYcDLIs8G6NlF7pTxRdjAHaY5hu
 JyTy4YNxWzb9nJmQGPlrzojnL5eujHItVxT33eTlndeW7/CrscqDkNNGbB863G
X-Received: by 2002:a5d:588e:0:b0:431:7a0:dbc2 with SMTP id
 ffacd0b85a97d-43569bc0085mr3633583f8f.31.1768569498911; 
 Fri, 16 Jan 2026 05:18:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569927163sm4977611f8f.12.2026.01.16.05.18.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 05:18:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Frederic Bezies <fredbezies@gmail.com>
Subject: [PATCH] meson: Do not try to build module for empty per-target hw/
 directory
Date: Fri, 16 Jan 2026 14:18:17 +0100
Message-ID: <20260116131817.38009-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In commit 83d5db95d38 ("meson: Allow system binaries to not
have target-specific units") we allowed targets with empty
target_system_arch[] source set, but missed hw_arch[] could
also be empty when building modules.

Skip such case, otherwise due to commit a1ced487549
("hw/microblaze: Build files once"), building with
--enable-modules triggers:

  ../meson.build:4034:14: ERROR: Key microblaze is not in the dictionary.

Fixes: a1ced487549 ("hw/microblaze: Build files once")
Reported-by: Frederic Bezies <fredbezies@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3272
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 2339aa4db2a..5bb8d0b3ebc 100644
--- a/meson.build
+++ b/meson.build
@@ -4029,6 +4029,11 @@ if enable_modules
   foreach target : target_dirs
     if target.endswith('-softmmu')
       config_target = config_target_mak[target]
+      arch = config_target['TARGET_NAME'] == 'sparc64' ? 'sparc64' : config_target['TARGET_BASE_ARCH']
+      if not hw_arch.has_key(arch)
+        continue
+      endif
+
       config_devices_mak = target + '-config-devices.mak'
       modinfo_src = custom_target('modinfo-' + target + '.c',
                                   output: 'modinfo-' + target + '.c',
@@ -4038,8 +4043,6 @@ if enable_modules
 
       modinfo_lib = static_library('modinfo-' + target + '.c', modinfo_src)
       modinfo_dep = declare_dependency(link_with: modinfo_lib)
-
-      arch = config_target['TARGET_NAME'] == 'sparc64' ? 'sparc64' : config_target['TARGET_BASE_ARCH']
       hw_arch[arch].add(modinfo_dep)
     endif
   endforeach
-- 
2.52.0



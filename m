Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D160DF589DC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuSf-0000ik-3W; Thu, 23 Apr 2026 09:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSU-0000g9-N0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSQ-0005oc-7w
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so48160905e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952264; x=1777557064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xo9+PVRtt+5NON2Kj6mTrN4MMNYuwyQS7G6lhP4uHOk=;
 b=S5nHT4aK/mv7tkCRm8bLgtjzNk/LNyPdQMM0AWgP0x68Q2/m1yx7Cvgx4UlCyOguD6
 KYvaeIhWo0tmmOVV7qqEfzMkAS3XpRxDvBfL/TECcEBUYfX2JR6Kpo2jhqBQcvXwTuHl
 0r96MMGvFWtyvpscbQjF4oLVMQ9OFSVafjy8uQRrlb3Jz8R7k4pqBWFSD9dwnj6giawd
 V36zH9ZkOoF5Y/TTPkzJojuwMXJhe7j7pGBQzEqo+XiAHhvaxyvqc4ztSBJ3Oz2X7Hh3
 URBfbUXRHS16FrK0iHwDg3YbhfaXx0RYku8avv3Mzqn/x9Dyu7k+aV5VqjN6LNXL/A56
 Fcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952264; x=1777557064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xo9+PVRtt+5NON2Kj6mTrN4MMNYuwyQS7G6lhP4uHOk=;
 b=XlAwvFybfmsE+i8Z/j4X45Y3PGIHWp5YfImAz+K0uS9UDLKg6j0N46jy3yWjOBd8VS
 rRX4oQf2lAForr32npQ36jJXnQdCg5rfU0Aij4mStQJO2qZWjonaZ6SA1u+YXSLoKC33
 oGKsyoX/1r7SgwrWwoni5IK7TR5W7eN7l07+R4iG8mOwdCsv+dmTtt58rdfXlgpyBR7R
 JjgYvz51luVkhtAxjedkb6F7ofMRCCD7gGrlUDtp1x5E8I2P2xg6YTUOdB9RVXCkMw3+
 IllTSiAho+Ptqi+I3s5TlRykKTWF8pzJKeZHhqQtVQt1iBsKquCuiVmnbF+MrqYDKgpF
 bJjw==
X-Gm-Message-State: AOJu0YxOxlZj2uW2h32GfXAmljkG/QB/L7FdwrCI3bUo6RDOqYyQztMY
 HfT9aIFIlrheMpinLGOWyJ0COtwUvccTsqE8axwmTZY0uAHzV2FqERik0M7bTL3Jvb3Vw6bV8um
 /ZekoX3Y=
X-Gm-Gg: AeBDieuWWUOZS8Yh/gTs+59+dsUge02MtJElIDydbFDNrj2yGjDPDJCH6JwHoIQnN/p
 A7lc2yY5oZmbDuPRkmmd0ynOCP4qy5GqSB+algo2XkKmnr9V2xZmAFvvvCDzbK2BZn47Me6PErT
 C28663O7f+RxRNHmMTfej668MhlpTzL1nMWE5jI8cqGyujHfEoUzyp28VrwtpfrTMCGz94ZOlM0
 O//UJHu7N1oXvE9nuxkmfkCM186/mfPeHfGQnc7KJgNMlra+DbhzOsWLkdaIyld75OQ9crHxQZi
 GKq0eyxNUsR0rVRxDXP9UEgzlX/lckULNAv/7fKp9x6GXJ/fJjue89fh8zqDvT6ZyR5POAgCuR4
 yiwZBqt+kMOakb1vXaQiKyoMFPJmuT8vyelH9PjLFFcMrKtzSUqCj5CDaiyG2m3aRCu5iReEFq/
 aOyo+XFUy7rffhhZn8X1CKFb8Q27LZUjyrmDy48FxeNhBi67Iuz5SrPC5C5DjIErxSHGQRI6VGF
 6Fo1kptfM+X4vZw0+IurQ==
X-Received: by 2002:a05:600c:1e09:b0:48a:592c:e655 with SMTP id
 5b1f17b1804b1-48a592ce7c2mr129588645e9.17.1776952264460; 
 Thu, 23 Apr 2026 06:51:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm565231035e9.1.2026.04.23.06.51.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 06:51:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/9] target/s390x: Introduce common system/user meson source
 set
Date: Thu, 23 Apr 2026 15:50:29 +0200
Message-ID: <20260423135035.50126-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423135035.50126-1-philmd@linaro.org>
References: <20260423135035.50126-1-philmd@linaro.org>
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

Introduce a source set common to system / user. Start it
with the files built in both sets: 'cpu_models_user.c'
and 'gdbstub.c' No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/meson.build | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 6f98ce34d73..44f58ac2919 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -1,4 +1,9 @@
 s390x_ss = ss.source_set()
+s390x_common_ss = ss.source_set()
+s390x_common_system_ss = ss.source_set()
+s390x_system_ss = ss.source_set()
+s390x_user_ss = ss.source_set()
+
 s390x_ss.add(files(
   'cpu.c',
   'cpu_features.c',
@@ -15,15 +20,16 @@ gen_features_h = custom_target('gen-features.h',
                                capture: true,
                                command: gen_features)
 
-s390x_ss.add(gen_features_h)
+s390x_common_ss.add(gen_features_h)
+s390x_common_ss.add(files(
+  'cpu_models_user.c',
+  'gdbstub.c',
+))
 
-s390x_system_ss = ss.source_set()
 s390x_system_ss.add(files(
   'ioinst.c',
 ))
 
-s390x_common_system_ss = ss.source_set()
-s390x_common_system_ss.add(gen_features_h)
 s390x_common_system_ss.add(files(
   'helper.c',
   'arch_dump.c',
@@ -32,19 +38,14 @@ s390x_common_system_ss.add(files(
   'mmu_helper.c',
   'sigp.c',
   'cpu-system.c',
-  'cpu_models_system.c',
-  'gdbstub.c',
-))
-
-s390x_user_ss = ss.source_set()
-s390x_user_ss.add(files(
-  'cpu_models_user.c',
-  'gdbstub.c',
 ))
 
 subdir('tcg')
 subdir('kvm')
 
+s390x_common_system_ss.add_all(s390x_common_ss)
+s390x_user_ss.add_all(s390x_common_ss)
+
 target_arch += {'s390x': s390x_ss}
 target_system_arch += {'s390x': s390x_system_ss}
 target_common_system_arch += {'s390x': s390x_common_system_ss}
-- 
2.53.0



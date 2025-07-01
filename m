Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CF4C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSi-0005lP-HC; Tue, 01 Jul 2025 13:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSf-0005jP-P6
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:02 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSd-0003hW-J9
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso59055445e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389678; x=1751994478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/DJBJh8TrP9nUNYIuMCuVv0lIVyAFjDZ5LeEIS1A2hs=;
 b=NP+On352uk9XxY5EWB6SyeR7lIwaft4AwmaYHacGk0jrrOVemV4FNBM4SYWvv/WGjD
 h0pVwwcUk8KjEijjDBjDjek2rtxXs3knnDyRUG9eUWB9scX8nWm0gE5NkmQH8J5LU16d
 RL2cvIJk/2GTB9MXg0EPhxCH+03kIt4z2ZU0s7vumFepJ+EwfttA1FFsuiUEuCsZrZmi
 PCN7dijsXqOIvs80e0i42X//PfOauqHmVN02Z4SUCte56/HOuiv/QPGOxjCdP6d6rJwq
 c/nHTqIKe+s8l462Il2dtmHhSVW/sa9LtX0sKSPMb/8v/vRmIR9IDDyEx9qbPFKK0AFM
 MNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389678; x=1751994478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/DJBJh8TrP9nUNYIuMCuVv0lIVyAFjDZ5LeEIS1A2hs=;
 b=ONUl+PILRFmEThc+6RiHNu1ePJUDRxhSUqhdUDwVtqiHUM0iqGgPVRQxIU/bRqRJSy
 v91lmzEfhTv6zeVhtd03m7iutPWR6WnGHsc0ZvuFUDDjhxP1HDNE2q+Be3KBK2t+bvwe
 zL26NfiwwyaP22dqWWbheFOOrwPAVqu9vODVfdGlDCHk2eKKITGLA2Tzfa8G0LnrdND7
 Rdg5v3y0GNmEFcFRGugUaQhKY2jpzE3kw1fXmfRv4c7XJytchtEXLA9MWmigzlF5VMx8
 N4n2wPcK5+dYHL+mNbME7bXl+ZYYkjmL6C/A8Iw1UH5hJpkffrTt5ICjSTwA1NNrWX26
 PCxA==
X-Gm-Message-State: AOJu0YwsypsqlTvUx90VCtir3Qyc5LeJl1/fX0XNlQJ89kyJRcz3hkfn
 VfghXkjTpyenne4nNKwYqfGNpCrJMDaIzb7SqPBrueR7kkoKzgg2qHMA4lzRRjgGymmuwygnQKN
 WHw8M
X-Gm-Gg: ASbGncsqPAvzINgnFTjLA4BBuTJiTTtXX0+eJVh0c/YRKNQ22q7zFZGTTU70lqZsKTC
 HYzf+QpDxstI3ZZKkjXgzNrXuFHtiUW8+HKg2FI4R7jIHUKV2Ww5Utj/8LMGFFYPI34P6B8l5/+
 L8GZhCnrrFipDeF5AzrLRsG5IyEc+t22+TvaS8IjXPpbK0PNhSJ8iV7RvYGMn4E3kKBc1xPIqXP
 Jjw/F6wfWhP5r8bMZeNEHYfUODgU9qJuraJvyYUU2j3e1OvnBhwB4Na+NCZDlHYvAUStxQzZ5vU
 M0yJHV50YgfMUZUtSqlK7Q+iwIpwxyPGPED1y3oVXLlTnIe8cG1QJZRpZgZyMxjLpUaZ
X-Google-Smtp-Source: AGHT+IGP43PWGmrE7psT6MXrxh+XXLSx++nBtTqW3Zd0Zyfz8u3MDnK4G0F3SHHYbSqZmyGd492Z2g==
X-Received: by 2002:a5d:58d5:0:b0:3a5:8cc2:10aa with SMTP id
 ffacd0b85a97d-3a917603a95mr12757804f8f.32.1751389677919; 
 Tue, 01 Jul 2025 10:07:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/43] hw/arm/virt: Rename cpu_post_init() ->
 post_cpus_gic_realized()
Date: Tue,  1 Jul 2025 18:07:12 +0100
Message-ID: <20250701170720.4072660-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QDev uses _post_init() during instance creation, before being
realized. Since here both vCPUs and GIC are REALIZED, rename
as virt_post_cpus_gic_realized() for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-21-philmd@linaro.org
[PMM: also fixed up comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 30f91bcfb3c..3bcdf92e2ff 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2026,10 +2026,11 @@ static void finalize_gic_version(VirtMachineState *vms)
 }
 
 /*
- * virt_cpu_post_init() must be called after the CPUs have
- * been realized and the GIC has been created.
+ * virt_post_cpus_gic_realized() must be called after the CPUs and
+ * the GIC have both been realized.
  */
-static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
+static void virt_post_cpus_gic_realized(VirtMachineState *vms,
+                                        MemoryRegion *sysmem)
 {
     int max_cpus = MACHINE(vms)->smp.max_cpus;
     bool aarch64, pmu, steal_time;
@@ -2346,7 +2347,7 @@ static void machvirt_init(MachineState *machine)
 
     create_gic(vms, sysmem);
 
-    virt_cpu_post_init(vms, sysmem);
+    virt_post_cpus_gic_realized(vms, sysmem);
 
     fdt_add_pmu_nodes(vms);
 
-- 
2.43.0



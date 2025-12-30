Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A8DEE57C2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagxB-0004aq-Rm; Tue, 30 Dec 2025 16:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxA-0004Zz-U0
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:28 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagx9-0002Ej-5E
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:28 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-47755de027eso61075955e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128905; x=1767733705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YEG6iZ6Aw3LQd9IRTTR+j/7S3SvDhMq9IcY5HHvReKc=;
 b=YSgpjQfdNREyXxKHE7+4Yu75rG+BL+k0FG2zNVCnJ4X++dXRR5v+qNcb4ha8T896N4
 hZRi2QZyX47emHwBw5JsUlALXHkJb9gyeYQYJI+Rb0j1Qc3iCBtO/+wyV/UdEsiSMtD3
 7oYyhQhbXBSfjuewU1CT1SdNuTsCcw5a5li7LYk8Y9SYFm9958z66Bn/Bw82GnRnbYSR
 nMlbRSZmlT7db9ChnJY5tVUN82JPzDDjueSk+ygl1hFiy7FyePK9EnmW5v1eNTOuozSm
 VJ+svPx8tEKBfgiJbKOwq2/mh36OZwSBVrTlSgTY34A8mE/vfOJD0uSCuJAdwlMrV3Nc
 nYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128905; x=1767733705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YEG6iZ6Aw3LQd9IRTTR+j/7S3SvDhMq9IcY5HHvReKc=;
 b=A1SOV+GxA3re7XnFEAdHXwIOHWlIy1E9KeHaPOLLh7hXO2Rwn4OwwfBpQVYW3r3jOX
 ibrOMq13b4u6fQ2HIsmEzPAlwxRGZxcnmk+GD+lCHBECk0JC8b0GmzefRMaG1TKRvxTv
 LnhKbmCRkVDSBz1q9jDYUqF02zpnmO32czMngoPAIpY8Eo5tWRM8L7keBcJVOF+Z+1vy
 w1TT+E+df8KkQkYrRsDcDZeautajjrqZdi3dIPvtUqI1vDY7SU+BJJkgxdXZ0q5aAJL1
 AtSN6L1cqrZKY36vW6Z5ZAGlwtEw7lhvmnEpsF2+LmK1GGSsWI8zjjgQ4L8/HxhpcWQm
 6zEA==
X-Gm-Message-State: AOJu0Yw9f4CU4ttoCk1k/aF80VgZTKXp1R5QjWUKguLpkfTO3lyPGlSX
 W+AQITZ/U3rFC0oQX5GMnaupvqjFS06nxbFN/UPLmtqovArQHZtu27KPHqnpf+8mz4vt351RjK3
 3g/iaLk8=
X-Gm-Gg: AY/fxX6dnN/Cf59q8d2iPgSusDYrCKjzAr/8sRdPJFWUuajaWzrFrQFcYaxMrE/v38c
 lMxzJ4oCSZTHtBBQmqspeBag5LDvVThOHm88+spOaN+jqEa226cfoB2odBC2yiusW7XZAkmBJai
 jzhaLtxeuoxpDGm7Z1Kzj3u7OA6lXcjlWE0bSEO7yjOJsocVJQMmdoil1B8s/I6+320Rn36qw6t
 KJ+mAWDIqZh6vh7Lqyn8hyMnxAaYs04XzU/iqH4mB/xf+6byCoWAsA/gPQkhASOtaytUpuA7gXM
 Ca+bSW54WwBE5DZV1VfdIotsuLJBFcKBsCgk5zOr7GDbTz4LXQA9PtEmm2z8IAZkOhAn/wrv94f
 b5S1nIITRArPjslvjUdEVsPvC5p9sa9RLpFc+b9MBxtsWbsPzcSZPTPpatFS62p5bBFBX+FiXri
 Y6jjKdCPcZhMiaDfLuWsLlwGN04X93iJMdDc1VP9vSmfsqJJDZY/QWVuZEGFav7DIhhJr50to=
X-Google-Smtp-Source: AGHT+IEPHCNmtgG5XM11k8QqrbT6RoyvIC3v+e+8gRAeVchklO+RXBRHUNAmdK/7JgNQL8hDKQYT4Q==
X-Received: by 2002:a05:600c:46ce:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-47d1953bb1emr442489195e9.1.1767128905218; 
 Tue, 30 Dec 2025 13:08:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193621c8sm609207835e9.7.2025.12.30.13.08.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:08:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/34] hw/misc: make the tz-ppc-port names more useful
Date: Tue, 30 Dec 2025 22:07:26 +0100
Message-ID: <20251230210757.13803-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The TrustZone peripheral protection controller (tz-ppc) sits between
peripherals and the main system. However this results in "info mtree"
looking at bit confusing, especially as the sequence numbers can
overlap and miss steps:

      0000000000000000-ffffffffffffffff (prio -2, i/o): system
        0000000000000000-00000000003fffff (prio 0, i/o): tz-mpc-upstream
        0000000000400000-00000000007fffff (prio 0, i/o): alias ssram-0-alias @tz-mpc-upstream 0000000000000000-00000000003fffff
        0000000028000000-00000000281fffff (prio 0, i/o): tz-mpc-upstream
        0000000028200000-00000000283fffff (prio 0, i/o): tz-mpc-upstream
        0000000040080000-0000000040080fff (prio 0, i/o): iotkit-secctl-ns-regs
        0000000040100000-0000000040100fff (prio 0, i/o): tz-ppc-port[1]
        0000000040101000-0000000040101fff (prio 0, i/o): tz-ppc-port[2]
        0000000040102000-0000000040102fff (prio 0, i/o): tz-ppc-port[3]
        0000000040103000-0000000040103fff (prio 0, i/o): tz-ppc-port[4]
        0000000040110000-0000000040110fff (prio 0, i/o): tz-ppc-port[0]
        0000000040111000-0000000040111fff (prio 0, i/o): tz-ppc-port[1]
        0000000040112000-0000000040112fff (prio 0, i/o): tz-ppc-port[2]
        0000000040113000-0000000040113fff (prio 0, i/o): tz-ppc-port[3]
        0000000040200000-0000000040200fff (prio 0, i/o): tz-ppc-port[5]
        0000000040201000-0000000040201fff (prio 0, i/o): tz-ppc-port[6]
        0000000040202000-0000000040202fff (prio 0, i/o): tz-ppc-port[7]
        0000000040203000-0000000040203fff (prio 0, i/o): tz-ppc-port[8]
        0000000040204000-0000000040204fff (prio 0, i/o): tz-ppc-port[9]
        0000000040205000-0000000040205fff (prio 0, i/o): tz-ppc-port[0]
        0000000040206000-0000000040206fff (prio 0, i/o): tz-ppc-port[1]
        0000000040207000-0000000040207fff (prio 0, i/o): tz-ppc-port[10]
        0000000040208000-0000000040208fff (prio 0, i/o): tz-ppc-port[11]
        0000000040209000-0000000040209fff (prio 0, i/o): tz-ppc-port[2]
        000000004020a000-000000004020afff (prio 0, i/o): tz-ppc-port[3]
        000000004020b000-000000004020bfff (prio 0, i/o): tz-ppc-port[4]
        000000004020c000-000000004020cfff (prio 0, i/o): tz-ppc-port[12]
        000000004020d000-000000004020dfff (prio 0, i/o): tz-ppc-port[13]
        0000000040300000-0000000040300fff (prio 0, i/o): tz-ppc-port[0]
        0000000040301000-0000000040301fff (prio 0, i/o): tz-ppc-port[1]
        0000000040302000-0000000040302fff (prio 0, i/o): tz-ppc-port[2]
        0000000041000000-000000004113ffff (prio 0, i/o): tz-ppc-port[0]
        0000000042000000-00000000420000ff (prio 0, i/o): tz-ppc-port[5]
        0000000048007000-0000000048007fff (prio -1000, i/o): FPGA NS PC
        0000000050080000-0000000050080fff (prio 0, i/o): iotkit-secctl-s-regs
        0000000058007000-0000000058007fff (prio 0, i/o): tz-ppc-port[0]
        0000000058008000-0000000058008fff (prio 0, i/o): tz-ppc-port[1]
        0000000058009000-0000000058009fff (prio 0, i/o): tz-ppc-port[2]
        0000000080000000-0000000080ffffff (prio 0, ram): mps.ram

So as a quality of life feature lets expose the name of the underlying
region so we get something more useful:

    0000000000000000-ffffffffffffffff (prio -2, i/o): system
      0000000000000000-00000000003fffff (prio 0, i/o): tz-mpc-upstream
      0000000000400000-00000000007fffff (prio 0, i/o): alias ssram-0-alias @tz-mpc-upstream 0000000000000000-00000000003fffff
      0000000028000000-00000000281fffff (prio 0, i/o): tz-mpc-upstream
      0000000028200000-00000000283fffff (prio 0, i/o): tz-mpc-upstream
      0000000040080000-0000000040080fff (prio 0, i/o): iotkit-secctl-ns-regs
      0000000040100000-0000000040100fff (prio 0, i/o): tz-ppc-port[gpio0]
      0000000040101000-0000000040101fff (prio 0, i/o): tz-ppc-port[gpio1]
      0000000040102000-0000000040102fff (prio 0, i/o): tz-ppc-port[gpio2]
      0000000040103000-0000000040103fff (prio 0, i/o): tz-ppc-port[gpio3]
      0000000040110000-0000000040110fff (prio 0, i/o): tz-ppc-port[pl080]
      0000000040111000-0000000040111fff (prio 0, i/o): tz-ppc-port[pl080]
      0000000040112000-0000000040112fff (prio 0, i/o): tz-ppc-port[pl080]
      0000000040113000-0000000040113fff (prio 0, i/o): tz-ppc-port[pl080]
      0000000040200000-0000000040200fff (prio 0, i/o): tz-ppc-port[uart]
      0000000040201000-0000000040201fff (prio 0, i/o): tz-ppc-port[uart]
      0000000040202000-0000000040202fff (prio 0, i/o): tz-ppc-port[uart]
      0000000040203000-0000000040203fff (prio 0, i/o): tz-ppc-port[uart]
      0000000040204000-0000000040204fff (prio 0, i/o): tz-ppc-port[uart]
      0000000040205000-0000000040205fff (prio 0, i/o): tz-ppc-port[pl022]
      0000000040206000-0000000040206fff (prio 0, i/o): tz-ppc-port[pl022]
      0000000040207000-0000000040207fff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
      0000000040208000-0000000040208fff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
      0000000040209000-0000000040209fff (prio 0, i/o): tz-ppc-port[pl022]
      000000004020a000-000000004020afff (prio 0, i/o): tz-ppc-port[pl022]
      000000004020b000-000000004020bfff (prio 0, i/o): tz-ppc-port[pl022]
      000000004020c000-000000004020cfff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
      000000004020d000-000000004020dfff (prio 0, i/o): tz-ppc-port[arm_sbcon_i2c]
      0000000040300000-0000000040300fff (prio 0, i/o): tz-ppc-port[mps2-scc]
      0000000040301000-0000000040301fff (prio 0, i/o): tz-ppc-port[i2s-audio]
      0000000040302000-0000000040302fff (prio 0, i/o): tz-ppc-port[mps2-fpgaio]
      0000000041000000-000000004113ffff (prio 0, i/o): tz-ppc-port[gfx]
      0000000042000000-00000000420000ff (prio 0, i/o): tz-ppc-port[lan9118-mmio]
      0000000048007000-0000000048007fff (prio -1000, i/o): FPGA NS PC
      0000000050080000-0000000050080fff (prio 0, i/o): iotkit-secctl-s-regs
      0000000058007000-0000000058007fff (prio 0, i/o): tz-ppc-port[tz-mpc-regs]
      0000000058008000-0000000058008fff (prio 0, i/o): tz-ppc-port[tz-mpc-regs]
      0000000058009000-0000000058009fff (prio 0, i/o): tz-ppc-port[tz-mpc-regs]
      0000000080000000-0000000080ffffff (prio 0, ram): mps.ram

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251215170548.2594651-1-alex.bennee@linaro.org>
[PMD: Wrap long line to avoid checkpatch.pl warning]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/tz-ppc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 159073d1e6d..6f820430eed 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -273,8 +273,8 @@ static void tz_ppc_realize(DeviceState *dev, Error **errp)
             continue;
         }
 
-        name = g_strdup_printf("tz-ppc-port[%d]", i);
-
+        name = g_strdup_printf("tz-ppc-port[%s]",
+                               memory_region_name(port->downstream));
         port->ppc = s;
         address_space_init(&port->downstream_as, port->downstream, name);
 
-- 
2.52.0



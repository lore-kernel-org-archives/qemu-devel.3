Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE97ACD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 17:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOIca-0002S4-4F; Sat, 16 May 2026 13:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIcY-0002Rl-Sk
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:16:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIcX-00086T-5r
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:16:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso6330385e9.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778951771; x=1779556571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xr7AB72ORRy71rA35bL81bHEuFs70DepQLKA20BG1Qg=;
 b=nZ3uuSnYWWuc7qtc4dQbNiJwTBK9peBjptfM4uy2wgXrHi6IMI7HwC3DeGFYbRreS6
 R1fM75ZMWee8JLf33kx4hue97AlYKNdQgHe1v4yO23lt0grwEOZUkTYFaWC6/1vbYrRD
 GcmQWBx2ZBPJILZsnCOqgbn2yfdpWUXOHBNCoU9uXAHEFT2mMRGG31kw2jI9+h1sErqU
 gCf3XQc0z3KO1FwQ8CmXyjSRZ17j0erMzyIEjfsZuuhUAhn5qR1Bkl+8tiG+VHEbh+iX
 XrNQufi2JqP1ubEU8omvA8SBSGO7X0mh4EyYrPTvfV4KM04a2eLxsMK/gC85al70dH+m
 +vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778951771; x=1779556571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xr7AB72ORRy71rA35bL81bHEuFs70DepQLKA20BG1Qg=;
 b=Y4fLcOvgu6TWH8A0CGICRCABvpTcLeNpau9mlqgE088WH4MLz+jEZg+e8NBo8/qbeS
 r1PifzRUrEWsu/EamKvK47zxGTOlhGoRHgcUrB2jrp8moz9NzaPLUuKizrIYdT0BumWG
 wiOZuvZW6ip9jM3P+Hwp1nQDsnhqkxqO+kdr5CjnWGT/Rijsl8LjjraojJLRg6IISzsM
 gqdWgbnrvRy5vrVMbTwqXFVij2vvq+uMmEdci/ftvn4SiYOi7HocDgmzxW817MpcpPqB
 HWJDBBoQ3DPFahfEMm5mNMQ2yjAU/RELfWOem26lZvH0OZcySNjQ/4jvbYu7TLVmThEq
 dO7w==
X-Gm-Message-State: AOJu0Ywu5o8S9jnxMr8SkzrEIHd4LrXO+AOf0WaK1USEBJTpGi7HlSHE
 23tikD8aamQ81x38aM+wn/s+rSn6/Aq6h8pYeCmsuUX9q/S5UiHVi2yIRL0d2ehsRglG4XWlap3
 //U23V9U=
X-Gm-Gg: Acq92OGn5rdPeREedoX17y4jzj8bb1lrhNWMTXcoxPQzuPoysrRf9la9Y7KGL+qT111
 DNJlyug6trF++LBFAZDEoHPRPypyadGOg5ND5jR0AqpRfabTuADudBpC1ZVlU7iUxXlK/r0b9L8
 gT4CTkzTIpNPGc5I+eME2egTM4oxDOQFAQ5oUfTJ1Ur4zamlZhOU6Kwx2BBW7NiWd1/TIyi+z44
 pJjUrm5a0w6Yq6ti5Do2I+UxHAPI0FcSfI8NTe9Mkp30WYOQVok25TKqE9V3NCRXSNSmhBwOgUj
 n6+YizWQo4/1h9xjxGI5njiJ4+wHiEWtiw7C+kBhPo4Tukhm+ApR5CSOp1bi+Tl7eZ22N8FEBdB
 vHWUt2r8LnDH/kg0cx8dWxXrCV4u5/V0owyWkyqhoweDe3titH63bonytXUIxW4TBTEY/9HTqZt
 u4nkUo4ciJsYbbQ0EwfkEHKZxzhufokbBUT0gt+lQWzK8PSt1IU6/xlx/hflfHIz+PD7vfNCLck
 YOUmIt7CNI=
X-Received: by 2002:a05:600c:5298:b0:48e:635a:18d2 with SMTP id
 5b1f17b1804b1-48fe60e51d1mr122723765e9.2.1778951771167; 
 Sat, 16 May 2026 10:16:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fffb9aac4sm22165725e9.9.2026.05.16.10.16.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 16 May 2026 10:16:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 06/21] hw/arm/aspeed: Build objects once
Date: Sat, 16 May 2026 19:15:08 +0200
Message-ID: <20260516171524.19184-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516171524.19184-1-philmd@linaro.org>
References: <20260516171524.19184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 064f1ce95fe ("hw/arm/aspeed: Split AST2700 EVB
machine into a separate source file for maintainability")
remove the last TARGET_AARCH64 use.

Now than Aspeed machines can be filtered when running a
qemu-system-arm or qemu-system-aarch64 binary, we can
compile the aspeed.c file once, moving it from arm_ss[]
source set to arm_common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 144e4827660..7c3d66f4378 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -43,7 +43,7 @@ arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'x
 arm_common_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
-arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
@@ -66,8 +66,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2600_gb200nvl.c',
   'aspeed_ast2600_rainier.c',
   'aspeed_ast10x0.c',
-  'aspeed_ast10x0_evb.c'))
-arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files(
+  'aspeed_ast10x0_evb.c',
   'aspeed_ast1700.c',
   'aspeed_ast27x0.c',
   'aspeed_ast27x0_evb.c',
-- 
2.53.0



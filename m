Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2841BC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQE-0000mh-Ol; Wed, 07 May 2025 19:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPy-0000J3-4A
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:14 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPw-0002ap-9a
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:13 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22e6a088e16so3424635ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661391; x=1747266191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E27VnLHwdjjgu7+qzkSpdD6sP1u8J5fzfB0GITxze0s=;
 b=cyBtVHvXONWanI6Gr1iqEV+YZ4VkaO59dHy/JGU3QLADt8qH/sc4c2t4wKtZe4361y
 tLqBJtw/znjPBm641O6viw6/MEmjMZzBBVzVGHOP3XkMZahjNB1+lyD0M/Fzutm8PQUz
 JQ1hnxuO8Bshqa6lVRjofJj3wg0o3KqNDN55IkthIbwGUISAVnbeAevO4K5iEA6DqEgw
 MUry6vU7WveV16hiztNiZJqfn/fs3HI6cuj5dsxhTem0Aix1TcAze0gtXfDCJt+8KWFb
 wcDMeA6ilRy+vfFoWwUR0RJELJXetSHXnXhj3/bgeIqS4FdbavsmWYGxf/BLdIvpCIW5
 VZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661391; x=1747266191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E27VnLHwdjjgu7+qzkSpdD6sP1u8J5fzfB0GITxze0s=;
 b=g6xt6N3uTkLapBNRI7vlUOC7KtUBkz+MDOZuFdqjVFwEFbWquD14utgd+3+CDz1y0J
 UxzHl+JnaIC9aGzAXpdcLKqdB8pdISaw7wH6+SazHEe98YWWLp4zMRFOtFWS9O89+wTV
 +MnKineRmJ6mbLQGzutGrafw4b6s59HgDcZQGYEYc3WhU6NslCwQqt28LGwf3JZZihbJ
 /evThsmuCuRBtAQdu4L+9GwSDaV86hpGbSvJNv/5IrLj58EV1xMNPUCTsnOUoUBmK7TX
 kWJarUuVP75UkaygKlRnmmytwhhOZ3G2bMwXrux6AGPkA5myGD+kA6YEPk6C++vbAjo6
 KtkQ==
X-Gm-Message-State: AOJu0YxAgyH3PkpI3zONrf/ARD0tQAXm8kJqbY/NjV46G96Efgesg4aQ
 EZk5QLemeKXp4fhmVQSCFvTMtu2CwyDtIjBOWMYV/kUsroKjCPMJ0b9ecc7QRDGfvXqHfT4F0vj
 vSqglUg==
X-Gm-Gg: ASbGncsAZ+OI+A27pRDSfjbDY8E6dh4ruaZT753B+JwR0FgoOq9y3Bt8yGw3tIl0T/C
 O+W4a1XMgKvk3itV/0udkGwKCAq7RiFnHoP6wBRLpeccXRQVG+RiSpNeSSpwT0RsF+KoSKff6df
 E452nCOhgDnK5pxI8IbgChH3xyEoLAg4wM5lOJyE2G5GGsTGxkxL0HiPIHQSsD9ZasUOKfgs1UO
 5vfqeY6PvhDVpwmkqUaJdYw7upj5utR/RvzGjEeYPWCv6+zQpNhjCzVeTxRpFkXbrdbv+2Pxx5n
 68NyUk7ABQvld+OUH/9q5qK5j3G0sWmlP7Z8QBbr
X-Google-Smtp-Source: AGHT+IGctSV+DtKGe121ux6Zk+dI1dkMdB7jLPCmVMZdvVH6IdFd/gND7HK0CrSpxI3zMYELxI5nOw==
X-Received: by 2002:a17:903:8c4:b0:221:751f:cfbe with SMTP id
 d9443c01a7336-22e84751aa3mr23792315ad.19.1746661390879; 
 Wed, 07 May 2025 16:43:10 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 32/49] target/arm/ptw: compile file once (system)
Date: Wed,  7 May 2025 16:42:23 -0700
Message-ID: <20250507234241.957746-33-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 6e0327b6f5b..151184da71c 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -17,7 +17,6 @@ arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
-  'ptw.c',
 ))
 
 arm_user_ss = ss.source_set()
@@ -40,6 +39,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'ptw.c',
   'vfp_fpscr.c',
 ))
 
-- 
2.47.2



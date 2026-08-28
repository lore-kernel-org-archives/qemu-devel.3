Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BC7C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvT0-0007pk-As; Fri, 28 Aug 2026 08:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSx-0007oi-Lb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:51 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSt-0005YQ-M5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-482dd6ee390so770432f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787919225; x=1788524025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ST1FOuAQ39FjdnP6nZ6r2ASbv9ni6IRiZc0RuWujmK4=;
 b=oFnYoPnl+xgzKOef8DCvPgcmT6ADWDohQVBJ822II2yFpSx9oQQ7Nbhh7+nsb6vxsa
 s5kbjZ/PmvGKFMpzoixn3P9aVaVhke4wun6F1kqreI8ooSeiG/B6AdaV+bHAXNmRaITI
 tq7YbaizQssFuh/gyvOn9iDrjOVNeotPCGMJyIqCSrf8tcOG4KHxr+yWIgWiPBG8iqI1
 ifiXzXgYk0aQAERv1OaZG/bqucYTNV0sTSpX3SQcT9Hl45KsRFMpu6GyYmVqPNdubOBf
 oC8TvXa7T+tou33zqyUmZ1F/0qfGURyfwRkv8SOncj0TVglbhhsxvaodtRxLEgKDThh/
 rO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919225; x=1788524025;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ST1FOuAQ39FjdnP6nZ6r2ASbv9ni6IRiZc0RuWujmK4=;
 b=Id2yo8uXddU8HJ9jl2rUHGCMEGRYCA/LfoqL2MzMbQZzzjYGF6PzMDJLgKSuBkJPk+
 UpIVFz0w5jbxjfNF/pbXROQfhr52dAVDWdOF54YDzhRJVcPyyPoTA9TyJzUTXfBp3tFL
 fndEB1L8bgSRE+cmoiYSfIjk97ZmYAhRfEwi6lVfdUCq3QWRx3poU+ZhP89izJ4p9+aj
 HaMXTU4LoXHzkzRdRZZUlNwS0OjoM+lOEK55+x0WiKXiAEdCBzAb4JuHuQ2wyDZBqJSw
 3oZ8r43IRKCsPF7Ii1SthXk2RZ2qfoG0Z8uztvbBK9F8W3Ln4CU73NiZpojUyI1u/qC3
 E6zw==
X-Gm-Message-State: AFuF++lJ/YRVkd5GEZdulH2ZObN11e7EhRC98WKoBJbWQofa4h3Fqyvs
 lZlL3B4t1QltHu9792yWV7iCuwaLSGJMLUCydi6NyqM6jnZ6bs9JMrlt73pGLeMeBeM=
X-Gm-Gg: AR+sD10FrIq0lFz9NRoxWJU+Aw2orRPYkUcr6BPYT3Kcr0ldWcjlZnMwBXEdz+d2xpC
 ObZJXQK3tpLYKsblHzUGKW9tV5HAK/SqtsgieSJCamU/o5EXtewCmbADlE+jl91cR75d4xAr7p5
 f5MIVUUqSKTVHHP4FPKHT4vze5Y8wPBTdZmc5pn2osIFSL04oYDd3+9BNB7A3Clo2BYP1fIRBLR
 J26bJGYYzJTG8gPh8u9tFnZOt926+XNN6O7k/pqWZzaukiycColmmXLhFS01UhjC6xu9ONXnojh
 dp124m90yKyokw7OoD1yppTDEJzrs9auC22grCfpMP6R3e1aUvSGPO8YLPu5W4jzh0z4ScY49Zx
 LvKNk5XAdjT6CXdGkmGfq4chjPR982lyn3aD3OU8XdMxe/9WgXsrAhnGXKGS1K6kJT+9/r89+fh
 YwbUaqQm9KufRtUYFvg51QLbxNyXfL6bYuXsO3KUtdAEoEKKVfCd6V58/gSTGa
X-Received: by 2002:a05:6000:2f8a:b0:47f:9266:9bde with SMTP id
 ffacd0b85a97d-482f7975d34mr8516438f8f.4.1787919224576; 
 Fri, 28 Aug 2026 05:13:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab730fsm3650763f8f.8.2026.08.28.05.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:13:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 674155FD5D;
 Fri, 28 Aug 2026 13:13:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 6/6] mailmap: map the last From-munged author back to a real
 identity
Date: Fri, 28 Aug 2026 13:13:37 +0100
Message-ID: <20260828121337.2277303-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828121337.2277303-1-alex.bennee@linaro.org>
References: <20260828121337.2277303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

From: "Denis V. Lunev" <den@openvz.org>

qemu-block@nongnu.org rewrote the From: header of commit b67e353863
("block: drop force_dup parameter of raw_reconfigure_getfd()") for
DMARC reasons, so it landed in git attributed to the list instead of
to its author, whose real address is in the Signed-off-by trailer.
Map it like the other munged identities collected in that section.
This was the last one left unmapped, so 'git log --format="%aN"' no
longer reports any author 'via' a list.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260812112456.970371-1-den@openvz.org>
Message-ID: <20260824-fixes-for-11-2-v2-8-352c6b890402@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.mailmap b/.mailmap
index e5dc644623f..08f0fa9e118 100644
--- a/.mailmap
+++ b/.mailmap
@@ -68,6 +68,7 @@ Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-devel@nongnu.org>
 Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-trivial@nongnu.org>
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <qemu-block@nongnu.org>
 BALATON Zoltan <balaton@eik.bme.hu> BALATON Zoltan via <qemu-ppc@nongnu.org>
+Denis V. Lunev <den@openvz.org> Denis V. Lunev via <qemu-block@nongnu.org>
 
 # Next, replace old addresses by a more recent one.
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> <akihiko.odaki@daynix.com>
-- 
2.47.3



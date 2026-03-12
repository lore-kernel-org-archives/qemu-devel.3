Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E243D106ACF2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0omQ-0007DE-1f; Thu, 12 Mar 2026 18:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omE-00073V-Lc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0omD-0003J1-4K
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:10 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2aea41d4fbcso7274235ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355508; x=1773960308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwRfh/sohnPunxfSN46Zr+FfMuNI+X4cXpBJVFqhXI4=;
 b=N3pMI7wt6ZtcdijHUJg1/FmRHnIHSep6SewcHSOqn2yygjFuF+Xpjw4c3UbOANerVv
 c7RL5pMJIvTb3d3OTn9q1HhRTnH5k6X7WRnjn11sXNQhHJkL22exuHNxBzSWdU+DWxIJ
 wKJDMHdHdpmO4adBGHNrZJcQqLC3M6NLM2wf6GM22BQIOkTrgFF3bFzlOF981ZArWkzS
 epJ4QxuReHXZ0uzug8URttvhyp/dlMV0gavQhaMSicHGXAnKn1+afOy+1k3zncN9LqEf
 IhWrBwzwIBJUJ/LZuJ+X1cxN/H/GRmqPVOqFKUA0NcIHxTYIL0If2zljkRuGyECMkSEu
 sD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355508; x=1773960308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iwRfh/sohnPunxfSN46Zr+FfMuNI+X4cXpBJVFqhXI4=;
 b=YsXUcAn+tIj8FcIMvtQkz+MnjKBEwIlEjV7NBjvFT9yJxDFTsWTdkixPxXyqthUOxg
 pkAoBZ0s7Hx45VlcBzphaiOeE2tGqk99mc+uxlndafcCsmT0iW6gSHop3L4XYPOQm5aI
 rjQ1geolrntypCL1vA0mWiIu6Lqm4VGJXyZMWsrzujQwH6Po6GZ+vuMXJVba6Ddba41C
 P6wtVeZGExT0ljlqS+Az7azEIvT4deULBC7TJJiM/XAcb/SuDUJf2ogxHMycgVoG4ECO
 2jNhHRHtMEDn684oLKyEAWn709Vt2LgSQ+eZddtJ5wbp3C7SgyGHHSYknZJc5d1W/hTK
 ynJQ==
X-Gm-Message-State: AOJu0Yy3wv8aBDY6nctPwmHobNOiOlvfOSaLFqFDJmlNALvWOfpNlUS5
 3dX9arRzUvCmv9zwCqhGJgHiV7u0XsA5/nS8Sw62WtsZCRPgdAKSqZxVVBxjGTfjWuEdx4vP+hQ
 gMhneDRo=
X-Gm-Gg: ATEYQzwWwPPWDEx2jZ2qavGSmADqQHRSWI2XgIdb9xtttO67FyXhGMp35MkzLZoqY5S
 Wz2uKUys2qj2obvH3yvKUruVMFT8K8mqs8jZrrceNPW60RjpCa3FB+SeovSXhr8JLoLi4ni5CNe
 EPgmE17Vi0xjCWb4XTNy7Fti9VqDvSvxUHZcqLqXQftKv01nkmpop3mdHiZKPetrwQGkgqlN820
 F9RGbMZ55uKK3C/juS1FpCAur2iKUz93jr15Lo5koZXCvDYxJ1/mm4Rc3LzdT4jC/aRRC8zkos2
 +NDvoMvAoAQOUTILZt0/pxr9201u4PrE0dPVBsl73XNDcnJQPktWUt4SrS4mhVO6ICGfYsayupN
 0wrqbb8AVhvgCtDZZOl1OzLV0R7KtZnOAFUwvwz3GatKfwDZeZGQV1b2xYTSP0SMeL0c24vm0Mi
 1eNWBkUTebadUrry64GOrfCV5XjJ6i2YpBsvmOl6Y0TXNPCgfyt/SfCAYaITzh6TxI5aL0BjQxS
 WvK
X-Received: by 2002:a17:902:f544:b0:2ae:bd12:f832 with SMTP id
 d9443c01a7336-2aecab1c781mr8399395ad.46.1773355507529; 
 Thu, 12 Mar 2026 15:45:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ed9cdsm128215ad.60.2026.03.12.15.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:45:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 8/8] hw/vfio: all vfio files can now be common files
Date: Thu, 12 Mar 2026 15:44:49 -0700
Message-ID: <20260312224449.1605071-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 06e24122c5c..4553aed6a6f 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -20,7 +20,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'),
                                      if_false: files('igd-stubs.c'))
 
-specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
+system_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'cpr.c',
-- 
2.47.3



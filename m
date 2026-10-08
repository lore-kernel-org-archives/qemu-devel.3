Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B0CCA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEt3j-0005Iw-AR; Thu, 08 Oct 2026 14:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEt3g-0005IP-SU
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:41:36 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEt3f-0004kY-Eh
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 14:41:36 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-16079d54c17so2772766c88.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791484894; x=1792089694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dy/SBey8Ie5e9tFCrYEZkW32VFY0EP87nzoMZVgaQys=;
 b=lZUAOJ96MzPaPMcjl3IjRHeQgTND3HDV7qscHeUxLSvZBxIVg/8aMxY8qydvfoSS77
 feTK1OMW8AFLtpT4ELTo44iIBhqF606wuiXk0SWCmwBIXjMOgMuiCVszvWfJQLsBBr74
 /p96iuMMYV9HsVbLlpuxX+orWap3eVziF6nrvP+A9o4M0nOwYY9BSwVchR1fln2RTe3o
 GVqklDL1TWfTkkS90Mv3XiJsnXdpLCa9VDBQadHlkzUDoC24LeSr91tzbG9UR65giiOJ
 3ori6RgzSBaqY3gDOndvOLYTTqtYVqPJic2Z3RBwKzXZhUtbDMpWWJfN+VEL8lv/Oy+j
 n4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791484894; x=1792089694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dy/SBey8Ie5e9tFCrYEZkW32VFY0EP87nzoMZVgaQys=;
 b=VfeoP1+QmGUl5QdX0tGVBZwY+ydePnkNW8ueR2i4rhExHJNTSxvPAg1rtcBMP2KibI
 MWu+2BttMRFtC8N6GQfiDJsDbKgxTllYz83o1wlLgm63d72Hbm/cu9o0lBmKkx/3gJAS
 8OZSIUJRD1ccdA83n/xKI+JeZBgWp0URqlPPfbR9OOFuXy9BPrxqtgbpSAk39FVrQ60+
 Mhi00lNVD2dALKips88vd3XXMJqhLDHCah7x2qf3cRuVSy1MUCuJkIEdlrMsqpWQjWnp
 vUUbij7m8pMPvWD6s4IAsYp014BMKnG21lT1DXyfYxlzyiqWkqzN9QmGk9QvG1WSiikG
 7Img==
X-Gm-Message-State: AFuF++n0bVXVCup9UWBmfPTBZMErdQVAu9fRcgS91tTaW4KsV/FM3j5m
 8H7WRdobT9fCLCb8HaPEOWuM7MTr2oafb9SLsb0voSlV7cwaPKzhAi/x+K8u70eB
X-Gm-Gg: AYBFou313dT0idxdYiBPdr6bVED+kRGubWTgGkm8BEyo5c0XN3bZrSjCKi01hcYgy/b
 Snk6rEn+CuQq7uJdo5PUh4S9GO5yFrnKaD55nfHD0Y/xDPZ8EJ8d1r/4FnEkCiDDfSFAK9dxR+H
 Uln73ZvtWqmkIsnbxyZQqAR8guDgmX1xNACmMgDJ4UGxcC76XrJnCDv/bRonPNWSBhcJtLPh1HN
 kSjjB30TnOCkd/7sBhEccuQdwjYGy6erO2zZOm7smtL04C5raXWQ2OzmNI4YyDwsuVLwXBWnRhS
 6JmAaLpIE3T90lQqIVlvFjEZIm+wot6CIcFKt/ys4S4JLomS+y5Krb2sEVvy3PDWz9JBWpWFWrw
 pI/xP1cWI0mXVChkY/lce7dpizUPjPpfQkpywX4aK23P+9aH7al6eQd/FzZZGbeYPFeHIKwKHxK
 Tm5wllxvgcCKjxVguRr+UOT/oiORphpKGlpBauOxh2Ma/ZMC8UxhJOmwexrdqMEeNhfuDmq71HC
 bf78FUi64HyjNDMtwPICsa9vF90
X-Received: by 2002:a05:7022:b058:20b0:166:af48:a2ba with SMTP id
 a92af1059eb24-166af48a334mr3058016c88.0.1791484893951; 
 Thu, 08 Oct 2026 11:41:33 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a442ac67sm259515c88.18.2026.10.08.11.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 11:41:33 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 2/2] gitlab-ci: enable slirp in the Windows cross-build
Date: Fri,  9 Oct 2026 02:41:19 +0800
Message-ID: <20261008184119.142-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261008184119.142-1-luoyonggang@gmail.com>
References: <20261008184119.142-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Require libslirp so check-build compiles the PXE test and catches
MinGW portability failures instead of omitting the test.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index a823aaaa218..d5dc4946e92 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -95,7 +95,7 @@ cross-win64-system:
     - job: win64-fedora-cross-container
   variables:
     IMAGE: fedora-win64-cross
-    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins
+    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins --enable-slirp
     CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu
                         m68k-softmmu microblaze-softmmu
                         or1k-softmmu rx-softmmu sh4eb-softmmu sparc64-softmmu
-- 
2.55.0.windows.3



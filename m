Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CDFCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvMM-0002u5-Qo; Wed, 14 Oct 2026 05:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvMD-0002nP-Mh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:33:09 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvMB-0000QB-Kw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:33:09 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-154e9d2d979so564263c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970386; x=1792575186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N92nFfVD3yppLw3bzN6p2rDF7VCVhKpNKJeukwohcLA=;
 b=SNbLQoYUuVmvBbs/MS7q+CZHGDi7xP4hSRpAlb1kmFbeEkUVoPeaKb4y1imHsniZlJ
 ZsslYGjnanerFu2cisHfZ6mL0nvmZkmyWyvkjxv1evD3q2uW+tGbgorH/2K14l0+aZ7Z
 8lv38Zlf18et2jB1Gb4QBTDeDVfXDtnCBnfEvvylZd+9sRmKw0rNOX9uBph809TZ41T0
 dy3FoPmCBI9zyBHHpzIPX41CBQNE+0Cni4b4v6rgY0jDnJTckFo4AbqgJiKtMRM+EBDm
 AdM1wQn5EPa+qpEfxT1PFSCSCax3sBTYsczC5ju+sxzPxNnBr1inwN482aKN0zHUNfAY
 4ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970386; x=1792575186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N92nFfVD3yppLw3bzN6p2rDF7VCVhKpNKJeukwohcLA=;
 b=oWpUU1iWH10gxEIyipiJV2AFkdKsnH++I7bkUKsgQiLyD7/mmwM2TfiATbUBgjlkJS
 icQv43aacZQXqUlq/VRTDI4bQRbAa2oQHJG7hpl4dQJ7TPcgb/ewlh+AhYqfJQtYlx4t
 9YwkHwsIXowK1vW5TuM7V1IZjlAH2lE3XRUXo2QcLwCqyMDH9FLDpM7iLn0p4H6ZJu2m
 uHvoWvF7fPayWr1PRIshl8ehGMk6pHSfXLOyUx07xqHd1zyQNA+SwIhliIZ0xINAuaBd
 ZKH98z9PiRVTQr3OBmrgx8z25GpskVF6qanCEqFQtg6Q5iPBGWuNh4g1keJfxFKpHL5T
 bF2w==
X-Gm-Message-State: AFq9FYLIaRjDySOEzR5RiM3imq1A7OXNtgyUUeUTyGTZI44Uzs3p0xiX
 eQ0qEoQ3um23MR6SJl+pHhgsFL59wzauZy92Exm8reET7ngKYE+XJn5xdt4VjAClGuw=
X-Gm-Gg: AYBFou0KBM5Puu2Jlo6bmkVckIhe65jZeHWNLUseS2D8x8g44VXsvLdMD0Qv53diG/5
 sXfABhO2ppzK8Fq6cVBwlWkJD+VlubBlpUHoKI+3rZgftv44YJgSlI185RgL0hMvRK/nHdWA+lv
 YFultZEVaOzQ20ttikM1xSdCNlVrIUqH9G/2/wlid3P36Pcn+c08AJeX6biBnv5LmXH21aNjWvh
 9JERMSQUm0I/w94aAHRecMZZwUeRpapooge9oByd71EWLBd4TneQ1AoZioQIGljbftmqHmlXZ/y
 FsDnubMVnoX0uzIjZAsj+5CwwRnWLvoTA9W+ESNiIQSRcdLC5Kr3nwAKKTDxZNMAqfZ5GK+8s1t
 NUr2zsbE9UmXxjXWVMER/p5B2xk3Lt86K4kudPJH6P98A7jHThLsk55NxnfhKLPo85wcSBypptt
 OdbP5eaXDmse1nrWeONZSjY5g0jhz+X8jwCaBm1zm4L9dpNVMOuIKNZNwmMQm87JaWLZrZBjR/0
 jQlwHGPlU0v4UG8Fw==
X-Received: by 2002:a05:7022:f51b:b0:15e:12b6:7365 with SMTP id
 a92af1059eb24-16a54fab7bemr18580852c88.2.1791970386113; 
 Wed, 14 Oct 2026 02:33:06 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:33:05 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 06/34] meson: define TARGET_ARCH_VARIANT to target_name only
Date: Wed, 14 Oct 2026 17:31:16 +0800
Message-ID: <20261014093152.834-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
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

So target_arch() only related to target_name.to_upper(), simplify
it's meaning

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 255c887e8e6..3460d031a95 100644
--- a/meson.build
+++ b/meson.build
@@ -3290,11 +3290,7 @@ fdt_required = []
 foreach target : target_dirs
   target_name = target.split('-')[0]
   config_target = { 'TARGET_NAME': target_name }
-  if target.endswith('linux-user')
-    config_target += { 'TARGET_ARCH_VARIANT': 'TARGET_ARCH' }
-  else
-    config_target += { 'TARGET_ARCH_VARIANT': target_name.to_upper() }
-  endif
+  config_target += { 'TARGET_ARCH_VARIANT': target_name.to_upper() }
 
   if target.endswith('linux-user')
     if host_os != 'linux'
-- 
2.55.0.windows.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80FBCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvLg-0002HE-Bw; Wed, 14 Oct 2026 05:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvLc-0002GL-Jw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:32:33 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvLZ-0000Kz-Ul
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:32:32 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-16079d54c17so4956283c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970347; x=1792575147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ujyr7Jx7RdrtwSaEiPldTVT9GggNzUt/ZtswxjPgnhE=;
 b=RRajW/42VlApdrxrDCRkHamvfRHd50yhHuu73+ZMj2rqYMwoUsAOoXeuxi4/4FDNLs
 n1rXgohJwDuevzEKzq9ANEg58WhqTHIG36WeoGiC+083LEPEs/NZdL3iz7kO4atZwx+u
 98Zfd+37PxwHjd1/3abhU2FUdUMysMsroTp0/3K+/D1GJqUKTiYWoV8F3OQCjhyipb/W
 JY4OxvintrIOHqFfMDdZqOpJoE0tRptGyTF9fig9GLuBJNch0NrcJkX7bSnu/ok1brFJ
 dNIT9zpcddBsbnuCIL+fwbcBxOI25f52ck4mJVgCnghUgX2/3rjIpiHuTOeQ2oVXYhrE
 HNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970347; x=1792575147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ujyr7Jx7RdrtwSaEiPldTVT9GggNzUt/ZtswxjPgnhE=;
 b=oHRTZZFeHKlMCGOr3nkxTBF+ySBECG7QDwicgtZCgFDRj+Jc5XMESfPb5nvs1pSz+i
 c6uilixvyID6sD/MU9Q5ymkYfwtibi61EtmO8c17QlHlNLuMShg2IO4/WkLGegzRBJkr
 q/uVe0NIm7MKJLw1qvVatOFGaO/seOvLqFnDIYmB1Cr46ZhuBsvVTVC/tL6vc6U4hZaY
 PiydLcUgehP5E0XZHStFwilir7I0eofb3GEFwdC0EcHZO1s2qcSqTZnu3dWlhoiwFoxr
 LJ5zyd2lzuzbD3+rhLNlIIm9Px6oOwV1YNSX8WhzciFkxFS59mNDry2+PcJicm46tQD0
 kQ0w==
X-Gm-Message-State: AFq9FYJa0Bh8nhIPngubUy/Z766V8+k+DwzPxK+VDGryVT/vQpFftXpp
 bOMRg98ihmF8aK2FhyL26/WfXR4pZpEWQxseJzao2fRPh5a91Hq6pS+GoN8teOwkPjY=
X-Gm-Gg: AYBFou18bIhjievZzBcJeigyfiqYjWxxlBs3Xopbipr3Kz3yjzOHG9hodiqVvMlPRpL
 dhxplVU55KBwmYqatN4NeZOW7F9yifRZvle71+B0otoGNwYcnsDoDi8FSbchngkPRa0h2j6eEt3
 al8LlryWEaIRw3ZUYHjxsMworEU1dQnwD2Jy35fKK0yhFAtLZkRurMGXJFcoFJ1dc2358N19Vrm
 SeRiR3yRF+79Asz8821gG9MVURxd+LoP3Iw/5CQaE4Nv/2CCGjzIzBN+GLDcmPDjcj29ll72KFg
 +ROMabQ9OQpMXzPzlVp8D1iSLdaTRysuYbgtW+GYHFhtPh2bUiK8JNIC2sMwHOcqTC9UaRmEBE4
 yQ7hzMMqsYVHSrui1VSx637sAqet5d072rxUN8qgVMPKIlywaSUp5+B3OhR64gW/Ii3Jv6PudFp
 1oWiwo8CH8K53/RtrIIfPvyXerHIqKyX/qbu7XdaVic7h1VTe9eaSpngt4c3yR/4WtmVV+noR+/
 Nhnrof7lnFpmvQYoQ==
X-Received: by 2002:a05:701b:451c:20b0:14a:5d07:9b with SMTP id
 a92af1059eb24-16a5ea5d851mr19602319c88.28.1791970347413; 
 Wed, 14 Oct 2026 02:32:27 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:32:26 -0700 (PDT)
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
Subject: [PATCH 02/34] qemu: Use SYS_EMU_TARGET__MAX to define QEMU_ARCH_ALL
Date: Wed, 14 Oct 2026 17:31:12 +0800
Message-ID: <20261014093152.834-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This is more precise, so we can iterate all target_arch with QEMU_ARCH_ALL

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/base-arch-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/base-arch-defs.h b/include/qemu/base-arch-defs.h
index 806ad8094a4..a6478c2d3ff 100644
--- a/include/qemu/base-arch-defs.h
+++ b/include/qemu/base-arch-defs.h
@@ -41,7 +41,7 @@ enum {
     QEMU_ARCH_AVR =         QEMU_ARCH_BIT(SYS_EMU_TARGET_AVR),
     QEMU_ARCH_HEXAGON =     QEMU_ARCH_BIT(SYS_EMU_TARGET_HEXAGON),
     QEMU_ARCH_LOONGARCH =   QEMU_ARCH_BIT(SYS_EMU_TARGET_LOONGARCH64),
-    QEMU_ARCH_ALL =         UINT32_MAX,
+    QEMU_ARCH_ALL =         QEMU_ARCH_BIT(SYS_EMU_TARGET__MAX) - 1,
 };
 
 QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);
-- 
2.55.0.windows.3



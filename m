Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082C0CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrK6-0001L2-OU; Mon, 08 Apr 2024 11:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrK5-0001Kr-CV
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrK3-0001ql-QF
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OUsSvx4rS/JvSGux26uwYxv9XLnSYU17H3EwXSZxQ0w=;
 b=gy79+6suawwLTSIT4PQOIfAWmYYVXRKE2BY6auKr2Qy9NthbePJLuXXyfpzyjHNs0R3dgP
 h+zAG0ur7vG3uaRV6bTanpeD0UAq0HkRA/p5/zkt+qDn5SbtflhRrLuY9wnu+31rgnBfYK
 816Q8rr2RFA0R+MObHuaJLSFss8ame4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321--BzWSn6IOeuQMHI4E7u0SQ-1; Mon, 08 Apr 2024 11:54:14 -0400
X-MC-Unique: -BzWSn6IOeuQMHI4E7u0SQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d883dab079so15545861fa.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591651; x=1713196451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUsSvx4rS/JvSGux26uwYxv9XLnSYU17H3EwXSZxQ0w=;
 b=ciEYuGUzLqfap69a1We4NrAvlRQYADOAj69xjZ0TLsHcbXCsidx98ii5b+tJGa3yrq
 /Mqsqa1KuubVTpmiZoFVBaTDK36DEAFk3s1J+NT9UdkgqoAugEsnTfp5EGBhitQS65Mg
 z3O0MS+/zT0Ki+mfckzp3q8r6tcyTh41ss6X+kcAnMXHtO/iVbWuxF81FINJuONwJ3JW
 hjn9ooPgCVPsjk1z16jsrci1LY/VJQqTIdIcXtRhlkganjLUCUVsC1VzO1qSgo+knMU/
 GiCQmyKag1Kc03YC1No/9aUsaH4ceuGLbW+n7Xv3/j/+WLJnIUPRCioMFSfR1tpQyQx9
 0PBA==
X-Gm-Message-State: AOJu0YyLnXYveA+LBhZiVZkCt+Q3RaDI+xePvQlLvIx6Nldfa0q9mqXV
 isY3mSY5433NFbbZxVwW8ujRC4jK8v0YSogxI12SMI11LYkuFB7mgsL6u+ccTwW9KT8VBle2Fji
 s3kL7twKgcXgUhWF9NWkuHXavv7xe9Kzm8JMQNgiB2FscEl2WovKTWdAHt3TZg/ZfGWxz/BOpdl
 lJNM0vO0Xl5PCaamRK6UQl24nGqkqvtIq3JYEz
X-Received: by 2002:a2e:95d4:0:b0:2d6:e0a9:9981 with SMTP id
 y20-20020a2e95d4000000b002d6e0a99981mr6868185ljh.9.1712591651334; 
 Mon, 08 Apr 2024 08:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAlgKqvGt9x55z6ZFndNEXaNbZHVKmVcSb0sgjkM6ZyItdDQGtCMUMtuYoEPo3E8eNRfHvqw==
X-Received: by 2002:a2e:95d4:0:b0:2d6:e0a9:9981 with SMTP id
 y20-20020a2e95d4000000b002d6e0a99981mr6868172ljh.9.1712591650995; 
 Mon, 08 Apr 2024 08:54:10 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a05600c1c1600b004165315d885sm6677512wms.11.2024.04.08.08.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:54:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 13/18] ramfb: move stubs out of stubs/
Date: Mon,  8 Apr 2024 17:53:25 +0200
Message-ID: <20240408155330.522792-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since the ramfb stubs are needed exactly when the Kconfig symbols are not
needed, move them to hw/display/ and compile them when ramfb.c is absent.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/ramfb.c => hw/display/ramfb-stubs.c | 0
 hw/display/meson.build                    | 2 +-
 stubs/meson.build                         | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename stubs/ramfb.c => hw/display/ramfb-stubs.c (100%)

diff --git a/stubs/ramfb.c b/hw/display/ramfb-stubs.c
similarity index 100%
rename from stubs/ramfb.c
rename to hw/display/ramfb-stubs.c
diff --git a/hw/display/meson.build b/hw/display/meson.build
index f93a69f70f4..4751aab3ba9 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -3,7 +3,7 @@ hw_display_modules = {}
 system_ss.add(when: 'CONFIG_DDC', if_true: files('i2c-ddc.c'))
 system_ss.add(when: 'CONFIG_EDID', if_true: files('edid-generate.c', 'edid-region.c'))
 
-system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb.c'))
+system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb.c'), if_false: files('ramfb-stubs.c'))
 system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb-standalone.c'))
 
 system_ss.add(when: 'CONFIG_VGA_CIRRUS', if_true: files('cirrus_vga.c'))
diff --git a/stubs/meson.build b/stubs/meson.build
index 84ecaa4daa1..92887660e41 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -36,7 +36,6 @@ stub_ss.add(files('qmp-command-available.c'))
 stub_ss.add(files('qmp-quit.c'))
 stub_ss.add(files('qtest.c'))
 stub_ss.add(files('ram-block.c'))
-stub_ss.add(files('ramfb.c'))
 stub_ss.add(files('replay.c'))
 stub_ss.add(files('runstate-check.c'))
 stub_ss.add(files('sysbus.c'))
-- 
2.44.0



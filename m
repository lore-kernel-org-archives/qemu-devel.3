Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F62C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 07:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKKA-0002p2-OI; Fri, 09 Aug 2024 03:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKK9-0002lp-Uq
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:09 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKK8-0002wB-HN
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:09 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-264545214efso997699fac.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723189447; x=1723794247;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyU/F2e8eEPOOSdfSzXeHUo4Ool3slJ1380DRhWnPrw=;
 b=10RLiEC1XUz+KOvsWvNx+O2j2b+C3LvdSKVFACsDyBJnufuKb+5q/XkjzSE2dUV8Mf
 KPku25oxtR/vfvI0z0inDlA2TjCdgJXS+eQG8uD8tDJkIBgSIbDK/Z3Cr0xlmbUW+IGH
 VKwL72W6k5//pc3MAlSUB02T93WomMG1+AUfT7Tjb/gYqvVDoqtssJ2XKaHhZcRyk0JK
 yFlmSAdbwYu14t7KKY9X6c3rmjmxWazcgkV9djAgNYyJd8csypeI/Q0ed3LCvD8LEPoa
 JyM42LZ/f0sTRXVue4rqZFdIWYN3qEl1cCUWvr9m5FnHNNov9y1jCK/juZl8dkorDsqu
 ivhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723189447; x=1723794247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyU/F2e8eEPOOSdfSzXeHUo4Ool3slJ1380DRhWnPrw=;
 b=csI1JBlVMci0TLfoiDXeHk1MDcv/RXeuHM2r4CY7MZONywHBFU+fl9a6OqheS0plTS
 YVBsxKZMPj6vJMQDIzKYtCCN5GDoosdRxC5nH0ILgPkrflHCUztSBfpk1X44Eqde7LxQ
 i8zqWsvimgUBrJQ+vMxpJ4Q6kHYO5iFGSfCp/hH+Y4KBLKLYRqXpScefX6ywl5OGrkGR
 PgFIrJ9u+8pd2LYFRKnBqYjXIOuuipZMRQPEPyTT77n6mE38y8BePpZCQvw+b3JCa/GH
 CxMTE0IWtycQdG9MHX2MiFXYRHuwAxUSc14umCRxmlGR+J9hdIm1oFKStGQRLxXi3Rbb
 1s/w==
X-Gm-Message-State: AOJu0YwsGJi8l13HRi8iJoNpS0rU4qdyzU5AjndvfC0TkLZjqfV3UTV6
 dl1S2c6Y3m+W4BFwewCtqFrf51cLA1bC9uhRxnvg/OF6zvPUxvUj9JF/3ILXY66hj6k/801wT41
 TDP2lFg==
X-Google-Smtp-Source: AGHT+IHynN9S4Pu2K0OsJGGhlniAhkGW4LEVP08OhipoF3W384q60mqxfNZCF7/5qJ6W2g69s9gyAQ==
X-Received: by 2002:a05:6871:710:b0:261:16da:deca with SMTP id
 586e51a60fabf-26c62cbe1b9mr962912fac.27.1723189446426; 
 Fri, 09 Aug 2024 00:44:06 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb22a455sm2123212b3a.71.2024.08.09.00.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 00:44:06 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v1 2/5] tests/migration: Make initrd-stress.img built by
 default
Date: Fri,  9 Aug 2024 15:43:33 +0800
Message-Id: <7134ee3f7632b0454ef287301bda6c4faeb1d473.1723189080.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1723189080.git.yong.huang@smartx.com>
References: <cover.1723189080.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::32;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

The initrd-stress.img was compiled by specifying the
target, to make it easier for developers to play the
guestperf tool, make it built by default.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/migration/meson.build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/migration/meson.build b/tests/migration/meson.build
index a91aa61c65..393e401800 100644
--- a/tests/migration/meson.build
+++ b/tests/migration/meson.build
@@ -7,12 +7,13 @@ stress = executable(
   files('stress.c'),
   dependencies: [glib_static, sysprof],
   link_args: ['-static'],
-  build_by_default: false,
+  build_by_default: true,
 )
 
 custom_target(
   'initrd-stress.img',
   output: 'initrd-stress.img',
   input: stress,
-  command: [find_program('initrd-stress.sh'), '@OUTPUT@', '@INPUT@']
+  command: [find_program('initrd-stress.sh'), '@OUTPUT@', '@INPUT@'],
+  build_by_default: true,
 )
-- 
2.11.0



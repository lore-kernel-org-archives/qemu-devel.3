Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BD7CD129C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrJn-0001EE-3a; Mon, 08 Apr 2024 11:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJk-0001Do-GX
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJi-0001oT-L7
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhGSxJKt87Lk51t1FMaldViRBBvgZjPXp/8O2/Jk8T4=;
 b=aKwYVOQq/dBNW1kqw4aaytIhLs6jLMd401jKmQayeCW3vu/JU8S2Mmpjk7Pqoat2Y86Dod
 QxNOcciOHv20fs14PfBQ+oxUbKjA53s/h797kQ5GA06pKv3xAeMzFUHV3UQuuiSyrR86m3
 r3CxiIBe0j5qsvKa7rLrBdKNJv66zM4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-IVXSdqe2Phu1NUQbnUR_Bw-1; Mon, 08 Apr 2024 11:53:51 -0400
X-MC-Unique: IVXSdqe2Phu1NUQbnUR_Bw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-416664de900so9016965e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591628; x=1713196428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhGSxJKt87Lk51t1FMaldViRBBvgZjPXp/8O2/Jk8T4=;
 b=F88DbZTdvWkiCUg5o8DITZE2mTCznf8kOzQNjHC6A4RkV6hTiPEEJHC6AjXKc2caH6
 5fHFgc3WC3Ix8Zq94epDc5jVP6JfnFr5YsGhW8l13KxnypZadDFPwHpSPpbi2aTUc8Bh
 T+In518vsBWfoGo6zgMyQewvCkAd7yzMz5wLVESGwZafwqEv4+g3ULQW7WBe6ZaVSSeB
 rKf+Xa3DROCsG3ZOXkDrF82q57Hrgq+rL4NJbIyImnyilJBFrVoeQyjc/Mr1sZhHS9+r
 OCCvAb7attmp+yCl3hPtXjjvnls8ExH4qUGyuU7RtL2hUAEZrnCICAnPn0i3jPEk+dNd
 8c4A==
X-Gm-Message-State: AOJu0YyNXQW6AAWs8n1C/WZV2ZSCGf1SG8Mkl/uzgkJoc6pPhxPbTEQ5
 MSEESS4ya6k4RlSricOG4GLmE7VIGhWw7N+Lk/6Esj0Nk39nPUfR+hAsY9cC5/63s3I8NsvH2Hz
 Tu0AZQM4boyYm6If3p+QDDQOU0lcUnMBzIHYt/SOMJrlOSUsmpRYE7uaK1cUtI10tvtkgxaDfQr
 V8Fov7+PO+8EPqp5EnltevwK3zf9vqH+jgFsaI
X-Received: by 2002:a05:600c:470b:b0:416:6be9:c477 with SMTP id
 v11-20020a05600c470b00b004166be9c477mr3030468wmo.10.1712591628728; 
 Mon, 08 Apr 2024 08:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEINZWfJhDokKx3xnRZM1ABWHSaUQpx8PvCCfJtW9YkdTuNYt5at91c8DW6LB0zUmrbG7S3og==
X-Received: by 2002:a05:600c:470b:b0:416:6be9:c477 with SMTP id
 v11-20020a05600c470b00b004166be9c477mr3030456wmo.10.1712591628484; 
 Mon, 08 Apr 2024 08:53:48 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 5-20020a05600c024500b004161b59e230sm13600253wmj.41.2024.04.08.08.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:53:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 05/18] yank: only build if needed
Date: Mon,  8 Apr 2024 17:53:17 +0200
Message-ID: <20240408155330.522792-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The yank feature is not used in user emulation.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/meson.build b/util/meson.build
index 0ef9886be04..2ad57b10ba2 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -60,7 +60,6 @@ util_ss.add(files('stats64.c'))
 util_ss.add(files('systemd.c'))
 util_ss.add(files('transactions.c'))
 util_ss.add(files('guest-random.c'))
-util_ss.add(files('yank.c'))
 util_ss.add(files('int128.c'))
 util_ss.add(files('memalign.c'))
 util_ss.add(files('interval-tree.c'))
@@ -117,6 +116,7 @@ if have_block
     util_ss.add(files('vfio-helpers.c'))
     util_ss.add(files('chardev_open.c'))
   endif
+  util_ss.add(files('yank.c'))
 endif
 
 if cpu == 'aarch64'
-- 
2.44.0



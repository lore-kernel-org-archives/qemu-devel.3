Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3821EC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsb-0000VF-MU; Tue, 20 Feb 2024 03:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsa-0000Ra-8L
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:32 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsX-0008FL-7z
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:31 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3eafbcb1c5so178888466b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419208; x=1709024008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2ZZZfT2mvh9TPWu1HLXXLptGZNuBkeMEgEXTk5vuuQ=;
 b=fBykam33pGzxcYHGA9CQh2lwzHmohd/zv66axXoM7ENs4qgYV9Vm0bkIV3MKJuuqZC
 tv633u9h0AMVtMZQMb6FdQ1/SyVENQFN7h7cv7Rkau9/ZYYA7Q+ac8X6FaLFWeGxlYtN
 sgRHL+Om23dl7aIi+xhdEfeqgOZD8pZ/Us7PTOD6jNYfqAE7o3J7MHIlytRvRCtTazqb
 IpFcHjiQs43x+j1BerhYNLsdg3sD2TDtzVRhWxEIvDI2slwyUi8j9IofQCxfRa/bHgt2
 zRSMYyVzVD7rjCoNbb+kNUisuhcNXLYthSIo5p7idWt+cLD7k3EUhnQ0b8ZHes/Ik/bA
 i+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419208; x=1709024008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2ZZZfT2mvh9TPWu1HLXXLptGZNuBkeMEgEXTk5vuuQ=;
 b=SFAhjSC6FBS6ELVSi+jLjH0LcXI0hbmreFVALBXhkCWQEgfyT9xSVIcwcSiFKirKis
 Ab3FiwKMTjtBJWXUICz6L2kn7Wqqol+K5gVgGDXKBF1A2GIpG8/tH61qT19pPCnU8H0G
 udabd80+bbAP4cpzBej79w6c+H/oUd3f0LZ40qVdRsmUxxbl7JT1bwxEhDE2qJcL4ZEV
 3qQPFTLR5cFTc7ZnspPOKXl4USRQr2oI9btcQHSAFv+ufVfargAB41ZrokUy3FpzqvDy
 4f3GqnIVMHX/AfPcOv+o6lDtjVVS6zxdKxa57TNwj/DvgysUmmYwFIYdMrOkaoMCp0WY
 D52g==
X-Gm-Message-State: AOJu0YxgHWF754s7i2IVmYK32g/kKO+HusC2yINen7Ro+pdyx4hwd0TO
 66CRgQ6e6WwwExoJ5zID9VifmUY9glteKNaS77RhyaXyL2GwL2EG3jgKXiAvjz71w5MGBzh/gB+
 lQ1c=
X-Google-Smtp-Source: AGHT+IEStIKtmT5AaMveWofLskvajnkJhh3rrgvT0Ejf+dFSKdpwnsFRJUaDAJEB4tg11nulmDpEIA==
X-Received: by 2002:a17:906:154e:b0:a3f:2c1:9887 with SMTP id
 c14-20020a170906154e00b00a3f02c19887mr686091ejd.21.1708419207994; 
 Tue, 20 Feb 2024 00:53:27 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:27 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v1 16/21] qemu-options.hx: correct typos
Date: Tue, 20 Feb 2024 10:52:23 +0200
Message-Id: <be8b852de8adb887472d04016eec876264ea5a91.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 8547254dbf..9be1e5817c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2468,7 +2468,7 @@ SRST
 
     ``to=L``
         With this option, QEMU will try next available VNC displays,
-        until the number L, if the origianlly defined "-vnc display" is
+        until the number L, if the originally defined "-vnc display" is
         not available, e.g. port 5900+display is already used by another
         application. By default, to=0.
 
@@ -5511,7 +5511,7 @@ SRST
             -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out
             -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0
             -object iothread,id=iothread1
-            -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,notify_dev=nofity_way,iothread=iothread1
+            -object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,notify_dev=notify_way,iothread=iothread1
 
             secondary:
             -netdev tap,id=hn0,vhost=off
-- 
γαῖα πυρί μιχθήτω



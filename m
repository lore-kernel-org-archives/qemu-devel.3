Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE55FD33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QoV-0004EN-6e; Mon, 28 Oct 2024 10:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qla-00012b-Jl
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlZ-00041o-2j
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gd7P+eFQmuapc72Z+2YjooQQ3wuGxiAok9a2Yw5g+xQ=;
 b=YCoZCRTsp3gfQ+tF+2i0oDCNceGTJMcwMCtbfcURBv6/Txs4+CNDQ0E/aW39T/FqZcNkc8
 AIlkWcLXhnfyRyo8YIVzvQVBEm9tp/A2p5iiVZsTN2d3BIUFIdHCge6YdFs5922AG0d0z3
 BQQ42VecrxczeW3qMuAvUnmuRhAdCzw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-F4RPQimWPWSuWTrBx8IZrA-1; Mon, 28 Oct 2024 10:30:31 -0400
X-MC-Unique: F4RPQimWPWSuWTrBx8IZrA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d462b64e3so2250607f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125829; x=1730730629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gd7P+eFQmuapc72Z+2YjooQQ3wuGxiAok9a2Yw5g+xQ=;
 b=eXxYLG47qjc2KFeAiGVIuinPxy6oGF16vkEGOWT0UDqbTfK1Mf92S3rmCHtyk/3R6I
 76N0mFa6dNAiECN7/fmF9NrduGPmoA/YzFIFuZsh5AifR0oqWOKx/dDj78R+L9pV1LL2
 yB6DN4dbaQ+DMdTDsKQlhUhvc5bpdCrzlZP3i0gT9W8iJjUTwgdvux2QaG2Ffnnuj13/
 bzoYnvS0uwwk7WbOp7LcGf/ilqpPSScD5lCWnWCLgJovcqRaKPDO/IQD1gEfjkjRQIem
 7FdjpyfKfgvGXc5VUwKqaA7cZm4lfHzRNZzRoA+Rdz6pZHKLuX6zHLzyxlVKO3aPX1Ck
 x6kw==
X-Gm-Message-State: AOJu0Yw26v5AzIU6uEEH7RmTPF/pzlJwjIHu9J31PumZIxNgrrsOuvjt
 6EI+l152fO6iDsb2ydve6RTNydU1h/uWKXeWYiFeAFyoagBiY9GKbz8uiZAVyYKAwB9fSO1dqRx
 PqWYAgnEQk4W1cxDrS5VmeZylzZfG80zPxRTuCKmrGvif6JAbqBAxZ7EFMAT72orTTnlW/L8fHU
 WzNjcuOG4PxyGyrz30kB7Zz2wgLQzETcjuuYrtlzc=
X-Received: by 2002:a5d:5391:0:b0:37d:890c:f485 with SMTP id
 ffacd0b85a97d-38061162d72mr6476378f8f.25.1730125829235; 
 Mon, 28 Oct 2024 07:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD7Gj5WO7V6EX+8ZjUPc/eSSiWS84x1CfoC9Paju/tvMIiiuTDMtqHhwXAR4IfRk55Zn5t+g==
X-Received: by 2002:a5d:5391:0:b0:37d:890c:f485 with SMTP id
 ffacd0b85a97d-38061162d72mr6476356f8f.25.1730125828824; 
 Mon, 28 Oct 2024 07:30:28 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b46bffsm9584193f8f.46.2024.10.28.07.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/24] configure: detect 64-bit MIPS
Date: Mon, 28 Oct 2024 15:29:29 +0100
Message-ID: <20241028142932.363687-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

While right now 64-bit MIPS and 32-bit MIPS share the code in QEMU,
Rust uses different rules for the target.  Set $cpu correctly to
either mips or mips64 (--cpu=mips64* is already accepted in the case
statement that canonicalizes cpu/host_arch/linux_arch), and adjust
the checks to account for the different between $cpu (which handles
mips/mips64 separately) and $host_arch (which does not).

Fixes: 1a6ef6ff624 ("configure, meson: detect Rust toolchain", 2024-10-11)
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 0918147156b..89ac9e78b86 100755
--- a/configure
+++ b/configure
@@ -395,7 +395,11 @@ elif check_define _ARCH_PPC ; then
     cpu="ppc"
   fi
 elif check_define __mips__ ; then
-  cpu="mips"
+  if check_define __mips64 ; then
+    cpu="mips64"
+  else
+    cpu="mips"
+  fi
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
     cpu="s390x"
@@ -1230,7 +1234,7 @@ EOF
       fi
     fi
 
-    case "$host_arch" in
+    case "$cpu" in
     arm)
       # e.g. arm-unknown-linux-gnueabi, arm-unknown-linux-gnueabihf
       write_c_skeleton
@@ -1278,7 +1282,7 @@ EOF
     test "$rust_arch" = arm && test "$rust_os" != linux && rust_arch=armv7
     ;;
 
-  mips|mips64)
+  mips)
     # preserve ISA version (mipsisa64r6 etc.) and include endianness
     rust_arch=${raw_cpu%el}
     test "$bigendian" = no && rust_arch=${rust_arch}el
-- 
2.47.0



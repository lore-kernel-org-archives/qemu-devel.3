Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06865C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 14:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUS0J-0004MA-FP; Mon, 29 Jan 2024 08:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUS08-0004Dy-IM
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUS06-0003u0-W9
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 08:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706536118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y0vzfbHXilb01T3/y9Yp7fe4MdRpSzgLBkIF+oIPoKM=;
 b=TR4A/U2kHhD74ChVVO/5msKKkRMOOtrn3H/to5x2g78z5rQq0nsBH4KH4s1A58kuuU2rHP
 akPtLV3Nkue1W8rGjsaSqPA0WOdD4+xHlJttIXC5uqiA7o5c2M7Gy/eMn+HPnfyq4+2uVK
 mxFktqBblmr7vUM2rFCyqagF2eS/UHI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-ynEDgLeQO42jwJR0mjmylg-1; Mon, 29 Jan 2024 08:48:36 -0500
X-MC-Unique: ynEDgLeQO42jwJR0mjmylg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a30f9374db7so440136866b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 05:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706536115; x=1707140915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y0vzfbHXilb01T3/y9Yp7fe4MdRpSzgLBkIF+oIPoKM=;
 b=Y7Tnh63PhzAMQmrhPg8Lw/kNk6RNRcYE/2eX9YP9CFf8AZImxbrS2oaXYbF1CszLgO
 1qYGX/94sg1NmPHkcCTcE98PyLMPYAW5mXq5HVN1Npqw6kr9BVZI5k/5zucm+okmTkKe
 ff+AXuwweIWTOAhSsO7glB3TaCne7vk9mhwwaAIsp7ZTQnvfszTbN4NFhd6lKKZCLqSn
 fvgTqbWAv1zJm+PBBACW62pQukq88L48vfLMRxohw98VfAxNcn/UTCxQ57wRFwInZu/M
 OBy3muNCpiPaa+70jTMiaJl7P8vhZS6eMJXKGcHm1yRiG9gphZavIGPTJ6p7x2HCsgyj
 gQFg==
X-Gm-Message-State: AOJu0Ywk8a2mc5hKc7y84axyejYtSAUJJjtZDL0/yM90aG89B5mqpUuA
 Lka+BJCfcH2OIW+bqADB37U+jPA/wERRI+Ghivt/OV7hf0/BrojQiyJ4xuMtkCh7dW0IU4IwR6s
 z55xeYLp/Gpco0eJ8VT9EjhDHd8vHrcEV6Oq/HPjsb8y7sHpYYTMSdtsVgobXA58gB6aXvZhVPj
 +lzZV7yFKz82I7fubm6ENTiKr9htR1vjU+enQP
X-Received: by 2002:a17:906:f14d:b0:a2d:a38c:7b7f with SMTP id
 gw13-20020a170906f14d00b00a2da38c7b7fmr6877236ejb.19.1706536114820; 
 Mon, 29 Jan 2024 05:48:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmEuWC73g8nX2LLBX17Zg+rr3ZdUlMmofQtCAhsxyMoYJgaim2D5spqsJtABfepMIN2Ve15g==
X-Received: by 2002:a17:906:f14d:b0:a2d:a38c:7b7f with SMTP id
 gw13-20020a170906f14d00b00a2da38c7b7fmr6877216ejb.19.1706536114408; 
 Mon, 29 Jan 2024 05:48:34 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 my28-20020a1709065a5c00b00a28fa7838a1sm3995566ejc.172.2024.01.29.05.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 05:48:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH] configure: put all symlink creation together
Date: Mon, 29 Jan 2024 14:48:32 +0100
Message-ID: <20240129134832.1108726-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Based-on: <20240129133651.1106552-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 9cdb5a6818b..3cd736b139f 100755
--- a/configure
+++ b/configure
@@ -1538,6 +1538,11 @@ for f in $LINKS ; do
     fi
 done
 
+# use included Linux headers for KVM architectures
+if test "$host_os" = "linux" && test -n "$linux_arch"; then
+  symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
+fi
+
 echo "# Automatically generated by configure - do not modify" > Makefile.prereqs
 
 # Mac OS X ships with a broken assembler
@@ -1605,11 +1610,6 @@ echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
-# use included Linux headers for KVM architectures
-if test "$host_os" = "linux" && test -n "$linux_arch"; then
-  symlink "$source_path/linux-headers/asm-$linux_arch" linux-headers/asm
-fi
-
 if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
-- 
2.43.0



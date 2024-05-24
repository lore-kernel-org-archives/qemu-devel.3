Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D16C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 16:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAXef-0005z2-Uu; Fri, 24 May 2024 12:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXee-0005yA-1H
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXeW-0006wc-Oa
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716567620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DrQKXlw5u4HCxCSjJA+nYUSNZLIT05jc7Oc0v9l+ebg=;
 b=WKRgoj3d2dvzuu80uUiSLV/jCkG+YuBKHtqtbtnsQ80KH50f4o+HEAmE3eF+dA7Hp81IUq
 zJW8bKMoZ0yQuFTv6ap/iFgY3mn/FgGVjoRiTxm/sYkofytESwkpcasUKfEFrT+opnyH2H
 6/ITd7Bl5BdReZre/CJKwbU7oiz67f4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-rvF5T6eWMM-bmBlk08XUqQ-1; Fri, 24 May 2024 12:20:18 -0400
X-MC-Unique: rvF5T6eWMM-bmBlk08XUqQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5785f772d8dso430017a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 09:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567617; x=1717172417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrQKXlw5u4HCxCSjJA+nYUSNZLIT05jc7Oc0v9l+ebg=;
 b=rZRa3Ol9ZZIpBRgfejOYEX2pIUPZmbTkAPRtyRW31m9f6SYtcDyHDseWqdFexpnCfh
 TZlV6PI1rQ89EHfpqUbiSBJSZ+XsUsVmILvJHORqQ2lNBgJFn7DHYoY919Kj44qiSQfm
 eH1U/0vFGIcJOOWuWq+lvtuxEdCOA+aCmwQa12CV5yqvY31I6/MqFhErz1BTu2J9uct3
 745g+9LPdu66eZVCcIoPSaJ3ePeEQ53yKDlREFR7O1GoHs2e4vaZ96xp6T9g2WgfykoW
 Bikp4v0pHIgCCf2PG0gSDneWqSHaXjlEvclzT/4Yak8YAgz3xLHKEwL6FZrDOrWjBMsL
 kXdw==
X-Gm-Message-State: AOJu0YyQl4ma7Ms98weviuJatzvDMIF+Yz+fbVB1EKjZWMudPfcT6EqT
 GC8nprBZzQCDQ0CriCiQJ23UtChCTHN5gX4ShinZETC2bjJzAA0sSRnuWk4yOr9kRl1cRHiLO+n
 0QbXErLkdVag+ME3sRbx7DglMkb0zr8LLrDY8Yy4YJCklnSJ/Q6gRwiEKiPlcpLh6Npt2MSY6z7
 LSxpyzR/jzUgxyOio5+7XPQU1YiEAwBJLXYOxg
X-Received: by 2002:a50:a683:0:b0:578:55a3:8b52 with SMTP id
 4fb4d7f45d1cf-57855a3a941mr1368867a12.8.1716567616704; 
 Fri, 24 May 2024 09:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoQQpn9GSvcfwcZlcJXNj2JGUkkeXR8c39gBT9Eo9kg9kb+gMWq3GHw79h0beftnvLmWr1qw==
X-Received: by 2002:a50:a683:0:b0:578:55a3:8b52 with SMTP id
 4fb4d7f45d1cf-57855a3a941mr1368849a12.8.1716567616187; 
 Fri, 24 May 2024 09:20:16 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57852495debsm1904740a12.69.2024.05.24.09.20.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:20:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] meson: do not query modules before they are processed
Date: Fri, 24 May 2024 18:20:04 +0200
Message-ID: <20240524162006.1271778-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524162006.1271778-1-pbonzini@redhat.com>
References: <20240524162006.1271778-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/meson.build b/block/meson.build
index 8993055c75e..158dc3b89db 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -119,7 +119,7 @@ foreach m : [
     module_ss = ss.source_set()
     module_ss.add(when: m[0], if_true: m[2])
     if enable_modules
-      modsrc += module_ss.all_sources()
+      modsrc += m[2]
     endif
     block_modules += {m[1] : module_ss}
   endif
-- 
2.45.1



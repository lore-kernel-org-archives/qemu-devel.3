Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AB7C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrJu-0001FL-2v; Mon, 08 Apr 2024 11:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJb-0001Av-Hd
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJX-0001mI-8j
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GE4i1kGwr7qusquI2eygxfjfNDhcy764/NdO3lS1rJo=;
 b=e/FqByBTPOn0hJRdkNl9LYXVnsOpcVtjt9kuXFHiIeOgkFuQS2v67Q3C/0AP3AtzzkB1oj
 h1KwBMaYY0RsmWWrloVa63D1jpsOiMaBBn2H26ZQnn0dyOY8qtt3UitTkszr2B8ciXhtBV
 gtQlr66IZu5zevZING/RBfBw36V2npo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-HpvWPshGM6aGw5TKt3nmpw-1; Mon, 08 Apr 2024 11:53:41 -0400
X-MC-Unique: HpvWPshGM6aGw5TKt3nmpw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-416601b0f8dso9892735e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591619; x=1713196419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GE4i1kGwr7qusquI2eygxfjfNDhcy764/NdO3lS1rJo=;
 b=KnyTRXfDk13aYkcuzEf/Q9CP6C25RAIQ8KooaSCN/nfRPZXuMrUDa7uRy5UgHdmfWP
 bMYPNnQxnUzYRk4ZP1Yb8azf+8iC2wwWnTtk5PfTkKODIZtPSxkxsi1zGV5XsqHm9Y71
 AX9ULj0XY4n2L4lY/6S2srJEH3yXOqrZMkvJqw/GjR0c54SckDjhcF8ZxWuj9dQYk1d1
 rEYZJ2XKwN1px5kmDgft97mdeIs5eX0lQ8IbR0e7Sk4olkv3xP0sGkWa2/4VnnqCSWO2
 GO8tnyXglxo/5XtOAu6nlJm77AvOVOdOB4VQ06sXpkhfAYMCK4u6XEyU/uPH8+ydr+XW
 WZhg==
X-Gm-Message-State: AOJu0Ywxar3RmBuDGBd2SPZQ+AqHjTBcAHdDU5AQpzatngZ8bRV6qRLb
 M6Hd60+eH+giGJ1AJL+r/C4p2MeueHVGZD1Mv+eGo3TeSzRPLIWmMkHSSUg8bsmD8Q87LMDVSCP
 pd8h+18z3WHzjx8zVTxM5ASqO1p+LqlUOBFjjPV5vWqzPUZclJvphe0vCMX5agImHiYEIXj1Zne
 aKJUk2CO3ZAuFukAJADvg4bANjmKpIY2VMex/d
X-Received: by 2002:a05:600c:3552:b0:416:7ab3:4c02 with SMTP id
 i18-20020a05600c355200b004167ab34c02mr2360367wmq.14.1712591619788; 
 Mon, 08 Apr 2024 08:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJknOtKv983rji68a9irVg4mWqzduYF450wABjT3zORD+W9ypQqIg8sx2AQNolniG3wzBrzw==
X-Received: by 2002:a05:600c:3552:b0:416:7ab3:4c02 with SMTP id
 i18-20020a05600c355200b004167ab34c02mr2360351wmq.14.1712591619434; 
 Mon, 08 Apr 2024 08:53:39 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a5d64cd000000b00343e97150d6sm8749432wri.32.2024.04.08.08.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:53:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 02/18] tests: only build plugins if TCG is enabled
Date: Mon,  8 Apr 2024 17:53:14 +0200
Message-ID: <20240408155330.522792-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

There is no way to use them for testing, if all the available
accelerators use hardware virtualization.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/meson.build b/tests/meson.build
index 0a6f96f8f84..acb6807094b 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -78,9 +78,9 @@ subdir('decode')
 
 if 'CONFIG_TCG' in config_all_accel
   subdir('fp')
+  subdir('plugin')
 endif
 
-subdir('plugin')
 subdir('unit')
 subdir('qapi-schema')
 subdir('qtest')
-- 
2.44.0



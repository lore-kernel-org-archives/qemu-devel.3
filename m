Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F81CD1299
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrJf-0001BT-86; Mon, 08 Apr 2024 11:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJZ-0001AT-13
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJV-0001mD-I9
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tON+RxlIcOKUvuNbAsvnQBYFFWkRj/k0UEnvjOdoODI=;
 b=KeLaRSLKdFFl5tTkNG4XpInQhHVtPNXjOAUqz54GaQ16Wmvths6tOUbT3QnSCm6CNx4Izq
 nfygUGGnmFRLHh4nXaMHxNaTijNet8luy16trF5dm2znTkaSh3RaSer69EERb2FOCLXhqW
 Bf+9UXjB1Bqcjyf6VIOM5DVVFVbkvf8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340--O6dlww6Pm-krDbhPnpXmQ-1; Mon, 08 Apr 2024 11:53:39 -0400
X-MC-Unique: -O6dlww6Pm-krDbhPnpXmQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d87dad1640so14922911fa.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591617; x=1713196417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tON+RxlIcOKUvuNbAsvnQBYFFWkRj/k0UEnvjOdoODI=;
 b=Er3UqUjuc3eC4yC8A6dohKnJfCx9N9KVI7K78zeMlsrNgErDG5Pp9Y8qgbcZ/1NVov
 cyq6u6wSrgyrP0kJa1fBhTI5/6IvF7/0g9qLXTTvTmgV5zpPmvimUKjGBpLhHHWT6z2B
 ICgv4Zyjunv8cUWgeRelvoNePqHypprQlSA4Vx4qzs9iRCx8PR7WkeJIKqTtEL94X1h1
 AsQTRWVCHJvdaoP+g6kNokY15U+XImZbzpKrwqYAfl+Yj1QGBd+iIn8HLV9aI+clud3A
 qV3KNgKCu2VgPkMweW+OFE/t6D791wgYx1XW2UfpkqTDKho+bQPQ0m1nRgJonmFsnLzj
 xTig==
X-Gm-Message-State: AOJu0Yw2uanSWg8/ZVHUbnJ/QAaxlM1Du3Pjs5H2Xe808EFzu3MqENPK
 847TbtXuqEfRb8Cll/7bCPRMAD7zxl3THYHw5q/3qkxP1IVmrrHfn4ub4KkfQ0HyvN6OB0Cb4rY
 BibVulGfSdA6RZoO8sfaFyUpVAvrUj68MW+c6TScMYIYeV7n8dVGjffFa2R7SahBrLUwyBW/UpP
 Xa4+pJAti2agoe14A24svEqfMHQV8mQWtrX4wv
X-Received: by 2002:a2e:8695:0:b0:2d8:7200:38ff with SMTP id
 l21-20020a2e8695000000b002d8720038ffmr4902604lji.24.1712591616829; 
 Mon, 08 Apr 2024 08:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv+THxP+7lnUNqhkV3MzBGQ4Z7GqCw+HPCw9hv6w5tCj91zmuJAIZP6vv+CWi9SNtYl3nKwA==
X-Received: by 2002:a2e:8695:0:b0:2d8:7200:38ff with SMTP id
 l21-20020a2e8695000000b002d8720038ffmr4902594lji.24.1712591616384; 
 Mon, 08 Apr 2024 08:53:36 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a05600c4f0d00b004167071617dsm4119939wmq.9.2024.04.08.08.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:53:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 01/18] meson: do not link pixman automatically into all
 targets
Date: Mon,  8 Apr 2024 17:53:13 +0200
Message-ID: <20240408155330.522792-2-pbonzini@redhat.com>
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

The dependency on pixman is listed manually in all sourcesets that need it.
There is no need to bring into libqemuutil, since there is nothing in
util/ that needs pixman either.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c9c3217ba4b..09668e3c5f5 100644
--- a/meson.build
+++ b/meson.build
@@ -3477,7 +3477,7 @@ util_ss = util_ss.apply({})
 libqemuutil = static_library('qemuutil',
                              build_by_default: false,
                              sources: util_ss.sources() + stub_ss.sources() + genh,
-                             dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc, pixman])
+                             dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc])
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res,
                               dependencies: [event_loop_base])
-- 
2.44.0



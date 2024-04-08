Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F03CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrJw-0001H0-5H; Mon, 08 Apr 2024 11:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJs-0001FQ-Il
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrJq-0001pC-DS
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KbjY7aIuc7IAjQmn1sxXdHMB6cOTkaQOGtjjzsthhOg=;
 b=VYt3FHRaMnt9G3kNCVjq+bs7lsuxL+HsZa30P6bnBWPdknykHRSX10g3cZvgiOapvvhFOC
 iUSJYll5Vg4TIx3dlDRRxR8tGFree094uezgwWbYRihSeYvF4dB2zlZp7WJA8Wm19SmEgj
 Yey3MG6Bbe5pUeegCQszju6rAHkQAu4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-rytjUqXSMzKbCTNbaScdUQ-1; Mon, 08 Apr 2024 11:54:00 -0400
X-MC-Unique: rytjUqXSMzKbCTNbaScdUQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed489edcaso2739284f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591638; x=1713196438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbjY7aIuc7IAjQmn1sxXdHMB6cOTkaQOGtjjzsthhOg=;
 b=sZLrtDdplZGrgmb8JVPZM9pBe+sptfS8B0X/AMyBJUZdoltrXf6KBUkSlsdV/YLg8n
 4BjTlB2T14OMLsqhagmzSBYb9fihE/IerOEXsHrFnDANj6mTH056ZpCmGlIu7FZFkAAN
 3j97CKcV80bwq26zZS4IjLBI1LibBgCZjJS2+TQRpU6gxO1oxh0vgTPzMJWMHZBUD1hZ
 NxFOy+V5fFXWLntE4qgCs/mHqq+remB5JichXWFp6KPxjRzBe9OqXfLWbgH9eeUDdIuv
 trod6BZHeAstOHoxv519cv/yuUpHBPvVYmkGi2W1RQk3Z+z1dKvHHurRr7wK2F87wE1y
 Z/Rg==
X-Gm-Message-State: AOJu0Yxge0y6qPBiy5Q1tb8bobELr1GYcW/xB3ELQsmEyA4J1FywfYcZ
 KI9hrrx7WOpUKxDUwcws7Zs3Yfz3TtG5BWEkMPYpgkhqjGzlXJX0Fey8qalfwcNIEucYj77bGsI
 Oh0PW4qyIK6kde7YVm5qDrN+dm2pfSDs7j7C5HJw7j/T/KAhCwkIzMWex3fhYEUoxZBgJEeiFzd
 D6y4irydeo1MDbVazbvQOahGlwIOouzuxi3f7F
X-Received: by 2002:a05:6000:1864:b0:343:5cac:8d9e with SMTP id
 d4-20020a056000186400b003435cac8d9emr9600562wri.33.1712591637834; 
 Mon, 08 Apr 2024 08:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG3wsTpqOVEkjB3vEbxiXHj89C9rpVnLAII/I72Ouo0SVK3t6lVvEgDVURWOmu+3dLiG2sNw==
X-Received: by 2002:a05:6000:1864:b0:343:5cac:8d9e with SMTP id
 d4-20020a056000186400b003435cac8d9emr9600544wri.33.1712591637524; 
 Mon, 08 Apr 2024 08:53:57 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a5d4564000000b00343826878e8sm9251321wrc.38.2024.04.08.08.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:53:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 08/18] hw: Include minimal source set in user emulation
 build
Date: Mon,  8 Apr 2024 17:53:20 +0200
Message-ID: <20240408155330.522792-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Only the files in hwcore_ss[] are required to link a user emulation
binary.

Have meson process the hw/ sub-directories if system emulation is
selected, otherwise directly process hw/core/ to get hwcore_ss[], which
is the only set required by user emulation.

This removes about 10% from the time needed to run
"../configure --disable-system --disable-tools --disable-guest-agent".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240404194757.9343-8-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 09668e3c5f5..e8ac846fc5a 100644
--- a/meson.build
+++ b/meson.build
@@ -3447,8 +3447,12 @@ subdir('qom')
 subdir('authz')
 subdir('crypto')
 subdir('ui')
-subdir('hw')
 subdir('gdbstub')
+if have_system
+  subdir('hw')
+else
+  subdir('hw/core')
+endif
 
 if enable_modules
   libmodulecommon = static_library('module-common', files('module-common.c') + genh, pic: true, c_args: '-DBUILD_DSO')
-- 
2.44.0



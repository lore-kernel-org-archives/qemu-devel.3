Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB7BC3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 04:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXCdd-0006kR-PM; Fri, 26 Jul 2024 00:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXCdb-0006js-Kg
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 00:33:03 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXCdZ-0004nI-VV
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 00:33:03 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fd70ba6a15so2340625ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 21:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721968380; x=1722573180; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2x4mj/BwG7aAcgrsqFz1Wjvyoe9j7V/h87SQHM9sKzM=;
 b=FStF4WcPSDFIZTSDKzLYqtOCSOYUNzD4QhtmjYwg98a9jC2+3+rDROktglyoKMC4X1
 63d0Gy4a4gGcNaOMlDufZ/gWbWxZVfwq+9MkNe0uFIBDs05Zl41Q561cggaZXpR0D7ER
 oX3bZ88ElMxioJlqBvBUNIPq0Q4QV2VPvp1UWFdnNBOAI/mSBw2GlmEFRp/r3d0+v2z+
 zUUO6SVjB6CDdnwT6nzTOZnY6yXS5FxQJM5+VVahpe/AcRwNfm9PuHKnJobzVnk+aM8P
 lCiVC7MySvX8FVb3H+787sYIu63mKTDoLtSwhAT6/3i2kMb+XYBXYDb917uatqQKm0d0
 refQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721968380; x=1722573180;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2x4mj/BwG7aAcgrsqFz1Wjvyoe9j7V/h87SQHM9sKzM=;
 b=U2YXpaYPvFaVAGXetetXvMfZoDUIwhzPgYoNlhn/NrRXM582J2bImR4mTkpKonBuGm
 57DeAL6e0jWrGLVDNNySefv86DUaEJ1CtNNNagq8tfNyik+kUVhD0DVgOgAYa+K2BSqR
 BTMQxbxvivanT9vLOY9AwFeBhJoM7aRueFyc59mXFX6cWK9OLyGKpR5dglJpu30nTqDl
 FQBN4C36+ZBEq3u+O44jeJY36y/qUXk6cq9DF0yp43NKTjWXBlIPkotbry5o938dprD2
 E46jBH8UEptNGk+Mh3+sYsM+BymdRpSt+3G/qwqY85FCuGvwgY9dWndOr2xGuyppM6QS
 AOkg==
X-Gm-Message-State: AOJu0YwqFOSoe0vXA3R0+EzXOCz5a2kvnn7df3gppdxtbXYdY3WVOBnW
 xLLiq7NXBbcXHIlBb68xHkj4K7Z6fNswD22bfXPzcUIqi+mTtRGj9YS4MjenoGso3mVEZt+xOJJ
 /amiabBDeY4X5yDC0L8syPQTPanHMkCzN/gXbopwio8/168DZS+mHKIz98urT7+nmteYfVN3Jss
 iijNCTTS+Pc4Cyzt3GIc9c83BanWWNQIRzOg==
X-Google-Smtp-Source: AGHT+IEwr3ab04VrYcJM4KyRCVNL+YihmknAfCSYADHrHT/a5pjf7xoci0bxfkbgOyAjiIMM7x7B9g==
X-Received: by 2002:a17:902:d511:b0:1fb:93d6:9fef with SMTP id
 d9443c01a7336-1fed9253507mr43527235ad.38.1721968379652; 
 Thu, 25 Jul 2024 21:32:59 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f7b092sm22303015ad.246.2024.07.25.21.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 21:32:57 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 1/2] include/elf.h: align ELF macro name with glibc
Date: Fri, 26 Jul 2024 12:32:45 +0800
Message-Id: <20240726043246.10999-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726043246.10999-1-jim.shu@sifive.com>
References: <20240726043246.10999-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename DT_BINDNOW to DT_BIND_NOW to align with glibc header: "elf/elf.h"

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 include/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index e7259ec366..ef47b5e2ad 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -235,7 +235,7 @@ typedef struct mips_elf_abiflags_v0 {
 #define DT_DEBUG        21
 #define DT_TEXTREL      22
 #define DT_JMPREL       23
-#define DT_BINDNOW      24
+#define DT_BIND_NOW     24
 #define DT_INIT_ARRAY   25
 #define DT_FINI_ARRAY   26
 #define DT_INIT_ARRAYSZ 27
-- 
2.17.1



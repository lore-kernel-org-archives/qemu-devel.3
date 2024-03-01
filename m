Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E5DC54E58
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjL-0005Og-9E; Fri, 01 Mar 2024 23:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1h-0003xE-I7
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:54 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1e-0005oh-Bo
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:49 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6e4d1448d31so422776a34.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334643; x=1709939443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX3KBb2f91IJNoXnuOHaXnVXtCOeG00rM8fZbeZEXms=;
 b=Y2kzzu143heSNZAnx63b8aw5dRDxKrc/OcgUUwdoPxIsZzYPtCJeUEInAam2leFT/7
 OJWBmXrWxCpqrmMAHv9/zM7y42ANO2QqCk4ZQcqaPGvGDCaVakniGB1GnD7cTMCwFny0
 Hfck20eFgXAfXMVL3/7Tp9RBbWcTCmz4GH1jEDsXjlagfUtBt8ButtRfO6IjPMz6Wgce
 8gHpcCCZPRUxcvN40DtUu5sg12yHb07Hu4G8sAHDCXwb8pGBTnvcBXY+f7U6aNr7phx4
 LDi0e3j22cNKJ+ZmESOPoirHs2ZfxRsjJJmU4F7i7ephhij55y5vkmuQIUukJVP0thFP
 z6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334643; x=1709939443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oX3KBb2f91IJNoXnuOHaXnVXtCOeG00rM8fZbeZEXms=;
 b=FJip0sxO86oMVF9KjHLV3hQERMQ4x5jmmwggcn3qnf2lsUtRn7sPB4EOdj8qhv6TqX
 8BnNF7rSirCcDtSldWMY3H4A9pBbZj9iAHyXY9QwuHFDF2htXHhaHrd6J4W4lV5p0gX+
 KmaU2exSJrciybCOrboWxYTiyYC+A/qOZuNH/LRreBUDoDLOmS9ULSZ8C27CzRQaVi5+
 9J7Cud5ulFxbh1VIUos0hbVh5NRiJfTmRICKLKHlpKXT7B9g7Rv6RfCZauLXOTLgyoKb
 o4m4JWUROv3ywWjYb12xsK7ht8jNBzsSMdXqo5IBOB4S8AkmXFzR+5Pc070NUd6k3YSE
 ecIQ==
X-Gm-Message-State: AOJu0YzrJa1ujp3K0oAojLRZqIxlst4BwHobXVaroUIGl5OsP9rlWdZX
 XxYrkK5617b3hVye4xotRhFlAOOlN0OrEnHLXN5Lv5P3IHkN5Q4vZvxx/m2c7MFaFtLwpabtnQD
 O
X-Google-Smtp-Source: AGHT+IGYT6rOdxYNGYmG9lq+JzEiBc+aH2WXs27wwuG9ORbe/HMz89jYWOwNu0syDc24f7WyWilc4Q==
X-Received: by 2002:a9d:63d3:0:b0:6e2:e2d7:55fa with SMTP id
 e19-20020a9d63d3000000b006e2e2d755famr3233569otl.14.1709334642949; 
 Fri, 01 Mar 2024 15:10:42 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexey Sheplyakov <asheplyakov@yandex.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 54/60] linux-user: Remove pgb_dynamic alignment assertion
Date: Fri,  1 Mar 2024 13:06:13 -1000
Message-Id: <20240301230619.661008-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

The assertion was never correct, because the alignment is a composite
of the image alignment and SHMLBA.  Even if the image alignment didn't
match the image address, an assertion would not be correct -- more
appropriate would be an error message about an ill formed image.  But
the image cannot be held to SHMLBA under any circumstances.

Fixes: ee94743034b ("linux-user: completely re-write init_guest_space")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2157
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reported-by: Alexey Sheplyakov <asheplyakov@yandex.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/elfload.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index cc2013c7b4..0c299a7c15 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3022,8 +3022,6 @@ static void pgb_dynamic(const char *image_name, uintptr_t guest_loaddr,
     uintptr_t brk, ret;
     PGBAddrs ga;
 
-    assert(QEMU_IS_ALIGNED(guest_loaddr, align));
-
     /* Try the identity map first. */
     if (pgb_addr_set(&ga, guest_loaddr, guest_hiaddr, true)) {
         brk = (uintptr_t)sbrk(0);
-- 
2.34.1



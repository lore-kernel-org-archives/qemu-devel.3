Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B11C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSVO-0007Xi-J8; Thu, 16 Jan 2025 11:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTs-0003lj-BC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTi-0004Wd-UD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:27 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso7238145e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043937; x=1737648737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tO4+dhgDNIyv7ebOS6QWgeVxieJfX0lz0H9vGOgOWgE=;
 b=SqhRb8NauczcF3YsQlrsb/JIHNW+TGf5xtMhG/1pqnqWLB7AJLobffOVceTyQKdruT
 xcUuZpic93TyFawRRquFvbPLVyA9gJ7vSYxHdwx/eOT1e2b9A/71+I+OyI879n0IihZe
 tYJ5H86YwaP42STFg70FCFRAECsAtVG7CjwajjWY44/w92MSrnTn30leGSmTxNCAtmr3
 FGXrSh90rb0sJMDkRU/BVmjy1WPx7N/kaZ9yB0vc9KoMYbi8RqwFiMOlOIUMuhR7momm
 isecAGaNbd5IiUBMhs2mdEFcBS7mopGe4QrIdllSwYKz8rXJcaI/BBxn5SyxQcBfOafc
 +Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043937; x=1737648737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tO4+dhgDNIyv7ebOS6QWgeVxieJfX0lz0H9vGOgOWgE=;
 b=uuncro9v6wnidVjyI8GLz1pmGwG2Zr9ElWgM4gSYfz9FvmU9w80jGVEAKkVgz8irm7
 6BSE4mGFYIXOlsFvbzvaBtWob5APv0plc/u0Jyabu4D4WUZT/90XipYUf1kB8ZBOO2Bz
 sXHPcMUfPtrR6zEAAfAIzGECX7KfEFkiRA1hkHkAS9luYBHLbNL7pqMaf5nh2JP9mPQj
 pxZ1CASXYy2emU7NR9eAobW9KCS5xQTgMELTcC/GNYryxuql81Pz9WsV2rBAQqVvupee
 R1i+FTgLX1/oaLiFv48U8+lqbulA7hvaaC+hHsST6khmU9d+Qee55/8TLdZjFnZdIDSn
 TQqg==
X-Gm-Message-State: AOJu0YwhM1csHVTwu5jg/hBj0PgCHvMC0vOHTJiaTq+8KOF/ekIgOlos
 dMGEOwEMF+TQOuSO5HXQMWz6qXM5chGBq04OYf9G+DAHZln5xRBzGiNPPZLkNn0=
X-Gm-Gg: ASbGncueidBvprTgRXgX3cYVYVwnqhgI9Bt3orY5WgN/RocfeXEC2mdm0czvibrCNEI
 M/PE5kasPv0mCh0hjnH+04wWUeX1tES0A7+soDi3keTISdGwaJz7uPzb1YocWxBLJ6BkzEUtfd0
 AgRWETuLAcSnxe0KihKqHmTryaCnbTDVCqLDEractPTPf4BFOY1kW50D6Z+gfiJfDJuZu9twq7x
 6E8gyCL3SySJ2hccPyYUjjQxgJcpg4JMyUOonkkKIEO31mheQ2h/WE=
X-Google-Smtp-Source: AGHT+IEKy+YKPzZ94MmVyA5tBCXIkVkFNLgN009HkLdeuMT34zI8mD0OYs3Jwdri5RtYL57VqnCPCA==
X-Received: by 2002:a05:600c:1384:b0:436:1c04:aa8e with SMTP id
 5b1f17b1804b1-436e26bdac1mr366312215e9.16.1737043937257; 
 Thu, 16 Jan 2025 08:12:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499884sm65557275e9.5.2025.01.16.08.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C7FE6608D4;
 Thu, 16 Jan 2025 16:03:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 24/37] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Date: Thu, 16 Jan 2025 16:02:53 +0000
Message-Id: <20250116160306.1709518-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Stefan Weil <sw@weilnetz.de>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250110203401.178532-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/style.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 2f68b50079..d025933808 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -416,6 +416,26 @@ definitions instead of typedefs in headers and function prototypes; this
 avoids problems with duplicated typedefs and reduces the need to include
 headers from other headers.
 
+Bitfields
+---------
+
+C bitfields can be a cause of non-portability issues, especially under windows
+where `MSVC has a different way to lay them out than GCC
+<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_, or where
+endianness matters.
+
+For this reason, we disallow usage of bitfields in packed structures and in any
+structures which are supposed to exactly match a specific layout in guest
+memory. Some existing code may use it, and we carefully ensured the layout was
+the one expected.
+
+We also suggest avoiding bitfields even in structures where the exact
+layout does not matter, unless you can show that they provide a significant
+usability benefit.
+
+We encourage the usage of ``include/hw/registerfields.h`` as a safe replacement
+for bitfields.
+
 Reserved namespaces in C and POSIX
 ----------------------------------
 
-- 
2.39.5



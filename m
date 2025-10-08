Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF19CCD185
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NmZ-0004y3-Gy; Wed, 08 Oct 2025 02:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmW-0004v4-GI
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmU-0004by-Jk
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759905369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfiGfyaUtQw93g5vDuIo9R5ZncfvN9pDh/NQvXv7C7U=;
 b=CW3LykAyujtY0Fl5Qs3i63+7nrtM9AhZ86mEfxyoyXOlHogOTL10mokq4myUlc7L21yNyx
 v72mbZVkaO3yvD3Qfsoky+1z8KuY8wgeLkqR5KITZmgPDknMthuHyZmRAJetROvi7v2y8Y
 DlB4ljoiiEsGGdrn2/wFHCIBExmwxdo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-bgM5sRkLMQKxNBcO9PhjsA-1; Wed, 08 Oct 2025 02:36:08 -0400
X-MC-Unique: bgM5sRkLMQKxNBcO9PhjsA-1
X-Mimecast-MFC-AGG-ID: bgM5sRkLMQKxNBcO9PhjsA_1759905367
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-634779072f7so7219375a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759905366; x=1760510166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfiGfyaUtQw93g5vDuIo9R5ZncfvN9pDh/NQvXv7C7U=;
 b=hyOXJVU6mqdBgV6X2NfKW86dgUgDx00s/VKxdogr5c7WwzPiyyuqlEpDgnh3EqZfqs
 FdtxaEhLWy/GVA/6DY+fp35PaT088yHbjavn/W8WcRgJj8KYS02ErpeaHtyn2J7+b0eh
 hRiyiOqCRgib8bmzXIoYVeMKY56qITkyb2ucwT5A/ogElSPzXASqx1D3U0ubPlx6IaCD
 7Tha65Lz5Sa0nHi4EaeX2jwdeJkHolk9ubDAj3R99myZL8EYNvoFM4/LddKMcn4Z4MA2
 OJCUx0HFvwM5qLIoY6zdg0wEfBpmBSUttbLxpGI4h/hryThx/YBPN8jINhxPaxsOCVTz
 W/qA==
X-Gm-Message-State: AOJu0YxcH5KDP/YYY/1hPEpDzAYfJta3M5bfgaAHJbrh1Iv0bsfCLfn+
 qRKl8EQ73Z4tO5a8K3kJMASj3taYVj3xZjmQtx1G6ce5Rppj9yyVgeR9h7gYZ6JobrxPiJqnZNc
 pu84Zl6MEim/RgyljBRCtFnof1hNiRDkztFKpatJ4RTOfHiVtDTwgmxS3vHWK9cbpFt7oE4/+Yt
 ogfnVlcU6aGCCXUOUqRg8dshrCF0/0PQ8vEIx8E8wb
X-Gm-Gg: ASbGncs05Mb7gDBQv8mWYKejR7PajytjcUZ7X1+bhHuAdP6BCENEtxe4LDI1FPHGnI4
 hgPJOj1uD1fumyi43BZt4XOFgZfOrh1MBCvdUWytjX3us3694i4O9jlPwwx0qqG3dTJak0FG3Ij
 g3WE+BhkDTtRnR2OeSrMP1rpSYG7+DNWQVZZpaV+bS/1PQhPS4mOAQdVDwmg+kirpkRey/b58RA
 zQXBQTdYKOdVxcZTrmmF2vqeIII8a054oA+YTvw8fLOzU62+lOVH0/QkmsBevWzsD0VT1gjlDWS
 EU1wJXACqVx53bQq/Whe7eYNFMw5Icm8EGJqLxBfb0hEd1BA4EzyrI0uEQOUylRDv9zycSpUyGm
 HOyXUcTIEiVFC5DXYlQ+tGfz7MAxrc/yM4zCuRB0qQJVXvZac
X-Received: by 2002:a05:6402:1ed4:b0:633:e4e7:76af with SMTP id
 4fb4d7f45d1cf-639d5c7391cmr1824113a12.33.1759905366608; 
 Tue, 07 Oct 2025 23:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEurzwv65Xm1Spu/ogsBm+1jDzByWJX5RDP8c7BGaYRYUZmhn8ZYcDDdXKavzNtd//t9w/2hw==
X-Received: by 2002:a05:6402:1ed4:b0:633:e4e7:76af with SMTP id
 4fb4d7f45d1cf-639d5c7391cmr1824084a12.33.1759905366199; 
 Tue, 07 Oct 2025 23:36:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-637881011e9sm13924865a12.25.2025.10.07.23.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 23:36:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 6/6] tracetool: add typing checks to "make -C python check"
Date: Wed,  8 Oct 2025 08:35:45 +0200
Message-ID: <20251008063546.376603-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008063546.376603-1-pbonzini@redhat.com>
References: <20251008063546.376603-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 python/tests/tracetool-mypy.sh | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100755 python/tests/tracetool-mypy.sh

diff --git a/python/tests/tracetool-mypy.sh b/python/tests/tracetool-mypy.sh
new file mode 100755
index 00000000000..7b4011e52d6
--- /dev/null
+++ b/python/tests/tracetool-mypy.sh
@@ -0,0 +1,5 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+cd ../scripts
+python3 -m mypy --strict tracetool
-- 
2.51.0



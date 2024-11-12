Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D6FD32D81
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvn3-00049A-NB; Tue, 12 Nov 2024 13:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAvn2-000491-9a
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:39:00 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAvn0-0004sd-MK
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:39:00 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a99e690a3e9so18748666b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731436737; x=1732041537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qiSWxxHYfQTY2zsTVKqfJgicfESEbI2xKrsyVMmH8nU=;
 b=XhME8DByEPtorBF6zDUvCWxmvOyz94MSBwmw8yjvRcHeKRbMW+8KqVUeI0VXPF1G8M
 lKUkEfwRxd9mJIiQUPEwJKwyGg83wEvzYpnFWc+v85u65Q0sfAjahzE7eJwosJV1sNGr
 t+UjaJ9BKwvBt1/DhEkYwvLw7bOXkR5FVJA0lrcSuv/VmiD9MASio0PRunW8JIn+wI8C
 VFA5TiZI1DzO+SZ3NOPcEO9GXDk5A5f1cdhAa2Nmb6sxsunem7mgTZLUI0t/x3/wjv2i
 HVvD2IQqa61FW+ZVHW3azwbtbukS624QJ2ItxjocH+vqTnjD50jPsDNZR5wTSVigUlAh
 hKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731436737; x=1732041537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qiSWxxHYfQTY2zsTVKqfJgicfESEbI2xKrsyVMmH8nU=;
 b=GL75PvWt26wxZulbZq3ib0+D9sA9VtOYAMTAyQENPkD3wsM6fucUWeBpsr+Ha4CbGY
 zpgYeUZvOSpDyI1g2b6gXjd5sKd9HoT2+DPQewuG0zczU/sQ8+KtvhvzZ6nl+CLY73dQ
 K6kH5m2jVkJ+gCLYl3H40yLTY7B4dEstRjqsccbfCxXQJgVxQAkn5cZrqrLNxSxYkmMu
 gaElNvLryFcoROWSriz4hNI3Bfq8beAFiLEvUF/BraC0AF669FypNieh7Q9myojxQb0w
 5a85D/9//h9LY9I0GgPiPRdKf66waa9hgmchDidXUE4MWkW8YKcHFQR/MEnoCw36iQzW
 8rGw==
X-Gm-Message-State: AOJu0YzhXzJoUFpAt12OV36XQAawVyEHwOdnxDA7CnOSl8f8KSp6XRaP
 KTV1y7gmLt9TBpb+LZDTywIEuuxBnb7zb2LZjDe/4+lVzDZmFoF2++ra1FgL
X-Google-Smtp-Source: AGHT+IEIla944rQas2zDsG/KEvQcaUxTlhqCm6IturWGastNugo/yVTV5VrjdZPGC9qIsUgMa56F2A==
X-Received: by 2002:a17:907:1c9e:b0:a9a:2a56:b54 with SMTP id
 a640c23a62f3a-a9eefee26bdmr713961166b.5.1731436736655; 
 Tue, 12 Nov 2024 10:38:56 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([193.104.68.137])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a9ee0e2eb28sm745980766b.197.2024.11.12.10.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 10:38:56 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: qemu-devel@nongnu.org
Cc: djordje.todorovic@htecgroup.com, cfu@mips.com, arikalo@gmail.com,
 philmd@linaro.org, Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 Faraz Shahbazker <fshahbazker@wavecomp.com>
Subject: [PATCH] GTM19-448: Fix script to work without realpath
Date: Tue, 12 Nov 2024 19:38:49 +0100
Message-Id: <20241112183849.2577570-1-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The archive-source.sh script depends on realpath command, which was
introduced in coreutils-8.15. CentOS-6 build systems use coreutils-4.7,
which does not have realpath, so fix the script to use 'readlink -e' to
perform the same action.

Cherry-picked 5d1d5766f0219ce2bec4e41c2467317df920ec0a
and 8003ab4032772a0e5b46e5983fe06268d3469289
from https://github.com/MIPS/gnutools-qemu

An instance of a pipeline of QEMU CI jobs run with input
variable QEMU_CI=1 for this patch is available here:
https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1538854588
and for the master branch is available here:
https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1533465414

Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
---
 scripts/archive-source.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 30677c3ec9..bfaa0c1483 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -18,7 +18,13 @@ if test $# -lt 1; then
     error "Usage: $0 <output tarball>"
 fi
 
-tar_file=$(realpath "$1")
+which realpath
+if [ $? -eq 0 ]; then
+    tar_file=$(realpath -s "$1")
+else
+    d=$(dirname "$1")
+    tar_file=$(readlink -e "$d")"/"$(basename "$1")
+fi
 sub_tdir=$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")
 sub_file="${sub_tdir}/submodule.tar"
 
-- 
2.34.1



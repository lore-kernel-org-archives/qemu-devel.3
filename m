Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DB3D7879A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAdX-000837-Sb; Thu, 21 Nov 2024 12:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdV-0007xo-HQ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:33 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdQ-0001Zk-UV
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:33 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43193678216so10419055e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208785; x=1732813585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wv4PNTnfk9kZ4Ys171hToXZi4xYchox2b5iY8mj5xXY=;
 b=T1bds6c3UQXEE4ldyChMLN+62NZBWiybkkRz0uOVnOH0n7hMbkodYfebo3AysWgq3g
 /4kTaiU2QFcdYr59qG1Q2gIuQaIU/ZF7yKF6dlf8SH0fPaJ9L7Ozdj3bOkMaw4iE5lX+
 pg45mcDR7UnIxKCo2X11AEZAofUKMGSveWi5TDmpJuh+x6rt/b1i69FFfcC3jII8ZApl
 IAag0UsO1YFZJvNQg/C4K/hzOJorr/OXH8f3h0lUtZU11tlhlb8lfOzRTRkOcY0fpWta
 xo/JcFWq7MYlqLQHMDJjsUN416rm/SMf3JUcNyxt7dfW2QQYSGUB7s0MOye63EFDrb8E
 ecDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208785; x=1732813585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wv4PNTnfk9kZ4Ys171hToXZi4xYchox2b5iY8mj5xXY=;
 b=p8jnbpRqX6HDQ8/o0w8XPXLIws9YHS6H7w2VuhkGRjQOoR6UUnnp624lKEqhIdRMLy
 fF8FdOCZMqQrHCPGa6yiq+A8qy/QCYNBlHkNKfYECZ0P2tQ9qWdrOX2m2m+Cw3NH67lc
 a2BJltjWipj9ZrEr1aPEwpF92VQedrIbHmqMm13hd0LAwfi/YZwLkzElY3e+5oFK8eZA
 AqZ1cyjkOixzMc2U/sThEKVGsc52ySXcL0lkAfs2U69w3gMnYIAv9JCJXBp61WnuDxSi
 SxWk39CSMx32tfOOIEQNhpQEStjNZAYvO6jk4a0mLObFmmrgczeAqjr8Bp10mGXyWZUE
 uouQ==
X-Gm-Message-State: AOJu0Yxkvp6tETSveO/onUCXeV/Veapq7A+ylp15or7mcymLGGqmLNVp
 gZ42uSfHZQ0k9wQL5DEjfonlmnp3ErTvhfBX2oGxKDYqS886kQTSB3oRtoForC4=
X-Gm-Gg: ASbGncu27+F/a2yyG2tmAb8CQJMMcC/xR6bMxLrnUXkvqwlFeJtUNLX32rJvYdZU2It
 EreTUQIg+XP3JAs1kYQzL85Wz6sLUZJs/FM5hzypsOeLk1qMqT09AQTCR1BCaNBZoXWRL51b9NC
 V9F5GWE3xH58cXIAE/T3g/XC9n6NG5Ss9DsSZELOjXllejRxsqtW3fu+iyBrEQF0Anw+77B+G18
 ybWPi+vxpHOFuMA5MqwS9MVWk1JFl1Q2u/owgj4BG14zYPI
X-Google-Smtp-Source: AGHT+IEXZ91jFsQPj0ANHoQvzJK063hUeeff9wPkWor6mp90Ld69UU6SGLizgpf999m+Wdp54jpnpA==
X-Received: by 2002:a05:600c:870f:b0:42c:b1ee:4b04 with SMTP id
 5b1f17b1804b1-4334f021c2bmr54753795e9.28.1732208783911; 
 Thu, 21 Nov 2024 09:06:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4616fc2sm61609455e9.22.2024.11.21.09.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:23 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2F4460510;
 Thu, 21 Nov 2024 16:58:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 39/39] docs: explicitly permit a "commonly known identity"
 with SoB
Date: Thu, 21 Nov 2024 16:58:06 +0000
Message-Id: <20241121165806.476008-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
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

From: Daniel P. Berrangé <berrange@redhat.com>

The docs for submitting a patch describe using your "Real Name" with
the Signed-off-by line. Although somewhat ambiguous, this has often
been interpreted to mean someone's legal name.

In recent times, there's been a general push back[1] against the notion
that use of Signed-off-by in a project automatically requires / implies
the use of legal ("real") names and greater awareness of the downsides.

Full discussion of the problems of such policies is beyond the scope of
this commit message, but at a high level they are liable to marginalize,
disadvantage, and potentially result in harm, to contributors.

TL;DR: there are compelling reasons for a person to choose distinct
identities in different contexts & a decision to override that choice
should not be taken lightly.

A number of key projects have responded to the issues raised by making
it clear that a contributor is free to determine the identity used in
SoB lines:

 * Linux has clarified[2] that they merely expect use of the
   contributor's "known identity", removing the previous explicit
   rejection of pseudonyms.

 * CNCF has clarified[3] that the real name is simply the identity
   the contributor chooses to use in the context of the community
   and does not have to be a legal name, nor birth name, nor appear
   on any government ID.

Since we have no intention of ever routinely checking any form of ID
documents for contributors[4], realistically we have no way of knowing
anything about the name they are using, except through chance, or
through the contributor volunteering the information. IOW, we almost
certainly already have people using pseudonyms for contributions.

This proposes to accept that reality and eliminate unnecessary friction,
by following Linux & the CNCF in merely asking that a contributors'
commonly known identity, of their choosing, be used with the SoB line.

[1] Raised in many contexts at many times, but a decent overall summary
    can be read at https://drewdevault.com/2023/10/31/On-real-names.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
[3] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
[4] Excluding the rare GPG key signing parties for regular maintainers

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241021190939.1482466-1-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/submitting-a-patch.rst | 7 ++++++-
 .gitlab-ci.d/check-dco.py         | 5 ++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 83e9092b8c..10b062eec2 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -18,7 +18,7 @@ one-shot fix, the bare minimum we ask is that:
 
    * - Check
      - Reason
-   * - Patches contain Signed-off-by: Real Name <author@email>
+   * - Patches contain Signed-off-by: Your Name <author@email>
      - States you are legally able to contribute the code. See :ref:`patch_emails_must_include_a_signed_off_by_line`
    * - Sent as patch emails to ``qemu-devel@nongnu.org``
      - The project uses an email list based workflow. See :ref:`submitting_your_patches`
@@ -335,6 +335,11 @@ include a "From:" line in the body of the email (different from your
 envelope From:) that will give credit to the correct author; but again,
 that author's Signed-off-by: line is mandatory, with the same spelling.
 
+The name used with "Signed-off-by" does not need to be your legal name,
+nor birth name, nor appear on any government ID. It is the identity you
+choose to be known by in the community, but should not be anonymous,
+nor misrepresent whom you are.
+
 There are various tooling options for automatically adding these tags
 include using ``git commit -s`` or ``git format-patch -s``. For more
 information see `SubmittingPatches 1.12
diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
index d221b16bd5..70dec7d6ee 100755
--- a/.gitlab-ci.d/check-dco.py
+++ b/.gitlab-ci.d/check-dco.py
@@ -78,7 +78,10 @@
 
 To indicate acceptance of the DCO every commit must have a tag
 
-  Signed-off-by: REAL NAME <EMAIL>
+  Signed-off-by: YOUR NAME <EMAIL>
+
+where "YOUR NAME" is your commonly known identity in the context
+of the community.
 
 This can be achieved by passing the "-s" flag to the "git commit" command.
 
-- 
2.39.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52E9CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf4y-0001j4-Tj; Wed, 20 May 2026 07:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@9elements.com>)
 id 1wPf3z-0000qS-Km
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:26:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@9elements.com>)
 id 1wPf3s-0003lx-6K
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:26:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so1733161f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1779276361; x=1779881161; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lf3KASJOV92HjyIgUlj70uoKfquZBzI7Nc5bu+kBkVk=;
 b=cl59KJnTt0KO1VjgP8ddAy6Jyq5m3sLVHLkUgNRfu2gWkxqJAcbN0GxGs41dTJ1Czg
 VQff59TQnbKLhGUn9WUxqmSL0ULuXSpunRfOgKXxgq5CnVdcaN1oK40yjWm7A29ykw67
 0CiJbrN//AH0VYdWXDKtzS+wSathp7pzFDLab85rh+1zTpothID7cZ5ELgbaRZBxq8FO
 mjXDEks7lhjqA4IU5Bbdp5GbYCa5F1X9/9GNHTgJXOZ6dPN6laaNVY2PF7zFOktMKbT+
 eU5Pl5Td9IRNhc5LZZ06DLSHLiQagzVG9h/qopKT4jeaauT72tfKJx3TdJCuAXZjlNrS
 Ft4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276361; x=1779881161;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lf3KASJOV92HjyIgUlj70uoKfquZBzI7Nc5bu+kBkVk=;
 b=SGj8AghoH42LH8YTn2wtAzK5KKhutzP4vySlCANFugq8fWxITTGqqHVAvonOt7rZUP
 pmkkDOuVBXKCgwZUpBHQGbCRuftmVuQYs/LcNHbL4sVwubfVL+95v9J2n1Bo1cGh3KvW
 rt2NsFT8WQX86f9SpSpQB6CP820/FnXVxoog+XkB3xBd4nv8XrfT8xN1n4Eu7ra3BeGc
 zkQgTDJAtYaIvyNpHBnQVbY28JgKnfDw+d8oIXuPJoVfA3v7ybcbzQ6kM8Pwzg3BNla9
 OKd/L2xXFClUpO6BUULEHxjJUFzEXyHjWLVj+U9B2/w8tqq30RO9NB70RqtwUyZWDBJy
 efbQ==
X-Gm-Message-State: AOJu0YyiVZSsH8ZEvtJWHCGfGcHN9/LPA3jwlfaQ8aElVruHQt81evqy
 pHPSI1q4uNjYF3efHc0EqsTD40EOcASVXZ4F2BIVelRmrX8NJlhjvN/AsW6Fj9yUIS0qOjXH8Wf
 5LA1eyhr18w==
X-Gm-Gg: Acq92OF/DWqYy8cJGl+Ere+OmvmC0MwHJQ9UK1TufNTUserUe40L9/lwJNFhFoB607G
 HzqAx56wNzkUZ6mWzYNMJEBo2wyHKqaZN3nNtd5wQ7B1mONJTLIWeC4IZ+ST61sL15Otm9B/n9W
 kkQs+8ft5eS21ILKmLqvBzvDOr/WxJPc3a4xqeuUjTsGyypZT7TU+2WS05yhh7R2gDQKSiPPxRG
 5BAu3R21svTxkaIeDvkwYmRz3YM6u5IdBRO0C5vA59BpyfcIwMT8V1iRSV1CAdpfN8ZScgvY/3b
 JCE72UOZp0g0jVLONAyVoXriki6YPkPQzNsZ+ek8F70ZqfIEc8cG43lgTiGGvxszNpr7I4v46Km
 +0zPCPxGqhORrNeSabJ+iHVVMLxGka+cRMw6VMMdbpfb+Oa4QWGcpUZ49SVH5iUMBGUyiam+5Ai
 odVS6cir5+FldI6CkSqS+VaiCV+78YSXM0kGv7u+hrKMa1IbJ+8lmVNVtScUaAM7SD0OMzz20EJ
 q7ruOY1Fe0nphVYKKik73UP6g==
X-Received: by 2002:a05:6000:1845:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-45e5c587110mr36686191f8f.20.1779276360785; 
 Wed, 20 May 2026 04:26:00 -0700 (PDT)
Received: from [127.0.1.1]
 (2a0a-a54a-ed40-0-9db4-bb9-3f9b-5d0a.ipv6dyn.netcologne.de.
 [2a0a:a54a:ed40:0:9db4:bb9:3f9b:5d0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0f72sm56884432f8f.25.2026.05.20.04.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 04:26:00 -0700 (PDT)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>
Date: Wed, 20 May 2026 13:25:49 +0200
Subject: [PATCH] docs/code-provenance: Fix formatting of *-by tags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-prov-v1-1-7a58af334b9c@9elements.com>
X-B4-Tracking: v=1; b=H4sIADyaDWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMD3YKi/DJdc+NkM8tUk1RLc8tkJaDSgqLUtMwKsDHRsbW1AGtALdt
 WAAAA
X-Change-ID: 20260520-prov-73c69e4e979c
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779276360; l=3123;
 i=j.neuschaefer@9elements.com; s=20260513; h=from:subject:message-id;
 bh=I72F5Zy2uwMGcJa96sR/nZvgzFovgfK0zV/pNSZmXeo=;
 b=nkY/6Zlfjnl76aajNhmqIxH8dw+suqZv7XVJ/thDJo6op0HSQsjtsJSwA4oP3ffCPdzO4SvwV
 fAnOkwdjEu8B3Gtvppp3RdJaHdoClQWu/MJN0XPEN5U+anaSUFmRa6A
X-Developer-Key: i=j.neuschaefer@9elements.com; a=ed25519;
 pk=mytxDu9ALv0FsWdexvpDMisghxetVpsZ8NdmY/FGsgY=
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=j.neuschaefer@9elements.com; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Applying both ``code`` and **bold** formatting doesn't have the intended
outcome, instead Sphinx emits the backticks into the HTML.

Use only **bold** formatting to fix the HTML output.

Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
---
I'm fine with either solution, keeping the bold or code formatting, and I'll
switch to the other if requested. They just don't mix well.
---
 docs/devel/code-provenance.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 4e6a9afe0d672c544c069447a9978baa0b4a6212..65b8f232a08f6bc903c77fd0b1f7a5adad9fbe5d 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -99,13 +99,13 @@ Other commit tags
 While the ``Signed-off-by`` tag is mandatory, there are a number of other tags
 that are commonly used during QEMU development:
 
- * **``Reviewed-by``**: when a QEMU community member reviews a patch on the
+ * **Reviewed-by**: when a QEMU community member reviews a patch on the
    mailing list, if they consider the patch acceptable, they should send an
    email reply containing a ``Reviewed-by`` tag. Subsystem maintainers who
    review a patch should add this even if they are also adding their
    ``Signed-off-by`` to the same commit.
 
- * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch that
+ * **Acked-by**: when a QEMU subsystem maintainer approves a patch that
    touches their subsystem, but intends to allow a different maintainer to
    queue it and send a pull request, they would send a mail containing a
    ``Acked-by`` tag. Where a patch touches multiple subsystems, ``Acked-by``
@@ -113,18 +113,18 @@ that are commonly used during QEMU development:
    maintainer wants to indicate they have done a full review they should use
    a ``Reviewed-by`` tag.
 
- * **``Tested-by``**: when a QEMU community member has functionally tested the
+ * **Tested-by**: when a QEMU community member has functionally tested the
    behaviour of the patch in some manner, they should send an email reply
    containing a ``Tested-by`` tag.
 
- * **``Reported-by``**: when a QEMU community member reports a problem via the
+ * **Reported-by**: when a QEMU community member reports a problem via the
    mailing list, or some other informal channel that is not the issue tracker,
    it is good practice to credit them by including a ``Reported-by`` tag on
    any patch fixing the issue. When the problem is reported via the GitLab
    issue tracker, however, it is sufficient to just include a link to the
    issue.
 
- * **``Suggested-by``**: when a reviewer or other 3rd party makes non-trivial
+ * **Suggested-by**: when a reviewer or other 3rd party makes non-trivial
    suggestions for how to change a patch, it is good practice to credit them
    by including a ``Suggested-by`` tag.
 

---
base-commit: 6d17fd91f6cf88df5cb2205e578640d72605cc43
change-id: 20260520-prov-73c69e4e979c

Best regards,
-- 
J. Neuschäfer <j.neuschaefer@9elements.com>



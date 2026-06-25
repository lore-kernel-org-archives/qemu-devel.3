Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30E5CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 19:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcpe4-0001bb-MP; Thu, 25 Jun 2026 15:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wcpe2-0001bL-JB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:21:50 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wcpe1-0006Rr-0H
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 15:21:50 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c8584e80d59so95502a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782415307; x=1783020107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diWzBbTQHTYaigM28DCbI/5KBH8pHlvi2XM56QB4yhI=;
 b=Hgt+8iOmhht/kkk53FhB75VU4E+n2YiVySgdazHstYRYW2HUd1liZuyqChcWZd4BtA
 SQqCe64Dh+e4szlwff9ovCrYjXW0qDF3jHspqxwfoV8NH6nsWmmzMQWdBTiA2igIOiX2
 LZoT98kyq+5GMzuRSwS7q13O9iGmYc8bc3LbxgareeAKwlzv5U+sTld5CDDvw1uvJepJ
 Jko/uMImIWiWg8vtW6EpVtir9ZaAriiefukkJK4uS8wE/ALjcE/hZKf9RQT63Q/3vOG0
 NnU8j80TNqb+ozGztRypTYP7rMmi2DWu/nNBlBFYS0QxCDKlao/f3+izEknkYVplLDS4
 3PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782415307; x=1783020107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=diWzBbTQHTYaigM28DCbI/5KBH8pHlvi2XM56QB4yhI=;
 b=iE/4U8zwkNgabEaGg9ZNDLgr1YUZepvFO/CAfDmo5LJyEd+CoPQCtGcc+WjNCqBRY8
 BVFtH2+CgaUR/ijW91MsDVHXvMiE1nLLJs8YeD/CyMajk/5xkPyEiBNipBVai4GMYMll
 sNXvFyONkkKmufF9o5eCMwCj0rkBsadgzt2D/Y5Bcl9dkuL+UOqZMwFW8fsUFd4k9qiR
 0++kLuQc+f5K6U9kzT4MDTtSh39PSJhqzRic9y5lFFHGALj2Njmo52Xt7ZoHcWPthiTB
 OixsFzjp2H2TANIUjokBFVSJHt6GXPlW+cFiAtCtc6/EwwyitzoJnIO5AaNioE/T7DOf
 EJHg==
X-Gm-Message-State: AOJu0Yzysk7fpbJUViL3c5dqyeFNs5zzqlSYBItEF+RyXIWuvpTDHNw0
 RVCTu/58eMoBeAXk9RMRztDtGp5UDTqpgsEPl0QVXxdQiKTfXf+38o5h3weJZg==
X-Gm-Gg: AfdE7cld57gOW14rR0IXTqE3J1UgMoSzTntNqO+Y/9DjdDPDW1o2Qu6glmYjp2VfLMH
 V5pjObKdRonDd7cznU5ry9MkvagKi7e6ztq2RxnKEHPJprhplt46BsK6SYxcOZj/D5KWNHQwaDc
 +Fdes1A8wDqOCAKiaZETiAX5Ev8xIDpaTtaUcfuegKyLI4E2wTs3AiRUsmSFdXz5V2n2CO1L4DK
 9oVMflGJSQcXwk2hlahDn+mk3U48cXDgInM7mnl57/seofXZx5Ay7ReauqIei5IYA9fDi9GBs2X
 57XOQ3mhDMrLZEE3N/xVILE6jqa80TeYpgAKyForJFjMGgsxyiR5jq6ohOLE2UyHQBTYHLXvaWq
 HF14xwZe4l32BqerHirbS/Qs/jBTsutC36o0uGP7GNONuluU9ZHwCEyVeeIPBpqnwJ56cVQBQo1
 GuWip8ITKS5jhK9Dg188kmL8ehpneypW6jPfkEd2OBxA==
X-Received: by 2002:a05:6a21:998a:b0:3b3:f46:1efa with SMTP id
 adf61e73a8af0-3bd4afc7bd6mr4820325637.42.1782415306948; 
 Thu, 25 Jun 2026 12:21:46 -0700 (PDT)
Received: from localhost.localdomain ([103.171.172.198])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c92bc1e0a90sm2223492a12.15.2026.06.25.12.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:21:46 -0700 (PDT)
From: Linisha <linisha232@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 mjt@tls.msk.ru, philmd@mailo.com, berrange@redhat.com,
 Linisha <linisha232@gmail.com>
Subject: [PATCH v2] docs/system: add general note about architecture and
 machine differences
Date: Fri, 26 Jun 2026 00:51:19 +0530
Message-ID: <20260625192121.1887-1-linisha232@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20260623205839.1294-1-linisha232@gmail.com>
References: <20260623205839.1294-1-linisha232@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=linisha232@gmail.com; helo=mail-pg1-x536.google.com
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

Add a note near the start of the introduction explaining that QEMU options, properties, and command lines may differ between target architectures and machine types. This helps prevent confusion when examples shown for one architecture do not work for another, such as the pflash0/pflash1 options visible in -machine help on some machines but not others.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
Signed-off-by: Linisha <linisha232@gmail.com>
---

v2: Take a different approach based on review feedback from Daniel
    Berrangé and Peter Maydell. Instead of incorrectly claiming
    pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
    machines too), add a general note near the start of the introduction
    about how options, properties, and command lines may differ between
    target architectures and machine types.


 docs/system/introduction.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index bec7291e47..8d9ef61d26 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -1,6 +1,15 @@
 Introduction
 ============
 
+.. note::
+   QEMU supports many different target CPU architectures and many
+   different machine types for each architecture. Options, properties,
+   and command lines that work for one architecture or machine type
+   will not necessarily work on another. The examples shown in this
+   manual are specific to the architecture and machine type being
+   demonstrated. When in doubt, consult the documentation for your
+   specific target architecture and machine type.
+
 .. _Accelerators:
 
 Virtualisation Accelerators
-- 
2.47.0.windows.1



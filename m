Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A52C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 14:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s15UQ-0007Qt-Rs; Sun, 28 Apr 2024 10:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobbi.bugs@gmail.com>)
 id 1s13A2-0006z9-NA
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 07:57:41 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tobbi.bugs@gmail.com>)
 id 1s13A1-00009T-1E
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 07:57:38 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a55b93f5540so467910466b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714305453; x=1714910253; darn=nongnu.org;
 h=content-transfer-encoding:content-language:cc:to:subject:user-agent
 :mime-version:date:message-id:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=av4w8VW51NwifJPWYPQhMLKqJmvvBEIUeN2ZlYmFFy0=;
 b=QfIaviAs1M3ssDRFE0yCPhHz0pHW4zZ2ZGHzcONHPlXWmLwwd+dUXU+MqlRIpiCjox
 EVHIUvO++1EFNZj6g8GeGqBG7WKxKUeVtUo4m0aFmIQGZVzXnzBLtQPfWmaGWo8eFib+
 pIYF57+8CzKX8LL39Yuz4GR7r7ZlwAVVRHgi90Cus0xyWOqu8muwEyu/WdStx6+wUG/6
 UE8ybBoEXne7+b8fGsUAjp3TqmBXIIQctk7GRveacUaYw2wWz2w2ZxRen2VH5YvDAqUk
 T3qWBhP4JOxr9KdeWjiDuKizaFnRcT4/cin0jIrgV/ZyvsfevnsJClcHIvwofqtkPRh9
 d9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714305453; x=1714910253;
 h=content-transfer-encoding:content-language:cc:to:subject:user-agent
 :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=av4w8VW51NwifJPWYPQhMLKqJmvvBEIUeN2ZlYmFFy0=;
 b=kWnWcNnYO28/MDUn9QsP86ZcOx+98UnOta1X7k7mBqnWLz+BlLZlwOOBbeAkT2Pjkd
 dv9cL7WQVS66cRSGumiqOY8oV9r+2XV9kovw1sRp3k9w+0QmypgpUICDYSBmt1GZb6qW
 RDELAYDPUNTklrEgfdGc5vAXm62KwlVq1ZUQQJhu5wi+VAzNrUdWZjQ7Oe6eDbyZORp5
 Aj3Fos1g6jgqETcR8dEX+I6Q8NP+NXhkT3Id5Cs8AZLTa7yTLc5UcLnsMAgncZqQfrD7
 4t9SMYpCXJhtuel55RlGSPCx+lAmyG9hKZT1d1bc+5ZV4jzcN306RpzsDXEDFHHtw3m1
 /b9A==
X-Gm-Message-State: AOJu0YyiAHQCMFXb2hIgAT0JNBQ5SlVJ8OkzHAgY2Fay8Jp3PWpMv7FC
 1sMk2p925MXo0WnG+TssSNSlaMKjM9nvrWLFG4ixP4pw39ZUg9F8iDXH2Tqv
X-Google-Smtp-Source: AGHT+IFWjnWUWZJZOUcZ7zFSxIphvxJ9wdqS5eIN/20sxC5QJ8f2F8fzNx3Yk2i0YvsHkxHaFQX7GA==
X-Received: by 2002:a17:906:786:b0:a52:6cb2:9347 with SMTP id
 l6-20020a170906078600b00a526cb29347mr4272775ejc.8.1714305453300; 
 Sun, 28 Apr 2024 04:57:33 -0700 (PDT)
Received: from ?IPV6:2a02:8108:1240:48ec:e18d:6f53:c197:d6b0?
 ([2a02:8108:1240:48ec:e18d:6f53:c197:d6b0])
 by smtp.googlemail.com with ESMTPSA id
 h26-20020a17090619da00b00a588729de82sm5839376ejd.142.2024.04.28.04.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 04:57:32 -0700 (PDT)
From: Tobias Markus <tobbi.bugs@gmail.com>
X-Google-Original-From: Tobias Markus <tobbi.bugs@googlemail.com>
Message-ID: <fa98f79e-f682-4efc-9cfd-37a108b853b5@googlemail.com>
Date: Sun, 28 Apr 2024 13:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/1] Fix safeAreaInsets not being available on OS X 10.13
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com
Content-Language: de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=tobbi.bugs@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PDS_OTHER_BAD_TLD=1.874, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 28 Apr 2024 10:26:48 -0400
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

Hello,

to prefix this: I previously filed 
https://gitlab.com/qemu-project/qemu/-/issues/2314 for this compilation 
error and I'm quite aware that QEMU only supports the most recent two 
versions of Mac OS X by default. However, given the small change 
required for this to work, I hope you can make an exception and include 
the attached patch into QEMU.

It would really help me continue to run QEMU on my legacy MacOS X 10.13 
version.

Thanks in advance!

Kind regards,
Tobias Markus

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2314
Signed-off-by: Tobias Markus <tobbi.bugs@googlemail.com>
---
  ui/cocoa.m | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 25e0db9dd0..96992736ef 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -539,9 +539,11 @@ - (NSSize)fixAspectRatio:(NSSize)max
  - (NSSize) screenSafeAreaSize
  {
      NSSize size = [[[self window] screen] frame].size;
+#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_VERSION_14_0
      NSEdgeInsets insets = [[[self window] screen] safeAreaInsets];
      size.width -= insets.left + insets.right;
      size.height -= insets.top + insets.bottom;
+#endif
      return size;
  }

-- 
2.24.3 (Apple Git-128)



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFC8C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5U5-0005JZ-D6; Tue, 12 Mar 2024 13:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Tn-00052j-QA; Tue, 12 Mar 2024 12:59:57 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Tj-00081L-8o; Tue, 12 Mar 2024 12:59:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e6adc557f3so572407b3a.1; 
 Tue, 12 Mar 2024 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262789; x=1710867589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7kmXgqtdcMD9RJbt2RdUSSdzZ9tGHMF/tncpvYDkjQ=;
 b=CnQzzrw8BUsv8dgX3bl5Q+DMzDv2v8LmjwQL/ahLTxT71PIKdHpeIZn5iqnu9BRq6E
 jNeuQbVFtUya4d2JfS60EtFM8iff/sk+zev6RcQBLWvt/XDMkCO1dupo6STNgt3JPzaK
 nxpZCeZXshR5bD/7zGLyzrd/54PB2Wm1h4R6j1kTMweHU2X7yJRmQ8eParEIzOC5+R0Y
 NXqog4klTi6heqTSBznO5EksaxAttk7KqxR5o+KrpRKPQ3JsMyjs+qJkjo+8SEdd/clC
 sMhh0wTwfDT2T7pBaOxodir410mWb2AutSnPL1ZCMhYmcsXop9B97U8ShX0c/PsTlWhL
 wkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262789; x=1710867589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7kmXgqtdcMD9RJbt2RdUSSdzZ9tGHMF/tncpvYDkjQ=;
 b=lhvfgMNhFG1PwTp17S4cKV5aWwPmXbEudfwKhpee9rFbO6kSA43gEd8E2nn7XW0FEN
 GLaCgVpYZ/e7pZbhWTmbX8TnIjnNEoUSJKgUSfQ5xjluBFf3ZOZCTrGRV8vd3HMpEMpr
 qlKmi2rDGq6mxw5qfZEhMMd/YGTQSPbN11hagpDkKIX7qeL5MlrSJwAnIJj6fOLH9OQL
 KTR2ykpJrWJDJ/ZWJ9eInvoqv0X+lLIMaUIjX2wFzf5vNTYN2JKJgt1OYdByRdIsv9+2
 PBSYkKzMKcuVuuVK7ZbROFvu+8UN1L6PKjcNo8S6YpvXlzgd+K8bbEmwgfEAaec16u2h
 hf/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc/IrVQEvLV4GCVFpwNxItXJNhCDjJVcA3R8vaVTKaX6/bGorBLRE36cvxafl+WpoYyO1AmMkEb4j5tPzCfqfOwD2y
X-Gm-Message-State: AOJu0YzLGb4Zo4MQvfl2860dnuAu9bzkC2HqLuFl/Bu5U9Mxr8gwhIy5
 3hlUmpn6HTLMCW8OgGEDBTqjamOTMsbF4i/QFHIj86OqsQAZ8rONsXQPd2qSnv8=
X-Google-Smtp-Source: AGHT+IExJJzpys6WiWWedS4/RTEYMS7L60ZlSWHvW9TgnXeE2wvWKCq6ozj+BRzBAikBr9nZr+DLCg==
X-Received: by 2002:a05:6a20:9591:b0:1a3:2f5e:d4fb with SMTP id
 iu17-20020a056a20959100b001a32f5ed4fbmr716528pzb.61.1710262789198; 
 Tue, 12 Mar 2024 09:59:49 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/38] docs: Deprecate the pseries-2.12 machines
Date: Wed, 13 Mar 2024 02:58:24 +1000
Message-ID: <20240312165851.2240242-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

pSeries machines before 3.0 have complex migration back
compatibility code we'd like to get ride of. The last
one is 2.12, which is 6 years old. We just deprecated up
to the 2.11 machine in commit 1392617d35 ("spapr: Tag
pseries-2.1 - 2.11 machines as deprecated").
Take to opportunity to also deprecate the 2.12 machines.

Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/about/deprecated.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4fb86608e4..7b548519b5 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -237,13 +237,13 @@ The Nios II architecture is orphan.
 The machine is no longer in existence and has been long unmaintained
 in QEMU. This also holds for the TC51828 16MiB flash that it uses.
 
-``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
+``pseries-2.1`` up to ``pseries-2.12`` (since 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''
 
-Older pseries machines before version 2.12 have undergone many changes
+Older pseries machines before version 3.0 have undergone many changes
 to correct issues, mostly regarding migration compatibility. These are
 no longer maintained and removing them will make the code easier to
-read and maintain. Use versions 2.12 and above as a replacement.
+read and maintain. Use versions 3.0 and above as a replacement.
 
 Arm machines ``akita``, ``borzoi``, ``cheetah``, ``connex``, ``mainstone``, ``n800``, ``n810``, ``spitz``, ``terrier``, ``tosa``, ``verdex``, ``z2`` (since 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-- 
2.42.0



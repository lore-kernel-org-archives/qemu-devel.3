Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26230EB2711
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu7W-0005od-TX; Tue, 10 Feb 2026 15:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu7V-0005nj-G7
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:14:01 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu7T-0007na-Nw
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:14:01 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b4755f37c3eso2902060a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770754438; x=1771359238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uns7vUCLwr62MBErOAPukryvxRwaPsZ2c+g8wZ8a1iY=;
 b=a8t6EHFtFl1uR4u4V9BmDy7GIim89R0cCBagB2DsOqdto0rO08r/nveJeHTydVy6BP
 +DrckN/mmwfYLAuyRwUoL2X7iElSz1UKy/i48qACSWyd8692htfdmbei2vnb01+Y0efh
 n2NfFrXPje2cIweu65GCLrzDDLMfOJOId0JuX7fwOpSc7M9frsxx67qR9F3esOlHl2yE
 SX+Vs5+pIzLHXX7WpPh0uIlgDt08qKv+nRTV28pmHaQciyhDChYqap46tChxAv1SOm0Q
 oJ4Bpfz8Vwr3Ow1H+EeqOtzvYa+vA4CBgk+4skgZPkGpmXAISIdFO2KGviqCQbNbmvmC
 7CnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770754438; x=1771359238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uns7vUCLwr62MBErOAPukryvxRwaPsZ2c+g8wZ8a1iY=;
 b=M5gJujRl5NuqXdC5xMla5nojDlORV5l2ap5TvoZ4i3H7EvOrmaGHWvBa0okD9FhuW/
 HLezqf8bhwMH88/tS3ytfcremkqtj5E7NjIDcgbIo0PYHCYwtENxrsSTRqqc8wjaGPEs
 /LWKpdsytZZN7oIoBdctvBXk9w2B4hNEg8j8pEJSGvjssTiJNp1fbBqjcXiYhqoS3VeB
 SYxE9bsaFwscsUiD7Us/sE0CQN93zd0uTnZbFw7geiqyPWZuBPba4Q4Vso8azuotFNuW
 UcCsTh8+lYOzqs37eD9qxlJwr19BvYXZxjxKmuiSC28AfzAHMun9rn3vZiPTDDIrh0uJ
 E5WA==
X-Gm-Message-State: AOJu0YzdOzzLJoiVQrNKpbX2PUqTop2CU71ovdB/nHv9ziGMtP+IIQR1
 sQL/Ma+QiToX2gh8Rn/hxRSzHTvD+yq8bByTisuom/fpLYtjjNQcmrqNCBmNscquFRTuKJVZu+q
 /I648
X-Gm-Gg: AZuq6aK8s4ennWLKmsGrzsbMGvJ0Q3ipSJXMTChYOeuDN1n/9dYjMheslrdgk2FW8di
 aJJpz76CYsIEqY/mPBH3sfEFjT3nx4rZhu2yDxmvjaxDK+uwI/7EnyGO4ZJgU4Xm0eDsMBiw2UR
 x3TYX0cSomcCMkNzikUxtyl4g+9K+ITG2SUsuR6tTBIo72LMFqfXCYxWUcHI4sH/qsquUZryf+n
 fP2ZyIzrjxij0MiO7sdqZBTKsqwiOQpey70EFcBSnCBinAKIbr66qRUea+aAiCdHj6aFoonq4Qc
 eaNiyxje0CGlWPuaXFKThLLnDQ+zrOgOEaQh01urxiMKDOBtpPL2kyQFg5qb7tvAeK/I8t2QxSg
 rO9IT6ae135lc9OX3mK41vRjsg88LWnFz3/2ANPJuSPJZ6zKVLYq1W6ZnW+VsbjXAOeeulVUnfy
 v9atR+ogaj5WpZM0jEQBDmV+a3ydMCYSagfSh4jgE91THIF1YMYkyhJ+HM41mQiTLCkFUuWpFOY
 7dU
X-Received: by 2002:a05:6300:614a:b0:393:8fc:5291 with SMTP id
 adf61e73a8af0-3942e6ba5c2mr265571637.74.1770754438273; 
 Tue, 10 Feb 2026 12:13:58 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb5e3e8csm13930031a12.21.2026.02.10.12.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:13:57 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, alistair.francis@wdc.com,
 Mahmoud Mandour <ma.mandourr@gmail.com>, manos.pitsidianakis@linaro.org,
 philmd@linaro.org, anjo@rev.ng, brian.cain@oss.qualcomm.com
Subject: [PATCH 3/4] docs/about/emulation/uftrace: add info about automatic
 tracing
Date: Tue, 10 Feb 2026 12:13:43 -0800
Message-ID: <20260210201344.1403613-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
References: <20260210201344.1403613-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index e8793b0f9ce..f547e118eef 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -849,7 +849,7 @@ Symbols must be present in ELF binaries.
 It tracks the call stack (based on frame pointer analysis). Thus, your program
 and its dependencies must be compiled using ``-fno-omit-frame-pointer
 -mno-omit-leaf-frame-pointer``. In 2024, `Ubuntu and Fedora enabled it by
-default again on x64
+default again on 64-bit platforms
 <https://www.brendangregg.com/blog/2024-03-17/the-return-of-the-frame-pointers.html>`_.
 On aarch64, this is less of a problem, as they are usually part of the ABI,
 except for leaf functions. That's true for user space applications, but not
@@ -976,7 +976,7 @@ You can follow the exact same instructions for a x64 system, combining edk2,
 Linux, and Ubuntu, simply by switching to
 `x86_64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64>`_ branch.
 
-To build the system::
+To build and run the system::
 
     # Install dependencies
     $ sudo apt install -y podman qemu-user-static
@@ -988,7 +988,14 @@ To build the system::
     # system can be started using:
     $ ./run.sh /path/to/qemu-system-aarch64
 
-To generate a uftrace for a system boot from that::
+    # generate a uftrace for execution (collect symbols automatically)
+    $ ./trace.sh /path/to/qemu-system-aarch64
+    # show output log to read timestamps
+    $ cat uftrace.data/exec.log
+    # generate final trace (compressed) for perfetto
+    $ ./perfetto.sh <start_timestamp> <end_timestamp> ~/trace.gz
+
+To generate manually the same trace::
 
     # run true and poweroff the system
     $ env INIT=true ./run.sh path/to/qemu-system-aarch64 \
-- 
2.47.3



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D90D44C54
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOJ8-0003Z9-4K; Thu, 15 Jan 2026 09:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOJ6-0003Xu-7t
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:26:40 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOJ4-0004kN-F5
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:26:39 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so5586195e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 06:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768487196; x=1769091996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrIH/PkxdxhcCb21xCtkdaU8PJrncavs24FzlTPfmdw=;
 b=ypineUBwJfNdmjbEJbmaTZfr9SCdUNWx+/PmBqLftbWvG+yskC+jHUW15JNfwuNIgE
 zkWFpqoo31bHsciqvJ2+Xmm2fwhBLN3p/fMIE3L1kZkHZvGYxd7kqaCqkbIkIdedc/+n
 kZkOui8a0MdIA4mkBHdTTBJJl1GgELPiYd8zlsSqkr7/CfYYGMK00M+w+yGscmq+iRgu
 Sda9/CFkb9d6HmLPkXiw3XYepvZ6c8lPG3Eeg9exfGNLqCSd++hrLa7zjT/h19CzyMfM
 9KoHW/Bdip1fWHpF3lAAtu4OrOy9J4WBfFPKs3FUtIK8USYOSKzRpFG5fC0NerPieV58
 npQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487196; x=1769091996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MrIH/PkxdxhcCb21xCtkdaU8PJrncavs24FzlTPfmdw=;
 b=b92t/+LJGJ5QK+Dobt3ZOLHYQv6Eu9ykYo79NmqYPKzB5lCFaOOiZjgJB/2TxITsbw
 IAIAUYwzUgdSrLdm9ANjs9IAR4rjMnxvZh9UR3AegOqjD36ibkaJ4io6yCCAA0AbBfPT
 +TELX6um/oViufURSOcgbCbBkuitKVvKOu2IQA4zD8sEnvHWvTJzCw8ERypW/8f4Ru30
 jsyABobDU0BSxC9CjSuccamNYuJYb41hG2JAVNNQ0Ent2rjjSVgzoxNzt/CFSosVKlBq
 kMPCit9OCd5iRbjXRebXWdUldppIYEX05j2bn7zyl/BjBa2amBP54doO6g7hpLtEod0g
 J94g==
X-Gm-Message-State: AOJu0Yx/ZNwYvhX6Kbq6ZBkIGIDtXN1burMywxOb69a4neV6uShVTxJM
 imWQvOEzkzoFrfHk8RF1+aLGGk34kMAWjF2+9y9HjkqYrCk4+OLjc8piOvmmOis+ZkOiLv+vWAC
 fGoU1
X-Gm-Gg: AY/fxX4wfMHE5cmlJJTn5WnXc9Tu9vsAuoEBgPCWfJo/1NGPvC0RmPbm5SVdvey0rjp
 /6jDgPQlF32Vy0tyHKMzkBHgQ5P0/0XiRW1YLJHIL2ZXsUOqFxCfUfBIlUeaQMmHscw9HWdh+eR
 /yxy1pJDIXuxodPz1mKfzGvbCQadBstumJNvt0OSHsc3Gv6bIL+y+N1DguywD+DeaOwQevtdZiJ
 or8EQTVKsYK70g2BZZZZnPrJA0FCyrvhdhcQ1L9N032YqAxVhDK0REj3wWBrKuZNi9YqNUbsiRO
 fV9TB1b3HGNdOdAxtnbdMR9u7HvIwq9XB4M++S+CQJR+qWiy9ujWMkqDg1h9qVk9lRF4Px0yaYj
 UY15TwNgoTZ8vgNYykOCTSRFE2QRG/Z/5obOzORE4aLvXWXEcsy8Th7uxSN/OI/t7GDqqjLGUFQ
 Iz42ekU9wPeR3mSz8/YplBLPFw5JJExcsqeYUaB3ic6puWKZgS1gpP4vci/bMBlFwIbayJ5a8uO
 MLTOFaFWN2M8O0k5Q9VRsJavLMUVAJrmr52ZW6FJUwdFQ==
X-Received: by 2002:a05:600c:548c:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-47ee32e0c52mr73399235e9.6.1768487196218; 
 Thu, 15 Jan 2026 06:26:36 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2672d6sm50759435e9.14.2026.01.15.06.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 06:26:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 3/4] qemu-options.hx: Drop uses of @var
Date: Thu, 15 Jan 2026 14:26:28 +0000
Message-ID: <20260115142629.665319-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115142629.665319-1-peter.maydell@linaro.org>
References: <20260115142629.665319-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

A few entries in qemu-options.hx use the syntax "my-option=@var{name}"
when documenting an option that takes an argument. This syntax isn't
consistently used, and the documentation generation has no support for
it: it just appears literally in the HTML output.

Switch these uses to the more common "my-option=<name>". This also
doesn't have any particular support in the documentation generation
and so appears literally in the output, but it is a little less odd
looking to the end-user.

The other common pattern we have is "my-option=name" with no marking
at all that the right hand side of the '=' is not literal text;
using <> seems preferable to me, as it makes it more distinct from
cases where the right hand side is documenting that only certain
values are permitted, as in "my-option=on|off".

We don't change the uses of @var in the colo-compare documentation,
as that part deserves a slightly more wide-ranging overhaul that
is better in its own commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-options.hx | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ec92723f10..aca9dba8b9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -36,7 +36,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
-    "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
+    "                memory-encryption=<id> memory encryption object to use (default=none)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
     "                spcr=on|off controls ACPI SPCR support (default=on)\n"
 #ifdef CONFIG_POSIX
@@ -100,7 +100,7 @@ SRST
     ``nvdimm=on|off``
         Enables or disables NVDIMM support. The default is off.
 
-    ``memory-encryption=``
+    ``memory-encryption=<id>``
         Memory encryption object to use. The default is none.
 
     ``hmat=on|off``
@@ -180,7 +180,7 @@ SRST
 
             -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
 
-    ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
+    ``sgx-epc.0.memdev=<memid>,sgx-epc.0.node=<numaid>``
         Define an SGX EPC section.
 
     ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
@@ -4530,7 +4530,7 @@ DEF("compat", HAS_ARG, QEMU_OPTION_compat,
     "                Policy for handling unstable management interfaces\n",
     QEMU_ARCH_ALL)
 SRST
-``-compat [deprecated-input=@var{input-policy}][,deprecated-output=@var{output-policy}]``
+``-compat [deprecated-input=<input-policy>][,deprecated-output=<output-policy>]``
     Set policy for handling deprecated management interfaces (experimental):
 
     ``deprecated-input=accept`` (default)
@@ -4546,7 +4546,7 @@ SRST
 
     Limitation: covers only syntactic aspects of QMP.
 
-``-compat [unstable-input=@var{input-policy}][,unstable-output=@var{output-policy}]``
+``-compat [unstable-input=<input-policy>][,unstable-output=<output-policy>]``
     Set policy for handling unstable management interfaces (experimental):
 
     ``unstable-input=accept`` (default)
-- 
2.47.3



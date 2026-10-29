Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B224606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i5AoBAwL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSlD-0005ox-PV; Thu, 29 Oct 2026 12:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSko-0005dk-4i
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMSkk-0000Yb-1K
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:13:25 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so25965875e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793290398; x=1793895198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RnwAwIz+PsCxMjFEC+AJfTb2z+24LhPAg6xy8beKLlQ=;
 b=i5AoBAwLwZWNbzmyLkAVV1yN+Y9fI3ETYiVcPqQhHjU1SxwI3rCI1K3gLnvpCRNKGB
 lBfr4mLAtJIxL0bVK3iBpETMu7zKXgb93nz170w5yrgF6n4EgYYd3j9PL/6e7AlfPaQe
 2M1d2sPOLPbOUND1dNB/bzTgfKVRVAClRWhvBPH582lpm/lfHlADl0DsZFLhA/kC3nDM
 Iz6YbETgBYCQBqW4MmGKQxVs9vZ5APaNK9DYwOs/zO+EUaB+hBmMUx8yyZMmTRMMIy21
 tQDb7kXYTm7ufwC7e8Scywflm4ocUEbF3aMc334+2tcCpIfmdNpwvGNhup8DmUpELuDI
 9KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290398; x=1793895198;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RnwAwIz+PsCxMjFEC+AJfTb2z+24LhPAg6xy8beKLlQ=;
 b=ZPwJaOpkEO21hXqhAvFW1iJm0D9QYYXf2KpyXW0rovcpGji5qhezrXjYOIPDlWe6cj
 s0DPrvTLj50VZP8AEJfSAJ9oTOpT/GB/GrbCm4IiIK0PTFJYDb0vLfLuvptSCiXn5Ad0
 4Cf/q0Pjb8hlpgBXzW7GQdbleV5b3O5YIoyy30dlE+5YG+cxuw9JLBEeWmU6XWB8HtP4
 ZTCNtU6hWCpB7dUp6rYWarKVKURrtxI0IcfFXYvCChfLIO17zGazHD7T9G6ooQym/FD9
 qLrZs/w9UIt+QE97EfI3pc1dchUKP9tfZNnl9dDdsVLXFKuDPrh1tNDs9uFcOuVwCPnP
 56gg==
X-Gm-Message-State: AFq9FYI9lF/Y5VZ4ApadFMt6YwRMStAyx3zhp1u4rwKrzg3npx3l2Wnf
 HsBjvb1WvLhHNSQUqkdger2F8SZsAlSIgMeIG8/hvivowXuQ+5GBEi58OV7ZyVLdxus=
X-Gm-Gg: AYBFou1w/ITXHkzuO00tbHWlKSnLofpWerX+YgXdtPRa9bLoTB9UFfAFKJimOI3FimO
 NhOA0LseFLu+khi9QsGPdFuchIn05ndQiWyEADJbqatMLBIJ75KYbC8GoOesfYjX0tCBA/AE4y/
 BieaTAbIx/y9WN4JUY7N7nnLMDtI5I/cDqG7ZaJFGrFgwYcQxobnBiQ4ZUORSXHRY1gFaQ7dURz
 UImQ6X41d2F9979Aojqi+hYp/lNcIbC5fuJ7uVisNBRw8pG+GOn2cK50zzGcb5br15weiQaPhWL
 X4TKJKHHK9h3hFgKb82egW8Sy4bM7ELnyeEQg8NOoglc1ePc/0mUDMSDieYel7AQWNkq1wGrbjF
 J2TAQ/rJ5/a9InOvDh8G1Sh+Klmlbz3nMDDFuEg6CqFO+21cO+rt23q8sRpHcE3VrgK5GJLBpPT
 3/dJUjkX0gr5joqu+EpgCNHSQYPmk+iTTZh5wens3xsroGcxwUzgjScq3Q2l9Hjrf4C2NqPc2m2
 sDyFdFzn+06RYkZ9TPnpgpArOgesiMzKHtgu9Q/bVZqm+87v47HCU8LHOACEqZfC2SJBqwY9usg
 KNGgFM4uXxP4laTQw7SymckTyHP7
X-Received: by 2002:a05:600c:4f89:b0:4a2:1612:637a with SMTP id
 5b1f17b1804b1-4a966c4110fmr138745245e9.16.1793290398318; 
 Thu, 29 Oct 2026 09:13:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfca7d0sm59718f8f.59.2026.10.29.09.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:13:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E59D25FB60;
 Thu, 29 Oct 2026 16:13:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 7/8] tests/functional: remove @skipSlowTest from quanta_gsj
 test
Date: Thu, 29 Oct 2026 16:13:09 +0000
Message-ID: <20261029161310.2065290-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029161310.2065290-1-alex.bennee@linaro.org>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The full quanta_gsj test would have caught the regression caused by
the WFxT implementation and isn't that slow (<60s) it needs to be
gated.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/arm/test_quanta_gsj.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/functional/arm/test_quanta_gsj.py b/tests/functional/arm/test_quanta_gsj.py
index cb0545f7bfa..0c0f5d85874 100755
--- a/tests/functional/arm/test_quanta_gsj.py
+++ b/tests/functional/arm/test_quanta_gsj.py
@@ -30,7 +30,6 @@ class EmcraftSf2Machine(LinuxKernelTest):
          '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb'),
         '3249b2da787d4b9ad4e61f315b160abfceb87b5e1895a7ce898ce7f40c8d4045')
 
-    @skipSlowTest()
     def test_arm_quanta_gsj(self):
         self.set_machine('quanta-gsj')
         image_path = self.uncompress(self.ASSET_IMAGE, format='gz')
-- 
2.47.3



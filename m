Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5631ECA5FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSi-0001TJ-RB; Wed, 30 Sep 2026 12:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSS-0001CN-Sv
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:06 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSR-00033P-0Q
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:04 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48affb828f1so1033825f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786821; x=1791391621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1QNRedqYGyPzL6Ypuu1mQrHA3NbEFtuOcKMWfFPj6Ng=;
 b=aSroYiZRykUVMXd699g+lcKjUqKDA7jLEuRr3yoneeHSzk33K5IyqWaABxggm0p5wF
 3oZQMHEkS8ddLmIxWOuQOGVqIaOzxN6NbUL8a7Ezdy7iBrjEDhMvIdx+NSA2zfjuLjch
 NPM7ib9+E8HvQB5KszN+zIg8ceYuBWiACPeABmz9uDHSwSf735jDcC3Q3Mdn7NQFQIKo
 PUze6/yIoRPaVQzb+umL8q5pCslAyFCtYdzWmdAsvo04EBfP/4RFmKM+ura8I3s3J6ZN
 sfcLLKvILtlk0BXnJg97dSEpzGPfitFlr+XfRwhEMWHkVOvFpXQp2HNBBjsZ/xSiEkkH
 XKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786821; x=1791391621;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1QNRedqYGyPzL6Ypuu1mQrHA3NbEFtuOcKMWfFPj6Ng=;
 b=nN1I9VX8xtg628oJBpK8x5eAIM5HWsvC6FIBrEP6nrWmkG9zoa08aNkx8U0UqG5r91
 X65+/RVNi2E7ZMnrpnY7fP/OTRstm0BWkvvni8BI7t0zJ8XgfBZTA4s5U2yYoc/vT/mn
 DAHqBiHZLco2X6ZDPbqEn/LE6lFNXu08NG2ju3B0IKMrtqPS1qpXmnO2VSZXcwUZo4sc
 Nb5C8n+Oi/UipbFeLVOY2wZDs3zSkYqxpWriXqbRIu20BRp6eHFmtGrQ40Faasa80GUS
 bol9S2aqel4VdPgAzqCdQ0MKS8ChAmVbVSXgrmIU37t7NH2PB0hRzJKyidGdLjsL4qS2
 hOUw==
X-Gm-Message-State: AFuF++kv5E9qtl8Cre2vXRoNC3sHYard/ptUL4ATRlVslZzHri9Ps287
 5zs6GHDOwmIy1VtQC9AegqW0qWTghYZJYFMTy2Ut9b8dwB/bnEKUl2cOc28HQ2rNkPg=
X-Gm-Gg: AYBFou2GBnxb95VD8JgLSmpwN17yy8OqUhHJ/5m5mxDtKB8MpejQFfBRohF3nAjhP0W
 UBeDRUOy3LOmS+HLZdJxfvV6X0R9TUZvciAdfjQL1aBi0VjrOKw0d+vvvHPo/aveIU1ku2KTaqN
 ivPyAq7SU7i8jLXNUIoLrwEPMC2pEg2zL9A0uJy2H1Y9cI0ZW8ALvVv07mRHS7VpEO4+y3RBUpy
 QfefEFDRrU08wYYXayoBHUChBC2Z4scuMGmOLM2IkHT4SdLrl4guKEPnrF+Kb4kdQLjE+WBrV/y
 czLg+LmpYnpj8RjseKtU8x1DkqB0Ajhej1VyDUyj1QNFFDDYQLasjhy6lrkAXxmzzM6ytwIumBd
 RDWH5NqNce2Da2KQaBVa/z31IdsJMZq7uvIjpkNXSaLuvcCOoGzeXrFK5UgyazQ4ay0aL3uJJ1l
 U3UU2L4B7JYTDF7pvcTzEU6xEDJHPFCrRyLPDVP/098dJ3VxegvZrg0Pr0DMuT86DZbJxc8w==
X-Received: by 2002:a05:600c:3b1a:b0:49f:fe90:de63 with SMTP id
 5b1f17b1804b1-4a01b12cbb8mr35981125e9.28.1790786820781; 
 Wed, 30 Sep 2026 09:47:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01cd002bcsm24498565e9.4.2026.09.30.09.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 87A495FA65;
 Wed, 30 Sep 2026 17:46:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PATCH 08/13] tests/functional: split aarch64 tuxrun into tcg and kvm
 run
Date: Wed, 30 Sep 2026 17:46:44 +0100
Message-ID: <20260930164649.433573-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add an explicit "kvm" run to the tuxrun tests. Although running on an
aarch64 host would probably have defaulted to "kvm" anyway we want to
exercise specific features later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/aarch64/test_tuxrun.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
index 7dd50c3de17..3870be8b6e3 100755
--- a/tests/functional/aarch64/test_tuxrun.py
+++ b/tests/functional/aarch64/test_tuxrun.py
@@ -32,6 +32,16 @@ def test_arm64(self):
         self.common_tuxrun(kernel_asset=self.ASSET_ARM64_KERNEL,
                            rootfs_asset=self.ASSET_ARM64_ROOTFS)
 
+    def test_arm64_kvm(self):
+        self.set_machine('virt')
+        self.require_accelerator('kvm')
+        self.cpu='cortex-a57'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_ARM64_KERNEL,
+                           rootfs_asset=self.ASSET_ARM64_ROOTFS,
+                           accel="kvm")
+
     ASSET_ARM64BE_KERNEL = Asset(
         'https://storage.tuxboot.com/buildroot/20241119/arm64be/Image',
         'fd6af4f16689d17a2c24fe0053cc212edcdf77abdcaf301800b8d38fa9f6e109')
-- 
2.47.3



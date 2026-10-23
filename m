Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3172606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dEJKVan/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeT-0006m6-6W; Fri, 23 Oct 2026 14:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeL-0006fQ-S8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeK-0004YS-1H
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:53 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so1050412f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778750; x=1793383550; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WaqUj6WEGN6dVwMOoOZBYZN/P8vE1I0eY8vio88JriE=;
 b=dEJKVan/OoRC3xkMaPVBBPxKq70bI9dNzHOHLp59d2VU8gZQE8yGK3W5Nk/R2MzSUR
 NhLcacJkg0ofgJSg4cvu1HSg4hLWnrvkdPQpbfso52h8uueBXF+BypyyqYskTlKw2MQB
 BwVv2TAifanpHtLliu3fovnMxUpxwYvcuwTMpiTlW3nr4IKVLfcgfFsIaCsdOdiwWwFe
 0tRLjuDNl4B/DOGHOVOgseW9IUTbtTwQPbwehUl+1EvRFEEfycc1E41/yrjyL/ASQDDk
 094flsbYcdm4MiNk7CirO4BIIp5ivFH8mCuqxHqtNQ+6w56IbqYp5pDZPUO1rVs8cdZd
 owMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778750; x=1793383550;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WaqUj6WEGN6dVwMOoOZBYZN/P8vE1I0eY8vio88JriE=;
 b=hK1Ruy4FYCwI0k/duHAVc+pWwW7vjz/2c4lpYLXYt/0H9RexQvEBH5lvC1iwXTRsEl
 7ZqJ/4vglZXR3+DAX4vEYuCfFLczHIfB8uzVnhfTTIWN3OqhaA+ZerSjdlCXihohxcLf
 5cA7vkiWNRaEB1sbPVDJkdqiVNph2QjvxOGSXOqf5z9ZSS3yGYwuyjQBfS7Iz7MGtcJE
 MkLjb40YLDDcLAgueLFvdl3wI8e9hUdCwJm1EriOGM8TGw1x/pPrjUrfKQv1InO3MnKZ
 1nzt4MSkpvYtiATqYm2yg47Ux12nWOBsGJm1dPXWss5gtEfTKNL5m3eX8do74igAjXwf
 xxCA==
X-Gm-Message-State: AFq9FYLmO23Ea6usbCrwbS28Zz1Qep8m3dREGKo+ciCl7rA5DTIMhNSX
 pvBEANBG/SSlyTzFlbDsTMZD2rMlKXSk0zNXzlW108rukM93CitDoXiO2x09ZZYliGGqVx5w64K
 DON1p6Hk=
X-Gm-Gg: AYBFou0WHcacXYycildcp6qhfRT6qnVFLz1tXFWiceX3rd/bTYChHZAoMkhfl9V92n4
 2ocFu7Bo1OHWIKBavaLrc5ui59+HH3b+5zeCmHk+D3A4l+U6sbIE96W3H2Oat1Dx7Tm9TkCt2c4
 KIb0nSi6SDzNdffqfW+Kjz9ba5GMbKOBbBa7P8TRgarRD58hLS0sYXeaJ4Tp1TIGCD0T45gzlcc
 4fMLftpm2VbtqxhiIBDPIijxInf38nVNSXCdz6zC3AC8EkeeXRMJLXBT1ZmgiYMrqexoTkrI4xQ
 h3nq0Q88qX4YW0+asMR0OnBLsp47fMtqILTyaXQsBJA5jV2VKlBDDMtwcmpk/7COZ90DQwK4V2r
 z7oizvDIDcYrUhbjqVml26NhygWkBL1i0cPETZiShZnsqYpbCJqfLsGF9rpW6Sq9X2gklq2wf7k
 hUvt+xRgHlI+pZSfjGISbv6+q9ZQ1f0nywgIKuWQH0t8vpcxg9Y9fqXZtfB/gMv7WWgkGukzgo4
 qWJKrGgvYuOEyzMQnttyB3xmOTUdnM58DAdXwrFXXOopMS69NLyLFE=
X-Received: by 2002:a05:6000:26ca:b0:48a:f454:3d4 with SMTP id
 ffacd0b85a97d-48e385c07f9mr5076201f8f.53.1792778750540; 
 Fri, 23 Oct 2026 11:05:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d42f4bbsm1347760f8f.58.2026.10.23.11.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E93C661186;
 Fri, 23 Oct 2026 19:05:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 14/19] tests/functional: split aarch64 tuxrun into tcg and kvm
 run
Date: Fri, 23 Oct 2026 19:05:32 +0100
Message-ID: <20261023180539.1574134-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Add an explicit "kvm" run to the tuxrun tests. Although running on an
aarch64 host would probably have defaulted to "kvm" anyway we want to
exercise specific features later.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261019192704.3220373-15-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
index 7dd50c3de17..0ef1b126fae 100755
--- a/tests/functional/aarch64/test_tuxrun.py
+++ b/tests/functional/aarch64/test_tuxrun.py
@@ -32,6 +32,16 @@ def test_arm64(self):
         self.common_tuxrun(kernel_asset=self.ASSET_ARM64_KERNEL,
                            rootfs_asset=self.ASSET_ARM64_ROOTFS)
 
+    def test_arm64_kvm(self):
+        self.set_machine('virt')
+        self.require_accelerator('kvm')
+        self.cpu='host'
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



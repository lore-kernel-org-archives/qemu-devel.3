Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B067606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V0pd5iec
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt4A-0004tJ-PV; Mon, 19 Oct 2026 15:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt1E-0000cR-HN
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt1C-0003CC-9R
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:36 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1e3b87ac5so13368725e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792438052; x=1793042852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QhYHEO3ZxejazA6iXsRomgdAQi5gUE1y7/m+pzLUlNQ=;
 b=V0pd5iecEnsP4m4XhbAXGIgLyBQARbfzMvEQ7W1+dhqFxIFYDFZo/D+EQmYFvD+dLe
 GHdl8uh85ppjco7k6/qLjDkgOvkV0ia2iJUwNt8Xfh8Q/VOUgNuf1U5iJ/oLF33z93ZJ
 AY5UNra3yBBUni9wbGZFAPM4ogiE/mAutPcShvNuAqXStwC5FKI+7wKBe6WjewOvqnqV
 +pR8v2cIu6eaH76CLcy8Z4w5hRcnGsHavuaMTZJTmZYAnsZ2EhcXRuWN4noOvVJHncPg
 DzNmJCVrf/9yv+qr68uOOTzkMZbfky08fyr1KRSTDv/VAOxtcdXm1g9KkoyDsOXxURrj
 YFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438052; x=1793042852;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QhYHEO3ZxejazA6iXsRomgdAQi5gUE1y7/m+pzLUlNQ=;
 b=B3x6qT1rrLj5QYsX0gdZ6u0oKppvcQDPTz7qa5Grwz80+1euI0vn0+iXsus/7ZzFAm
 VGA7xB9M9cmn1BFVpgsoI7mZQE4suDPaEHZkZRYdamQTR4PkJhOK4q+rvCTYOYj9YqtN
 gYbPXO/7Zq3TBgOPFgntG0rDNDP42C4uigZDt/7JqZPYujqiJkcrvBKSFVmNIARzouE7
 Hie3IpjEPIwv7aWheum7XBm9lvMG5LhEbhpPNXY+0I2Nh/aXxzE2jY6QhuU1Mx9rpdWm
 Tym5O2a7QTB/sd4EwWXliKUMMLBjD4zrHMhhPYdkMhwSx86BHExwairlXbDmr6szKqvh
 ZS2g==
X-Gm-Message-State: AFq9FYKHs7WZlFU8zVqsy/fjiVRiB7vuNYpo8fGDc/hZNv0JCtVNP35A
 ZQl4jU0SYT5R6/OHtS7nW3IppBxurDyZAwY3J/m2hE6zzDWyf/9ecMFvY2cC0QJ7hHI=
X-Gm-Gg: AYBFou3lx2T8rHknM0VGN4a6HzM5I6GHuCIvnaIawl9BkZzCh1J2OphKCBVipLBbuUb
 3nuOvag5F7lF3+WqffsTULfPYPypeSYv7pWLXrSFrjsyCrGtwePyD40IfPoR35I6qsxenRzR8bD
 Y5MKwHfvBYEFSfDC0iic2Np7+m0ICghCueUrCBnFQicMmt4+PWHONUyeGLIR3zXsYdgHNE+FTnB
 PhGN6/ax3d0z/4m4JNLt4+SZaV+IabXKSDTIVnMV047UG57qB+t/AhY5I3cnwOfdmfsixFKWs7o
 z4uD7eSwnp2gG5wasLOdeH62SqAojAqfNZyEh57iqMDjzROAiG+crQBIhE/h2LeF+qQX2tvzpJI
 GUieCLURZKlwfUR1wO5+wRzSlaA0JFUWPHMqTOWeipQjS8qoOGOJCtA2BLz1S1yD7Y2m8MKHBOF
 ZKKm3JGsqFYcPDrOttS29gnj6GcCELtyFL6wi9ZQGn5THd6E/ZcEa9iABOK3qxscHjv9CpNA==
X-Received: by 2002:a05:600c:3488:b0:4a1:dbb7:bb44 with SMTP id
 5b1f17b1804b1-4a1dbb7bc9emr125319335e9.5.1792438052481; 
 Mon, 19 Oct 2026 12:27:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d6dc034sm827876f8f.3.2026.10.19.12.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:27:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BEAB65FF88;
 Mon, 19 Oct 2026 20:27:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>, Anders Roxell <anders.roxell@linaro.org>,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 17/19] tests/functional: split s390x tuxrun into tcg and
 kvm run
Date: Mon, 19 Oct 2026 20:27:02 +0100
Message-ID: <20261019192704.3220373-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019192704.3220373-1-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an explicit "kvm" run to the tuxrun tests. Although running on an
s390x host would probably have defaulted to "kvm" anyway we want to
exercise specific features later.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/s390x/test_tuxrun.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
index 8df3c6893b7..086466af81f 100755
--- a/tests/functional/s390x/test_tuxrun.py
+++ b/tests/functional/s390x/test_tuxrun.py
@@ -25,11 +25,22 @@ class TuxRunS390xTest(TuxRunBaselineTest):
 
     def test_s390(self):
         self.set_machine('s390-ccw-virtio')
+        self.require_accelerator('tcg')
         self.wait_for_shutdown=False
         self.common_tuxrun(kernel_asset=self.ASSET_S390X_KERNEL,
                            rootfs_asset=self.ASSET_S390X_ROOTFS,
                            drive="virtio-blk-ccw",
                            haltmsg="Requesting system halt")
 
+    def test_s390_kvm(self):
+        self.set_machine('s390-ccw-virtio')
+        self.require_accelerator('kvm')
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_S390X_KERNEL,
+                           rootfs_asset=self.ASSET_S390X_ROOTFS,
+                           drive="virtio-blk-ccw",
+                           haltmsg="Requesting system halt",
+                           accel="kvm")
+
 if __name__ == '__main__':
     TuxRunBaselineTest.main()
-- 
2.47.3



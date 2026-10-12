Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E493CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJSk-0006SC-Tx; Mon, 12 Oct 2026 13:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRS-0005FE-7d
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:05 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRL-00076V-R1
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:01 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48c4649b3aaso1254730f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824632; x=1792429432; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EPqkEo+REEQvki6c4nWZaj2y2OF71gOMMkGDiVxPDRA=;
 b=YfUScW2EkztQ7HkHNXP+1MD2DqQBw5ualw4X6blXAm15tgQ9UXLdGk0xRLc+f50FmE
 yHkCz4gxP59HqKPntMrkc7TsPsHt2uVu351Sh5kwdhNTI81gjy0MeXEE8u6VDfiYmfY1
 3P5igEHhuL1dvtJwblYjZ3Kjunh9xbFROBLovjH6ei81uFnfZPOucyA6tvaW8qhMKjM7
 kR5/bDTGL8wvO3CTUUoECcs2DNgB+pxJN1vXeA1Vq/z2l5gmEgFhcKwzw/1RI+uWg8eQ
 zQxwsyTRL5HMFaw21QYXK8FKNi6XkFpRNOoOwo6IJhQ4SUWvl+Gg5K0wdLq1y7akENpw
 KzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824632; x=1792429432;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EPqkEo+REEQvki6c4nWZaj2y2OF71gOMMkGDiVxPDRA=;
 b=TAKcmLrovl7qF/EJ1bdttl9SsZ2FtwEC7UFX5GuG57FEURA3bUTVRk0BKzPk/l6KzK
 UViMxp/Kqwxg+or4VxPp1jQ7uOv88IIsZrEyK40rDJe+pRjzQNvTGrDLx9kej7UvgAdE
 7CvZrSS+nLog3FQ/RTCueL9xBYUThqoDmLi7+WsPcltGv1iTmIAz0elXjtSgMUGeHQBc
 WxyFC0/vhKbOd9/Tyh7EtvvVKRN+3g1Mrrxq1Xt+GSuJrIz//dxng4mocAzJLx8+UzyS
 YIF4zxYGBdFMyr8IBFNViFYSLb4mXgxTDt8+sF8TdBpjnDThXVKvRPDfLFSuEnf7tARx
 pYPA==
X-Gm-Message-State: AFq9FYId97HNQeCNDa35FZwpLiP1o7zNuNlsEwGaIMwYTF5qEgYAPzpI
 cUYnihpXBaF9lGRwxDjR4qp4Luh8YhcF8qniY8kFHqQCut3KWWz7w5mnG7Eny1yz164=
X-Gm-Gg: AYBFou1vL4qjmFsMuwKB87M1O0Fs2mpkhXjrLHxREOpb/XbopS0EJegj39wLd7fa5QA
 M1Z9fLa1+UGz4xf/lQQ+Y0sMW64M1+3lcu2E79AfK0lqBY0g7nzv9oYZ6SNMMOu6rgGJ1mlKU3l
 35xrlxSS9qFEJKJ0ULLAqY0CBoQLnqCACWf0eKF1lE0zLaazpdFp62z+qlijb632WPEDhoJ2Tnn
 pw0Wp+05hkbIb+eX49BGSTTt7d/WCj3rqsRskWpQajtLAfKni5upN/1KWZx4d3SoGuqrP/Aad+2
 QQSd3kiKLbBZPc62AiLoy6g7vK7kp+Z6iQpNPCcE53tVnGq3Olj/ixDo6J8Swmog0lvMucYEWrx
 vaD+EcBES7rLbDkHpVzELbnARQ44GJidipO4gWejq+TnrOeV+JHQ6/zmt9qCT54PJrJkTyy8wjV
 tfv6FSjBWlD+P3kQLYXf00pejqgSq81tAA1D3IJlpcxMgDgvpXc7mRlQgwUnLFkktRDRMPTVc=
X-Received: by 2002:a05:6000:22c9:b0:48d:cbf4:6df3 with SMTP id
 ffacd0b85a97d-48dcbf46ebbmr11655127f8f.25.1791824631995; 
 Mon, 12 Oct 2026 10:03:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac3ac5sm454124f8f.38.2026.10.12.10.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 86D215FA3D;
 Mon, 12 Oct 2026 18:03:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 05/16] tests/functional: split x86_64 tuxrun into tcg and
 kvm run
Date: Mon, 12 Oct 2026 18:03:19 +0100
Message-ID: <20261012170330.1144446-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
x86_64 host would probably have defaulted to "kvm" anyway we want to
exercise specific features later.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260930164649.433573-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_tuxrun.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index fcbc62b1b0f..729f6447d05 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -24,13 +24,28 @@ class TuxRunX86Test(TuxRunBaselineTest):
         '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
 
     def test_x86_64(self):
+        self.require_accelerator("tcg")
+
+        self.set_machine('q35')
+        self.cpu="Nehalem"
+        self.root='sda'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_X86_64_KERNEL,
+                           rootfs_asset=self.ASSET_X86_64_ROOTFS,
+                           drive="driver=ide-hd,bus=ide.0,unit=0",
+                           accel="tcg")
+
+    def test_x86_64_kvm(self):
+        self.require_accelerator("kvm")
+
         self.set_machine('q35')
         self.cpu="Nehalem"
         self.root='sda'
         self.wait_for_shutdown=False
         self.common_tuxrun(kernel_asset=self.ASSET_X86_64_KERNEL,
                            rootfs_asset=self.ASSET_X86_64_ROOTFS,
-                           drive="driver=ide-hd,bus=ide.0,unit=0")
+                           drive="driver=ide-hd,bus=ide.0,unit=0",
+                           accel="kvm")
 
 if __name__ == '__main__':
     TuxRunBaselineTest.main()
-- 
2.47.3



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185F606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jSAcd0n0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJeN-0006h6-VW; Fri, 23 Oct 2026 14:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeG-0006aP-7J
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xKJeE-0004Wo-Ig
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 14:05:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso12537635e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792778745; x=1793383545; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bVulna2+DOgaginRZ6d/WpWDJZyclxhZ+uRx8ClW14I=;
 b=jSAcd0n0mOxZ1eCr1t/qm3LlfnK+5U9yA54pjbY3cHQEpI59+e0Af570q6TH0UHDG3
 WdeMomHccaPeYvduF4Iwsc7lsRQ3NFoWj18VksXO1X0m0/llLekwRCKfdla2qyK0hoSY
 ePHy17uxB/t60QwXO9Q/lpuiqehSdRdYevWBfqAmV6/BGrtOXAzYIjtMXiKbASHHQkYY
 b6ApVfM1A3sfMcvnaisbhgMjQRJMXrMKoTAlNeXylLuSUZQcbcapbeFFr8/E2R5TcBM1
 0zrV9AOIiaan9SRy8NRqbpvKVCNXKL8jrHjomwxLs9cQ07Xk3AVZWQYGz0J5kDZfoGBj
 L9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778745; x=1793383545;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bVulna2+DOgaginRZ6d/WpWDJZyclxhZ+uRx8ClW14I=;
 b=x9mSAjO5wTIg0op0RXaB3ozHy52jQXOSQrKu51dR+U7kBAQFMBPLuyMhwtRlwYS9Zw
 LvRb6eGJpyo1OKrates8mAzhYnlCpjb34cz//cOnuaNHf+jHHertVkuIXvX9VIISZyJU
 OmymVF2GVTpPxyHck+XQN3LfvMmK9m9u0JlNpHeEOjKXHG3wmBlBsc8qvxmY69Vn3J6I
 uC2vDAN57nYMQmlBy0KCjq+wNm75jOL7V+JLejA9rsEc0L//D+5gICdOFKZaXYrRWgLV
 ug8n9Pkfw9g8HhbzJ3JgLcH8kWrnxqwIMIMzE5RoJez4UQzilgneWAV48FqhB/ZKi9Oi
 c6fQ==
X-Gm-Message-State: AFq9FYI3fzOqgiafH5ObvCg/5TUSl2IQPEBsiUUWmSL46gYtwoT+uSwz
 iudNCOHDLmbKARpZAXEZMAEagfkOqx8nN0+rAmnHouX34eYiUAtSF8t/mq9iWBSKwvY=
X-Gm-Gg: AYBFou1rI/pmf6Wiy5CePFRmfDktFThii+t+jHEbFd3T1pI2x1Csg3R5ZgMrU6hrXoM
 5tfbxVqZfJnTnBjLjZkJOrYQy2eGMbuG7NaAwUPJb1t/tScWwi56q/31NzcpSDxyduafpNFKYM1
 dsf9hZPz51W6p2zZnesQ1N/dfxTcDeaFEst90Aj1sTFPx4Iwq9youxm3K3GzYdyMaVRh6Oqts+h
 Kv2gBXVWKCTYVwPVRLV5ba6Fl5enW32hEpc3ZJyDWefyyFOft6kbM1vXOZmMc1tHlK9K7LTfxKJ
 sEGs4NkZ/bRhlT7JoCpNq9X62dZuoPkMIh3Vh2gtCkgxPKVTFRluu8UNUYOhjnFTSOTtOGAS7AA
 7KNx6XWZL8ClTGToujuOX5r35KTa3HghiZqUHroekrVrgFVXUNhWmxPH4xtaVbTuuhKuUiIQTeB
 kIUqSkWH8aBMUl1CM7uawJ3EtBxeddOG3kx7f123HrN2KTmcWTTRKcs+calouic7XR2Ylj8zwoW
 3kJQNU26jmLm00GTuMS0MwvAbG50Up9kzp6k/Ab2OeRI8+S8O6jI14R
X-Received: by 2002:a05:600d:82e3:b0:4a2:8c5:5e5 with SMTP id
 5b1f17b1804b1-4a211caf98cmr58751715e9.7.1792778744884; 
 Fri, 23 Oct 2026 11:05:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2b0637460sm20746325e9.8.2026.10.23.11.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 11:05:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 27B9960F38;
 Fri, 23 Oct 2026 19:05:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/19] tests/functional: update x86_64 tuxrun images
Date: Fri, 23 Oct 2026 19:05:25 +0100
Message-ID: <20261023180539.1574134-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023180539.1574134-1-alex.bennee@linaro.org>
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

We now split the fetching of the buildroot image from the kernel
itself. This is because we will want to access additional metadata in
future tests.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261019192704.3220373-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index 729f6447d05..026b373accb 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunX86Test(TuxRunBaselineTest):
 
     ASSET_X86_64_KERNEL = Asset(
-        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzImage',
-        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed5aef8')
+        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
+        '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552b')
     ASSET_X86_64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootfs.ext4.zst',
-        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
+        'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ext4.zst',
+        '8e310455b0244414ccff29c507f7ccfd4032e3587cc405e49ab0322738e3e27c')
 
     def test_x86_64(self):
         self.require_accelerator("tcg")
-- 
2.47.3



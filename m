Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B095606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n0AGh9Da
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt1S-0000j8-QA; Mon, 19 Oct 2026 15:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt0z-0000T7-RD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xIt0x-00035G-KR
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:27:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so13637615e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792438036; x=1793042836; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iXTLXKXswaoS8fK2iy7Al3ZjuS4aIMD3U9wC6kd44r8=;
 b=n0AGh9DaoCOQCYAZWet0okFe+4EGsCdwmJfg9HVQcf9OcvHeMIw6nAZo4ho9CgEOuj
 SR9kaxVfvFBb9VmXNvddclVI9s4O/U6NJVzvbPl9L6kbNoMS012MJKzvlNyU81H9sRuR
 IUNGOCsxvR7Tm6Br1jDdV+KwyErMFsSDLPram7o6iZ9n8Xz94n+8kga/VwcBgDJMLejw
 v92jxI0zcker3Hzvi9pLs3vk5BPoEN4z4b75tD8Y+nPr7ijJa+p+lRiuVuDU9uVM/3ZM
 tNJDJ7rhDyzITlxERNV3/fvDFM18fqs574pa4ZiF9LYWUwDpZCtRrrWBC85HSkcYAl/1
 YFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792438036; x=1793042836;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iXTLXKXswaoS8fK2iy7Al3ZjuS4aIMD3U9wC6kd44r8=;
 b=usUCYliNb1hrn8WqHsXHD4Hc4/4JuQxPB14QoYrO0mbEu5AiIr/F8vjm5vidIx6K1o
 1eI5Uncarv9D3Tv/1lKqjE9v5zf6M2raCcKxc9NPCQHHWdZc1HaZyS6VJq0L8VYS7bUJ
 IWyhm4pWvquw6ucDcBVlJ09Ilmi6jeHA9rGNRvAUENDcJoqCFMIwLH8JkKyebDETVNvQ
 gcZmGW9UqqESRZzRXuzcLrZ/Sk/na5cY1kiORlfzSATNaEBk1t0N9+JgI4YKNjwFwzGf
 ezcgHU4KsiZ8v9LQ5uijIFFZQxrI/VQqlnxtki5Rnzw0wJBfYfySm/Cx8c4pLmRiFzcg
 C5Hg==
X-Gm-Message-State: AFq9FYLOsdONdIksqY1nrtgfsGJa8XeT+r1tRnZ1GoLAbvE07IektcS5
 CG5c/YHLI/WGo/QEN5Ae19SbZvbG39ygsV0vakKnmxA3LpzO6bTaJqRLcvhYWRbvuuo=
X-Gm-Gg: AYBFou3p7ZFw4dDRbiall08quXg/2xofq+3q2efkgutF+z8Jm3O/IKS8eCK9JNOAWee
 P7RVVAXOVlodk6knBgaAr4lRq+oqPFR7BCr/RpWhJ+6ByGhNJa1EwqvGx8TxN/ewjS9KHQJEGn2
 DuR7MgkrsF3+rzINLMpgZL3LwqMckzb8HKGO9P1ytCdDEpip9HCrRLTiUtP+X6QUs4HFHRDhS2Y
 R5teR5E1rZYLjlbG6MO398qlwVvtgmLTFaN/16kdBok7WGAy2K/QMBh1U7nGQUpwe53cw75Eyvk
 +UBrcUb95Yfm5hd5Hlno6KVyCCzCeY4cRmMK1a8945CY/QBfeIYvdDQLDHG5VLHxKqnnE8QXGZh
 9SORsQIhNtYKy4jmg1EkChu6ZgoZFVIhd7QgF7c6lojukqFP/1rjKgGjfoTsSPZqRyL8/0lvmAL
 VWjAg4O6ToncE1m/rvQSD2um+LQQBGnDylBDya4ZaqpVyiZEsXCsyM8VNLsrhGmxZMj2gd/g==
X-Received: by 2002:a05:600c:1f86:b0:4a1:93fd:8f8 with SMTP id
 5b1f17b1804b1-4a1d75ab363mr195854185e9.4.1792438036190; 
 Mon, 19 Oct 2026 12:27:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce33ad3fsm249105425e9.5.2026.10.19.12.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:27:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BAC905FACD;
 Mon, 19 Oct 2026 20:27:05 +0100 (BST)
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
Subject: [PATCH v3 07/19] tests/functional: update x86_64 tuxrun images
Date: Mon, 19 Oct 2026 20:26:52 +0100
Message-ID: <20261019192704.3220373-8-alex.bennee@linaro.org>
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

We now split the fetching of the buildroot image from the kernel
itself. This is because we will want to access additional metadata in
future tests.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260930164649.433573-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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



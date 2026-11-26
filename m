Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A35606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qevHfF9B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWejm-00005G-UQ; Thu, 26 Nov 2026 14:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej9-000831-G3
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:55 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej2-0005DB-RB
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:48 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c4322d310e7so250499266b.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719703; x=1796324503; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4bwALAOugqP+6U/jBDmD5iA4eEaAn9l9Xu/KF4OZNqE=;
 b=qevHfF9BPJ824Hux025OccEtWvLNX6gyA8sVNgrOeg5hSt6UK5WlqmuSnh7fL9CS79
 QQVOwKHaRZfhI10fYTezp/JYgBvMmCzrqSPOTANdLKw4fGkhIeaygqDaZI/iwD/PFT2N
 jXwf1PUM02QCBS54LVIEk43vBuIZsVH+zLkSKhvlcM0jSn5/Y6PGmjpR2zc/J7mPJ7Ae
 6uRmkz8CkSHQ2PXprta89Fg1StxLRmiRTzKEspdUbxZdIRLVLu/mWOmq25LjOiJxJkWg
 cYrqQYUe9I4lSR/XmIJVzIHAE/jzBKAfbBByaXf6JSv/tBAzm4D2VPpYGLVjiJ9Cd2km
 WUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719703; x=1796324503;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4bwALAOugqP+6U/jBDmD5iA4eEaAn9l9Xu/KF4OZNqE=;
 b=VLfoh03dJuuh8rszWnqzfGHqAzrkXIaqVfqQYtYfFBofe/LEMqaOr6zkT9q78IsiMi
 0zVERYEk+zlwuE2oRNy0YmjW7U1tZlrhBFesJvCXVQMUl40O3IBocdnigaIE6PFfB8V1
 pgUjty9Zg8cRmDJsggNZ3OdYIyV6nr4troLL85U9smdiEipCSe75TOky0EiL712CJa0j
 tNEwzbGtDdxQxiqR8CN71tbp/vD1+LRKrleReysp5I0NuTs6wxGLFHwkr+xSozIlSntn
 uNLK8JYPwAoiXANbqLm35Q3LWiTvqQ/z19UAWQ8WRW6REBywzksaK5i7LDdOGXzFq0gY
 Co/Q==
X-Gm-Message-State: APuU4Z/pFhQ0P4D5nDzA2dWEouZUh5k0fNwao7FP0CRYqOeKyQ/ysdov
 QYk9MSyW8TXbf57gL5jzYPfqpO/+MY0c0dt3/ZTqkxT9eMHVSu7RnZXLI/ZngivDtwY=
X-Gm-Gg: AZFdTZdQCFRAetrinesoqXFWHfYpuBvsph8TdiZ6VlmXOJjxLeDIFevnXufFWRpZBif
 0AjhjZq8oKHSxAnWCHug92IfLY39ElyeC25DraFA82/lEmAXjJW/oqx1ZjkHV7L8xVvVg6VJs83
 DIVqHCv+8+uLKh25bChnH+r4xYR3WqXQMtFlTFytSt8YYB5waGOERNhQ5/NNmcrH7c2BaKlOG0R
 LyFK1FnCRmH1klZgVXcuGQNBo+lNsFlnXNUJ+roCdtMhK/5IcdPka4X1iFdpdCGI1j7ds6GHtZh
 omDrgHJ+ySBpCSX1ecSQEDidUewbI3Op8Az+IO6YToPFbgXToDYuUrpqd/m3sb1wgsv504KyxXS
 rJrdG8u6e/mfIGSJfOct+ZHnPv+HNlDmE7pG56aXuyCaXCuf0Sptq4vMafHX3e9SNAIokBLz3Aa
 r3VZsDjm/wKq2ziTh1CQmVF2skQa5rtA2ewrXGtEyS4vBtzT40j3zjQG5uJQdDI40Dh+DQO0NhR
 T0Mq9uCZsnx+J1EbA3RQfNb6wunQy67J2w20Qr2i2WVsMwmiV9V+QedvwOS6CPC6Bzd9Ioi/0LD
 Vuuwqokjm6TMDVbMqudO9q1BjwJiT+EC5Cbp
X-Received: by 2002:a17:906:c10f:b0:c51:b21d:72f4 with SMTP id
 a640c23a62f3a-c51b21d76b4mr525042366b.36.1795719702900; 
 Thu, 26 Nov 2026 11:01:42 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:42 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3 05/10] iotests: skip preallocation tests if not supported
Date: Thu, 26 Nov 2026 20:00:48 +0100
Message-ID: <20261126190054.40844-6-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126190054.40844-1-bogorodskiy@gmail.com>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Skip preallocation tests requiring efficient zero writes if
not supported. Support is detected by probing
"qemu-io write -z -n".

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/298 | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index f2b94077f4..869bdb3242 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -18,6 +18,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
+import errno
 import os
 import iotests
 
@@ -32,6 +33,15 @@ drive_opts = f'node-name=disk,driver={iotests.imgfmt},' \
 
 class TestPreallocateBase(iotests.QMPTestCase):
     def setUp(self):
+        with iotests.FilePath('zero-probe.raw') as probe_path:
+            iotests.qemu_img_create('-f', 'raw', probe_path, '1M')
+            ret = iotests.qemu_io('-f', 'raw', '-c', 'write -z -n -q 0 1M',
+                                  probe_path, check=False)
+            if ret.returncode != 0:
+                if os.strerror(errno.ENOTSUP) in ret.stdout:
+                    self.case_skip("File backend does not support "
+                                   "efficient zero writes")
+            self.assertEqual(ret.returncode, 0, ret.stdout)
         iotests.qemu_img_create('-f', iotests.imgfmt, disk, str(10 * MiB))
 
     def tearDown(self):
-- 
2.56.0



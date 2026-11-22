Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8B606A684
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kMTxGWw/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVAmI-0002Q0-BH; Sun, 22 Nov 2026 11:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAlH-0001ox-Ko
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:57 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl3-0001WI-KJ
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:43 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c4cac7a7d3cso353115066b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 08:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366180; x=1795970980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7pWXzUEZT2SSH63tSYhSY5NZTKqRIcACwALgN3DUZ+c=;
 b=kMTxGWw/1YIr3AJv+Fr9N+elnvdTUlddV1vvPj28MJwGxkmvTLLwsHY3yq5aPghrEd
 3J0tC4oJOGHjxHPkybuLEglPc2NCKPVKB8BggKbMT0eUR0CAkkDF/2xmtWmDF3LEbVLa
 p0nHdGR1P5gDBbRoQO9nmEI62WuDZG79i5OD6VwvZkmRUVh6BtqC7B35zVucO3l7bQ1j
 7YXY0uCqDsw1+PBVnY76LyO8AeXikPoWtjEz/ANW7n8Fp3e7hFAw5o8nhVe8HD4u3OJ4
 dJWa4Ye3Td8y6x0OW0dADoLZWAl2ctmTFy+/P22SjLmKR5Y9V67psh8iron0Rg3BWEqX
 Edyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366180; x=1795970980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7pWXzUEZT2SSH63tSYhSY5NZTKqRIcACwALgN3DUZ+c=;
 b=i3CmBnvhH2kDNPNGF7cP5BVlTGy+Okq5fPjSbRmsoBURz1dVt30/MofEytSHVv3ioo
 u1e4TTvu45iZeGVQX8XPBDalrrcppewb1QID85m1UxX5uuhK2Ry8SD1XZmBs04U4yv+d
 ROD3hErXUMOl0xUq9Bk8vE1VyDOiHRocHpmwQjAB6wOn2j/s8q76cIbKeN5tBmnGCajS
 2x8Ab/dJoJuEfeFgyLWZt2ul4eqpVyy+zmCZDDgKovCbYe1IXfyQ31mevK3JZjV7+zyV
 nnCDYfyiURB4kBlWnLso2woBCxO/h+7yjX/KE0I4wxHJLfz5rir8KYBVf5mp2x9yj3QO
 86CQ==
X-Gm-Message-State: APuU4Z9iTKeKUZhw1LvVcu5UNxFht/y92nsrMIMhdclJSDbnvRzmtMZ4
 PEwAZ7H1ftvXEzjfQ0x7MBEFJ2rPQptnJejjbAoFqyXd5syzAuxJQp+o/sbrbw815Tc=
X-Gm-Gg: AZFdTZeTaBgy7iz51y0ipi4G90/ddn+f0bdDjD/XHiTM9OIJ/mRRGYgpWUKhW8ERmTZ
 iGlJJVSJ/MvhjsK19bdUFMkbdsGyBC83Rwy9Xrk6tKXS22NnTZrOvypdf2Xe5kVmMd45fCbI1LV
 p71SgcqKLQXL0eQCz4fIfnh5lUtyCZ8nYrM/NcbYMvJe8/G/wbaBN/7PRcFxFVi7p6yEU+R/GBO
 N4LxqMpzxfChLepjcTa8m9436LUBzqT8zgIbgEl3qFq6BOD48AFyBeaSwBYCIdsUNsFax7kOjBY
 3APgSaoAdcCJMNZuMKqfmeLtFXSs3s8AHYkvn/pZcKZZf4MiYAaslfKGiRXoKDbss55IsK0e5L+
 +VNxYRdw94tlIn0ZGm0bGeuhtxyA5djraerlu09O/PrFf4ruAphlzlee98j/cDGpGw64PJh94JE
 0OIVCB1mC8ZdtCqFMJtotLEmNyJ6PFqffLpTVLkDW+dvXZsKm6djNmG8KMa02sgdZsGnsTlDJsC
 u1g0EoJwYaluNqL6Wil67nPT2SR7b1Uw2sPfmupfah1CXm38/hPmNm+vRuYCMSmTL3htp5b2plb
 T681UXapDozbdmTbZuH7wjID1RhxPm/FVR8WZRMN2AqJkmMHOw4N20f73KX4SQAijJYDRqXJLOY
 q63Ci8ht17snn5YKHc1mr0tg90ISnlyqx99b1if0=
X-Received: by 2002:a17:907:a712:b0:c4d:a05:a2e4 with SMTP id
 a640c23a62f3a-c513a9ae26fmr688826566b.20.1795366179855; 
 Sun, 22 Nov 2026 08:49:39 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2455sm325303166b.57.2026.11.22.08.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:49:39 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 05/10] iotests: skip preallocation tests if not supported
Date: Sun, 22 Nov 2026 17:49:00 +0100
Message-ID: <20261122164905.59680-6-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122164905.59680-1-bogorodskiy@gmail.com>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Skip preallocation tests requiring efficient zero writes if
not supported. Support is detected by probing
"qemu-io write -z -n".

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
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



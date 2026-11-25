Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B487606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nx2WQnNH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIVl-0001ig-25; Wed, 25 Nov 2026 14:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV3-0001Yz-TS
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:50 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIUz-0002Fi-UZ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:48 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c5133831027so879187266b.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634264; x=1796239064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7pWXzUEZT2SSH63tSYhSY5NZTKqRIcACwALgN3DUZ+c=;
 b=nx2WQnNH9lLRwdmQHAkL6ZbUAn4RMh7l7R2EuVsXDPTCbzWKELVJBM1p2D8ppbIyDU
 cVhbDREc4pKLmr4sMsNkh24ZSIQ2AZw2kdF0dDPwycq4Bf1qzGFgVA2LYFbqgI/524ux
 xHa5fxK804NXXmen3Lt43vX36qaTeWovzge/Kk50cI+B+pzSd8xkFnh58t/nJUNgueg6
 6dKMJEOvTpJoKvUa59FPFg/Z9Vgjh01+nNFeA+Xqk4zIWrjhDCltYAgpybL7cwxR63L4
 u2Yf53XEHpXhlCA2pTLBO4wlBAB2Ox2mTQdekCCXUSzXLEsCSBJmTrlB1h4Nee9ydZoU
 zGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634264; x=1796239064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7pWXzUEZT2SSH63tSYhSY5NZTKqRIcACwALgN3DUZ+c=;
 b=j+cbGYYh99pa8/vYtaimKHZKIg3d5ns9iX9kZFekdVd9U/I8U8qVtxk0krlwio6D74
 uLfYrO/P3zr6oY9AtMwb/15U3+Gv9nWX0wdu3DR3SAmjcZzaynkbxzI9d1cVrGUoORtP
 lt2cS2vSlQRqgS8xwFw9xaGCxvy23j9911Sh6GgDe87QTSQvwU7dt6sSnwj4v/ubuQ6v
 QoA/8grxSHl43Y9gU6tIDhduzvq3srmK8N9VWj0rnZtUfav+RdC2UN5ZlVJ7ow/PnpPW
 8zB3zy66xposlTzXgY+wKgoS/U3kBdIsiBi3K8gpT6DTiJ/Kz2oAjWdLbXAP0fi91esd
 ydhg==
X-Gm-Message-State: APuU4Z9yPXTcHuSpiU+8q+8Nqlwmog89Q6GhQWJ5l628H4dDRUJP4DcF
 B0vJZxc5CBu3mfgKkcyVuChAK2VAsU7c8L99Bkg978NvLyxue6Fex4pGBxGkA52VkfI=
X-Gm-Gg: AZFdTZdEVjdo4f0bUKnXuWMbgkor14sF/F1qvVmdPQmwRbkVj1Bo2j88jfeuykepLrh
 n8+GlZLo7WOdwesAUEiRYLFvuUlCK4WPW/WmTH26/azEBLVV65Qzl4ezvHuvPNxXsZ8GhVQDVya
 h+axGdb6JaE5+v8N5Dg4kXKgwJ8Vv5tzPF9mAbc4hArl7OWtGeV9QCvmaQ928E2vq4IbdhcHRpz
 wTl86TyD5uf2dRBHJIljq7BGeQmpvA1OPa1GfhkWwdRPIcl4LUMOB3tWugc49odPKrvg1JVd7TN
 pYjHdZCdiLetb1RbHNrJhBMmgDgfb8lTOXNmzb7AM67IsE5ZjTpfnm2jMqnTZxNhTCPejkqX+dg
 v0RYnFgD8xbo8KymURVSgwlPKC7IxjgPQGYWjBIvxKHuaQ4/UQBdd7JLMbBUAtz4YuqrdxPAwx5
 vp8FApcr78sDOhQVsYdFo75IBagqyp+W275Fs8KVVyEeO12ZBWUi5rVUWW8bjqLV40fGqJnk1U4
 CQ/yJIp7UVSM9L/X9BMo4mjdrBhG0XtTSeCYw+RzooRs4ysJlikQ5RsBf75vRKd9NwhVrI1DzjT
 FNbv5HIJJHgmV8+1GSr5KHGocSKWUjbS3baoVyZ4HuJb8um2Ji/d2OIFIsqWaIg6P8MTXxiCkRN
 OTfdKESN0Gp2cHO6CV3hEsIkcgibfEsRsA+rije8=
X-Received: by 2002:a17:906:c114:b0:c51:baf0:f9a with SMTP id
 a640c23a62f3a-c51baf010eemr142988966b.15.1795634264057; 
 Wed, 25 Nov 2026 11:17:44 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:43 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 05/10] iotests: skip preallocation tests if not supported
Date: Wed, 25 Nov 2026 20:16:55 +0100
Message-ID: <20261125191701.93931-6-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125191701.93931-1-bogorodskiy@gmail.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62a.google.com
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



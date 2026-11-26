Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81A606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQusW85a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWeje-0008Cc-Jh; Thu, 26 Nov 2026 14:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej5-00081x-Pr
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:51 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej0-0005CL-K9
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:45 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c5126505cb3so957654866b.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719701; x=1796324501; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WN1rCG6mClYmHNqS52MkrcTgJAqMF/VV1B9Wwnzg+8o=;
 b=uQusW85a0xP4x4vuIg05WS7kGxAWujIZiqRWwJVdMHboabUgz8GYvzMw8aHIoHg2PT
 ntTf9142qvM/FxD14Zfvqx0hxL0GNcCumHHzvOM2meDlFqhCkJsoHnzqTsraHSsbEZhh
 HnTjPbmVAd5FH86ODiyqfb2wBorZQSed0jZ3ndl0v/oGITwSI++GIlZB1IXMM/GISCYW
 Uq047dVcmREYsFUOozjdDbVMHiz3u0ym/ssMLZdAZ/GISeWgHbbBRfHQJzZALrYTHQUa
 rJAqeUksiyzM9af/mWiGGFNVnD3FGLl8+EahRynVTajFMPVqPxB4BoQrNg+7FyP/e2CA
 BgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719701; x=1796324501;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WN1rCG6mClYmHNqS52MkrcTgJAqMF/VV1B9Wwnzg+8o=;
 b=TismdsXZqZEwtCJARRy3LPsRSpXWxIfc9QUKksyYvEbRcGMRRBfI/StchweWBWjf+t
 BHQB7GXRvZDF63GRiYPIZqZRoAS0T+xh8jZTPkuED4PLBSvpxVuT8qx6hBNGtKD+aUvb
 ELBF1I/MeZJWdd2YNZ1cyNompZ9OkkdlE1s3q9GqxUiSQg1INxSD9LEwt4pypOVykJhQ
 tX9bDoTZoIopL1+5b2SsofDv5z7y1SFQ9yjqjELH/D5bVq0quvaQ89nhP56wgE6RlMhY
 7D8wpZJCRcFuTK9S17/L2erVdAP9Xwyu+h9JdQGMem/0WxzBwQCR/5Z9FuK9hRWXKMMF
 N3YQ==
X-Gm-Message-State: APuU4Z/6bSbUHltAsS0mCC4w+TkqSVO/SkFAsttSpYJreEsqoA4IUWMI
 feVIfN3fM1s3ls66GAxFFMACH7AvyGtDeQAyMhVb0rmHAsVdiN+WjI7oFW581iTOA98=
X-Gm-Gg: AZFdTZeqSoQ7tQX2Lf1wUb2XnGZ22fZ8tCB0zQg46WZxaDa/LOEswDrAY/FJ2Wj25Jy
 K/PfYLSq3gynxk5f5zm//UuLnwNFMGSpYYmT3i2I21/T2F2i3QmObP+XwHN4pJIG/kuUzWTxnzF
 sD1CnfvVcsVXmxwCBzHsQI7G5Kuo6ynwHO0v0I73D1XFE73+Ur4fMTkdPjB7oEK7z6n+NWBvvDZ
 2tQ/BH/ME4b/WVgmZ3lWiScjOlVenvltLPVrprcMzVQwIRFLn5+uxT11SXcdE7gBZoLo9nuteGj
 MyHf3xQWbhvXmV+eH7jT/qIuh7U6bJRz0Lis3Tg1kpKfhiURvME2xBsX9ZgcRCPnYvO5AKE0yKQ
 Fmbjuiru8+ywnAuuKUl5KYtA6kPt/JXgCEJLeWZjyi5konb6Qyve3V+h86Q0UeF6C6dmYdUTT4s
 WJD3BG2kpqNUqXJg0vscUnQw/5EQxxXQf4dUWP3F+9kabjRGz+6/NmN//dETv9DrHIcJ8ukJkcn
 6H3dwn+JhFjAJVf+Oge0x4WX2rnoOwSh926Z227TEPyAz9+6yz0LdobXCvD8jCoBUVR4LjkKY0S
 OPZP5cJzgORquFC6UWop8hbXzp8t2n7pdCXN
X-Received: by 2002:a17:906:66c1:b0:c50:5ee3:e5d8 with SMTP id
 a640c23a62f3a-c513aaffcfcmr1388224166b.24.1795719700753; 
 Thu, 26 Nov 2026 11:01:40 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:40 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3 02/10] iotests: fix default QEMU_PROG on FreeBSD amd64
Date: Thu, 26 Nov 2026 20:00:45 +0100
Message-ID: <20261126190054.40844-3-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126190054.40844-1-bogorodskiy@gmail.com>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62b.google.com
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

testenv.py uses 'qemu-system-{arch}' as a default
value for QEMU_PROG and it obtains arch from os.uname().machine.
As FreeBSD reports it as 'amd64', normalize it to 'x86_64'
to use a proper qemu-system binary by default.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/testenv.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 53c9b5d196..20595e680f 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -171,6 +171,8 @@ def root(*names: str) -> str:
         arch = os.uname().machine
         if 'ppc64' in arch:
             arch = 'ppc64'
+        elif arch == 'amd64':
+            arch = 'x86_64'
 
         self.qemu_prog = os.getenv('QEMU_PROG', root(f'qemu-system-{arch}'))
         if not os.path.exists(self.qemu_prog):
-- 
2.56.0



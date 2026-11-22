Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1B606A695
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IgLm77Gp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVAmN-0002bn-V9; Sun, 22 Nov 2026 11:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAlI-0001p3-OU
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:56 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAlB-0001XZ-KZ
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:56 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c50a4a2132cso349896866b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366183; x=1795970983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EKrW/KMVZQvUPv/4T0xY9IAUFaScpmhyjRdo5uGln3c=;
 b=IgLm77GpF3Khlg5WmqIqvcug6+QZZLiewsh87+SnCQrc9Zp3ICQxbGdPb0jGJhu4Nw
 nDRGxYA+eqXOO0IXkCsiqci+0Yph4gLXwDJrWDIjDgjtVfYc6QpJ5Q8fyut/kPBD+lxu
 dPzoY1TbgCShmIlgfnxCaHvV/A0BdTtcc0ZktELzK+sxcrIKbySGOne9ZP0f7ZXc3v96
 PELJ+65qpUt55l0L8OLhbk8xxetNZ/ZosD1pZqdeaJq2eqxoXVuRQEW11DjbvMuit5HB
 ptUMjYI304NG1ApAXplP0/kix1Np/DeMFnIYMrkYUWHt3FJDdXX/5Kpn82w2i8Py6cpZ
 wYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366183; x=1795970983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EKrW/KMVZQvUPv/4T0xY9IAUFaScpmhyjRdo5uGln3c=;
 b=x65Ooku7G3r8RpIbTYWcSuOqWoOHBY43WWbAvv++54mIzhDcq9z4W1iu9VV1NboySO
 57cE5AsriRfbGvHAi/I/g6YGYS4Oq44U7y4HKXZUa5SG8k83IOeh2ymAPk74dw86BdCF
 B1xV70P350OOp5fO69LV3ehrq+XZapsMDN4Lxq7Ce9CS4M+SDfAQWTVgrUZr9VS5zOPA
 VC2deNngfIgazzM65YKVLgYSifBitXk4+PIB0NVNezNilXHYMpHQ17hXrVR1AidLZmwd
 9CcmHyy0codVqfhtPJXmsc3jgZTGfInQMSq/yCBslLJoHQ9DTqTgPC+A/EH8qPzbLCM1
 LaYg==
X-Gm-Message-State: APuU4Z9J2QqUPWdxdtHUzkTwWnQPk+Ttw1ped4hTDnuO2uQVTKNJZ9X5
 DjTVIuOMPWZDF2g90GSAZvyLXIkdSYvba0gqss/nLU3RdPOvqMWzw0noLj2Y7rfTfAw=
X-Gm-Gg: AZFdTZffmQ7+ZqfcQj6GC+5V0B4m8AaO37CqxsAozeI7Z7REM7OvmjzQS5vMOIRL/5G
 HMTWv1BhOfRM/y4dOUWDehsfl2/G72Rt3/GODcyhyBrMCOkyxXc1cZNG90sSAzj7Q7tlDFgoIdD
 iffZG+NfuYE0r5kc3FTVR5nbf/42xdzRhe2WcYJgCS/I463XDZHqGQtRHsNb1i3JeZYyJefYwOt
 Vky7dXvx2bh64B4Vv8ADNNSHDgT7oeDb0yS8Dk6OUNPjb/CtWEIUWCmxm7sYSQYT0PgKIIb7kTX
 wmMq7oZ+vNl3qJUVfvuNJ4pyOo+SfccLL4lAqAzKIf+IZ/+44G6YMAPQDAHPMRmzZZ/E6YYcxX/
 TIkKqqyk0FkOfNyhBRjiIy03eDwgEVmrae2sixlxrraa0XOhBboCa01BUeLDCW2CZydqk7iDTAO
 RhOEqsD/mWm1h7l25NntMEHCvQn2Y98EsquETReTrIyyR/8DlIPx5+uhLxyURCn0TJdGB1JdpkY
 kT1zzcW7CxS6GHTVpz/am5yEJUQzE60NCIJ+WixmeOp7jJB75eLWTfXuuHUoNhI8rJ0fWbJ92sL
 J35nDMKqTbeAowXFtn49MoQxFb59T70ztwG4G2KIT8oJCpMi/PA/F4Hyz33B6vS3CM7jgeB9ebM
 8JNVhe6jpLsQcTTe8H+Csjif33uXWnaaPQ4tW8nU=
X-Received: by 2002:a17:907:c17:b0:c4d:31ad:9dd5 with SMTP id
 a640c23a62f3a-c513ac86e26mr773681166b.42.1795366182421; 
 Sun, 22 Nov 2026 08:49:42 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2455sm325303166b.57.2026.11.22.08.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:49:41 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 08/10] iotests: fix possible race in 145
Date: Sun, 22 Nov 2026 17:49:03 +0100
Message-ID: <20261122164905.59680-9-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122164905.59680-1-bogorodskiy@gmail.com>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62f.google.com
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

Test 145 uses "-incoming 'exec:true'" argument for QEMU.
It is possible that it reads the migration input before
processing "quit", so it'll report an error and the test
will fail.

Fix by using a migration socket, similarly to how test 181
already does that.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/145 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index bbc3c34c19..3711250c7d 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -25,8 +25,11 @@ echo "QA output created by $seq"
 
 status=1	# failure is the default!
 
+MIG_SOCKET="${SOCK_DIR}/migrate"
+
 _cleanup()
 {
+	rm -f "${MIG_SOCKET}"
 	_cleanup_test_img
 	true
 }
@@ -56,7 +59,7 @@ else
 fi
 
 echo quit | $QEMU -nographic $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \
-                  -incoming 'exec:true' -snapshot -serial none -monitor stdio \
+                  -incoming "unix:${MIG_SOCKET}" -snapshot -serial none -monitor stdio \
           | _filter_qemu | _filter_hmp
 
 # success, all done
-- 
2.56.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF044606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHNZcQXj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIW4-0001oS-20; Wed, 25 Nov 2026 14:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV3-0001Yy-TG
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:50 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIUz-0002CS-Ij
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:48 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c4395d31228so1045052066b.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634263; x=1796239063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TuQlGDT1fLxtyHtXB8qKU3dpP4rlbBDlNjKVl7VNh+k=;
 b=xHNZcQXjIoMpiqPdCEIR3Aoqs4K2mnveVR860LA87H6wGpaGzIEr7O4wNqY2VjxMt2
 ia7CdKfLR8UAU5P2iszErCVLisI/p62vkvcnVj6km7RMPeR2ml8u2oCdnX50ssaCi+G5
 7KEsoJqjZX3W4JnmJIV4NQPHIp/McqGLTHmMYGK388JTuHzJ4ot+i2356cvr4WAI5vlL
 mJNoJrIg41K6Rlm6GbXtiAHs0jXnm3wrIWIe1zs++L2GEtDKcanZhM9DgsCe3HpvUsoW
 qctbLMcsErJMIKyIUJLxFwNK1eILL2s0z5exM0OgzSW3QGNeBySsQOGIacNKsjIAqi3a
 pkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634263; x=1796239063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TuQlGDT1fLxtyHtXB8qKU3dpP4rlbBDlNjKVl7VNh+k=;
 b=Cq8QPs//8F+UFI7Z0hNTfPgMK4j8pNJ7EvpaFFt7X4ALx0ozzMExsV55tICIcbs1Ky
 UNSCrIexveXjXheKmIhG+V+mBSmItHmSpZLeL04HueZWOxYFvH7PCfU5lnUjDmCuxIv4
 SFbZ99zNDGa1NCNmzOSO6Rt2IpT1cTri6uTl7YsRdu4FeLh+ZapnKwkLw6Y9FmT7+Ade
 XcXJJDVE8nGj74h/4Js6ity+ouA7WqVEM1pucTUPnEyzJge9Uk/ns+QrHCkkshMXv2b5
 eDlznBczx9HdpSU1iyi6JEPnW+GzWKBhkEJlRGBCqxPmRku9G5L8QC1G77eMNWJXj1fH
 yIJQ==
X-Gm-Message-State: APuU4Z+TnPP8VH3AuVkXuOzZmEmho+/zc6As3FADhGdxpzkpJpWUXV5F
 pStyCR15hlJnFBrdCm5ufk+e1o58uREXUIO8xlup43eBZCKMe6IjYmdAVUzst39IkXw=
X-Gm-Gg: AZFdTZe29hCcoNGI8jVNpAkB+2nSSNfW3zXT05J7Eqx3DGi+NL9NgGoLN/jFL1krwxn
 g+w/uEgMlLhh2XYmSIa9MfWibXVSwqcqG+9ocQ+9oEIqrQkwAE9LmcFGGwivFYkbk73wI0ZN7UL
 LakZwfT7Twmpeo/m3XXEJ6I/JvwZdyv6sLEQtDCR6cVZCtC36cwivGY9QqNQ7GxRcm5wrtpOOge
 89abEnERzJ2u1rhreqHeyReIFYDLxmUsh1gBpzabI7htS+KUk2mb5cz4qYiW3SJNu8g0PdX9Z8/
 cnRqjRtB3vvNaHtxOVE9K5mgwgdkVxZO1TR4ds6ZoHVlcRw9f51bMIlg+hblHUwg0LD3tzqxUJZ
 Z8JAyM+KuPPVfhTmLyVvDcX1pmL/tDuIo8SrHhy/2ExYE38gwCj6CvU2WTZ0msOL4+IYmjEvAgA
 a7Of/TB2KMbPTQVsoADi7cAccMgdmyk2eRFurvF4IniHX+T5f07JjQL/DfHleycmGfLGKOK3xZ+
 pf01hZDhCfDHjVv3CGPD/RmTxMhe7NEcE1nWIOUZ4l3DzPB8pr9o3etLHbFwKnQQpdIksDYqiWZ
 6SF6tn0pdNzsbN/T8c7ABcefmeCLK2DQ9zvDOs5fzYyTTkLrUvlDbyl4JZMPGgaH4EZic49GeID
 7JYbMXBH5VPiTaej3QB6mXZYuTVbia9mRTGCReUgnLfA0s9Jb4xDSUuvX10uKsw==
X-Received: by 2002:a17:906:365a:b0:c46:50c6:f737 with SMTP id
 a640c23a62f3a-c513a88d971mr1268696966b.31.1795634262702; 
 Wed, 25 Nov 2026 11:17:42 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:42 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Brad Smith <brad@comstyle.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 03/10] iotests: fix the dd() wrapper
Date: Wed, 25 Nov 2026 20:16:53 +0100
Message-ID: <20261125191701.93931-4-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125191701.93931-1-bogorodskiy@gmail.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62d.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dd() wrapper uses status=noxfer on Linux. It's also required on
other systems such as FreeBSD.

Rather than adding OS specific conditions, check whether dd supports
status=noxfer and append it to the command if it does.

Suggested-by: Brad Smith <brad@comstyle.com>
Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/common.rc | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 262fe63da8..a89aa48fb1 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -52,21 +52,16 @@ if ! command -v gsed >/dev/null 2>&1; then
     fi
 fi
 
+if command dd if=/dev/null of=/dev/null status=noxfer >/dev/null 2>&1
+then
+    DD_NOXFER="status=noxfer"
+else
+    DD_NOXFER=""
+fi
+
 dd()
 {
-   if [ "$HOSTOS" == "Linux" ]
-   then
-        command dd --help | grep noxfer > /dev/null 2>&1
-
-        if [ "$?" -eq 0 ]
-            then
-                command dd status=noxfer $@
-            else
-                command dd $@
-            fi
-   else
-        command dd $@
-   fi
+    command dd $DD_NOXFER "$@"
 }
 
 # poke_file 'test.img' 512 '\xff\xfe'
-- 
2.56.0



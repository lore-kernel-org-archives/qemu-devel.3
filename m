Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A48606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tD2ck0Gj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWejh-0008K9-Gw; Thu, 26 Nov 2026 14:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWejB-000839-GE
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:55 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej5-0005Dq-GH
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:51 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c51c294cef6so114483466b.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719705; x=1796324505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=35g4FLKL6yEA8ziN66v1CUgLUxjBA1s6MbjCUNl4ucs=;
 b=tD2ck0Gjb6ZdyXDSWcAFu4zPBxgbPkbDobam5E9xu68W7O7r6JXnCuV8p9YmRNqZXy
 TSetEEckOo5oiS+r0wG4xG9lRZvIfyPeweHFasmy/T9ifgDQ77LaZVqsMEsal62LOvI/
 Q5DP9MUuto7xkSu+tKqmGt2tkrBYzc9FzEoEXk+L/Y1k/3lA9dm4a/nbAWAoc+0gRR0W
 0d4h4Yuen8l6e/45N1mFhUSJ4BBmdsdHiXFr3blY22QnK/MCniBuPgXFJuk9Sr1jtVcP
 Rwm9nt0l0kvJM6oPBcDRoEua7N6FeFot7/+R0eW0y8776vxEm1QTF/DiyT42fNf/PhNr
 ACVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719705; x=1796324505;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=35g4FLKL6yEA8ziN66v1CUgLUxjBA1s6MbjCUNl4ucs=;
 b=zCj52YOlJTfvwWLXW+XWbkqDjFnxXww6N5KC5KNRXiXqVZ6eoKvas30x5G/DOnLsfl
 5cRUkmvWzepJQRw1a6Mi9MeIwjUaRNa7d8Z/KWgHCgr7QfiZiat1NZBxUf8T92e4Rzoa
 OHD0b0S8HXr66AlCTaaDDczJr+OumPQFo/FprzJYTdby3ufMaeHUACXxQvjljCtX4Eg8
 7TN1xd3HxfQ9Wl8UPK2THj4v8mgE9UUmB69EIkmGvD2YH8WMSAzLyvO1EiO2pw45dwi+
 /vrS3F8ahj4ZCEH4GOWz3o1AOk755A4SE9awbVz+V47O9l+T8HivuCs4VBVjZ3ACaG4p
 hNtg==
X-Gm-Message-State: APuU4Z8/LkG1KQAb5MEVB6VFRr0U93khKIRPEJbuvw7uDP2a5m9HMYEl
 xciRN9rOD4M4CwV/1Pxm51f8345SiSwaaf2Pu+nMg4OrUnJCc93adVuVxgTjhgJnBpE=
X-Gm-Gg: AZFdTZdd+EjrbCokWPWWaI9eieZXo+Co59cZrPQFcnfb3cs8tiAis6IJ0WupJJmOrgb
 Wk0xNMvPfGatthpvD+WZ7WucCJic4hNDuo/rsb6XMv+lsmryW9gTT0lPmAttPWn/trI66+sO03l
 XfGZowdMnQgWvbBiYLywlQqcNC0Z/RgahQpy/Q20X43aiYuNrqh43RLxUn15Nkbs0LWKWuFJeZ4
 N6bXWJATz8PTD8eGc26NBNC4M/I1iSFVIQKNuqV+3fmNdOJpiDYnUVTwtGNFQYby+P3iqOJbaSW
 4ivJzZHp4bePdR+5F+qzopwrQo2Po45KUZlS2EGu9eXhqQVOQJErtnMhDt2kFkLbrPhAjgr7IWp
 VE/qjCHHEMCtkCRQGye/x0kkyBFrf/SDsiZaci3sDlkqx4L2dWpP8V72clnTW4f28mj76TOAAR5
 RNzDEDxIRlQnmxjCDPxYEvnt/eJ6bkbWV9C6SgApUVEBLC8vNTez3hUE/BkgMbEFhQ2KqOs8LdD
 HhnX3vMhQRMpvRfNsvEVEuLzel6pwTwBcAdeclH4cxcB7E6ixpWSM495Bo5g7PQO/u5DLp3TFKZ
 RO4jWIPGXQzGvXIXs5bt3iyL1MT14zq0R3sM
X-Received: by 2002:a17:907:6d03:b0:c35:d50a:1352 with SMTP id
 a640c23a62f3a-c513aace66bmr1733684166b.11.1795719705022; 
 Thu, 26 Nov 2026 11:01:45 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:44 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3 08/10] iotests: fix possible race in 145
Date: Thu, 26 Nov 2026 20:00:51 +0100
Message-ID: <20261126190054.40844-9-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126190054.40844-1-bogorodskiy@gmail.com>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62d.google.com
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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



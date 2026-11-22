Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE8606A32C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cnAB6KKp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVAlF-0001oe-SE; Sun, 22 Nov 2026 11:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl3-0001mW-Oq
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:41 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl1-0001Vk-H0
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:41 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c50e26763a4so461457166b.1
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366178; x=1795970978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q/uQ5dCxGLHC/sqFChbq/a/9YkIEhv0pwzfYMAGs6yg=;
 b=cnAB6KKpFbtuTz+I7dTVnagGbKVgccmwdAshSfWLVDgZl7Q8R2KR3XL5XVYvcOmczs
 IRhp4nNU7oQrYBlcdsmaMe3NmO3daF+U7jhx29T2lhtZApmCe1Sg+d6O9YxOg9aysoVF
 nKJEza4ptgMA5luAgCqJRi/JMomAcVeKmfxBIETmQM9JiqWMNa3smWJC0rkGhEz6V/09
 NwhyGJ6oCSkcJLsJsL2M9IKuHjogwel2TJM8fSb3TOoyrBGolKhS9LsW9GsNC5ZLqCmM
 /eoapOnS48r4l2hR0v2uU7u4zMN2K/bHmtvooW5IOQPX8oyRrL89lvzDQLfhrk8EfcE4
 dX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366178; x=1795970978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q/uQ5dCxGLHC/sqFChbq/a/9YkIEhv0pwzfYMAGs6yg=;
 b=YMAzqF0eiK66kDQ7PQcN1TvpkC8n8jh5JufKxFvt1VQfC31Po0I5JT7vFJnc6Aku1Q
 Tgd+8drmhPStck7/kzMto1DhuHfAU+9R1aHjPxslh/dcagfZlWQcdJ5lw9Qy1MEpkVHP
 R/CD9GDGV2uug7F8XDzUCCV4VbIs+bFWCOf1p9aqwX1Vp+Uar+daOdAY2AgZPhMHijqN
 Nwku0T5xrP+JlC2cibt9TjfvNWwvFiFb8AzHxnK0m6VDS2H+f0/plwY/brHjKq4BVcDY
 2i2jBSNkVqrwEzWBxsVBjyhRXTDr4HQBXKHCQ3Q5IlCwn/Xnyt9VkU0/BnAmGb/ZR7Ty
 aAXg==
X-Gm-Message-State: APuU4Z+isZTIMS78dFk0m+aLwMeN5XujisKo6kjo5vmQ7bT8oTPTxVpa
 Bebl8JuBcDXjPFVk78JqziBL6qDMd3gbtL3RLNd9mlQZuZqLQAOKFjpT3iexKcBE8ko=
X-Gm-Gg: AZFdTZeURLTbAqLh9t2dRTIw6hkSrsfO8jqERD0XBvTxB0ijVIVCv281PPwmb85nDfr
 4vTQ/vg63sZKd+YSSjL4zSoCZCUiA0s9j53UGRcrHCK9LL8Qu95GlSCpq1ufD49Y1gvF2zUVP0U
 a0RtKqesfXImjNGQpHAtpUDP4gIGQpGLodCwipyCrS7cd+1JDQABdZqDeRyKFY9ffUKaKJl+XpP
 zl+AYzxqKI1/fT3z+f8q9WoZIFGvxPCJjY7iMFKVxARCW/Bd1fslxcXYnSxwVyICteTBvkph3Pt
 xXlf2q5iU6TMjro/1tc3MtVUnHvQ50G4bNY+iL0t2hk1AFJznf/Yu92Tr/zX2/AWSNUr8awAbse
 MUarhy+cEmyq7CDCWHkdiDdQAO7vfPGUjaECMlgf2XB+yc6f/Kupp9XtFHhuY7v5CF7SIOpqxMt
 aur3vxirCBnWLjPY7ViTOsXbIf85374248RhMXkMUnz7YL9uG81jwdHXJqiqgqnN7fzWDQ3rZ+b
 wRdDRNpLD8IcgrcdxfpYNBnRAc1wPrj/tWGqtRdAAXhfKncVMElXb0KXJIzEzuDkwtExIqJkIiP
 Eaz1NxptZpsu5miNuvw3yReB1EcMU88zz4DHTV0O+I5K7JfemXAPDp8gQD3OoBbzEbNFAG0vSSR
 +1G5jPKgaE/oVAEzXCU10YRPhVe4AWmxebhMFl28=
X-Received: by 2002:a17:907:c13:b0:c4c:c997:8711 with SMTP id
 a640c23a62f3a-c513ac67123mr731900966b.38.1795366177995; 
 Sun, 22 Nov 2026 08:49:37 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2455sm325303166b.57.2026.11.22.08.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:49:37 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 02/10] iotests: fix default QEMU_PROG on FreeBSD amd64
Date: Sun, 22 Nov 2026 17:48:57 +0100
Message-ID: <20261122164905.59680-3-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122164905.59680-1-bogorodskiy@gmail.com>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x632.google.com
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



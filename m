Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D86606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rkgAIwCC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIVW-0001ai-2i; Wed, 25 Nov 2026 14:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV1-0001Xg-Sa
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:48 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIUy-0002CL-Lz
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:47 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c505b2e1cb9so1134656566b.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634262; x=1796239062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q/uQ5dCxGLHC/sqFChbq/a/9YkIEhv0pwzfYMAGs6yg=;
 b=rkgAIwCCi88HtDBYnZLDdjr1Q6RVJZ5xzyqAjTPM7sUxI0nEtLdspON/kSrf+Gq8Wm
 RjtwDP9RucbUfYAqUUFtvKvuVjY0y+quxi4of81JDBfg2fhRxOVabU82hOJxgpMwJ4DL
 mA5++ThXzbefw+WnoqGJLLZS3QrtNYiM76OHSsvyCqCO/ons/+piyeMrHqwoIi+kWmQI
 yQxKQbor+iX+O7VnYYmwpkMN3+PS7/ntqxbNxVd2jIb7TuH9WzvM4cPYEBG/+T2UDE64
 4egRWnL/OZiDR4wl6C8gJ5H0XKyimkwiNE445NE6dRA+AtMKtxjqMgxXSPf9RThn93/A
 LV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634262; x=1796239062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q/uQ5dCxGLHC/sqFChbq/a/9YkIEhv0pwzfYMAGs6yg=;
 b=h/RHR57dnq79rY/k68NWg9a3sLCpoNO3C2tkaKDOatIn3rF5lBUEXM/IRbfS65kJIa
 jr8WPz1Zjgpxc33jV0UI3WS1wJjunGWf7eX3TxT9xwdtsfMysGlmcclXElr672/dFZxQ
 KdkKTk+va9cJkNsx2EutkUawjZcV4b3U+gpCZGuhxGJvVEKX5P6Sbq+M2LN94WYKG9Gw
 vo8/GCaEsWLVFsxo9k2620h0zmwmYOZkY5TnNNMHp+2K76gvU75ocVkl39Af8Wi1a+cx
 R/8UgXBRAHOpLHgSjOxxsAjCye4nGkBtXl/sOvrKUulHKSCSwRK8qO/PNs4mtIxKUlBF
 0VkA==
X-Gm-Message-State: APuU4Z+dyS2TJVNeqRQLFYR8l8rZzjbSmEbiYalZAO0u9rEJOec73emN
 BIcE7Ky85Jk/z6oKq7UCjZTRxryEvFfIZjWr4nuvbFnTvd5l0FHA1Zm4TnrZ+NqnkHU=
X-Gm-Gg: AZFdTZdFLl6p1/PYtenbWIua6uvWirZcaRH+WV4FCa/+wVrFc+wO61fRGk2taLPREVv
 sjRraoSkwRnQqWRaJusBCuwoNJ5tHh2i+MtowUWcNC4QntkgCSaIJUDGuWrRqdOmE896lwji2LN
 NkgK5IE3U/La+EijEiiTG1qrqkDbAKQ53dxl9BywObYWc/y6vc/l5KUH60niQDLGQbvx6GC40jO
 lWEfo1Si4THq92By14ybtSWoxC2vfTSH6kdroQJbWSbDcZ5vDvhX0CGdNTEM8qXfBDGk+wSxWVs
 QDfFKS/L5zRyffrpyYt0dZ8gLmxCghs9Kof9uI4yw6i+85c9AR7fPZU56+NHBie5VNvKioJmoCE
 b8ex5ILQDik0Q1N3PWALd+Hqd5Hc+RlXRgU3GI9LpLLPVHN5QECdV5y5BJ7Sap5ppVn5MKNXBub
 9cCBQe+DjuQ32qlwGg7wkir92VnRw/jT/q4I93MJYQ5cjBYNftHtcW2BdTrSkBczmG+OHTgG/Xt
 Ib3UOEDwCeenesC8xOhDYEs2N+ZA+Dv66oXWjDeR5CEci2moXwzXRETDuXhj5qLsNaDGCLJx/B1
 pSouCu2IP1RBctPSc/RADj79jFlcQmtzZ+m1PDaFUt+QxgvSZ2tQV15UefzuEq2MoGI0kJN++6H
 uxQ1w1aFVkcG9jDw7R+hq+tII35nfVgBebPFU2X8=
X-Received: by 2002:a17:906:9fd0:b0:c50:5a93:3bd7 with SMTP id
 a640c23a62f3a-c513a52b574mr1445579566b.3.1795634262010; 
 Wed, 25 Nov 2026 11:17:42 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:41 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 02/10] iotests: fix default QEMU_PROG on FreeBSD amd64
Date: Wed, 25 Nov 2026 20:16:52 +0100
Message-ID: <20261125191701.93931-3-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125191701.93931-1-bogorodskiy@gmail.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x629.google.com
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



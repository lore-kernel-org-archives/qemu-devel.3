Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA20AC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmYL-0002G8-Vx; Fri, 31 Jul 2026 08:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmYF-0002Ch-Mm
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:41:25 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wpmYB-0001bU-UG
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:41:22 -0400
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so719553f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501678; x=1786106478;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wfgnax45aICt6Jk7Ro6ypa6BY2EaCT+RRKjj6PSNFs8=;
 b=GCBL8BQoSsgURm5FTqB3ApfPM2DLBdz3d/yXeJfraMWY1zGVAreESlTsowOf+0/nS/
 2Mclu6x+7bw+c1Us+uHFoT+PIfPA8AkGCUIjG3jcUVOd7IlzRBX1nFywpI61jBnpRt2T
 14XI6FefvI78G+OmnRIo53MbT2bJov6cJnkGw3z/jsKr9+e2z2w4tKUSKSUKwjK3kHnA
 xfSZUeXQdtuaOQyp1E5vzBMDV0BYgsrNo6Cepn1AE/sys/S+HL6WgNzvF44qA1HHgKoY
 Flx4a+Z6MeTlS/xyIbXN/0una4OvOUBqT6CU721sJpJ3Us4FL93wqKF1KeAoGX5MLUlH
 4EBQ==
X-Gm-Message-State: AOJu0YzlqwyrETKSMRKk07WOZi0MoJ3lLRD2BgU1uEK8gpfCJpVYFFbs
 Bg+hAXQ2IxwgYMvlOAIAzPAxdGX/DNpPstVVsDnGQbSJz+Ynz9Zn8QC1Msfc4P1x
X-Gm-Gg: AR+sD11Xh3HK+fgNRhU1xeeeFZcxEBwv0/I/Ulc+sBPUQ/+k6DEoU9LMJ6bupirh+83
 mWVJqiw22LnsJxHb8dn/SGtjGc4/i3L47+uI/p4JTWSr//YNsXRI2J2Smb/06tcL4Y7Rpq1Anjw
 GijKRAA37i4CfJAJf3ByZIgeZAjAWna1LMxxgJ8mMxmo0sK9OiE9Bn7szUjqsUHvNxb9vItU5vS
 h74Wtrsk28LXMwscRA/tr9x7RaWp2xmZ0YUGWsvHw00+bKSahAnx4eRYoFv1BluVs0Tufpe47e+
 D46WAHvUxv6oShDOoTxZBpCEWS2ulgluk8gDkE4FJugkjj4tvmGLCSjGOcNcwxBYfngpyTYHiAg
 Wqt85qcsLq1gNTLHnR6OcS5plPqiiFdroFj2BhcmfagZOHHzbD+7rr6/HaJwgksah32DgH4WjG5
 YRAldxrFzONSydJCt1RSHUI9K0Y0MadhhCiu9ygTYLIFkp2Dirx12ybNsVuwnZcx1+Qca3kysGk
 F1qLCvi41a1rtqeGg3fi1Q4OJjcb3fI8hXJ
X-Received: by 2002:a05:6000:4289:b0:47f:9839:a79a with SMTP id
 ffacd0b85a97d-47fd2abab8dmr4431755f8f.10.1785501677626; 
 Fri, 31 Jul 2026 05:41:17 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458bb4esm4890379f8f.30.2026.07.31.05.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:41:17 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:45:16 +0200
Subject: [PATCH v2 17/25] tests/functional: give the set_machine probe VM
 the test workdir
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-sanmiguel-bmc-locator-v2-17-1266926ba769@free.fr>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494708; l=1100;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Z+1yI9ZlM43E+k0NqAp1ImIMvg64cZpfA63qBC1lq6E=;
 b=MbsEmbQIJ8LmTRubmq1OG/na21OSmmK6gSY19UtB3Wl3hNAsdBDV7pI4pMFVcEwBOeZVr7AKF
 mcS+P6DkxGUBvNoDmNuh0F1xGYwgcRs3SoJvVj96FmjBH+zAdvmHMW/
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.221.51; envelope-from=eblot.ml@gmail.com;
 helo=mail-wr1-f51.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

set_machine() launches a throwaway QEMUMachine to query the available
machine types, but constructs it without base_temp_dir, so it falls back
to the hardcoded "/var/tmp" default instead of the writable per-test
workdir that the actual test VM already uses. Pass base_temp_dir=
self.workdir for consistency; this also fixes VM launch on hosts where
/var/tmp is not writable.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/qemu_test/testcase.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index e4179d165c..ed861709e1 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -317,7 +317,7 @@ def set_machine(self, machinename):
         cls = type(self)
 
         if not hasattr(cls, "_machines"):
-            tmp_vm = QEMUMachine(self.qemu_bin)
+            tmp_vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir)
             tmp_vm.set_machine('none')
 
             try:

-- 
2.50.1



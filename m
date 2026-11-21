Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A164606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N4q8NttM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUq3k-0002aU-Ir; Sat, 21 Nov 2026 13:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@amutable.com>) id 1xUq3I-0002Yw-7D
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 13:43:09 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex@amutable.com>) id 1xUq3G-0004YM-A3
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 13:43:07 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1054309f8f.2
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 10:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795286584; x=1795891384;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OPtNs4xMnm2ZdPak90Lg/QccmJA2D8okQG2oRAxtZmQ=;
 b=N4q8NttMXz0cAY4S2PyZkyHymptlZDjrcJC/4ZONoN0TidBN945VsWhObWA8/vozYX
 XtsRnTdN9h6tUvp8LvpjK0IAYP2OKP2wtyrRM4sSz8rhF/+o7x7wHTTT28gi7u2w6nBj
 43zo3ik6Ze2ArmafidqR0yDyS27SgdpWpsL0T37mVtnhZatDRTdkSTH0KgsawuFApJlW
 a86b2I4po5H1LsYhmlQOXGvsy1y4n41Ee71/AtL20XXhSKUtl5u+T5kNSJZf89fWBrhj
 AbHPWYk3aHotNT2WcxFJX7LdE+QRGz6ovK+Yy7AHlGscKuaL5sC1BF05/vfAbdTETo0L
 dGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795286584; x=1795891384;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OPtNs4xMnm2ZdPak90Lg/QccmJA2D8okQG2oRAxtZmQ=;
 b=FSMXYgJQmG2eDcYQ9Nb4nnbiCyGxBmX3fpCD+lMGfOfoeAawt3MX9cF3t4AMvdiMlh
 +zhD7BedlXgHjvSFXAOBgKAmRz3FWp4kl8ZgMP30alNQ8IcCN87d4d/S6s38vVEaI1x5
 2mbkWrOGrL3g90OWq1/m8yt/z2y/UQJrmhPxGeSxIJg2nPiX/dE0ltu1qPDCHVENYLrt
 GsrnQrEfWtunDFinNMEQMIDOY371kl94Rwzb2s2tTiV8PhsekCnysl8PSflDmZEULf0U
 hN0/0gFQSXxlB3oG8zPsGVD4dE/SoewwigLG6lr4EUtEnQlWkukSiRXyNwCxs8v6gXps
 1qVA==
X-Gm-Message-State: APuU4Z+xNr1KBXJgKIsEBjdS67P5cKaUTh+jfFVIl0G+5DLuKNwueIOf
 PmcUUeVHc0MyBzOqpgaPwFUlY7L3/GvQP5Uxhwx+362VzcnOWYfZy1gX7aQcGA8qUYbxHxhp1bS
 eNWUKPX3z
X-Gm-Gg: AZFdTZeiF7SfXhGwlDoKgUhFViZzLXlsP3dxJ61SYk5wMlj4SOkcQVjJ+ABFyrxArtH
 dzZ3eaD9DTp/dWzk1ro1pEEGvcZG3KS61RKnrzoADO2BRIujLa/4RZIGTA/kaf0iJuXlA4cpZEo
 DGrtL/ICoF3H7/w98Ljm/J8yOmi6+b11t1sjAYxigT/hDPe98Xrjgp+q7popY7I0KbeiTxX3qCu
 Dz8eylfqexHp+TVzulcq4FjwGPpnF00GTxPWy9uoWK/s9iVxEEOt6YU777rPJFw+8NXboUDiEtx
 CavlcRbR3oedqP/1y7sRhjS1K8R1xdKZb053incUQwrFvalDOG4Mx0CLy8y1nlUCU8a46GRMK0x
 HgTPHrB3vlncEiAnE3cItSufL5FEZV5nSsvB7N862IdM+QGN9BTXFTpUu5uN7V0QIdxt3bR+ryO
 BplC6fDo3j3+eVevdgOAkco6iuddSeCrcASI5eq+UNdlvqxY7Mgn4zpFDkh25Bl9hyk0orPDXQe
 ff/c5y8h8D3lvQ/3cl8+bVPV/2PlL4WIr3FNKYfNXbGKrU23ljuH20ItmGfCS+rVg/NMB7H6jU5
 o/Q9CMiLfRpmxtXwd2inbcwTVy5L37f2aqEL/hUnWy45M9rbECqNJ/0b0p6nfeYF967Sa70WRT8
 RvSFa6g21/iQY6qhC
X-Received: by 2002:a05:6000:26ca:b0:48d:f14a:9188 with SMTP id
 ffacd0b85a97d-4abb0f3c225mr13547600f8f.17.1795286583464; 
 Sat, 21 Nov 2026 10:43:03 -0800 (PST)
Received: from alex-t14g7.lan
 (p200300cf572c2800e6fa15a778fe8e37.dip0.t-ipconnect.de.
 [2003:cf:572c:2800:e6fa:15a7:78fe:8e37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110d56sm12370285f8f.40.2026.11.21.10.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 10:43:03 -0800 (PST)
From: Alexander Mikhalitsyn <alex@amutable.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>, Klaus Jensen <its@irrelevant.dk>,
 Peter Xu <peterx@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Alexander Mikhalitsyn <alex@amutable.com>
Subject: [PATCH] tests/functional/x86_64: fix race in NVMe live migration test
Date: Sat, 21 Nov 2026 19:43:01 +0100
Message-ID: <20261121184301.21112-1-alex@amutable.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex@amutable.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This test uses /tmp to hold test_nvme_mig_workload.pid file, which
is a PID of a "workload" process (producing heavy read I/O).

Earlier I did a mistake and forgot to mount /tmp as tmpfs, instead
/tmp was using the same storage as root-filesystem (which lives on
NVMe device).

The problem here is that for this device we use "snapshot=on" mode,
so after live migration all data that was written on the underlying
disk is lost. It is not critical for the test itself (because it's
read-only test by design), but very critical for the test logic
that uses /tmp to find out the PID of the workload process to kill it
after live migration. Absence of this file causes test to fail
spontaneously.

Link: https://lore.kernel.org/all/20260921190345.1709227-1-alex.bennee@linaro.org/
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <alex@amutable.com>
---
 tests/functional/x86_64/test_nvme_migration.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/x86_64/test_nvme_migration.py b/tests/functional/x86_64/test_nvme_migration.py
index 890f0aab6d..a8fb5f9e81 100755
--- a/tests/functional/x86_64/test_nvme_migration.py
+++ b/tests/functional/x86_64/test_nvme_migration.py
@@ -94,6 +94,8 @@ def launch_source_vm(self, vm):
                                           prompt, vm=vm)
         exec_command_and_wait_for_pattern(self, 'mount -t sysfs sysfs /sys',
                                           prompt, vm=vm)
+        exec_command_and_wait_for_pattern(self, 'mount -t tmpfs tmpfs /tmp',
+                                          prompt, vm=vm)
 
         # Run workload before migration to check if it continues
         # to run properly after migration.
-- 
2.47.3



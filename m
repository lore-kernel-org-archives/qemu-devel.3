Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AA606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v3hydFN7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXuN-0005bG-06; Mon, 09 Nov 2026 17:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXu6-0005LA-Ek
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:54 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXu4-0003yK-SD
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:54 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8a06e79e152so737046b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263510; x=1794868310; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8gAMKO+bBoKDKwjxX1fSr59h7XZItuue3T5wyjTtfu4=;
 b=v3hydFN7sXM6JfMJnnp1IcD/47ZzfPkxD5vUclUiwjuXnHOJkdRgBMYdCMer3hIuDa
 yKeIWH9h4iMq3ejj6Z5WYvDT/VcP1d7ua3b2XUWJquK6AKdQizKXdOjeHKkgWKCzVbp0
 L3sAstNDwmDVfNnpA9NS/85KqTXSugWedlbjRsWXbTBrewsmMVo+YIl0gGjyt99YyTqz
 tXqHZLDu9KKyt+Z1uDPjkeIbBLZeKV7QGRnhrJJMqxxR0F9qggWOEciKBJUfhpHDTxdx
 NWoenxx4aDdHvPOpyRMsDCvKayIwZ4dVVDrlc9BV91kCs5ecdVhoNCFqBbAO0D3ul6vt
 aHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263510; x=1794868310;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8gAMKO+bBoKDKwjxX1fSr59h7XZItuue3T5wyjTtfu4=;
 b=PkGaPOkL1+UWKwKZ0DAX9+BXJEc6wa8VjSQ4sIedQJmAIl61GyV93UKe+ieTrinqGJ
 O/n4kAC245ik9PI3a5WUm6JMEqf8aSpQlmJ99O4rqDavZrihWG5l6C8m285GYk6vl8Qt
 AnX6zud9XAEX4V6rkrM8r/auN41Ji/Qq3Rs9Exz+GkYO1eyzUMv8Iib9jMdWX7lQVzKM
 UxCh9DHE+ODw+3iMvnxw9D4a4hq6qYKd71M+ec7ResHeg7omiMtq2piN32ORpwfXbGaJ
 AN2Hliiv+ySWhcdlvrlWOGNtajK6ZcT6Pcca185RRXfVabF5/2jp04o0NBIEOOq3wAjP
 vxPw==
X-Gm-Message-State: APuU4Z9QfPcGATvovmWNSqy/LM5+eEyCHco82UrrdVQAmVfOvx7nH+cU
 Eug0SZQ6OnKF2LUBuazXcP5UZ19YrDaniZLFUZMDfefYwBTI2Ygo6RHhyjUJ3vy7L+s=
X-Gm-Gg: AYBFou3tDZdV0j+hnNLnDJEoLt++lR5yURhqQQ2AxXpukQNpJbRsPvWqfKjpLmikZHz
 VBkt+6AIX3jxVn4DXY42VcD/ub0ni5V8Uj8RwAoTyyqZcTWWf8Euroksw2bA1E/UiXm+Zd7gB3i
 EJ5zPnieRl+FQcfIK/LSA4gzVm8sUWIYfqPYMEAxG94iirMziUhNOBV0vUhAaAMowX5+CF/cqxO
 GHnaypNsI4w37OH19c6+S+I9zO/FmCA2c0nG96E1NU5EnGV4wYHaO7NXnmqHwoinQota4FCm3h/
 LUxfBV4sFMzojpq+QhuRviGu6g1I96rE5nXWWa1/Q+Ln6K8VQeB2SvaWGYwnzCK8D2uy7bC8Bge
 X9wskZjzlTjxzjUscZu9Hj3QQsZxll+EkNEECBEthA7yzQOuauWGY3j4oeq4VRfTthJ6tSan7qi
 8VYjVwMpVYPRD8ltfs1iZLGmDBEKnT8eG3g8RWZwX9OfO9zCd7TsSmCu8NYmmO+l07ppCvsYWUz
 BAu9BCSmxEerAFNLlU2rJdT7Ue1ypYJm9+Q2N9phnGt4JzcmkTrT/Fr7g5Y+IwZY669WZJb2tyK
 9nMzQ6GKw5s+QjwIuS1b4L2FSSI16VDsrm1q3vr7Dg+N+NbXFKWrYQ==
X-Received: by 2002:a05:6a00:18a8:b0:89e:7bfa:f86e with SMTP id
 d2e1a72fcca58-8ba885c7a6amr951177b3a.13.1794263510381; 
 Mon, 09 Nov 2026 14:31:50 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:49 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 21/23] docs/interop/firmware.json: Add arm-rme firmware
 feature
Date: Mon,  9 Nov 2026 16:31:08 -0600
Message-ID: <20261109223110.1619504-22-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Some distributions provide packages continaing firmware to be run under
QEMU, such as "qemu-efi-aarch64" or "edk2-aarch64". Those packages also
contain descriptors in /usr/share/qemu/firmware/*.json listing the
firmware features, so that environments like libvirt can figure out
which firmware they can load.

Define an optional feature for arm64 firmware to indicate that a
firmware supports running in a Realm. Firmware implementations need
extra support for running in a Realm, in particular to distinguish
shared from private guest memory.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/interop/firmware.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index c8bf0ef1a1bf..a5e36de8db6c 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -156,6 +156,9 @@
 #     options related to this feature are documented in
 #     "docs/system/i386/amd-memory-encryption.rst".
 #
+# @arm-rme: The firmware supports running in a Realm, under the Arm Realm
+#     Management Extension (RME).
+#
 # @intel-tdx: The firmware supports running under Intel Trust Domain
 #     Extensions (TDX).
 #
@@ -224,7 +227,7 @@
 { 'enum' : 'FirmwareFeature',
   'data' : [ 'acpi-s3', 'acpi-s4',
              'amd-sev', 'amd-sev-es', 'amd-sev-snp',
-             'intel-tdx',
+             'arm-rme', 'intel-tdx',
              'enrolled-keys', 'requires-smm',
              'secure-boot', 'host-uefi-vars',
              'verbose-dynamic', 'verbose-static' ] }
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2728C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBGB-00028p-3f; Thu, 22 May 2025 15:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBFE-00016t-HX
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:22 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBFA-0006Y1-Nm
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:19 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3dc87649822so19121865ab.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940775; x=1748545575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aCXupjQf+KpZBVxWkFiZBckC01w8HvIqJ4QFv6HBfc=;
 b=oCLSyFALdZpwNw22TIIJ9f/oaHnfmJSQYBnkm5BXEzrR2E80LLluX43dO74FLApxv8
 wcyVZLeMEM/drTA8CA7MjtrZMzld1S7MbTH4+/g2bcSSZjlO5mQ2PRX3IAKKpxOMik78
 nZE4uLH2g1zv+p12L2bv+mI9Jb+Zx3tArnWpLKrScbcX9paJDRSVwFUiBr7T0BGMFmGb
 Ycidmj9nMrZAu8Rew9s/LTCihDiaqqS4oHUZE9p3Yh9eDYvRPvK549XCKWF95493eF8t
 J4otfosOhSen/4KYAlimCGs/UMT7jg7ml27O5crxLf2ur7tzwfvR34NoCr12k425vUot
 93YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940775; x=1748545575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2aCXupjQf+KpZBVxWkFiZBckC01w8HvIqJ4QFv6HBfc=;
 b=DzRDbdb37yAnl+Nla/MtkQj5runBXXzIujKfarXSwIhs23UCRJOOBNoUVieOqQ2Gwj
 TyHz+TFqTC+BqC+5I+WRezA3EqF4sVnT13f7aoZerM4ui16kkUc7yw3RDsXnnORC/JjD
 2MNCPXVPwdKDFP9NfDNQirp2juMFF0nRHB1uxYJ7DLz6M9S5E3uE83RgTZDp28/baHgD
 MUN7GqGzJjS8FKQoCSAjYyJ19V1cRLjp7yjX1V1UU1UDrySmsAJoN+NQoJAr2/EaGI/b
 KbR8hXEqd3IquoQHxHjmaL/YB55Ja/E6VDxsuqPB7Rxlr2mt66v3MiUx7qW4V2khB/Oj
 tCSQ==
X-Gm-Message-State: AOJu0YwKrUyYNDHxmI5iTp8L2GVo1tMcU+IyCZ5gsvakiZdSor854g/i
 qYR3iJ0JB8HeWnzpBW3qE9nW/tbb6dKSULsg/3w+oE74Ix/R3trRLIXlwYDQZrp/fyMtHIvMKeP
 p8ly7
X-Gm-Gg: ASbGncuMmjrzzbIUv4qNvUZ2o0hOYdpsG0P51dUDmHvAVOL7IEQsRIwff5VaD3EgxSV
 ld5p4RYps3nAp707rSn7b7aGWlF1GHovcyEPhD4NKENQ4w7FOK6wrWF/jVuv6UCqnfSvVq99pRe
 PrJ5b8S+DyEMQLD1jd6wvNithp6v5Sa1WliWojZ8s4HpRDYFTb+dkALASnyNvBO1Trx8WhHpAqA
 CV3VdCwIyNK08gYNRd8cO/afLuKdycqN5amxkLYGllrMLPDdDbnpXJLOTk/NsozBgazSkhzOR3u
 /4dlPueBf7YXh0PVamcnnPPlGwLFqwYIKLzF+SIN55qJJ81rOQI=
X-Google-Smtp-Source: AGHT+IHWvrDXwuZvs3ShngwDLOKbnqNTg8w5Yzm7YwLBqSxwiRLnhXpPk6hpGeF12K/BeRSYiom/FQ==
X-Received: by 2002:a17:902:e5c3:b0:224:376:7a21 with SMTP id
 d9443c01a7336-233f23c9f98mr1715205ad.42.1747940764790; 
 Thu, 22 May 2025 12:06:04 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:06:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 15/15] qapi/misc-i386: move errors to their own
 documentation section
Date: Thu, 22 May 2025 12:05:42 -0700
Message-ID: <20250522190542.588267-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x130.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-i386.json | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 6f79817e382..796eaa5f406 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -166,12 +166,13 @@
 # measurement for SEV-SNP guests is only available within
 # the guest.
 #
-# This will return an error if the launch measurement is
-# unavailable, either due to an invalid guest configuration
-# or if the guest has not reached the required SEV state.
-#
 # Returns: The @SevLaunchMeasureInfo for the guest
 #
+# Errors:
+#     - If the launch measurement is unavailable, either due to an
+#       invalid guest configuration or if the guest has not reached
+#       the required SEV state, GenericError
+#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -210,12 +211,15 @@
 ##
 # @query-sev-capabilities:
 #
-# This command is used to get the SEV capabilities, and is only
-# supported on AMD X86 platforms with KVM enabled. If SEV is not
-# available on the platform an error will be returned.
+# Get SEV capabilities.
+#
+# This is only supported on AMD X86 platforms with KVM enabled.
 #
 # Returns: SevCapability objects.
 #
+# Errors:
+#     - If # SEV is not available on the platform, GenericError
+#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -234,11 +238,7 @@
 #
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object. SEV-SNP guests
-# do not support launch secret injection
-#
-# This will return an error if launch secret injection is not possible,
-# either due to an invalid guest configuration, or if the guest has not
-# reached the required SEV state.
+# do not support launch secret injection.
 #
 # @packet-header: the launch secret packet header encoded in base64
 #
@@ -246,6 +246,11 @@
 #
 # @gpa: the guest physical address where secret will be injected.
 #
+# Errors:
+#     - If launch secret injection is not possible, either due to
+#       an invalid guest configuration, or if the guest has not
+#       reached the required SEV state, GenericError
+#
 # Since: 6.0
 ##
 { 'command': 'sev-inject-launch-secret',
@@ -273,15 +278,17 @@
 # 'sev-guest' confidential virtualization object. The attestation
 # report for SEV-SNP guests is only available within the guest.
 #
-# This will return an error if the attestation report is
-# unavailable, either due to an invalid guest configuration
-# or if the guest has not reached the required SEV state.
-#
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
 #
 # Returns: SevAttestationReport objects.
 #
+# Errors:
+#     - This will return an error if the attestation report is
+#       unavailable, either due to an invalid guest configuration
+#       or if the guest has not reached the required SEV state,
+#       GenericError
+#
 # Since: 6.1
 #
 # .. qmp-example::
-- 
2.47.2



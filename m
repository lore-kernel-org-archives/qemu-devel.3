Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF02FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcN2-00089g-Hd; Thu, 15 May 2025 13:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcMz-0007wr-1s
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:45 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcMw-00024F-O2
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:44 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7418e182864so1404633b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330061; x=1747934861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBmZUu2xz9zNrRIusKpD96krKv5u2Eoq/yUy1aZuXB0=;
 b=mCox1a6WmeFsI3MyYOBtgyjSf8tgNAPytWjS0DlLQZeSpUHhOaZtf/ET2ksl8iB9ie
 +jUGkGE+IqB/xYy6ZxR42BHbmEafULzLa7CTFEBuKE+pMXqkaYKEXdhmmV+UtqmdWqYx
 C2xejM3ojOE9aV6xehvwY5sISUy+phjOADUP2jIqY3ZbYey7uH9Beg/EDNgodTUswx9M
 T1sS9k4L2Q6Dz/mDSMUyfUv1jfDLRwp9QOUV8NHybaVh5kHZrrfY8OjOeNrIIYlXv8Rk
 8lBdPolDqYww1R9n4T6+e6ykESPGgE/eX1hCnzYsi89zR+9ErNqlLgyk+l8o3hVFMn/5
 qtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330061; x=1747934861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JBmZUu2xz9zNrRIusKpD96krKv5u2Eoq/yUy1aZuXB0=;
 b=TEod77NubFkeI4wPEPdE2r9W5xQpo0fYkcXIMYev/W3fK1EhBdt16D5QKGU9/p6i69
 OC0uNrMjvuAx2E45dfggCNyOfy9uHnAW8uD7AtrM3YTzUW5oBDVOZuH3zIcrFrVag86C
 /gvK/qOMpxn5aWEcKMLA1wk4BabXfnNYh5pSbZh8FeWOH0c1W9OIatUTo5af3uIK/MqX
 tZTme3CZm9iNsx9H0CWVYrxp+SBezfBGW1ntAb0Qm9uSAewhUq+R1XGhP/3gjIwYZVDP
 rxJSey/4lCT2xjJi3ZkkfVrU1IuKscYoqXyr98e/mrDngk1IwjR3U/pENCeCNlAH5nWK
 CvZQ==
X-Gm-Message-State: AOJu0YyuTwUlEn/8OlUe6NQO40te1hMAc+VToeZZxTikFo2o894RsrHs
 N9xyTsciqT7vxNRGMy27hADiOxO1Zx5fRY3tlIZ8PMAGJxjaM5AzqFKbf2Wl5vlyYxXtuXLpmhd
 mGBtS
X-Gm-Gg: ASbGncvQWzvYKIRgyQDO3wPwIBpxQEdUH6PN3huVnR1kZQLVNGx+mYm9aiYmMCf7zqr
 M5+Q8M4mg44D1bOCm1i5tYIuM80i086kl9kRdI7RR7Q7fgbeY+G+9rkOvM/ktV815ep2xlP98Z7
 nTIijPBmiyVpxhohfdDb0CHqSiIFRkuYDHdb6eU+kXTUXduTDK5CslPu5zrSMZlUI5Zw/jVlvTk
 xpg0eF1m/Jh7DFI3kHaQBYhSLUGb+nj9PQfZ87gsLx1zk4ivX/trh0vaijDUJmaSBifxS+L7VJn
 rnos8GawANUumFXeaM1PHvnn400Cf96aHsDmp7c9NrHT3K117U8=
X-Google-Smtp-Source: AGHT+IELq9SA7KQR1g2Ym5f7G2VlBDX2XkV0Y47kkMWupvP298ItKC6fKg9NahH1UFoGTQBgVVm8xA==
X-Received: by 2002:a05:6a20:d493:b0:1f5:a3e8:64c1 with SMTP id
 adf61e73a8af0-2162166e6bemr566109637.0.1747330061221; 
 Thu, 15 May 2025 10:27:41 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 02/12] qapi: expand docs for SEV commands
Date: Thu, 15 May 2025 10:27:22 -0700
Message-ID: <20250515172732.3992504-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This gives some more context about the behaviour of the commands in
unsupported guest configuration or platform scenarios.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-target.json | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 5d0ffb0164f..ae55e437a5f 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -110,7 +110,11 @@
 ##
 # @query-sev:
 #
-# Returns information about SEV
+# Returns information about SEV/SEV-ES/SEV-SNP.
+#
+# If unavailable due to an incompatible configuration the
+# returned @enabled field will be set to 'false' and the
+# state of all other fields is undefined.
 #
 # Returns: @SevInfo
 #
@@ -141,7 +145,16 @@
 ##
 # @query-sev-launch-measure:
 #
-# Query the SEV guest launch information.
+# Query the SEV/SEV-ES guest launch information.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object. The launch
+# measurement for SEV-SNP guests is only available within
+# the guest.
+#
+# This will return an error if the launch measurement is
+# unavailable, either due to an invalid guest configuration
+# or if the guest has not reached the required SEV state.
 #
 # Returns: The @SevLaunchMeasureInfo for the guest
 #
@@ -185,8 +198,9 @@
 ##
 # @query-sev-capabilities:
 #
-# This command is used to get the SEV capabilities, and is supported
-# on AMD X86 platforms only.
+# This command is used to get the SEV capabilities, and is only
+# supported on AMD X86 platforms with KVM enabled. If SEV is not
+# available on the platform an error will be returned.
 #
 # Returns: SevCapability objects.
 #
@@ -205,7 +219,15 @@
 ##
 # @sev-inject-launch-secret:
 #
-# This command injects a secret blob into memory of SEV guest.
+# This command injects a secret blob into memory of a SEV/SEV-ES guest.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object. SEV-SNP guests
+# do not support launch secret injection
+#
+# This will return an error if launch secret injection is not possible,
+# either due to an invalid guest configuration, or if the guest has not
+# reached the required SEV state.
 #
 # @packet-header: the launch secret packet header encoded in base64
 #
@@ -236,8 +258,15 @@
 ##
 # @query-sev-attestation-report:
 #
-# This command is used to get the SEV attestation report, and is
-# supported on AMD X86 platforms only.
+# This command is used to get the SEV attestation report.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object. The attestation
+# report for SEV-SNP guests is only available within the guest.
+#
+# This will return an error if the attestation report is
+# unavailable, either due to an invalid guest configuration
+# or if the guest has not reached the required SEV state.
 #
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
-- 
2.47.2



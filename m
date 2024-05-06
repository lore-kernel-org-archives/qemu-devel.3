Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAF5C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wmr-0002EW-N7; Mon, 06 May 2024 07:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmU-0001q0-NJ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmL-0001t5-Rt
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iv0qu/DvouHMUWkJhrQofFhP1SlFQ9rAt+Y/ankr54U=; b=wzAmXBls+P8XEEE3Kc3Wdh5H5Q
 voHUvFR578+ssAmiTE6/yGKmwzGUoZ1iUfE9iiRAyF48aZWUHJFkLGhxKp3C3l+8FxlVMvORxkoxa
 y9cESB8oKjKerigqUdmGYcxD1ApZnagV8r1ZBl/MNH2oJzXf3rH6OGR7yNOsK8XfFf0tTc008/6Bh
 8yiw6RvQgl74rvB/nIny8/MKnCVMITpbdQKhVOiSqFbNK6vTKj9LAofNtVSgKwmkowoV8a5P0Agcc
 RnmHlZnVLev3eWoIkPaetwDalTihvq/3QZJq8kPIMwp7+j3b79lI4GF4nqdYoA6nkHXxNlgaDNzbU
 az7mqV0JY29USIYCJHLWFyyXhHRCiCYzBuxMLNMm0Nt7fVMGaQhEsiHoNy4/G5BVTbBztweidr7tE
 qRsfmlyQsk2zpFnfFo5eyS6d1HLqqj+whJoRM4ULi+flNnm0S+mumVSFNqyW/wNh+JkkcZ1/K1wCz
 kSYZO7RsLO3LSsOCa2vYYYXFQ1fXH15zZ9B6+/yoCuQkO/PmhT/ageKxodZnMSntYS3vYWwfHrQqw
 4wQvmWPSmJIESQrgJZD46HCiE1v/mNwM1uCSEYD0vqVZc/IT1mwkz+8BGYiu/4ojqXTLppazy4wSx
 P0TiVyWnfDi95Y+J9AI4VQaDWlu4hGoLOCUuE+K38=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wlC-0005pA-8v; Mon, 06 May 2024 12:44:02 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:40 +0100
Message-Id: <20240506114451.331311-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 01/12] target/sparc/cpu: Rename the CPU models with a "+" in
 their names
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Commit b447378e12 ("qom/object: Limit type names to alphanumerical ...")
cut down the amount of allowed characters for QOM types to a saner set.
The "+" character was meant to be included in this set, so we had to
add a hack there to still allow the legacy names of POWER and Sparc64
CPUs. However, instead of putting such a hack in the common QOM code,
there is a much better place to do this: The sparc_cpu_class_by_name()
function which is used to look up the names of all Sparc CPUs.
Thus let's finally get rid of the "+" in the Sparc CPU names, and provide
backward compatibility for the old names via some simple checks in the
sparc_cpu_class_by_name() function.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240419084812.504779-2-thuth@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 qom/object.c       |  8 --------
 target/sparc/cpu.c | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 44ec8f6460..157a45c5f8 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -157,14 +157,6 @@ static bool type_name_is_valid(const char *name)
                         "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                         "0123456789-_.");
 
-    /* Allow some legacy names with '+' in it for compatibility reasons */
-    if (name[plen] == '+') {
-        if (plen >= 17 && g_str_has_prefix(name, "Sun-UltraSparc-I")) {
-            /* Allow "Sun-UltraSparc-IV+" and "Sun-UltraSparc-IIIi+" */
-            return true;
-        }
-    }
-
     return plen == slen;
 }
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 485d416925..7487ae034d 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -314,7 +314,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES,
     },
     {
-        .name = "Sun UltraSparc IV+",
+        .name = "Sun UltraSparc IV plus",
         .iu_version = ((0x3eULL << 48) | (0x19ULL << 32) | (0x22ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_12,
@@ -323,7 +323,7 @@ static const sparc_def_t sparc_defs[] = {
         .features = CPU_DEFAULT_FEATURES | CPU_FEATURE_CMT,
     },
     {
-        .name = "Sun UltraSparc IIIi+",
+        .name = "Sun UltraSparc IIIi plus",
         .iu_version = ((0x3eULL << 48) | (0x22ULL << 32) | (0ULL << 24)),
         .fpu_version = 0x00000000,
         .mmu_version = mmu_us_3,
@@ -762,6 +762,16 @@ static ObjectClass *sparc_cpu_class_by_name(const char *cpu_model)
     char *typename;
 
     typename = sparc_cpu_type_name(cpu_model);
+
+    /* Fix up legacy names with '+' in it */
+    if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IV+"))) {
+        g_free(typename);
+        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IV-plus"));
+    } else if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIi+"))) {
+        g_free(typename);
+        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIi-plus"));
+    }
+
     oc = object_class_by_name(typename);
     g_free(typename);
     return oc;
-- 
2.39.2



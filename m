Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738B2C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONC-000130-QB; Tue, 01 Sep 2026 09:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONA-00011v-H3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:56 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON8-0007Bb-Tb
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:56 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c2531f453eeso727320266b.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268673; x=1788873473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Fwv5pyfNb8QZcfDc8HjkDq34cIxSmnuvmyZtBTjC3AA=;
 b=G/FVRfYwfmVk3EZFqmGxhmqiEMRqt4+8lq3wCeheNQRklo87DyBIdvaxNK+069GKku
 enbwW92G6C0z/gLhUj792XVvd/kcfPopmLwMgZacZe1EV+fbaLHXyhmAzPS3aOkz4j+k
 NPQzyPxEIwQILxVgJgD/NygzC1smEHIonB6ivJgLHbgJ6JEC/IC0TUgA3MH0MJN+GqaM
 /mH4348OwMgVBbgEgczrRpX9g7diYRFW2zlObTVEPOXLkaeJXKOm8zZEVtH9qcl7G04l
 jjCLyzD+QczmG2vyoxwbYkdNcVq7H7zg9ZGn+6s6lAdcJIHo4NtD3/Ly6KZrTAz1tYTN
 Kj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268673; x=1788873473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Fwv5pyfNb8QZcfDc8HjkDq34cIxSmnuvmyZtBTjC3AA=;
 b=DVSzzuxDmjRkF9qKgWX0S0gQ2V2gFZx2kXfI6KnHcOhoG90oLpDmHa2NHIW9+ct4fc
 bFzg5dHeF7VCAAqoI4YsYOJ29n7Rs5cMWNfEOA9uUPxCDHnhq122wyD6lkKlo4/agpmA
 YFKDBtEhczBUKlRiZIZmxXk7x5p7Iro4Zh3YIms2PIBbAr/8tFLGpVQVNMUnB5YAURO6
 cmW2kiE/cvy822t/9nTmegcygvQg2xfE2JruSpVgYoya2h0H1YNvV1p0GCTjy6sreGsU
 M02eP4EJALhe/T1yxVM+4vcm/1UWqy+bvgzbUUhK5OoSTcoiXfiWNs0yBNZhWMj9drsj
 QHrQ==
X-Gm-Message-State: AFuF++m16G4u1sO++/2R3cm+PT7DkcGI2tG0X33wnLdG+v/Iuw0KoxzV
 B3ots+eUopFqgrJl9a00zQwQKjfvv8RWTamWFRa4hNIPiivjWr8yd9RELirTTF7zzwr5KMMoNcl
 ls8qy2aY=
X-Gm-Gg: AR+sD1058XvFfkK4VlVVnt5Y7QiNwkLDn/9HXftifLAfC56GKbFN5GjAa7VaSyikz6M
 c3vxA7mJyDEn3svkc/at8LaIIcQhuUcnEo0aqeSnn0RUdXvyc+bvFPM/e4ToTSdNPcqiGUO417c
 NNDfKuCRP3gbpNQonM+8sOrLHaw8CewokACmWkXooki9Mukj8Zq+CgOFIkKpZ/8MDPV1U5AtaDT
 Ia4OzU1hpfO9wzTkUTDfs/e1iQ8U8p/Tnsz4dr2JQQyPtdOxw/uYKljojr/OMuut1Y3mVTo8B7S
 9r3ktXgJJ6x1z5fcx/Qtycr8ZV3MQapY9IeayTRBXMJsFMk4lpkg8O/H8mNd04cCa4O7TJSjn0I
 8S1iF0ls83wN3DOMpk3XfML604xS9GCqeBh9nQuYwKgQp6nEweNFzPBgkQA4mUWCQ/MKsYky4PJ
 czkkJ0NhpLe5gJOHUZzV+1pgFX2dKFQDIu1LqRArMPFQ8kQApTUUV/nhdHnfplfls9tnJXk4NWd
 TSxFC3vRtLwyjjMYvRELDiKVXzFUlpw6mw8CF53nd+/LAQWobZcCW8wnFIJZth1GdwiaK3UIIcy
 C7Zy
X-Received: by 2002:a17:907:3d56:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c25b3bb9089mr581095266b.2.1788268673508; 
 Tue, 01 Sep 2026 06:17:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/58] hw/misc/iotkit-sysinfo.c: add SSE-310 support
Date: Tue,  1 Sep 2026 14:16:53 +0100
Message-ID: <20260901131732.2263947-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Simon Xu <simonxhy0404@gmail.com>

Add SSE-310 PIDR and CIDR registers. Add sys_config2 register and
always report 0 on read as we do not implement the NPU.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260805153005.9989-8-simonxhy0404@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/iotkit-sysinfo.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
index 19f089e6ee9..f3d07f32474 100644
--- a/hw/misc/iotkit-sysinfo.c
+++ b/hw/misc/iotkit-sysinfo.c
@@ -31,6 +31,7 @@
 REG32(SYS_VERSION, 0x0)
 REG32(SYS_CONFIG, 0x4)
 REG32(SYS_CONFIG1, 0x8)
+REG32(SYS_CONFIG2, 0xc)
 REG32(IIDR, 0xfc8)
 REG32(PID4, 0xfd0)
 REG32(PID5, 0xfd4)
@@ -58,6 +59,12 @@ static const int sysinfo_sse300_id[] = {
     0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
 };
 
+static const int sysinfo_sse310_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x58, 0xb8, 0x2b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
 static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
@@ -68,13 +75,22 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
     case A_SYS_VERSION:
         r = s->sys_version;
         break;
-
     case A_SYS_CONFIG:
         r = s->sys_config;
         break;
     case A_SYS_CONFIG1:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
+            return 0;
+            break;
+        default:
+            goto bad_read;
+        }
+        break;
+    case A_SYS_CONFIG2:
+        switch (s->sse_version) {
+        case ARMSSE_SSE310:
             return 0;
             break;
         default:
@@ -84,6 +100,7 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
     case A_IIDR:
         switch (s->sse_version) {
         case ARMSSE_SSE300:
+        case ARMSSE_SSE310:
             return s->iidr;
             break;
         default:
@@ -95,6 +112,9 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
         case ARMSSE_SSE300:
             r = sysinfo_sse300_id[(offset - A_PID4) / 4];
             break;
+        case ARMSSE_SSE310:
+            r = sysinfo_sse310_id[(offset - A_PID4) / 4];
+            break;
         default:
             r = sysinfo_id[(offset - A_PID4) / 4];
             break;
-- 
2.43.0



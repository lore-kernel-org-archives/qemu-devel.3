Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F13C54736
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siuIn-0002pg-MJ; Tue, 27 Aug 2024 07:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIl-0002i9-QV
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:55 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siuIj-0000k0-Qm
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:23:55 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8682bb5e79so710612066b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724757832; x=1725362632; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6023lRD220fUKA6bf48jqfG/QjqXt5noiDcRHVXsjQg=;
 b=OtaTYarLKejGprqzKHe5CrLzYGEMa2aIZhjM0+FuHSga1I3Lqt9E0RTbQkuYRjzowl
 w8RzKMCSCZ/CHe/Rsn21Ghp79M4zKZQhyFpAq6sBrIQGCQPAwFP38OXLN1C6K+oUkTsL
 HHe5dvXQ5a267d1J0Q70NYB8/jNFvKZY4rA0s1t17453XSyBtNRwryPTM7z6Mv5OUtqc
 V0KwMGxZ7EnFMWgySNDvjjD770EHXSAid1f+cCssnKPO9BOcKvbcri2QVUxKFdzB87pu
 xcx3oInvhMaeACem/+DOYVO/rBeBiOHnKdchkm3iWKiLmtmx+ldhLJ+ptyYXvNPWpAZY
 XewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724757832; x=1725362632;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6023lRD220fUKA6bf48jqfG/QjqXt5noiDcRHVXsjQg=;
 b=f8F2p2Z1xTTeBfVuWM/aENWdECdg1uPCMiq5tIIIFzgqJ7KiqsFGq+SnUTRyaNAeoG
 ZhdQlt8LimvG9QPgcMiHB+KMOhqfvqn0brBBEBKPfh2+E+JDCSNd+RIWATjX5XqoCXv8
 2C1oTtJDJB1xlkUZtiae/eczEsVmszhAfPpep22EHZaHwnCJoGBPaFCML+6vdjUrliy3
 3Q9C+VHs+xhwrMmW4wExyTz1HlHRNR0OiQEUiCPjSyBkByP6blvYP6bQQCiu2WWtusIA
 +eeSxtM2eprjHUWXKs+AI2s+kEl6chKwLxjIMR6IYHII9uk6vk2gOx3GrdfSuK017bdx
 x4HQ==
X-Gm-Message-State: AOJu0YxnNFmd1jF80pVLvIUOCL3Hie6m4frVkMedTfNJ9F8AA0uHWyjY
 eKFG4qq2EXgT/0YzOxVndpa/8fQKLn017KGwgFafPeHiyc/HxR5JCsj8i+4cRpg=
X-Google-Smtp-Source: AGHT+IEaXlbsewDN3gBqdWwnjzEcwhaVvmrvDDcVMFjl2LpNb0VNaqI6jlIaAvrZa0PdDEczhAwBGQ==
X-Received: by 2002:a17:907:e646:b0:a86:89ea:ee6c with SMTP id
 a640c23a62f3a-a86a52de5d5mr1012626066b.30.1724757831988; 
 Tue, 27 Aug 2024 04:23:51 -0700 (PDT)
Received: from [127.0.1.1] (adsl-242.37.6.163.tellas.gr. [37.6.163.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594fa62sm96280066b.198.2024.08.27.04.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 04:23:51 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 27 Aug 2024 14:23:15 +0300
Subject: [PATCH v9 6/9] meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-rust-pl011-v9-6-e90b9c28f861@linaro.org>
References: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
In-Reply-To: <20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=BHZl+cDvjx6vCSPrL4UwCDjF/NsyQKlyuKtsv2MOHNE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16YmMwRXJUWFVrOGg3allLZ3lici9qYlZ2MHdNClVxTXpOM2drYnM3R2Q0bDNE
 bkNKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnMyM05BQUt
 DUkIzS2Nkd2YzNEowTk5aRUFDSVFUN2hka0w5UlpzcGZPYUlFVXlvQ21oUmF5aWZhUWpXSmV4aQ
 pzOFhzUmFCazhiTnhQazZuVzMwcXd3d2pPcFRPUDlqMUlhaTZiMjBXRkdIQXBHMVN4ZGo4dDR4S
 i9LNWUwV0Z6Ck16eG5BWlZvSklGMTljMmZmOUcrald3dWJ4NHlFZ2JaUkJubUR0SmRYUFdOUlg0
 VGd6SFlvd0prNVZPNUN2cnoKSjBmNDVFcDJNUTdCcGpRYklyMTg5RGlYVGxPUHlpbXFuOTVlTzh
 rdE5ZOTlna3lTZkVaRzQ3dmpVdFBPTTc0Zgp2WUVGOUJMQlhkSmNoSlZwcWtNeGRsL1JrNVlybn
 NVRXNHNWp4anowQnlxS3pmeHQxTzBDRFhzMzh1dTZYb3hkCkJ3L3ZHenVBeXZnN3dNdVUvcENoR
 GlTa1FtYTN0ZDYyc1lHV3dxQ1ZUS1JocFhTR1krM2E5aWJpQXlWRTliWlUKbDh1alpTWUNtM1dT
 Uy9qSUtqZE5zTkQ1T2ltQnVtVzlPNzdWUVVBQ3RIVXI2MnBrL1krZ3JMWGMyMnFWUStVcwo5MEJ
 uQlg3Ly9VWmtZWUJzVGtaeEdreWZBUll4cEJYRzFOWUtUSU5oaTdEMmZ2dklrdFZmSVFQTTI3WX
 R0S0N3CmVHZlEzbGd6ZHVsQUNhYmVWQmhScC9aMHNSNWxNQVRTNzd6c29xMmNXT1p6ZUhWcmxWL
 zduWm5McUtjemMramEKRjYyeTJ5SlcrSkU4OUtPMnJKTEpHY2tsSkhvQ0x2b1ZiKzR4SGs0dis1
 M2g2S3F1SHp2Q2pHbDlaMDlmc0ZvTgp6dktUOE42SGdFbzByV28yLzZaWXNqWUIzV2pLN1RBcEN
 FUjFSdWg5ck1LL0ZNYWNqNTJLL3RoRG45MTNYQmM4CldYTDhYUT09Cj0wb3JuCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rust crates, introduced from the next commit onwards, use the glib
allocator API and need to know whether g_aligned_alloc etc are
available.

This commit adds a define in config_host_data that depends on glib
version >= 2.72.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index 05446acbc6..7f05466d12 100644
--- a/meson.build
+++ b/meson.build
@@ -979,6 +979,9 @@ glib = declare_dependency(dependencies: [glib_pc, gmodule],
 # TODO: remove this check and the corresponding workaround (qtree) when
 # the minimum supported glib is >= 2.75.3
 glib_has_gslice = glib.version().version_compare('<2.75.3')
+# Check whether glib has the aligned_alloc family of functions.
+# <https://docs.gtk.org/glib/func.aligned_alloc.html>
+glib_has_aligned_alloc = glib.version().version_compare('>=2.72.0')
 
 # override glib dep to include the above refinements
 meson.override_dependency('glib-2.0', glib)
@@ -2508,6 +2511,7 @@ config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create'))
 config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
 config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
+config_host_data.set('HAVE_GLIB_WITH_ALIGNED_ALLOC', glib_has_aligned_alloc)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))

-- 
2.45.2



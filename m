Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A89DC5474E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 04:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjA2v-0006AN-4T; Wed, 28 Aug 2024 00:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2n-0005kq-JN
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:31 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2l-0000m9-GN
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:29 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5bec4fc82b0so327342a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 21:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724818346; x=1725423146; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5XXJiXERznBbe2Mo2VGN/xNFPalflSWfdtbpmX6ccVY=;
 b=b4Zd/Y+sPS5TVkXknSc5vWjEVPm6cwiDOqN2fN9O22tmsieZBi3Ggl2utnm0Zuzs4F
 1l4bRXoqqBNVfCZE8l+hhDKDu4KoBQ/uyUeFgcicjGwHwxTcmumeiKxiEfMzwU+EcaJH
 hEpdec5b5cnbaxlna9QhDe947uE7+WHdh/isEXOpM4kl385hW6wC8zbVwho5M6DuWU5p
 aMYxPiCqiaKwpcORaQ5KEHif1MNDpYZYAcUpIsxIfBmDQwrJ6gjD0ef1XufmjHgrYV2P
 2Ggl6I0TPgFmJ/8GRxSD/M0ikq5P84Y2JLKoU0TyeAMfxk9pSLiLwcBpXIyWlRgFZQMi
 2K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724818346; x=1725423146;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XXJiXERznBbe2Mo2VGN/xNFPalflSWfdtbpmX6ccVY=;
 b=Pij+TNJozjgzvLfZhvfrgGOMQCMBsYSnH205g/wbnaaB9u+wthLRqdv82I5yDRXUAX
 ldeEfS8JhoE2KIRPPt2X9yEW5r4JqGM8UhXPjMSS5PKsmlmgwYyamM0tcxxh5JQeisZY
 3yOmoBwPwqXP9j0uWDxagmhAE1o2uGVUDSgqdxsMjD8tZTn4pfGZ8Z0z/V/eF9JLyRgX
 xXu/rrSzwNT+4MdRU/WqDp/rq1vuiJPqHSd2gMoXCAYTGwlijo+DB8lsgNiW1R06k4Rk
 9U45+CeIy97FCQ1BODdxEfOwT8Di71ZwhxyzJdeKoff2Rn0zxE62cnvl0QY9fNkzLI91
 Hz5w==
X-Gm-Message-State: AOJu0YwFR+3qcefE6ogqvY7fgbzfEHVBnDEymYeTQrtxcvAAzLnUoVsW
 D8eO29P5AdaKH75Fti0OF6iPRx3bx/ozSYExQOCYPuXqTKGJEuVvX7tLba2+YXs=
X-Google-Smtp-Source: AGHT+IHOYjEaxmdaiXBY7N9GbkdeDZfZVN2F3sLw/HGKwypfRG0THc9O33akkdI5yen5DeQaOq/r5A==
X-Received: by 2002:a05:6402:2709:b0:5c0:c6a7:1c58 with SMTP id
 4fb4d7f45d1cf-5c212ab30a0mr785096a12.15.1724818345591; 
 Tue, 27 Aug 2024 21:12:25 -0700 (PDT)
Received: from [127.0.1.1] (adsl-98.109.242.227.tellas.gr. [109.242.227.98])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb1c29b9sm1712814a12.18.2024.08.27.21.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 21:12:25 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 28 Aug 2024 07:11:47 +0300
Subject: [PATCH RESEND v9 6/9] meson.build: add
 HAVE_GLIB_WITH_ALIGNED_ALLOC flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-rust-pl011-v9-6-35579191f17c@linaro.org>
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
In-Reply-To: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
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
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=m74JGdAON2yLb93RBa4Z+R4byBd/4OHukWLHC7W6c78=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16cU9MUktHK3diTXd3ZkFkci9QWGNocEc4S3cyCnRzS1VTbER3aG1LbXFTYVlW
 OUdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnM2aml3QUt
 DUkIzS2Nkd2YzNEowRkNYRC85Q3VENStia2FVVTdiT29ZeWhuc25Yck9YTXQ4eEM4WUxLVnlKVg
 owV0FPRFFOaTZtcWlhcW1IR2I1dFN5MCtmUURlaFBsSTFzeDZCVlZmcnJDN0NIK0NNd040SCtwO
 WF1ZUpaT1h5CkhWZnBkQUptb1hadUd2bzRmdzN2ZE0xWjZMZXAzemVEdUhnOXVlMlF5S2dScHV6
 ZEFpNWFweGQ1WmhYVlJCT1EKcGpaZW9Bc0Y3dFJTblVCM01La0p3YllQeDRsZDVseEdBbkRzTE9
 qdGZIcUJBVy9sckRCNzR5OGs4YzdWQnRFcwpTR0Rhamt2ZTZKdFBySTRZWklNMEdxMmh2NXp6Ni
 9hUFZDV3ZGN1ZSV1I5QVBHMExzRDdsY2N5QVE2aTdIMEJiCkFxTnI1TnZ2Nm43MHBYUTFGdloyN
 2RPWFN3bHdhU2JoR1RlQmJha3JzdklSaVNGOWEyYTJvc1dXcTVwa3BQcTMKQ1QzamNuN0VaSDNB
 OC92YmFiQ09ucGtURGdVL2h5WmFNR1NxRmJxdm5vL1Q4QW1RNE5tNzJRekxieW9WbWVZTQpiWlg
 5RHFHQVhuNE4zUmlyMm5sM2lkdlByZnliWXJZNml2Vklmbm4yRGFwR3A1TEhYQlQvWVk3ejlxcX
 c0clBlCmt1aVB1Zm5PTG4vREo2VitMM3l4ZEtmdStkVG9YZTVIU29tV2RkMHV6TWQvdTAySVdYN
 klKTk81SS9iREVtOGwKN1hIaUtJOEtIVm9YTmFrU3FBUXZnVUZHRFpSQzBvbDJ1aGVRQmNkb2hG
 Tmw3bGhIUUlzZnQvZHNtSVNYbDFYUApBcFRibXFxeU9FRE1ad21oN2EwNUdIYXlLMi9NZlVXeFN
 5aHY3SVlaQmlZcmpsY3djT2ljeW5KSWowUnU2aURzCm0rVDlhdz09Cj1ETHVhCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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
index 05446acbc684a7521ecc9b3f80b98e2cec1a60cf..7f05466d128776ad8dbf403179734e6831b023c0 100644
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



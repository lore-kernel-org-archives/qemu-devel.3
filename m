Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55174C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetgX-0008Fu-0Q; Thu, 24 Jul 2025 07:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetg4-0007Yn-QL
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:57 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetg2-00080A-3s
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:55 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae360b6249fso138741766b.1
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354792; x=1753959592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGQBWOlnSO+u36nuiqLHxBfdpHNix5/UwaTMVfh1iWw=;
 b=ip8YSaHfbybaVrAFaFsvkfHO5lb5Qqnqw83WfLBSZ1tMKtDWwjwxqqGdWXnaZNneAj
 gYVnrY73ZSH1biLy5iA+uxNeao3nYdxM2Wu/xZCxG0625EgL+KxwOLOeRUFCLdf+5K38
 sKmGrvo61IvkKjsdoDXtfWfFHI6tTAHetTDVmkJ2VzEAPJuxliYJl1IVij6xi1a4RbYE
 HdZv6Fb3rzzoCwQtMfeY8hA50QbtWhUHMAd75bcK4wsgVVWbY6QWEO1vANNOA/oQXt0Q
 ALG/PuzPL/niLV5GrSduEkQsWlq/2mXGjdhf7sP7b9HHkReHoGWuFipkjLGSlJxCmyPL
 ogEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354792; x=1753959592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGQBWOlnSO+u36nuiqLHxBfdpHNix5/UwaTMVfh1iWw=;
 b=n+EHXf20g5j11/bWEGzKT7i9+ghz6/cgepm6T31Zpx/PQz1QAT1oRqJrZb9Ad9LKe/
 tvqg4ki3U8ufwAvnO5A6B5yF54R+E+V413f7l3mvTUBbBa0NIc/oGzOJKSXYZ0jojS6S
 kbY3olHJhdRqYkeiklaF6WhDRE6GAOysIQuJBGkeBTOEpoG4DVLh/v0k/D6c1gEN/+Lu
 Rs8ACBNifpqP8Iqu26LocZk5knx0f9Q5f8nFC79ZTzmE9rvH0QgICBD0fcFbULFtH9+F
 lIjBUjkAK9LCKcMcU7H/3YxLnJhEe34vVH4fWqqPtgRuvShzqRVccd5gNYeVSJpLhz1M
 UiHA==
X-Gm-Message-State: AOJu0YwGVsG8ZU1LU86ovLqDSwfuCI5WOQv3DDOptWwZFoEsM4u5IgdB
 f3qam+PwAcBGbjGhHPRTUAjrPCp5+YViX0jbzQ7m578j37wXVAuNF6fRjPECn7KEvV8=
X-Gm-Gg: ASbGncvUp2RvKEqYukzm9gMCQJJQtzDqfnAOgvd62xfXMZQVCZs6DK6ww7FWoN6ysiq
 cSyool/9QkrY5OkCO7XoBcvG7h/rIadwWcZ7rnnXqy4fdjBvaUPLbN8W5DLzGK9yREFX1ZMYIRI
 YExm6sh3ZBdnFhKgoL/bw1L4mR5oGukSZpndrS4VqHNoqtt2krffnyRoloYvl+c7hoNHXeiLkSi
 Of0inkPM9NdQ5Od005Hduqra0PliSCG7DvOqN3yLb+GB51N1blPteGCildlq4zpfBYVDlpeqsOZ
 zDfRePsBnGcDRfD4rsh+imvTX0k414oDj8LlPUm8zbUKoGn0bvwRPdevk5JpGxyePIOzPNqlE5A
 EK+wrWpwiJ6t9x9BZb61YjmTU/qN9P89LDQ==
X-Google-Smtp-Source: AGHT+IF3vw9GpvYsQpQsRJRhA7PWw5t+3YoDXI3ejx2rocRESGQDIe3yd/0baeWO+vf0uBI274oKDQ==
X-Received: by 2002:a17:906:d542:b0:ad8:9c97:c2e5 with SMTP id
 a640c23a62f3a-af2f30e1192mr647170166b.0.1753354792400; 
 Thu, 24 Jul 2025 03:59:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-614cd2fd3c7sm707506a12.33.2025.07.24.03.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1AE965F8F3;
 Thu, 24 Jul 2025 11:59:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH for 10.1 13/13] tests/docker: handle host-arch selection for
 all-test-cross
Date: Thu, 24 Jul 2025 11:59:39 +0100
Message-ID: <20250724105939.2393230-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

When building on non-x86 we get a bunch but not all of the compilers.
Handle this in the Dockerfile by probing the arch and expanding the
list available.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles/debian-all-test-cross.docker  | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 5aa43749ebe..16a83241270 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -23,7 +23,9 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         bison \
         ccache \
         clang  \
+        dpkg-dev \
         flex \
+        gcc \
         git \
         libclang-rt-dev \
         ninja-build \
@@ -33,16 +35,11 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         python3-venv \
         python3-wheel
 
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-        apt install -y --no-install-recommends \
-        gcc-aarch64-linux-gnu \
+# All the generally available compilers
+ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
         libc6-dev-arm64-cross \
         gcc-arm-linux-gnueabihf \
         libc6-dev-armhf-cross \
-        gcc-hppa-linux-gnu \
-        libc6-dev-hppa-cross \
-        gcc-m68k-linux-gnu \
-        libc6-dev-m68k-cross \
         gcc-mips-linux-gnu \
         libc6-dev-mips-cross \
         gcc-mips64-linux-gnuabi64 \
@@ -51,18 +48,24 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libc6-dev-mips64el-cross \
         gcc-mipsel-linux-gnu \
         libc6-dev-mipsel-cross \
-        gcc-powerpc-linux-gnu \
-        libc6-dev-powerpc-cross \
-        gcc-powerpc64-linux-gnu \
-        libc6-dev-ppc64-cross \
         gcc-powerpc64le-linux-gnu \
         libc6-dev-ppc64el-cross \
         gcc-riscv64-linux-gnu \
         libc6-dev-riscv64-cross \
         gcc-s390x-linux-gnu \
-        libc6-dev-s390x-cross \
-        gcc-sparc64-linux-gnu \
-        libc6-dev-sparc64-cross && \
+        libc6-dev-s390x-cross
+
+RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; fi
+RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; fi
+RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; fi
+RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; fi
+RUN if dpkg-architecture -e amd64; then export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; fi
+
+RUN echo "compilers: ${AVAILABLE_COMPILERS}"
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+        apt install -y --no-install-recommends \
+        ${AVAILABLE_COMPILERS} && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 
-- 
2.47.2



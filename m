Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03F2C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 12:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7wf4-0004z1-Qr; Fri, 17 May 2024 08:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7wf1-0004u8-BM
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7wez-0006H6-L7
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715948763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOAR1PoMiECTQnNirSl/2aD8b9nynHOIiEx9kpCqQ7U=;
 b=EgBsb6RPKJSBJNoqTg5UwvVi6Vk7ih6phY3fmDofbU0liTSW1q4VwK9zz3i734fjtIdAWf
 Z1BFOtm2kWH2nV+1DIptwvpM3x3RG6mYlIHxa3ARhiSrXszMsF9BeQ7M27kIR1S5rQO5FV
 yL8Mr0IQ3cNmoJGxpjpozxls02D03mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-7lHM7d_eMqaGn9bOTArPMw-1; Fri, 17 May 2024 08:26:00 -0400
X-MC-Unique: 7lHM7d_eMqaGn9bOTArPMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B331F800CB0;
 Fri, 17 May 2024 12:25:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E72861050173;
 Fri, 17 May 2024 12:25:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 4/6] tests/lcitool/projects/qemu.yml: Sort entries
 alphabetically again
Date: Fri, 17 May 2024 14:25:50 +0200
Message-ID: <20240517122552.584215-5-thuth@redhat.com>
In-Reply-To: <20240517122552.584215-1-thuth@redhat.com>
References: <20240517122552.584215-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let's try to keep the entries in alphabetical order here!

Message-ID: <20240516084059.511463-5-thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/projects/qemu.yml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index b63b6bd850..7511ec7ccb 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -35,8 +35,8 @@ packages:
  - hostname
  - json-c
  - libaio
- - libattr
  - libasan
+ - libattr
  - libbpf
  - libc-static
  - libcacard
@@ -54,6 +54,7 @@ packages:
  - libjpeg
  - libnfs
  - libnuma
+ - libpipewire-dev
  - libpmem
  - libpng
  - librbd
@@ -73,27 +74,26 @@ packages:
  - llvm
  - lttng-ust
  - lzo
+ - make
+ - mesa-libgbm
+ - meson
  - mtools
+ - ncursesw
  - netcat
  - nettle
  - ninja
  - nsis
- - make
- - mesa-libgbm
- - meson
- - ncursesw
  - pam
  - pcre-static
  - pixman
- - libpipewire-dev
  - pkg-config
  - pulseaudio
  - python3
- - python3-PyYAML
  - python3-numpy
  - python3-opencv
  - python3-pillow
  - python3-pip
+ - python3-PyYAML
  - python3-sphinx
  - python3-sphinx-rtd-theme
  - python3-sqlite3
@@ -121,6 +121,6 @@ packages:
  - which
  - xen
  - xorriso
- - zstdtools
  - zlib
  - zlib-static
+ - zstdtools
-- 
2.45.0



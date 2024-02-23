Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852D3C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbgp-0000ix-BL; Fri, 23 Feb 2024 14:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawG-0005nF-UQ
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdawA-0005Dz-2V
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6849bzPsRNSG+m7rBaT3t7p6WGO/m0rCc0KP5ao5Uw=;
 b=g+lLdxVrYi2nRZaE1WgVuHno6yg7Gky3q64BRkUqwNNDmRV1Qjjzp0GsrhMOyfhX+AeSMe
 wQaPiMzeU3fKVPDDN+LLzHATm6VQTPFaqewSUCpj8VHTLpRk0RVuAeDhYDjAN+OlqlRTQO
 IgG0xawuUJBtBQu7ABBXpDHbP9qpd40=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-TgeC-YOmPM2D_x9Y3H_vqg-1; Fri, 23 Feb 2024 14:10:16 -0500
X-MC-Unique: TgeC-YOmPM2D_x9Y3H_vqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EAE585A589;
 Fri, 23 Feb 2024 19:10:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35C698CED;
 Fri, 23 Feb 2024 19:10:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/11] docs: Document that 32-bit Windows is unsupported
Date: Fri, 23 Feb 2024 20:10:00 +0100
Message-ID: <20240223191003.6268-9-thuth@redhat.com>
In-Reply-To: <20240223191003.6268-1-thuth@redhat.com>
References: <20240223191003.6268-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240222130920.362517-2-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/build-platforms.rst  |  2 ++
 docs/about/removed-features.rst | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index f2a7aec56f..8fd7da140a 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -139,6 +139,8 @@ unprivileged accounts can create symlinks if Developer Mode is enabled.
 When Developer Mode is not available/enabled, the SeCreateSymbolicLinkPrivilege
 privilege is required, or the process must be run as an administrator.
 
+Only 64-bit Windows is supported.
+
 .. _Homebrew: https://brew.sh/
 .. _MacPorts: https://www.macports.org/
 .. _MSYS2: https://www.msys2.org/
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 54081a6c19..417a0e4fa1 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -659,6 +659,21 @@ This command didn't produce any output already. Removed with no replacement.
 The ``singlestep`` command has been replaced by the ``one-insn-per-tb``
 command, which has the same behaviour but a less misleading name.
 
+Host Architectures
+------------------
+
+System emulation on 32-bit Windows hosts (removed in 9.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Windows 11 has no support for 32-bit host installs, and Windows 10 did
+not support new 32-bit installs, only upgrades. 32-bit Windows support
+has now been dropped by the MSYS2 project. QEMU also is deprecating
+and dropping support for 32-bit x86 host deployments in
+general. 32-bit Windows is therefore no longer a supported host for
+QEMU.  Since all recent x86 hardware from the past >10 years is
+capable of the 64-bit x86 extensions, a corresponding 64-bit OS should
+be used instead.
+
 Guest Emulator ISAs
 -------------------
 
-- 
2.43.2



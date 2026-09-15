Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FF0C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Otu-00051e-Lt; Tue, 15 Sep 2026 04:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6Ots-00050p-6g
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6Otq-0002hk-2L
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789462340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kipJoAtxrSWpipOgAqk6DErFdBblRpYNq0GKxlR0BKE=;
 b=QeOQmHQKS1VIRQOSiwovYkrtHv0hcZoMudentUQ4Gz8luErzEhSPJFD6i6lw1kuKmx6JaK
 gz9XvoaatzvS1T2z7dFAOKh+LmI1sZscNlQU5ic34K1DcSqKs5wx1UgjA3arZzwgWG8yFj
 utjXg8jgQM2S3V8ey9voD+NQPfGQdiE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-XD2pIHeoN9S7aSRFU1O6ow-1; Tue,
 15 Sep 2026 04:52:18 -0400
X-MC-Unique: XD2pIHeoN9S7aSRFU1O6ow-1
X-Mimecast-MFC-AGG-ID: XD2pIHeoN9S7aSRFU1O6ow_1789462337
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DF64195420C; Tue, 15 Sep 2026 08:52:17 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 303F7426; Tue, 15 Sep 2026 08:52:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/5] Bump min compiler versions again
Date: Tue, 15 Sep 2026 09:52:08 +0100
Message-ID: <20260915085213.139944-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

With the security policy we want to rely on usage of
the -ftrivial-auto-var-init=zero flag to declare
bugs "not a CVE" if they rely on uninitialized stack
variables.

This arg is only supported by  CLang 17 or GCC 12 though,
both of which are beyond our current min versions.

This series bumps both CLang and GCC to enable this.

The GCC bump is technically something we shouldn't do per
our platform support matrix, as the system compiler in our
targetted releases of NetBSD, remains GCC 10.4

This series considers it reasonable to bend the rules
slightly, as NetBSD does have new enough CLang, and also
ships newer GCC as non-system compilers.

Also historically the macOS XCode versions reported by
clang did not appear to align with upstream CLang versions
so we checked versions separately for macOS.

With this set of patches we happen to end up on 17.0 for
both upstream CLang and macOS Clang, and this makes me
wonder if we can rely on aligned versions going forward ?

Latest XCode 26.6 apparently reports clang 21.0.0 which
appears to be a match for a modern llvm release.

Daniel P. Berrangé (5):
  tests/vm: drop redundant ';' at end of each shell command
  meson: simplify clang version checks
  meson: bump min XCode CLang to 17.0
  meson: bump min upstream CLang to 17.0
  meson: bump min GCC to 12.0

 meson.build     | 12 ++++++------
 tests/vm/netbsd | 17 +++++++++++------
 2 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.55.0



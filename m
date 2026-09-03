Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04BBC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24nc-0002XN-6a; Thu, 03 Sep 2026 06:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x24nX-0002WA-Dx
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x24nV-0005Qs-P1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788431756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sTruB7GUkNSN2vhOvTQsMrknaI6QBjzdEW1k/ClI89E=;
 b=HejAmp9OGWrhuHomit6W6qiPVF5hipUZ5IJF2eLDWTgBWSowL5yO7zzAT2bvSdN5NuebHo
 Maw89gRTS8N3r0Q02Wf3bVt7pwV5vHv7ievhs7Q6+/0LowCLX0/D8kCZlAehlNJ1z5QgSS
 AtZQuE7vdBqi8zUvd4PIYjM3qK/if0g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-hAfcMwO8OM6tBXm2BPdpNA-1; Thu,
 03 Sep 2026 06:35:53 -0400
X-MC-Unique: hAfcMwO8OM6tBXm2BPdpNA-1
X-Mimecast-MFC-AGG-ID: hAfcMwO8OM6tBXm2BPdpNA_1788431752
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B32781944DE2; Thu,  3 Sep 2026 10:35:51 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E539E18005AD; Thu,  3 Sep 2026 10:35:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/4] Bump min compiler versions again
Date: Thu,  3 Sep 2026 11:35:44 +0100
Message-ID: <20260903103548.2142568-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series bumps CLang to enable this, but we can't
bump GCC far enough due to the NetBSD constraint due to
its system GCC being 10.x. They do have newer GCC in the
pkg-src as non-default add-ons but we mostly stick with
default system versions.

We could bump to 12.x and force NetBSD users into use of
the non-default versions, but the last patch took the view
that we can just warn that use of old GCC versions takes
you outside the security policy.  If people prefer the
former though, I can respin.

Also historically the macOS XCode versions reported by
clang did not appear to align with upstream CLang versions
so we checked versions separately for macOS.

With this set of patches we happen to end up on 17.0 for
both upstream CLang and macOS Clang, and this makes me
wonder if we can rely on aligned versions going forward ?

Latest XCode 26.6 apparently reports clang 21.0.0 which
appears to be a match for a modern llvm release.

I'm no macOS expert though so looking for feedback from
people with more direct knowledge.

Daniel P. Berrangé (4):
  meson: simplify clang version checks
  meson: bump min XCode CLang to 17.0
  meson: bump min upstream CLang to 17.0
  meson: warn on GCC < 12.0 due to lack of -ftrivial-auto-var-init=zero

 meson.build | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.55.0



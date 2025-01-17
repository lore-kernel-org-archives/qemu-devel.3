Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82C0C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYja3-0001kW-Bx; Fri, 17 Jan 2025 05:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYja0-0001k1-VY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYjZu-0004CU-T0
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737109669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2KRtGhrYNd/JCG5ojiim1SKCb09yUUTsdPQdRBBTofA=;
 b=TAtqTC7USArBxCRgSD9qfltNL3m/Srd+aObCD9WIDQ45LJ0MiwnBfQWhBNUNGshFxlT0/1
 qtMoA5UMcwYAj+9QHFVUVWOJXYjPVmFxjhb3bZNUOlafKgVFRmQ1hyVIj3grqnSaYMnKBq
 p+DwBDBWQQuXYLKD/8tIIa4wLokEDJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-GwwQrVqMMR2DXG61VP0jQg-1; Fri,
 17 Jan 2025 05:27:45 -0500
X-MC-Unique: GwwQrVqMMR2DXG61VP0jQg-1
X-Mimecast-MFC-AGG-ID: GwwQrVqMMR2DXG61VP0jQg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EDEB195605A; Fri, 17 Jan 2025 10:27:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.246])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 809C9195608A; Fri, 17 Jan 2025 10:27:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 0/3] Remove deprecated machines pc-i440fx-2.4 up to
 pc-i440fx-2.12
Date: Fri, 17 Jan 2025 11:27:35 +0100
Message-ID: <20250117102738.59714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

While our new auto-disablement of old machine types will only kick
in with the next (v10.1) release, the pc-i440fx-2.* machine types
have been explicitly marked as deprecated via our old deprecation
policy mechanism before (two releases ago), so it should be fine to
remove them now already.

Note that we can not do much additional clean ups on top yet since
the corresponding q35 machines (which share the same compatibility knobs)
are still around and only will be removed for the 10.1 release instead.
So the bigger clean-up can only be done for 10.1, but removing the i440fx
machine types now will still have at least a small benefit of accelerating
our CI a little bit (since we don't have to run tests for these old machine
types anymore).

Thomas Huth (3):
  tests/qtest/test-x86-cpuid-compat: Remove tests related to
    pc-i440fx-2.3
  hw/i386/pc_piix: Remove pc-i440fx-2.4 up to pc-i440fx-2.12
  tests/qtest/test-x86-cpuid-compat: Replaced the removed pc-i440fx-2.*
    machines

 docs/about/deprecated.rst           |  7 ---
 docs/about/removed-features.rst     |  4 +-
 docs/interop/firmware.json          |  2 +-
 hw/i386/pc_piix.c                   | 95 -----------------------------
 tests/qtest/test-x86-cpuid-compat.c | 52 ++++++----------
 qemu-options.hx                     | 10 +--
 6 files changed, 25 insertions(+), 145 deletions(-)

-- 
2.47.1



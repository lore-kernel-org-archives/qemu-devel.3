Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD4606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dX8/Ifmz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZFf-0007b8-Nw; Wed, 21 Oct 2026 12:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFN-0007WI-FK
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFL-0006Ww-Fi
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792600377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IZZnczJRu/Z0IH1I/CXcERUjWwZSG/xclOlmPjwrQuE=;
 b=dX8/IfmzPZsS7OvDEuQfOlNUmDrruoxXQ1erGa3B9+i3HdUw4hx4Jc4aoOy59v93U0N8jV
 OVZ4hiqftWRAQB0kCiNhfYIfdcypsoOcuFFtGSNf8TbRmH8wifgNSSRONeNaC7FlRsEZsq
 Js3YFee2MKE+JS04VObfUMtxK+xO/Cs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-Uq5iEOvkP4mwMgDGIJoKjA-1; Wed,
 21 Oct 2026 16:32:42 +0000
X-MC-Unique: Uq5iEOvkP4mwMgDGIJoKjA-1
X-Mimecast-MFC-AGG-ID: Uq5iEOvkP4mwMgDGIJoKjA_1792600361
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBFEE180049D; Wed, 21 Oct 2026 16:32:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70C541956087; Wed, 21 Oct 2026 16:32:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 424351800912; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 00/10] Firmware 20261021 patches
Date: Wed, 21 Oct 2026 18:32:28 +0200
Message-ID: <20261021163239.1131460-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 8967b2fe1b2aaae3c29e207d85fab901d580a2dc:

  Merge tag 'pull-9p-20261019' of https://github.com/cschoenebeck/qemu into staging (2026-10-20 07:04:06 +0200)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20261021-pull-request

for you to fetch changes up to 966572648f246483b2076149b4fb9d665789409a:

  backends/igvm: fix parameter area entries leak (2026-10-21 18:26:52 +0200)

----------------------------------------------------------------
- igvm: fix policy handling
- igvm: misc minor fixes
- igvm: add command line parameter support
- hw/uefi: fix pkcs7 wrapping typo

----------------------------------------------------------------

Luigi Leonardi (8):
  sev: split set_guest_policy into set_guest_policy and set_id_block
  igvm: move set_id_block call into the SNP ID block directive handler
  i386/sev: convert the guest policy properties to custom accessors
  i386/sev: add a get_guest_policy callback
  igvm/sev: forward the IGVM guest policy to the platform before launch
  backends/igvm: supply an empty device tree when the machine has none
  igvm: add command line parameter support
  docs/system/igvm: document MADT, COMMAND_LINE and DEVICE_TREE
    directives

Martin Pitt (1):
  hw/uefi: fix ContentInfo detection in wrap_pkcs7()

Stefano Garzarella (1):
  backends/igvm: fix parameter area entries leak

 include/system/confidential-guest-support.h |  36 ++--
 include/system/igvm-internal.h              |   8 +-
 backends/confidential-guest-support.c       |  24 ++-
 backends/igvm-cfg.c                         |  21 ++
 backends/igvm.c                             | 159 +++++++++-----
 hw/uefi/var-service-pkcs7.c                 |   2 +-
 target/i386/sev.c                           | 225 +++++++++++++-------
 docs/system/igvm.rst                        |   8 +
 qapi/qom.json                               |   7 +-
 qemu-options.hx                             |   6 +-
 10 files changed, 336 insertions(+), 160 deletions(-)

-- 
2.56.0



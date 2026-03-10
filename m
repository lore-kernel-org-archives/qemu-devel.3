Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DA6FD2D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzx2G-00089I-Jq; Tue, 10 Mar 2026 09:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vzx2E-00088j-En
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vzx2C-0006UY-Jy
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773148922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LN/hDjBsAiB7kLgPSxgvMZ8NlpqRLqqNGXkxBBcxVt0=;
 b=MdXOkzdE7luS71e1GaPtpVzF97u+v3+z3nKRt0Ow0FfOmYTRRl0Mo2LkWO9OZVTrKuhmPT
 7z7KVmN+V7DWymU3hzfHt/PYlcAuUOE5ADW5zhYc1Gg8ypMYlyDeihmOL9NxwRxt8DB6yZ
 LaXM08yIyx1oe6ZEUsqUCg9xXViX6hE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-qT8FwWBhONmrWnmDz2Uf5Q-1; Tue,
 10 Mar 2026 09:21:58 -0400
X-MC-Unique: qT8FwWBhONmrWnmDz2Uf5Q-1
X-Mimecast-MFC-AGG-ID: qT8FwWBhONmrWnmDz2Uf5Q_1773148917
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91A1419560AE; Tue, 10 Mar 2026 13:21:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.225.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F7203000223; Tue, 10 Mar 2026 13:21:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CBAA518003BD; Tue, 10 Mar 2026 14:21:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PULL 0/3] Firmware 20260310 patches
Date: Tue, 10 Mar 2026 14:21:51 +0100
Message-ID: <20260310132154.2783257-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

The following changes since commit de61484ec39f418e5c0d4603017695f9ffb8fe24:

  Merge tag 'linux-user-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-09 14:53:42 +0000)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260310-pull-request

for you to fetch changes up to 470ccb470b33bedede0100fdb703228a3f2683a5:

  i386/sev/igvm: do not reset guest policy if IGVM does not set it (2026-03-10 14:20:41 +0100)

----------------------------------------------------------------
- firmware.json spec update for svsm.
- igvm bugfixes.

----------------------------------------------------------------

Ani Sinha (1):
  i386/sev/igvm: do not reset guest policy if IGVM does not set it

Luigi Leonardi (1):
  igvm: fix build when igvm is not installed in a well known path

Oliver Steffen (1):
  docs/interop: Add AMD SEV-SNP SVSM interface to firmware.json

 include/qemu/typedefs.h        |  1 +
 include/system/igvm-internal.h |  9 ++-------
 include/system/igvm.h          |  5 +++++
 stubs/igvm.c                   |  1 -
 target/i386/sev.c              | 12 ++++++++++--
 docs/interop/firmware.json     |  4 +++-
 6 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.53.0



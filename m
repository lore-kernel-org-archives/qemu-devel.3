Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4053C021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 12:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnGQ1-0007FK-CX; Wed, 26 Feb 2025 07:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnGPs-0007ET-KD
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 07:21:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnGPq-0000g3-EG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 07:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740572488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+1rDpZWHzRmcJsZ0fa8GurKrbHWLCuENdJ+MUMx+MRA=;
 b=RlbjRRO4gSgBFlc9s3e1LV9VdL4M/7AGwwGw36TWcInlHU39/wi69a0eAvr/C4ZTSij2CV
 4HLg4DsP3JxL/671uBX9FwnGqWMEP/HQ+T8P4DrPFXxxXRPGz9k2pc8FqhkgybF3C3Hinm
 iRLRWGFNHf3vSWebSdT8zjtiAmNf3YY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-qV-oA-x4NIGivRM-cHt18g-1; Wed,
 26 Feb 2025 07:21:26 -0500
X-MC-Unique: qV-oA-x4NIGivRM-cHt18g-1
X-Mimecast-MFC-AGG-ID: qV-oA-x4NIGivRM-cHt18g_1740572486
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D446518EAB3F; Wed, 26 Feb 2025 12:21:25 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.227.242])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E4D419560AE; Wed, 26 Feb 2025 12:21:23 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/3] Misc QGA patches for 2025-02-26
Date: Wed, 26 Feb 2025 14:21:17 +0200
Message-ID: <20250226122120.85790-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-02-22 05:06:39 +0800)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2025-02-26

for you to fetch changes up to c6f5dd7ac8ef62dcdec4cdeda1467c658161afff:

  qga: Don't daemonize before channel is initialized (2025-02-26 13:34:25 +0200)

----------------------------------------------------------------
qga-pull-2025-02-26

----------------------------------------------------------------
Konstantin Kostiuk (1):
      qga: Add log to guest-fsfreeze-thaw command

Michal Privoznik (2):
      qga: Invert logic on return value in main()
      qga: Don't daemonize before channel is initialized

 qga/commands-posix.c |  2 ++
 qga/commands-win32.c |  3 +++
 qga/main.c           | 31 +++++++++++++++++++++----------
 3 files changed, 26 insertions(+), 10 deletions(-)

--
2.48.1



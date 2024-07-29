Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF98C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 06:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYK0n-0007Gi-UP; Mon, 29 Jul 2024 02:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYK0l-0007F1-NK
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYK0j-0005He-Gv
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722235051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a1inBYAzA7XuZHsL3DU4uCgt93vI+hmoiQwPF613TDA=;
 b=g/iTGFTK59IpHhQGzDE//CBIpNUI3I2sw438I7AcoGeSABJVa2OftUyFFoPk7s1BZ4o41r
 lsdGuZ5miSvgvkzYSLoqm+LMJLKJffKzdWAGHfPztZDhfVhNybeDvsp9vrFPYNpXWb8Q9V
 GgDWcE8W8OdpgtC/08uxHTZ6WMacFyk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-40b5myb1NKGtBcbp_p1VtA-1; Mon,
 29 Jul 2024 02:37:27 -0400
X-MC-Unique: 40b5myb1NKGtBcbp_p1VtA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 633D01955D4B; Mon, 29 Jul 2024 06:37:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D97031955E89; Mon, 29 Jul 2024 06:37:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8CB8D21E668A; Mon, 29 Jul 2024 08:37:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 0/2] QAPI patches patches for 2024-07-29
Date: Mon, 29 Jul 2024 08:37:20 +0200
Message-ID: <20240729063722.839708-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 93b799fafd9170da3a79a533ea6f73a18de82e22:

  Merge tag 'pull-ppc-for-9.1-2-20240726-1' of https://gitlab.com/npiggin/qemu into staging (2024-07-26 15:10:45 +1000)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-07-29

for you to fetch changes up to bc2e34e343b40b83cca82409db9c126df2e28c81:

  qapi/machine: Belatedly document target loongarch64 is since 7.1 (2024-07-29 07:29:47 +0200)

----------------------------------------------------------------
QAPI patches patches for 2024-07-29

----------------------------------------------------------------
Markus Armbruster (1):
      qapi/machine: Belatedly document target loongarch64 is since 7.1

Stefano Garzarella (1):
      qapi/qom: make some QOM properties depend on the build settings

 qapi/crypto.json  |  3 ++-
 qapi/machine.json |  2 ++
 qapi/qom.json     | 21 ++++++++++++++-------
 3 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.45.0



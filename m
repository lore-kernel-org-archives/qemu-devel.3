Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE95DC54E60
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 16:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjixy-00054A-3D; Mon, 11 Mar 2024 12:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rjixw-00053m-KI
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rjixu-0005zV-Ut
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710176249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tsmuEoyZ1xWuBnLMeIx2Nyi/P0wmkya13RD8mKoTakg=;
 b=KCd3rnC5Sqi4W1zz20kkHJktMlcg5hgSUv3rmQxG+pIuXbl8/s3EZPh08asqWJ7pkhARV6
 7W2XdoY0MgScTn41J7MrBq3vEMAt8J9GdYvtjKKqVvX5D0C/v+SpZs1s20ouOFwTAQt4Oz
 /AjBiPcIUh9b5lqGFrA80UpjA/Wmb8g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-QYRc3kfUPHGFF5Ridv--yQ-1; Mon, 11 Mar 2024 12:57:28 -0400
X-MC-Unique: QYRc3kfUPHGFF5Ridv--yQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09A4485A58C;
 Mon, 11 Mar 2024 16:57:28 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75A9F10E49;
 Mon, 11 Mar 2024 16:57:26 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/3] Misc QGA patches for 2024-03-11
Date: Mon, 11 Mar 2024 18:57:21 +0200
Message-ID: <20240311165724.176168-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:

  Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-03-11-2

for you to fetch changes up to bfded6fe62b859e337386ed3028b85743569a30b:

  qga-win: Add support of Windows Server 2025 in get-osinfo command (2024-03-11 18:24:39 +0200)

----------------------------------------------------------------
qga-pull-2024-03-11-2

----------------------------------------------------------------
Dehan Meng (1):
      qga-win: Add support of Windows Server 2025 in get-osinfo command

Philippe Mathieu-Daudé (2):
      qga/commands-win32: Declare const qualifier before type
      qga/commands-win32: Do not set matrix_lookup_t/win_10_0_t arrays size

 qga/commands-win32.c | 63 ++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

--
2.44.0



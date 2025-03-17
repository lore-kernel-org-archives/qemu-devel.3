Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E907CC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 09:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu6f9-00077I-MI; Mon, 17 Mar 2025 05:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tu6ev-000758-QG
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tu6eo-0004BK-Jr
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 05:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742203272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m3OxjPnkGJ5GUcEC9M8fuYIwnLYHHWX1OysPElC9gDA=;
 b=WpMmDXWFo+qBLX1yMp5Rwi8c5wmXOXdF555rSTYu2W8Romcte4h0hZTeWgT12VUdSnyclQ
 UYkweqGuOl8mL46y0aq662mO8ITZhi9jo9zBbuCpT1Dw5ssQGuRvdOOA3qr+Vs/1kfsFNM
 GSmX8u0EKk25JlsXvwMkxryPYQP6g+0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-300EuWiTMYyJhMbVas30kg-1; Mon,
 17 Mar 2025 05:21:08 -0400
X-MC-Unique: 300EuWiTMYyJhMbVas30kg-1
X-Mimecast-MFC-AGG-ID: 300EuWiTMYyJhMbVas30kg_1742203267
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74BE219560B8
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:21:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 998931828A84; Mon, 17 Mar 2025 09:21:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 0/1] Net patches
Date: Mon, 17 Mar 2025 17:21:01 +0800
Message-ID: <20250317092102.4381-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit aa90f1161bb17a4863e16ec2f75104cff0752d4e:

  Merge tag 'migration-20250314-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-03-16 02:45:22 -0400)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to b027f55a994af885a7a498a40373a2dcc2d8b15e:

  vdpa: Allow vDPA to work on big-endian machine (2025-03-17 13:46:28 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmfX5/cACgkQ7wSWWzmN
YhFRHQgArp4daHmnfc4r8TNel7fBjeSTpfDGwQcUJbcljKK2ABtylcESAEg6tsAw
aBzaZ2PwoTQfDV2s//g/d2uzd3BWH0Iu3qimsyBtx7Um7D4h7NsGB+gTB/7IhcK8
1LjMHqDnaeS6fzJ93/umTXuyQLzA3tIFkJBzvxVseLrmv6uBPmAy+PDNe/uZ2jeF
2H20jNt/HMc1Yf7sE7NKTBkX+OxuIFkpOGcBtVxiPK1//Wmhw+v+zlQOFjUC+6CD
LxiBB0Q0tD7ekfbuF6x2SOnuzLDHgpMzgoGqLIYzeQhBX9TdHLM0LtEHHaMyW1pj
7mGPSY4avVSM1sePgtmNJ5Y5r/xTRA==
=e7Sc
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Konstantin Shkolnyy (1):
      vdpa: Allow vDPA to work on big-endian machine

 net/vhost-vdpa.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)




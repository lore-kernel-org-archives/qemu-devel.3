Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A2EC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 07:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdPTd-0007s3-0c; Mon, 12 Aug 2024 03:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sdPTb-0007ra-Km
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 03:28:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sdPTZ-0004Dv-T4
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 03:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723447699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V6UTt1YTaTojFhYxLMopKVuLtNoGr3U+pIJiggPcJyw=;
 b=Oo75D47tO0m0GqGpk5N6gfKB3eqPbK6xKg4b44rBX9vDxxB2x9Iwk8xkV0+5Qp/yVnJCyw
 2BhCMJqeraacjy6moROR2O/60OrHYkCeF+qlZ2SgBaLITP2pJCH1d3v7ydsgPPYMRiErHA
 Qbch4AKqFQkhLlbGYnE8g+5WbtxR8rs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-Ir_Kp9DqPuCOE4f8XBQitA-1; Mon,
 12 Aug 2024 03:28:17 -0400
X-MC-Unique: Ir_Kp9DqPuCOE4f8XBQitA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F72E19560B7
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 07:28:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.186])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE9CF1956048; Mon, 12 Aug 2024 07:28:13 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/1] Net patches
Date: Mon, 12 Aug 2024 15:28:09 +0800
Message-ID: <20240812072810.5247-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 0f397dcfecc9211d12c2c720c01eb32f0eaa7d23:

  Merge tag 'pull-nbd-2024-08-08' of https://repo.or.cz/qemu/ericb into staging (2024-08-09 08:40:37 +1000)

are available in the Git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to fa62cb989a9146c82f8f172715042852f5d36200:

  net: Fix '-net nic,model=' for non-help arguments (2024-08-12 13:36:42 +0800)

----------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAma5uNkACgkQ7wSWWzmN
YhFpLwf+J9+cBWKUze7FZkxNHU78GJ/b+oVQfLYPnrCRrVKoyTr9yiKfMDS8qf5/
tPd+xFABwcHb8UL3EeAe9w5aB0QCqqdmZMFRkWuaZ7HEbZkYNt9cJck5iMdNaPBm
cKiFRLb8FDVA3aegCcsBqnwCxgFW+3P3rrnHQz1C+GQAOm7FER+HiFnYucjrrLSM
SaXZYIH/LPqL01gbZcbixQkhgL5XFWUToFXQEYECGS07uZZ1WSJkxIP6WZDchJ4+
vYO8/fWXVdrjvDirraZQRYnurWQGpTUk0Ocn2R8MaJsF8TK031MrMRJ3YP9zXp4n
wMe0BZO/YG5oi2gFrJpYL2AZqh2MgQ==
=DhS+
-----END PGP SIGNATURE-----

----------------------------------------------------------------
David Woodhouse (1):
      net: Fix '-net nic,model=' for non-help arguments

 net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)




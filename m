Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F0CC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLtX-0004L5-B6; Thu, 04 Jul 2024 08:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sPLtJ-0004Ad-Iu
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1sPLtE-0006Jw-H2
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720097322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0KIsVzaMJ2c6J7JjJ0pwhbJkp5EspKm1WD0SiiZ8bvQ=;
 b=YzJUtnLKCJhz86/4YATZib4CUtaqxVe8I87SkBveWpvdMHbguTfGjZPyZUZymo0RzDRoC0
 MZzFBDpMfH/6FLA0dt+anuIzl3D9yzeBKFtLnzHJqDfaNk977RKwfnsTby4vdOUPW6pZEu
 T+oG+e46GErdGJXXbyVPOodcSDmlatI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-i6hVYa_wO6yS0Jj88EeCoQ-1; Thu,
 04 Jul 2024 08:48:39 -0400
X-MC-Unique: i6hVYa_wO6yS0Jj88EeCoQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44479196CE01; Thu,  4 Jul 2024 12:48:38 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.192.194])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B45391955F65; Thu,  4 Jul 2024 12:48:35 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 0/4] net: update netdev stream/dgram man page
Date: Thu,  4 Jul 2024 14:48:30 +0200
Message-ID: <20240704124834.81958-1-lvivier@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add the description of "-netdev stream" and "-netdev dgram" in the QEMU=0D
manpage.=0D
=0D
Add some examples on how to use them, including a way to use=0D
"-netdev stream" and "passt" in place of "-netdev user".=0D
("passt" is a non privileged translation proxy between layer-2,=0D
like "-netdev stream", and layer-4 on host, like TCP, UDP,=0D
ICMP/ICMPv6 echo)=0D
=0D
v2:=0D
  - split patch=0D
  - update unix socket description with stream and datagram words.=0D
=0D
Laurent Vivier (4):=0D
  net: update netdev stream/dgram man page=0D
  net: update netdev stream man page with unix socket=0D
  net: update netdev dgram man page with unix socket=0D
  net: update netdev stream man page with the reconnect parameter=0D
=0D
 qemu-options.hx | 189 ++++++++++++++++++++++++++++++++++++++++++++++++=0D
 1 file changed, 189 insertions(+)=0D
=0D
-- =0D
2.45.2=0D
=0D



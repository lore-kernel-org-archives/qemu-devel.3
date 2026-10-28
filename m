Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142B606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iLdQHZ8q;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ktuPo/DJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HN-00036B-31; Wed, 28 Oct 2026 13:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ga-0001Dg-MO
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GW-0003wN-NE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWpOsnChQtr3kRDdC1FT+mgnTXjmcTTbX2EopbWkNRs=;
 b=iLdQHZ8qYMZp6dEEsMM+Wh3MTv1n9IjgZBsV11m1SzpZ0SKdZNqcYciH7SzgtjHx1fmd8h
 s6F9VzdEuDO/TSxqRyCTsTo6kjOWkY6ZUz69jx95bNZqYGlIUTwb2FXVnAhr+TQKOcoWm8
 vfeLmLPYO5b/T04/tPM/sCTwaeAVaG0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-QsgIKsVbPUSZgT0cTS-aVQ-1; Wed, 28 Oct 2026 13:16:40 -0400
X-MC-Unique: QsgIKsVbPUSZgT0cTS-aVQ-1
X-Mimecast-MFC-AGG-ID: QsgIKsVbPUSZgT0cTS-aVQ_1793207799
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e011829easo871100f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207799; x=1793812599; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dWpOsnChQtr3kRDdC1FT+mgnTXjmcTTbX2EopbWkNRs=;
 b=ktuPo/DJ42SfPoN/FirJ9AvXDVl7lrKc8eHI63JWzEy0pL4PsZCGbUNUU9M1YKcH0z
 OJZdQ6KXdB+4MLO60LLg1yknFAIMl3s78vsNeajymyVtRtUw4g1XGZHUZj+BYyWQdt7M
 EcfgRoleCfAsYYO8LJnPLpyopOg+HktUSSkdaOf/Zmf5gHlmoSq9iscgFEwIn2mcdYdp
 R6Z2ofy29oglxAFac0gft1vFyGLjp5d/1CvBDYtiqUh5sM8x3cwQkHLMr2dwfTmHEGrh
 2H+JdBIwmMwplrS9wpvPUwUcSGAbbREI1UqGimvvtU96HeQE4TCdLSeVN9o/3ZWuRBvy
 HOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207799; x=1793812599;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dWpOsnChQtr3kRDdC1FT+mgnTXjmcTTbX2EopbWkNRs=;
 b=J2LsuvN+oQcTL5b36AMqbVVOeZseDSydDHo033eLnoyPCoz2z6GpV60lXonMoH7dVB
 Gb7tS5Cgmt9cDAOi1aIDf6go/6AR36OakeD3VNocWmhKqivsey1hKsepEgwbF2j3ONjU
 8VnizPsEngElrkrT4P6Mt1YijT9e54Lvt5zpGAuy9uQvaE5jo6GZXd3YqFPZKgg2QAUb
 F0E4LlnEspIQndJfzfkroNFeV8zgZ3IYcEadd4lxweYEmdFMpd2O8YEC3s5Xq1ew0wjY
 BWWi15zq6zKHlrp3g9UDx/BfhCT5eWbtYck1qjB6CZ+F4LOyWFuArwwxu8xWjuDmjjA3
 4heA==
X-Gm-Message-State: AFq9FYJ+sVKusOoX1AvysIJJhH6RvYqWbGWW476fQo3pfxs69M841OIo
 Zxpyw2XYVzbX3hFZP/yqsM04bGgjXQtdifKM3f1ogxBD1sgJAPcxpTfiwe1mdo50I648GNldoyl
 sRjz3ulqnRXTe7rlA+V9AZ7sJ9vu7jSDJuAXXWB6bjB8ptDo0MfG6zuqE5wbJ+YeQBJlRgZZVGH
 NgwZHNiwyUkr9NyY0PERq2FryLkmv+H77Y2Q==
X-Gm-Gg: AYBFou2jTJCPWqkIN9gD9tQGJCWLfjLWcC9QiMQVZ0oT4EuaSA3mFmZ6yTbw9U3qWOX
 JkUnYSlKWS8Uf68eCQIb19ZVkj2H//hbHhgX9eOD8HADP4eLNDLZKmNOoc0g7Kb0M7Qak6ZBpfn
 levGTgFgi89ONfUvF4wGjNxpZ15U2KILK2C89S9swkh+UO8nPvg6qEskrEn/n8dqsJ1NZtcxKQP
 2IsQ9Qwd2AA0zZmQoHJbj3yzwciPghbmUe5P4+pGrPLDQfgO6jXmV3+bAF8BgP4SMS93BhBQpnQ
 019CaXQnT5NZKQvs1Q71y7p47h27akWHwC+cz2mGLwbZ/vTXLwBNqtz0KHZvq5E45kTLYsoPzvD
 qadSwqZvElpdLalv4oiAN6A6yjKvdAKt4o/IKSZTW
X-Received: by 2002:a05:6000:4553:b0:48a:f0cd:8712 with SMTP id
 ffacd0b85a97d-48e5d5e26a6mr5110949f8f.50.1793207799296; 
 Wed, 28 Oct 2026 10:16:39 -0700 (PDT)
X-Received: by 2002:a05:6000:4553:b0:48a:f0cd:8712 with SMTP id
 ffacd0b85a97d-48e5d5e26a6mr5110895f8f.50.1793207798667; 
 Wed, 28 Oct 2026 10:16:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc4d76sm30009609f8f.12.2026.10.28.10.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:37 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 vhost-user@lists.linux.dev
Subject: [PULL 60/78] vhost-user: add dedicated mailing list
Message-ID: <f5992d68d3dff73e17f65264d5e443ac40d546ad.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefano Garzarella <sgarzare@redhat.com>

During the "Virtio and Vhost-User Ecosystem for Production and
Automotive Systems" BoF at LPC 2026 [1] we discussed and agreed on
creating a new vhost-user mailing list, mainly for changes to the
specification and discussions around the protocol.

The main reason is that the vhost-user specification is also used
by other VMMs and implemented by several back-ends outside the QEMU
repository, whose developers often do not follow qemu-devel.

Add a paragraph in the specification about the new mailing list and
a dedicated MAINTAINERS entry for the vhost-user protocol, covering
the specification, the QEMU front-end and libvhost-user (back-end
library).

[1] https://lpc.events/event/20/contributions/2365/

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261023162441.89450-1-sgarzare@redhat.com>
---
 MAINTAINERS                 | 12 ++++++++++--
 docs/interop/vhost-user.rst |  6 ++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7ec12ac39..04842adba6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2544,19 +2544,27 @@ M: Michael S. Tsirkin <mst@redhat.com>
 R: Stefano Garzarella <sgarzare@redhat.com>
 S: Supported
 F: hw/*/*vhost*
-F: docs/interop/vhost-user*
 F: docs/system/devices/virtio/vhost-user*
 F: contrib/vhost-user-*/
 F: backends/*vhost*
 F: include/system/vhost-user-backend.h
 F: include/hw/virtio/vhost*
 F: include/*/vhost*
-F: subprojects/libvhost-user/
 F: block/export/vhost-user*
 F: util/vhost-user-server.c
 F: net/vhost*
 F: tests/functional/x86_64/test_vhost_user_bridge.py
 
+vhost-user protocol
+M: Michael S. Tsirkin <mst@redhat.com>
+R: Stefano Garzarella <sgarzare@redhat.com>
+L: vhost-user@lists.linux.dev
+S: Supported
+F: docs/interop/vhost-user*
+F: hw/virtio/vhost-user.c
+F: include/hw/virtio/vhost-user.h
+F: subprojects/libvhost-user/
+
 vhost-shadow-virtqueue
 R: Eugenio Pérez <eperezma@redhat.com>
 F: hw/virtio/vhost-shadow-virtqueue.*
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 488214a306..c31a75def3 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -38,6 +38,12 @@ conventions <backend_conventions>`.
 The *front-end* and *back-end* can be either a client (i.e. connecting) or
 server (listening) in the socket communication.
 
+The protocol is developed and discussed on the `vhost-user mailing list
+<mailto:vhost-user@lists.linux.dev>`_, archived at
+https://lore.kernel.org/vhost-user/. Until October 2026, when this list
+was created, discussions took place on the qemu-devel mailing list,
+archived at https://lore.kernel.org/qemu-devel/.
+
 Support for platforms other than Linux
 --------------------------------------
 
-- 
MST



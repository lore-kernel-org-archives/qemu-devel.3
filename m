Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015E9CD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVyp-00027e-3w; Fri, 05 Jun 2026 10:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVyn-00024s-9i
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVyl-0005Nb-Du
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780671418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WJ8Hgp7J677y7MbqzWQIEh/HSUNlfgaCHwKYby/1BGQ=;
 b=YXgKBlYYa7FOxtbAoYwxFlTfAFdqUKaT+gcjmqTjMPMDqaZ6BnvTnDRQVOTX7LkvJb5juo
 I6PyhqartIm2Sm+6f3e4o7IbqvV0OljyPg93jcBl+W028SzzI5TWpjw+Opa9SGpK0XPoh+
 EsKfPI+Y9QaKwF8sh59wCl8iagir/T8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-kqsGbOUIO26JaGn-gGCu_A-1; Fri,
 05 Jun 2026 10:56:55 -0400
X-MC-Unique: kqsGbOUIO26JaGn-gGCu_A-1
X-Mimecast-MFC-AGG-ID: kqsGbOUIO26JaGn-gGCu_A_1780671414
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87D5F180047F; Fri,  5 Jun 2026 14:56:54 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.48.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 473F0180049F; Fri,  5 Jun 2026 14:56:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/7] s390x updates
Date: Fri,  5 Jun 2026 16:56:40 +0200
Message-ID: <20260605145647.272621-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc:

  lcitool: remove Cirrus CI support (2026-06-03 12:45:38 -0400)

are available in the Git repository at:

  https://gitlab.com/cohuck/qemu tags/s390x-20260605

for you to fetch changes up to 23cec0b2cd2eed05fc67148fc971bdcd147d3e94:

  buildsys: Stop checking for ESA/390 host (2026-06-05 12:30:33 +0200)

----------------------------------------------------------------
s390x updates:
- several fixes, mostly pci related, also in the STSI implementation
- fix up some file patterns in MAINTAINERS
- stop looking for ESA/390 (pre-64 bit zArch) hosts

----------------------------------------------------------------
Alexandra Winter (1):
  target/s390x: Make container ids in SysIB_15x 1-based

Farhan Ali (1):
  s390x/pci: Fix interrupt forwarding disable for interpreted devices

Jaehoon Kim (1):
  hw/s390x/ccw: Mark virtio-pci disable-legacy property as optional

Philippe Mathieu-Daudé (3):
  MAINTAINERS: Fix s390x storage key/attribute device paths
  MAINTAINERS: Fix tcg/s390x/ path
  buildsys: Stop checking for ESA/390 host

Thomas Huth (1):
  hw/s390x: Fix memory leaks after removing elements with QTAILQ_REMOVE

 MAINTAINERS                      |  6 +++---
 block/file-posix.c               |  2 +-
 configure                        | 12 ++----------
 disas/disas-host.c               |  2 +-
 hw/s390x/s390-pci-bus.c          |  2 +-
 hw/s390x/s390-pci-vfio.c         |  1 +
 hw/s390x/s390-virtio-ccw.c       |  2 +-
 include/qemu/cacheflush.h        |  2 +-
 include/qemu/timer.h             |  2 +-
 target/s390x/kvm/stsi-topology.c | 10 +++++-----
 util/cacheflush.c                |  2 +-
 11 files changed, 18 insertions(+), 25 deletions(-)

-- 
2.54.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8661606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 04:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nb3n9b+O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWQkX-0004WD-9g; Wed, 25 Nov 2026 23:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+daejun7.park.samsung.com@kernel.org>)
 id 1xWOoc-0008Oq-TA; Wed, 25 Nov 2026 21:02:26 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+daejun7.park.samsung.com@kernel.org>)
 id 1xWOoZ-0006z0-Oe; Wed, 25 Nov 2026 21:02:26 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF88A45790;
 Thu, 26 Nov 2026 02:02:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795658541;
 b=t34Pd88RgfWs1X/tKu1VjkqHp4D1g0DKgHd5ErNEVjORLRBRwhOssHd1bAWpVcdYaK+R
 LDbDbNVccNp5R63XG+q2xV9oNMQRmbhsp6yUQv4gERw4U6rBC10dnE7u5J8HPS1dgFRMa
 D8nUzOu+89WBZiyYoxZM3Tc+vznQgEg3ZERr6z4iD7k68Ljie/xr2+GxrCoP0Zlbq5j3D
 LixbzHRHnZ3HYbYqqgByftEJxCYx6a5l2rK+21xMQXwibVqMdGnfaRnikRlIs5pJq8P/F
 otPvr9oEKFPLGWHGYKVHMKlqDV1/oOvB10h7+ChwN4zL9kTMQIHZZQgJPWTixlAPmig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795658541;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=XtETOvgkSxRs5itFyzyrB+YgeEcbIaI0XDAMMFOuw4U=;
 b=XQ94qP1gDQHgz/BLh3wAA+Cy8qysT+SEJ9DkKIgoAKuF/q15ehHpDqjks7643G4s7CGZ
 BFdDG1vhVd1oGVToFyL/cxDLWSf5pvJPbiBqmIZhSBkTJJuyiQhkcwtUWqSTJfxDsz6Dp
 yZHz81mowKgWFmP1mmSyuOyoMH9Ge3rPGxKyrSqeDmjY4unaTnqlPaqOxLc4KdNwBG5Au
 5I91jGV/6XoWy3yYlK+ZsYnBFgcFEccnuARtJZnqXBgazXtVpvLE4zT6vwP3BhPc7Aayp
 HVT66hsKX6ryWbezSZ1lqGj02zXO4Hph7n5xLJ1HXMpdp+uuAkRtZdLQV9LojfS1gYA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 76EDE1F000CA;
 Thu, 26 Nov 2026 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795658541;
 bh=XtETOvgkSxRs5itFyzyrB+YgeEcbIaI0XDAMMFOuw4U=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=nb3n9b+Od0RMvfp2+872sT1aqOHBRgT7OZCP6CXTrUvuUFgX4WLmdu+RXCovItr4j
 dmh3BQNu8tEYERFKE2CigjYXe9t993yqvLUJqPFLcP1p5nX8F+EToZqI5g4F9pwtCf
 HBtKkL6r5cXV3B+gicI3JNZdJILOGysGaeMyW2OS+R+EeDFlVozEYXc9pvtWGZob0o
 EKfnevppbO9cZs/y8uYfR7BVlwSAYeI9pTljigmksjYU7QJ4caJiJKamku1U9oBtrk
 pvan4ivXRIq+rWhZtImi0Qb6+kwp+GjGq+GVc3Rr5RHhZ/UfTBIOCvNVwH73aOYMWI
 hpiCGqwAlK3aA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CB5A14D17C;
 Thu, 26 Nov 2026 02:02:10 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Subject: [PATCH v4 0/5] Support for Zoned UFS
Date: Thu, 26 Nov 2026 11:02:08 +0900
Message-Id: <20261126-zoned-ufs-v4b-v4-0-f90239d12a55@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACCTB2sC/x3MQQqAIBBA0avErBswkcCuEi00p5qNhUMSiXdPW
 r7F/wWEEpPA1BVIlFn4jA2m72A9XNwJOTSDVnocBj3ie0YKeG+C2XgMyjnrrFHeBGjNlWjj5//
 NS60fqOeeMl8AAAA=
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Stanley Jhu <stanleyjhu@google.com>, 
 Keoseong Park <keosung.park@samsung.com>, 
 Daejun Park <daejun7.park@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795658528; l=2731;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=/cLmwNv7b8jTqocxDAfhXcQSLNRD4e5NXiWZaGVu+Rc=;
 b=m63x4e6PgJ2mlQa1jXoOZuIYRXzIE8+Kb/AEA4xkstLq44yUC1SITEmEyCQmGx3j2pkulbfXQ
 Y0JfGuiRscbAPGcaxls4geXigoTahweg+AyxGTB3Co0/8CUtx44XG3s
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=devnull+daejun7.park.samsung.com@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Nov 2026 23:06:16 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: daejun7.park@samsung.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series makes a ufs-lu on a host-managed zoned qcow2 image a ZBC
host-managed device, so that f2fs and other zoned software can be
tested on UFS. As Niklas asked [1], the zones live in the image and the
logical unit uses the zoned block layer API.

The ZBC commands are emulated in hw/ufs on top of scsi-hd, which stays
a direct-access device, as scsi-disk serves its mode and VPD pages to
those only. They can move to scsi-disk if the SCSI maintainers prefer.

Tested with the UFS qtests (also under ASan and UBSan) and Linux 7.3-rc7
and android17-6.18 guests, legacy doorbell and MCQ: fio --zonemode=zbd
with verification, blkzone, sg_raw, and f2fs on android17-6.18. One
early android17-6.18 MCQ run retried unaligned writes (data verified),
fourteen later ones did not. Zoned host block devices are untested.

Two qcow2 v18 problems show with qemu-io alone. With detect-zeroes
on, a zero write at the write pointer does not move it, so the next
write fails as unaligned. A resized zoned image overflows its write
pointer table on a write past the old end, and qemu-img resize leaves
it unopenable.

Based-on: <20261124085529.1537572-1-cassel@kernel.org>

Changes in v4:
- Keep the zones in the image and use the zoned block layer API
  (Niklas). Drop the zoned properties and v3's Reviewed-by tags.
- Add patches 1 and 2 for the active zone limit and zone errors.
- Drop patches 1-3 of v3, which are in master.
- Link to v3: https://lore.kernel.org/qemu-devel/20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5

[1] https://lore.kernel.org/qemu-devel/at9P9OWMQUQR501_@ryzen

---
Daejun Park (5):
      block: add an accessor for the active zone limit
      scsi-disk: Report zone errors with their ZBC sense codes
      docs/system: Document zoned UFS logical units
      hw/ufs: Support for Zoned UFS
      tests/qtest: Add tests for Zoned UFS

 block/block-backend.c             |   11 +
 docs/system/devices/ufs.rst       |   50 ++
 hw/scsi/scsi-disk.c               |   11 +-
 hw/ufs/lu.c                       |  886 ++++++++++++++++++++-
 hw/ufs/trace-events               |    5 +
 hw/ufs/ufs.c                      |   16 +
 hw/ufs/ufs.h                      |    8 +
 include/block/ufs.h               |   15 +
 include/scsi/utils.h              |    1 +
 include/system/block-backend-io.h |    1 +
 scsi/utils.c                      |   28 +
 tests/qtest/ufs-test.c            | 1587 +++++++++++++++++++++++++++++++++++++
 12 files changed, 2609 insertions(+), 10 deletions(-)
---
base-commit: ca3b685586976cc2a9b759c1e7ab7c184e5aed34
change-id: 20261126-zoned-ufs-v4b-d0aa9a940b4d

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>




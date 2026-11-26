Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F018606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 04:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fL5uyE9O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWQkf-0004eo-HQ; Wed, 25 Nov 2026 23:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+daejun7.park.samsung.com@kernel.org>)
 id 1xWOof-0008Ph-Sx; Wed, 25 Nov 2026 21:02:32 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+daejun7.park.samsung.com@kernel.org>)
 id 1xWOod-0007Bm-1d; Wed, 25 Nov 2026 21:02:28 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC36B60E5F;
 Thu, 26 Nov 2026 02:02:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795658544;
 b=POHF/A4amTW3Bv0EtlHRpHkIGFArs5zIW3K+M99lWhehFNKqBlOSX8YOWzwCil3LVjrm
 e/8+gpgHmyyMf1P9ewfiUddIyxk+096G8B5PDKgOOC09nLnHmzv/W8t8flLhQ2MdFiOST
 TuTw5t4wurogyxhRbp5opySfVdkRgy/KNMkk8lTUOAuzhl59Sglxf2QNA+ltpf+BPiEBb
 laoUcce6z1ggxtmFgWl8QRZlgaLnr/W469TSl7iU+A8czuLvM7VdThbWkA2kjTCsfi1eJ
 0rbfhYlwuKCcAYNTAXvyI/Yk4MdG6DBTLOErp8SWr3jcgBIP/BLW++V/Ly0/TJ1g4lA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795658544;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=q9Xy3QMMi6to9x8xcA2DRRCM9Cwern1LHyIilzRsLY0=;
 b=k0fR9cX08zru+PV9J6OELgVHIR8I2Yiu5HAAJIrpteotpmo/GXlozOwW4tEVTrPoc7uH
 YfL0U4ul9y5PHXjNGyMVj6bqaV17n5Q8pLzmlUXQVchHVCgltuUZkvyrgznTZuvTrU14e
 m0wHwEzm5cHgSgYb5FTm4cWrC8bnn4qndBfXTS7QU1pkWFBgA64gS54sbylMwv9WRC91v
 2DXa19eujHly31ezNdwGu8XXN7j2rryg1Ey90AUZvEx29RGekcdIGQd67RCOZ48/OMDMy
 ubJ8NKj51vcj5vsgGHGwwhWlJa+7TgCTsD9A5gmTfOiPdrm9VV+cG75mVn8WJeZhhsQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B0D6D1F000D0;
 Thu, 26 Nov 2026 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795658544;
 bh=q9Xy3QMMi6to9x8xcA2DRRCM9Cwern1LHyIilzRsLY0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=fL5uyE9OCD4RTtxcFPkqOhUgu1Q16wSKpByZCuwCgqKkjxxIlnxeav9mb/lGJBGg1
 o2E9LPH5/PZz77JjIMkqiFNhDvmHl+Cq/cCWlp/imgchT4Xtgpkk6VPPNecex9juvs
 NH09gwiIGMU8+UBl4k8RkUdhsF/MWfZ7gaj9vDag830Y72HPh9Zm9BLtpKF9TSufNd
 PEKDQfxhyflcdoeSd913dmJJA731PI4HAprNP6TsEh1/cQ2AnDbQy6+OuN0YzGx5lW
 qiRXDgl9h+GhdZ2WgaG9gp1NgVS8iDakNMnKMLqgjfa1bqjkf1lPsMfr9G2jxDZNxN
 tx4gWpKPaZ9LQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3D4A54D188;
 Thu, 26 Nov 2026 02:02:11 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Thu, 26 Nov 2026 11:02:11 +0900
Subject: [PATCH v4 3/5] docs/system: Document zoned UFS logical units
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-zoned-ufs-v4b-v4-3-f90239d12a55@samsung.com>
References: <20261126-zoned-ufs-v4b-v4-0-f90239d12a55@samsung.com>
In-Reply-To: <20261126-zoned-ufs-v4b-v4-0-f90239d12a55@samsung.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795658528; l=3191;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=E+FqxT7+4Rg8UwwbXL+CnxhEI7ZBRdGiOVMzAJRKTSo=;
 b=tVKKxaSWUqChu/m+uQMSxyL1IshBjxAB6yCHYHq5tbMWkUq2s7aXulMMV1L3KuVghO8iHx57C
 1gn0N+ZtgBnDpkShMJNkuXHlmYD+sNX9CELV4lySCOQuryTS0EtAKl5
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=devnull+daejun7.park.samsung.com@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Nov 2026 23:06:17 -0500
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daejun Park <daejun7.park@samsung.com>

A logical unit on a host-managed zoned drive is going to be a zoned
logical unit. Document which drives qualify and what the guest sees.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 docs/system/devices/ufs.rst | 50 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/docs/system/devices/ufs.rst b/docs/system/devices/ufs.rst
index 7e1fa671ab..0a33626b59 100644
--- a/docs/system/devices/ufs.rst
+++ b/docs/system/devices/ufs.rst
@@ -73,6 +73,56 @@ Logical Unit Properties
   Logical unit number, 0 to 31. A host controller accepts up to 32
   logical units.
 
+Zoned Logical Units
+===================
+
+A logical unit on a host-managed zoned drive is a zoned logical unit: a
+host-managed zoned block device (ZBC) with the zones of the drive. The
+drive is usually a qcow2 image created with the ``zone.*`` options. It
+must be writable, and its size and zone size must be multiples of the 4
+KiB logical block size. Every sequential zone must be writable to its
+end, since gap zones, with which ZBC describes a smaller capacity, are
+not modelled. ZBC cannot report an active zone limit, so the drive must
+have none below its number of sequential zones. A zoned host block
+device (``host_device``) reports zone errors of writes other than the
+zone resource errors as I/O errors, so the guest sees them as generic
+errors such as ABORTED COMMAND. A logical unit on a host-aware drive is
+a regular logical unit.
+
+The following creates an image with 64 MiB zones and adds a regular
+logical unit and a zoned one:
+
+.. code-block:: console
+
+    qemu-img create -f qcow2 lu1.qcow2 -o size=4G \
+        -o zone.mode=host-managed,zone.size=64M,zone.capacity=64M \
+        -o zone.max_open_zones=6
+
+    -drive file=lu0.img,if=none,id=lu0,format=raw \
+    -blockdev qcow2,node-name=lu1,file.driver=file,file.filename=lu1.qcow2 \
+    -device ufs,id=ufs0,serial=0001 \
+    -device ufs-lu,drive=lu0,bus=ufs0,lun=0 \
+    -device ufs-lu,drive=lu1,bus=ufs0,lun=1
+
+A Linux guest needs ``CONFIG_BLK_DEV_ZONED``. f2fs keeps its metadata on
+a regular logical unit, for example ``mkfs.f2fs -m -c /dev/sdb /dev/sda``
+with the zoned logical unit as ``/dev/sdb``, and needs at least as many
+open zones as its active logs, 6 by default.
+
+The zoned logical unit reports the ZBC device type in its INQUIRY data,
+the open zone limit of the image in the ZBC device characteristics VPD
+page, and RC BASIS 1 in READ CAPACITY(16). It handles REPORT ZONES and
+the OPEN, CLOSE, FINISH and RESET WRITE POINTER zone operations. A zone
+operation acts on one zone or, with the ALL bit, on every zone. A ZONE
+COUNT above 1 is rejected. Writes go to the image, which checks them
+against its zones. With ``detect-zeroes`` on, the image takes a write of
+zeros without moving the write pointer, so keep it off, the default. The
+logical unit does not support WRITE SAME. All other commands, including
+reads, MODE SENSE and SYNCHRONIZE CACHE, behave as on a regular logical
+unit.
+
+The image keeps the zones across restarts.
+
 Limitations
 ===========
 

-- 
2.43.0




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10733C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Kn-0006P6-0e; Thu, 09 Jul 2026 22:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wi1Ki-0006Mk-Ew
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:51:20 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1wi1Ka-0007jN-Nl
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:51:20 -0400
X-UUID: 2de4f3627c0a11f1aa26b74ffac11d73-20260710
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:cb3e56c9-a02b-49e7-a094-93b295320edf, IP:15,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:40
X-CID-INFO: VERSION:1.3.12, REQID:cb3e56c9-a02b-49e7-a094-93b295320edf, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:40
X-CID-META: VersionHash:e7bac3a, CLOUDID:b3fb628a66edd8acd273ff716458f0dc,
 BulkI
 D:260709153530A19YP6P0,BulkQuantity:1,Recheck:0,SF:10|66|78|81|82|83|102|1
 23|127|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:ni
 l,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
 RR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2de4f3627c0a11f1aa26b74ffac11d73-20260710
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1838706304; Fri, 10 Jul 2026 10:50:58 +0800
From: zhaoguohan@kylinos.cn
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] hw/virtio/vdpa-dev: pass set_config buffer to vhost
 backend
Date: Fri, 10 Jul 2026 10:50:02 +0800
Message-ID: <20260710025002.50687-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709033448-mutt-send-email-mst@kernel.org>
References: <20260709073225.2341642-1-zhaoguohan@kylinos.cn>
 <20260709033448-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Sure. I hit this with a generic vhost-vdpa virtio-blk device when
changing the write cache mode.

For virtio-blk, the guest updates virtio_blk_config.wce when switching
between write through and write back. Without this patch, QEMU still
passes the old s->config buffer to VHOST_VDPA_SET_CONFIG, so the backend
does not see the new wce value.

I reproduced it with vdpa_sim_blk. After writing wce=1 and then wce=0,
the byte corresponding to virtio_blk_config.wce in the buffer passed to
VHOST_VDPA_SET_CONFIG remained unchanged without this patch:

guest writes wce=1:
0x0020: 00 00 01 00 ...
guest writes wce=0:
0x0020: 00 00 01 00 ...

With this patch, the same writes are passed down correctly:

guest writes wce=1:
0x0020: 01 00 00 00 ...
guest writes wce=0:
0x0020: 00 00 00 00 ...

So from the guest's perspective the write cache mode change appears to
succeed, but the updated value never reaches the vDPA backend because
VHOST_VDPA_SET_CONFIG receives stale configuration data.


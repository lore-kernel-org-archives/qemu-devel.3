Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF83606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUKvK-0002ww-4I; Fri, 20 Nov 2026 04:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1xUKvF-0002vU-L9; Fri, 20 Nov 2026 04:28:45 -0500
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1xUKv9-0007Pz-Js; Fri, 20 Nov 2026 04:28:45 -0500
X-UUID: baba9eaee4c411f19a56ed5b684f684d-20261120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:0e3c5421-8110-4db1-bc55-dc87629e925f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:17265a803de0a3f137198a5f8167e3fe,
 BulkI
 D:nil,BulkQuantity:0,SF:81|82|83|102|123|136|865|898,TC:nil,Content:0|15|5
 0|99,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
 0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: baba9eaee4c411f19a56ed5b684f684d-20261120
X-User: zhaoguohan@kylinos.cn
Received: from ubuntu.. [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 748668129; Fri, 20 Nov 2026 17:28:22 +0800
From: zhaoguohan@kylinos.cn
To: mjt@tls.msk.ru
Cc: arei.gonglei@huawei.com, mst@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, zhaoguohan@kylinos.cn
Subject: Re: [PATCH] virtio-crypto: clean up every data queue
Date: Fri, 20 Nov 2026 17:28:17 +0800
Message-ID: <20261120092817.119611-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a16d5437-dd54-49dc-b53a-c8756afab274@tls.msk.ru>
References: <a16d5437-dd54-49dc-b53a-c8756afab274@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: GuoHan Zhao <zhaoguohan@kylinos.cn>=0D

On 11/20/26 8:25, Michael Tokarev wrote:=0D
> Is it a qemu-stable material?=0D
=0D
Yes, I think so.=0D
=0D
> I found this change while trying to pick up a subsequent fix in this area=
 --=0D
>=0D
>   902c849979c hw/virtio/virtio-crypto: Drain in-flight operations before =
unrealizing (CVE-2026-50625)=0D
>=0D
> which touches the same place, and wonder if I should pick this one too?=0D
=0D
Yes please. 902c849979c was done on top of this patch (b35d34e3ccd=0D
in master), so its context won't match without it. Picking=0D
b35d34e3ccd first should let both apply cleanly.=0D
=0D
Thanks,=0D
GuoHan=0D


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E66CC6B1D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 02:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Ts1-0001ms-R2; Thu, 02 Apr 2026 22:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w8Ts0-0001ki-0O; Thu, 02 Apr 2026 22:02:48 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w8Try-00041k-6a; Thu, 02 Apr 2026 22:02:47 -0400
X-UUID: 316a8b602f0111f1aa26b74ffac11d73-20260403
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:c67ed887-f4dd-4e31-87d5-53eef5998546, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:6992c320d927372cdc1685fbb0008b27,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|123|850|898,TC:nil,Content:
 0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 316a8b602f0111f1aa26b74ffac11d73-20260403
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 765366209; Fri, 03 Apr 2026 10:02:39 +0800
From: zhaoguohan@kylinos.cn
To: Peter Maydell <peter.maydell@linaro.org>
Cc: GuoHan Zhao <zhaoguohan@kylinos.cn>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH] hw/arm/omap_sx1: map CS3 at the correct base
Date: Fri,  3 Apr 2026 10:02:36 +0800
Message-ID: <20260403020236.85278-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFEAcA_QQ_Hx0_Q5P7-Hne6sJvQoss-RLh9=OzmPZ3m-LqcGYw@mail.gmail.com>
References: <20260402071718.130490-1-zhaoguohan@kylinos.cn>
 <CAFEAcA_QQ_Hx0_Q5P7-Hne6sJvQoss-RLh9=OzmPZ3m-LqcGYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Hi,

Thanks for the reminder — I've resent the patch to qemu-devel@nongnu.org and kept qemu-arm on CC to follow the proper process.

I was looking into this code while studying and experimenting with QEMU's ARM machine implementations, especially around memory mapping and device initialization. While working through the code, I noticed this inconsistency in the chip-select mapping.

thanks,

ZGH


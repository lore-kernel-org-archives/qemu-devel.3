Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BD8C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 06:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9GWb-0002o9-CX; Wed, 23 Sep 2026 02:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=md1720B46088=lizhaoxin04@baidu.com>)
 id 1x9GWT-0002np-5f
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 02:32:05 -0400
Received: from mx16.baidu.com ([111.202.115.101] helo=outbound.baidu.com)
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <prvs=md1720B46088=lizhaoxin04@baidu.com>)
 id 1x9GWR-00026x-LR
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 02:32:04 -0400
X-MD-Sfrom: lizhaoxin04@baidu.com
X-MD-SrcIP: 172.31.4.16
From: Li Zhaoxin <lizhaoxin04@baidu.com>
To: <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Longpeng <longpeng2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhaoxin <lizhaoxin04@baidu.com>
Subject: Re: [PATCH] vdpa-dev: implement guest_notifier_mask/pending
Date: Wed, 23 Sep 2026 14:31:51 +0800
Message-ID: <20260923063151.39400-1-lizhaoxin04@baidu.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260909155042.34186-1-lizhaoxin04@baidu.com>
References: <20260909155042.34186-1-lizhaoxin04@baidu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjkjy-exc6.internal.baidu.com (172.31.50.50) To
 bjhj-exc18.internal.baidu.com (172.31.4.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1790145118;
 bh=NqaCM6oVjqoeKP2W5Ez5abVbIKT+aW7sJQIAflDbQCw=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=Xuih2PY+rl+4xtXjYYKXdwhqPSesm4Ue7BMXMh1BScBtWh9Tv0q3t5rjzTFMqBaEX
 OxxnfhWDBVl2tK1nW439mNUPh0/Hvz09Nptw9juLu99gqKkWegftYrViOlbF0laon/
 KNn7PjRObIdlXKJKoZiHKKMxJNXPqGKjfzw2BvkeCoOOcxdWIPmzfqqQTh9pHx5Wyv
 63aYCbtfouTuu+8UKEV8uVID4RcYHr/eYKEMBBI5x3IqPP08oLhjlk3o9yUe0WAxJQ
 7AXL3NFpIJz+d8Zz0EV1S3lkEw39Z/wqf0y0hDBJNdj8rDtfuojcUZ0q6g8HU8MFI5
 /Y1KqHeG7Umgw==
Received-SPF: pass client-ip=111.202.115.101;
 envelope-from=prvs=md1720B46088=lizhaoxin04@baidu.com; helo=outbound.baidu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gentle ping =E2=80=94 any feedback on this patch would be appreciated. Than=
ks!=0D


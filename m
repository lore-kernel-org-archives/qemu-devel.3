Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50A1C282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqEa-0001Jz-BM; Mon, 10 Mar 2025 23:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1trqEY-0001JD-9S; Mon, 10 Mar 2025 23:24:46 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1trqEW-0007Zl-0U; Mon, 10 Mar 2025 23:24:46 -0400
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZBfJC5R9Qz1cyl6;
 Tue, 11 Mar 2025 11:24:27 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id 7D8C61800C9;
 Tue, 11 Mar 2025 11:24:30 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 11:24:29 +0800
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>, <fam@euphon.net>, <hreitz@redhat.com>,
 <kwolf@redhat.com>, <qemu-block@nongnu.org>, <zhuyangyang14@huawei.com>,
 <qemu-stable@nongnu.org>, <luolongmin@huawei.com>, <suxiaodong1@huawei.com>,
 <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>, <wangjian161@huawei.com>,
 <mujinsheng@huawei.com>, <alex.chen@huawei.com>, <eric.fangyi@huawei.com>,
 <zoudongjie@huawei.com>, <chenjianfei3@huawei.com>, <renxuming@huawei.com>
Subject: Re: [PATCH 0/2] qapi: Fix qmp_block_set_io_throttle blocked for too
 long
Date: Tue, 11 Mar 2025 11:24:04 +0800
Message-ID: <20250311032404.1132164-1-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250308101618.721954-1-zoudongjie@huawei.com>
References: <20250308101618.721954-1-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=zoudongjie@huawei.com; helo=szxga08-in.huawei.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  zoudongjie <zoudongjie@huawei.com>
From:  zoudongjie via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ping.



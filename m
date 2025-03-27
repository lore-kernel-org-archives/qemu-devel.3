Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871EFC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 12:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txmTL-0000v9-IE; Thu, 27 Mar 2025 08:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1txmTH-0000sV-BR; Thu, 27 Mar 2025 08:36:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1txmTD-0007ZY-H4; Thu, 27 Mar 2025 08:36:31 -0400
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZNjhB1Hpvz1jBTx;
 Thu, 27 Mar 2025 20:31:38 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id C12401A016C;
 Thu, 27 Mar 2025 20:36:18 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 27 Mar
 2025 20:36:17 +0800
To: <armbru@redhat.com>
CC: <alex.chen@huawei.com>, <chenjianfei3@huawei.com>,
 <eric.fangyi@huawei.com>, <fam@euphon.net>, <hreitz@redhat.com>,
 <kwolf@redhat.com>, <luolongmin@huawei.com>, <mujinsheng@huawei.com>,
 <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>,
 <renxuming@huawei.com>, <stefanha@redhat.com>, <suxiaodong1@huawei.com>,
 <wangjian161@huawei.com>, <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>,
 <zhuyangyang14@huawei.com>, <zoudongjie@huawei.com>
Subject: Re: [PATCH v3 2/2] qapi/throttle: add timeout parameter for
 qmp_block_set_io_throttle()
Date: Thu, 27 Mar 2025 20:34:43 +0800
Message-ID: <20250327123443.2250580-1-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <8734ey2924.fsf@pond.sub.org>
References: <8734ey2924.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zoudongjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 27 Mar 2025 09:04:51 +0100, Markus wrote:
> zoudongjie <zoudongjie@huawei.com> writes:
> 
> > On Wed, Mar 26, 2025 at 10:53:20 +0100, Markus wrote:
> >> zoudongjie via <qemu-devel@nongnu.org> writes:
> >> 
> >> > From: Zhu Yangyang <zhuyangyang14@huawei.com>
> >> >
> >> > Calling qmp_block_set_io_throttle() will be blocked for a long time
> >> > when a network disk is configured and the network failure is just about
> >> > to occur.
> 
> What other commands could similarly block?

In theory, any command may be blocked if it calls bdrv_drained_begin().
I did a quick check, qmp_block_resize() could similarly block, since it called
bdrv_drained_begin(), I'm going to verify it later.

> 
> >> > Therefore, we add a timeout parameter for qmp_block_set_io_throttle to control
> >> > its execution duration.
> >> 
> >> What's the QMP reply when a block_set_io_throttle command times out?
> >
> > The reply is:
> > {"id":"libvirt-484","error":{"class":"GenericError","desc":"Blk io limits disable timeout"}}
> 
> I find the error message confusing.  Suggest "command timed out".

This message doesn't provide more details about the error, especially for developers.
How about using "command timed out: disable I/O limits"

> 
> >> >
> >> > The default value of timeout is 0, that is infinite wait, consistent with
> >> > previous behavior.
> >> >
> >> > Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> 
> [...]


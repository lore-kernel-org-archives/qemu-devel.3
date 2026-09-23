Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7959C98309
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 06:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9GTU-0001yG-5I; Wed, 23 Sep 2026 02:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=md1720B46088=lizhaoxin04@baidu.com>)
 id 1x9GTR-0001y6-L7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 02:28:57 -0400
Received: from mx20.baidu.com ([111.202.115.85] helo=outbound.baidu.com)
 by eggs.gnu.org with smtp (Exim 4.90_1)
 (envelope-from <prvs=md1720B46088=lizhaoxin04@baidu.com>)
 id 1x9GTM-0001eY-Lc
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 02:28:57 -0400
X-MD-Sfrom: lizhaoxin04@baidu.com
X-MD-SrcIP: 172.31.4.16
From: Li Zhaoxin <lizhaoxin04@baidu.com>
To: <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Longpeng <longpeng2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhaoxin <lizhaoxin04@baidu.com>
Subject: Re: [PATCH] vdpa-dev: implement guest_notifier_mask/pending
Date: Wed, 23 Sep 2026 14:28:34 +0800
Message-ID: <20260923062834.35973-1-lizhaoxin04@baidu.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260909155042.34186-1-lizhaoxin04@baidu.com>
References: <20260909155042.34186-1-lizhaoxin04@baidu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: bjkjy-exc10.internal.baidu.com (172.31.50.20) To
 bjhj-exc18.internal.baidu.com (172.31.4.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1790144923;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=JlMpi7IY2U0Xda2ajdJQPSaVwfAKRzYmMRLK0QlVK2a/riY5dflvhgQHH3IkXIwiB
 Pz0PGMhGBs4n1shUc9NCSFxtL2rvMJL3xzaWqZAnavnGavI2C+IE4SZkZ+oyeVKOnM
 A5I2iyQPdJ+F7zD+9cV4lZl301FcEqunT2owel5IHwlFsK62HyCum1+t4SD6ypiq8S
 dOtpBhBGK5ut7fcMA7J440+N0YXRcnhe8OnXrlohZ5A47OrhCxGXxbEqlSppsudTeS
 ngzXfhdA9ykB9muY4Ov4MavaUKHj+DkTtdHwfViw5z+CVk/KcNWWZkG16v1gJllQgZ
 McFUio03RYOOA==
Received-SPF: pass client-ip=111.202.115.85;
 envelope-from=prvs=md1720B46088=lizhaoxin04@baidu.com; helo=outbound.baidu.com
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, EMPTY_MESSAGE=2.32, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=no autolearn_force=no
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



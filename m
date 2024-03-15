Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8171C54E5D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 01:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkwkp-0000HY-9B; Thu, 14 Mar 2024 21:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1rkwkj-0000H5-U0
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 21:52:57 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1rkwkg-0006hM-LZ
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 21:52:57 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3tEHnqfNlqUOwBg--.43868S2;
 Fri, 15 Mar 2024 09:52:39 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwD3aEHlqfNliS8AAA--.98S3;
 Fri, 15 Mar 2024 09:52:37 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com
Cc: dave.jiang@intel.com, fan.ni@samsung.com, ira.weiny@intel.com,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 0/7]  QEMU CXL Provide mock CXL events and irq support
Date: Fri, 15 Mar 2024 09:52:28 +0800
Message-Id: <20240315015228.307512-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530133603.16934-1-Jonathan.Cameron@huawei.com>
References: <20230530133603.16934-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3aEHlqfNliS8AAA--.98S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWXzUXsAmQACsi
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKw17XrW8CFWxWr4ktFWfGrg_yoWDGFX_uF
 4vkFZIvw4ayFn8Ar47XFW8W3y3J3yDu3y5WF4kJF4Iyr1fJwsxGan2yF9xJa43GFW5Xan0
 ywn8X3s2gw1xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello, Jonathan

When during the test of qmps of CXL events like "cxl-inject-general-media-event", 
I am confuesd about the argument "flags". According to "qapi/cxl.json" in qemu, 
this argument represents "Event Record Flags" in Common Event Record Format.
However, it seems like the specific 'Event Record Severity' in this field can be
different from the value of 'Event Status' in "Event Status Register". 

For instance (take an injection example in the coverlatter):

{ "execute": "cxl-inject-general-media-event",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "log": "informational",
        "flags": 1,
        "dpa": 1000,
        "descriptor": 3,
        "type": 3,
        "transaction-type": 192,
        "channel": 3,
        "device": 5,
        "component-id": "iras mem"
    }}

In my understanding, the 'Event Status' is informational and the 
'Event Record Severity' is Warning event, which means these two arguments are
independent of each other. Is my understanding correct?

Many thanks
Yuquan



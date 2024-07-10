Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA010C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 01:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRMJu-0002xm-5o; Tue, 09 Jul 2024 21:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sRMJq-0002vG-0q; Tue, 09 Jul 2024 21:40:31 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sRMJn-0002xw-34; Tue, 09 Jul 2024 21:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1720575614; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=1a6+uQnEOwp0DyKmcUQBFKCn9TG/xo+wIn35Orx1nEY=;
 b=YBNDzU/NB3fKHneaa3uLeypJCcSvYuSSTbU1KCExPXkkNsKc8YWq8VyUb16J0khfTf1EbqSLJMV+2G7JJ1YBAFn55PcdkAPkxyDOwUX2muWwk2pPn6mXzIU6dKe38/UwV5sVztKtn2VYI7tSMjokVjKw+7apoVJgklTNP3S8DDM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R601e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0WADHC-d_1720575613; 
Received: from 30.166.64.104(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WADHC-d_1720575613) by smtp.aliyun-inc.com;
 Wed, 10 Jul 2024 09:40:14 +0800
Message-ID: <782baf65-68cd-409b-82f3-b24f3a9f9dc6@linux.alibaba.com>
Date: Wed, 10 Jul 2024 09:38:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] tests/avocado: Add an avocado test for riscv64
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com,
 bmeng.cn@gmail.com, richard.henderson@linaro.org, philmd@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240708131645.1345-1-zhiwei_liu@linux.alibaba.com>
 <20240708131645.1345-8-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKNOE2J95o0CRxDnxV-G4gmogaF-MoDsU7v+TF1hZ49brg@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CAKmqyKNOE2J95o0CRxDnxV-G4gmogaF-MoDsU7v+TF1hZ49brg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/7/10 9:31, Alistair Francis wrote:
> On Mon, Jul 8, 2024 at 11:22 PM LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:
>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>
>> To regularly test booting Linux with rv32 on QEMU RV64,
>> we have added a test to boot_linux_console.py to retrieve
>> cpuinfo and verify if it shows 'rv32' when using RV64 to
>> boot rv32 CPUs.
>>
>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Something is wrong here, it should only be an Ack

Sorry, I missed checking this. Will fix it in next version.

Zhiwei

>
> Alistair


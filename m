Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896D8F8D761
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDPFl-00006x-F3; Thu, 16 Apr 2026 12:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wDPFf-00006Z-4r
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:07:35 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>) id 1wDPFb-0007Y8-RQ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:07:34 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3f5s1CeFpDW5iCQ--.2315S2;
 Fri, 17 Apr 2026 00:07:17 +0800 (CST)
Received: from [192.168.31.119] (unknown [113.246.119.50])
 by mail (Coremail) with SMTP id AQAAf8DwFZQsCeFp5M8KAA--.26811S2;
 Fri, 17 Apr 2026 00:07:08 +0800 (CST)
Message-ID: <02e21af2-d6e8-4418-9cab-af56c81afc27@phytium.com.cn>
Date: Fri, 17 Apr 2026 00:07:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/28] MAINTAINERS: Remove Huai-Cheng Kuo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-11-peter.maydell@linaro.org>
 <58a32864-6c05-432c-bdc2-5763e32cda99@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <58a32864-6c05-432c-bdc2-5763e32cda99@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwFZQsCeFp5M8KAA--.26811S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAHBWnf5fgEpQACsL
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKF13KFyrCF48AFy5CF4Durg_yoWkZrX_Zw
 4jv397u3WqgF17GayDCFZ7Aw4jkrZrGF1fKFnxXr13JFy3XryDGF1vga9avw18KF4fWrZF
 va4DJr43K3yagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2026/4/16 19:28, Philippe Mathieu-Daudé wrote:
> On 16/4/26 11:16, Peter Maydell wrote:
>> Huai-Cheng Kuo has not posted to qemu-devel in some years and did not
>> respond to a query about whether they still wished to be listed in
>> our MAINTAINERS file.  Remove them, on the assumption that they are
>> no longer active in QEMU.
>>
>> This makes "PCIE DOE" orphan.
>
> Cc'ing Tao & Gustavo who are working on Security Protocol and Data Model
> (SPDM) which IIUC use DOE.


Thanks Philippe. DOE is indeed relevant to SPDM and RME-DA work we have 
been looking at.

I will help review changes in this area as they come up.


Best regards,

Tao


>
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   MAINTAINERS | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0b2adbc247..bc7c9b61da 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2160,8 +2160,7 @@ F: docs/specs/*pci*
>>   F: docs/system/sriov.rst
>>     PCIE DOE
>> -M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
>> -S: Supported
>> +S: Orphan
>>   F: include/hw/pci/pcie_doe.h
>>   F: hw/pci/pcie_doe.c



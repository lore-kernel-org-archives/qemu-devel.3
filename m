Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF2FF4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgCJ-00060K-BQ; Fri, 17 Apr 2026 06:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wDgCG-000607-Sq
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:13:12 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>) id 1wDgCD-0000x6-E8
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:13:12 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAXH6OmB+JptM+UAA--.49146S2;
 Fri, 17 Apr 2026 18:12:54 +0800 (CST)
Received: from [10.31.91.158] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwS5GlB+JpePEKAA--.3805S2;
 Fri, 17 Apr 2026 18:12:54 +0800 (CST)
Message-ID: <44abaece-6a6f-43c6-b29a-53d6eb08033c@phytium.com.cn>
Date: Fri, 17 Apr 2026 18:12:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/28] MAINTAINERS: Remove Huai-Cheng Kuo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-11-peter.maydell@linaro.org>
 <58a32864-6c05-432c-bdc2-5763e32cda99@linaro.org>
 <02e21af2-d6e8-4418-9cab-af56c81afc27@phytium.com.cn>
 <a75dcca3-9cab-49e3-818c-4d52c2a1bdd6@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <a75dcca3-9cab-49e3-818c-4d52c2a1bdd6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwS5GlB+JpePEKAA--.3805S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAHBWnf5fgEpQAJsA
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tw15Gr1rZrWfZry8trW7XFb_yoW8KF1kpF
 ykJas2kFZrJr1xAFs3K3WSvFn5ta9Yyw1xXwnFgry5Zr9Fvr9xKa17Kr15CFyDWr4xXrWY
 9Fy3tw1xXa1kAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
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


On 2026/4/17 16:58, Philippe Mathieu-Daudé wrote:
> On 16/4/26 18:07, Tao Tang wrote:
>>
>> On 2026/4/16 19:28, Philippe Mathieu-Daudé wrote:
>>> On 16/4/26 11:16, Peter Maydell wrote:
>>>> Huai-Cheng Kuo has not posted to qemu-devel in some years and did not
>>>> respond to a query about whether they still wished to be listed in
>>>> our MAINTAINERS file.  Remove them, on the assumption that they are
>>>> no longer active in QEMU.
>>>>
>>>> This makes "PCIE DOE" orphan.
>>>
>>> Cc'ing Tao & Gustavo who are working on Security Protocol and Data 
>>> Model
>>> (SPDM) which IIUC use DOE.
>>
>>
>> Thanks Philippe. DOE is indeed relevant to SPDM and RME-DA work we 
>> have been looking at.
>
> Commit 4f947b10d52 ("hw/nvme: Add SPDM over DOE support"), described as:
>
>     Setup Data Object Exchange (DOE) as an extended capability for
>     the NVME controller and connect SPDM to it (CMA) to it.
>
> introduced the docs/specs/spdm.rst file which isn't maintained:
>
> $ ./scripts/get_maintainer.pl -f docs/specs/spdm.rst
> get_maintainer.pl: No maintainers found, printing recent contributors.
> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
>
> Would it make sense to move hw/pci/pcie_doe.* to the SPDM section
> instead of orphanize them?
>
>   SPDM
>   M: Alistair Francis <alistair.francis@wdc.com>
>   S: Maintained
>   F: backends/spdm-socket.c
>   F: include/system/spdm-socket.h
>
> Added in Cc contributors who might be interested in being listed
> as co-maintainer or reviewer ;)


Hi Philippe,

If useful, I would be glad to be listed as a reviewer and help review 
changes in this area going forward.


Thanks,

Tao



>
>>
>> I will help review changes in this area as they come up.
>>
>>
>> Best regards,
>>
>> Tao
>>
>>
>>>
>>>>
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>>   MAINTAINERS | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 0b2adbc247..bc7c9b61da 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2160,8 +2160,7 @@ F: docs/specs/*pci*
>>>>   F: docs/system/sriov.rst
>>>>     PCIE DOE
>>>> -M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
>>>> -S: Supported
>>>> +S: Orphan
>>>>   F: include/hw/pci/pcie_doe.h
>>>>   F: hw/pci/pcie_doe.c
>>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3307EF3D60A
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 15:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6rvk-0001ZM-CY; Sun, 29 Mar 2026 11:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w6rvh-0001U1-2T; Sun, 29 Mar 2026 11:19:57 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w6rve-0004E7-3j; Sun, 29 Mar 2026 11:19:56 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3fZkTQ8lpMAOtCA--.3919S2;
 Sun, 29 Mar 2026 23:19:47 +0800 (CST)
Received: from [192.168.31.176] (unknown [222.244.183.215])
 by mail (Coremail) with SMTP id AQAAf8DwwZIRQ8lpVkcHAA--.15431S2;
 Sun, 29 Mar 2026 23:19:45 +0800 (CST)
Message-ID: <25351f50-a3c5-4457-a7fe-0fd0d0594a22@phytium.com.cn>
Date: Sun, 29 Mar 2026 23:19:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 3/4] tests/qtest: Add qtest-attrs-test for memory access
 attrs
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260323133210.1523868-1-tangtao1634@phytium.com.cn>
 <20260323133210.1523868-4-tangtao1634@phytium.com.cn>
 <acJKBPwxvFa54DJM@ZEVORN-PC.localdomain>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <acJKBPwxvFa54DJM@ZEVORN-PC.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwwZIRQ8lpVkcHAA--.15431S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAJBWnIKvkcBgAAsl
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrury8Jw17uFyUJFW8Xw1rXrb_yoWfuFc_Wr
 yjy3s5Cw1vyF4UuFs8tr1Skr9xuFWxtw1vkw1DJr13Cw1SyFyDuFnxt3W0q3WrGw1Iqrs7
 Ww1DAF15JwsrujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Chao,

On 3/24/2026 4:26 PM, Chao Liu wrote:
> On Mon, Mar 23, 2026 at 09:32:09PM +0800, Tao Tang wrote:
>> Add qtest-attrs-test to exercise qtest memory access commands with attrs
>> on both aarch64 and x86.
>>
>> The test covers:
>> - Arm virt,secure=on: scalar and bulk accesses across non-secure,
>>    secure, and root spaces, plus negative coverage for realm and for
>>    non-secure accesses into secure-only RAM
>> - x86 q35: normal accesses
>> - libqtest-single *_attrs shortcut wrappers
> There's a gap:
>
> patch 1 adds several parser-level ERR paths
> (invalid attrs string, space=... on non-Arm targets,
> too many arguments) but none of them are exercised
> here. Since qtest_raw_cmd() is already available from
> patch 2, it would be straightforward to add a few
> negative cases for those error strings.
>
> Thanks,
> Chao


Thanks for the suggestion.


I indeed missed some negative cases. I'll fix them in v4.


Best regards,

Tao



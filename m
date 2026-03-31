Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34315109B492
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7bRq-0001Ny-Lw; Tue, 31 Mar 2026 11:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7bRn-0001NS-VN; Tue, 31 Mar 2026 11:56:08 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7bRk-0001Of-BF; Tue, 31 Mar 2026 11:56:07 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwC3vqKM7stpiP1BAA--.22084S2;
 Tue, 31 Mar 2026 23:55:56 +0800 (CST)
Received: from [192.168.31.119] (unknown [222.244.182.203])
 by mail (Coremail) with SMTP id AQAAf8DwJ5OK7stp9NQHAA--.18267S2;
 Tue, 31 Mar 2026 23:55:55 +0800 (CST)
Message-ID: <6ad7c0a0-3b6f-42e3-a4f2-0817ab3343e7@phytium.com.cn>
Date: Tue, 31 Mar 2026 23:55:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/qtest: Add libqtest attrs helpers for memory
 accesses
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
 <20260331040659.401397-3-tangtao1634@phytium.com.cn>
 <CAFEAcA9-=VKiGYMxYMTPhnKovWxYyEcTGp3+Yw3Cy0H1pDTv=g@mail.gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <CAFEAcA9-=VKiGYMxYMTPhnKovWxYyEcTGp3+Yw3Cy0H1pDTv=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwJ5OK7stp9NQHAA--.18267S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWnKzfEFuwABsv
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKw1rAF1UGrW7trW8tF4kXrb_yoWkGFg_Za
 1UtryDWw4jvF4ftay8Kan0vrZ0kFy8WFsIqw18Xa17GF18ZF93Wrn7tr93Ja1rWw1rXws2
 krn0934rtFnIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=-1,
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

Hi Peter,

On 2026/3/31 18:26, Peter Maydell wrote:
> On Tue, 31 Mar 2026 at 05:07, Tao Tang <tangtao1634@phytium.com.cn> wrote:
>> Expose libqtest APIs for qtest memory commands with optional attrs:
>> - qtest_{read,write}{b,w,l,q}_attrs()
>> - qtest_mem{read,write,set}_attrs()
>> - qtest_buf{read,write}_attrs()
>>
>> Keep the existing libqtest memory access helpers as wrappers passing
>> NULL attrs, so current users remain unchanged.
>>
>> Also add matching libqtest-single shortcut wrappers for the *_attrs
>> helpers.
> This part is fine.
>
>> Refactor libqtest response parsing by splitting qtest_rsp_args() into a
>> raw tokenizing helper, qtest_rsp_words(), and the existing OK-checking
>> wrapper. Add qtest_raw_cmd() on top of qtest_rsp_words() so tests can
>> send raw qtest protocol commands and inspect non-OK responses such as
>> ERR and FAIL.
> This is a separate thing and shouldn't be in the same patch.
>
> thanks
> -- PMM


I’ll split the qtest response-parsing refactor and qtest_raw_cmd() into 
a separate preparatory patch in the next version.


Thanks,

Tao




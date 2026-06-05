Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C39ACD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWP1-0007Kd-ET; Fri, 05 Jun 2026 11:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVWP0-0007KN-Jq
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:24:06 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVWOy-0007WY-0s
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780673038; bh=VyfoauI6Gno2xS3PIHsgI75TM3BFGcw9paRZbrUoHVo=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=Y+khHFU9c4g0kWB4RyWQbKLdJufw/5C94HfEgzl0CB8O+6l+kbUL0pBDl6E0BpzVa
 NlDdMBr3k4uwdmpuQkiBJiubZoeXmSgPaOrShdcwHJttF7b7W2kpO4W/9+zeJd7PqC
 AL96Aqp7ju+6jfxk33tC0j0PObB9L20Pmh/Gttao=
Received: by be1-4.in.mailobj.net [192.168.91.14] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Fri,  5 Jun 2026 17:23:58 +0200 (CEST)
X-EA-Auth: KrqRNhUGck7cN92rE94XLc8uPmFIIJMNsUTKK5AWaAm2HYVv7QstRB+BIiF9Xc3lerTEwCA8TDN7sqVgZOQ+OzGVAw1o3wno
Message-ID: <f74e2828-921a-46e7-b6e3-83508a40ca90@mailo.com>
Date: Fri, 5 Jun 2026 17:23:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 38/38] target/hexagon: Add hex_interrupts support
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Michael Lambert <mlambert@quicinc.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-39-brian.cain@oss.qualcomm.com>
 <c71f8159-5c3d-4e02-aa08-7d979f5454ab@linaro.org>
 <CAEqNhNaJx6_KPW8dxsoN3WdoVLAxhVQKKD=2S92ya9KONMdboA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <CAEqNhNaJx6_KPW8dxsoN3WdoVLAxhVQKKD=2S92ya9KONMdboA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.12; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 3/6/26 16:00, Brian Cain wrote:
> On Sun, May 31, 2026 at 4:31 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 29/5/26 23:55, Brian Cain wrote:
>>> From: Brian Cain <bcain@quicinc.com>
>>>
>>> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
>>> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    target/hexagon/cpu.h            |   2 +
>>>    target/hexagon/hex_interrupts.h |  15 ++
>>>    target/hexagon/cpu.c            |   4 +
>>>    target/hexagon/hex_interrupts.c | 371 ++++++++++++++++++++++++++++++++
>>>    4 files changed, 392 insertions(+)
>>>    create mode 100644 target/hexagon/hex_interrupts.h
>>>    create mode 100644 target/hexagon/hex_interrupts.c
>>
>> Patch #28 mentions NMI, how is it handled?
> 
> In these three patchsets, the nmi remains unimplemented.  Would you
> prefer I include the nmi implementation?

Could we simply drop the nmi helper in patch #28 and add it along
with the rest of the NMI implementation?





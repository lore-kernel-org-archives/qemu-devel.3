Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B84CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPCIs-0005TK-P1; Tue, 19 May 2026 00:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPCIr-0005St-It
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:43:37 -0400
Received: from smtpout2.mo534.mail-out.ovh.net ([51.210.94.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPCIn-0005Jm-RV
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:43:37 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.68.80.175])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gKMW52CFfz6LNZ;
 Tue, 19 May 2026 04:43:29 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 19 May 2026 04:43:29 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.100])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gKMW46ytwz5vd9; Tue, 19 May 2026 04:43:28 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id E90FB941730; 
 Tue, 19 May 2026 04:43:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S0088dd7906c-4e00-434e-8f19-7242ecb79bd4,
 A1C5BDF50025601E7F63D663DE463AD2E6007479) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <cdad7a1a-8032-46f0-bf94-63afd68759aa@kaod.org>
Date: Tue, 19 May 2026 06:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] aspeed/hace: Prevent total_req_len overflow
To: Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>, qemu-stable@nongnu.org
References: <20260504213421.710035-1-clg@redhat.com>
 <20260504213421.710035-3-clg@redhat.com>
 <1df3c974-0e84-4801-9441-705d4241dfe8@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <1df3c974-0e84-4801-9441-705d4241dfe8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 16893283677665144060
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFljm2gbpaQGvVknwi3ISUNu5MXqCdqwbVom+/yZyvFUCcmBsGguQss4j+PxOYhGkptF8o1lo0DKvrVHKqIK06mV0xaFH0XUfqkFPYbRU3uVxubTglXD1pSSccuc4MOK41FK50aDSnILszQ2ahxudUP0et9aupOqymroAEKJrGZmf5ZRqWcXjdgIhOH3IiyWArgIoejpjHsawNnVRekLVs+bBylnXy3Ql9G9nU5N8WhZwgKvu8TbyiaGUK2Kpv67f35J3O9zlUsfW7Y1kTsC8eilwN33Ijh10TD1WU7fHw7Ju39BHgRvnwS8TGeYJcJnds9mejA2HAqNsl1eJ7O07Orr1ITQkDKvn+bTwbspUEYLUp5QC40XfeapriiaOwIvvZ0m0dcOGyZF+BhriNKzbnB1hvPzXPYhC9DDjUzNIdviByJlxKFutCJydFvp43x45XUallqyvKFGoRMCza2KsSJTRd2HT1on0qOwraJbeOnI/KVkdPNU4J8qITjQvptqMWpSkApm2U/iH+JaAjmNt/p1uAR+ZUbRuT+an7bvMcoHzF0iO3itZS/vf2UStFoORBFhMW8m3rS1hQ8AebsRleGBBi3wkuduiBA+i01EBQE6KwJO91GK94LcIp0/E4QSFfdkTs7APZBQg63IHy1F9ZQTxUrgjRjaEY+w8TOofO+lA
DKIM-Signature: a=rsa-sha256; bh=UNJU6eSuY4VQUKcxVmYKpsiuhM7LLwkejd5LIQO932o=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779165810; v=1;
 b=JLcDm32Kf9sQGXFQT6+Ch/dxSgzEeuUmGvP6low9p4FD93/NYHutWkkY5+TGk52MYOmG9lhf
 mLHBCWKhHUHXHfTXyVyBWJDy5Ytnm1bXA6b7jK7xJGq0AupdAnChXGTELawPIEBfXuQTW0YvHV0
 31sfZRvlUZ1glYQm8mJNYTdQZJMCWQ9X+3R9kzawYEC+Fu6OsfRnsb7YXaUjuEHpIhLS2Af7/tI
 iBmCPeA97AVA+778qOyWGujN1Qv8YNcgoBPXUOigMWAFSO8fdNyZeUVpjIBYrjQjeU7h9+ytiCJ
 4Eu8SZohOIUgJhV2qKIaIv7U28IJn5IiXyxSKngNKFaEw==
Received-SPF: pass client-ip=51.210.94.141; envelope-from=clg@kaod.org;
 helo=smtpout2.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/14/26 21:13, Michael Tokarev wrote:
> On 05.05.2026 00:34, Cédric Le Goater wrote:
>> In accumulate mode, total_req_len is incremented with plen (hwaddr)
>> for each hash request. Repeated additions can overflow total_req_len
>> (uint32_t) and potentially bypass validation checks in has_padding().
>>
>> Add a helper function to detect overflow before incrementing
>> total_req_len and reject the request if overflow would occur.
>>
>> Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 5cd7d8564a8b ("aspeed/hace: Support AST2600 HACE")
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> This change does not apply to 10.0.x qemu-stable series, because,
> at least, it lacks v10.0.0-1171-g7328c48b57c9 "hw/misc/aspeed_hace:
> Extract direct mode hash buffer setup into helper function".
> This code in 10.0.x is slightly different, namely, there's no
> error return from the function in question.  Please take a look
> at https://gitlab.com/mjt0k/qemu/-/commits/4a82112f40351e94f1b3af938782298abda1c810
> which is my attempt to fix this code for 10.0.x (not even compile-
> tested yet).

Looks correct.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



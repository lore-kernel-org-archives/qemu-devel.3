Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADF6CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 08:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHHUL-0006Ji-5p; Fri, 07 Nov 2025 03:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHHUE-0006Ex-Lj
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 03:06:23 -0500
Received: from 3.mo552.mail-out.ovh.net ([178.33.254.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vHHU6-0001St-ED
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 03:06:22 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.133])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d2s80260Gz5wxL;
 Fri,  7 Nov 2025 08:06:07 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 7 Nov
 2025 09:06:07 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00308dce2ef-c364-4330-870f-18bc9d442654,
 22B515FCB2325FA901564F8AB94FB8FB00D14EB6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <987ff09c-7b9d-49a5-8e81-38144fee1b4f@kaod.org>
Date: Fri, 7 Nov 2025 09:06:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/17] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
To: Kane Chen <kane_chen@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Joe Komlodi <komlodi@google.com>, Patrick Leis
 <venture@google.com>
CC: <troy_lee@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-16-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251105035859.3709907-16-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: a3ddb409-7068-42dd-8991-a9acac5d5bbe
X-Ovh-Tracer-Id: 12136919521607126008
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGPOyWOflf9XzuE9NwRvHXrANrZb7LIMgtr9LPlEBrrkSebFusqQZ9C7oKbxrnzo4/JNXMs5ctuZUWt+nrezDqd9EqkSPE4eo9piCl6RiZg3RXPgYloLpMXu/ZbHzepTtpUDlRvbhe4etKxfPbfzqgw69G9wJFMp4fA43CWVluDZr6vn0+718GqwAbvur7k2JICMt/VYtjHRTK52osZc/PL0rfGwI81d97AzeN8pYJR37W9mZ/cyEqxiTY+2jTCv2UtFD+1Mqdr87YDNHkxWLlSed9rlQTYnp9wrzaGeqFSFAkwMRC3MDHIE8kaQMpvJO7ssp03b1yePqpjUJpF4nFDLE0NdiaN5QDKxzzTKxmOY+mZU8vwXglxjs0G3CQ+i2xFQas1AKpm2vIC3XEB36RtEcbAXkNlcag+47GK3XYYhuwOcsKxB+mGIAHNWacYD6NyMg76PPJexzbqKmVeQVM/sQJgNZOtyH4PNnNls1rnFKB+R+wOXSG6hMOm+ztw1VPmXUf1CLLWDQycnSL1xBrDcqG7phq/WZhMaAhXLsaH/EHjgegvISxAtoqs2sjmVl67UvaxKJM+02aKKZ3MHRTKOU1YWeqoQQTSsdWpjgoh0wkME3TM3UawvYYBymQu1da0+GZTjAEP2c0qLRk28zJca8tuJU7B7i93dlyjql75FQ
DKIM-Signature: a=rsa-sha256; bh=vqiQHpMRc+YfkSGkGJLmlYrBzfN9yUiRBW2YHqW/58c=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762502770; v=1;
 b=BzSPUuFxmbCE6F9OViLfMhUru0bOyycn1RUg7vt+lwW4Ov1F4ifOrx5mZi7wemhge1o5hKdO
 48qpdURsivOiMJAbUxHEnWRMHpYOpJcbwGguQXjAzD8UOyRPUba99omcA4o/bfJhZXOCuXTr3DI
 qNtfOR/6gAt5xS6+LrdZmu0IxCprhB1ZYm769aZ9diZW+sMmFk0LQpvNy9tgNeOWyXg8TG66uYM
 EDP2QNROwKB9Hqg0WAqYcrNrXWCeUdw2YVnQ2NtElH+pZi0Sn0EzDkTe3SMEpgLnUTE0LvpyUWU
 LFReM3RN4VjMUcTeMMur7Nc7MJU8ZeK4PcWuaS5JoItVA==
Received-SPF: pass client-ip=178.33.254.192; envelope-from=clg@kaod.org;
 helo=3.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

+ Joe, Patrick

On 11/5/25 04:58, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> AST1700 exposes more I3C buses than the current dummy I3C model
> provides. When Linux probes the I3C devices on AST1700 this mismatch
> can trigger a kernel panic. Model the I3C block as an unimplemented
> device to make the missing functionality explicit and avoid unexpected
> side effects.
> 
> This wires up the I3C interrupt lines for the IO expanders and adds the
> corresponding device entries for the AST1700 model.
> 
> No functional I3C emulation is provided yet; this only prevents crashes and
> documents the missing piece.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h      |  2 ++
>   include/hw/misc/aspeed_ast1700.h |  2 ++
>   hw/arm/aspeed_ast27x0.c          | 19 +++++++++++++++++--
>   hw/misc/aspeed_ast1700.c         | 17 +++++++++++++++++
>   4 files changed, 38 insertions(+), 2 deletions(-)

Joe sent (twice) changes adding I3C support [1].

I’ve been maintaining it in my branch, and from both a code and testing
perspective, it looks solid. I believe it’s ready to be merged. We now
just need maintainers and reviewers to step in.

Would it be useful for this model ? If so, that would be an additional
reason.

Thanks,

C.

[1] https://lore.kernel.org/qemu-devel/20250613000411.1516521-1-komlodi@google.com/


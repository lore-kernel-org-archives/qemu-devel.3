Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA583C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU8k-0007eK-C6; Mon, 27 May 2024 02:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=e5bn=M6=kaod.org=clg@ozlabs.org>)
 id 1sBU8d-0006uK-8D; Mon, 27 May 2024 02:47:19 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=e5bn=M6=kaod.org=clg@ozlabs.org>)
 id 1sBU8a-00086B-GY; Mon, 27 May 2024 02:47:18 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VnmR11Dsxz4x0y;
 Mon, 27 May 2024 16:47:09 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VnmQv27JGz4wcR;
 Mon, 27 May 2024 16:47:02 +1000 (AEST)
Message-ID: <8ea0c423-f102-4ceb-941d-c9d64bfe8823@kaod.org>
Date: Mon, 27 May 2024 08:46:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/16] aspeed/smc: support 64 bits dma dram address
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240416091904.935283-1-jamin_lin@aspeedtech.com>
 <20240416091904.935283-9-jamin_lin@aspeedtech.com>
 <986d0cea-611d-46cd-a266-99bac6a62c55@kaod.org>
 <SI2PR06MB5041B10DED228B86F51909D8FCEC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <034f139a-dc5a-499b-9c1d-8417dcf1a4f9@kaod.org>
 <SI2PR06MB5041CFE7C56A014CDD10D790FCE92@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB5041CFE7C56A014CDD10D790FCE92@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=e5bn=M6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Jamin,


[ ... ]

>> See my aspeed-9.1 branch, I did some changes, mostly in the last patch.
>>
>> * aspeed_smc_dma_len()
>>
>>     - can use QEMU_ALIGN_UP(). simpler.
>>
>> * aspeed_smc_dma_rw():
>>
>>     - dram_addr ->  dma_dram_offset
>>     - There is no need to protect updates of the R_DMA_DRAM_ADDR_HIGH
>>       register with aspeed_smc_has_dma_dram_addr_high() since it is
>>       already protected with MMIO accesses. Skip the check and update
>>       always.
>>
>> * aspeed_smc_dma_dram_addr()
>>
>>     - same as above.
>>
>> You can merge the changes in the respective patches if you agree.
>>
>> Still on the TODO list :
>>
>>     - GIC review
>>     - aspeed/soc: fix incorrect dram size for AST2700
>>
>> Thanks,
>>
>> C.
>>
> I merged this commit into my code base and thanks for your kindly support.
> https://github.com/legoater/qemu/commit/d1bc2c776422a9d0d6af2b4414fae83fde1832ba
> 
> About GIC settings, you can refer to our kernel DTS setting for detail.
> https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi#L143-L164

Could you please resend a v4 including all the changes we discussed ?

Thanks,

C.





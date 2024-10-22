Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8825D1CDA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 05:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t37qX-0000xg-3W; Tue, 22 Oct 2024 01:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=pGrG=RS=kaod.org=clg@ozlabs.org>)
 id 1t37qT-0000wu-8s; Tue, 22 Oct 2024 01:54:17 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=pGrG=RS=kaod.org=clg@ozlabs.org>)
 id 1t37qR-0007eU-EQ; Tue, 22 Oct 2024 01:54:17 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XXhFX2Kj8z4wxf;
 Tue, 22 Oct 2024 16:54:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XXhFR0Jhmz4w2L;
 Tue, 22 Oct 2024 16:54:01 +1100 (AEDT)
Message-ID: <b162770d-c8f7-4931-a801-67d88e4a1c1f@kaod.org>
Date: Tue, 22 Oct 2024 07:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 09/16] test/qtest/aspeed_smc-test: Introduce a
 new TestData to test different BMC SOCs
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
 <20241018053112.1886173-10-jamin_lin@aspeedtech.com>
 <c395abee-68ca-4030-953f-476b364df62f@kaod.org>
 <SI2PR06MB50418E6553BC95BDCC71E4CAFC4C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB50418E6553BC95BDCC71E4CAFC4C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=pGrG=RS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.171, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/22/24 03:38, Jamin Lin wrote:
> Hi Cedric,
> 
>> Subject: Re: [SPAM] [PATCH v1 09/16] test/qtest/aspeed_smc-test: Introduce a
>> new TestData to test different BMC SOCs
>>
>> On 10/18/24 07:31, Jamin Lin wrote:
>>> Currently, these test cases are only used for testing fmc_cs0 for AST2400.
>>> To test others BMC SOCs, introduces a new TestData structure.
>>> Users can set the spi base address, flash base address, jedesc id and
>>> so on for different BMC SOCs and flash model testing.
>>>
>>> Introduce new helper functions to make the test case more readable.
>>>
>>> Set spi base address 0x1E620000, flash_base address 0x20000000 and
>>> jedec id 0x20ba19 for fmc_cs0 with n25q256a flash for AST2400 SMC
>>> model testing.
>>>
>>> To pass the TestData into the test case, replace qtest_add_func with
>>> qtest_add_data_func.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    tests/qtest/aspeed_smc-test.c | 546 +++++++++++++++++++---------------
>>>    1 file changed, 299 insertions(+), 247 deletions(-)
>>>
>>>
>>> -    fd = g_file_open_tmp("qtest.m25p80.XXXXXX", &tmp_path, NULL);
>>> +    fd = g_file_open_tmp("qtest.m25p80.n25q256a.XXXXXX",
>>> + &data->tmp_path, NULL);
>>
>> Why did you change the name ?
>>
> 
> The default flash size of fmc_cs0 are difference between ASPEED SOCs.
> For example: AST2400 default flash size of fmc_cs0 is 32MB but
> AST1030 default flash size of fmc_cs0 is 1MB.
> Besides, the testcases support to test jedec_id of flash.
> We set the different default flash model of fmc_cs0 for all ASPEED SOCs
> Ex:
> n25q256a jedec_id is 0x20ba19.
> w25q80bl jedec_id is 0xef4014.
> That was why I added the name of flash model in the filename of testing image.
> So, users easily know the testcases testing which flash model.
> 
> By the way, I set the different filename of testing image for AST1030, AST2500, AST2600 and AST2700.
> AST2500: "qtest.m25p80.mx25l25635e.XXXXXX"
> AST2600: "qtest.m25p80.mx66u51235f.XXXXXX"
> AST1030: “qtest.m25p80.w25q80bl.XXXXXX"
> AST2700: “"qtest.m25p80.w25q01jvq.XXXXXX"”
> 
> I am okay to set the filename of testing image back to "qtest.m25p80.XXXXXX" for AST2400.

No. Keep it as it is. I was wondering if this was some kind of work around.

LGTM,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


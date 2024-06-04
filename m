Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF847C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVrK-000477-Gt; Tue, 04 Jun 2024 11:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OW7X=NG=kaod.org=clg@ozlabs.org>)
 id 1sEVrH-00046t-W9
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:13:56 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OW7X=NG=kaod.org=clg@ozlabs.org>)
 id 1sEVrF-0002US-Cc
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:13:55 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VtvHw3W4Gz4x1Y;
 Wed,  5 Jun 2024 01:13:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VtvHt11JJz4wcq;
 Wed,  5 Jun 2024 01:13:45 +1000 (AEST)
Message-ID: <c24d36b4-4087-4042-931e-0398d32e500e@kaod.org>
Date: Tue, 4 Jun 2024 17:13:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/32] hw/sd: Add emmc_cmd_SEND_RELATIVE_ADDR() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-18-clg@kaod.org>
 <d5680124-827a-4b03-838c-77754a84599c@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <d5680124-827a-4b03-838c-77754a84599c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=OW7X=NG=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/3/24 14:26, Philippe Mathieu-Daudé wrote:
> On 3/7/23 15:24, Cédric Le Goater wrote:
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/sd/sd.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index dd60a16f8c0a..5ff132139ea9 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1053,6 +1053,25 @@ static sd_rsp_type_t sd_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
>>       return sd_r2_i;
>>   }
>> +static void sd_emmc_set_rca(SDState *sd, uint16_t value)
>> +{
>> +    sd->rca = value;
>> +}
>> +
>> +static sd_rsp_type_t emmc_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
> 
> "emmc_cmd_SET_RELATIVE_ADDR".

Fixed.


Thanks,

C.


> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +{
>> +    switch (sd->state) {
>> +    case sd_identification_state:
>> +    case sd_standby_state:
>> +        sd->state = sd_standby_state;
>> +        sd_emmc_set_rca(sd, req.arg >> 16);
>> +        return sd_r1;
>> +
>> +    default:
>> +        return sd_invalid_state_for_cmd(sd, req);
>> +    }
>> +}
>> +
>>   static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
>>   {
>>       switch (sd->state) {
>> @@ -2194,6 +2213,7 @@ static const SDProto sd_proto_emmc = {
>>           [0]         = sd_cmd_GO_IDLE_STATE,
>>           [1]         = emmc_cmd_SEND_OP_CMD,
>>           [2]         = emmc_cmd_ALL_SEND_CID,
>> +        [3]         = emmc_cmd_SEND_RELATIVE_ADDR,
>>           [5]         = sd_cmd_illegal,
>>           [19]        = sd_cmd_SEND_TUNING_BLOCK,
>>           [23]        = sd_cmd_SET_BLOCK_COUNT,
> 



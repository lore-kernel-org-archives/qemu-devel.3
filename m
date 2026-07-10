Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D97BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiK2Z-00068F-Lq; Fri, 10 Jul 2026 18:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wiK2X-00065F-VX; Fri, 10 Jul 2026 18:49:49 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wiK2U-0001n0-SV; Fri, 10 Jul 2026 18:49:49 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4gxn8R1cwjz65mh;
 Fri, 10 Jul 2026 22:49:43 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <danielhb413@gmail.com>; Fri, 10 Jul 2026 22:49:43 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.1])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gxn8R0ndfz5vMB; Fri, 10 Jul 2026 22:49:43 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 5B6151923D45; Fri, 10 Jul 2026 22:49:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S00801d2b596-1a89-46d0-b045-376c1a9247b1,
 1CBBC061D37F2CD07CD19160E92E2EFC4735075F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <0e1cc6c4-c403-42c8-9bb9-d6d5a658965f@kaod.org>
Date: Sat, 11 Jul 2026 00:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 07/35] target/ppc: Implement watchpoint debug facility for
 v2.07S
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <Harsh.Prateek.Bora@ibm.com>
References: <20230904090630.725952-1-clg@kaod.org>
 <20230904090630.725952-8-clg@kaod.org>
 <905b6448-d313-4808-b76b-d42f9ecfae55@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <905b6448-d313-4808-b76b-d42f9ecfae55@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8576824018215742524
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFHVVLZBFbRGszGnoYFS37spCt6zjPh073Z0ayiAIkIh2211NqgXVltpfmiXiLirpPe6QpQ++yvRyb0WSlnAN75yyVnOhUwSCaQKCP9g0vufdIfbqWsKfhaaBmqnww9z9UmI0o6wcKvG0cJFbhXQ59nEaDNi2BbhKgkJy8XNmDPYe1hzioyYPlpmAbgQ0sxntpGMr01sMB8J5zBoIo2aP5ma0HCnIJ5hdsoHREEwlvf8e3oGRCz7+PAyQYebgk9Ezr8tzsTakCc6HmcU4KUN0heaNXSdYUyyBu53lsuursYBvtSDBOUKqh7HkSJ0uGRqGhbZ02gPnnzhdT78SZvMCchlIz41cJbEeRvjrwfoY+cQzWLIsS9E8W0kC5R+uXSAe20JTqIpXuBPblWsF41lfFA/vLOOOnF4/XBV1M93a6DCFq2S9LnhQZ54j6JfZRGBMeRkx0d3zIeNPxFa8blsXnnqCN3r+s6qI0/W0vBx27NTIwN0f3upOK+iXRiTZP+vikOCJ0xFsLPxrCr6QusbhW4R8ofJyrDiGDyoHqH00RIjXJyE0xbRP82ooIl+4LBs/1ViIaDVj4Dw2sRPc3HoKoPm8Ng0zVKtKEPt0Bx2mOccR0x1Ge5siQihfw1qd0gyj4mVPuj754osKVaSf37VY40Xf/0a6htBpCvEAEUHL9hJA
DKIM-Signature: a=rsa-sha256; bh=uDHPUbYO2xq4nR+6VPGWCOJ4NLl/Ae6aGA+FinQkPiQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1783723783; v=1;
 b=u4iBcGfZ4KNbBvk2q7WRT1aE2Jod79lgHaNpflvKuJh/QeIh34K1DA6vge95M20Vd8qPCKwZ
 /r9ieUnxHegww+KJzP1qiHfj8p0xVKEUASVu1tjHGeBi3JLLmpB+7Gfj0PCLI1bGJ5KmNaAm6xL
 d2TwtOy6CbXjicdcmu8Ut75d971qflyd5Bn4cNyEoBRtcNBapd0aH1Xr4/0MujceDi7l+zA74KV
 WrFdMW8DPLYmrfJJ9z1cuhgp3B5rF4hKnl6ADbjtgy7avpwj8k2ktTpJgVBiha/Ba7hEuJxGRl5
 v5URfdEopFODRa4nWkh9TxqkLGSGLcSylkqjh5yhGT+uQ==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

+ Harsh

On 7/11/26 00:07, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> (committed as d5ee641cfc5c3cbd51282d0c6e996f990b9d62a3)
> 
> On 4/9/23 11:06, Cédric Le Goater wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> ISA v2.07S introduced the watchpoint facility based on the DAWR0
>> and DAWRX0 SPRs. Implement this in TCG.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   target/ppc/cpu.h         |  4 +++
>>   target/ppc/helper.h      |  2 ++
>>   target/ppc/internal.h    |  1 +
>>   target/ppc/spr_common.h  |  2 ++
>>   target/ppc/cpu.c         | 59 ++++++++++++++++++++++++++++++++++++++++
>>   target/ppc/cpu_init.c    |  6 ++--
>>   target/ppc/excp_helper.c | 52 ++++++++++++++++++++++++++++++++++-
>>   target/ppc/machine.c     |  1 +
>>   target/ppc/misc_helper.c | 10 +++++++
>>   target/ppc/translate.c   | 13 +++++++++
>>   10 files changed, 147 insertions(+), 3 deletions(-)
> 
> 
>> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
>> index d9c665ce1819..62e1c15e3d33 100644
>> --- a/target/ppc/cpu.c
>> +++ b/target/ppc/cpu.c
>> @@ -128,6 +128,65 @@ void ppc_store_ciabr(CPUPPCState *env, target_ulong val)
>>       env->spr[SPR_CIABR] = val;
>>       ppc_update_ciabr(env);
>>   }
>> +
>> +void ppc_update_daw0(CPUPPCState *env)

dawr0

>> +{
>> +    CPUState *cs = env_cpu(env);
>> +    target_ulong deaw = env->spr[SPR_DAWR0] & PPC_BITMASK(0, 60);
>> +    uint32_t dawrx = env->spr[SPR_DAWRX0];
>> +    int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
>> +    bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
>> +    bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
>> +    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
>> +    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
>> +    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
> 
> Is it deliberate @sv and @pr are the same?

I think it's a typo. Should be 63. Harsh could you confirm please ?

Thanks,

C.


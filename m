Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884FECCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 06:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA00I-0008Mt-Hg; Sat, 18 Oct 2025 02:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vA00E-0008Ko-MG
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 02:01:19 -0400
Received: from 3.mo552.mail-out.ovh.net ([178.33.254.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vA00B-0000g1-DD
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 02:01:18 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.72])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4cpWJv4PrJz5yk6;
 Sat, 18 Oct 2025 06:01:03 +0000 (UTC)
Received: from kaod.org (37.59.142.104) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Sat, 18 Oct
 2025 08:01:02 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00565e1befa-6c5b-420b-89e5-7a88cc5aaf24,
 9B96CC619B315B053716FB0A713D7CBC1CAB1C25) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 86.206.43.69
Message-ID: <3c2d1838-0fc9-46e3-a6b4-382ecc4d4ff8@kaod.org>
Date: Sat, 18 Oct 2025 08:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Remove the unusable e200 CPUs
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath
 <rathc@linux.ibm.com>, <qemu-ppc@nongnu.org>
CC: <qemu-devel@nongnu.org>
References: <20251017144504.563594-1-thuth@redhat.com>
 <295be472-7778-49f7-9ede-e5ef51dd908e@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <295be472-7778-49f7-9ede-e5ef51dd908e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 785248cd-7931-4183-b274-8a0cd3bac68e
X-Ovh-Tracer-Id: 3251317456097872678
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGC1Tw1K8b4U4YVBCBDuQ3PCNt0RDO0GLuoBukLr5uyy/12FwywyDyBC5vKWngVs/EMyOZkXiQfsyLxfI7+iovozjKG1TxmCJ3rmD5vCD5DQHKBjPKtbOWMGFMjRB+V5V7KtKWmldf4znM0Wr7vCl0B5bJIHybl7uoSmauHmqpQGshSWRgvkzlELL1KRYTItnREeQCdpOVy+4j/osaX0+YY5Nt+iA6dPzE0CuvubnJU1YHQ4fvP2IuhWc9skBhWF5Q3Nntkjp950idi/w04UZmZk2Uyi+ReCvS9hPg3AvkIVM1l3fOOpwpL8gVuUzyFKGSb/dITl2ZVUicGAtFuOkwil9BuKYJ2uoXfHGet8mq2tGkkNz6eSsP4TRvrRX49u3XNMeoNwxszZNu3N61Iefkt9YbsknOpatTHknuHwukgDDEYK3YWC9F5ztpHa11R1UrzsqyZREbT2W4zmUf7JtutWXMwTOWZwB8EtBsBZnXJxtn834OhqYbPkSaX4pOkvDSpgHLnuSRJ68X6xdz5LtDS7phT3fwLudfN+x8UN4LGqTVnQIDJEiJu9zT7ansEIoGpv+vbVFHYdJ9lVe4Wrfrc6nhdhtPZecUaAocpGH1deAnqWLHmrv2k79iHXMJMlpkzIMMB/8bdQ37w2WJ5vYqRj13QcUR4vV5mPs9CC8wyCA
DKIM-Signature: a=rsa-sha256; bh=xsny/6lLS6K6kdurbhNepfs9nuA8TvvzySq9u/tEhyw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760767264; v=1;
 b=CeYl9SPIakMCpakosmLg/kz/L8t5tt7t80va3YQBWcsSZ/+BZfgSheiv3l+RH+yC4f/9ehp0
 0/BTB7R66sIcGHnB/52i+8C7IE26P1RtNJ9x+plYB75r1jzZhraVKhTqJkG18j5tRt6+O7YKu6j
 TzwoRtk3okO//JD3+HkVgCIDZG0UhPi049LnXdvAYrCOfcf8HZLQLrtgyu1QVQM9FkHJ80aqIuB
 gHpGDKG4insqPsDc2xr3pWOoYSNw+qZ+vlbqm/y1bm/903OyN3/YzICPd8lSPmry7hxOGnB/0TG
 JWz2kYgJMBaiBTAxtkEZb0YM9iZdlBvhjlZ2wv4S+ankw==
Received-SPF: pass client-ip=178.33.254.192; envelope-from=clg@kaod.org;
 helo=3.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/17/25 17:50, Harsh Prateek Bora wrote:
> 
> 
> On 10/17/25 20:15, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> There is currently no machine in QEMU (except the "none" machine)
>> that can be run with one of the e200 ppc CPUs - all machines either
>> complain about an invalid CPU type or crash QEMU immediatly.
>>
>> Looking at the history of this CPU type, it seems like it has never
>> been used in QEMU and only implemented as a placeholder (see e.g. the
>> comment about unimplemented instructions in the POWERPC_FAMILY(e200)
>> section of cpu_init.c). Being completely unused and unusable since
>> such a long time, let's just remove it now.
>>
>> Note: The init_excp_e200() is used by the e500 CPUs, too, so we
>> rename this function to init_excp_e500() instead of removing it.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   target/ppc/cpu-models.h |   4 --
>>   target/ppc/cpu-models.c |   5 --
>>   target/ppc/cpu_init.c   | 147 +---------------------------------------
>>   3 files changed, 2 insertions(+), 154 deletions(-)
>>
>> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
>> index c6cd27f390e..a439eb37ee4 100644
>> --- a/target/ppc/cpu-models.h
>> +++ b/target/ppc/cpu-models.h
>> @@ -120,10 +120,6 @@ enum {
>>   #define CPU_POWERPC_MPC5200_v12      CPU_POWERPC_G2LEgp1
>>   #define CPU_POWERPC_MPC5200B_v20     CPU_POWERPC_G2LEgp1
>>   #define CPU_POWERPC_MPC5200B_v21     CPU_POWERPC_G2LEgp1
>> -    /* e200 family */
>> -    /* e200 cores */
>> -    CPU_POWERPC_e200z5             = 0x81000000,
>> -    CPU_POWERPC_e200z6             = 0x81120000,
>>       /* e300 family */
>>       /* e300 cores */
>>       CPU_POWERPC_e300c1             = 0x00830010,
>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>> index 89ae763c7f6..26b6debcfc9 100644
>> --- a/target/ppc/cpu-models.c
>> +++ b/target/ppc/cpu-models.c
>> @@ -244,11 +244,6 @@
>>                       CPU_POWERPC_MPC5200B_v20, POWERPC_SVR_5200B_v20, G2LE)
>>       POWERPC_DEF_SVR("mpc5200b_v21", "MPC5200B v2.1",
>>                       CPU_POWERPC_MPC5200B_v21, POWERPC_SVR_5200B_v21, G2LE)
>> -    /* e200 family                                                           */
>> -    POWERPC_DEF("e200z5",        CPU_POWERPC_e200z5,                 e200,
>> -                "PowerPC e200z5 core")
>> -    POWERPC_DEF("e200z6",        CPU_POWERPC_e200z6,                 e200,
>> -                "PowerPC e200z6 core")
> 
> While I hope removal of e200 should be fine, I am thinking if we want to
> deprecate it in this cycle and remove it in next ?

Since it was never usable (I don't remember of any tests for these
CPUs), I agree with Thomas to bypass the deprecation process.



Thanks,

C.



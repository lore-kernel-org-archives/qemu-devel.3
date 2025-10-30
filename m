Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96749CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 11:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEQXa-0007cZ-Hw; Thu, 30 Oct 2025 07:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEQXY-0007cA-CE
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 07:10:00 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEQXS-00036n-UT
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 07:10:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9A4515972EB;
 Thu, 30 Oct 2025 12:09:46 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id s0gyV_w2Ppyp; Thu, 30 Oct 2025 12:09:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 42DE25972E4; Thu, 30 Oct 2025 12:09:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 40E095972E3;
 Thu, 30 Oct 2025 12:09:44 +0100 (CET)
Date: Thu, 30 Oct 2025 12:09:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: Shivang Upadhyay <shivangu@linux.ibm.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 peter.maydell@linaro.org, adityag@linux.ibm.com, qemu-devel@nongnu.org, 
 sourabhjain@linux.ibm.com
Subject: Re: [PATCH v2 1/2] hw/ppc: Fix missing return on allocation
 failure
In-Reply-To: <47ac6382-3270-4179-8455-43cee36a9ca9@linux.ibm.com>
Message-ID: <c089e14f-69a3-fe9c-cc80-b0c7bba4105a@eik.bme.hu>
References: <20251028080551.92722-1-shivangu@linux.ibm.com>
 <20251028080551.92722-2-shivangu@linux.ibm.com>
 <8d5a8cce-d769-4cd8-9753-7e9ad37d8a47@linaro.org>
 <dio77m3m5jj6ccgqpswkifiqztf5fz45qsjpspu2yszgwrfgha@mcwjruxszkn5>
 <47ac6382-3270-4179-8455-43cee36a9ca9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1427477736-1761822584=:43010"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1427477736-1761822584=:43010
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 30 Oct 2025, Harsh Prateek Bora wrote:
> On 10/28/25 15:54, Shivang Upadhyay wrote:
>> On Tue, Oct 28, 2025 at 09:35:40AM +0100, Philippe Mathieu-Daudé wrote:
>>> On 28/10/25 09:05, Shivang Upadhyay wrote:
>>>> Fixes coverity (CID 1642026)
>>>> 
>>>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>>>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>> Link: 
>>>> https://lore.kernel.org/qemu-devel/CAFEAcA-SPmsnU1wzsWxBcFC=ZM_DDhPEg1N4iX9Q4bL1xOnwBg@mail.gmail.com/
>>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>>> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
>>>> ---
>>>>    hw/ppc/spapr_fadump.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>> 
>>>> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
>>>> index fa3aeac94c..883a60cdcf 100644
>>>> --- a/hw/ppc/spapr_fadump.c
>>>> +++ b/hw/ppc/spapr_fadump.c
>>>> @@ -234,6 +234,7 @@ static bool do_preserve_region(FadumpSection *region)
>>>>            qemu_log_mask(LOG_GUEST_ERROR,
>>> 
>>> FWIW host heap exhaustion is not really a *guest* error, because the
>>> guest can not control it.
>> Hi, Philippe
>> 
>> 
>> Thanks for the review. There are following log level defined in log.h
>>
>> 	....
>>
>> 	#define CPU_LOG_TB_OUT_ASM (1u << 0)
>> 	#define CPU_LOG_TB_IN_ASM  (1u << 1)
>> 	#define CPU_LOG_TB_OP      (1u << 2)
>> 	#define CPU_LOG_TB_OP_OPT  (1u << 3)
>> 	#define CPU_LOG_INT        (1u << 4)
>> 	#define CPU_LOG_EXEC       (1u << 5)
>> 	#define CPU_LOG_PCALL      (1u << 6)
>> 	#define CPU_LOG_TB_CPU     (1u << 8)
>> 	#define CPU_LOG_RESET      (1u << 9)
>> 	#define LOG_UNIMP          (1u << 10)
>> 	#define LOG_GUEST_ERROR    (1u << 11)
>> 	#define CPU_LOG_MMU        (1u << 12)
>> 	#define CPU_LOG_TB_NOCHAIN (1u << 13)
>> 	#define CPU_LOG_PAGE       (1u << 14)
>> 	/* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
>> 	#define CPU_LOG_TB_OP_IND  (1u << 16)
>> 	#define CPU_LOG_TB_FPU     (1u << 17)
>> 	#define CPU_LOG_PLUGIN     (1u << 18)
>> 	/* LOG_STRACE is used for user-mode strace logging. */
>> 	#define LOG_STRACE         (1u << 19)
>> 	#define LOG_PER_THREAD     (1u << 20)
>> 	#define CPU_LOG_TB_VPU     (1u << 21)
>> 	#define LOG_TB_OP_PLUGIN   (1u << 22)
>> 	#define LOG_INVALID_MEM    (1u << 23)
>>
>> 	....
>> 
>> Which one do you recommend we use? or May we introduce a `LOG_HOST_ERROR`,
>> if that's more appropriate.
>
> I think it would be better to have LOG_INSUFF_MEM for this case, but let's 
> hear from Philippe and others for suggestions.

If it's not a guest error but an error in QEMU then maybe error_report (or 
warn_report if it's recoverable)?

Regards,
BALATON Zoltan

> Since it's unlreated to the coverity fix and can be taken separately, so:
>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
>> 
>> Thanks
>> ~Shivang.
>>>
>>>>                "FADump: Failed allocating memory (size: %zu) for copying"
>>>>                " reserved memory regions\n", FADUMP_CHUNK_SIZE);
>>>> +        return false;
>>>>        }
>>>>        num_chunks = ceil((src_len * 1.0f) / FADUMP_CHUNK_SIZE);
>>> 
>
>
--3866299591-1427477736-1761822584=:43010--


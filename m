Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4469FC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh269-0004vJ-Ld; Tue, 07 Jul 2026 05:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh267-0004tC-Rs
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:28:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh266-0006Fe-Cv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:28:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678EBur3231398
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kIjgJXGmQ4n6AbWq2OH31U2Cynm3Ogdoi0tvSJxpsHw=; b=f8TlnYNtq2noHlz+
 owN2aLCyfJR/lrbqS8jf4AuYtucaNFbUQVWaHS7hwM29CbFNpBJv4AM0R179zJiy
 7CKOnsZgLT1nlNrWSbnuEiaRFB1nfcvXAJMt9A51Ru5A3bM2yvtt7CFtRME0rjej
 ytd2OCvzT5huvCzHt+bA+G4nSmOQPnIBVbJA5+nUXfqRCJqMdYJx9vCTF1Ay1XDs
 WtTzd+7pCKUhO2wH2TN0fB6M5lKriGyya9dLJYd3zJZdu3faucGSZziCTs+CFcEo
 c+8HHbqCc8zpVlOdBtz6PPC1HEPA+Bu/SGO8yTpV2FTij1A1ZCCn4kudEMpzaQ9f
 vAPiHA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj79qnr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:28:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso81570831cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783416488; x=1784021288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kIjgJXGmQ4n6AbWq2OH31U2Cynm3Ogdoi0tvSJxpsHw=;
 b=YT49ZqQ8nQ3pnZk49tK3QNkvinv3ZB8+E/bNSTtXwW4pX4gIvCCqTdpFUF2Z+cWRgl
 xExF7JESjWpT7Hv6DJN5uO5anA65W03jiBr7YzN32Mo8mFWPELHnceLKrybRJtkhVjgn
 jijCnPfRcgpdFRiprftEpnR3iTlZh0jADHR1WVnEqiS4gCXgjB2YoyjTM1uDqZeTYmgy
 6qqty2rK4lJrhlUgkW1qmSAcLcO7VFdgSXM754rUAWyP48vtkQrKiD2GOVQdDUbdClXL
 il1H9JWF8aP+ZEDtywjapv0+0swRSKnuBwuRemQU4yw/7K9HLHobTRIqRJy9v4NpS70k
 ppLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783416488; x=1784021288;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kIjgJXGmQ4n6AbWq2OH31U2Cynm3Ogdoi0tvSJxpsHw=;
 b=VFuWX4AdV458X7BzCuJwmspwmCK1qL3T9xZG1YA/bzalOoAhJxuZcuaPpIqzQbJNqd
 sg1KvaEOD0vlwlbXQwzWIaaThz0JLZgI5h2/7q+0EODRUbRyAB5OYVybgIJ/W60arYFu
 onVmSaDV7APDec2J78ihh/XHOg5kNxqy2o3iCBzKxRX1koRcEKWUAWZrjFfW+DFpeCwi
 f6QvMfxaNbKNbksi1vCKO2WCs9jhdBqJjtMS2WoG7GSODsbNDX1aAgIUAfihHg2JFgsQ
 Soy32yPEWIvDPNjvsiykB/GVkCJ2sKFe9QDQLTX7Zh/gTb72dkYg0nqfJYleNmUlr4Ks
 gexQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9YqKxoUAzlwpfq4DXq8XpgLZCnNap+LhtNSxlW0x+1BplZM9g4IUb9nnwEQAYaoR8VCHMYaKlDbrs@nongnu.org
X-Gm-Message-State: AOJu0YxIhsrvo8Xyyxj7TTAiAGVh/LBPB7QfvqWlj9YxeSB1OUUSMr9h
 n15gDVrLNrxJjS9cSzGKClc6gg8mO01Wdxmm9FUcru8aTvhebmnf7GVPKSo+KMrZ45ggvhoSmBl
 JXil4wlPI8XlMz9p1kZcTzpMaQw3YBxODf2tPD0RLWeb3fa3jtLrlqyB0SA==
X-Gm-Gg: AfdE7ckREb/o1hoRU4tu2F6ecnVLx5AHXvT36JyT3bCmLfVu5DP+owp/5Zi5yjKavNK
 i/0ubFo6R+r72RdBVU4c/JazQXyFIkpONJ1S6yenzNKJF4vbGGjxMYeeXj6QeTPuJB7CP/4rfIx
 E+euTwti4p9tP3GRgMxHPc1Kb6IVJYsB+p1dCp3cmJQgfxmTu5i3gYONz4NKADmGoWrJMXmkj+b
 MFYTmjcVzeZ/8x3sXdxdR0BLJ+zqPKwffQTIpD6KVGCD/tUFiVHkQjiATwLnYfxvM3IElFP/UuG
 SlSs/tucUumNucvJqDxjet2tUXWO7oqBjMBtwk29xpZov/NW+i08blnw02wKWrsgogL8lQnNbH2
 DtqaoaiL9XaEu1ZRZBwRfhE6uKFDscYfuccFBS1f4hntLpWetPRglukqVh9A+uw==
X-Received: by 2002:ac8:59c8:0:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-51c747ae893mr44334531cf.1.1783416488361; 
 Tue, 07 Jul 2026 02:28:08 -0700 (PDT)
X-Received: by 2002:ac8:59c8:0:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-51c747ae893mr44334361cf.1.1783416488016; 
 Tue, 07 Jul 2026 02:28:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada023cesm90929866b.44.2026.07.07.02.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:28:07 -0700 (PDT)
Message-ID: <f4570b7e-7f33-4e79-b4e3-1de40c41ce91@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] hw/arm/aspeed: Use Aspeed2700SCUState for AST2700
 users
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707060919.350637-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6aJaesYpGbkpYNphw_LsGHNSidgWn8F7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5MSBTYWx0ZWRfX5WauDD0cNub0
 FsUqiNf52Wr7/8BHIoolDAEFDUVdZpOCg0/vPjd/NOBoeDKREmnHHRGPaXamPY9ANHjvgRzqhBk
 YBkmIgXYh2eabiSe7Hea5iFJOKFic+QkWvdQ+cSbjtO31sgLZkEIwgqOxwR59tmN8tZNkvM2W5r
 WWOp7NomnKlW1oWSL0nm7g8ms5F8chDDVHior4GdKq+sThuApurEfgZvT/h37dNUNEkCQvXVAys
 C5iM6L9ceWGpiEf+YmE/7tUZDO0Sfp6B9/7AjdzY0c9h+BVEX/+dtaKIkp1vQFKxF6tm+H2SSzz
 9CaTJW2NBydoVuDruNCH4p4Lk2BksvTX7rmOXrDW4eyn+y5xQfoBWONn+yFejWNCOnJEF6+mltR
 HGcX3eNdV8VGhEOFVGAYWV4D+Yg2ACZLNPfHNbyVL7vDxnhfe/CIH0xBkd+ywv3Yt5UCo75IQyA
 wJRP83SSKQwPYhpzZ7A==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4cc6a9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5MSBTYWx0ZWRfX2dinR6o3N1cL
 82uYRG9WmJozhZAhtiaLNAFlhz+ZzaB9nV7eoAR3HwpsKIW4GgHE6HavFZQ0qD+xEeBeVDIFjwQ
 oMy770QXIDTY5JZGmXClUphc9DjZXRw=
X-Proofpoint-GUID: 6aJaesYpGbkpYNphw_LsGHNSidgWn8F7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070091
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/7/26 08:09, Jamin Lin wrote:
> Now that Aspeed2700SCUState has been introduced, update the AST1700 and
> AST27x0 SoCs to instantiate the AST2700-specific SCU subclass instead of
> the generic AspeedSCUState.
> 
> Also update the AST27x0 FC board to link the SSP/TSP coprocessors to the
> AST2700 SCU instance.
> 
> This prepares the AST2700 platform for subsequent patches that move
> AST2700-specific SCU functionality into the subclass.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_ast1700.h |  2 +-
>   include/hw/arm/aspeed_soc.h     |  1 +
>   hw/arm/aspeed_ast27x0-fc.c      |  4 ++--
>   hw/arm/aspeed_ast27x0.c         | 16 ++++++++--------
>   4 files changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D23C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLAm-0005Uh-3x; Thu, 02 Jul 2026 13:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wfLAg-0005U6-Ee; Thu, 02 Jul 2026 13:25:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wfLAe-0006tq-Ly; Thu, 02 Jul 2026 13:25:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662EIHAq4014030; Thu, 2 Jul 2026 17:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5CPG/L
 LjoLUGz2mxt0J77jL/VRW04N3mJHyTiu/RUlQ=; b=CppUH8THkMCuN+f1HCLqoK
 yv6ilFpIYMJjSMLnyN4jiM7iDR9+YPOHnD+dsOcRr8dnMaAXVE/4X+XM920x9BLj
 EHjJwKlSPKqsaT9+jXxreadqZM81snCcc71lhGdxTpmeh9LxT8TwykBtfTzbyQOp
 ax4LbdWdkhFBtyiFTSCVOSe+T//w07K+lRIXQqODNljWsuMUIWP57tLf4WYS//rC
 K0c/0W6d709iQHZeGfte1PktRqoYM74oNZAdgTRbc4dyLrbB3TSDKvN88e/8UFUR
 K/IjAC2qeK+WCvF3CeXjpRVCYKkTvTro1GoEnwSnOV8pf/4KBexBGIFntbO10c2A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rfantw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 17:25:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662HJeWR017401;
 Thu, 2 Jul 2026 17:25:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhmywu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 17:25:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662HPjEP29950472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 17:25:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A03958050;
 Thu,  2 Jul 2026 17:25:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 592D158045;
 Thu,  2 Jul 2026 17:25:43 +0000 (GMT)
Received: from [9.61.18.137] (unknown [9.61.18.137])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 17:25:43 +0000 (GMT)
Message-ID: <342ba1eb-7545-4c16-af3f-73f1dbb363f6@linux.ibm.com>
Date: Thu, 2 Jul 2026 13:25:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 32/35] s390x/ipl: re-apply secure boot flags on DIAG
 308 reboot
To: Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-33-zycai@linux.ibm.com>
 <7a9aead0-32ed-4672-8526-bbaf6a96901c@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <7a9aead0-32ed-4672-8526-bbaf6a96901c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a469f1b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Twaj4APWrUy_8NTiV2sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: M0PZy1Wjak6W3kf2WxD_LYRm54FgrH7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE4MiBTYWx0ZWRfX9RgZ2tGN2bKK
 ZgWePuVZ9pB7JqVAsS1rHfxCdy6HcUf7Xk+/QtOHUweIAPBnUSiYE/fn+uy8TIibm/I5H+H3ryL
 zlkOjzVTvB8UY6vT3X1taUStPPKCJwNZC23766p42y15l8IbIjeugTOkzo3CE3km/hPbS6YX/hg
 1jxnfXAgAevPIfDqvHb8KMj42tlRmZF12loAeBLaA4mhvR+0n4ab5poKtA0j964UTFPjvUeoV+X
 wJn/ZeeHBma5MYgyJ59YkuTIspY2gSR9IHF6vXlg6eoEDht+e2uUKeRuQAvnV+IT7INRHW9BUVd
 7gGZH0MZ7F7aEZxAiUteX8dLM2vUwx1c8FuXTOpAb0F2cDL4RiQKpzQKaxaTT+WObt67yR/8UTb
 BVqAcp96g1tU9fiZLY1HKhN7xn2MP4aPBvPRSaC5Go+lkdZYYbeA9pmmRmxpFDCsZPDFN14DpM2
 IawTDFtoJImQIAoFjbg==
X-Proofpoint-GUID: M0PZy1Wjak6W3kf2WxD_LYRm54FgrH7G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE4MiBTYWx0ZWRfXxJFz2IlXhNRN
 Uiszuk3TwJiesHmDg366nU8+987PEFTdXv0g0ru1gg5qpHrfaXG93YeWsBKtlYvfstVpHCzULpe
 XJDY4N12aoUUllJixbBHnTufXRgXPfE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020182
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jjherne@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 7/1/26 11:47 PM, Jared Rossi wrote:
> 
> 
> On 7/1/26 4:49 PM, Zhuoying Cai wrote:
>> The Linux kernel does not preserve hdr_flags in the IPLB across a
>> reboot, causing secure IPL flags to be lost on re-IPL.
>>
>> Set secure IPL flasg from s390_ipl_update_diag308() to restore the
> s/flasg/flags
> 
>> flags from the current machine configuration.  Device validation is
>> skipped here as it was already enforced during initial boot.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   hw/s390x/ipl.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index f4e01b6918..f970b34126 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -737,6 +737,14 @@ void s390_ipl_update_diag308(IplParameterBlock 
>> *iplb)
>>       } else {
>>           ipl->iplb = *iplb;
>>           ipl->iplb_valid = true;
>> +
>> +        /*
>> +         * The kernel does not preserve secure boot flags across a 
>> reboot.
>> +         * Re-apply them here based on the current machine 
>> configuration.
>> +         */
>> +        s390_set_secure_boot_flags(&ipl->iplb,
>> +                                   s390_secure_boot_enabled(),
>> +                                   s390_has_certificate());
>>       }
>>       update_machine_ipl_properties(iplb);
> Can this be included with the initial implementation of true secure IPL, 
> or maybe even earlier with audit?  I can't imagine any scenario where 
> secure IPL is intended to be cleared on reboot, so adding this as a 
> later feature doesn't seem to make sense.

I agree, this should be folded into an earlier patch, wherever it makes 
most sense. Unless I am missing something? Everything else here lgtm. If 
there is some reason this needs to stay separate, I'd provide my Rb.






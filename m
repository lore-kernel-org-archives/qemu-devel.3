Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430BBFD4F23
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 19:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w02WC-000235-7n; Tue, 10 Mar 2026 15:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w02W7-00022n-4g; Tue, 10 Mar 2026 15:13:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w02W4-0001w6-Rd; Tue, 10 Mar 2026 15:13:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A8JGjt1997845; Tue, 10 Mar 2026 19:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BKW4yD
 WAu6s7BlIXDGTWUV2Lvizie71pryUFhaK+bn0=; b=CN65JwLH9sUqDt15aR/Dsw
 73/4DZTxlkqBCgNVgGdCtdEiu47muc9iV/JQxb+/R8uAoRKanU0NE6LtOT9xQkdr
 PbzrjuJovCMGdq71hFx9z9w1XPyY56FCZzifBMTsEBlTAMhw30/6wudbD+jaUeQp
 W3JRPn7fjlqWUYLfsbEuAdhfd8ylE9WLVDV8SE/IQrmOQdBpgE9tld0Umnm+k14r
 svd1/dOnErdRiwAvFxc698pUSGc36LbI1NSlSNnKwB+nV5k+u5P7IUNzmM45Etnc
 SdqRoAE2liAyEQUkBmFkPiYIbLlUa1UsoqUuwANS9WZY/kX3n29eUbWJGxv3hx5A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmcjtk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 19:13:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AGi1WQ024657;
 Tue, 10 Mar 2026 19:13:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk2anv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 19:13:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AJCuOx56230260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 19:12:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DE192004E;
 Tue, 10 Mar 2026 19:12:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F5162004D;
 Tue, 10 Mar 2026 19:12:51 +0000 (GMT)
Received: from [9.39.23.69] (unknown [9.39.23.69])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 19:12:51 +0000 (GMT)
Message-ID: <04f8baa5-f9ea-4355-9d0d-ed24b5d081b0@linux.ibm.com>
Date: Wed, 11 Mar 2026 00:42:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/core/loader: fix error handling for
 load_image_targphys callers
From: Aditya Gupta <adityag@linux.ibm.com>
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20260310182801.196443-1-viking4@gmail.com>
 <20260310182801.196443-2-viking4@gmail.com>
 <9a658ec5-a167-4d0a-a08b-50ea90c40be0@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <9a658ec5-a167-4d0a-a08b-50ea90c40be0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Nuc_FYRaUnqo3lV57dOhG6n4W2wvjZRW
X-Proofpoint-ORIG-GUID: 2s-l-MuMjW0Aq50xfAihxCB-Rw19fu0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE2NiBTYWx0ZWRfX/d0SMBKFRXjK
 reGhSm3mzDZD3G/Xw+RM2Ze8Lp/TgP9EqpejwTpxGZqdw7oUPnzuGEMe6qgc34w+BYQM5ixsMJw
 uoAkRBX/b8SdQRgE9hLHl0BXLbG+VQSWVx6OLdU+R/C/uc19GElS6d0AB0n0ezz+xfB36fPUnu8
 TVjKh+uM0QwTQmIMAwmONUWrDMzg1q0PBNKecYBT2wja8BgPh0xYQ0krUBSecy9V4zXiEm0oX+V
 Vx2p1ptcR4NmAAyHBfRHUPhbnOQdiDTvfgf4XlIvK3gelC0YEIEpy3MVpvOfu+8JkvOiJSbSfl3
 7eKSL3rNUWZvyDxV8XedqE0q+dQjiKXkyc7z+SjNI/tIU7vNMadpJ1tojNAUg+Wo6v7w+U9GTh5
 Pl9+R1JT1dxbjjKKZ6pBWh9ZtGmEulFn8pKx22M+kqLHK8GCRLwt/QT3I0oP0g+kFxX1HipSMOQ
 n2H65m/fX+LQsi3Unmw==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b06d3d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=jZHwgfVtUnBscKycHLwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 11/03/26 00:32, Aditya Gupta wrote:
>
> On 10/03/26 23:57, Trieu Huynh wrote:
>> From: Trieu Huynh <vikingtc4@gmail.com>
>>
>> Check return value of load_image_targphys() and return early on
>> failure instead of continuing with invalid state.
>> - Use ret < 0 to handle negative return value.
>> - No functional changes.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
>> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
>>
>> <...snip...>
>>   diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 1513575b8f..aecffb211b 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1068,14 +1068,21 @@ static void pnv_init(MachineState *machine)
>>           exit(1);
>>       }
>>   -    load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
>> -                        &error_fatal);
>> +    if (load_image_targphys(fw_filename, pnv->fw_load_addr, 
>> FW_MAX_SIZE,
>> +                        &error_fatal) < 0) {
>> +        error_report("Could not load OPAL firmware '%s'", fw_filename);
>> +        exit(1);
>> +    }
>>       g_free(fw_filename);
>>         /* load kernel */
>>       if (machine->kernel_filename) {
>> -        load_image_targphys(machine->kernel_filename,
>> -                            KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE, 
>> &error_fatal);
>> +        if (load_image_targphys(machine->kernel_filename,
>> +                        KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE, 
>> &error_fatal) < 0) {
>> +            error_report("Could not load kernel '%s'",
>> +                         machine->kernel_filename);
>> +            exit(1);
>> +        }
>>       }
>>         /* load initrd */
>> @@ -1084,6 +1091,11 @@ static void pnv_init(MachineState *machine)
>>           pnv->initrd_size = 
>> load_image_targphys(machine->initrd_filename,
>> pnv->initrd_base,
>> INITRD_MAX_SIZE, &error_fatal);
>> +        if (pnv->initrd_size < 0) {
>> +            error_report("Could not load initrd '%s'",
>> +                         machine->initrd_filename);
>> +            exit(1);
>> +        }
>>       }
>>         /* load dtb if passed */
>>
>
> Thanks for the patch, but as balaton said, atleast in this case, the 
> condition is not needed since it's have error_fatal.
>
> Previously the if checks you added used to there, these were recently 
> changed to not have the conditions,
> by this patch from vishal:
>
>     commit cd274e83d50ba52ede62d2a8ea0f0ae7cb1ef469
>     Author: Vishal Chourasia <vishalc@linux.ibm.com>
>     Date:   Fri Oct 24 18:36:03 2025 +0530
>
>     hw/ppc: Pass error_fatal to load_image_targphys()
>
>     Pass error_fatal to load_image_targphys() calls in ppc machine 
> initialization
>     to capture detailed error information when loading firmware, kernel,
>     and initrd images.


To add to this, it might be better to pass an error object to 
load_image_targphys, or error_fatal
if we are exiting in the if condition. That gives more details for why 
the load failed.

The NULL arguments were added in this: 
https://lore.kernel.org/qemu-devel/20251024130556.1942835-6-vishalc@linux.ibm.com/

That was because it was intended to not affect other machines, and hence 
it stayed with default
behavior of ignoring return value of load_image_targphys

This can be changed to use similar to PPC's approach to use error_fatal, 
if that's intended.



Thanks,
- Aditya G



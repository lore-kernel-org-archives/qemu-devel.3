Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6557FFD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzziu-0007K8-M2; Tue, 10 Mar 2026 12:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzzij-0007J9-O5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:14:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzzih-0006mk-7a
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:14:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AAI3Oh1765534; Tue, 10 Mar 2026 16:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kZ1rQI
 q/EN1YP9LR3vI7dv1PmGAaCiGt+AheCOMt9qc=; b=VPhV+1NXLu1O3CHfjBpj0t
 /lwWEbUp5D5aH4rG2HIgVOLGifn+RJiZC6KoC4uzV1SxuiW13dRJW/gUkScl56aD
 H8FeAX5ZmBDI/6fqoZsZIxYwhlUVgeySloqSXY1dyBVgqzohj3AqVkzwzQu544kX
 +QchI8H+Jm94hftX7M9BTdctYLwULjovkNiZwJPlq2S1dRXxIolSQ5Xi5HyDOrpt
 y828IaZ5Q4KRIz8tMl5LdpkzQqopYeOrrbsKHTylQFviKEk8FR2GwNg0aCzpMFag
 V2l8Fqkb1UV5UqPRQBulJNBEEEOtyNjC2SC/WWxCfYKA2Q0bYtZAB8vH60ja1wqg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunbd8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 16:14:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AFKKdd029625;
 Tue, 10 Mar 2026 16:14:01 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6upek4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 16:14:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AGE0bS29164078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 16:14:00 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D7D258061;
 Tue, 10 Mar 2026 16:14:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 679165803F;
 Tue, 10 Mar 2026 16:13:59 +0000 (GMT)
Received: from [9.39.22.172] (unknown [9.39.22.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 16:13:59 +0000 (GMT)
Message-ID: <1389084e-3ed8-4a5c-aac5-bfee420b0916@linux.ibm.com>
Date: Tue, 10 Mar 2026 21:43:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] PPC PR for 11.0 soft-freeze
Content-Language: en-GB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, adityag@linux.ibm.com
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
 <CAFEAcA9FjtvJanmbvpAXMjY0zURZch9PruHUsXEXOtPiVJgarg@mail.gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CAFEAcA9FjtvJanmbvpAXMjY0zURZch9PruHUsXEXOtPiVJgarg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RtwVOYLF22pwbl5G05XN0qKncj3WmYJp
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b0434a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=Ntdz4ZrCjYjt58_MNA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzOSBTYWx0ZWRfXzHOmaJawiPGh
 jcFqbjPS2R2nRDBVe6n3ibsAyDCvLA7J/tDe8mmoXPDHMtDb9RFUZ+zct4lrj4Laj92bw32btY3
 vNFv0HsMguiyHcyu9Y7/ijCkLv7Kbd5VWpnRR0N7niH0hV1tYnlsFswgt99FU23ETzwSMDDptuY
 RPCpZMqzWqtAhiu+fpGUMyB1A6AQge8XYuuXM4U6EZiDxEoLvu1GB3wqLXuoE3Huq1Bj9f9+UC3
 jZHFIV2BQgUCInLlt1GXin6i7n2UXeled3iW9Jy9RXBw+KesKolmhtg0WO71UcdrGeAHwR8QL/M
 nN7Q58Cl3td5l4UifOEyLr+Bs8tVX+CjnXU4BblXFN73+c6Qu80gS0UFuRUW/ibQpayCgvF3nDK
 t5b2kuHReEQanmhUrZHTdM+ZNWi6MerAn/rpZl9x7YIY+vz6dVcA9jP5reNZTMXYVyMR2z5YBN1
 rP2xX10A5SHFD0S82Wg==
X-Proofpoint-ORIG-GUID: RtwVOYLF22pwbl5G05XN0qKncj3WmYJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100139
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

+ Aditya

Hi Peter,

Is there a way to trigger aarch64-macos-build and x64-freebsd-14-build 
from Qemu gitlab CI? I had run the CI pipeline with below job and I do 
not see those tests getting listed/executed:

https://gitlab.com/harshpb/qemu/-/pipelines/2375854439


Aditya,
Could you please take a look at below listed CI failures and address it?

Thanks
Harsh

On 10/03/26 9:23 pm, Peter Maydell wrote:
> On Tue, 10 Mar 2026 at 15:15, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>
>> The following changes since commit ae56950eac7b61b1abf42003329ee0f3ce111711:
>>
>>    Merge tag 'firmware-20260310-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-03-10 13:32:30 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.0-softfreeze-20260310
>>
>> for you to fetch changes up to 8d00b61217814fa6809768b8d2ca13167ad4106a:
>>
>>    MAINTAINERS: Add entry for MPIPL (PowerNV) (2026-03-10 20:23:46 +0530)
>>
>> ----------------------------------------------------------------
>> PPC PR for 11.0 soft-freeze
>>
>> - MPIPL support for PowerNV
>>
> 
> Hi; this has build failures:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/13431423411
> 
> ../hw/ppc/pnv_sbe.c:279:29: error: format specifies type 'unsigned
> long long' but the argument has type 'ram_addr_t' (aka 'unsigned
> long') [-Werror,-Wformat]
>    277 | qemu_log_mask(LOG_GUEST_ERROR,
>        | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    278 | "SBE: skiboot_base 0x%" PRIx64 " exceeds RAM size 0x%" PRIx64 "\n",
>        | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    279 | mbox_val, machine->ram_size);
>        | ~~~~~~~~~~^~~~~~~~~~~~~~~~~~
> 
> You need to use RAM_ADDR_FMT for printing ram_addr_t values.
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/13431423381
> 
> In file included from ../hw/ppc/pnv_lpc.c:28:
> In file included from /tmp/cirrus-ci-build/include/hw/ppc/pnv.h:28:
> /tmp/cirrus-ci-build/include/hw/ppc/pnv_mpipl.h:54:9: error:
> '__packed' macro redefined [-Werror,-Wmacro-redefined]
>    54 | #define __packed __attribute__((packed))
>       | ^
> /usr/include/sys/cdefs.h:217:9: note: previous definition is here
>   217 | #define __packed __attribute__((__packed__))
>       | ^
> 1 error generated.
> 
> This header shouldn't be defining its own private macro
> for the packed attribute -- use QEMU_PACKED.
> 
> Not a compile error, but I just noticed:
> 
> This header should not include osdep.h. The rule is:
>   * all .c files include osdep.h first
>   * no .h file includes osdep.h
> 
> Also, the fadump test failed on the functional-system-centos
> CI job:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/13431423958
> 
> AssertionError: 'b'fadump: Reserved '' found in console, expected
> 'b'fadump: Firmware-assisted dump is active''
> 
> thanks
> -- PMM



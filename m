Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD5DFD7F8D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvusn-0006F2-8n; Fri, 27 Feb 2026 05:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vvusY-0006D8-4M; Fri, 27 Feb 2026 05:15:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vvusV-0000py-Ol; Fri, 27 Feb 2026 05:15:25 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61R3Jp4L2771372; Fri, 27 Feb 2026 10:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JAJ3Ad
 tFOyFt5e/6ZsJpSvzWjP8lN323hsjqNpqxypw=; b=dQ27Rzn20npKfDKooO1YSL
 b0QHoDTU5gUOXa2kIfILNpi+7FkXnHOpJgzZNp27x92VmL8fYzeEqeUUD8zHBUtT
 6JQ9EqF43R/kOdphgTCXpAwYqODc79rJ2jEFrIYWkO/InDBhQHJmkXhyAYUBJwpt
 A0vc6luf4yR18xjdTVOWIdW7vx1Tz1M3XR+jLp3GsD0LNJWLolEr8i3P+KMA6bMl
 l6FyastrbFD3cX8gmQLqItTGALmPtu236TGWla1OmDfKf1kYjTHImJyoMg+9H/3n
 Hh3Tuq05ynVhZKWSqf+QeIzuBpn9JQdNPPT4TjtCLn1Lf1B1bOnB+F6AXgZ3dEYw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34ck6dn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 10:15:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R8hJGc027812;
 Fri, 27 Feb 2026 10:15:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr29c4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 10:15:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61RAFFhr24248672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Feb 2026 10:15:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FB222004D;
 Fri, 27 Feb 2026 10:15:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D88D2004B;
 Fri, 27 Feb 2026 10:15:13 +0000 (GMT)
Received: from [9.39.31.246] (unknown [9.39.31.246])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Feb 2026 10:15:13 +0000 (GMT)
Message-ID: <48b13f0b-bb53-4316-923d-77a20ffdfab1@linux.ibm.com>
Date: Fri, 27 Feb 2026 15:43:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
 <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
Content-Language: en-US
From: shivang upadhyay <shivangu@linux.ibm.com>
In-Reply-To: <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NyBTYWx0ZWRfXzdIcFCSLR4HI
 NgAxTT71FVV3/rKfIILybGAcVFhB2lSum2xsqzZVgQQ08SXRpuyujGRNZa03BjRxcc04sqwjK1d
 gPglRMCtq6elFokpABDk++0T365liQjRYfoOy8dHtFAHHlJKNSAVoPaqgjnGfHV7E+K35HSMoM0
 vhH/5ou8gRMCiqpk2g369FaSqaZ3zJc9nh4KTdD+u7NpsBgPTBK4aP0VFfthZGVR6YvUtocILx8
 K16Q56AjHJJ0yunjb6g+/7xl3dRL9FAMAKr5dboL+yx1lRt+JH3pllpIxTLtRk4hF1VWFk5el7j
 GaR69ew/sSFip27NyD6l4XQoSaZ2jXR8llw+UFUWgpDR81DxqXUuo55kTlfUEdM/zStak6VWZB0
 RwVi5TeuDk2P4HqLlmRp9duXmiEyWV/2K+qqYfoIMcvzbcEsdlMOueiaVuWqz+eAOZhJQBEF/wr
 SRYnpT0FQDOSYYK/2lw==
X-Proofpoint-ORIG-GUID: jaG-qSmz79qfyjD3p5jFgSbZYv_TkSkw
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69a16eb8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=5IPcWWnK-39Dvqt5HgUA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: kXJA30xBFDSrVUhuYqabO5qnU0iBnxI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602270087
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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

Hi Peter,

Thanks for review.

On 2/26/26 3:28 PM, Peter Maydell wrote:
> On Wed, 25 Feb 2026 at 08:11, Shivang Upadhyay <shivangu@linux.ibm.com> wrote:
>> The '-machine dumpdtb' command line option stopped working on
>> PowerPC/pnv systems after recent design change [1].
>>
>> Fixing this by generating fdt blob in `pnv_init`.
>>
>> [1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/
>>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Thanks for catching this. I would suggest having
>
> Cc: qemu-stable@nongnu.org
> Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine dumpdtb option")

Ack. Will add this.

>> ---
>>   hw/ppc/pnv.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 1513575b8f..9861714ad5 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -1261,6 +1261,10 @@ static void pnv_init(MachineState *machine)
>>       if (pmc->i2c_init) {
>>           pmc->i2c_init(pnv);
>>       }
>> +
>> +    if (!machine->fdt) {
>> +        machine->fdt = pnv_dt_create(machine);
>> +    }
> So we now set the machine->fdt in pnv_init() (which is
> the right place: the centralized dumpdtb handling assumes
> the DTB is set after machine creation but before reset).
>
> That means that this code in pnv_reset():
>
>      if (machine->fdt) {
>          fdt = machine->fdt;
>      } else {
>          fdt = pnv_dt_create(machine);
>          /* Pack resulting tree */
>          _FDT((fdt_pack(fdt)));
>      }
>
> will never take the "else" path, and that code is dead.
>
> It also suggests we should call fdt_pack() in pnv_init
> before setting machine->fdt.
Correct. I missed this. Ill add this in v2.
> This bit code in pnv_reset():
>
>      /* Update machine->fdt with latest fdt */
>      if (machine->fdt != fdt) {
>          /*
>           * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
>           * the existing machine->fdt to avoid leaking it during
>           * a reset.
>           */
>          g_free(machine->fdt);
>          machine->fdt = fdt;
>      }
>
> is also now dead and can be removed.
>
> Q: can the generated DBT genuinely be different on a
> subsequent reset than it was when QEMU first starts?
> The comments in the pnv_reset() code seem to suggest it,
> but on the other hand the code as written will only
> call pnv_dt_create() and update machine->fdt once on first
> reset, not on later resets. So perhaps the comment is
> just confusingly worded ?

Yes, I am not much familiar with the design here. But, as per

my current understanding of this code, DTB content should not

not be changed.

> thanks
> -- PMM


~Shivang.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B72BE9B25A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 05:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv7vb-0001DZ-Rg; Wed, 25 Feb 2026 00:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vv7va-0001DI-Ec; Wed, 25 Feb 2026 00:59:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vv7vY-00013Q-LO; Wed, 25 Feb 2026 00:59:18 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61OKPSmZ3207066; Wed, 25 Feb 2026 05:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=v6W+26
 1N5z1RPnDJYqBL/lTCtJBqSQBpVe60v5Lr4zo=; b=CBGqaQNxZ/gIR83jiJvnad
 3ye0VNkLOAsOOBwCnifxXPy7MWkcDnAkxz23L+uOOpCjherh5dG1ZrmP9mjAbcnG
 c4FXXpi56tICJVAcbdZi1/Ug8TU56RAZHtyeKGptASb0Smsq791SIVRHzgsV4mzx
 sXVwIeTytB/cVdF8oDHrr/4xQd/VoiwqppQtTLBPBMY27sN1RIKoXLzvUvYHXHkZ
 zz+l4mibeIMaJ4jndiA/Z4bDxxOzEpPSeNjro0K4SBdrjfOM4q56PzlscRi30Cwn
 KHY95HNSLMkBJfkV2R7Wqi962syQePs2WmLnIjliSf1yhMTibm99PCly9FQzFCmg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24ged5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 05:59:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P30T0v002215;
 Wed, 25 Feb 2026 05:59:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1n42gn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 05:59:14 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61P5xCNI18154120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 05:59:12 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B82175804B;
 Wed, 25 Feb 2026 05:59:12 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86EA758055;
 Wed, 25 Feb 2026 05:59:08 +0000 (GMT)
Received: from [9.124.208.177] (unknown [9.124.208.177])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 05:59:08 +0000 (GMT)
Message-ID: <753f9d96-2901-483b-8148-04bc97d3d122@linux.ibm.com>
Date: Wed, 25 Feb 2026 11:29:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ppc/pnv: Add unimplemented quad and core regs
Content-Language: en-GB
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com
References: <20260210134647.2050821-1-calebs@linux.ibm.com>
 <20260210134647.2050821-3-calebs@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260210134647.2050821-3-calebs@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699e8fb3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VnNF1IyMAAAA:8 a=c5OLUQTj0YHlXaN6L28A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qSBmLuOqSNV_cgzZ7LQ219zdPdnHT8c5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA1MyBTYWx0ZWRfXzFGR/Z4W/BmZ
 6zzAuJ2qKrLebZu8ZqslMyWId2Dguqij8SiAxmpHIjfMuxbNwHEWhZulbUXRXYK46SiEHbd5iPG
 YvMg1D24cbFyj4GsLaVXcr15/IdPY9SExK22dCf1V6OOJfD5oNu5AiocMKHmujTqhUftT38cwS9
 32HgbFkx2RUBV5DjVBGME5zxHyS5OALcdDFhMTG95zEtzvqNhuT1s7tm6/e51GFLYSP8bMAG+0k
 i3vQMpUQvOZBD1H8McLKzmlKvqVOa+gjcNjX3iIpqLWWavFnUKqjU6ZpeNtQTvLuqruD/yR1lI6
 /bHbEuuj/SfkMToZcgW5Avky88wMDD7yo2+VUX0IsmWUki6SklWySRcvRCDQGqBZKBmRCWhd26d
 Ze4pwTIwve/9W11RRgXGhOT+QFtMpp1sADtYCga/Hb9SpHOSzYRE7+ZWCRFWihDzc+6zghS1UiS
 pNdxdh2WL6ejW1O3bpA==
X-Proofpoint-ORIG-GUID: sLNvYO_FZ5r8mWMgplvwA2BLGX5Ev1vM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250053
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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



On 10/02/26 7:16 pm, Caleb Schlossin wrote:
> This commit adds the read/write functionality for few core and
> quad registers for Power Hypervisor development.
> 
> Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_core.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 87 insertions(+)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 8939515c2c..a95934710f 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -183,12 +183,22 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
>   
>   /*
>    * POWER10 core controls
> + *   Adding additional SCOM register support needed by the
> + *   Power Hypervisor team for their development

.. needed for Power Hypervisor development ?

>    */
>   
> +#define PNV10_XSCOM_EC_IMA_EVENT_MASK       0x400
>   #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
>   #define PNV10_XSCOM_EC_CORE_THREAD_INFO     0x413
> +#define PNV10_XSCOM_EC_CORE_FIRMASK         0x443
> +#define PNV10_XSCOM_EC_CORE_FIRMASK_AND     0x444
> +#define PNV10_XSCOM_EC_CORE_FIRMASK_OR      0x445
>   #define PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS 0x449
>   #define PNV10_XSCOM_EC_CORE_RAS_STATUS      0x454
> +#define PNV10_XSCOM_EC_SPATTN_OR            0x497
> +#define PNV10_XSCOM_EC_SPATTN_AND           0x498
> +#define PNV10_XSCOM_EC_SPATTN               0x499
> +#define PNV10_XSCOM_EC_SPATTN_MASK          0x49A
>   
>   static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>                                              unsigned int width)
> @@ -224,6 +234,19 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>               }
>           }
>           break;
> +    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK:
> +        return 0;
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
> +    case PNV10_XSCOM_EC_SPATTN_OR:
> +    case PNV10_XSCOM_EC_SPATTN_AND:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                              "xscom read at 0x%08x\n", __func__, offset);
> +        break;
> +    case PNV10_XSCOM_EC_SPATTN:
> +    case PNV10_XSCOM_EC_SPATTN_MASK:
> +        return 0;

These two registers could be clubbed alongwith previous two regs case
returning 0. A single line comment with the reasoning for same would be
appropriate.


>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                         offset);
> @@ -284,6 +307,19 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
>           }
>           break;
>   
> +    /*
> +     * Allow writes to these SCOMs for Power Hypervisor development.
> +     * Behavior is not needed, just to allow writes to these SCOMs.
> +     */
> +    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
> +    case PNV10_XSCOM_EC_SPATTN_OR:
> +    case PNV10_XSCOM_EC_SPATTN_AND:
> +    case PNV10_XSCOM_EC_SPATTN:
> +    case PNV10_XSCOM_EC_SPATTN_MASK:
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                         offset);
> @@ -579,6 +615,23 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
>    * POWER10 Quads
>    */
>   
> +#define P10_XSCOM_EQ3_MODE_REG1         0x1160a
> +#define P10_XSCOM_EQ3_NCU_SPEC_BAR_REG  0x11650
> +#define P10_XSCOM_EQ3_HTM_MODE          0x11680
> +#define P10_XSCOM_EQ3_HTM_IMA_PDBAR     0x1168b
> +#define P10_XSCOM_EQ2_MODE_REG1         0x1260a
> +#define P10_XSCOM_EQ2_NCU_SPEC_BAR_REG  0x12650
> +#define P10_XSCOM_EQ2_HTM_MODE          0x12680
> +#define P10_XSCOM_EQ2_HTM_IMA_PDBAR     0x1268b
> +#define P10_XSCOM_EQ1_MODE_REG1         0x1460a
> +#define P10_XSCOM_EQ1_NCU_SPEC_BAR_REG  0x14650
> +#define P10_XSCOM_EQ1_HTM_MODE          0x14680
> +#define P10_XSCOM_EQ1_HTM_IMA_PDBAR     0x1468b
> +#define P10_XSCOM_EQ0_MODE_REG1         0x1860a
> +#define P10_XSCOM_EQ0_NCU_SPEC_BAR_REG  0x18650
> +#define P10_XSCOM_EQ0_HTM_MODE          0x18680
> +#define P10_XSCOM_EQ0_HTM_IMA_PDBAR     0x1868b
> +

I think it's time to probably move all macro definitions to 
include/hw/ppc/pnv/pnv_core.h ? Preferably, a separate patch to move the 
existing macros first, and then this patch can add new ones there.

>   static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>                                               unsigned int width)
>   {
> @@ -586,6 +639,23 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>       uint64_t val = -1;
>   
>       switch (offset) {
> +    case P10_XSCOM_EQ0_MODE_REG1:
> +    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ0_HTM_MODE:
> +    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ1_MODE_REG1:
> +    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ1_HTM_MODE:
> +    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ2_MODE_REG1:
> +    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ2_HTM_MODE:
> +    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ3_MODE_REG1:
> +    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ3_HTM_MODE:
> +    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:

a comment for the rationale behind this change would be helpful.

> +        return 0;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                         offset);
> @@ -600,6 +670,23 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
>       uint32_t offset = addr >> 3;
>   
>       switch (offset) {
> +    case P10_XSCOM_EQ0_MODE_REG1:
> +    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ0_HTM_MODE:
> +    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ1_MODE_REG1:
> +    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ1_HTM_MODE:
> +    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ2_MODE_REG1:
> +    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ2_HTM_MODE:
> +    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ3_MODE_REG1:
> +    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ3_HTM_MODE:
> +    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
> +        break;

ditto for comment providing rationale.

BTW, I am still not sure if we really need this patch upstream at the
moment in case a behaviour change would be needed again for some of
these regs until the full PowerVM support is ready to be upstreamed.
However, since the change appears safe (has been vetted by multiple
reviewers already), we can consider it along with above minor comments
addressed.

regards,
Harsh

>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                         offset);



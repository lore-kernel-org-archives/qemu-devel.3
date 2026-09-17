Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B892C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77MF-0008RV-C8; Thu, 17 Sep 2026 04:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1x77M1-0008MO-JF; Thu, 17 Sep 2026 04:20:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1x77Ly-0002Ow-TG; Thu, 17 Sep 2026 04:20:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H62V9W543292; Thu, 17 Sep 2026 08:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YH2ViF
 0lJ9F8QlTU4AxhSTwc3pnQnd8XuhSDsRxDaaA=; b=nmH9O2en+fO2AU+YJBQri1
 p19QRXG20V92TP4wKtXlc36+8miuibvXfncFhwng2Mm3Nhkmm6aGLuQm917vGM6U
 z77XspVb6x4PEG5FT3XPMMPuT17gqMV4GrVkYkCiTiyB6MgSCKOoZ/kSMSFKBrY8
 CrXsRZWGZzVaYOWVj3G08kOj+X6II7S0mDHUXD8JtHS8wyuGU2ous8PrT7EcZcV7
 3DkqiSETpnyou2fOjhdtF+9DKk7Cva+nUVsi5fEfnft2ZB4SE8cleZHSTkwRjXoG
 DklsBs0eeYd+/XiJj7iO2QUb8re/RcpExfkbgZS7mfeODX+7qXT54UgC1ubRaiAQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e8v5p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 08:20:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H652Cq2723214; Thu, 17 Sep 2026 08:20:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yrjcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 08:20:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68H8KCwJ48038294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 08:20:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAE0A20049;
 Thu, 17 Sep 2026 08:20:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 028D420040;
 Thu, 17 Sep 2026 08:20:09 +0000 (GMT)
Received: from [9.43.124.189] (unknown [9.43.124.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 08:20:08 +0000 (GMT)
Message-ID: <97eda650-c75a-4342-96d6-d44c4780a1ad@linux.ibm.com>
Date: Thu, 17 Sep 2026 13:50:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] ppc/spapr: Add VFIO EEH error injection backend
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, mahesh@linux.ibm.com, sbhat@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
 <20260901174110.45356-2-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260901174110.45356-2-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwOCBTYWx0ZWRfX7iXrK4MUWYnp
 MUtchXtmXUhKL5Eja0ISg6+yog+JoSYYtriIoXwoxS/ipozm/sCH8/PJDBWzhY1euChpKqlGOi9
 NnbD4h/w704nNfPvHFI4eNQk+j+F4SVo/4YxR/90/Y2dcUp1IK8z6/S9/aGVdn2R+4vTnXG9rnV
 wvYC0b4VH55KuHBzYj+hPzpBj2coI5ye/nYdO8qEqhIUE0oeJG3eAJPVWlB7EpDtdIjoWJZebRe
 ToRiTl0wtILosHVxY+kzsUMPCZ+7Hl3+EEyOZDp+QmzZIj0VPp+g/sOSrD4LLSIruVfvYmzl5Sk
 WOu97jy4ImWzwgVUP9pgE0lDy8x4eR0q6IVRXvZdNpzkzq5qzGfBIZswQgNVnQ07aCPSXk/JRor
 0wDofvf5l/RmvIVlrxbDVAkLgLulkPsTArTKWeBQgiiC2URHipb4civ1ZLJuff6RiM+SSX0iA03
 48tOq+tmc/tlQ3dvhsA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaba2c3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=eECvpAt6tWSfZlz6KskA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: n4Lh-Ewifa-NUDFJCfSHUDonOXF260He
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwOCBTYWx0ZWRfXzoPGTCyUEyT2
 3AtxmD+S/HmM7Nr3IUIypzRNiE9myB3em9SU1xSp3xYKm1txfCeMdaErLRkSxiCVHl024l/SAVh
 +asqdZAF8niLV7lXJrSRn2h6cRAnt9E=
X-Proofpoint-GUID: kSq1I2e7WHZsNsxIXCy0NtYRqVpwadCT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170108
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 01/09/26 23:11, Narayana Murty N wrote:

> +    if (ioctl(container->fd, VFIO_EEH_PE_OP, &op) < 0) {
> +        error_report("vfio/eeh errinjct: VFIO_EEH_PE_OP failed: %s",
> +                     strerror(errno));
> +        switch (errno) {
> +        case EINVAL:
> +            return RTAS_OUT_PARAM_ERROR;
> +        case ENOTTY:
> +        case EOPNOTSUPP:
> +            return RTAS_OUT_NOT_SUPPORTED;
> +        default:
> +            return RTAS_OUT_HW_ERROR;
> +        }
> +    }

Hi Narayana,

In existing QEMU EEH code, I have seen that EEH operations call 
vfio_eeh_container_ok(container) before EEH ioctl is issued. That part 
is missing in this code. Can you please add it? And if that check is 
intentionally skipped and not necessary here, could you clarify the 
reasoning?

The rest of the patch looks fine to me. Once this concern is addressed, 
feel free to add my tag:

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks & Regards
~ Nikhil


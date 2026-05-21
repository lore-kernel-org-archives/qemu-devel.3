Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7F5CD5BAB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 20:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ9qd-0005Fm-Rt; Thu, 21 May 2026 16:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wQ9qT-0005Dz-26; Thu, 21 May 2026 16:18:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wQ9qP-0003rN-D9; Thu, 21 May 2026 16:18:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LC15pe834424; Thu, 21 May 2026 20:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dwRNOM
 KLj/BAPj0a4JmOg7jRonYoBx8nRsG1r6KXKn8=; b=kkYS4JLxatQ3T6yP1yQJwO
 rD0KW87IHpyK7gIDT4Z2xsUrSzrlBk75xXN5kwg/qowIyPdt6DXHDVweBfll09d3
 7OZ1f+ak+e7RV5T9Ldi+EkzuZZ/VSnEvzF35f2eD3LS5Ik3WDEakc510HwokGMid
 k3L0ppL7IM5NfjeaxWgUGEplfE6d6zqB8pGpQPO0yL3gROeW1qNSOIZ/AhGiK8br
 rQbzj2n4glPnbJbAlXRQlq+xEaIopTfpPbxnPOxrBOyJVAIV7VKnFS7nWGN9VxVU
 1Ay8PbM56UJLRtTGn40gEuqZ8NW0F15c4A4T+ZwsCtUK/uaeo2le0h60P5txxXfQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n0ut7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 20:18:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LK9N2A030142;
 Thu, 21 May 2026 20:18:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kydnvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 20:18:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64LKI67V48628128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2026 20:18:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18BD72004B;
 Thu, 21 May 2026 20:18:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2311120043;
 Thu, 21 May 2026 20:16:58 +0000 (GMT)
Received: from [9.39.29.116] (unknown [9.39.29.116])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 May 2026 20:16:47 +0000 (GMT)
Message-ID: <85986a77-4135-4419-946e-16eea76fb36b@linux.ibm.com>
Date: Fri, 22 May 2026 01:45:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ppc/pnv: Make Power11 as the default CPU
From: Aditya Gupta <adityag@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>, Shivang Upadhyay
 <shivangu@linux.ibm.com>, Misbah Anjum N <misanjum@linux.ibm.com>
References: <20260521200844.1449023-1-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260521200844.1449023-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: bR4VayECeZdOoYecEU5FPZMy8IG5pA-B
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0f6883 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Qhl29BPw-YrFtiSbdCcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _T2nhcgzv4i85Y7lF1UGJkypw8FLcg9T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIwMiBTYWx0ZWRfX1WWwHnrMX//u
 DSCVFb8DiIMAglNLsiXLABH1aFhlmN+wGCh8eVJT9jBF48Ss2JHy0Kw8xT89HLRCiUB0JApXplq
 fLzMQVAVJxHOPnlcfBMYBOtCGY1/ElsOad35OtMRlpmkxNW05gQ86g5E0e/mtQmhPCN5jXkuXWg
 SKGtJ6DJCcjo2MChpp/+6oP9VVoTralJFjSutDhWO01TQRbPLGMFWMGtakZguOgXkSAPpCNw0pH
 OFMJiDdsLVFcT9oYu5QOhCMccEXI4FWoxwlBJ/JlUSDqrfkTgVy7xDpVLv3lqsTWLhBZyvOGUnU
 HCqvmmtfHTxwMRuQB6J1c02lEVy6YXD8KsDghwdsn6uKF0ZpW5TNGAS7PYpAWgfRrGVllq6cxSe
 VIq0leRoW5sAseB+MwZiCcQWg674o5fRYe4JUSv2RhK29StSIWx6EN1UPKp5I9EhkeiB1rM7isq
 2+KbTBuDXOKRWODTDuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210202
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 22/05/26 01:38, Aditya Gupta wrote:

> Overview
> ========
>
> Power11 is the newest supported Power processor merged last year.
> Make it the default processor for PSeries and PowerNV.
>
> Testing
> =======
> 1. Git tree with patches: https://gitlab.com/adi-g15-ibm/qemu/-/tree/feat_default_p11
> 2. Gitlab Pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2542576926/

Note: For qemu to successfully build, following patches by Amit are 
required: 
https://lore.kernel.org/qemu-devel/20260518172517.12466-1-amachhiw@linux.ibm.com/

- Aditya G


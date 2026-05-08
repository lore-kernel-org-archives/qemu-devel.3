Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D802FCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIPI-0003G0-Eb; Fri, 08 May 2026 06:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLIPG-0003FC-9k; Fri, 08 May 2026 06:26:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLIPE-0008KD-ND; Fri, 08 May 2026 06:26:06 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647KMaZp3638747; Fri, 8 May 2026 10:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=r4LM61
 dBNjqRHm+K0kY/yyiUMXTsYjir7VWm4aAqhRo=; b=MFjC8Tq5pc4eug3fjhFYOO
 udZ8c1jdQyvwPwjX1JWlC+Yf0MN9EqGSh5W7AOfj3nYjtvEdSw4dcF9kuiaFoX1y
 qKFMiebt57RrIZKhoicD8KwukoU0kCv3kV9FqeH7oq6cW1PJS6ylSaBD6d7FX5ud
 DkvwCi3LOB46baSDRBKJHDGRh/DmMGsaDHR1yzOoXBTwD6HhyhEUr0vVZ8jNPdlg
 6wUx6EwHNd2djIikB3BOUpxdcNjJIPaju20+BSTdymsZ8t4pIVTRNFU+1ViMs5o4
 V9MpLytE9Lg/H0j55eQI6Jf0HMJsjgFMpRzs94AAdu0qgrdVB5ljY1D1EXjU+Ouw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xy1v2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 10:26:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648AOTcX027249;
 Fri, 8 May 2026 10:25:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hfpu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 10:25:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648APure57278872
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 10:25:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D8532004B;
 Fri,  8 May 2026 10:25:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2980520040;
 Fri,  8 May 2026 10:25:45 +0000 (GMT)
Received: from [9.124.210.83] (unknown [9.124.210.83])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 10:25:43 +0000 (GMT)
Message-ID: <dd076589-951b-45f0-82ca-165d16283b83@linux.ibm.com>
Date: Fri, 8 May 2026 15:55:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add self as reviewer for PowerNV and PPC TCG
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, rathc@linux.ibm.com, milesg@linux.ibm.com
References: <20260501144558.24491-1-harshpb@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260501144558.24491-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNCBTYWx0ZWRfX90blRgQgcewy
 RBFwXLgyv5rDlRErA7ZHaY+IXf+X2Tp6+mOgZVjAXylE8mcSV+TPG1+3JwCcNK7BITugQzfDw5p
 BqEQIU8ia1CLZnZ73qdh9Aa6Xuo0bXQSVl1la65RqzWOnrIpmGHYVjgZyr429Q5DzOAZkVHmzWA
 fGF2vyDUeIbjqmisS5wYlNi/VPvk3T6B1HdSL48kI6MUDPWBUSBkZpcymWgAUahsVAtD68j/jEd
 N38pSaFp/bTeyrQu9XDvODIRsbtF83X2PO2eQpyfSc/rxwFWk699d5PQF/lZQ9YAX5ULVM3nmR2
 nKgzaIbB/1zpBYdVKpLp8A/X97VlRNgZEZB7BIrDn9nCDEVjYIPooNRauKwnfWXEZP7RkqU6sXe
 StueQjZ0Hj9W/omu1X9d6xh5lo9Cl91wYF9fwZ97SFkmvlFs8k5ezzBIsQ3NC2ab/x1oKJAh7kl
 b0gqE5+BdnUsKBcxaXA==
X-Proofpoint-ORIG-GUID: m8aMrgMdAtzG_3bAbjQ5Wit29nRK-OK9
X-Proofpoint-GUID: 8eaZymt2m3uB1IlAmcbTSZdfFEGJwaIK
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fdba38 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=IL7DAOFrXIg1l3Eq_CsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 01/05/26 20:15, Harsh Prateek Bora wrote:

> Also remove the redundant entry for pseries.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Acked-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks,

- Aditya G



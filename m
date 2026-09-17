Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE89AC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GoR-0003D8-BC; Thu, 17 Sep 2026 14:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1x7GoI-0003CZ-KY; Thu, 17 Sep 2026 14:26:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1x7GoE-0001AH-6O; Thu, 17 Sep 2026 14:26:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HHVQhh3143218; Thu, 17 Sep 2026 18:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+8ZLgk
 rvqr/T2haUzJ739haRsccTVD5FdZrp3nfkAVM=; b=BCsxLRzs7gZLrIegIa+vOI
 F/KgJ1BIwPxP1kLW80IvAAuu4WrnCH8L+THO3GzFoVyv6bWGxDtHgNyBvzDizaWc
 mE/6zPf88XKnBPkXHq0Dzm7WisuiYDY/RIKlNz+iTFOz6C4MoUmqxzeP78uY670N
 rRNLsiLDw0HEYtU16UuY8uAOKd4+bGZEti8JRuQLMJ86lrzZ1g+oFMRAyDHv0Bm9
 b6wcgF5TciUW/nFiTfzHzGhaMJQCYWVnFvZkFN/AZJIw/NLjtJKDQCoNoWKlbb42
 9BKRjgq/wKbXlQafmMmLrlWg16tHFbBion3/SvSagQh/fnuhHwpF7auDiXPerrUg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx8444sh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 18:26:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH8wx8261494; Thu, 17 Sep 2026 18:26:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gekbs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 18:26:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HIPx4O51904946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 18:25:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AC1F2004D;
 Thu, 17 Sep 2026 18:25:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE2E820040;
 Thu, 17 Sep 2026 18:25:54 +0000 (GMT)
Received: from [9.43.67.51] (unknown [9.43.67.51])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 18:25:54 +0000 (GMT)
Message-ID: <752d54df-ca01-4569-a945-8d88e2eaf152@linux.ibm.com>
Date: Thu, 17 Sep 2026 23:55:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] ppc/spapr: Add support for ibm, open-errinjct and
 ibm, close-errinjct
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, mahesh@linux.ibm.com, sbhat@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
 <20260901174110.45356-4-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260901174110.45356-4-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1NyBTYWx0ZWRfX/6njOCd7BtKN
 Y5b+JPw/o2rTXjdl7jkdx6H7CmW7Cd9IG132Qo0YSjgapr12y/Zd8io6uPMyuJAV5ZUv1SJTR+7
 WbOYxBMYVMzFcuagOcl66BszD2wygYejQVZjvQGcAO8sE/+eYfh/YJW5lHK2Xratq6NjTf0+xCg
 vsjfu17nkAFXAVpZ4AKdQRpX9BGleYhD3WY+mmG1dDFGplLz9WCTryYhkKNt/C9uichq8RLbiXK
 0JuyRit6Fvkib+s/RBf4PIb3p8Q1drpKxqE/rwEd2EKqkIVQ0eXzFjMsqRSWrTu+W/f4B8HuQFU
 EprbpNzn+EQ6sI/gekX1BKRXT4/8e6o1dzW73hsAgo/jL+k10LtI57rv3qzvHyD8UexIaWhUbr9
 o6JRraaIX/HzjQJTb9blJYVGaNrBT+y+8VASc+294WtlXsEPibJWA0x32lN0Ex+SLa7vtlrx2d4
 tGpgAfYpl+TAA63AV+g==
X-Proofpoint-ORIG-GUID: uA488dPuunjP0Qpk7Rf6UL9-Lw4YtJsX
X-Proofpoint-GUID: qcJkvNrR7Z29oUBv1SRXPz1mja95Hts9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1NyBTYWx0ZWRfX7ItcC69qqIgB
 lKXBHgoNTpkdvHhlZN4+qFFOGSRd7fPKS8NnwNA3gHr0KzDag5BOJ/q622RVqjqIAg4gwk+J0Eb
 9h5oBbSQMfyghnCIy9PcL/ERL5Y8sMg=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aac30bd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=jgDA9dOrmJLqsAro-SoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170257
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

The patch looks nice to me.

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks & Regards
~ Nikhil


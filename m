Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAD4C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7IO8-000326-Cs; Thu, 17 Sep 2026 16:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1x7IO6-00031P-ED; Thu, 17 Sep 2026 16:07:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1x7IO5-00006s-14; Thu, 17 Sep 2026 16:07:18 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HHVc2H1980413; Thu, 17 Sep 2026 20:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fJDoH0
 b9HRtp0HYbaHcMXNV5RNnyiwMKyHK6VGO8Cmo=; b=TZH5EhNSLSCQImTVp5Z/CG
 YRqS5bUknZPOTB4XMziTITICEFsBusTsGqyrWczrCDQxQ9L7UBdZmvHHWukFwp2v
 Uu5tLw/+gLr5QuoQrtWX7Yj8wiUqgMFEjlNUCrkIAQGG7gRnr8uvM4sX5FX+LTYQ
 vgJFiffMVwrgqtEKn3Yg+GxYkGPAAFFA5Rdw+aC4j9mb2vhotBpXV7AyToEB/DUM
 VMNHDy/JSdBl8vAait5jLGlXBEVsQgk0Ias8WkqW+L+1pHhamq1xnyPzN2anCkwY
 zBUymm0aYUpS78ggpLQF722xA54xMctTUeWw+LpTAjn+nbAgqJBXd+HZviSyTObQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5ec43h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 20:07:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH92Sw3510137; Thu, 17 Sep 2026 20:07:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa427a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 20:07:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HK78jm28508598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 20:07:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E5D12004B;
 Thu, 17 Sep 2026 20:07:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D6AA20040;
 Thu, 17 Sep 2026 20:07:04 +0000 (GMT)
Received: from [9.43.44.15] (unknown [9.43.44.15])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 20:07:03 +0000 (GMT)
Message-ID: <c9c57648-db60-4365-9104-3c8dc427e907@linux.ibm.com>
Date: Fri, 18 Sep 2026 01:38:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] ppc/spapr: Split VFIO EEH support from general
 VFIO code
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, mahesh@linux.ibm.com, sbhat@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
 <20260901174110.45356-6-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260901174110.45356-6-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI4NyBTYWx0ZWRfX1miSi9i2KfLQ
 grG65XEjwa15754aucRcdN9Tlky7YzwoB2oYIAwWIsffR2TPcMJZt0AyAdiEF0tOHYtkX1i4ZCg
 pgDysjBcp4UvcTaDG0a2d7sndT1rvWDtQyfRlQnPweitm/Z8zEzXGStIg4W2aWzPawEbQ5VX3mb
 oh5XBGXa4/xoIp5wKWe29Dc29rXZ5O6izeGhRiiWmPA9cAcJ3PlfCF9vx1wq9BEbD5YDC0jM3Wz
 lnTemgy9al6BduhyL/FkVgzcRb2o/FfQoTBGlNbz4I/B9ubJE3Qmtl8FmGzZo6JT2gwRABvuDH9
 2dBLy9NQvoRmwZUP1QWbEtrRSBLbgc1e0mlYYdVutKd9h3lkXdngM13yZ+o7b4hx9ejPagT/jN/
 tsq+p0kYMdHwkcNpBc3FHdoLLmB/gkwTtYZ7GpGVuRqvCGjkGXJXqu01xdYEppgQSeH7E5YSWS8
 k3VqV3i08xFv5IYbB6Q==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aac4872 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=tGTCX954vJuJRVDza_wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vUiP9Ejj34e015b1c4QqdRSy9cZeZFtY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI4NyBTYWx0ZWRfX70g8sOwdd5mg
 rtxO/F/9ABkThmBv+Uh/qy38r/e8LaJDoi3V0x1dnTdLsTjnkOjZ/2IRmUh6M3fb2VKwcb77FlI
 OgBDGmwzKZpeh7+3E0LRxLUOX1BySjQ=
X-Proofpoint-GUID: 0noA_zmAcAXD9MDtSFWDPFvSnnGD-Xi8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170287
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

The patch looks good to me.

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks & Regards
~ Nikhil


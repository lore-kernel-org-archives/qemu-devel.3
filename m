Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CD8C55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqr7M-0006Lw-CU; Mon, 03 Aug 2026 07:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr7K-0006LA-Ed; Mon, 03 Aug 2026 07:46:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr7H-0003dm-UF; Mon, 03 Aug 2026 07:46:01 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672LmpGP2566607; Mon, 3 Aug 2026 11:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bn/ET2
 6AxBFONnjOSeLX9edgsIZdOs7l1WETp2/uu8k=; b=V3L4uXxnXRL8CZx91GzSOT
 e5gsM+oStLfWnU93yZDne5d9sh2VlGcEsP1bP3hCzkSQ3YvNKP6YCDwa8AzsauQv
 xygy8EiD+p/iSt0PmfCOOknE+QtUDYXWdaa3RNy1CoATc0qbJrFj7QR2X42VT0hc
 v+Nw4K3rmLdzkq8ozwIVMyxYqoFZtOj+eIcQMw9RKhGOx8A8+hYzv1PArgbNTcWQ
 L+DI6Ee8kFwiTXhHQgSTUomBJ4ROtWB1LEr/hv4a9YhN/hJWJajsXBpr6tvaLAyV
 RlfR9N66cRp+VUatqan4mg8mJmC1eAd311rxIGkzKKvH1/y5Hfwpjlxvbf2m2w6A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqgfjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:45:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673BQPef021529;
 Mon, 3 Aug 2026 11:45:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qdavp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:45:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673BjsDq49086924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 11:45:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEB8320067;
 Mon,  3 Aug 2026 11:45:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C30BA2005A;
 Mon,  3 Aug 2026 11:45:53 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 11:45:53 +0000 (GMT)
Message-ID: <a3e94de5-f9e0-4d82-87b8-8583d1ce3473@linux.ibm.com>
Date: Mon, 3 Aug 2026 13:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] target/s390x: Convert op_st8 to op_st
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-9-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260731185628.23161-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R5Rg_meg5LjbxyvLc_krQbaPFESZHsd1
X-Proofpoint-ORIG-GUID: R5Rg_meg5LjbxyvLc_krQbaPFESZHsd1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX3FaAcsG5vFM9
 cS72D4fa2O7O1289lmtoxeQuIy6WY2sBNbp2elZtaOa7d7h6wxl1m7ir8jKmIcPW8zo7k+vTo9/
 /z8Dh5A2Vrj2sv8hw3qFFBicHPhOtyc=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a707f74 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=mCY9YKB4b3BH0MC2CqwA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfXyw0phOVB82Hq
 DWuHZy5HnxakT81m88fjS7YqkwJpqt65f61DOG8gUv7xpdiA0bNvdnzP1xfFHJg7B1BzB9+DAbx
 +d1Q7mfqFfTdZ8Cd/ShDk4PM6l3NY8ITSW6jBpS2Vq9kkaueykFxUbD4yiy8vsueIyNkZggQzIn
 n4zZMMUWlIlMKpoRCtuNZiP04hO5ZLc8oPrNcwcLdlcbLfnMAgg3NSk1pIwquGtfL6IjaDHJ7MK
 Xo4Nc/KtntIt9Nu/vxJfsf+KY3Pvi2WBaz4tEWn+VfpNxlDOQTafa1wkuIErZd+DGuyyoplFXnD
 VNNm8rn1mGQY5kj9OleZGL70Aw1IXm/EHMEQVtX47pgPX41tBHcfWJK/i5Ll4uKE+gPIkvHDH2B
 ONIVb+5ow2Yrw0eFouZkL0eqi4dJpCIgEKg6Tq8+57m2rKpI7TgHQ/1OcOvodRp0bBJSP5ApFd4
 ZLdwzRSgkIFVswaL27Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/31/26 20:56, Richard Henderson wrote:
> Begin unifying store operations by storing MemOp in insn->data.
> Start with op_st8.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 4 ++--
>   target/s390x/tcg/insn-data.h.inc | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


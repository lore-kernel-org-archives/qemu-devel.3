Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E47C55179
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqr18-0002A4-CL; Mon, 03 Aug 2026 07:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr14-00029d-NY; Mon, 03 Aug 2026 07:39:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr13-0002Lu-1s; Mon, 03 Aug 2026 07:39:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672LoAe02568777; Mon, 3 Aug 2026 11:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BMA+bk
 fuEDBM8vn5j6ujA3AHkq+o5M0bdegyGuWBgrw=; b=UrNKhSLhk+Em3mMCYEHzo7
 Iv+4EMshTX9ctSZLiFLcS1Ps69Wk+NTGmq6HNvNvMae8ZJdB1MAumy9eNrlgFFH9
 KeqabiK4yL85bAvINaKB5EfpMlCay+jOVBRdEEgzCnPmJM1z8UJDrfPUJLm3SRpK
 78sksNSdGoh9AxciHpe+33QB42hyI1yvs2oZy13v2xCqY5QbJlpOrB/4LQoHAo9/
 Ji33LN9nWORGaPhNTcxqgMccw/9vToyUG7xmGZC4gicDja7Rgc9tZUp9TQ5kEa9A
 uDB1vvSghU8eFtz3i1ygpwGITCTGl1+Hgq1cfAConqqUb/RlzMMUZ+zV1z2t9Dhg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqgesd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:39:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673BQIKG027454;
 Mon, 3 Aug 2026 11:39:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvw7qp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:39:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673BdQCA37749022
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 11:39:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D83272004B;
 Mon,  3 Aug 2026 11:39:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE88120043;
 Mon,  3 Aug 2026 11:39:26 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 11:39:26 +0000 (GMT)
Message-ID: <d7d3b539-b5d7-405f-a627-b3656896aa9c@linux.ibm.com>
Date: Mon, 3 Aug 2026 13:39:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/s390x: Convert op_ld8s to op_ld
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260731185628.23161-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dXlTAuvULLnjT-PzkouhiHkIdmUoUBtn
X-Proofpoint-ORIG-GUID: dXlTAuvULLnjT-PzkouhiHkIdmUoUBtn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX7r1qT0ACbASp
 FB/oqp1HNmpZ17CbtwOrO+5MNOPEFbePGAV62FzWae3/jPWTGK0fU4zodoZD5pyhldbvAwCkH4L
 IZuUgkDw//5MIrRAXI0m3BSC89PXaPY=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a707df2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=TLes5HARpN7NIxw9v-kA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfXw6ThePk/fafG
 WAOcbiHYHWRndKqTmhisnaAgD62Mkf4Jn6Z7oV5scRRrqTH2edRIKpCv19KHnxsPPy1IjR/Ddin
 Zntfd4ROwLAPahl+U+YcBObR91sVpipHa0yVZg+y9YX2V01NJy33i+7qHsdv7fx7F4+IqXFvCT4
 3XjikLCUTNOX7sF9ZbWACdOu7k8xKhULdpcQ3wybk0O0vHKiwgApJ2YPRD8EAlZxCAzagSzQh46
 QfsL9Pmk+rCGqHAc/pwLZ4m7eMXD+B7XZlSJoVyBmc1EbsBMTqkdg8vQY4b7Rko77PCB4FhOJOp
 jEcQ1mkXIvOMSufP3IqFXQWFqYVi+SAj8yALl3I6OfLJjJ5lPG0FwiiuwclG0Wpxh4aznkRMVzC
 fkDNdUHA+yTYLXM4yyb+iS5YgtwE5jfAh8nA4XPsXbPYewQQxTABpRDSjf2KuqVo6RxO43unjrA
 3MVU4y+7aSDCzsTiNYg==
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
> Begin unifying load operations by storing MemOp in insn->data.
> Start with op_ld8s.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 4 ++--
>   target/s390x/tcg/insn-data.h.inc | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



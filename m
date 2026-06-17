Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC70CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZvCd-0007Tj-4G; Wed, 17 Jun 2026 14:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wZvCZ-0007TQ-WD; Wed, 17 Jun 2026 14:41:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wZvCY-0005HH-Cf; Wed, 17 Jun 2026 14:41:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHmSKm1082785; Wed, 17 Jun 2026 18:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Dbh7eE
 1BSKO7LvGWFOZde14//ihpxRPfMYGXm3IIp+I=; b=CgrIS69UrkWUVUtFtnMdGh
 ZETQNVbVRqxgc+1gEPv+5q62jaTeI2njtcyIiywyUEMLAHL6OjzMziZ19tMgG7Fw
 4+rLDApdLNie/BYM6uY0XXv8VnE6+udK2IcavdAa1Z3Sao+K/OYTZr6Z9qxRMd8c
 jC8oIWZ+MDL0dREAMzNcsTXkO0SdvkFvCXLDz1RWhz4KZh/7aPrmKySy+klu06uZ
 3OVN4KjOOHx8oZwzf+BEHm1Mn7kELhUuSAu4dvN238q3rf2IN20tvCGk+o0KZQtY
 9JKzI9mLc2eoALpVLB+Ya/I9YeFNwArRwNpapJVGcBCogbqixRhBnDSVzdJ4d60A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvvgs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 18:41:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HIYaPh029546;
 Wed, 17 Jun 2026 18:41:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva4kp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 18:41:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65HIfJ8n28443274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 18:41:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E569C5805E;
 Wed, 17 Jun 2026 18:41:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 179FE5805A;
 Wed, 17 Jun 2026 18:41:18 +0000 (GMT)
Received: from [9.61.108.75] (unknown [9.61.108.75])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 17 Jun 2026 18:41:18 +0000 (GMT)
Message-ID: <33635949-a3f6-44a0-a908-19222eb7300b@linux.ibm.com>
Date: Wed, 17 Jun 2026 14:41:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] target/s390x: Factor common s390_ipl_read/write()
 helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260617164035.70788-1-philmd@oss.qualcomm.com>
 <20260617164035.70788-2-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260617164035.70788-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE3NyBTYWx0ZWRfX/XnAfKfY3kaf
 mBnE9v0uUPqYucBniONRexMHbCkjxG6E4qmrvhlpVqapWEzWtI6TTYKEMROSugLRklysX35Ftjy
 q6wtl6WgzEXBp5CEXwNg8wAQdcryotU=
X-Proofpoint-GUID: aas03kOIPRnHc1dEaLglLHGIpgG3Iosg
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a32ea51 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=XloHFGe-dfbfG-L8Zw0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: aas03kOIPRnHc1dEaLglLHGIpgG3Iosg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE3NyBTYWx0ZWRfX+3K1+BudWeK1
 QbfzLIdsML9dfQgTETXhjNdzG79VHeKM+N/UMhUf0JFnGHwZkOoPRcn35vguDqXa5FDj0iggohl
 XrVruTW6VRPWePU6h6YhPQhN+4991qN59miQJxmQJfxYY0tk692Mi2dUuyxs9Ena/eA4GpzLLiA
 GkGnYfravqgcW1o6+Bma+QroCmlXGOHatmUMVfgJM71UnKPsklG461JQpVs04X33vPxCpI3qBQR
 BeMv4l9RtJNFFPgLk+DT6z+3qINVc1VSQcDVsatV65wf9g7iMSS7aSorDIN5MZ+K33W1BlObHkG
 dTQXMCzY/O9C+mjcVBmxvIl7i6gfhBl/bzekFC2I4pRRHmSda6cUVAVX9JlcULNQ0anBjz/vlLW
 E/xm1hcEcrE63/1HF+U5s0/l99a+Ilye5V/JCGqnNJFW1hwPL+C9k1eQtW9nEvYsL33tdi4jvCI
 5rXZEEDQGQmMRPimGxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170177
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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


On 6/17/26 12:40 PM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>
> Prevent duplication factoring common helpers.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20260616020839.19104-5-philmd@oss.qualcomm.com>
> ---
>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>


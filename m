Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90A7CD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 19:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKhgn-0001gA-Gb; Wed, 06 May 2026 15:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wKhgl-0001fg-TX; Wed, 06 May 2026 15:13:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1wKhgk-0004yB-FI; Wed, 06 May 2026 15:13:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646E1s9W535863; Wed, 6 May 2026 19:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dykMhv
 DdDGRlh6CsZA0AyJmAIdDYP4vJZwefRoIlKyE=; b=l0i5NgumXhggJVWIRcFVV3
 Y3QH1FHqk2bK2zuLBh/KokeugwpDwLghpmKg4Ps4bc9yJuExUMVlIdKgJLQPHMUw
 HAmwYV5X9MYso20cVx8iCVdV8r+9FVPKBpPPEJufXs8y9IbmT/EShfZ14mWT9pz5
 2Es7A2FHeDHHTN6V5nanQ/QEf6f3ZvQCtGdTVi2nAbw/H1GTTjf6Db9OuZIsVKFK
 f42/vVSUjoH+A8w7+NAE0R7v0iLapPgdJ8u14gbfkk7SVR9vVw4GU/HOkkImaetK
 DgPPNCOEWzYk3gTSOjFaLBKAWWtzZZnLVehpCGmh3jtyO//yn58Rl7I2QILvoR1Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6hndf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 19:13:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646J9T8i028336;
 Wed, 6 May 2026 19:13:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yfe1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 19:13:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646JDZdR30474810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2026 19:13:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A43035805A;
 Wed,  6 May 2026 19:13:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B55EE58052;
 Wed,  6 May 2026 19:13:34 +0000 (GMT)
Received: from [9.57.45.176] (unknown [9.57.45.176])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2026 19:13:34 +0000 (GMT)
Message-ID: <319eabda-7f3f-420d-a841-80d29d89393b@linux.ibm.com>
Date: Wed, 6 May 2026 15:13:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 32/32] docs/system/s390x: Add secure IPL documentation
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, pierrick.bouvier@oss.qualcomm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-33-zycai@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260505201905.997996-33-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb92e2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=LaQpobO6uo00I5wJoAYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4mQ88HGINbFtfQP32wFwYWRAyyTFi848
X-Proofpoint-GUID: 4mQ88HGINbFtfQP32wFwYWRAyyTFi848
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4NyBTYWx0ZWRfX0XGJvMvY063r
 qedzvHeLEZW6Kz/PLZ3R4RnAVufGACUlvJXqsixLpSH0jdu7J0T8eo2qMyTLhlK79s5/1ERV9WI
 PhZePRg7bYLJWYfljETuNZWjIVsgUHdoWGWl8ITvO0QG7EUON66a86Op5bJINTejcUblcSj84LU
 NZPUeB3G/deVcpmnLquICqe9H1rL8Oa2Cd2K2pGmeEyTt8KBumPt3JgBzKgiy5pTRXcDSr6yAmQ
 L9wJIqZj94j+NqOsfPBgRgQVUw40qRVBh8/MOjx/6vCrGVkLrUdCiziyMukns1sUOfCCz6rRf7y
 hHvvuoFtS4zl2gXlw74XbyKdak7+vys5ObX3arHg2K7VJ0ZjreW5kIrb+UXoRZgcaynYF7/ysES
 loYYkjO0HvvWXgMW2e7afrWIShHi3Yd5fxkGsgI4f0faEgrL6Y5pfoe+o31h+qkttQKWFuisbcv
 Rrk5l8D8OjOOCqo1sAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060187
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
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

On 5/5/2026 4:19 PM, Zhuoying Cai wrote:
> Add documentation for secure IPL
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/system/s390x/secure-ipl.rst | 100 +++++++++++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 
Reviewed-by: Joshua Daley <jdaley@linux.ibm.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B3DEDEBF3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWVY-00041a-UY; Tue, 03 Mar 2026 15:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vxWVR-00040N-VA; Tue, 03 Mar 2026 15:38:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vxWVQ-0002lp-E7; Tue, 03 Mar 2026 15:38:13 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623F4E2S1358746; Tue, 3 Mar 2026 20:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=S4PPFi
 W3PQSePJs6WSIPMEYX76pnm0L1rIX3Wy6oNsE=; b=VIZ/3npkTTVDsqpnX+p39I
 V/DxgNgEwhF4Iz1JZsheaXm56v1B11ZkLA5oS0WnVpVbTHgFWfmDXhB8swqL0WzB
 CK6oYpENLzOQ7Y5ZKaRM9WpLaviMbWa18WTzXGT7yZyQq+foXKayMoYabIfvDWCm
 4Pc5vduptNg7UvaLEPsL1N41Ug671THIvIh6bkKOyG7pE8d637O9MM3Ub2L4OeFu
 SrZpsnRfffJLNM5YXsdRr9i7fhKsugdmAVVgFNNeronMAj+G9OA5hXoPTNqV9O59
 9/XSDOxvEQxA+2G4YXZ+utQWKU7NlCW66Q8bK1oLLZzdBWvmA3A6U+yAJAB9VXqQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj4ud1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 20:38:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623HiAIo003200;
 Tue, 3 Mar 2026 20:38:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y448e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 20:38:04 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 623Kc2bn27853328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Mar 2026 20:38:02 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7540158050;
 Tue,  3 Mar 2026 20:38:02 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 780ED58045;
 Tue,  3 Mar 2026 20:38:00 +0000 (GMT)
Received: from [9.61.253.239] (unknown [9.61.253.239])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Mar 2026 20:38:00 +0000 (GMT)
Message-ID: <1a7d38a0-274e-4d29-a433-5df6c084b3e8@linux.ibm.com>
Date: Tue, 3 Mar 2026 12:38:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/30] s390x/ipl: Introduce IPL Information Report
 Block (IIRB)
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-14-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260212204352.1044699-14-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a746ad cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=6TBBRNzuo0D78PCdhlEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE2NCBTYWx0ZWRfX/9ni5MvyHa6g
 I2VyvggeHe7z5XbBS6LcwobGHxbbRJuu+tlMjmScPlFxyzAAHXug3OaJMr2RBFqv5psn6t+hC0y
 aBfNURa561llDlzlQZAvFMpUD6jZQhF8Akg6tVwT3zKko19fcvv6SKruY6a2WrtvvcAxaHvr/CD
 PSvvs0hWmAog9prbMlp7V/QqBbf9izAUgDcHV6aDFEAEBXOrbLjjzZ+Q1V12hEOPsmjIJXH3YrR
 lkmFwldmg1ZtX1HZyLQauJlZSaWEwroubxfKMwDcGl4bbuQt/w9qKTFmDOyvJOFNxt+nhNvuYdK
 jBFnccXBH2G78hGZ+bGIJPM6KApZ6OETXtxuY5HlD3mTUi0nlt6InEvORmeCv3+fNeEtCco4brt
 vo0wbAz1bWeLRkQsMFW16V77xMaOemhwRLctLnSDTJX2i0Qze9zO7H+b+dR5XfyfY6NPU6KDwsp
 hHSBNmIG5YGkkOkiWuA==
X-Proofpoint-GUID: PMC7zzEXEugT9FkKnCwXhXKXu9wxIQ0S
X-Proofpoint-ORIG-GUID: PMC7zzEXEugT9FkKnCwXhXKXu9wxIQ0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030164
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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


On 2/12/2026 12:43 PM, Zhuoying Cai wrote:
> The IPL information report block (IIRB) contains information used
> to locate IPL records and to report the results of signature verification
> of one or more secure components of the load device.
>
> IIRB is stored immediately following the IPL Parameter Block. Results on
> component verification in any case (failure or success) are stored.
>
> Signed-off-by: Zhuoying Cai<zycai@linux.ibm.com>
> ---
>   docs/specs/s390x-secure-ipl.rst | 14 ++++++++
>   include/hw/s390x/ipl/qipl.h     | 59 +++++++++++++++++++++++++++++++++
>   2 files changed, 73 insertions(+)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>




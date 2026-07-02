Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEB4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfBaP-0008G3-0h; Thu, 02 Jul 2026 03:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfBaM-0008FL-Uv; Thu, 02 Jul 2026 03:11:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wfBaL-000358-Fe; Thu, 02 Jul 2026 03:11:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621Li0v2648872; Thu, 2 Jul 2026 07:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4SY6nR
 r7FCTLMIQlhfdBsXT6VzpyWw1QOYumC6ivsqo=; b=rp8a7G0MOOrKf9k4AkYn3f
 dvC1TvW+LztjR8K9d5MOr5yKfAak15XK9gAlJtdh1shF5xQmrrooB2D4BY25thiB
 yteeUkR5mn+kyiuypIVe5Zrz4yBnChK8zUl4NsL4VeVS//MJjuY6xjU3GiL3bYur
 p2R3wWU5UF8iNonnNcpfblRguyfkyb4nwqvWBVVGLjymAzivbJ+DizBI8Cj9RA6d
 E0jgsuHFBigH0Qt+O3LRgn4bFWPZOD92oiMyhnPI++eaNhVcloaBw4uAt8i6seGL
 Mnol0sH08hikid+7Bm0QyUK78OEA7TKFohUvpLayF6dXomBM3n/q1xv1ztkNBMbw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg8kk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 07:11:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66274rkW017432;
 Thu, 2 Jul 2026 07:11:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhju5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 07:11:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6627Bbro28443224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 07:11:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E851720043;
 Thu,  2 Jul 2026 07:11:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 529A220040;
 Thu,  2 Jul 2026 07:11:35 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 07:11:35 +0000 (GMT)
Message-ID: <9e4078c0-e4de-422b-8a01-09ef78c14734@linux.ibm.com>
Date: Thu, 2 Jul 2026 12:41:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] tests/qtest: Add Power11 chip & machine to qtests
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
 <20260630210355.789109-4-adityag@linux.ibm.com>
 <444f825f-e1bd-4f31-81dc-e6916b1b79b5@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <444f825f-e1bd-4f31-81dc-e6916b1b79b5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a460f2e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Uq34ioT5xjltGcfdW80A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2OCBTYWx0ZWRfXxXsiaXGoiQUs
 2fY+Ti9O++sUsWZIbB+QGSDzCNl6bCa+t5E9aLHco5ViLd2SOeVUXDu2474uiK/he2LEcR1A4uz
 5/98hJ1jspGDRzQyc2Nxm5oYO/BZN7g=
X-Proofpoint-GUID: 4eJ187g9j4vrgslC06rMVbVD-giq21jU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2OCBTYWx0ZWRfXz6WAkirRU9x3
 nbyq/gNQYbxTRfgVHyBJizxV1Fg0bo+DNi75O3e8lqNN7q9eoboJNTGZNi49oH7PdnRB8aRAfhM
 Gl0AitRoeiFghopEjpwEx0r0D22Bl+HvVSoKx5dqhVdnlx18O0CPusX5d05ZnFJ8pmMPk4enz4j
 +05pf3FwEN24viVR+vDc9b2IfuT64ZBECiE0UpsamOv8Opic7WeWR7r2PUH9zxAYh4iMPzcabTG
 O1tYNcW9JdD7baD293Ds3VPWVXBN6Uw7d/tCmaOlkqIHYAgIv81MG3egLbNERmppnOHcl7bAlGP
 58zZUDk/BFyUxoE9qBJBzbi9u/EEIAUp8HL7vmtAZ0vtaKYKF47F/lVNRx5qUJ6lJrgcq62T8+7
 WniY+tNakERDT/IFJjAJjMisiGI2SQvUuwMFDrlzTfQ0SVfKSofw+mUgpatBd2O+Hig1Al3TQyB
 UVJ65183v0svqUVOqOw==
X-Proofpoint-ORIG-GUID: 4eJ187g9j4vrgslC06rMVbVD-giq21jU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020068
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

On 01/07/26 07:37, Nikhil Kumar Singh wrote:

> Thanks for addressing the comments I raised on v1. The changes look 
> good to me.
>
> Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>


Thanks for the reviews Nikhil.


- Aditya G

>
> ~ Nikhil
>
>


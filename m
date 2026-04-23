Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0770BFC0342
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvai-0000iJ-VW; Thu, 23 Apr 2026 11:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvad-0000gv-M3; Thu, 23 Apr 2026 11:03:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvaY-0006Ja-4o; Thu, 23 Apr 2026 11:03:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8GbWa3229166; Thu, 23 Apr 2026 15:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=80Kn0K
 ErTUrlAreU7AMkMwEkByJFOm/qxq+yH6f5TcM=; b=LGjTNNled3pzmkT9O2kVrZ
 yDCIKU56y0yFROxfSmelh7PW3nFCyGw7sMnzmI/g3YDLuQwhXNsrLzrzgiylNH5o
 mN9WqbetNKSLeG1veJnqyOd5riQqYbLlWsl0djRy78B2HVHfWZNDaAY1QU3rXjM5
 eCKDe0B8mwx2ekzkDJbFxgbg86BTJ+mJY/UQ7I8aiJ2PMl+cEc5BDBs7dR8Laj9x
 szHBRbCFHUFo20E+OLtrV29OU+25QxHLmbUVhBxq6ueWnf6slCtp6EcFr5nZPSAy
 XpP+h0Rr5pOFJ3PiHZvUmudLOVx9jVtm+IWgAQiZxfElQTWH+u1b2TA253U5q7fQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu299p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:03:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEoRdt017976;
 Thu, 23 Apr 2026 15:03:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxy3fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 15:03:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NF3O7635848666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 15:03:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AFEC2004B;
 Thu, 23 Apr 2026 15:03:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FFBB20043;
 Thu, 23 Apr 2026 15:03:23 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.73])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 15:03:23 +0000 (GMT)
Message-ID: <891f1cc7-8b5b-41e8-9b11-695a737dfde5@linux.ibm.com>
Date: Thu, 23 Apr 2026 17:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/s390x: Introduce common system/user meson
 source set
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423135035.50126-1-philmd@linaro.org>
 <20260423135035.50126-4-philmd@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260423135035.50126-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xu6-7wZuCagdlvKRe75P0b_OgVJy6OC2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OCBTYWx0ZWRfX77Rv8dLLIUn/
 zLmdIAwT07ypVLLIr7pTrnkyQKPKaNSLEGxzvPJHaFwGfY+scK3aj/4P1SNHoQs0y1dFz4rY66H
 DEC8TOl2SkdsI0FSrB4T/IubeXVSApfFbM0xHARzSjGBtiRsl/nPUIuGksCleCj4oWaClgu2TpG
 A4Ja7LuHSfPFUPJAOhe8sjF35r0/p+N9ZeUrx0ANYoPAQfmAG7WXmuLjVrETECPz1jvxfXwGw85
 lTARBO6prvQSJz4KJb+81nmh1raxTiiYlTQxa9yvIAv7XbAPcXVNiV6jWA2nbV+9+MO8A9YxyVb
 T0aZvTdxTtZ6lyDjkCS3hTmQVl768H4NeZRJVjGe838VAFV2RNRQHGw1CKed4HgWHUkTEABQNjB
 Lp6wTS2VQ4bj7mVcyJLWJzX+ZMZH0YVaFuAuavJTe1KKv/zU4q449Ln8LHeEu0l7kNtrtaC3SXR
 JLj38tZfhoUVWku4s7A==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea34c0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=T1P1OpTRLjKXgjHeOEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: xu6-7wZuCagdlvKRe75P0b_OgVJy6OC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230148
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/23/26 14:50, Philippe Mathieu-Daudé wrote:
> Introduce a source set common to system / user. Start it
> with the files built in both sets: 'cpu_models_user.c'
> and 'gdbstub.c' No logical change intended.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/meson.build | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


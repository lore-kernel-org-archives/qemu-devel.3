Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RjguNxFb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJDzE-0003tg-3J; Tue, 20 Oct 2026 13:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xJDzB-0003sp-R7; Tue, 20 Oct 2026 13:50:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xJDz9-0003IC-Cl; Tue, 20 Oct 2026 13:50:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KHEGHH3063319; Tue, 20 Oct 2026 17:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AgT2p0
 vcM/3eLA187OAis6QP5fWfMLUnsTjyh+qHFac=; b=RjguNxFbp9pFxIBwAUTtBt
 SU+qYFLu1YXA6/MMM7ePY+nGGBCfH1q42Uudj3wpO79/S5zvfJV3Ah3bgHJRCn3d
 rAtZR0wmuWHzyjW+bxlLHV6nIH9ZgX5p7DtCMUyrZMH4BUgFppHCis40GXB9yrkN
 1HtbNmitZH0ADXAGWVxV/ixMtduWnkqJeLH8AXE9FX0nOtyPh1C1yfukzAqpA7NJ
 ezaT/3g7gpRp4D9h1D/uY8HIiJQgQoTRnDIyqpTk1wMX4HbIeN/AencFU1LsuzCK
 75AK/erKzu1xt34D4XJ4jVEDjTVj9r7es7hE/HphpUnhgC/qar/AuoWgb/SkoW6A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a4gc4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 17:50:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KH4qli1834521; Tue, 20 Oct 2026 17:50:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmuh36b8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 17:50:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69KHobcY10224322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Oct 2026 17:50:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C01E5804E;
 Tue, 20 Oct 2026 17:50:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 795635803F;
 Tue, 20 Oct 2026 17:50:36 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 20 Oct 2026 17:50:36 +0000 (GMT)
Message-ID: <543c35aa-76c5-424c-84ea-2005bd0f77d4@linux.ibm.com>
Date: Tue, 20 Oct 2026 13:50:35 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] s390: mark features that depend on deprecated
 features as deprecated
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-stable@nongnu.org
References: <20261009185559.144750-1-walling@linux.ibm.com>
 <15d2f267-aab8-4333-a15b-8f402780321f@linux.ibm.com>
Content-Language: en-US, en-GB, en-ZM
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <15d2f267-aab8-4333-a15b-8f402780321f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3MCBTYWx0ZWRfX/+7lRJgG0S//
 YeBNcLQiqamo0LExJdK5B77yAxCqkBEpe0zFstotEcAwo1ydxo1FwAj714KCrNUFJs5bjIGosD3
 szToO4MdMPbH/F+bE/PGhZKkyYdI3ec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3MCBTYWx0ZWRfXx9Cd9DHXOxWN
 4AZHc5VMqiTot6jsS3Kz8WqFfvCHOCtJIj9QvyrdQ7Z4n0YicQ9CNiJlv4mAJRKXaLeOEx8JIwA
 0WMv+EpKhfRQd8MMUH3x5xs7WLvX5YgHFAUoSC6Q1k3Z69e7m3f2PhCTLgdy6O5FYKYJXgxY21P
 geCbpTdd8HWczAwmTNieOcOJ8qPPy9bIU0aqwVu3nr8xmF0eMr1rg3laPSXecIRMUqA3BkXxcoa
 NS+f8wNrwv5eklpr2datukZ0apcP4it+2uRU6WAHyJUGECq73uJDzXVBtbL6qJ640wJ2wVi2vEO
 Xo7fTi0OrBaRSt8W3Hr89OoikyHTJrk0NCrCj3jSfW+RUl2DmDHVrtXp4aaEbUiTXpJGecWyN+5
 49qfUXqkp++UH627wvrWRKtu83Wp9B9lx9ycSuNraIIdXdp26udUIm7HMzbtDglLhkjAbtCQn/2
 RQWCH/IOislCN6tUzaA==
X-Proofpoint-GUID: joFoiNob3002r3-oJ_ceMBNNj36xVuuS
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ad7a9ef cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=MQF9_I5wXWLH50ZhBI4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: joFoiNob3002r3-oJ_ceMBNNj36xVuuS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200070
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 12:33, Eric Farman wrote:
> Queued to s390x-staging for 11.2; thank you!

Thanks!

-- 
Regards,
  Collin


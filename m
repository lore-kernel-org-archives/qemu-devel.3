Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DD8C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhmI-0004Oh-LP; Fri, 03 Jul 2026 13:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhmE-0004O5-Mg; Fri, 03 Jul 2026 13:34:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhmC-0003Fp-86; Fri, 03 Jul 2026 13:34:10 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJ00u3246526; Fri, 3 Jul 2026 17:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rGz3Uu
 QGYr91IPactCM/NoRwL9tdeC8xpN4eOV3ciq8=; b=d1U5zVs7WzKblY9/JsyaU9
 UITyOL+kmPEGMbROtgjR31fE5wEcnGhNwai7P8whtX2lolBNmv3JYfPsIGZt35oN
 YaTQgNQT/bsJodgWEAE7DgdnKLT5fLTSRAXDxiZEhERKhhkk7K+L12gUuZF0udMb
 CBgQE3v0GWQtGbs+j9O+OdleOY5O7b7/oqaFdSN2ZGZH3gsIM6FLBqobGzyks62b
 Of3FuijY2wq1o1Z3lL+qDIqzvgjceR1VHDWHMmHfdqvEcnAUewGkky2/pPX4BzW1
 W3tV/l4/9XkN2s9tumk7bVGsyRVyuWnCydOCHCSjI3F2duJ9Vm4CnzqiN+7ZuUMg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qafway-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:34:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663HJmeh003450;
 Fri, 3 Jul 2026 17:34:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhssnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:34:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663HY2TN28115646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:34:02 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 759B55804E;
 Fri,  3 Jul 2026 17:34:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BDF85803F;
 Fri,  3 Jul 2026 17:34:00 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:34:00 +0000 (GMT)
Message-ID: <3aea4114-1f3e-408a-8a20-f86b1751190d@linux.ibm.com>
Date: Fri, 3 Jul 2026 13:34:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/33] s390x/diag: Generalize s390_ipl_read/write to
 accept void *
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
 <20260703170032.1893204-14-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260703170032.1893204-14-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX4ZjvrOw3zPEK
 8BBxXINd1Npx2qE8YKhzm46E3wcseGh2/EmCMyFw9c/kz6ikmpx/1OxIt//CBkZOvtEc/4TguHr
 Lk8WH79uR/pu54z7dicwToxLpZArk6l3NMITC6oCa11EQJ6RBl8U0gHeneHxMwW8XFqoL4iytsS
 IRBfmCnYnpTSBQSLQfxvdlr+X9GtK9uoDbgu98OUaPfDL8T3cNQ7d6fpFjh8oPft0RyeZ2Mk3Lg
 4eTT20z6JKgPgdBQ2J4jAzBySEA77oiEZGTNmU/qNmUU1++OveKda+D6+rVSvoLlwRx4MVxxHnX
 TKBk0EJndJBAeV1CfmhhVSZJbzlgowoUREHxAtlShdXgfjLi9vwn3nRKsdhKh/UoahNv4sCmXN5
 FrbQtWYuMq5Idp3S7Y4kLOaebEnJbuLFYCKcw1TI/zTCmSwfhL/VaM4jRe5aYJxQCkmQETdDfuV
 xFIhA1q17GmXB0xjZ0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfXxJ0CCNPOxLTJ
 QZnOFkZG6YY90vLXHWcT7x8YP8mi8coWLmlvmmfOInhQ47s4NZN4EJnVtGPVIZcAICWO7EB844q
 hJCeufqueXlqWN+Ua5IldGj1n4BfaOI=
X-Proofpoint-GUID: UzwvrmBpvZgjJ7ng1HlNkHw2Gr6kDkLE
X-Proofpoint-ORIG-GUID: UzwvrmBpvZgjJ7ng1HlNkHw2Gr6kDkLE
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a47f28c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=HYRlvAy_F6ONy0iQ-iIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030173
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 7/3/26 1:00 PM, Zhuoying Cai wrote:
> Change the data parameter of s390_ipl_read() and s390_ipl_write()
> from IplParameterBlock * to void *, so the helpers can be reused
> beyond DIAG 308.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>




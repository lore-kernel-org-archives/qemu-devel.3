Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EE5C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqr2M-0003HO-O7; Mon, 03 Aug 2026 07:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr2E-0003B0-T3; Mon, 03 Aug 2026 07:40:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr2D-0002fV-A9; Mon, 03 Aug 2026 07:40:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672Lo2m4163804; Mon, 3 Aug 2026 11:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9u/4rQ
 DQ6ggHHipztd//Wc4lftgzkkFAXreSM+8v9SM=; b=J+8D2v7cVrhl9/cxa/tTsH
 mHtJhzvrpmxCCnYW0P1QHAvwgh9qhw0F0kQhwaPIqYomnkPQ5HL//BC68+toEyOw
 h4geN4kdHan3xx8OPGgaNoPyfl05hewO2QPS69eda89V5N//Xh3tz52X+v/HkgwJ
 1RYNzEOeF8gIZMxLKNNUGQgOraM2nNFQkukoDPjlh8D3N+X2fnZ/fOMDwzXmiTF4
 Qev60bQWrlC6E3wg84pzYYKypn6tXL2v/s26pPd4nLihkavW+TsQvL/gW9eleUdQ
 iFjSexJdoDR2e6iXD5pAsaE3/G3feQoOSB87QRL2sklh4mO9E6hwqsHXaNZBrBSw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hgf69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:40:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673BBG7S019439;
 Mon, 3 Aug 2026 11:40:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh53hb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:40:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673BedbA27853170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 11:40:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8A5B2004D;
 Mon,  3 Aug 2026 11:40:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BDED2004B;
 Mon,  3 Aug 2026 11:40:39 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 11:40:39 +0000 (GMT)
Message-ID: <1e1cbafd-a7c1-4587-b4d6-37d047e2d62b@linux.ibm.com>
Date: Mon, 3 Aug 2026 13:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] target/s390x: Convert op_ld16s to op_ld
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-4-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260731185628.23161-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX4e/FWBRUSG0O
 V817+r2ZvcfxCoBOPaltqjJzKN6uPuMowTaUNfaV9wZXSAhVogXZYRa4umk6GaF+CAnz8pIF9HR
 O/O3tbM4MIU/iwkZlBPPjrBYo9iCUas=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a707e3a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=vtlFLEGkmGI1kn2-6cgA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMSBTYWx0ZWRfX0m3AtvQFSJwV
 9NeoNAnwdFCgscyKSr9IQNQ32aIoVYsjESqv/OH/ebhGotSZOHcw1RkmT1INaWmv283FoYPE6ol
 9KZH0aS8YAjJ8zNrE6jX9C4iJa1Y2zU8ACObcWQv56VchWEWDtBt+pSHl9BY+Z2+u1xlHTvtWbt
 VMbMzNJrwGXASGEvt13B9dgD9gYmlKuBWKVSCWfvjX50gbCRPOOrDtANFwmJdG9bQ725XaEUHW1
 BbjJ7ZlYf8tuz6/suHg7ZCpbjzgf6m1UAELiRuCpqc75jdMxEdbTa8OzOizuq2TuevnmBzbypAT
 /aoGtQMXGfDi61e5sn5EnK5G8e4K19IpEwMjsnS3r3lgSH6qRMdIGv7z3+LIEL3Z56CdEQU2Jmx
 uof/R4FlWloUH2697dYthqLsNW/9D+kDX3vUEfpCq0qvPjGfPPKFjubn8cy2nNf64g/uH3sjJUU
 UB0OuxOczUXEdli7nYg==
X-Proofpoint-ORIG-GUID: A02PysbQjR-D1ua2G3ZlTuvPdwIM-75I
X-Proofpoint-GUID: A02PysbQjR-D1ua2G3ZlTuvPdwIM-75I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030101
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     |  6 ------
>   target/s390x/tcg/insn-data.h.inc | 12 ++++++------
>   2 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>




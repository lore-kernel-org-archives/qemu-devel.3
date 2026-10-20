Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8347606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BKnnlF0F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7x3-0001FX-6I; Tue, 20 Oct 2026 07:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJ7x1-0001A0-3a; Tue, 20 Oct 2026 07:24:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJ7wz-0003RV-Hp; Tue, 20 Oct 2026 07:24:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K1F4Sd1143828; Tue, 20 Oct 2026 11:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ncwkcD
 z1Pru/g7/NFxlQ3/oWrNQ704cL9g/vaGMjMTs=; b=BKnnlF0F7xkN5o2e60SYoh
 eRgT2F1JGXdmk8fPxY5lWVie81DrmHm2vYhz2dGBcepKGSDvICUcmpgv4E8AGW4R
 sk753tl3pk/wjyRWkBabF/MOxMM7vzLdXaTfxblIPs+HzvYLJhjbGWc+ag9MnBI5
 12lDNKUnQHP+qK+yx/HvqMokhTTHdmOHIsGIWT4fhQwKn4Yfl5Znijc15s+acS9N
 Na3Ur9UdvOxtZ0Yz+S3IWmVk1KnOoIQn94YoySUylsMa3EskQSihURV1pvbxfcKu
 sd5XGN66B9VfJDJwTcHtBnqM5Lb+P0uWrB8oNRU3jiqVzzRl2GgVRFG+OELQ42mA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a2hbk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 11:23:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KANZHS1346883; Tue, 20 Oct 2026 11:23:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he6gq86v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 11:23:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69KBNsuK52166952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Oct 2026 11:23:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8330F2004B;
 Tue, 20 Oct 2026 11:23:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 969A920043;
 Tue, 20 Oct 2026 11:23:53 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.149.137])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Oct 2026 11:23:53 +0000 (GMT)
Message-ID: <5618b97d-8b60-489d-a63e-45246eeb5d60@linux.ibm.com>
Date: Tue, 20 Oct 2026 13:23:53 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] tests/guest-debug: add --symbols option to
 run-test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-12-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261019192704.3220373-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0NCBTYWx0ZWRfX4KT2zViAtMPR
 SwhRuS1tQVAhmG/QFw5pmQM+Phf15uNudvzDBMO0mmWbW+bukjmo8s8H2/uvLxvaJey3fDLcNCr
 Gfv7sfLKlyFb9a4X3hKGKtKQr6t6JwI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0NCBTYWx0ZWRfX2aujLunxkptl
 8uGqNP7ci5IWrpWsixf9ZUsMysY0EnxLqqmfJS9A9vWNQIXPx4Hi0IOlE5xV11cgWZntCBugQ6c
 i6GS+qcAUUshjUYafzYGelve96inU0KCeH3p7eFlBPxfiUW+WM0J5jeuC8Xi7uZkxaI2wNLfuUy
 ffg5K4w/16YdbN2BqxxLutSuifyG9XsCh3jpy/CkSNbrMTS303huUqmeuSd9QzQ//2GC5WnBplq
 LXuUaIbx9OcvEeakFqB2tySqNxe/BcUmQkNAMTzWH5HVSiA0Ay2lbRZC+AZi8heKmYhZ+uJRqci
 gNPJxD87M+pTCIzURzcAfDX0YMJ2+Td8aFNMlxgSuYZyS9Iu73cyBtdoVELMH4gvPq7hKmy+CGL
 NPTXInlPa2IIHpYX2PXsXqi+/ecjk0EYuw7O6fZv7GO4sPNAoenssXpKo9f71RfUKJSFX/5g/vX
 I6XtVh7abZn9Hf5RJgw==
X-Proofpoint-GUID: laiMrkL2jTb-pJFpByyQTD7kFFdQ10Kl
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ad74f4f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=WTJAQmJ-4Fxv1vICBN8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: laiMrkL2jTb-pJFpByyQTD7kFFdQ10Kl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200044
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/19/26 21:26, Alex Bennée wrote:
> Sometimes the debug symbols are not in the kernel binary image but in
> a separate elf blob. Provide --symbols to facilitate using them.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20260930164649.433573-12-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>    - fix merge conflict now we use array for gdb_cmd
> ---
>   tests/guest-debug/run-test.py | 5 +++++
>   1 file changed, 5 insertions(+)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



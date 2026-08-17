Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81807C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvsfE-00021Q-Df; Mon, 17 Aug 2026 04:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvsf7-00020x-He; Mon, 17 Aug 2026 04:25:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvsf5-0002lO-FD; Mon, 17 Aug 2026 04:25:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLWM1J1866870; Mon, 17 Aug 2026 08:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=T+c35c
 JDoyPiTGWe2MdvCJPRqu4RnIRk2eum0BEw6xw=; b=pe7NYh7nsvrFzvW9pXqM9e
 VXYUJKlFUf49kkoy1VBWT9nje1Uj3L8efSdBavXfoiOxaWhui9I08cLSfgo8ttjQ
 /qZ+LSu9r6vTlMRAlTNINaaDbhzRKr6Ds9ulEWuLeFsIGhe8L7i33vrMahxRiK/c
 WPT94kb+NDwAn9FW4f0s7gmJzHQx0atcefu6fYoW96RheMl1HcGe+cBUDbd38osJ
 QTFbjyAr9VHMWcx/zFFiwHaTn72p5GtqS/H4FTgxQpGGb+Ao9nDbwQzxy8gWV46b
 SzpmGLF6lpDW+DDmsEfNW8OnfqfTuYCpRMdxuFZjGoHgwnwKEIas4nrBc4sGSQcg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqh5vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 08:25:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8BL2c024521;
 Mon, 17 Aug 2026 08:25:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y4uws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 08:25:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67H8PTU549676756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 08:25:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D66462004B;
 Mon, 17 Aug 2026 08:25:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53C7720043;
 Mon, 17 Aug 2026 08:25:29 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 08:25:29 +0000 (GMT)
Message-ID: <ae3197f1-d8f2-46e9-87b0-4c75d939570e@linux.ibm.com>
Date: Mon, 17 Aug 2026 10:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 12/19] target/s390x: Base support for cpacf protected
 keys and pckmo
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-13-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-13-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX8bEHcQffwx1+
 TJRcxz2aPX9OOInXcam+0VaBjUNsSR8Uwb4RUNzqHz412HNBdijJYgtcWB3I6whQpGUuvIdgxPO
 5PefbNDw3dm14+gDfSEAjNwfa8Yhrrq/JL6YV3hdvGRl7PaIyZNp2DnuNAyav/99W82fk5lBfZv
 oa/r7THt8v6x1pCWYUwubSyhAv3Zqx6NNQcKIY9Hv4wIhYdufZXGE2GzM/qDH6Txrc5GdetrHQu
 uk7LUHmG01Sh8A31CwVxxZ/B3wJYjt8Fqo5sbdDgoIhtRBfYWA349HVvURgobcG8e11X3MoPLyI
 UZuUe9dxDtMdppYUSQ8qJLneDs37TnVvSpFwBBF46r7MtH1YuXnKNvHiyLu4CIkoUiqoD2Tazgl
 kMb4ne+QaeABNxTwec+KyvwRHFvbjhy3n/2Rsbc/2dqyhgX9sPvZbLlotgq9sLu+AcoHRFtmPNA
 INHGS0ClvRRobXcs4mw==
X-Proofpoint-ORIG-GUID: ct7A9yUTMkO9l7H9r8r52V74Dfx_ADeh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfXw0VWq/q9Nk39
 RvMn9QXHwauPaiiU79grAnfNsBL5c1SgGMGZIEmecHsUT3loQSKI94k7zI9+nFlU++09UlP8o8d
 vCd2vXKd3rnIKyQt0Wxm0bl8aziEvxk=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a82c57e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=vCvgv0l5AUAdMAaF48cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ct7A9yUTMkO9l7H9r8r52V74Dfx_ADeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170059
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



On 8/6/26 17:12, Harald Freudenberger wrote:
> Add base support for cpacf protected key handling.
> Add support for the pckmo subfunctions PCKMO-Encrypt-AES-128-Key,
> PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key which deal
> with protected keys. These pckmo subfunctions derive a protected key
> from an AES clear key by encrypting it with an internal AES wrapping
> key. More details about protected keys can be found in the
> "z/Architecture Prinziples of Operation" document.
> 
> The qemu version provided here is only a fake intended to make
> protected key available for developing and testing purpose:
> * The protected key is 'derived' from the clear key by xoring
>    the fixed pattern 0xAAAA... onto the key value.
> * The AES Wrapping Key Verification Pattern is a fixed
>    value of 32 bytes 0xFACEFACE...
> 
> Add preprocessor defines for the xor pattern and wkvp used to
> construct ('encrypt') a protected key from a clear key value with
> this implementation. Also add some static functions to 'encrypt'
> from clear key to protected key and 'decrypt' back to cpacf_aes.c.
> 
> The preprocessor defines shall be used later in testcases to
> construct and decode protected keys.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         | 29 +++++++++++++++
>   target/s390x/tcg/cpacf_aes.c     | 64 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 21 +++++++++++
>   target/s390x/tcg/translate.c     |  9 ++++-
>   5 files changed, 124 insertions(+), 2 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>




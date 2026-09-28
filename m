Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232BECA5FAC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 17:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBFNR-0000bd-4c; Mon, 28 Sep 2026 13:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xBFNH-0000aG-1G; Mon, 28 Sep 2026 13:42:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xBFNE-0001AB-Hl; Mon, 28 Sep 2026 13:42:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SF5fB91269079; Mon, 28 Sep 2026 17:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vJJMH/
 RQETQi+URNvJtki6J1M1EkxI5xEeNnar64uL0=; b=WcFIFb/OEj2d0wd7tC/E5+
 tKoLQtCAp6E9ATILhW7RR2dihY6L2lxKhjlohP0dCIu3DZFZzH9j2FHCvQoj9LIF
 9MUbQAMO05/j++jq9/pbItflQQYbEjnii6CKvy09jfSCzVFygUwAo3wqe4AQZZkP
 NegKfHPOZpVidgHINmdv2hMZJaQXta5RaACxXQXWt8CGhG1FSCh3q5qjpFKLUKNA
 uuOo4hvYLonrP8Ys6cIQnb/v74+a6etA/WlTLHhLrnnTNYii2AKFqr09n3v2av1O
 8gEQETun+iRG460c1SetJZ7QR48ll2N9Up8H0zeg73v4BppH4rKIrZroODgb5dUg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk2ucw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 17:42:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SElW0T310180; Mon, 28 Sep 2026 17:42:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhean0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 17:42:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68SHgEkk16777722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 17:42:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FFD62004B;
 Mon, 28 Sep 2026 17:42:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7493C20040;
 Mon, 28 Sep 2026 17:42:13 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.81.16])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 17:42:13 +0000 (GMT)
Message-ID: <ea808fa9-2692-4a65-afbb-df5d6a51e5ec@linux.ibm.com>
Date: Mon, 28 Sep 2026 19:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/24] target/s390x: convert exception to raise_excp
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Glenn Miles <milesg@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
References: <20260928052051.251-1-luoyonggang@gmail.com>
 <20260928052051.251-17-luoyonggang@gmail.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260928052051.251-17-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wscaUkxNfxkcliZhXlVFW8tj4YOcmMPI
X-Proofpoint-GUID: likcWDpQJ6Q27wi8mXqXSJMOXXxPdZuO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3MCBTYWx0ZWRfXxpIY/Z+n7oLd
 x2LrRT7ShvgJ3cyV5kCxp+z1npY8VMyLLszLcLDn7WBtM0hhp2byu0CIUIBvVCRP3LAsQPjloIa
 MAjIi+CbB7Im+VaMAI31z6Ki7tyVajA=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abaa6fb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=HzV-HrvY6oUjtcFz-MoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3MCBTYWx0ZWRfX3yB6admBk59f
 ppEglO1c43Fu3mHsUG1ImojlvDaEA552cIbtaJFj9qprbkW7DNGrWOpb56tJl24pswDg/txqE/B
 PQHVkSPF1J8g/+vjq4IGKsQwJk8bwnM2m9PFzqX2Y/Hhm4WB/d1QWxAyfA8vFVVUytsOK8X83XL
 VnFcQeJ3rcFNzT2XvAUXLTPotOgY/I/5azfgQy6MaW/jp5hNXnbL0ymQWIfSW9aHltcIb0/dpnH
 CK4MZUODtBTy1tlLw/l3yANj2/NEwmL6LXV30AosvAmYKfuXkIfMrzP9a/Fh2/a2XpdIJ0U6QUc
 tlDh0XYkCJMRarJZrH0D7pTrzxAKWkoZmUFW/+CWOQQivirJt305xhXH2TKuZFopG7U+62nPcMS
 VY+EurVSwjuc9YmB0gugCIqrSYV83dQCzBmBNIRC1pgtDmqkpfBOkP4xIyIf220IB713yVFLYJI
 7KZ5at+ZS3bjCeovXow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280070
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 9/28/26 07:20, Yonggang Luo wrote:
> Drop TCG exception and call raise_excp. Keep data_exception. Route
> leftover C SVC execute through cpu_loop_exit_excp.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/s390x/helper.h          |  1 -
>   target/s390x/tcg/mem_helper.c  |  2 +-
>   target/s390x/tcg/misc_helper.c | 10 ----------
>   target/s390x/tcg/translate.c   |  2 +-
>   4 files changed, 2 insertions(+), 13 deletions(-)

Seems to be a straightforward patch without functional changes
(not counting HELPER_LOG removal, but `-d int` should still work).

Thanks!

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



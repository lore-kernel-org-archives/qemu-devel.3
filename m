Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA300C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8epz-00063j-Cs; Mon, 21 Sep 2026 10:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8epv-00062x-3j
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:17:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8epp-0007IG-7P
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:17:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LEGYFJ894538
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3HxZbZQjLmZVXy3qEmpYHWduMFhgbsbHCjhavpDN1Ho=; b=NJgyG9xWOYoGdrSN
 qWpBLdQvAcWEgaW4IkcorI0nkVdQ4XhdXf9trBoKO1EOX1UHLMM4tve+KtR3/9/L
 maL+/Ga6QNEvu+H3q/J8Oake9di//CgYc/0ufwuiQYN22ehSYXCuuzPR9kUi9M1S
 6naZV3MEgCeumqNrawxADuafAH33lEO3uSbtXzle8CMPUBFu5Esv/dW78+UTPYKz
 PKUT7RgJFk3bHGARnsWsrJtb6sCGse5UXyifgOSQsYulc7yMeNLBM0Lm2XbutWLA
 XPdK4wRMq0DY7DG+x6ACWi6d+QZjo5b/ZxJSqcvgACj3FigNY22GVVmKSUXu7tj7
 Hfh1Ag==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq9pdb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:17:30 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7a9378b844dso135887137.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790000250; x=1790605050; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3HxZbZQjLmZVXy3qEmpYHWduMFhgbsbHCjhavpDN1Ho=;
 b=RWBJ8nIWn2C9hRv/8x9ALxWEdhWcoTTOHX3qVjnTwRoYGZ8f3Lo02qgY8K936p3BzQ
 GNWcoWBwJUDGmsn1TYWwpq58je7sNYdwnbuD0tA6hzvY8/yGZFMyOIoQBE7TvZgij2ku
 NAEMZ67WmAAhRnkgUaJ96R5tr/wXsskqPpQv1tPgOzwrSjkWqaAf/plsowxnJcsFxBrr
 4+jCZn2Rj7zdrt/ON6C/Kb5kzFNen5Lz/AbPQWSn+CQA+bwwMSRlxJHNem5wNYfr0IUw
 k0Y5qPWNVnTdzBRhPrB4mv3oTCztSULI06Zuom0609gNerAEbLKKcxZlqW8Tqh2UQoyn
 aOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790000250; x=1790605050;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3HxZbZQjLmZVXy3qEmpYHWduMFhgbsbHCjhavpDN1Ho=;
 b=jZyl9aHrRCiWwXKDzvWIVwL+Ym39iy+fgxFLtiWx2tFMT30qLLLHQO8JRWIYmOGVxl
 afO6+s/Y1S7UfSq5T9ngTDns7JcGaAyInAbmMkWo45w0C+wu28W2NN0rUo6ZPrPOppqp
 nqNtq17m+M4jf9J5PvdxAYDnRMOLlxRDnVz9y7e+XdDWQXPQDPO+OEWhYMmreHnuPALX
 CKJZZLRl6i0S2EMyqQ8QwOiIBPoCSJHd0pNHXik0Tmd+oInI3A2MhHoeaehFfHmiwmPk
 VtK3QaSuqLvnBjTWLiStPe8rboUQyYT7CzTd6NaQpqlwOzXH37C0NQsOESe9LQ9HpWeO
 SYQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPNrh+ErDUWPkUXzB68o20yjHB0RbdReGQMvn3GRAanTh3R3W6XxOwUhqBNsmQEhvqc8qGmEy2ufyV@nongnu.org
X-Gm-Message-State: AFuF++lDH7iONs0v7L61y9ITGvrjaWQ1eCESow2x8QUiYoQXcCUtZZ0U
 ilPYHRuEZVzMJG/RBzAQRXcwp6kvtdlSsISTzBi8/lYwQeQni6/hyBXgNLf4D9aNUf7ZCKcNqT5
 L9nJ+1IeiYfWX61BA//bWVzbTJNtSM18Cmay8PghyvwAkD4cS9Z1nVHGSkw==
X-Gm-Gg: AYBFou2111GXmr5VZzSt/uyT6vmdhvs87kUzJB+6F+Jtg65JNiPGYUDjXTu1CMRnFF5
 jUvDq8GorcvG+Jg8yWscVy1Bbq4VIQHfdWq3dwcy6/xQls0swedKfYW+TsCI0Vu5ZCpNOMjMvAi
 0kWxI40QwOmkZV+/W3nyWGhmefCrLr4c3gO9AKWiU1/3dOdApYyWlVkW7NhQzVaPpWa7zc4R5nh
 +OGY64YUjGvXPHqLIuQX8OgtNW76AInmhpLyJrSZuG+ircjasouc2/mky4V3CDYfkaeS7c3DBoz
 3YDhccXUVNfGvHrGpPzKw7InicvDGlbZX7UAZ8KLp9qMGURSOGyw23UMQsM9HZCTUnipf1Jv20P
 noMwys25atshYu291WWU=
X-Received: by 2002:a05:6102:290b:b0:7a2:2f60:b9d1 with SMTP id
 ada2fe7eead31-7a55af2df85mr4550066137.6.1790000249572; 
 Mon, 21 Sep 2026 07:17:29 -0700 (PDT)
X-Received: by 2002:a05:6102:290b:b0:7a2:2f60:b9d1 with SMTP id
 ada2fe7eead31-7a55af2df85mr4549973137.6.1790000248972; 
 Mon, 21 Sep 2026 07:17:28 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd03fe55sm271152925e9.2.2026.09.21.07.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 07:17:28 -0700 (PDT)
Message-ID: <11f647d4-48ab-4317-a352-7e1f0cb875e7@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] target/rx: convert raises to raise_excp
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Nicholas Piggin <npiggin@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 Bibo Mao <maobibo@loongson.cn>, Chao Liu <chao.liu@processmission.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260918004225.827-1-luoyonggang@gmail.com>
 <20260918004225.827-5-luoyonggang@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918004225.827-5-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8qal6KFjCNZhCJqsOhfGhRbvLl5DYj8I
X-Proofpoint-ORIG-GUID: 8qal6KFjCNZhCJqsOhfGhRbvLl5DYj8I
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab13c7a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=4KMk1FrjdjcQRVtnX3AA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwNyBTYWx0ZWRfXzbC4VNKXeu2c
 xLnjTpPeGqLnzWPYbC1O8bSGACvC2W+GXDQDdGJhUhrw3mz90v7qddL5SDgAsoOhIadyvZQZXhl
 wveTmSKQOI26VylLtJY7x2or1yHRobP568yCAQY9d3/gHzfPs7dtMVfIA11zspPHyi+9R9tAGdr
 kHIkwNBgGEJTQsFrPltJvZ/TREQ+u+r+utgPrEyvD1pm4EbCzMQZ/gecjX8EtBZURDH9F8bSabg
 Pa3AL4wZ5Iu5QYmLOIb95MITHwqPRIPcvvGRy1IYKhMqCesTxzLMMrud/zU5L8OGL8Dtr6TugZA
 KLxQgfH9RtxvD2fUfABGd4gOvlk4gCdEvd2GWKYOzSUcVHi+WwPTr/g8DLESjcY2PKdxu8WRHT5
 Bz4HAWv/oR95CoZEbeN+IVNykq3VTTYl/rPwRqr1rq78NhLlScKDsh1xUHZGFzy3YTa8wAoHpcH
 2/6y+QmRiBrEKIH8OsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwNyBTYWx0ZWRfX171o5GyETp4V
 moeXcu7ulIl57BVHHVjMH0C5m3lQAZESPNAl06bPdpgAdIteOqD4svbwXIbShx0La2UzUKhTbki
 O8C11mdZlVzE+aZihNUf0Jikeeoe/V0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 2026-09-18 2:42, Yonggang Luo wrote:
> Name guest trap numbers RX_EXCP_* in cpu.h. TCG loop codes such as
> EXCP_INTERRUPT start at 0x10000. Translate privilege, illegal, BRK,
> and INT through gen_helper_raise_excp. Prefix leftover TCG wait as
> rx_wait, and drop unused raise_access_fault and the one-line
> raise_exception wrapper. FPSW still exits with RX_EXCP_ACCESS.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/rx/cpu.h       | 13 ++++++++++++
>   target/rx/helper.c    | 16 +++++++--------
>   target/rx/helper.h    |  7 +------
>   target/rx/op_helper.c | 46 +++----------------------------------------
>   target/rx/translate.c | 19 ++++++++++--------
>   5 files changed, 36 insertions(+), 65 deletions(-)
> 
> diff --git a/target/rx/cpu.h b/target/rx/cpu.h
> index 64ba48a7329..233615c32dc 100644
> --- a/target/rx/cpu.h
> +++ b/target/rx/cpu.h
> @@ -71,6 +71,19 @@ enum {
>       NUM_REGS = 16,
>   };
>   
> +/*
> + * Guest trap numbers in cs->exception_index. TCG loop codes such as
> + * EXCP_INTERRUPT start at 0x10000 in cpu-common.h and do not overlap these.

The "TCG loop codes such as EXCP_INTERRUPT start at 0x10000 in
cpu-common.h and do not overlap these." comment is generic, why
mention it here?

> + */
> +enum {
> +    RX_EXCP_PRIVILEGE_VIOLATION = 20,
> +    RX_EXCP_ACCESS = 21,
> +    RX_EXCP_ILLEGAL_INSTRUCTION = 23,
> +    RX_EXCP_FPU = 25,
> +    RX_EXCP_NMI = 30,
> +    RX_EXCP_INT = 0x100,
> +};

Otherwise LGTM as a separate patch.


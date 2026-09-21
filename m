Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B43C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ezW-00017e-81; Mon, 21 Sep 2026 10:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8ezT-00016D-6G
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:27:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8ezR-0008OJ-HL
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:27:30 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LEGbt9763701
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TBR/3aAB3jDLQPtoXps7XdaJkyXyOzC3O55vwwjgHFQ=; b=FYaqf9tCnB2U+wQ1
 mzQmSXrziMCoQhYkVepj5HqLNv58eL6sRwWJ26szIvyhnx2k9BT8T88eHJD0f9Us
 etlz0Qh5yI2Z2c8S0XfrBdFhsCjL/cKMdOu3gNoGnXg9bBryfPh3yRxK+VUmI8Qp
 SsZgYQEh3m6OeOevbVRBysOLgmOo0xVfC5BDceS0lsyue/1iK0jyaUX7Ed5wvA2i
 vnG8V4MCpLOTVKzkrekRZP0oNE/FzPIyNkXClb0lUwvGiqZTNkdd2ZFTf4TBmq4v
 No3Mjg8eGzZxVPv2QIXoFKUNhj6DY2t8Te+J9fcJYALxabXlCr5hhj3utP4bORq9
 UdwzSg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj1hy6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:27:28 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-78fb21aaad9so2950830137.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790000847; x=1790605647; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TBR/3aAB3jDLQPtoXps7XdaJkyXyOzC3O55vwwjgHFQ=;
 b=KsRMF4qUCq/8MId8RIqVjj2Y+ReBfCeK1nxlKEJYq1PKZEhExOZ6pBVc9DsbX6SsRb
 Q/P2RuAERHb8Gs/6tz+Cox9kREPMKx0gq3Gu901T/qMV7NHm/g69yQR2AoIKAbBRnpaD
 2vNSb6PixQLlReKOH6w+ivuF/NKQSnAJx+AgUevNdxz34tHhGumZT5FT5jFiMAo4Ld4f
 z3AhGEQLY3QiJpw3KOJg8ScQgyS8c0idYRQBLPmK3bWPM6NqJ9xpiyAi1VfFCImpxE21
 d3/jy30YEKVVvZriEnaQy7XtojoMYBJzeXt6DbDQBewN7cZLUc0Pdncpw8p06jLcRYtD
 LO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790000847; x=1790605647;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TBR/3aAB3jDLQPtoXps7XdaJkyXyOzC3O55vwwjgHFQ=;
 b=eICnx+jO7lehvkm7A9xRk/J3HylSU/fsTmQcgEsHN/v9d7wpGk9yMKqPwUETvdczAq
 s9iDO0FV30k+sp6Yi7Crfm1pjM5sCjApJ37A2Zg8abEjuAT9ED2MhjJc+ZdJZibzNtIv
 PEMgBWdVa1FLnBmhA3af0hJzQx5tB+2bKczxo6t1TEPeYVzApy/hV9apt5JTzIHlUZuw
 YPK9v0CACtfC2JtuKc8L+lnvBdM5K7onQz03ra/FRF+MRnyTyTJgBHRgnJ4dJH8vTj6a
 I2YH6P/WI467ApItv1J/8H5wNnVwsw7f1Xh2Vhjq+kk3CVGNSMrX0PWCvHtV0iCbs/9F
 yXkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSA0yZ/qItIpKVCeIZ1NM96RHElV/hehEn1VHkJOggTpbCV4k4IV/pWsa0kFuAqU8y9g9wda0fA8vH@nongnu.org
X-Gm-Message-State: AFuF++kUCqC3uXkfsv1EN2frTgnHCDp9qnyfEsElq+omxYMiEPZwKuSp
 WHUR/rIsfpAh9C18rKizauGIKl3yOc2Vv6crbbIcIWjzyow+HXSYkwh2gQpx7LI+TDwx0/GIhB0
 qVNuHKpJX4HLzETD/XJPTpo5a/KbTIKVvcQnPy1avUBJKc7FISqHsDePmfg==
X-Gm-Gg: AYBFou0NwiA+/5mRkdNhRKIEOYhD8Wm5Q7E+gaAiBH1eNeSWS1zZDe+NzUt98dQeBvF
 H0CfTLHhd7MWqaIz0Oo8/Mvu7ZDwujFTiymPw2w+vgUVL+w5YnV/7ZhT6ptdmq1n/9Qfpt8t/28
 qN3s4X/tbRS2tcBLCVUnHZq73RP+fcmLVsD6jkWFYRkvNklSJ9fWWy+LdB5jukqjhqDuSUJcPbP
 7nGMSdqCYT4UqDErcpUiGmMgNvs4hDZCXhYXi7qiO3Au3yT7DmVyYkZp/17xfwzQ4UGGn7dD9IZ
 g3SjXMCNIUW42oirD0rAjXtIghdSGgcrjPLQZ73lfe3HBr/7MGBvujVwUBm811TDA0os3xVikeT
 q/frita3CYxYR2Mygx+Ha
X-Received: by 2002:a67:efc3:0:b0:7a1:2076:1d81 with SMTP id
 ada2fe7eead31-7a1eab277c5mr4583640137.21.1790000847541; 
 Mon, 21 Sep 2026 07:27:27 -0700 (PDT)
X-Received: by 2002:a67:efc3:0:b0:7a1:2076:1d81 with SMTP id
 ada2fe7eead31-7a1eab277c5mr4583574137.21.1790000847083; 
 Mon, 21 Sep 2026 07:27:27 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc55cd8a8sm290505425e9.0.2026.09.21.07.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 07:27:26 -0700 (PDT)
Message-ID: <f0f92012-489f-4bd5-8bf6-af2ba7bb617f@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:27:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] target/mips: convert raise_exception to raise_excp
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
 <20260918004225.827-20-luoyonggang@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918004225.827-20-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxMCBTYWx0ZWRfX4xQm3XaBKemQ
 C9u+Vlm6qU7hEx15t4hn38FDRUXvCvGiWmNJ1vIm+wIsi4c3rBsukXouNOe32BrCnly1nxG0eWQ
 QT6rMYn01Zai+eMhEQRWMm7aE2YSzoY=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab13ed0 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=z8PmnMqlZL3EhCF4NzwA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: HtYiRtVEzdMFJAGwbY2HQIEddrDLl3cT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxMCBTYWx0ZWRfXxT7J+VTgTeQK
 D03dE2BKzHXP8YwBUx6l23gkyMPI/48icLTESlo/nVCMahd/Dw1cHX2mPXUMvDP1kqCds2EI9s5
 1Eor0W5E8sg6HdkkVWhudgBQrIb/j5jtAFEiekz1HpeVO2o89oKRKuJMshrM4QA7xF4nzG/I6xR
 PNCxZ6YjgUS+a0BX1serAIQGrV97ipcrWtIj3UTXsN5qC4IUH9QX4i/Qfx2wiyEHEvUcogMLdEX
 tqMc9tRUHykLl+UxIbYKTAE/Ca7aHIX7Cc0QOdSHRWU5kBJGFd7dkQR7kNyTl9qTaxMhmQOu891
 hcibpsNEg8OSJsPuUMcXxuwE8GswMLEZhmE9KZ61o48Mp1k4pnLCJURwYsbaBoWj8v14d1v/69x
 6J1gWxJcPOTX4TLXGB53++NQ+dGkqC9DI6Sr8QXapt98Pt97SZHE5Wkh9eyBeXCBIpfow8G/tXq
 btANG87ZjbPezvy4pFA==
X-Proofpoint-ORIG-GUID: HtYiRtVEzdMFJAGwbY2HQIEddrDLl3cT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210210
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
> Store error_code then call raise_excp, with restore 0 for _err and
> 1 for the 2-arg path. Drop TCG raise_exception, raise_exception_err,
> and unused debug DEF. Prefix leftover TCG wait to mips_wait. Keep C
> do_raise_exception_err via cpu_loop_exit_excp.

Please move "Prefix leftover TCG wait to mips_wait." in a distinct patch.

> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/mips/helper.h         |  6 +-----
>   target/mips/tcg/exception.c  | 22 ++--------------------
>   target/mips/tcg/fpu_helper.c |  6 +++---
>   target/mips/tcg/translate.c  | 13 +++++++++----
>   4 files changed, 15 insertions(+), 32 deletions(-)



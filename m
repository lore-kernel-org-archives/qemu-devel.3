Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D656AC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2T-00047n-Gy; Mon, 21 Sep 2026 10:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8f1G-00028M-98
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:29:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8f1C-0000SS-3X
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:29:20 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LEGTup2567823
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NZPsx59Nx1wIfewesp3hYcrpIVVNjWWuT9yseGXIkmY=; b=XEgI2PHLQqVIAK7A
 J0WLLQsQ666UqnnTq7FyjE+07HKNCUB8PRmRCbfSPlQC33Hw4VXxuUtht76kv5b3
 vcSmLS+EzV7BvD3XfbEL0qXSnmS4lWeYMrn5HJfVgb6wrTQKfoKi/d8k5y97HnQh
 iiZ5kbX+XoPMpmcMtsmx8NW3y153iris44UgBdM86aspOHl+Fj5yPSeU3X7pJfvG
 5JpU7qk3UHz+zf8vOHz5Og8ThuYwrqG7p0LQ1fcf5sHF0GB8u4pf36zZc1jMUHGZ
 lmkmUPRpPe/9sODzYw2mPvBpfIWGMSAE2Vg/i5qQTGP/5J/SalzVsjNKx4uGGDrP
 NyDchQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3wttua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:29:15 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98066bba118so194205241.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790000955; x=1790605755; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NZPsx59Nx1wIfewesp3hYcrpIVVNjWWuT9yseGXIkmY=;
 b=PisrWWAdGfUo/wvbfE7aX/K+HTAvBC+kXMc967Nya0p7cfLJrAdu5n3/8ag9g4DqPx
 Uc6tcFTkW7+TFTUpmlGILZYy76OlCj6wUyIiFr7MuEkuRZiLnxRUcyUJw3ZZZuewCXEN
 MP7eSjtCBkpNnbbWWJ2KYp9ItDdeOjM3mfCoon0NRP3VwcZLQ1J3713FiEIGofFePYGv
 7XUjC70cEnmY45BUPqs0fM4IY9RN0rL8RbYK2Dh7eGgmV1OUaY37hohej6HqittDihEW
 P1fUv4weckM/KNUuCMscQ+AP54a4X8ApNbZHFVyZw98TRMjDBEKdWUXoX+tRxU3MdLm+
 h9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790000955; x=1790605755;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NZPsx59Nx1wIfewesp3hYcrpIVVNjWWuT9yseGXIkmY=;
 b=Ub4vutT1ekFkz6ob1gMrzz4mNnVveXHxbWQgGQoF1zmracon+a75fjEusw2Bo18j8Q
 ObtOWOFHXbuhHzDQ2prAIwJ5rTi6IDfBWuOWvIWwR7AwM8lE0PJnENZmYWxpUbI0r7zY
 0d8Z9P6MZGzLII7ewEhqKkqsWTyXyFUsvokAIbyrkXteZ2C0H0JlMbZIbZpY7r3exSjC
 PdakcpzhHawxa9AbsBRCbn86wfMg+SXnYNEv+8nLR4Xs1p6iHoPB+KwionR0CJ0M8d4o
 K11PEigacb4H5yEUQG8/gt1/bp2XeJiZeeOR8fcCBtMmQFVD9lG2fRtm4OOezbGyxWWO
 SNhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6BM546Ya50CGtrWLNdIqPONhqsQtwVfqeZD02IqkuXH6I7q2JFOY3tWY5YWlU+xUM6irGf9m9olev@nongnu.org
X-Gm-Message-State: AFuF++kLYX5E12x0zY5vduhXx3CXONy3rhblXsUH3fU9JdNePm0KWS6q
 kh2qqAP0lJKt0iAbOvGUv3iA3ztEAqXLZzp2UUP7LOTOJ5Fh0cy/dX52Alud2WNtx24kGmetpWf
 eStpUCgx+CsITO8pbOpDFClEBGFW9dcd5/6aZT+JSr1vRN9T/vA/y4TV7Eg==
X-Gm-Gg: AYBFou2rmRUduu39GDSkfZR2xt9EXIXnGkowq8qkRtPPnLx5ddXgOGIG6iFpZsw4uhj
 ZGYqGrUMsH6jJg/wQ7hQMVefZZQ9MvwOVfnZ71x5lJJVXwLA/qq7D0C7HpxKbkCozRGykdEZdPj
 +ytHaGJ1dkqgOjS8NzHit2PEEjagQufpHnfW9FIbWPv5QXs8HZoQQKaSFk5LAXFXCXhVj1Wa7wE
 myu0yuOUq61Esn4JUebzzemmtgHBAlH9Ami88a7QXZnS+xe5nS2yCPXPBlINsjPybY7olPo6T86
 QNto+zmTR0bSQnM3DKyk2OMmYCfC3ZnUGKlGyppuxGHBoebPW5XkrJjoA1rhQYA9C9OYUfBbnBx
 C09kYKamLgKCpintzkZVc
X-Received: by 2002:a05:6102:3f06:b0:7a6:96d6:f791 with SMTP id
 ada2fe7eead31-7a696d717d9mr3388796137.16.1790000954737; 
 Mon, 21 Sep 2026 07:29:14 -0700 (PDT)
X-Received: by 2002:a05:6102:3f06:b0:7a6:96d6:f791 with SMTP id
 ada2fe7eead31-7a696d717d9mr3388756137.16.1790000954292; 
 Mon, 21 Sep 2026 07:29:14 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd1f0a061sm168901605e9.12.2026.09.21.07.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 07:29:12 -0700 (PDT)
Message-ID: <1722c6cd-479a-4ef2-bb1a-73b957b9bcce@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] target/ppc: convert raise_exception to raise_excp
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
 <20260918004225.827-21-luoyonggang@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918004225.827-21-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX/jnc7XEsmce8
 mLyeg45cKdKtvz/p80ySl0rGSYoODkbhFN0Ii3TOA0YH34qxuuEqzRerAIsNs1ZQxdUH0lPYLi4
 klWCJesO9+6n2Vzy2tUCrqngj955a+SBpCmlDUcI1zqeEp1vl+Fzo8xB+STIBoUIxkg85Hy8jdD
 A129cyZpIbmedr26EVvolfkQQbA6tqO1RZJDDE+xQwXuAHpicjBnnKYihIZ4k8SI85flFhPAKUt
 vvHTEaYvcnue1vmitE9RfrUmnQ7f6daPUXw/eFhERjFTaz5Hb0GRj4FAZwe0GjOE2ly9bSuUA1z
 OlFAofKCOvw1cKZvYRUiIeesGRMyBijBlv/HVwjbbho5ECxENAixUcfaZgZbJ41tnson61W5JIM
 hgRFWKU9QJ7T5X3OjuLAi7IRwwcdIgdJEBJRZ3L/ckbfj0ruMwiRvlTQ1kqcXSaJnNDYKqfTcdd
 DBvDd9WsPXQp+4a2BPg==
X-Proofpoint-ORIG-GUID: mQvCag0ThIGuvfDGL8U_Ei412CcbkmTf
X-Proofpoint-GUID: mQvCag0ThIGuvfDGL8U_Ei412CcbkmTf
X-Authority-Analysis: v=2.4 cv=dakVTnXe c=1 sm=1 tr=0 ts=6ab13f3b cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=O2UOSYPLqx1-oxIzoEsA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIxMSBTYWx0ZWRfX4ORDFw0H4VJd
 CzBqIWKZ8SFGuV7OQrIE8uOfF41oMhUhAktlBz3WTqJ/WGGXi2hDJDjpwJ29nG+pmQ/2zCb2GY1
 NuOwbcqQSYTOaxJACxb9dBXHTHN932c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210211
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Store error_code then call raise_excp with restore 0. Drop TCG
> raise_exception and raise_exception_err. Move C
> raise_exception_err_ra to static inline in internal.h, and remove
> the cpu.h prototype. Callers include internal.h.

You are squashing too many distinct changes (this is a general
comment for this series). Here for example use gen_exception_err_nip
in a preliminary patch.

> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/ppc/cpu.h             |  3 ---
>   target/ppc/helper.h          |  2 --
>   target/ppc/internal.h        |  9 +++++++++
>   target/ppc/misc_helper.c     |  1 +
>   target/ppc/tcg-excp_helper.c | 21 ---------------------
>   target/ppc/timebase_helper.c |  1 +
>   target/ppc/translate.c       | 23 ++++++++++-------------
>   7 files changed, 21 insertions(+), 39 deletions(-)



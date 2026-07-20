Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F5AC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljUw-0003dM-37; Mon, 20 Jul 2026 04:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljUu-0003cn-SD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:37:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljUt-0002vf-D7
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:37:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RWZk1420216
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PcyVnAJuHjGhp0iJhkLLLaxl8w00+9PdQgOJmLJT+Vg=; b=LEdq3B5igRxMrJHX
 lvLrwGiL8nag2J+XoOpU15oaPfvdfMMlDbmQEXbBThqNjk8+Z0O+s2vHKt/jdvLP
 7j0kyWBgfYcx37hoTrk546Z2VsB+KzebFZRS3Kd1ptM9x7cjA0sD1n15IDXOmjau
 PpCCBDHROZ2pX1Fw9O2Tg3ESFyhxOgSJn0Kov2dqbsB77tNMA/VpwhlwTHDZzrgv
 bodk/Hlywd/ZxnwcMbDUbL+nRZ82EWQZF7JRVKWyTkGKs010kKijWIIBEY3xGoUO
 xEHwbid9efUlR7u9/DEi1D0H65CZBR6WWDW3GSWJoXTW2iU84AcjnDaA3MSPqNuA
 jenZGw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7w5ma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:37:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso83233791cf.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784536629; x=1785141429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PcyVnAJuHjGhp0iJhkLLLaxl8w00+9PdQgOJmLJT+Vg=;
 b=QzwSTatkyQsG9y7BUO+SI/4W6/qcJUdnng947Sx8a9qI2eQMBym14l+qd3AGNMKw0n
 nOU+oVH/DjXtTBi1Rtjp6A7vJi6i1UuRjFoT5eZhJgkJg6Zu36H0f+kBoWziOcl/ZWtS
 V2EvYBzJVh4QpKK0GzuyGSfkqLIr9bed6NDuJ2P0/4KhvfEj5jcYW8oZF+v6mSJWS3bU
 akp0CoRqe7/oo3Vmj9ZRpPEcWLSvrB4TGZAnciK7VkJa+YhsRlyMtnAPJrMqwQJuCKcs
 nhrEam2zK5BK2LoO24GGfOQeqPE7ysbf6uyl2L3otSaC4jP/L95PoXjg7n7v0vsUXHBJ
 0XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536629; x=1785141429;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PcyVnAJuHjGhp0iJhkLLLaxl8w00+9PdQgOJmLJT+Vg=;
 b=qwY9aVaumMMYypni3PKhF2gPPojllJaGv3dyDimI1vDkrKEmkHiZgFHuokgdWziQHk
 PHgctfhtmvIMKZMzV6W0Xodn1I+ZOhi/PmN1Q1unuTsK/uHQ9XAxdvvQpaFBZJMj2eaX
 XETKFpYT6OaE2SO+sqIGMulRwobba40JgpTOXsK42J1gIkoiACyvnlbfjCNJrSXv5Zbn
 Nq1az7LjIkzDUKcKbsEnM5za1awy6snZqwRgXRPtEaiG02RiswtPIeercIGxLRH7Xu6R
 pFBY46tm02gU0j+sWkgFUDI0xZoxLheVS8+1k/yp6Y9Nys1svnhsk2gLMH3j9Dj8vjf5
 uojw==
X-Forwarded-Encrypted: i=1;
 AHgh+RogpSadI2IjB4XBia+0EJneKza70ExfaZ734rY+9gsVXHCUkB04GSnr3KEW5QKRi69BXcH/rpnCr86X@nongnu.org
X-Gm-Message-State: AOJu0YwwDOrbwDCOjqCgTipjjoDClReljtwwzIRnShbOk24XQP6DLQ+2
 YzdWxdU28pOpihD5fZ9xNaMMkHJ8x8bcZc8SHC4aioLEnOFOA/aCNO190+AEKQi5s0S3RLme2RX
 VvU1JQ6uDoYwcpKDqtQrnEp1CmZYyoOG5O9oE/Itob3gBLcl92snHqI5MwKMi7yFe2g==
X-Gm-Gg: AfdE7cmLR19ssjogYICpnr65yYYmRrLQVLdrfqYvxiEFklrZHMRcZRgiHuRxGuHQcmE
 mCEv+AOnQjqTRLh3c5dalZngKKbwf4cMTGj8hR3I/PefGOTd91IwrRMkNEe5dhq5LJpXxb+HJjE
 YnJHYs8Vv2CzhrZTJoLXzl2BmiojrgNx9c3Qw0l5M18PxJGt/l+VT0RZD+qQUJlwaq68VXgm0Rs
 SygYKG0obLzkIFbh8+k951Boe0xCzwZp5dIwg0nf/jRfI6CaX/M8McTezBCq5L7GMn4S7tX41Cu
 tNv3J78M5VFmk0x8H707c2yN13OwsiuL4SqQneJN1XnyGqks634pcDFrEr0GqFIq2RN0ddzmj/Y
 boZ5z2lP/yryNmZIszZa36pDTT347ZyBBeVjqCX9G7IAyzbbKgnc=
X-Received: by 2002:ac8:5ad6:0:b0:519:e3e8:85bc with SMTP id
 d75a77b69052e-5213b4321e5mr151188941cf.37.1784536628956; 
 Mon, 20 Jul 2026 01:37:08 -0700 (PDT)
X-Received: by 2002:ac8:5ad6:0:b0:519:e3e8:85bc with SMTP id
 d75a77b69052e-5213b4321e5mr151188761cf.37.1784536628601; 
 Mon, 20 Jul 2026 01:37:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563971572sm3278545e9.3.2026.07.20.01.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:37:07 -0700 (PDT)
Message-ID: <64fb74d4-6dc5-44b2-8f46-6d98d5348bf0@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] accel/tcg: Clean addreses in the user-only
 probe_access api
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260717232306.378988-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NSBTYWx0ZWRfX+NUBc16X0s6M
 hXYw+ScGAyK5+cXllgqP4qM6tJlEHXKfnRDIWx6u3RKaYdLJUponyUyiLJejdg0qmfzUeIJRs4c
 Bjbm/SAPrTeNtdbryhTgCi+AjAXWkHYHxoSYBYThR+1t/8mgpKHkKDpEzRFyKklLjFOnAMD+DkV
 hlOj2FkCB01r5nGEQMiN13/OPB6nCwUiLB0U8NBCmrxY5IeRUTPjY5U0iCMOh2xcCQrJb792GEh
 31Kj7r9DmAlCs/orL3snE1l+rOw/jlJpdUIL9ZL+KMqK7a/YV9CVJUn+L85LjpZhDwSzftrbobi
 /v0RiVVo1MsK/nEC2U01yhO8r56Q0wyu7qc60lKivGudbBWLOY6Lc6D75+2EE4RCZZylH9X/dpy
 JxC7XLQXT7v48s3igw1rVa6Fgl1pjGB6l38V43BKnBcPkxkwCEjWGCtqFujV5YPOLARAUVcL3oc
 3GOx+Iy+64eEf8KeUIQ==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5dde35 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=CrDdNXol1TZ_4v3VOGEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1lpr6pQQ8VZNauV4n_z8VVNMou4kgNIQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NSBTYWx0ZWRfX+/U7hLmFHone
 Qyc5mIKi2P8bRtOKij3GRv8YpijJ+a9mxW4fM6KttOLc649++Yg6dYlp/D11COUtPhfJfZ1kA08
 F5PIL8KxCnKhNFlL2OJeAiaqsdB7AmQ=
X-Proofpoint-GUID: 1lpr6pQQ8VZNauV4n_z8VVNMou4kgNIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200095
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

On 18/7/26 01:23, Richard Henderson wrote:
> On the system side, tagged addresses are automatically handled
> by the target's tlb_fill callback.  Allow user-only to accept
> tagged pointers as well.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/user-exec.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


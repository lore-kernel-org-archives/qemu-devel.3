Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8559CCA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOzl-00065G-Bq; Wed, 07 Oct 2026 06:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOzP-0005yS-8a
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:35:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOzN-0007oI-JB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:35:11 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jbrw2481462
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w7d61fYC3pQRRFHTc4FNB7F26lbaP9SUyqeSyI8Q6r8=; b=YJoccgwLOgVkcgtQ
 ey5BLhFhDONNimItNorcViZ1HT70YR46u/YOk9+fpDPstbBsDE8jRvXJ6jpBdh8P
 fYpHbnpCIn7YGw8X3sBeLb0AvsSXr/mrcdmbqz1wbvhPDA4LeD8TmVnZHKW6FZVp
 e61+jIC8XkbLWW9mH1Doy7++OIX0kX94+2U/THAJmh67ssRopmen00/D80gjb9Qf
 1ZOGpc22LoiYuWr0DH7Yn74LSB30xXKc0wsXiTzpBpFfQk2aGJDZcLy9Lki5mgwV
 hqYXSoCe6VhPSVfnZF1ElHywTvhhoRr1izihWPqyyD4IvbykhwrULoufYUjFCYNv
 SoVM3w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c6u1pb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:35:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9104eedb5b0so114048876d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791369306; x=1791974106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w7d61fYC3pQRRFHTc4FNB7F26lbaP9SUyqeSyI8Q6r8=;
 b=EJgs6Xq4IYfiEEfudWU0L9BDkfNdMb9Woy/eE7XvUtVSFU8zs/jtoamGTrN5qItA5p
 iNK21qVVGJFTad0ZicrJj6TjXZuYoo3Qh7hf8+fdUMujtIwSF6JCniq8hW7SACk97Jtj
 BBZBzql4ZcTJn2irB8U+FS8VpuzS1KkhpUazqKN74Zkoh0Cm9OGy4P/EcwNxyuus4QhW
 Q54ody+ggktQzDc3pM9VzpzaBvLkpybcvHSs1gv2DRT6wozKIVv1OoJ+vgQgXQdfSMOj
 /hehh5yO8uNB5LbhKz/6P+ypeS1y2x8nPvJVqc6hoghj1aWtE3kaNJ6ZKkbST9UZazmc
 mUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791369306; x=1791974106;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w7d61fYC3pQRRFHTc4FNB7F26lbaP9SUyqeSyI8Q6r8=;
 b=C1ELQxKWD2ykdN/JaDtqWoQXRtkmsXRBpTqBfsR4UC1cOgrGyIhMBT4HFRo1ikFj1J
 2EdjIVcC+tIQj6sWIh2ws7+qcGzO6h38E7LzIstYVnI44t1NPaHuYBBHc8tl5H5VkgIa
 HiTJB+CGNFc8ENAN6UIvPNRid0oPTEHrXfmJjYRyncMXw0WNBadsIMDLAhcTaQ8tBwKT
 T4J90hIOi3J2OMyx7bzV5iufjCrlQ8SFhyF+aKE9pEFeUXj4BmON5wnBbzaBahiIZkDb
 L25n2Lbh+wWg4gXCpJxA3LHejIMJ9OF0EWaWwP+MkrxdnoA4umAoImNY8yyuEzgA56SC
 iHEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOmbXb3pskkUtQtMgLTvt0PGzRwvtGcNmP7hwUcF0Ss8qQMkoV+xrG5AtUfdZFmV+3+xaKZDYDi/qS@nongnu.org
X-Gm-Message-State: AFuF++kbW1FRrs2VRPWWu49YMjEiFboDbdwY7H5VNOJRUxN3DJMAIA5m
 ogX+YNVI1YzrAYBt1VLxMsfpZSdXkjwJmuj3H30qA0ZJwfwjPKZy+VHeZ4socg0SPYJZNkQsnRW
 VwUhjixSUlh++e6FXd3YrK21QDhcw8Hi6r3vxDfb1xDnAiU0HetAQzB1yvg==
X-Gm-Gg: AYBFou0Lukc8CtPvg3pvtbhtkQS2iV6o6aQpR7YU0xccLMI10cW3HM6BTkuawXMu2Rc
 CPS9wYvHzS2odPJ5bEWnpJzH4LbZnG4gd0OOArG4ovw5iS3b1bOdo8YZV5gdq0KZj875AzFKqr5
 Orahrmn52OZg1KqvJ76z9hmpqQrmnGomhJrsVlTFUhG1TuPzJ4i/9neuU2zZcQXSYiPKvEBW9Zh
 b47Tm5uQqWz9u9TXaoCk0moSZydPU3wGwflP3RWNG2xUpGWgOsWYp5cEmScOlDozQj4O+pG0+79
 XcE6Yy4FvB0vlOfE3rBaSs6K4pbgjg1sQ2NV7SkUqElX4fXwsOXa4P4B9I7ZoD2MFb21p8Rc1Ag
 s8YOCeKtyrmaKboua8G0yGzxY3tOG3mqVWQ==
X-Received: by 2002:a05:620a:4407:b0:93e:980a:88bf with SMTP id
 af79cd13be357-93e9b8bb04emr299244785a.78.1791369306233; 
 Wed, 07 Oct 2026 03:35:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4407:b0:93e:980a:88bf with SMTP id
 af79cd13be357-93e9b8bb04emr299239485a.78.1791369305759; 
 Wed, 07 Oct 2026 03:35:05 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f51ba67sm52734535e9.1.2026.10.07.03.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:34:58 -0700 (PDT)
Message-ID: <b41b3cd4-2f20-4c34-8b8d-da80c23a6990@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/18] target/riscv: Compile arch_dump.c once
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-15-8a2f0f296a7f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-rv-dedup-v2-15-8a2f0f296a7f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfXwILxwRcIyTTR
 zfamqPgn+Zwsx2jcjl7SkSewQsu40xLsf8Bv75AR38zoZdazta9lnwSR479E03u4X/hxuB3GkXQ
 mg6R5xzl+L2ciNFjoDMnaX6MMHDD5ec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MiBTYWx0ZWRfX6vPv65CMd3Bw
 Ht/x5M2zCnJLw45qsAp86Ml84T3OkTd+o3x2UkobLnpcMT/Xm4z9pUSn0xs0qCAtwIBKaCHlFum
 BDhT0PKb/2JwSrCnzzrV2/Eg8pxfiQ157jKE3AzThNZzM1EI27hIgV5JruOwpwHMT5/p8FMrCJ/
 QmUfOBZ8JdgKDnmYl/z3FKeTMWdivwCor8J4VElKlSu8xHhcRFM2MWKUswPT17kiCf9jzZOXsui
 XBLvzKkchg3Bwot8gXZl3c8amu++0sp9GEXAEWx9zp36OHc/+0ApbdsMgPkkL2OCvERG0Af33qQ
 2Epe7jErLQTjkZcHalOyVZYOHnxs5XJY1iE4gS9TbUO5KnO3nuVeWQjU+/c42zTvhFiRC+5oTeh
 uAwg81NaX/SLUFJlwhkTg7gswo4iaHTQeYXAXESOhiysPzenKXKCEo2gEZ4nmbmFoSPACEdz5Pd
 jFP25LVV6fMLu2MIZiQ==
X-Proofpoint-ORIG-GUID: 22tV2GX0ulOmKiWmbne9zXCOeYtHT1m1
X-Authority-Analysis: v=2.4 cv=T5EZ3PKQ c=1 sm=1 tr=0 ts=6ac6205b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Sk4yTQCLnYdFTujUnrsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 22tV2GX0ulOmKiWmbne9zXCOeYtHT1m1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070042
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

On 7/10/26 10:43, Anton Johansson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/arch_dump.c | 13 +++++++------
>   target/riscv/meson.build |  2 +-
>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c


> @@ -175,11 +176,11 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>   
>       info->d_machine = EM_RISCV;
>   
> -#if defined(TARGET_RISCV64)
> -    info->d_class = ELFCLASS64;
> -#else
> -    info->d_class = ELFCLASS32;
> -#endif
> +    if (target_riscv64()) {
> +        info->d_class = ELFCLASS64;
> +    } else {
> +        info->d_class = ELFCLASS32;
> +    }
If this is good enough to link:
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

But FYI the whole "system/dump-arch.h" API is not ready for
heterogenous emulation. We discussed it once with Marc-André
and there is no good way to adapt it, since it was not designed
with that in mind, and is restricted to a single architecture
which doesn't change (word size, endianness) at runtime.
IIRC we ended agreeing dump can not be supported in Het.Emu.,
and the plan was to refactor get_dump_info() as a CPUClass
handler, if not heterogenous then dispatch if available
otherwise fallback to "not supported" stub.


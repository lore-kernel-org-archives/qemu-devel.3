Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48D6CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCOOd-00041q-VT; Thu, 01 Oct 2026 17:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOOW-000412-LD
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:32:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOOU-0007Si-Nk
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:32:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsRtg2267818
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 21:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fNPrxVA6jdhqHWg6tJd7V9jh5hOThu/3jnHjQK5rqAM=; b=Lcm5YBXKlZvWm/Xt
 hAJsxGlm8kza+qKfZe0TGGGv3CiXrIBLxEs3hk392UBjkM6bqa0+09j4PlAIozdI
 dZNIL0U73dRNFAIdlfEKpQ5LI1L5PRF33M4hM5MMb9W1MBuBEz9unOWu42Cly8a9
 zuHTs3GYMpYCY3q+yHQMTUyZ4aHlabadmLPerKyoVr2xi9if/Ms9Lak6xskM/t3P
 bMvaWWAKX2tTZp2mDArZLKUjuzv9NP5Oze1XCkmbsvzBT992gui3LcueeOC3CCH6
 FKB23WV9b9nXrNAH097whj6WWSgenCR3bNAWvcrDMjgcYw3pLazq8pNl9soNfN00
 aTvVCA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1rvqa0ty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 21:32:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34ef0362d95so708003eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790890364; x=1791495164; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fNPrxVA6jdhqHWg6tJd7V9jh5hOThu/3jnHjQK5rqAM=;
 b=ORGLmFqtJrKVoImRsxU9mfxY8tBtwtiM0OqRamY5ulqSJrgd0bsu9aTPdo6OXnFs0l
 Tum5kqmVAhh7yYwEvKi2xecCv9X3dpXOncFRPGIBo1OO7w33I19M+lpmDAfyOap0tToJ
 lTXaHLTlhdRr3qVtx7dLMkLmPcV5lbHuHZb7qE6qNz6e2XP+dbPi1wanTRxutHW9nZ+z
 rbUiCYdjUBsA+E7028wEcm7c24ePHBKcTkBMBHENdxKEWKSuxUv8RcR8/hQpfq+jHbf7
 DCYvHrB/Fk+j3MpZCtqNh0Wi+7EsX4yRMsRIcOmlcj2HBMjoEB6KIpuw+HFn6rBAk1+F
 A7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790890364; x=1791495164;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fNPrxVA6jdhqHWg6tJd7V9jh5hOThu/3jnHjQK5rqAM=;
 b=CnrEdPycmhPM8cRXiB9V8A29J+fIRHC6FfoHoaKXun118yqht57HePRe2LLQ4ONWfD
 Lvdz/6yX72PagKAhF4/+PXu5Xe8rka5qwLr28XMtanSzNgM4xc7Dq4uBNnlN0Z38Lu5Y
 sbXW/jygVKy0cmVSmBDHWz+NURZF3+kZb3Oh61BLefzUJX3+0+97HxyYoFDfTVtP1uRb
 U4EXHLiIvcoPb0SNb0SomoiQe4Sb1SAt/9zWMigA3uRNDTvVBXrhLTl1z+NcdyIq7uSt
 NP+UEPoghReQxdeGsZ0BeTxku3Z27ljQ0hvnnPbwrxGT32aui/CObbTmFemC//8rKXu5
 6gLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBySz6FgNYhROTwNhhDxETns/YnKLYvSFYjDO7xGzUSND4p87EpF/MrKTaBJIyhVfXEb1/aSswljHx7y@nongnu.org
X-Gm-Message-State: AFq9FYL7tICjhhhLZ5ypPJVrMOJ+ZP7oQCBiDyGF6X9baHk2y6j3IhY6
 VTsN500hzOQAAaFCd25KTCgyd5TKimTQmUH3BmGiGvHha4hUbcsypX8nZ0HjlgiriNsN6sqVCkz
 pWij2RFRoXdHT59MC+P+EvTz1C0Eo1plpC3UTIJE9AB3SRF/CFIYT4BQjrA==
X-Gm-Gg: AYBFou0hCU3c18ogUax8GNwqcU9YsTdAjLKfyflyk4iXH+DrNsQK3Il0J2kV5Gwjkvd
 co5EU4wAMq0oAZ2sKAcD76j8bmBq6FcxPw2W7znV7+/EUdxKcqYSognyYqFIY0byXVU28STdsEs
 M218jxqL33h+VlTPJ8WseyLu3k04IpulCJFtVOyCsxbMljIM/jOeJhmYl7XBfkezfB9IqIheedJ
 zc1rcM/PIObZBsbuJki3ha56AigXwxaAZWP9kqK9e0+WxQqXCrdvc2/LUaMlFMA8nyFsw9yMjJB
 HpxZDEGtQx+f5zT6Z/6a6bwrvsTGkYsxiqMqqe4fmlwb7oYjkUd3gnknUCLeM9zZQiuiTuqGOWm
 KZ0GaVGZhkBb1FB849NgBWJQDF7a1av9u1njX1/mhasVfXWL0PovT/Q0sgX4YdgBJ6LmJtQ==
X-Received: by 2002:a05:693c:65d3:b0:328:3944:ee53 with SMTP id
 5a478bee46e88-34f14f2df27mr667951eec.2.1790890364154; 
 Thu, 01 Oct 2026 14:32:44 -0700 (PDT)
X-Received: by 2002:a05:693c:65d3:b0:328:3944:ee53 with SMTP id
 5a478bee46e88-34f14f2df27mr667848eec.2.1790890363389; 
 Thu, 01 Oct 2026 14:32:43 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f8e9c7sm1032835eec.14.2026.10.01.14.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 14:32:42 -0700 (PDT)
Message-ID: <26e1cfba-3b26-4ade-8d19-70a17437b7e0@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 14:32:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] target/riscv: Make debug.c target agnostic
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-4-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-4-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4NSBTYWx0ZWRfXxnSr4gQRcOLl
 sNizNN8MiGfeYv8boYm9isNaOtWf5JQBJVKTiJb/81KrAOg+g/qMdurIGpM+0C3tcHtKQ+d7G3v
 KLX7i9EQX2Q/nAQxxRaguOHCZuV1/Q9LRtNeYJ9FoKf0Cfg941gowbQMKjZfN6p1J7CGIHm/Ptw
 T7SFNcMGHPb0ooh0cATmsb93Lrsvd+eNjaB1CnCQ09Cl2hA8z9So/L3m1dyMY7zLbmhiwux1twJ
 0qVJjN0MNKIa+zbqOFiznSlnkIprthufxxzi2BOWrgBujVQlnGyJI0qFC7wuy4+TUmLfg3GRntY
 bBPAjwfGvyjI9uztHFsWZSHd9xNG68BeZzjmOk0am5biMxa5xBMfYuLkxesNzaLytj0Ikkqca51
 78zHuyB5A9GZBVP98Uij3q36JG5UUweLm2atijXup5dAx5S8ag3hwKAEVhbA89eIbXZCuEIGpt3
 FdCucx8pzT9lBx8UffQ==
X-Authority-Analysis: v=2.4 cv=JIauIMKb c=1 sm=1 tr=0 ts=6abed17c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=K91iV5zTcVX8rV-a5GgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 8cEMvTORwABLR06iMe1Kgz3TIoIUSLFD
X-Proofpoint-ORIG-GUID: 8cEMvTORwABLR06iMe1Kgz3TIoIUSLFD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4NSBTYWx0ZWRfXxtcl2jZ3kluG
 66Rm3/Ocr8CbNk2+GoRnD8xK5JR/bWYslxzUUIF2J4pfqanJolxCLMaKht3KIOz5uN22RxVMdJi
 m3qhjuCmPcXLD2HPvdEcrcBdU5ia9yg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> This is not enough to compile debug.c once for system-mode, since it
> pulls in helper function prototypes which depend on target_long.
> Inclusion of "exec/target_long.h" from debug.h is removed in a follow up
> commit once the CSR functions have been made agnostic.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/tcg/debug.c | 140 +++++++++++++++++++++++------------------------
>  1 file changed, 70 insertions(+), 70 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25216CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCOIa-0002mb-9g; Thu, 01 Oct 2026 17:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOIX-0002lS-NA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:26:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOIW-0006kY-6V
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:26:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691IvpAs3519846
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 21:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +NoL16hu4mfp3PDDLKJtqZ8WrpLF7H8KBA9gmpGjjjI=; b=ZgbDDOeVpxlsPorj
 wnlNMLPxpxOSQTG4V7E6euQPdn8yZ9ZYECXvxxazplzHDj+oJXB9pwGB5hAoCmXP
 SwJfbtMi8K0ByfNYoT/d4YwdivNtesHmnwkj3IWqhF+/sR5mTs6OdBo59DrZejtS
 ZOODyNYouzvvK8vvhR5pjnODTMeZ5hWEankNKOrJGkMtb687/2CI7UHJkUukt5+C
 rBje9eUZ6jfo5qX6gcsb7SayehKDyc+Zn82gHu87wGiFNtbmSxHtqFZf1D+ktCbP
 qojk888Fu5qOlVZLTlWalisZMsL3NG44fYF9cX2th4+yo1HvfPf7oAZqtGhffxQz
 Zy+81w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1w8tgfvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 21:26:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-313d1015161so4146912eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 14:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790889994; x=1791494794; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+NoL16hu4mfp3PDDLKJtqZ8WrpLF7H8KBA9gmpGjjjI=;
 b=RBRnPCLg10lPGNd//CD1bH8J79Xo4TyCGT71SAyELtK9/PvQKksL1DAcOIsle6X72V
 X5QvzLiekJ+wpBUzMBCobwbk8H6vNgvk2aqyiAAyfED9lpyF0wnTNklki1s7O6UkZlmy
 lKsS0RaoKGXadhJd6mKzbh1oXDq/mTS/gJ0aSpjv58787jATmvKgo23PFR5Mbf2w2W4j
 E/G03gntiHRUukkdG3hCu/bnfesn8q1hThVniplZSCSKoyFJMsSiupQHbP0CI6ESmoZA
 MYlY0ZyPghBdHDgoM9zj3UkFPwINxREP5xSpTgXLUc8dgT9WKw8VbEv0WT8fr7Bp0lHW
 2e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790889994; x=1791494794;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+NoL16hu4mfp3PDDLKJtqZ8WrpLF7H8KBA9gmpGjjjI=;
 b=btdEtXHOI3Oh3BKKhiqnOVkkWVM+llMFCSfedYvSQYopPBnhlW1OUowET2ETL9/QnP
 aQYua5IUoHVRDaMm47M2AXiTqAPdIEQAs5k8ZiZCXM5IHNxiXLnYgT8TxDQ6XT1O9CYr
 b7EVsnK8DngZF3o7T4hPRlzN9rcOC9mjwV2lDf/ogecjquI89wJiEHa1Zr0gg8lNHdxH
 BpdgawimR4IQqFKRpYIM74YEwCI6/AsbKn4agu0vvZMuWKOfMyAoxVciocSYt6NO4s/r
 0yooacISBK/SeKAeBcnsE642G1IoBo/PyvLffOhICvRRfVbsKHNstl2WOQMsiN016p7l
 /BMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdc6ubj1Rj3JcuSN3sCXBqbL80YncG/dchsS9co7YE+sxYBiXSl1OXX6kadWISMinAIKiHsEgMoE46@nongnu.org
X-Gm-Message-State: AFq9FYIZdsC3VeBtU49k8dmOdhe3yNYTnJDplIfgXwg1/LX5jEcSGd+u
 mX7hGWICNF5B4nD1t7KtHl+hWJv3QMB7uGIvsZ/BW5rzgvqr5t76tHZxks4I9iNJqmoVH1d6zBF
 2vHKeduWYygMbShL6FW2w0YAB3Bg3BAO0q5h6Tslpk5UHDFmEGDLDSgJwww==
X-Gm-Gg: AYBFou32k95KSfJgjfLjpoAo01F9l5XPeirHrUPdVig8yPW6WanJfRG3XnmkfF7LcEl
 WqydZ24qJnGYmEgeNnrCIUJ2OwbOXIqJOjLwhhUnbzZEwY3FKRcqunS2wgLDOGRBFB8JZlB8atW
 glc3OmfleeFLN04tCI7tP2mKvV+P6UYDriZ7dOkjkpdn8mNP1nwot8iuKu6SXJLnv/EKtKka444
 NsY/9Mvicw2SmQYVEuMrwRIeL/apkNOBwLFmQMIiI0HNJS1TgE1VV9jXj8wjDxVV56f37ymf703
 NYGHnM4qiAiKjYiE7/kIcfhES98GFTS1a+YPKrEjMuJsPKRsR720Mys9mSW4Em3hcdhba76N+zU
 yka9URGhAjqQjUpfXF3vKembzcgHD3/ppw9kzBVOOzibCgk0z5zqq+EQMxscRSzzLlI19KA==
X-Received: by 2002:a05:7300:4352:b0:33b:f8f9:c8e8 with SMTP id
 5a478bee46e88-34f14f0d996mr990724eec.1.1790889994062; 
 Thu, 01 Oct 2026 14:26:34 -0700 (PDT)
X-Received: by 2002:a05:7300:4352:b0:33b:f8f9:c8e8 with SMTP id
 5a478bee46e88-34f14f0d996mr990681eec.1.1790889993480; 
 Thu, 01 Oct 2026 14:26:33 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14fd5620sm913470eec.21.2026.10.01.14.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 14:26:33 -0700 (PDT)
Message-ID: <d04339c4-db71-4d7f-833b-664d54f2a855@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 14:26:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] target/riscv: Move pmu CSR read to csr.h
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-3-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-3-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lnPioUqFegQNEfu7OZKq-oIwLmP256Wl
X-Authority-Analysis: v=2.4 cv=ML/1C8Zl c=1 sm=1 tr=0 ts=6abed00a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=-O1BbwZ24phnXMZMCbkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4NSBTYWx0ZWRfX1fykXzInHMiP
 2e/QxvX+hLvFfZ/6n++dKIS81iKbnGQlaPWxQydYlZzXq+IcwQx7pc+HigDbiTz51ZGm5p0rVHt
 md9F9+k4jFXkLzB6vbhZFe6y/CZ/yLbTaGTat2vkY1WgWtYTJQO3J1Pteq90Hz5q+jnwh1yaLsE
 U707vRtn/4lbQNpYKjJnrkH/UAMwXe5mccHj0cAkm7Xa8z2rUF4MvA43mafVJrln7qbNM5HzGnl
 N4w48i4dYIkfwZ5VjdHVfXSLXE3pVQcZeKT1/o0dwTxeYCCbSy1BQJHq9kJJCjafMnYVX6HRUuI
 umHMWJEKF25L5EAHkkBeyS2orpJnC72enYTaA7ej2M847Pl2rLbT8Dw0kwxHeh9hKuwbdDgQg/H
 wA4cys2krV7S/sgdZ1ItfE/O5ljv3DX57tPSYGXhqteKmUntNCBrGjvlJwalaGcjScshXTp6h18
 H0T/3NOrBgdl6OZ+5xA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4NSBTYWx0ZWRfXwFge3n2VadZL
 ExdfYecxQjErtdvful8jpVNM2pPw88PZF4Mkw8nwxJ4B/I1nt+OITfB9FQag6E2x5qqcYS9JqjW
 PYL8UWlkpLmeq+LkfLRWvTeY1JPoTb4=
X-Proofpoint-ORIG-GUID: lnPioUqFegQNEfu7OZKq-oIwLmP256Wl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010085
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
> pmu.c can then be compiled once for system-mode alongside csr.c/csr.h
> in a follow up commit, since it's otherwise target agnostic.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/tcg/csr.h       | 4 ++++
>  target/riscv/tcg/pmu.h       | 3 ---
>  target/riscv/tcg/pmu.c       | 5 +++--
>  target/riscv/tcg/meson.build | 2 --
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


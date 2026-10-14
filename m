Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDEECC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5h2-0002oO-TA; Wed, 14 Oct 2026 16:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5h1-0002oG-5U
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:35:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5gz-0006dh-GI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:35:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZkdi3468967
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3szOTeqyhIUq3M0STLpPAX7BMlC0MPmff4dJhlILE7Q=; b=UhWqu1i2Q6M7A4sm
 yTjWkOWlaHh8ZgZPjGodv7vzoKAY725MSZMVi0+tHEDW3KrEX66zyR1AGZTy80dC
 Z40Wg3yvFMmIGrl866ofXqYFz40uos2FwP8vTbwxZFSecGsJKr80t5q+rBYICdIm
 gKBGXpEMskO6Jc0uQeO+sugSEmW0riMepquo1obomqZzbBm2a49Y4otO2V57nabR
 nhhjm51QXcWPuIG/GmkDhi7YPC/sipL7bdBc22HiIq7YlGUnWX1eDqS7co8Jz3Jf
 zdRtxESPTODTDUFHCIgROsOrQFetYC1bmz2nATsFHdiBjnH98gilQ2np1kDtilxq
 lPVQDA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd78vr8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:35:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so9288172eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792010115; x=1792614915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3szOTeqyhIUq3M0STLpPAX7BMlC0MPmff4dJhlILE7Q=;
 b=JumT8hTO9bwELzn6b9g59B52Rtgx9F1ivh5eSUVsaIofqEibAkwK3ys3LHitDC0bnu
 PFSDVVvkonpK2GRFJCQx0omNuH2IsZOFiDHNk5UOlw0ieQVVuaDyH9dir92YaTRgeO/t
 jcetn7qjI+4MF0PtQVPbX/5Bux3J5ujJRE9aLOLGmItcdOz3XXCOVGKVcOCuoH+bxMdA
 of2xSAd73UayQ25/wRft4j4n4UcdRgxXabliCH8cSbsOW2fg4y2X3fcX1rZfJh7XYj7i
 T7usJv/WoKX/EWOy0Z/vhk3DzNAKIZBlz1A/lIGnzHnUOFaN1DklZSWQX6mYJo8Wq0af
 ZD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792010115; x=1792614915;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3szOTeqyhIUq3M0STLpPAX7BMlC0MPmff4dJhlILE7Q=;
 b=iOwkRxzM/vcWxJazkkzDe7YQubSELYEVHLbmfXXxtb8M+He5ohcrX7brHJUGvg2Ucg
 72Dws6UeVE0ePMzZeX8coNe+E448N183Q+Ew2nHlwgkMg4hUEqzRqofdqJWD1ETGP9ja
 0G9FtzWYAkiu59WPlQcifbPHWPtRQZ8MiAGPg/gIGDg2NWwG8eAPu7/bvFUIJW1Pne3k
 AHty+/hZSFmb1SN2k1r+QiVETYFVETwiRxodci0VF8kamyCBb/Ppx3sE4EyTgdgfTnX0
 u2GomfzcVJxYamQ555YV1OFnQmR3FCCPWZFQJ39Rb4fge9cAC2FPHlFAOiY/qioRVKrq
 pMBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYfwO9Q3lM4WiXrUIIpVI1Pkv8QOt8FG+5p4p1K1pIgfjSlzVXE11IkNwoVvm2SDHkScgQYweQqQjE@nongnu.org
X-Gm-Message-State: AFq9FYJJOzCluDq/zcV7Q2Ln6JVwOVEV3oagd+nqJ/YQkmdPRYn3qSJ/
 9gUUtNPyDrecpUPh/e47Pig5g4q0PtPvycP2huuaOnaIu9Xlutje8xaHmc5NAQ1ihIQ8W8h802f
 KgyLGgBIw2SNRorv/3Iw0jfCmg1QHWB1uXfoMRa5FZFWohrDpUx7EMIgvMKupqPLp9Q==
X-Gm-Gg: AYBFou15SwpTbWz+0AQ7ESB5/MmsSG6qTpSfKSa8SLkjLtV5sdDO8phO7K0U1BbBiB7
 p0KGfZopipBsXMxCtyIj57ZKz3QJpgICKt/cs6zRpWAkJpPnynfrUAdZQTZLsuLzzXEuRqOU99g
 tQL8RvwGye9oPYJieDF6zCAoev55q00ocxMT+++VRVxSX+kIVEK0DlQ5STwdZptb2Wzog0zBO2+
 QLyAxj+bGGdFipc15oX54GkQO3zjzv94rm4FByTYqaBPVRmC4hT6bu/+NyPy4W0QYalGdQiwnWj
 aSqtBV0QcvX2NEYO8xIPbcsRtgHyALoEmCAVA3bmO2s2Euphux2Nyst64R8biJXvRNQ6tyaQrHi
 Yo3FmLd922peN5Z1lsHkbiSdAOdFwmsMa5/n3DvwNUoYPRQbmOFQAyFWG1lOeLLee75X4gw==
X-Received: by 2002:a05:693c:638e:20b0:351:7bdb:6eb1 with SMTP id
 5a478bee46e88-3537e03ce72mr22642267eec.11.1792010115062; 
 Wed, 14 Oct 2026 13:35:15 -0700 (PDT)
X-Received: by 2002:a05:693c:638e:20b0:351:7bdb:6eb1 with SMTP id
 5a478bee46e88-3537e03ce72mr22642233eec.11.1792010114451; 
 Wed, 14 Oct 2026 13:35:14 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b53dsm51103915eec.6.2026.10.14.13.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:35:13 -0700 (PDT)
Message-ID: <5b17d85d-f25b-4430-a757-3609590a2434@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:35:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] target/hexagon: add v83 trap2 and vector stack
 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfe783 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=t3gNrLVchARdIZDrPOkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: vcf4vxdG0Jn6qyq3Wc1T49zWLjNwqsVo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MiBTYWx0ZWRfX7PXrFs+Ee2Q5
 fZ+WF3DjLt8+hXbf8aKuc93N3PkIju/Q0l40pn6opwDgFOIXv05NwHU5ZytYwIFIYOy7Ob5ZCU/
 qf2SCEnB28kXzvBksWWGeWXmHk0CTBkyVgo3yHZfuu4FgPkh8sgAxd1N4SLIF8/von3M/OtQHcs
 6hGZSzn7Q5oc7kCcq1WBtUynVwl5wE/Xmg9jaWyHZ6wej+U2D6/TshdHvib1sdTtaA7kIDD+EiS
 Bm2RS6kHbpyUcHsTalEvh1C11CqZlJv66DpObLhYDtgYmKCatFV8NMWiY79jInR3Uthb7hFO8UX
 8TKttzy1k1NNn/k2Iu6FItOWTLVlLbQpSxnyX7GLY7P4IThGkczfFYJ+vAxSbdHrihHN+loUsc+
 IXUZt35N+5+Q9S2tx9sCAPUXjOk5ahOLXXacHsrotML1+Qfgso8gtTeVx7lHpJOzEvEpMjGIWhZ
 dv9EXx376SiBMUf05ZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MiBTYWx0ZWRfX/rtcci0MCd9E
 nQui5PVF/9UUAsTuZMRwNTlDi1UKivwQ5EXBZvtEs/dA8GbKLoHENLNf9LTFkLvsZ1lGfA860Hp
 xndgrGLqWRSH3vxfmspb0aSbm3JKZDs=
X-Proofpoint-ORIG-GUID: vcf4vxdG0Jn6qyq3Wc1T49zWLjNwqsVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140082
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

On 10/14/2026 12:52 PM, Brian Cain wrote:
> Add decode and translation for trap2 and the vallocframe and
> vdeallocframe instruction forms introduced with v83.  Model vector stack
> overflow as a precise exception and report it to linux-user as SIGSEGV.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h               |  1 +
>  target/hexagon/gen_tcg.h                | 51 +++++++++++++++++++++++++
>  target/hexagon/hex_regs.h               |  2 +
>  target/hexagon/translate.h              |  1 +
>  linux-user/hexagon/cpu_loop.c           |  4 ++
>  target/hexagon/cpu.c                    |  2 +-
>  target/hexagon/hexswi.c                 |  5 +++
>  target/hexagon/translate.c              |  2 +-
>  target/hexagon/tag_rev_info.c.inc       | 10 +++++
>  target/hexagon/gen_idef_parser_funcs.py |  2 +-
>  target/hexagon/gen_tcg_funcs.py         |  4 +-
>  target/hexagon/imported/encode_pp.def   |  5 +++
>  target/hexagon/imported/system.idef     |  8 ++++
>  13 files changed, 93 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FECBCC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5is-0003b5-Iw; Wed, 14 Oct 2026 16:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5iq-0003an-Ke
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:37:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5io-0006hx-Vg
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:37:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFpisK1672397
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0frqxNI6HLyxoxkLXpE2gwSFDsRMhpMI+SRiL7xOsks=; b=Hlab1txchqtn7V4B
 bkgMFl34epvOUPWjGlfz3EVt9E0/tolQoQp5oxKnfpN8rO/R94T0QETdiMejBpaj
 zR7vL4g7m2LV6dSj8zW8/qA3Pe64ivXTKKt3IbLCN+gtchb0n8QtemF3dgN1tD14
 ck6AmWsU2Oo1Fdo0Z3G4LMr7nrSHKGtc52v4tcsdIAQcVAWdR4JDpwuaGl/Fht5f
 od/Hby+aSUVTMrf7SrJuwBaiasiPc5ueOR3j21VkdsTrH3SZHyFJMD/cnbq/UbYG
 kTL2nTJ6RCoWabGoSTUBULAYC66DWDfGyCZk8gCGLqt4O49OWJmzrUohTlDtw7lq
 V+6iuA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrh91vv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:37:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso9675564eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792010228; x=1792615028; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0frqxNI6HLyxoxkLXpE2gwSFDsRMhpMI+SRiL7xOsks=;
 b=NOmk7vLPctegM5COwGxWe4QO3dhjnZoJ9X79tg1cn4i9BMfYA2h9edGtE3tf6AaxyM
 bYEf8Cco0ZZbwLejADv3XNWS2iyga9UWMeY3aqV82kI0Nb25T/56jxu2wPzLj0QrpS3R
 do1aigwW9/rkI+B/89RFNwZlAqODiD3xIe5YDwWTcUgTINoMu0ey4BeeB0UsJA+LWo+e
 3FhDloHsOXxKYLZZDbWh3O/c4XlaDEq4CzGSMqK8iryFNFoM52LgOfVj1oK1VobkCvbw
 GBJ2y5hThSw8d5CIO7uoJEPktLCYT4aOPN5GjxhhERfZ9H5XRqFiMPVjBcE5s8o7PPHx
 dUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792010228; x=1792615028;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0frqxNI6HLyxoxkLXpE2gwSFDsRMhpMI+SRiL7xOsks=;
 b=r65mHZ0VvMDauDsNKoBqhHUbGvI4UF6gPjr81ypLrJ6sAQloPBeX41KqMOQSyZ+ueo
 /KirC8zNwtUoSMt/1IoO07zgUu09DQAkIsmEamB9dgTb89W007Bp5ZI9l9NtwSLOdy+W
 ZdWhyYlORARrK0lDJ3NWj/bGfDfUFzNtLOf+WSu28BvmwzbH0RdmxWgg6d6QPGRDR8+8
 fhwnvc8nseyMgELdYiirh+ELOuOgBmusH/6xqtPh0LNFcFmR3QVK6DiFf+ctMNJbs8I4
 o9Eysv11SsVzACSIeC6/VTM4ccXDEMwTpELPO+GuHHEgP0BM7y9ow+t2rkkyG2a5u6o8
 c1tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUKoLgdINURIuqC8EylZeCh1OXaClONRwIKzwJ1hUXr/1Lo9gIVm0lSEs5d82xR/B+UyHHAisw8Cgd@nongnu.org
X-Gm-Message-State: AFq9FYKtGwQKwzOLjhK9b/hiLrjqFwIK6MTFYOex26Sf977PEyF2ZeNX
 c9x0bhfIUGcxgkrNUS2YHDyf+OVUzDBBU6YnalYXfLwLEjIL9s0HDjMbzb5EPfswfOloGm3OMiw
 lgbt/HSe4lH3gWB1bKGsvmkqrn0JdHbbIn9ZphOtwKDf4wRRtcuyP9/QsLA==
X-Gm-Gg: AYBFou1DCciuOIR0ZbeneRXrbvFT4ClehwsEwwhERJyEa3gRu/ErqyzSQ8MJYBRqFex
 HnT+7ClSwbE1QWIsicblrZr6f+KsvzQk/rKYyTMG8Uh2SAKLOS7S5n7eNV8QSabfY2yqackQv5n
 6FoWlFJ5QiYr+frRkAUbk4YGcmKzeokxTCDrfGqCv83yf0SFaKwVcKGg6foSSclVlr63YPSWqb8
 0R7cX3xRamUKDVc/PkjCtbRCGv9NcYfuypAyISw8H18FwoMTJFBpNdvPVQakNIHzB7NYEMidoU/
 2QUTSZg+ZTBzl2+jGJOUgK35GI5kPF2eNiSgcm3AFz6M1n18zlS/1aUg5/dNbis67fUwFkBunfX
 WXAqgagdl8frEHNYKDvTbtJ8XN2KPHX6a2MKCQBvI7kSQx4RLzPm61RtUIAAaex+P4k04nA==
X-Received: by 2002:a05:693c:895a:10b0:351:1e72:7470 with SMTP id
 5a478bee46e88-3537e04414emr23400848eec.13.1792010228049; 
 Wed, 14 Oct 2026 13:37:08 -0700 (PDT)
X-Received: by 2002:a05:693c:895a:10b0:351:1e72:7470 with SMTP id
 5a478bee46e88-3537e04414emr23400818eec.13.1792010227484; 
 Wed, 14 Oct 2026 13:37:07 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35f0c3bcf80sm781050eec.7.2026.10.14.13.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:37:07 -0700 (PDT)
Message-ID: <2f00d1b3-01df-4b06-bfc0-0482e2137845@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:37:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] target/hexagon: generate vector frame instructions
 with IDEF parser
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014195223.3233623-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: naSlTfWVljxpPEDpw1LTEVdDXx7A7yic
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MiBTYWx0ZWRfXzPyl+f44Ja4T
 oQ/pwckhxIMcT5mFuIhCpCGlvg6SXq3TCKz0B164lQsV6yHpibBXFA6+adTU1XO1zw6dpGVhyp/
 Sx78r9WHniqsWUhSNKAPnQTcBoccjGE=
X-Proofpoint-GUID: naSlTfWVljxpPEDpw1LTEVdDXx7A7yic
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MiBTYWx0ZWRfX8APpQBloM+3Q
 aLJAN+OR0kF8L61RhPi/SkCHrlGuAideUy3I1OjwpXNFrOaFQ/kZE/xe9JfCH3tm4wARpWP0j0A
 tWtpVueTU72dFOnMD/b4v6f/GhzWF2quX0x2nYkL3uchm+HFct/bKpdj8eArYUdv2Zoixw26eIS
 SP228tqBgM9CcVe5Nl8RmMpQyLoKuLTvEztHjI0b6mcVxOfXD3sXalgfSEEK1EV0egqX9ipXiu1
 xYVdCOGwcm5E87G681XL+jWK6CIhAViz/nYGUNd6eRdsXDuhYJoerf6llrP9w1H+0byUotQoxbp
 fI8fka8Hmw4s1IxQYemAlOr9UZ+8zt27JKlg3DbxuA4q1RKTj0SoBgPT8etNGf3+WpdpCGX5MCH
 kHlmdAfBvQxMftiMSSoSZmbHjWsvBr01xsckvvIQN9ndfdcfobl8jyLWf0wkWr96cpbc6hWSGNG
 ki7KjMlgyHQdrC//vGw==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6acfe7f4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=LPp_mzMIw0HAbkSTvhcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140082
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
> Teach the IDEF parser about VSP and vector frame checks. Describe the
> vallocframe and vdeallocframe instruction semantics in system.idef, and
> move the vector stack overflow check into a shared TCG generator helper.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h                    | 51 ---------------------
>  target/hexagon/genptr.h                     |  1 +
>  target/hexagon/idef-parser/parser-helpers.h |  1 +
>  target/hexagon/genptr.c                     | 21 +++++++++
>  target/hexagon/idef-parser/parser-helpers.c | 14 ++++++
>  target/hexagon/gen_tcg_funcs.py             |  4 +-
>  target/hexagon/idef-parser/idef-parser.lex  |  8 ++++
>  target/hexagon/idef-parser/idef-parser.y    |  9 +++-
>  target/hexagon/imported/system.idef         |  8 ++--
>  9 files changed, 58 insertions(+), 59 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


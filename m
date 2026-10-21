Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC5606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 04:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pW/1SuN+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VMMxDtdn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJNrA-00050v-Bd; Wed, 21 Oct 2026 00:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNr8-00050J-P5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 00:23:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNr7-0001Be-5P
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 00:23:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2FDsS2392487
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 04:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 miim/zFSBLgnNpLIZAan8l/TivKT1Z7xP9RrKze39Xg=; b=pW/1SuN+8hXi94wq
 5qIZ2rkHaO5v7ReH+cJbe8+kthOe8yOlUMa7JXqxua4fVQN9xXRdmoyETDd1bDLk
 L6Ynppdvg2U049PkvEXPq9oGPbcuZagKEadZ1F3YKKKtv8WGcjKnCjaWwfBueNze
 hRHSJuJUGOUsc25OkcaBCE09CMuKJAsJ2hl/B/wN3ElPNqOcKM+v5NOP5pm31eHB
 oAQvOmVPb8wyTBveX0C8zVxVPpL+8m403BOQSoTeMt1UbPW5Mqj4okwm1w0DMJd+
 UhX9MKFidoFUg0duHc+5GHV9dXrmbm0Gp+0JIPh/TrGZJsMeGm1n311kh1Qj1u2H
 XIR2OQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb99qbv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 04:23:10 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b8c60c550so12000446d6.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 21:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792556590; x=1793161390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=miim/zFSBLgnNpLIZAan8l/TivKT1Z7xP9RrKze39Xg=;
 b=VMMxDtdnF5XFG6R8zQKCsVAZ6gBY5DU83NisRLzgCWi4qfCBcVoUqVioAucu8tcyo4
 E1JfdZB96+wseHoDMd8bhxiElSdmGhAR2SVnjWK9vcDltpmHktWf7FVBjfxU5eWgTWKA
 5daRy10A0JZfAtz/GKIWzrJ4Nrr+jFG3OxLO1FOdOwBnt701CvjgP1WfnC3h8RKt9pua
 v1f/P7LQD89lmIFdYpiIt9bA6HFClJ16trUHnvAECHJOnUDjN2y54DnM5kSgn+agt1w1
 uyUj/gUT09ZfEewnHp+Bn3/JqyvXIIfkVqitXEtckhrQ8ZpawXsW9+nPud1A5qyfFjs6
 POAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792556590; x=1793161390;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=miim/zFSBLgnNpLIZAan8l/TivKT1Z7xP9RrKze39Xg=;
 b=GqiORZVqjTG2IznEpaQYZv5lB/B9TxqbfcdZJhYLAglhOZHgNnKmHUoZS2mXFrIFbE
 ggHOJMRP0qvvqm0zfGLFHZGw7+hutAx117/dR+hKOE04c69kZWowraLG+6e3N7a8Ma5j
 cTiPspvZcvCEaNWeyv7PN6TADmgpsfBLLP2D7jduscuXrbAxddRVpxWtDM45NdYsnoWA
 dzVWM3mELZDDaYcuCghyEVlHQUmEcMN2yIQ+GnTMFr43pBuFA6z00BJibFqK7GpQ5bsI
 c4QuBU0mEHp78Zg8baYYJRRqTj8DuVGYOBw7nifQ8vDDGdHQe7vMykhDNnyZDwX2jOPX
 2FaQ==
X-Gm-Message-State: AFq9FYKPSQe2zbtopEiRh/8ph8RCGPF6bfnd+qBtJFn+f/lWe1GyfLJy
 qUCrMix6cRWvcYr7y+djpDpbVNKI0C8EatUxk9dNGgg30+LgBNcpoDhrDc2UeOSNoQi44uhLMJu
 sdyHfApaKZ1NG6b7qffORxX+V61J9D3yZhYtIsOFLEerU6Ax+Yh/5kW8e11sS+MeyM5iw
X-Gm-Gg: AYBFou3ec9xtmW+2qCTISbhAK698E4sKOEZPSHP6Cpc1T7VS09umYtdWwvpaGhr1lAx
 3nGKR+lFEaPeo1FuK/G9gwWpzIFIOcHy7LKOmY4dktD8H8A9WbOacKWZhvsLbdHyZaXP312Mp4b
 VqFCj5J+6Y4PR80zWlV+bR95jyYqyezGsBHZTbUrlBQx07MFooB/Z74LpaJ8qrOhrCmb2LB5XKH
 RAiMe50EIFi+7BBLpdu969hVzT56nB9wEuM13j47WsF5I5gKs862tkbvEZGYMZdy8vlFJzSvWma
 IN4fHaKQDB3p14spxhpHRQ0KjAHdbOHh9o1GVj+KW3vsMSqdWsfBsEwtjBE36DHd1SLHWlrToat
 Cpr4t7waadKMlOx6cTWFzl4u6dc689W4DVg==
X-Received: by 2002:a05:620a:44cb:b0:93e:6f43:b2c1 with SMTP id
 af79cd13be357-93f57f05ba0mr242591085a.16.1792556590100; 
 Tue, 20 Oct 2026 21:23:10 -0700 (PDT)
X-Received: by 2002:a05:620a:44cb:b0:93e:6f43:b2c1 with SMTP id
 af79cd13be357-93f57f05ba0mr242590085a.16.1792556589685; 
 Tue, 20 Oct 2026 21:23:09 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d699dasm129882825e9.12.2026.10.20.21.23.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 21:23:09 -0700 (PDT)
Message-ID: <36a3a000-ba50-4c11-8903-85fb70caad5f@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 06:23:08 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Remove NO_READ_GLOBALS flag on
 saved/restored helpers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20261021041310.26960-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261021041310.26960-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNyBTYWx0ZWRfX9cUWY0Eie3pT
 thWkJBi8tmX/bBQ90SD0twbUtCeMOPQ3IYr3wvAqbDNcL96ib9jK2psdp9kV5p7I+6gAfl8s8vL
 Hc5djCJDVmU4vVa0wpAuQt+ghpBWOSY=
X-Proofpoint-GUID: btMT1TrevlQVv0qS0gCAsTAtyE2No9oX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNyBTYWx0ZWRfX9F/xoNyM8Scn
 PjuMz/DAXDSD9pAwoJNBm09as6NQSoS2hyRbADsq4g4WHI3JN39RDSW+LAXWrcAeLMrCQYfIIRw
 8JXAUhRPlX5206KFMFM17I3uK54KWvHnmxFTZFnYwJl9G82g/QNlVSHcSLOoxYOEWKuPjVQXTkc
 YRc48eMzYYrpEJDwXsRZ91U1qbqKRasd8SGhZ8YrrtTW45P1Jpjz1l6HHiR9Yq2YPBaV0cn/JMa
 JJrhl21ePeMyBvbQf+nBaOqO8uSSBEZ4oxQDPdBwbgpMZQVzlApudpx6XEr3haZYCNyhctzTxAA
 ird3uGKRun6WPu/RyObAnNqb1yjOSNvn/fwgG6JNHc5mgH6c+H7MG9JoVsNO7pdjUPI3FFLq5jg
 Lv9BY+RcicAfvfbfHm44zazoOLGJJq0xWo594vI1/IX80D7ePELAcvPsVAl0fD6RDs1F4afHuc8
 6fWgY/LuQP/8m82htlA==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad83e2e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=yh0rKsGKyCbWX5GY1zwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: btMT1TrevlQVv0qS0gCAsTAtyE2No9oX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210017
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/10/26 06:13, Philippe Mathieu-DaudÃ© wrote:
> The NO_READ_GLOBALS flags are incorrect: helper_saved()
> reads env::otherwin, helper_restored() reads env::otherwin
> and env::cleanwin. Drop to plain DEF_HELPER_1; the helpers
> have side effects regardless, so translation behavior is
> unchanged.

I got it wrong, env::otherwin and env::cleanwin are not registered
as TCG globals... Please disregard this patch.

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/sparc/helper.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sparc/helper.h b/target/sparc/helper.h
> index 4be84622c89..758fcf2ba68 100644
> --- a/target/sparc/helper.h
> +++ b/target/sparc/helper.h
> @@ -11,8 +11,8 @@ DEF_HELPER_2(wrpstate, void, env, tl)
>   DEF_HELPER_1(done, void, env)
>   DEF_HELPER_1(retry, void, env)
>   DEF_HELPER_FLAGS_1(flushw, TCG_CALL_NO_WG, void, env)
> -DEF_HELPER_FLAGS_1(saved, TCG_CALL_NO_RWG, void, env)
> -DEF_HELPER_FLAGS_1(restored, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_1(saved, void, env)
> +DEF_HELPER_1(restored, void, env)
>   DEF_HELPER_1(rdccr, tl, env)
>   DEF_HELPER_2(wrccr, void, env, tl)
>   DEF_HELPER_1(rdcwp, tl, env)



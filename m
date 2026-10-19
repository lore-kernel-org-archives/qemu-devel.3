Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DE606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FoZFMJfJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kUYkhCb0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuzv-0002W8-QW; Mon, 19 Oct 2026 17:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuzt-0002VW-Rl
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:34:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIuzs-0006wc-52
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:34:21 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJwTp3103319
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ng0nsJTFAzM4cwNmFZPVKvsBub2anS1vhxKPjm5SdG0=; b=FoZFMJfJ8KtLKjKk
 seKyyowz3p1Gi5IqLKO6RaSunQklope2aSAd/GXsHOCcy+8BR4DE+Sim1TwC0vO6
 VphPovboStw3cRW65RotRJzdiDWqtjbMvD447Qcw6NSEkNXZQWIzWxeL+lAFY0O9
 +lCUSq5E78XAbG/7Ar7aEwTv04r1pMwWprfNRLcc38aC6InZF+AQ2JvrXhJ0La+C
 KxzKb2h8hDEhN8iWDQqNI5UkqGsOydBsPkuBkzy4WuaIgiIcD4IrMA3iQiyk0L4x
 8vX5D083C6rdTNhJjnPWn8pXZl0lHURakzrmzTp+m2v77Eh+n1/oIFeZUnjRX/HD
 y0WCuA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q0q0w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:34:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3580c07911eso7428416eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445657; x=1793050457; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ng0nsJTFAzM4cwNmFZPVKvsBub2anS1vhxKPjm5SdG0=;
 b=kUYkhCb0qZXMSsFlGD5wTQu3W05MHLCKuzZfxLBWLdenuicu77AtxUZWPnJClB5W+n
 4cTbfQIFLLcZXAoIXR53w3LxAdcBRV4xYn6QZLbASXX9xqzo8hVRq4mr6E5ifQByw6Js
 Exi4SThn7sjgCZS6oPoS5bE1gkV/sKVPVMAj3wlql/36NEy/z/EP5BROnWf1oAu8D/LV
 9MFEqKzaSbOHub6ThlaRcnC7rdfoiA3sFJXsevPtrbThJXeDy4JA8KV+hQzBk6CKZRuj
 cXOu60b9eUZ/sUjnRxdie4uo3rIHYz/uacR+MfmOS/RZTNQpMx4Nf+44hf8y9EiqFIJP
 pSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445657; x=1793050457;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ng0nsJTFAzM4cwNmFZPVKvsBub2anS1vhxKPjm5SdG0=;
 b=PDp4CkMSAiMHYuPtyuHXFlbPlKPTPOWFv9UGz20yqdAou/ffctBqo1pBoH3JWZ1auA
 s+C24aJikf/kP9HErcvmHp1Yt7UmAb7oZE8xjRe/nEjU2CBNTv5lhGIlx6CkvonIo12h
 2MyRn/1FWXcDpjD2b5cUUUw11YJP4bPJzA2GVB7sVZLmXbwaa9JwLyDCILYfQ/xUzwxq
 AT80NgzSBGhrKRsDNyE/HeT+wltGeSaX+30TzxFg8GPlwF9kgYfAQ7LLWE6SkkuUL/Q/
 l0slE5W9uodiv5ipyE9ZS9kQnzUJ1hjfqB6y3PmZZzU0skd+wXKEdAvRbWoos4fhm0c5
 iczw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzelgBCw28sFQofOd3nJisuhxEMGvcFKZuQeZRUq7N9J74m5QDVU0g2l10Na7Qs6lQ2vD936NceEE60@nongnu.org
X-Gm-Message-State: AFq9FYKSi5YIhy9/pfMIdnSB7DCiTDxLXzE54JO9+bRTspEL305KRMx0
 u+jCHV6dMMEDCJ2dCwl5hLKWLpJ6J71OviMLi29FXuz08llrqUUoRV+36VWgXK5wkIuwQ62bRIT
 mYiTwPyjD5V2qpqyGCS8HgSCOHTh616PB87UzeS+DgIlE+u4zybiovsafXQ==
X-Gm-Gg: AYBFou28B8MccZlzqAL8zgOOaBi8/K5WQY+ii6GhZdBnq5OpU4z7sgOFzyRUzUM3K7z
 R1+4GAzlUTvgWJu3Zg+/uc/tsXgsGMsBKridbyzoqy8LqiYLX1nDDmEaBBx5OIr2NjPiuj48eDN
 UrQYp2mOL8gQ2wBM9fWYyDPobBDp3L2KtLUomJ03VtqNsPbpf4XCUX6lj7nTKflJrbUnDlxgHNC
 l1u0umMaWBRVgJSDTFMusFErraVF1dOELPyK50Uo11mfPjQ4e/IG17ZGplx6DvVTjamYKW4OcAF
 8Oc8fNwBEnffus8X5FJlNDdF7UKxHeTpHDVfzQz/AlSyW06svjYT4MiRauIhbMOKR4VTeG40HcG
 mfvSaYfLo0xlQMVW5ydm/hePoyMXcj0UN3q6KWTsTdHiA4bZuG0gcKj3GXAhmrm/z6E+CuA==
X-Received: by 2002:a05:7300:7a9a:b0:35a:8dad:6724 with SMTP id
 5a478bee46e88-361a1f495bamr12810256eec.22.1792445657400; 
 Mon, 19 Oct 2026 14:34:17 -0700 (PDT)
X-Received: by 2002:a05:7300:7a9a:b0:35a:8dad:6724 with SMTP id
 5a478bee46e88-361a1f495bamr12810232eec.22.1792445656813; 
 Mon, 19 Oct 2026 14:34:16 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082784ec8sm32720033eec.22.2026.10.19.14.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:34:16 -0700 (PDT)
Message-ID: <667ed637-cb4e-46b4-878d-5a1571542750@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:34:15 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: assert qfloat shift
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20261019153558.2422277-1-brian.cain@oss.qualcomm.com>
 <20261019153558.2422277-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019153558.2422277-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iYuNPOI8ngaqhM2dpjygsFL22y5lTccO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXwF7/u92wBbrq
 qYk7vG65cJa5YShAFXCBjuYg0W2ZLfMSyYHxgv9/G9jg4Hdi3ikU6FasJbdfDa01GBSkGR+MYZB
 s7H1QxhMsRj/sn+p+vDPBd/p9U/2FmE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX30PTofmDCBvs
 k/D5k/NhgHVxXrHPk7RrRf5KShs+GKzd26w4X45qe6WHbltHYLaw63Q5f5K19+DkSSnzZLI3piQ
 rbMIZUvtGmVc4+D0z+4swkR723RHygngRKn+ZlRyDXSelZwXemoSuxvDARfYagtQLjEG5w4yc0q
 5Ok7b+eNX3oiDo6/I0PxUq8HHy559RfFr31e84cn7F+GHJP/CgKzRUiUX881Hr5sy/KJLnrxsd+
 +zVoMAcRGMGlH/wB+4LmjWyb9Y4tUztjG5NAG5HHk2uoHwVkvgYTlsf4bkne9WnglNN3CLn4vSL
 XhE68gHgR4WoUuMSywTy0GHYaWJEir8yVyf3cdCild+XWlza0o4KnB6pZo12PREjNzoTVuNf/oo
 eyusOJ2GAAVEY0dAE0Ka1CVNAwfVdMKy8jotiNHzsuiuRknJYeouZ4oOUsIlLyE5SjTyJDH8cnA
 IJ95aV1Yx4KqZv0c5Kg==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad68cda cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rV8cRaJqnNBheiZS6nIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: iYuNPOI8ngaqhM2dpjygsFL22y5lTccO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

On 10/19/2026 8:35 AM, Brian Cain wrote:
> The midpoint rounding thresholds shift by "shift - 3", which Coverity flagged
> as potential undefined behavior.
> 
> The legacy add and multiply paths select exp such that the normalized result
> is at most one bit above it. With the largest legacy fraction width of 23 bits,
> shift is at least 41.  We can safely assert this here.
>

I'm not sure how to interpret this part. If the absolute minimum of
shift it 41, then assert could be >= 41 directly?

> Link: https://lore.kernel.org/qemu-devel/CAFEAcA_WJ-PYCfiiu44uTQiDoc58_9Ky3uEd-9g14nPgDPT__g@mail.gmail.com/
> Fixes: 2633da1e127f ("target/hexagon: add the QFloat logic")
> Resolves: Coverity CID 1688240
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_qfloat.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/hexagon/mmvec/hvx_qfloat.c b/target/hexagon/mmvec/hvx_qfloat.c
> index 41cc827aa87..afbcb114ca0 100644
> --- a/target/hexagon/mmvec/hvx_qfloat.c
> +++ b/target/hexagon/mmvec/hvx_qfloat.c
> @@ -721,6 +721,11 @@ static int64_t legacy_round_n(FloatParts64 parts, int exp, int frac, int adj,
>      }
>  
>      if (midpoint) {
> +        /*
> +         * The legacy add/multiply result is at most one bit above exp,
> +         * making shift at least 41.
> +         */
> +        g_assert(shift >= 3);
>          threshold = UINT64_C(3) << (shift - 3);
>          if (low <= threshold) {
>              return base + 1;



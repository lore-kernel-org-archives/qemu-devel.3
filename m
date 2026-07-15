Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443DBC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 19:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk59C-0008Jw-37; Wed, 15 Jul 2026 15:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk59A-0008Jm-OK
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 15:19:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk598-0003Sg-Qc
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 15:19:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHB8qk342918
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 19:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4icHyI41dfMJ+VAde1N7pphqnYfoSxIl4xTFGixGmfw=; b=l65lx/sq8bI8ocOX
 ny2cSM92wkrQ5WIUdMfnDHxBV4GRirrbGVXzcAK84ZTfOI2AasFZGFygXzPcGSFy
 2Id99yzBxJhCiJjd3tfthSJ/Whn1gyd6LUIWytmJ60UZWXohjK5J6l1tLElEfW5M
 AH6wJM5Bb3GfPWppbTs4NNPVrPrTWYn6UiUzdLRcxAtuZ/kjS1Er1Y1vHl5MmWGq
 k3+MJUGMWxNdQ/7hDeV3GPKMt/0WX/UgNR7RLSfc30hsF1M2pU9E7neVAOGF3PRd
 ecQwAok6G83PCrAyOHIQWrNQIXRnPYM0zEVz+LAp2rweivq0xcMqqksgfTqh+sDY
 hsnLAQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe855adfg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 19:19:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so8469419a12.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784143192; x=1784747992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4icHyI41dfMJ+VAde1N7pphqnYfoSxIl4xTFGixGmfw=;
 b=STYSKPdafFohzryjBHrD/qYMCIa+5XZlNAdXtAU8BctEmCAq/HGe5CGqNJWC52A1Xj
 mFTi9sTwhs40wOIWOR4diY6mHdLpk02rYvE3Yss8RQiZFB9jp0tFcKwxlrYam6FbBdh9
 a4vZvz6XbISVBsLGfRok2p63Lnajdda1u+y0W3lWEj4L+b+BSlRCimkAQafYFdIl4gMR
 tESUYH9O7NlViquAltioRZAil8SwnjnfiJW7oznGa4T8W7ZoQEOue3eYynNv4QH0VyPU
 mAWa958Fc6v1DHMRJoKX0afr8aa+Dh9Ju8HLkKdQXHyIW8UGje5s9lCS4NmVWMIDya76
 Y/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784143192; x=1784747992;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4icHyI41dfMJ+VAde1N7pphqnYfoSxIl4xTFGixGmfw=;
 b=mzBZIARbb4TAF2GQDWzp0Nfx/db6LJ3LGoKW5Reu7JyvEOlIS/1JwqqfLMnAdbY8aq
 Gzr4HZTAKY2YcV+qqq4YzlHHhmJG5NgCh0i5vYXaQ+EMXMpPg+yz5qVeSjW5tcotIBpF
 BEpGakvqUnfPHl6owkxT01ghn4izT1lQPmLxXHVg763egQD3I9LYpNq8T6WJ4eVo3SMp
 2LU7czfVd9IPJSKWb1toYtIltr1Gq1c7w36Dk3/cI5FCxyffbKqW0hSz7DrBopbb8WBU
 9BR1dUV+eB22+dVveb81yjLWjOCO8gPynHqC1miFRGJQd43IEBBTRhnOR6g8O3S2VL/q
 Mfag==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4qFzBE05Qwxczumo4oKEJoIIBquAfYVePoOeD1cAcDkuubSu+U8Pzkueann+BadwpwzX+axfvR1fY@nongnu.org
X-Gm-Message-State: AOJu0Yzrjjno/PsEvdAG8naoMixFmYeFAh+tDq9FnA5WnWn9UZjzHd3O
 3FRVZGUXwXiS84xycVomXZIZZA2r06WYGAAMEUc6V/czDSeWDks+SpEaH91NbWsdezGuB8UBYk7
 /xeH4F9+ueLUWlrOs4H9SpOjFs2oT/k6JRASSp9BOS+XwtUkwoQVgAvDaxg==
X-Gm-Gg: AfdE7ckZqQquB8j/tKxxAj8rEo19mkVd/IwK9LHnrcnov1Nl0N9nzyvWadP/IRuC+P/
 THTxYE6ofBT+VQhKORKfCveKnA5FWT+g5bfs0MeaOAon9B2B+OqnJoO/QvfNDWkfVTd0tVd5O5s
 EK9mxlqf3OgmtvcUk1QPhGKaW9C55u0XRv6fXJEU4/Msypt8RJBLZyN50GyBbLEyJxQL0TNc2im
 1s+c2qK6o/mpvdIh9MHXa4NlSaErZFx+EGghDYdowTtLB8Y0BDjyyM2DcEE+JCtnGX2ZXJccovn
 +BwrB1QbVxqJnXr+kDriMTv269Fr+MMDj75Gtz4JqyzbXJu573g802uESKJRif/oDt3bgvRbIcT
 WWyeai/+zSklbEAd2yK/g2n+faD3Qn8BTNi/r9YprveGV+M1Ul05owGa0/3VqWzr1BLupb4bx0P
 0LV7c=
X-Received: by 2002:a05:6a21:3297:b0:3bf:bfd0:2a11 with SMTP id
 adf61e73a8af0-3c34d719d16mr10368727637.43.1784143191688; 
 Wed, 15 Jul 2026 12:19:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:3297:b0:3bf:bfd0:2a11 with SMTP id
 adf61e73a8af0-3c34d719d16mr10368699637.43.1784143191275; 
 Wed, 15 Jul 2026 12:19:51 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e545bb7sm3104926eec.3.2026.07.15.12.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 12:19:50 -0700 (PDT)
Message-ID: <673fb7b9-958c-40f8-8876-e5bc91ac662b@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 12:19:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] hw/intc: Add l2vic interrupt controller
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Sid Manning <sidneym@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Damien Hedde <damien.hedde@dahe.fr>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260715185701.1287176-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HOYUEE8yE91K87CYLO4duvIHP609ZjF-
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6a57dd58 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=U2hoirWLiHUcDp7i85QA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE5MiBTYWx0ZWRfX3txaU2TwEal+
 Md6LBvi2pUmkd2vug48Ns1jH26iIikqE3RW5wa6XyhBO8EieCsS7dVeeHImeS8zAn6CbuscAFgY
 3pFM01i8DD1jS+X8XHB7rpAUkESt4ffqbMJ7AmHlWgUakLiaPfEpyZQnyt4GWANwOew52vAJeGu
 8PnAOyplXFSmpA1UkQX1OxxE/d0kPquc/TqFacyho6DUxfMigGTDnN4ceziu4SO6h1hnBcT81E4
 z2GFqmhz8KWdxeRGJm9Vuy2HBmXdvwhLMuFKDpcqy5Er18F9zvoITQiyoYNAp6awUaM4iheNtGC
 HWvYggnspc+R0+NbEpTsCbF/TxSt9363mG0vIrlMUkkdedGuGYirkbY2fyRarxuPE+UCpxjMs86
 +aJ8NwGBr6xIYin3n3QzAEsVY3GOoBIdG4whU8b9IGlirqyQTxQyk5dVtetSMPFV9Dx0bGo07Ce
 dBVMURFrMaAfh2IR9fA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE5MiBTYWx0ZWRfX1Cq6sE7PkWC5
 iO2qbeg9ywoICW9RHnKsB8vzreTfDvwes19It6dTpG0PpdWYKIe/hQGjsCPfbV+ygBqzicRhMHa
 PiwblZlx7m7ou3Cp4DXSw4bzyr6Y03A=
X-Proofpoint-ORIG-GUID: HOYUEE8yE91K87CYLO4duvIHP609ZjF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150192
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

On 7/15/2026 11:56 AM, Brian Cain wrote:
> From: Sid Manning <sidneym@quicinc.com>
> 
> The Hexagon DSP requires an L2VIC to route up to 1024
> external interrupt sources through 4 VID output groups into
> the core's 8 interrupt inputs.  This device model implements
> the register interface, interrupt steering, and edge/level
> type handling needed by the sysemu machine models.
> 
> Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Co-authored-by: Damien Hedde <damien.hedde@dahe.fr>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS                    |   3 +
>  docs/devel/hexagon-l2vic.rst   |  55 ++++
>  docs/devel/index-internals.rst |   1 +
>  include/hw/intc/hex-l2vic.h    |  87 ++++++
>  target/hexagon/cpu.h           |   2 +
>  hw/intc/hex-l2vic.c            | 532 +++++++++++++++++++++++++++++++++
>  target/hexagon/cpu.c           |   2 +
>  target/hexagon/op_helper.c     |  21 +-
>  hw/hexagon/Kconfig             |   1 +
>  hw/intc/Kconfig                |   3 +
>  hw/intc/meson.build            |   2 +
>  hw/intc/trace-events           |   4 +
>  12 files changed, 712 insertions(+), 1 deletion(-)
>  create mode 100644 docs/devel/hexagon-l2vic.rst
>  create mode 100644 include/hw/intc/hex-l2vic.h
>  create mode 100644 hw/intc/hex-l2vic.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


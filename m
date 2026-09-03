Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B99C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26MT-0004rW-Vr; Thu, 03 Sep 2026 08:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x26MG-0004qf-OU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:15:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x26ME-0007Ko-GQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:15:56 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHF7f327180
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 12:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3oLTEgJwnr5N2pfKsISe4s02HESbuO5oygguuimLjlw=; b=o4BhVVBoGdHFzg4T
 dPh9+rslA1gKEq57h0j5Qpxh1/4TloyBv+8sc32nrKlVxILP2hXIbm6OZehVSY2N
 2avJumrqbpMMjR2H6gwZaqt01J7mIg87eAd0kXshpVrBd1+OvFEAo+P7rEKOHBXe
 P1nlGl11gcg87NH94KdtrN9seb5gyJhM8TwKwhYe0tvEOaAMW/gU98WWFz45avBn
 2i3l2cuRW2h3uZgt7GPKz1neG68NyCfWUJu9wwqCfdoNMjsLDkwSzWziAvhVwrm5
 WZ6vJ5n5W6Gtb53JK/ERWknUDJE+tq4Q7bIPjr2d4j8z0K1P/i/s1Ir2pO+vbezo
 wDsmMw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekh5f5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:15:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939694871aaso270830185a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788437751; x=1789042551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3oLTEgJwnr5N2pfKsISe4s02HESbuO5oygguuimLjlw=;
 b=gs6r7PdbvaT6q6CuWCO1/+NyN7PCHDHppETULmEMCJlOJhZQjO4zHS6wIoC3IbpUmJ
 dzlhvJn2luuFycoTb8MU5jrC1D/ElESNZuLChWhZtiK750jtQs6Mnwar3vNiiTjexrOE
 2f0jBoF2behWgqM1pkj0Lrxy7N3OwE5TCRLca9vL+bGfbkR3KR1nddktHWvpIKDWWIya
 9JYpQIznt4+o5mUpJKI0mbY/nxth72u9EVdJAt3/K6KdAjPbF+wrDUAC4ChrY2g6Ks3d
 wUBy/SNQ6XnDO2bM8MlcjeIOs7zMeTTu1vQVnVaeTHvwSSGNajiHYa2tvCfkP+WzaYNP
 /Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788437751; x=1789042551;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3oLTEgJwnr5N2pfKsISe4s02HESbuO5oygguuimLjlw=;
 b=PGjzu8NzgTtL/JODA2BZZWwGLkA4jH8bTHWTNq5jHPuPwEGE7qPQQIYR4qM/KLO+lZ
 zmTAUARuijEzcZQnrDaDXDZyLc5/xScGnAMtbMQlIA4P4/rD0A+Yx53NPn0/9ERWdkNB
 k9CMY+9n8Qok/tBPIWRffmmeYj76o0efe/+ZGmeFfLxiLwlBOb/U13w+9xCnKuJnsLqb
 hrNZkrHZ5ji/4eBYXz/Ki+Z5vYmTJpYjyLwLAEsr9vFlh7eTNYBPE36Tp8qUmAUC0/yt
 fjbbf7AJyDEWhpAhZsyqBwuDE9B/fqA8tMWUg1SEXkIJ/nhJS+79CYgWrwYvRofnL6RH
 i1Lw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzY72TYEkFUHyRBL2PaNW2YK21WzQa4Fk6F9Kn/1r/gHkUig0/WWXk8flYU2Xx6g+ttx9OCZFMrzfW7@nongnu.org
X-Gm-Message-State: AFuF++nVzDqI/NqTJgItNfOT4WDpB1UE5Hk2UbHMfP2vwO2Tq88N+BJc
 fCXmG1UTDQmFDJJrjIMjCGo0FLHxZ2tNtQ1mrhg9NGrEVciilPrbQd8A+f5orMQ4UzCa752Jc6n
 l5kpn0FFhZAULXQwq0qyIS4Ilvi81fanCdpRSTvT5zMopd1eGKcdnP1sd3g==
X-Gm-Gg: AYBFou1kE9FrvHlSf5+B5wU1NFXqSxCBmkGPC0FR/insMUU9GL4xVR4vUugKSw9OHBY
 7zvNGP4Pl2O00qOsM3H6KNTzwumQubmsVPPEwSTnE54T2bXZtOKGXBljDNQo2Aokpr5o/sw4tS4
 KE5RL9ICffaqQZPuODTZRK0ODwjf01NIlUR3SKGw5V47yJrptNPAHeXHyyGyuif3CTia1NWGmp7
 Or84yW2H3OZti2AhU6nayV80org5Owrbgx0+6pw8UCE+HRH0HFDDrWTU+r5njzTds9KNr7VTSLG
 sO9HXM4//5RNhYUgTwZrKObXFDSd6N+kzjwpVaixxFi+fC28fGkFWGOO9ne937qqxhgXbeFLW7p
 keNyreJDpucRsFb8/lA30Gj9WPP//NwbFxA==
X-Received: by 2002:a05:620a:6546:b0:930:a635:a782 with SMTP id
 af79cd13be357-93960e21312mr926808085a.11.1788437751522; 
 Thu, 03 Sep 2026 05:15:51 -0700 (PDT)
X-Received: by 2002:a05:620a:6546:b0:930:a635:a782 with SMTP id
 af79cd13be357-93960e21312mr926801385a.11.1788437750983; 
 Thu, 03 Sep 2026 05:15:50 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e7fddbsm12837507f8f.11.2026.09.03.05.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 05:15:48 -0700 (PDT)
Message-ID: <824e8ec3-f45e-475b-8fb4-93f2257d20ea@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 14:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: reject trailers that credit an AI agent
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260903100441.781277-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260903100441.781277-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rOJVfELiooXL25-rTC_Y14zgrdkIMVDz
X-Proofpoint-GUID: rOJVfELiooXL25-rTC_Y14zgrdkIMVDz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwNiBTYWx0ZWRfX4MFmvMbBAdmd
 UgLdmkinRoCJbPccpYtos2iAdzINjx2Op6JJg9QbwK3zGEpoXHJoPkfzvOaZu4WICZWp/HNH8jq
 ezltEdfrEo6XCqSF6SFI33uErbA6VmL8LoXr43RAFCS3cqNu2g9yOt7mhq5s/sdDxRST7AvRTdt
 bI1VKzoZ+npYG2OOsKLMuDcg3bgxQ5QGosMspPO8rVaYMi1175Sf+VMjZF8Xxqg7CB3oirWC2eW
 /mE+sbUW0jwOgoAJ7UUVdGlhSsRmVDMp/RALnwtxuiDNn8MjJLsLJd/aaR4nMxGMGciZ3+3gYpn
 HNDfg/YQHBvUduItcid4dd8mK6jV1TwPYsPgdD4+J8R2PLnZxOXsEXoy2Xh3vVJJhaI3MXFaK3X
 FmMnSVAY9CiAaNXWFKheiTqmJxoVpJvmaLzoPCnyuJ6w/IYzvyXEAvoXT/x73bRiVXItmj2ok+2
 998u3RWsgPSrFSBrASg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwNiBTYWx0ZWRfX0x40qb8gJp9o
 q1AopQjF2FhoweBQ77p8E1Txb6LT8+9tH1NFcdeZRtJxx1DnfX10mqtgbViEyatcjncvhAx14Nd
 e3HKV4nULQLKnkaDn4FwlK2KHuTW3yc=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a9964f8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=7rpXMMTx5e6kaQIhGy8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030106
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/9/26 12:04, Paolo Bonzini wrote:
> The QEMU community has broad consent to not accept assisted-by and similar
> trailers, and much less fake co-authored-bys, independent of any AI policy.
> Implement this in checkpatch.pl already, so that there is another way for
> contributors to discover the AI policy.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   scripts/checkpatch.pl | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e75012..90cb40dfe1f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1811,6 +1811,18 @@ sub process {
>   			}
>   		}
>   
> +# Reject trailers that credit an AI agent.
> +		if ($realfile =~ /^$/ &&
> +		    ($line =~ /🤖/ ||

Few years ago Peter was concerned about using non-ASCII because
it was not displaying correctly on his terminal:
https://lore.kernel.org/qemu-devel/CAFEAcA-CJwcE9k+TqQ-vDrevzZPV_+CXAr1j9QfR_ivJTJ3e2w@mail.gmail.com/
(that was using Ubuntu 22.04 which we don't support anymore).
Should we still worry about non-ASCII in the repository? Having
a quick look at the OS versions we support it seems all of them
are ready to handle UTF-8 chars. Anyway I saw various utf-8
emoji symbols in gitlab issues, and it is likely someone will
paste one along with the report when filling commit description
for a fix, so they'll end up displayed in a terminal via git-log.

> +		     $line =~ /^\s*(?:Assisted|Generated)-by:/i ||
> +		     ($line =~ /^\s*Co-authored-by:\s*(.*?)\s*$/i &&
> +		      $1 =~ /\bcopilot\b | \bchatgpt\b | \bcodex\b | \bcursor\b | \[bot\] |
> +			     \bllama\b | \bgemini\b.*(?:pro|flash|ultra|google\.com) |
> +			     \bclaude\b.*(?:opus|sonnet|fable|haiku|anthropic\.com)/xi))) {
> +			ERROR("QEMU does not allow using AI for contributions, " .
> +				"see docs/devel/code-provenance.rst\n" . $herecurr);
> +		}
> +
>   # Check SPDX-License-Identifier references a permitted license
>   		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
>   			$rawline !~ /^-/) {



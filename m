Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C96FCC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPV6-0006hT-Kp; Thu, 15 Oct 2026 13:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPUz-0006fY-FM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:44:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xHPUx-0007KZ-U9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:44:13 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FGNMxr4100190
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j1BnaYCC3ssoQt2Qz3O6FIsDeltqbHnTIC+NJaghXVE=; b=mQp3hP0qS9tSqRNq
 Fot+jmPI8g74/UF8+kFxlwJX+L3dtJCkcB3JAyTsuspUVaMD9sDyO/t9NFvxdbbc
 xvB6c8cB34NYKcTQepfRGqpkCmLdkVaK9hV30RGEiBBu+cy2z2g8lh/PWLgKnK28
 ql3FxzGTwHxB/qXVDlrDKbIMq6qWDTpITg0Iz6v9M7CAdk1uew/gPfeidOgJfWb0
 gVFDmbm1QZTi4Njm+idTTAyrnyDJNe3nnlxIt9smVfEDEYh6ngOijFVo6osSK01b
 0NwMblAroVFjeglH8Oh4uNDcjvudR9Eae6hSC9wffXDj0orZOYjKvKvkRhh6C+77
 cLVTbQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2r9rrk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:44:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb98809caso940593085a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792086249; x=1792691049; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j1BnaYCC3ssoQt2Qz3O6FIsDeltqbHnTIC+NJaghXVE=;
 b=i/TuFz+7RELEVl02rJTDTpUILDA8Ruxu6jARLcHS5VPSApqaCttlykrQ52ZFgGPCci
 OB3paGb0JuQPVR/yzTsRzqA5DKTNxnKTbdlKh97wSVPZd3a6Ng6AUuq+x79EeWFnFZ/y
 U8xzZTkpM283OQZtvLE0BOKErMuqG6OyPKOGCx+cyAjhiUMQytn2KRQQlO2PSQ/xKV5K
 pbn1l/G7I5jHFtso2Aldbi4Up1ageroVPAd6/ctS10jHNcVFvVOBGyKefmsRirum+MbT
 MblSxUskVbY3JxxB815Q3W5tcX6oIJvE6ExWUtj9QKesymAdF0l3rfJyLiF4fCoQriTT
 9fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792086249; x=1792691049;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j1BnaYCC3ssoQt2Qz3O6FIsDeltqbHnTIC+NJaghXVE=;
 b=NY0yjQtaqFB5XzBTx4nFQyCp2FS+fGHvqwM99X2VcLacwz3J9c95G7IgY2s1i9/Joy
 /B5bDcia3T2hp3Wk2rqxHUj+HkLQNXW5ZLpjYJg42xEgFOGvskKaUNrrvAoNm3jf6T4g
 RmKItgRq8Onp/o20bYxZclgix/lnC6S3E/UeFpKzo38OGE4xnOFeUJwl6PNunXfcjObB
 YcHW9/bjfp9KG/kxvOJbfeb/rPpm8o9LNCcloXfTMsV+JDRQCp+96zF9UCHxqNOb4MX+
 SA92fFXhhsPAYT9tcNRN5YfJSxqPAcA12XJqp4UUAARbrZErcQ5s8M/cnUfcuFNKMB0B
 HLXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUiIEyN6KDot7XrSRImoclUJLyhmNtnN0iEiIJKIDRSGzGAF2MxROxGo5EQ/xna4OwTLCQ++vr4HTU@nongnu.org
X-Gm-Message-State: AFq9FYJxaTVExiCFmffbWzqZRkiRsR07wbzYqHKW0/iWrOmdDnlKlHnh
 IId0evH/BISBov31HlX9qXeBmU5MfoBDwFBTTldrkmu6VYwV36jDbwz5LKRO3tLBdATBGI//CrA
 S6xSkQus69TUatB00N/jW1EW2EhJIlgzxQoSIYlvyrJVDfSWvy8+5/ee3Cg==
X-Gm-Gg: AYBFou3NBdqcoIYlwKn5kECZ6WMXsCi68mrbjzQgZZwrhyWtKnvhlm6qIqpO5FQ9tNg
 sKNYfjCygLW50x94HMm3C0jH7iwwvp/+gO0BSZeOX4vPhvxmy0FRc899UzfmB1PJfybvDW/q56p
 zo5vrIXvyIazeuxKsXx+Uit7IcZ94CwguKBaaqsYEmCpgDjtz2gdMLeAojhdXrQy9eJFGrmDtfS
 lTRFQE7ZzgwpIj0huJ7Z7pW527+Ipc9FFjwIhZikyMwc8AJrtlhWm+z1XyNJAqT6/WpWEIaFKMy
 ISWs7DIXDTnllQ86mvJ23UAbFeb2CKOOkQ1c/aPyXzV/9mIpSOTe3BTnr/+y02iP/nKK2D0tJR6
 +EaEDjpng4jGRK5st5r3/Gi2nWDLsJh9/hQ==
X-Received: by 2002:a05:620a:a0ce:10b0:93e:c03c:c2ab with SMTP id
 af79cd13be357-93ec03cc8femr2210012485a.20.1792086249350; 
 Thu, 15 Oct 2026 10:44:09 -0700 (PDT)
X-Received: by 2002:a05:620a:a0ce:10b0:93e:c03c:c2ab with SMTP id
 af79cd13be357-93ec03cc8femr2210009385a.20.1792086248808; 
 Thu, 15 Oct 2026 10:44:08 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1beb77054sm60237375e9.1.2026.10.15.10.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 10:44:08 -0700 (PDT)
Message-ID: <a16e106f-eef0-4e3b-950b-e4717a15f074@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 19:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] target/arm: declare semihosting ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-10-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014210526.104215-10-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX3MX57HSA5xA4
 VqBbnqm3LOW6uOcpVJW5U9lbNDzCltLSkoBo/yydWJfiRSm8d1pxhoYe6EKsR1Kpf/sb/Xhgiiy
 s92URvlsxy/iv+ifNSvs8hJPy40lIsk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX6gDKfIdBhtvU
 0tX2rQZTXPVDX2kNLriOHCHkze1s0pELFU6dmJAsPfNLDvMFWPz+PSGWEUCaldD/Cjl5BcaU3XG
 VVRLGE2Qd9dG9uRnPf37Vmg1wa6ANvoKalPzK1fPvsyQgWphisjnN0jEVZ5hQsfJX5TnmDvRVWL
 h3j9r6/sWuW9Wt5sf8JwFlOzP+DS9j2odXJbB8KlqaEk2FnRJARoW3Ltd7Qs2NTqFiamKF6bK73
 AVDCJwCRU+t9VL/M2iuEFp+pBuKvhftkwKaARXP6sfxVKAdTZDOmzYp5ELtLgxa0n6de59nYy7c
 vpbf0fhxNnMxFTBbX+mCoJvkS8VCozMDJ5+KKf3weVzjQRoaKYMA9HilnTvs9Sh5Qa6GmtQWGYp
 EIou1a2VrQG9Cfijh0AIM9rQR7i8FoiDUOzXS3VsXXhkglhiFdweVkTbTU/3hIYLZGF1jrQ0mH6
 HUkEL3H/7GnvTFzbBUA==
X-Authority-Analysis: v=2.4 cv=BNMmP1QG c=1 sm=1 tr=0 ts=6ad110ea cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=X6Q8Br3edyyEBAiNBCQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 52ryNk0euivOeXyMhcvgjAYFmWFXrf-G
X-Proofpoint-ORIG-GUID: 52ryNk0euivOeXyMhcvgjAYFmWFXrf-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150070
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

On 14/10/26 23:05, Pierrick Bouvier wrote:
> For now, we keep the global common_* symbols defined.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/arm/common-semi-target.c | 72 +++++++++++++++++++++++++++------
>   target/arm/cpu.c                |  4 ++
>   target/arm/internals.h          |  2 +
>   3 files changed, 65 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


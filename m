Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE4FF36C5C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErst-0002Fv-V9; Mon, 20 Apr 2026 12:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErss-0002FQ-4v
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:54:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErsq-000312-KE
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:54:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KBWkLc3212140
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MoiMoqDSRghfxNSOwo+qHzQZhAH4svgUUe/7F7s32Mo=; b=DRLJwUAR2yCw8qIR
 OJoYkaBIXE00dy0w5oiFw1TyzZCmaxBEUht0IP/S5p+eZwG679iQ53SusV8dxJLb
 D65XJhyygqi5eVikPFpLO+R6y3D2p50/GEu3gKw+f1QzCvrTXdD/2a3k32+bMVZS
 JwujdCHzot/JeKf0nwfONan+i+zWfDjGML9fTVz6vjKt8mVhrOdc3pQkcXCBewsR
 iNdzU8VRkm06EoQHqU0YUdgMBYgbQVm0d0ZBrvCaS1jwbnBOoQazl5E0r9zQfprJ
 AtCsCQbl0KAk32VM+T6QhpPLTMsXlViZQDMAXGDKh6uuztOE1+UR3M0N5WS7PkoZ
 slZr8A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfcfjdw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:54:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2dd1c74508cso5896994eec.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776704041; x=1777308841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MoiMoqDSRghfxNSOwo+qHzQZhAH4svgUUe/7F7s32Mo=;
 b=Vdn9EBsFoj7EeVvbtqsLCJrVtyi9XfymX5AAZODukWZH+jVzbispFHT5CwVXkF0yq7
 AbPnrTw9vMefBLGalDz6xrDS1saNaJ2EZitzJ13PIdDkn+s0WV+b+QVRsTRlJRquCVNu
 QPkLndBxtCAABvkKTnxfbBloQ9yjzLCNcE2sP8bId4pA/TGzMTMnv4y4POd8+ASr/ccT
 PV8PpjX1PgH5IDrMYDPk6l+vp6CaficBkbK3SA/ptokWsjyPLSnLMivspAbsTV3K7rUH
 KgwXOreRDC5tkkmXauZ1kar52iw65A++x7xpkx6BY03GBYrudJ9LzWYNToc71j0L7ZuD
 Rh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776704041; x=1777308841;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MoiMoqDSRghfxNSOwo+qHzQZhAH4svgUUe/7F7s32Mo=;
 b=fplqBb+xcREJlBTOem5vSC+BrYa6G1ZzXcNOzRp3PGNFyhds4VGVtyfmfmxK96CLsW
 Dn33wjjo+PiEh5F6OMiStCWwbUNPLhfKrSsb8rtB4eoCempJPF/zKjagYTrMjvxOsOSH
 enjUHzAJN83AdOEBYY2E7pAHFFf60/tG3wC6TK6EW19+aB45QobWcnO2/BXyY3e+ndlm
 pWa0Zhkdz7184XDlp9sGFxM3TFzBkItfoV9u3wkOaVXQzo3DlHtAYbE7y8tDW99knAMH
 7XReg8CYS8xoyjDfcCyH5A3OxeCiK1bHbb9VQOwLIpvSm790sXLiTEr/PkQwPSuaVEYv
 IsVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Hr5Yy+QPKOINyOBCJtV9LUSGm8EXLERl62PhT5XLpX1fRKCgk543oS9E73OsesnDBy9LEZ4qtnKZm@nongnu.org
X-Gm-Message-State: AOJu0YxTwPXZZs/6g/dFe6yWLmXB3MjzBSo1LP+7xfh2I3v4aPVbldoj
 RqfLC91Td2VC0p4DzznnecSuNadUd72BQE7CEzz2+O6kz9Pa3j7hNl6jAiyMas56dqF1hapgA8g
 5aNuWOYy3rY1VMe1a0snSMIzMkjhvzGcKrvqWeO58dxjZJItMiA5aSODwe2BBKFvp/w==
X-Gm-Gg: AeBDiev8LN1a4iLB4fULRSkYvLCM2xlW7PVQ9TozgLxvSmbT7+gkM7WYYlU2Aet6Vv9
 VvzseqXOsELLEtSVMecH+p9gpiE5eszrM4pGEVWQkdIt+OFRkXps7o6TjHRGBPE43Suodt6kB+N
 f3q5Vq88AN6YiNCImXGo4vIeZ4Fnva5wM2WZzOhqrXVodoE8HlXN23Zx9QFUgVwDwbEmZbppc/X
 zbUplAWOcGPMK2ayTh7rZ7Wnh+5Qipdb1bSW3oGZ227asISkgo0J75YMlOHZ/tzXuvVhNYuF2Kr
 5a/s3RLn62LkRpX27+I+1yOl+UrjamUdEiP21MiV+Vlk/USUSDKT6dUjl7TS7gFeMCX/y5gYVQ4
 VsuQd98qYux0ev68vpLprQXuMtN5mzcaxXMAkoG2RPc18qNHsEH8sHBdyq7eEK/P5xGfuFPc/dU
 k279DopVQqayVHZ/1oYhQu4XXw
X-Received: by 2002:a05:7300:3723:b0:2de:1508:937c with SMTP id
 5a478bee46e88-2e478a2f091mr7395288eec.24.1776704041476; 
 Mon, 20 Apr 2026 09:54:01 -0700 (PDT)
X-Received: by 2002:a05:7300:3723:b0:2de:1508:937c with SMTP id
 5a478bee46e88-2e478a2f091mr7395257eec.24.1776704040915; 
 Mon, 20 Apr 2026 09:54:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d2cfef3sm14516009eec.24.2026.04.20.09.53.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 09:54:00 -0700 (PDT)
Message-ID: <742f473b-8b41-457c-9413-a63d89d03a0d@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 09:53:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] tests/qtest: Add hexagon boot-serial-test
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-10-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260416210305.2255579-10-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE2MyBTYWx0ZWRfX5Jfe661pKLjo
 k05DDOuLGeIxVt0D76bN0LTf8cdKbVevW0ahZrDKpC7escALCBmoRzBbIAzIgmEUXkJZOCFwFwH
 5nl1seOndph78utu755H0BVhzcFvnpiRAEMMQwxZDKvs8ZYnl9lbKzCweU7lYMQPI3k5kokBxq/
 LkQqHui+7Yb5ISBTFQKA1YLaRXzvYIKPKsNNujO69J/XGOvjGSLvHI2gF/dL6tfal0RfLU0vXK1
 d8d52jHDDgn8U35/SFU4UYBaHQ22g1JhiJP40k61FmAOamv3nx2zm0GGT6QRtVSbnUiMrQ/0jiN
 H67ocEYwaF1D7p7FRF+s52KSmvuvLZD4mNjWUWHBs6wChOMlPW+9a9NLtSdrk4feywSdqYv0e+e
 x9e1TX1i37G8wBjOPcuo326Co7qwswc7MU9CMcMF8PGZ3SDhLCRmhijsOmqQMp5VfmXkko6g0M7
 LM3VrQqwlRbOq2shvqg==
X-Proofpoint-ORIG-GUID: aPyrxsSTbTkamj3W31ZqdSE40pWn8TuP
X-Proofpoint-GUID: aPyrxsSTbTkamj3W31ZqdSE40pWn8TuP
X-Authority-Analysis: v=2.4 cv=L+ItheT8 c=1 sm=1 tr=0 ts=69e65a2a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=qrCIeaJLEhgQZU1sUSoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200163
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 4/16/2026 2:03 PM, Brian Cain wrote:
> Add boot-serial-test support for Hexagon architecture using the virt
> machine.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   tests/qtest/boot-serial-test.c | 8 ++++++++
>   tests/qtest/meson.build        | 2 ++
>   2 files changed, 10 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


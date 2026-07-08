Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E096C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 05:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whKap-0007xG-Um; Wed, 08 Jul 2026 01:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whKan-0007wd-MF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 01:13:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whKal-0006MS-4E
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 01:13:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66842lxU1645147
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 05:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NHLziWo/mlqgM2yvS6KmyTyKS/706XB3cAc/XLN79No=; b=TY0Gnb2WDFFmWXoI
 I3UoDnZVONgL2JvGQYJ259jruLmsqWaEd5ujnAEet5OSwTvjnsur9JldouZVdvNw
 hs9GP2x7fzIehHITLnvMUEIO8XPh4S2RIV18qA00BbvMQRmaxscQC0URmP2YlqqZ
 B7vGHYpfVZRchhlW5EojuZuYXJCNmaVExR/uH62ID4rU2qaRjswzE0EW5zcR75P/
 m/ch4mnKups3UZHBoYLVPYke2MlOPUtzoIt3i5pmlUOM7esrF+eMDXywA63ILDNI
 r3gZHzSP6b/Dq6k7QytJQ/a22CYUDOwbkKI3rgHGkbEViFrSwVTHyCCY6LlG86dk
 RBDFKg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0m8b5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:12:58 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso5495396d6.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 22:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783487577; x=1784092377; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NHLziWo/mlqgM2yvS6KmyTyKS/706XB3cAc/XLN79No=;
 b=SkR5qq3YIG1rfIwq2I9Kt48ASMp2cf9aizAHbJ4WgguMIib4P5lGPnDTObrgtIt6uJ
 AAyUZuMctArFM6789hB2X8MKFoKxNKTWCsLs2Bzt1pAoLOklgXmqTxCcSt+ieBL9XH+J
 mQd+Z5WUk5meJ9aNfQnOrWEuNVnYNjJYjlyGoyxy2EKcOH/9IYdH4rWzhYeDkzhi7e3w
 VMrUnYnSwYOuPMd56K070we57lVQfzh0VpJjg9aE0riYAKTLk4ZmXlx6VYx8isGyUUPB
 sMNbzRLHpvGhfpTvOhMk3hc3LDCa4yh7Osk4RdXtsNrOtV+uG2+56hatgGYrvtRCQDkM
 N0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783487577; x=1784092377;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NHLziWo/mlqgM2yvS6KmyTyKS/706XB3cAc/XLN79No=;
 b=nvB/Qk68idRSYD7kkPIOV4JNOLd0Cr51SK79MWfa2Thp7hmjJ106slmoVW1PCNDr7o
 h14YmiMYXfdgdp98kjmva6gfCwzk8EXJ0C//v+BQTwJvgL5TXFIuZdy0sDzxH/Gr6My5
 /T3lMMGQfNegIlfh8pLAjpMHOXcTW9yVp+CVxDcDvZWUBxA8azLoMuT5X0Ho/pXlDOaQ
 LP1aRzsVC06CQxGnozoUd414rMUyC7BOHr2vScDqcfrfOqVPMU/2fI/KfRyIqekzY1/G
 k7ed8iylozQRWKgmDeYw6FG2awSsQbNr/qLjQ5nQ6hg2zwrfIx4UsO9GDwTM9ccUEadA
 bZYA==
X-Gm-Message-State: AOJu0YwdQjasoFe5TRp4D1yLQaP+nVQzZoMzVvEArUUHuJHqigbwPmrY
 0nzvynpBAU7uEg6utZMW//61BVs3bztaymdSHQ+4Xp6bBSwIPeI0ixMZxsm5771ufene3o9nGR0
 0d/WHC5giptz4Pd+VUtwl47wUnovbWHSxwip3pJs1kakiRgHn8wusIYle1w==
X-Gm-Gg: AfdE7ckJioTAu7DCVccTIhYk7W6Un8glmFbmmUiFulqKh57FWq6ntPZ/yOtt3hYwVYZ
 Nwvt+n9CPtVYCpRFIA8SeM61Sil/s3QUAInoGnux0cKtDUmE/45u0a0XNoRnLkbEKnTABJqKBoH
 Re+eMLaZL1e0fbYTTtxPB2wsa1wVplsvya2RhC5qdtx5L283G4XrHiHW4CmWN7xQ8Qi0lzfMgEX
 JMdCIgvhbSqQoIig/5GQ0Hw8Pk/PY2s7IWnITTyDL2kwARf2o6Za/VlyqbdHmoxIYPLOAwRfPiq
 lM3X/+VstGwrHC9dtHWh21O5aG3r7dIxILvDABDxmRPqJfaTRNfIpArbkVjuBlbjmzAmqIdTn9E
 DKVVEd/oS3FNqYEc5LKl9sL0Or8zAeG4s4LT0jNnfuT3JeBXM/0fX370QQdqFMw==
X-Received: by 2002:ac8:5a82:0:b0:517:c65c:488b with SMTP id
 d75a77b69052e-51c8b13d7bbmr11048761cf.0.1783487577054; 
 Tue, 07 Jul 2026 22:12:57 -0700 (PDT)
X-Received: by 2002:ac8:5a82:0:b0:517:c65c:488b with SMTP id
 d75a77b69052e-51c8b13d7bbmr11048681cf.0.1783487576628; 
 Tue, 07 Jul 2026 22:12:56 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a6d752sm20576035e9.2.2026.07.07.22.12.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 22:12:55 -0700 (PDT)
Message-ID: <56424482-5a3e-4afa-b9c4-8d93c37ab737@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 07:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 16/25] hw/arm/virt: Set proper conduit method for Realms
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-17-mathieu.poirier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707224306.1202330-17-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PQ1f3PaYmu_SnDVP792HruHtDkmiaPj3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfX75C9JDdKMzB1
 bI7pepmQ1KtT3hr+U5qVPCSt20Q1XVGPkr2U7DMs2l5QIDAjgmaAUICGh6nInC7ymOGRsc9nnOc
 WpMFxVcvJqGskQsxMAQDX9Y7fsnMEJc=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4ddc5a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PQ1f3PaYmu_SnDVP792HruHtDkmiaPj3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfX8TNz9f1j/jKg
 Xei7vv+O2eGwtFBP60rfDbzcowJAkwHFtHRws2hncPnS6CedqbVzooxc36ENBd0V4FF0suihjav
 auwNBF3elvEggwJypqqKByGM05zPOwaMFxg2WZ0Fk/yLv5ygQfm2pZQtIkHBl6RJHzSg3pDCBwg
 gb2r2qO9Ppd9o+FOU7jjgHfY7Ki4kVaSya4xUhyjPyTwn1nG0vCEJEcCuWcaYzHg4y1fiD3Qiln
 1AVYd1jO7TCZ/VC75AADePFEpMO3ucbaE2j+DVxe+mAmYoBd2dG0ZxeXG4KRjX0f0TrYJsoZtvy
 9CVNjStCo8XUz2cnVStEHe1lTjfssjKRcY6mDOo+kaOMzuv5zA+nL29sjInbuZ5S9qMvZN6Dk0X
 Lyv4H/5nq6bH71vmEGeDDkelWHUrf1dRhi5NqRl0RaKptK/VVFxTaycaTiFneUI7VEAiEPzLBRz
 ezeSfVZ5LX8nIBmf1wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080047
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

On 8/7/26 00:42, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> The HVC conduit for PSCI is not supported for Realms, so default
> to SMC.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/arm/virt.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


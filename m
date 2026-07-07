Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295A7C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh25m-0004DA-5o; Tue, 07 Jul 2026 05:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh25k-00049G-Mi
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:27:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh25j-0006Ad-7m
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:27:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678E5kG3004604
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1mw9fziuvY+i1n9PBqkd3l3Av/XCqrdSX1isoJQ8am0=; b=X9SumCKV73U41inl
 RDeX5/VOqc9u4WfchqjqPrVnx6BJff+5vN/MI+oO30F4E2V6DVHfogcliYVLW91M
 awppJjk+xZ1Kk2X8sptd2NXiRU4E621eV6ieeZ74+WWlKbbIzVCyv72iyIsZCOXz
 6eJFO4m1ZZcdi4Dz2CC2UVQYX2r4cYrV7OFWFtbGFMWvl787tZ3GQuCQRkS70GYT
 bON7tcavTQO2XzMMzIWNu+gxh0eefTC1lcQWLst5ibBuif9VLZWujJPPyhlyiudC
 ZKecJ9U0ikqz62raYqq273PNT5/g5MbfC9Fbx2Cd23Xd6osVEm6Xxd61374yWWcV
 /YxMGw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su717wt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:27:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c20762d21so48074061cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783416464; x=1784021264; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1mw9fziuvY+i1n9PBqkd3l3Av/XCqrdSX1isoJQ8am0=;
 b=Yc3zPe6Yn3WT7na+Q/fZ9MWyFPXVV8q2VWgtBx1LoeKMh21UQNogzBA7otszSL39sZ
 rw43k8lQa8Gwh8yRyCgO0xbi1jq2hCxS24cbeEMF483b/ccPHLj2JQt+7taayruL4WdA
 29zrIhOesXhmAprPVp2BmOi/70tuEq/SJpA00tuQm27z6bQ5Y2WFShaZ/uRq4Hd1xvvy
 1HzGbdi9endJ1WSD8vJk40zE5t4kTVwQ7Tg08QAfQuLfYl2uVfp037TBXSORqtA36IWY
 G/L861KI/hGgVFdOZyZTmCMYr0QwlB8k0Ne14dgBusqTKhkter1cCPpSDAFNxxrRvv5u
 BOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783416464; x=1784021264;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1mw9fziuvY+i1n9PBqkd3l3Av/XCqrdSX1isoJQ8am0=;
 b=UN7+gNcPDnTdOzpUrXx2IVcH+Nq0perHGq0Bd3y33eyRN0PxmQ+l3jcKyZ83GBrSTj
 b5/src0B69jXPK2GmZrHnBwfxcZklmUedqUhSBmNkcQd1bHloYGYuAyd/jKEoBt2taPW
 xs7jnhQAaoXh/uZvuwbjOsuiUyYz9wsOsoMz0T2195gcY5/epL+saOOExBGQ2/OdSHcv
 ZTpMpgya8ZtbW88FzycuEbJeGR8DFAH31lneQZVMVYWI+RhGqQztCS3eYtKxnl4dcW1D
 7BX2tMFyZ6E/iiG+0As/+5OznQbiJAKNhns3Rx6cj1JBIvhtD+n1OznW4sClIlXNLYm4
 x7gw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqV43OuRTQPPFZ0glJk5ZsUqte2hFHQ02SiTbiqEOrZugONYwEvkeeCfVRuLTRQoFONC3yzcd1fROJF@nongnu.org
X-Gm-Message-State: AOJu0Yy3TFBd/HQVTgN59KoXf/z3+EBlQQSy4Dw/7/SK/an9v7jl2sJj
 Ifo/7DuQiBFFBjYFmMFxNQEkT5VCA7CN80A+yB9ZYRQOm7QayQvpiWiT9P4PdPYfPp/Aj/GtHV3
 HkRNeU8nmgrnMtBS64dDHFGiu2CzXdnq8WrEd/Xd3L7ng11d5VYq/gh98Hg==
X-Gm-Gg: AfdE7ckU+gHyOFJ/tMYDpscZQjOkuNVfqPMlVabFPBZCzFevk74krU/cVnHaf0VP0K7
 kMzuHbtGEjs5R2vMlxQUhoSellunsnnEtnSsvv/1fazuAPIbZ00qIss5UZpW2hxG7Gkg4YIf6TM
 +eweWIdIirj4iJKcO3PWJQkOlQjVIZYy6JDwI6Sgb3owcAbbvTe0Jf+nYLrbRPqi57H/ekCvYsp
 kW3/Nl8A1yvKePOxHUlh48EMTRpC96SOr0/9kB2bZpx3BS44NngN2im/2UfCZ5ctiNqmqqOZEDF
 zYtTC7i7XeaPBe/uPNaf54bAg+sK/G7BvWYesRHyR+yV5jogsI5EsC2etxa5AG7oNkk5QIdOJvV
 m5yMX6Hs7eUO+n7bZBe6O2ODCl6ZGd839p5LY9Y+d8E05FNzJncU/I6V3gq3Ihw==
X-Received: by 2002:a05:622a:453:b0:51c:2685:2952 with SMTP id
 d75a77b69052e-51c7487ff4dmr46542241cf.62.1783416463391; 
 Tue, 07 Jul 2026 02:27:43 -0700 (PDT)
X-Received: by 2002:a05:622a:453:b0:51c:2685:2952 with SMTP id
 d75a77b69052e-51c7487ff4dmr46541951cf.62.1783416462757; 
 Tue, 07 Jul 2026 02:27:42 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19dbef44sm5568723a12.31.2026.07.07.02.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:27:41 -0700 (PDT)
Message-ID: <9574ad25-c47c-46f2-8ccc-7c4b811c1cc7@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707060919.350637-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfX7QD+COq4wFcL
 2kUCmyNeJe2wUODGgVnWqiRpQYPWctRe3S5XKV6P/W8yYTXbIUFOaQaxaaCXcuViFd0iS0UHt54
 MY8Zk55KRdaVR9rOGKck9nIshB2nZk9HEl6UBnyLBWRrjt6jKRpjamBIPrtHlcvFLuOCSUQ9C7W
 WCSRv073yXLS4t5wjf0OUwL5qGTqHjuUM6wdBXar117TrAvXZHKSI+Jck9jWBCno4FV3tpINcL0
 CCeOAaJof9KTFsErTLM9IqJ/u6g9K5CL0ZTeghvFM5OV1SO3s06PqMbyRbwkq6HbMeG2qop8y98
 7XoSBAyjAbbIODYrOXfkP6xKjmH58otSKfFAjWDIClSrvCceY6o2HvyViCsT0bRSjy+P381TKhq
 G3zvx5JUpHmbaUxq3PHLPV0TUgh8ZnzffM2MiJxz1KnnMZUalBYwX3ZKF1z1NcLyv24PWLYkk0R
 V1lhZlzVOrxgji9MnbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5MCBTYWx0ZWRfXwasCZyOxoi6c
 VF4cJUq8Wv+CVIJ6X01WAh1kvDi4tUuDqAsl5KE4lskJCnoSDFX7foovreaVirNWagaeJH9J142
 4xisNAFz3gBtoi0NVLcmOpS3y5N/zy0=
X-Proofpoint-GUID: 4RcjZ7B9m0-kGlAbqo_yg4woXPmkWbuM
X-Proofpoint-ORIG-GUID: 4RcjZ7B9m0-kGlAbqo_yg4woXPmkWbuM
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4cc691 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/7/26 08:09, Jamin Lin wrote:
> Introduce Aspeed2700SCUState as an AST2700-specific subclass of
> AspeedSCUState.
> 
> Currently, AST1700 and AST2700 reuse the generic AspeedSCUState.
> However, AST2700 requires SCU functionality that is specific to the
> platform, particularly for interactions with its coprocessors.
> 
> Introduce a dedicated Aspeed2700SCUState to provide an extension point
> for AST2700-specific functionality while keeping the generic
> AspeedSCUState unchanged.
> 
> Subsequent patches will migrate AST2700 users to the new subclass and
> move AST2700-specific code into it.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/misc/aspeed_scu.h | 5 +++++
>   hw/misc/aspeed_scu.c         | 8 +++++++-
>   2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


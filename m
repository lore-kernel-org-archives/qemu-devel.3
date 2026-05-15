Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24888CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvWO-0003QO-T3; Fri, 15 May 2026 12:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvWH-0003PK-O5
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:36:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvWD-000464-JZ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:36:13 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBjWBj4008246
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 16:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ty5KWDWyMwAHT2zES/eRHS2ypg4oFfYgt2gM7KfKQ44=; b=lVowoCgK8gndZP0B
 M2gWh2e61qo1Q6IDMX1wCggHTdCliaLs00Vz5ZPsJHWByPE+mlyVMkwqgtuaP+Ce
 PTuHFOXpkcXE3BTLrWhhMkQJwJoiapyHcMzAOPeax0qNSvoAWmCnM5frZNDPCQxu
 m31QzaO8Dnf6qW+txFYHM0ANMzTwbUF8JZaNh9D+UDkCD4JfriNXFT0NCTcANQCZ
 AwFAT3Df6l+pTrvOLLmV0onuweADRiPoNNJSa6LCaMIpfS2B5WvZsd5oOc9wysIV
 SyWeLt1MDQP0rnKWGeRNAL4gRtIPfryDtO+XgF1dNhWY02QYjF3b2aMQwapTpVjS
 LYxyug==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1sv2r9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 16:36:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso11810592eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778862962; x=1779467762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ty5KWDWyMwAHT2zES/eRHS2ypg4oFfYgt2gM7KfKQ44=;
 b=LHGPgmo5S5VhZUV+NGmL8T2X5JXJW7FgtaIo6by4By68s8Lp4JGk7iCVJOm60AFSCN
 76spZ+xRRNp/897ExHviPdkvJs/y5EECF16z43BHA5cTrp6UymY30T3xImy+nCQ7s5+k
 NDdwlLubuH42idu9unk+rFPx4LcRVmAhbI5NZW1dHuLqZIm0pH1i8srCN9e89iWrDyCj
 Ogf3AN182jRgvcxuHdyuWA1CSnSnQ6sA/pksULs8Na1FfhTrpfHDgb+UImnbtUFC279Q
 dliS5XZ9DF94MHrE+cn/RomxIke85ga18tcP9iDcXsjFornjghfoGvLGYVBPX4vbrzT9
 gueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778862962; x=1779467762;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ty5KWDWyMwAHT2zES/eRHS2ypg4oFfYgt2gM7KfKQ44=;
 b=k8MiyrBY+ItO/I9/zDuyaL2O88tBC/24Bno65NrZRGe28xSLqorS2KpGjBifER6f84
 v7y4sBucbVpvnJeSB+ARKydnS5o9Z5apNQshOuOM/Fg30MRxeBfwWLLC3sN3WtcuLP8a
 FxHkEAIx2cIBj/NaiouHIivQwqH0wQ9F86sgoNVykCCJVttv2bmcG0EkKdblEM0Z20bY
 GnxpiApQS0137M+5eOmRlZozDmcPs49bXeUxSMQMi17psZX4pAwyk8lBPrCgsbsDOnp6
 xrSXHQzkiXBV6pYxqHdgQUxix95+o7Uul88wZKR2FhpeDSGkfvUDshuKYv1aAA2QUCNH
 POYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xadcCu7f72BaxFGJxob5aadanjg8YApzdlIQRporx3cP5rMTb8wAloEwhT+t7lzoTrxWuWs9mJCZ4@nongnu.org
X-Gm-Message-State: AOJu0YyuT/YGyhfrVtMJtuGkWgOqyo2KC37LlE3YZ5c702xegigg74K2
 xesLKT3gdVwQygG8ls+6gWVDklRZ/LUdSkPr32pBGys5T7F8l1N1jybR6T+/aiYT8EiVI2IZiz4
 YT7vZY/Y88X2boI9qlp9Rt7xy6h+oHSAM95E5IRt+rcsRBkj2ZGK53koMJg==
X-Gm-Gg: Acq92OHCNSOnIayifr1PHA22DlGDgcbWU/LFayP1LZR15W1bJQdkn5Zua795IZWu/cp
 035IRKXj2PTHNODNFfN9YjkSyYIsuLN8OZvFSYKKCq7gah827U6C1f3XJvJEBXa63RsHuO3HMN3
 vYeqIvI3IdRQu9d/IeKH3o2RuuRUIMsb4wMOYeFP6l18DQ6cz4Wk5gBnhtMai4IWawo6Om2PL46
 KRXbneYWlfWFsMz8SbIgQI0fRh2E1ztrfyEIqiGDJiPWoOtn1hzbAdkeVCP76Glox8npaJsC0Vh
 OEhU5NlxkFPVctSsF90UvSQ8GD5zyM/AHUBDOZhmgruhyZLa+egvtHg4pp10ws2UeWSLxMbprR6
 S6snZwqwMEkNlcFRRSpnMRs+lyY04nYZRbxNd4cSlpilF3erdxj3/MhmkdenlIOm5MvlUsZfXEN
 ODjiPBIO6Aswyg1eSFHVH+QB+F
X-Received: by 2002:a05:7300:df06:b0:2f2:8857:180a with SMTP id
 5a478bee46e88-3039813cb43mr2392066eec.7.1778862962335; 
 Fri, 15 May 2026 09:36:02 -0700 (PDT)
X-Received: by 2002:a05:7300:df06:b0:2f2:8857:180a with SMTP id
 5a478bee46e88-3039813cb43mr2392041eec.7.1778862961775; 
 Fri, 15 May 2026 09:36:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978b3cb2sm9568439eec.30.2026.05.15.09.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 09:36:01 -0700 (PDT)
Message-ID: <3b5531ff-7769-4cdd-87b9-defe92d7f1bd@oss.qualcomm.com>
Date: Fri, 15 May 2026 09:35:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/20] hw/arm: Build ARM/HVF GICv3 stub once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UG3nWmmVRhvXBzhQkyS1nxdU7VVgUtOC
X-Proofpoint-GUID: UG3nWmmVRhvXBzhQkyS1nxdU7VVgUtOC
X-Authority-Analysis: v=2.4 cv=cZPiaHDM c=1 sm=1 tr=0 ts=6a074b73 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=duA0RHWJieNxBeiJALQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3MCBTYWx0ZWRfXxi6epFTL2rMT
 CbY8alMGEQ+ywnXw8jFRrC4JcMnI/IZorPpntCz6+ZsmjmWKR9Y0daOnZxqNfDsII9jZppS53Fa
 0fbSgqy29q+/i3SGdwzBUj28IT3uGJxAocIpQmkzEFKaFYWIxTPd8XW2tkTuDvX6m4HpnQd762M
 IbODqMX1gumrypOjUNPyTBLEs+Kzau9oGxtR9WSjPnm4Ex1DtdWwJeT5HKNdeVq3rAjtHWaO1PT
 xVTWlkmIBZvqtVv9XYp6JqjH1H3RIWefV1l1vHbgH0OBzo2767lMf7sAUDKIJGhx5xEg41O+wRi
 q0YUold/5q9lASJTMXgv8SLGgvFGbDcfFZQjVfSvbA1FqtoQ3ZegrVlYh0ixdIDicVQcvHtyc/N
 ayAbfxiAwcZoCx8cSeFsO+MQDsS36/VTnXrDhwroF+aHQvcSY9JLA0dBBp/6qVEEoQefOURq3YG
 3jno5HUSHJS34tJNS9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150170
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/15/2026 7:10 AM, Philippe Mathieu-Daudé wrote:
> Move arm_gicv3_hvf_stub.c, introduced in commit 48396ad6ce9
> ("hw/intc: arm_gicv3_hvf: save/restore Apple GIC state"), to
> the global stub_ss[] source set which holds stub files being
> built once for all binaries, instead of one time per system
> binary. This prevents symbol clash when trying to build a
> single QEMU system binary:
> 
>   clang: error: linker command failed with exit code 1 (use -v to see invocation)
>   duplicate symbol '_vmstate_gicv3_hvf' in:
>       libqemu-aarch64-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
>       libqemu-arm-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
>   ld: 1 duplicate symbols
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  hw/intc/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3688FC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyV3y-0002rp-GM; Mon, 24 Aug 2026 09:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyV3x-0002q3-59
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:50:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyV3v-0006Xd-EF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:50:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OCup9L4077617
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yKbttNmCiWAC8/kWZgONDgEVS8vSvMX5quD7Tek4ryE=; b=pubo48l1L5ZKVCdy
 jVUvcKsEm6E2lJmdb6ydHyhy+mqRnAzsKlGAoVPnMw0EPViBmg0MhFcK5IWtTnP8
 Zc1r/2LyzH9iYorddbmyowZorKbLk1L+1ffHcCjVWcb5wNgnXi3SZ45a/oBo1hvg
 inypKLH1P3/RpTcc1/zkxPtFAsrpzNXpN5M/Q4ApBNUGL/MTi4XEwq5do4yxqS00
 uVe5ha8hKYUzoha6fuk+n+wXT/3KKg6KzRgcMfYs2sdmR3tz0vKSumKdkKX43N5+
 qBKCSDjNFfNrMDBu4BQMwVYSiLi+5yu9SUfc1GXfHSNg/SXvfahzZXxGEIKDi8tO
 48FA1g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jpk1w1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 13:50:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d30035dso24299021cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787579405; x=1788184205; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yKbttNmCiWAC8/kWZgONDgEVS8vSvMX5quD7Tek4ryE=;
 b=KURzClNRez17U9jI/d2Ay8TYtNXRp3lPAwSdWfKtsemyKmdG5zpCiI0GxW4doNgq3I
 sDhy3zpBvxnA04fekdl6B6SFjwduB7jovHU/rQBwQ9Cox2A6NtwYr1nmGRLhXYgEyxu/
 jFJXThzPOtCUWuMeoUO7LGS3PEjjlbeKOsD23Y/ft0KLil+aEzW8w1jItqAd4f0PUt0a
 SIpPQL3g2rUUC0NuGJbtUf7/TUi6SiLceog60p7cDChKPiuuvoqkm/zZ8p9gaQjoCzEH
 55amH/YlS0Mcyh4OL/wM5v68HWTcezjoukozu0d1pM4Ik20d63upa98A0VJICyrB0r3F
 qJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787579405; x=1788184205;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yKbttNmCiWAC8/kWZgONDgEVS8vSvMX5quD7Tek4ryE=;
 b=Cx0DsCMK+8WPH/f3rZJOa34nixEotLREjoSQtBBkxNIVNm/9Guag5dhsTYcGF6O0QP
 pZE2JyKMaWJxXZQKQgcm6wowekN4EmHXswxsy/2HX/n9pQ3yh3GeQ/bAT5MtKLSOwU+L
 8i9rzUOKepe8wy7CIWHADpf9akE1HL/d3LAzZIUE1tWd+2asibX3YPUeCZqaYXi/4zW3
 OhWxJ1/CJO6FTLMh3C/sbs7RzyxEILVDD2Xcc3JDzDuxyDeeRbIv9wYwjuR0qnDeGHr5
 QDGmwjQzWc8ZMSoWUB+69DSBfNQfvERZKRL7sCpYZRrfRK9lqlkd73HC+juoKubwg/mx
 hLgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmcTQue+Cac+4uF4ZltnCMDmYFgVe00/BNNFDLMUMoBAdFhzYOyhaO615PiM5fsKz7SLzKIftQqY2X@nongnu.org
X-Gm-Message-State: AFuF++k+HBVUFiNEt9q0DE0V5VszxkNfOftG50v0mpq3RjMTvBDW6prA
 l9QMiDFByj8P9OaNAi1IWJzKLXm7sZHNqw6iAulIuMESkLzuh3Yyxx/zZto90q9N2mUPNaunnkM
 /zSBuRDa69//NefRIrHW/skGe1P/5zhaUkmFxgaCue1/VvzLNDqw0sgKD6g==
X-Gm-Gg: AR+sD12D+xxgXa55a5iMVEDzV8EwRfj3ivPAevVi91cV2QAxoj50coRj8ckrN4k808X
 oyCwysvbTk8Fjw6m1itwWxZHUYZz4csU5EdRx4V+hZJYcphJEfojyEnnfdacXvO8h+HMDDX18CF
 FbFWES5GUnyTPiaHce84Xo54tFD6BUylU9fFSt/aZdyhATR+hf8ZZEAd5owZYR7FVg6X6gMFyIC
 h+Soos7quH3F5DOmBff8Nn3cwy/pd9Lw2c3thYsS+/vU0vNLjRcAWa148UI3SbG9qs0k5Btc3yT
 8p3G4iTCjQpKhCPLzny2omFxUXg7O+p9bCI883hKrC5pu3wmu+lygvqkIkeiSKphrodfUj+PtCs
 WC10ynzpb2d+Dla4p+Blkw33pv4OEe0Z++m5CcjfCXywSQ/5mPg==
X-Received: by 2002:a05:622a:82:b0:52d:86ed:8394 with SMTP id
 d75a77b69052e-52e09cbb788mr182756291cf.36.1787579404537; 
 Mon, 24 Aug 2026 06:50:04 -0700 (PDT)
X-Received: by 2002:a05:622a:82:b0:52d:86ed:8394 with SMTP id
 d75a77b69052e-52e09cbb788mr182755531cf.36.1787579403924; 
 Mon, 24 Aug 2026 06:50:03 -0700 (PDT)
Received: from [10.254.188.74] (102.19.205.77.rev.sfr.net. [77.205.19.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499bebfa94esm76644165e9.1.2026.08.24.06.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 06:50:03 -0700 (PDT)
Message-ID: <f9267c28-6efa-4bfc-ac62-2efccf83765d@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 15:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/intc/arm_gicv5: Regularize spacing in
 config_readl() switch
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260824102805.639072-1-peter.maydell@linaro.org>
 <20260824102805.639072-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824102805.639072-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNiBTYWx0ZWRfXx7QY6neNCmWI
 B5sh8R1MmNU8KWJTDwGi5IzqSLuZmFdZ9LGStywl+gK+T7C/DarddRNJba3Sca5+1jhki35KUdA
 +4yG0gNJFzM6VENUf3OUiM3QpEpRsxFHakfg4+zdmDXCsRRHNmCTbN54a3kbaqFjg4wE79+O+t0
 COQTYs2dkpTRrMHvr00h0Huqitk9upywY70gVvyvUb4NnBVfeD2hxaQQnGc2UmF+PUoLH+F+RiB
 jG7elmDVR0YvE+plrGwuCRsAzBQiwXSEtJv8HBEMlpfokKYlup5I9O/nCEg3r1mgzNSM4Krul0N
 GChXKrIWQX64u6LDUBz6jgWKeyA16zx4CbSrXLNwZayzApZbN8zY712/vv/L68i+ggB5LyFp/13
 ZRm21m4jhPzIdBwcudOCp+7Z1m3AgWrr/lOyX6pXhbroLfx0fIR127Itvsil/RxFOuEuUC5AgoW
 Hi1TS7vFXb43wAE9FZQ==
X-Proofpoint-GUID: nhKlIlnFiedBRcjohhPNR7iQ2q15dHs6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNiBTYWx0ZWRfX7vufXO+WL8Fe
 3wcWoAtRO4iGQYeElFdKETErCeXj6bz+utj9NLpcsrKwnmGSSNLLyOlZIZ+WnIeqfaBA0JyuZ+O
 bHk648iB7SXql8WTxl+y2yJTX9ryQMk=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8c4c0d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=3Njm2NGJn2tjTLCKQaqOdg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nhKlIlnFiedBRcjohhPNR7iQ2q15dHs6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240116
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

On 24/8/26 12:28, Peter Maydell wrote:
> In this file we don't put blank lines between cases in switches,
> except that for the switch in config_readl() we've written it half
> with blank lines and half without.  Delete the blank lines to make it
> consistent with itself and the rest of the file.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I figured probably better to do this before adding a bunch
> more cases to the switch, which virt support will do.
> ---
>   hw/intc/arm_gicv5.c | 15 ---------------
>   1 file changed, 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F10FC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzr38-00043G-9Y; Fri, 28 Aug 2026 03:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzr36-00042w-Ir
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:30:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzr34-00057L-Q6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:30:52 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S674np1043667
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PluVpFDua57aNL97O1v9dEqAafYRkfrTz9xh+Fkm2aY=; b=QIdyeIqrVFV9C9CJ
 a6FDO5awBzoPxLc7O3+IULfRV0D1/95m/BUWeZ676EvThpVP2bdPtbkpiXuEqzed
 dlNDSlilhv/hMA0gsbIYsBNL2Qf8LtdO96M5RUQqWQB+e6cy6dqyjoVDqH5LjTWD
 ffqRsHMT5tn0ShMx3LAuY2iGOw9oCcVov0j3Wqk30ErC0YFGrKR451YmlHLW00Gt
 VZT9n5ZWA1bjImEyZQLNmYEic/L43SeDrGc63RpgOemjETinnLHEi+YOd8QDNE/x
 NS5w7CRe0WBOHZ/rnJ24MoBGCAKBK/F101Bn3rg8W+0m+6QoY9d4BtNBTGVQGsmM
 EiI11Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc2smc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:30:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8db414c7so9999471cf.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787902248; x=1788507048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PluVpFDua57aNL97O1v9dEqAafYRkfrTz9xh+Fkm2aY=;
 b=KyV8K4FR/dYQA5TqEx0timVyv15yKCGSgXN7k0GeYn+Dxk/S/tFHU6tDO1oP19OOpg
 NAYc/oCDxZ/VnQhRfs8X4/Fi78gh0APZU/WFU4YGoNnAkJ6L11S4olFDlkj4Qtt6oYxl
 G6PBuDGeWms/l1oV3kvDzSlLiGvel5Hp9LKEI1E359byuhghMG3kXfhAzdmnuzetNBzq
 t0IAAJrPxnEZ2ONttu2ZsYogwJdVs3ksQcpi7nrv3BSECN79TFZeu7a0zyiX+OZ4HhC0
 hpJnmLXJP0hkgIu0+gBDN0ILt/S66Djk2fyVhOIBvbc+TQhC9SkPy9baRc0EN1vb58yR
 w64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787902248; x=1788507048;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PluVpFDua57aNL97O1v9dEqAafYRkfrTz9xh+Fkm2aY=;
 b=UqJhVeT9iRZRgvEWOq3DnDvzip59ZoHqEAMDpAbH33A05w3vbH8YqeosiFJ9XcfucX
 E+nnZbywKhzbAFsX0L1+v45ntcrHLRIyH070rMpYhLQKLoZg4DHm/USPBeHkZd3PcKNA
 eTUwgJivbAahbjdPT1l9cnyIqYlaFzhaepxJxHDdud7okM/CgoSHHRKO1aJ37bW13QZZ
 xQIEhTm9qMEZZXI5jSE9isS2j3lfuPWLPBL+Rcv7BkeglQpua2CpinBCSZV7KNASZ2TC
 xnh8QItuvi39ILB9vgs5at6BRQj76hiwt8lY4U4noCfsJH4ASrDxWrEV67Bh/0lqrO3d
 QIPA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpnsk+k9Qstj0L3TVvo4PvzO9eO1fMVsKz0S9M3jrzQfOQfwFPblT0JzKiacfUGKffKAN/e8j4m4+P5@nongnu.org
X-Gm-Message-State: AFuF++mHA4JBEnIC2o9PcyaRucrnGpLLqqixP2ObbSG7M5PHrHMduOOj
 R0P40UczlH/la1R+FUbJw0zbAiXejvWpe2BeVI01Kd4aoR9+KdD1FF9ZzpIxotXWE9VkOM08v4A
 JM6NRW/rPZ6OxUOm5geLBHQBdQ9rHEl7VXKBOeNfDoz/QJj+yOuEz+ezFKg==
X-Gm-Gg: AR+sD11fQ1aimBzIPbqjIUQeSMgQhGCTahLBRF9br+2ST/Hv53rQUdelPIpXVrIC7+L
 gun8YKUmRanw6rhZ1v7DdHERfmiSAtztXvHwFpbLkzbkO6g0HXH3oBhSQcqg+NKYLYgr4iqJvai
 ror+DEeTu5vK7Pf78qBkk9yBjF95dZWAj4NlaEWw1bEOD/9OqMBbtA5UW2iUm3Xe1c3reZv0+Pl
 vh2VO2+RM0EB0zP03ia6NEAzsSLNZceBmCdgFA+K16GwIdh/G7OG9nVZn5EtOmGllOcg4/r3tiD
 j0cJTJSthQl6Y5V/znwi0xJIO2ZUpCRV4POHZBxQv7vtl4FCz4KoUioetfe0Rl3hqNdnlwBk+sQ
 LuUeOqdGej/S4pAUEGf0Ind186oYUxPrJtw==
X-Received: by 2002:a05:622a:89:b0:52f:a2b2:2dcb with SMTP id
 d75a77b69052e-52fb9445df4mr49840241cf.18.1787902248116; 
 Fri, 28 Aug 2026 00:30:48 -0700 (PDT)
X-Received: by 2002:a05:622a:89:b0:52f:a2b2:2dcb with SMTP id
 d75a77b69052e-52fb9445df4mr49839581cf.18.1787902247492; 
 Fri, 28 Aug 2026 00:30:47 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49cc61cfsm116723435e9.6.2026.08.28.00.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 00:30:46 -0700 (PDT)
Message-ID: <829bce83-b28c-4d3a-8bbe-001652a85b83@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 09:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] target/arm: Introduce cpu types max-v8 and max-v9
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com
References: <20260827041557.775080-1-richard.henderson@linaro.org>
 <20260827041557.775080-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260827041557.775080-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA2MyBTYWx0ZWRfXyQtRK6aKLuLI
 8mgZJMudN0NhKQyNRfIVWKrOtdosDtial587fhtXDe+txKv8Ih6QgM9YJ4AfL3cxOkmPxwvufTk
 RPt5D7O9L4ardain1YEJKyErqhar3hqsfSlOVLxugbNsiJ9XHMVMQRPUzHZRRftk+RpMyCeghvp
 0RPy82EM+9K0dS+6ylzyAUtBZleQyfaoNfBjWGgeMN8qaxwLESx9F2xrCPJiPyEP4C8a7hwn2xR
 wkwHLE+FV9Uwu3E4Hse1zAddIpMJOF4ZO++KZPff5U96XNtLUfkVgnz4t1Ran9Zb73BGJzcJLMy
 VpzZJb4sOwSATa5eAo/8l6Mggvz2O9KQ1pu1Xh8xi0O/Feu+L/S2iG98OLqvl1mjTG/a70fEIWJ
 FdhePicgbvwv05+DGTQqwAU2Xw6LKqrEp7guLN+aKDnjjOlDxZAbT25Y9JoWEszXKcfY+TcBWj9
 UYNK2tk8Pd613hUzmsA==
X-Proofpoint-ORIG-GUID: frT5KI__gO-o-XREd6hSJzi0Lt40jL9U
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a913929 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA2MyBTYWx0ZWRfX3/MUot89HPsE
 ii3dwTPT66ocfE8DcVi5ul+n0dja2BmKh5M0oL//f1A4cC1hJekwkgn422b8QvEfekK4Z/zUpZx
 Gwz39ApjFOCA1si5yTPi7YwqbF8H85E=
X-Proofpoint-GUID: frT5KI__gO-o-XREd6hSJzi0Lt40jL9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280063
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

On 27/8/26 06:15, Richard Henderson wrote:
> Introduce the names and allow them with the virt and sbsa-ref
> machine types.  So far, the cpu types both exactly match "max".
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/sbsa-ref.c           |  2 ++
>   hw/arm/virt.c               |  2 ++
>   target/arm/tcg/cpu-max-v8.c | 11 +++++++++++
>   target/arm/tcg/cpu64.c      |  1 +
>   4 files changed, 16 insertions(+)


> +static void cpu_max_v8_register_type(void)
> +{
> +    static const ARMCPUInfo max_v8[2] = {
> +        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
> +        { .name = "max-v8", .initfn = aarch64_max_tcg_initfn }
> +    };
> +    arm_cpu_register(&max_v8[target_aarch64()]);
> +}

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>



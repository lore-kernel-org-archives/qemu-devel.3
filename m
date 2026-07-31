Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36791C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wphPh-0005Qx-78; Fri, 31 Jul 2026 03:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wphPc-0005QV-Sm
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:12:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wphPa-0005nA-LE
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 03:12:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V67DhF2960535
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 07:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zwqwJYlVzSvFuv76ZbXiaVPZaVp7GOEuu5uNBk1yvz4=; b=eIbUw1cGaXLKfhe+
 LBsz5Ktomrbb6YZlPQcf4liXM5h78kPdtvRkn8ixcBqos0h9No1EaBGREd+EFcWC
 Oz/QUyw/2EurKFlbO9T+yxmVfwokTnEM468QCqEJqG25UmjI4J4Bk7GGmh+XLR/e
 IF946C1cV9TUH0+lxeq0Jw8BKUIa6ZsfUwTuWLyorcXYpwvI0dBioZ1io/4w9Bom
 rTDM4h7amXEn+iCXheoWWVZUY4j6CXsyxvUjp1ueDzKLhFV012zhBOgPML0RWD8m
 CsDBvJUTD8Nv9CqFygQeqTzTelWBSEbKOs5yJzCNuOaedknkY25d/s2DWTBaKBuH
 P5SkWw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp5kg7j9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 07:12:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so13211541cf.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 00:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785481923; x=1786086723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zwqwJYlVzSvFuv76ZbXiaVPZaVp7GOEuu5uNBk1yvz4=;
 b=IgwPV3MMjmUsxDnA+dVONIIQaJlshqPYF7YEhuym3yv3Y+Kn8h6rthOV4jEoQG9ugu
 01172Y6Jt/6XhuTo32JTAimKggkUBdBQ8PH3/9/nBNBkCp0oWCgpLJU9LxQzGj2o2J8m
 GhOr4K6G69dlGL4ivcxhjATNdnXq0riTV+6KqmQn5ko3SS89Sw7Fl19DLadrpwrynksE
 hZCcF3ld/SmWLWNNiH/JK74TsegGjYGxilRmlwRcDcDM6fZKQwUVRUuWCBmtZe6iyOQw
 v2I0WzWvDzoyJmcLpY7G7UpPxs6OWvdldH58jOKHzPaPPXncB5ya2QPS7CS0q2pUMf08
 xGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785481923; x=1786086723;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zwqwJYlVzSvFuv76ZbXiaVPZaVp7GOEuu5uNBk1yvz4=;
 b=XaykI8QsT0Pcfg+7B2+mLcp/QzCKl93yKy/Z7ubIw2RgU0gQdwkfejvnsOHC29ayR9
 Uh+YwUkx0fxLAr5wyujeZkBwnb70FH9ifclZNsE4pB2WYlN1SomBNQE153B7dZhqgqPO
 7CA2U4UUA0wHj5irFxIcX5dtzCxVpLDPl2YzwyC2UwrtDw0Nt8ydrxcMi8wzvZynrjys
 QhmM+RfqouH7BMbIqkjuUswq7R1OZgGv7zEHez2BW+yNIWVo4ypbXVpeut44eVfleXWj
 HfsIKQhcywK4JkLa84wsstuIaXhLsw40aiqRvVinpuERyTqshWIaU+RuglG5PI4JGQ67
 rzGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTd1f85pCx85QaxifJwdvaBj1c5UK/Qr91BbLNWNB9Lao1g+R3uBrsXTZPoNssdRtuwaxJFWBsnpUa@nongnu.org
X-Gm-Message-State: AOJu0YwmfjRU8NMKvgWh9+Cr7pLFsj+LvP8WnZlHbuX4SCry+kjk865X
 toX2xbtcpxqS/m9mLqJZqqfXWVo4z0i6NVYLe5Bmt/XFMt1PvM++hxDItYtOoa0M7hQmZvzV15p
 szVbxLWJUYN98m5dIwqQ56GbvTNZJm4f8FZNyEZNU08RFYkItoKlc/mYeJA==
X-Gm-Gg: AR+sD13jkpm/fxEVF0BT3s8/ol423qZEIM+jnKGWC5eZl3YQgBfcvB6muJVinVLrchh
 wTMbII1U5IIBPPKrbc+vanag4/EfskI5fKY5XRyLgxW9tkrJJ5p/4iLNle5Prbs2xwXU/xaK3Hz
 g3I5L8a+f6PZA/6ig/E4mb6a4qx8sHynaL/JI77riFg6Ba4leMKsS7tWK4x0CjXE414Ruyx/EUw
 P0F+rzWPbkuRVMBstBEliODDBzxz8Kuzogk/R6Nyai8t/2ODkEDai8BHpxs6N9LRal5BxmNs0fd
 JJ+my1RndHzGUkU4TDIPXqg1S1YUctSbhZ/xsXzFWz7CkEXmST8KNaDIcgyj1jaXoxycm0Kp8j1
 OcpKqJjhaHZG5qw773LUmwXCaAS/scp7dtqJACdxRGeu0LYKnupI=
X-Received: by 2002:ac8:59d5:0:b0:51c:775:c175 with SMTP id
 d75a77b69052e-52b4b033a03mr10787951cf.40.1785481923088; 
 Fri, 31 Jul 2026 00:12:03 -0700 (PDT)
X-Received: by 2002:ac8:59d5:0:b0:51c:775:c175 with SMTP id
 d75a77b69052e-52b4b033a03mr10787531cf.40.1785481922482; 
 Fri, 31 Jul 2026 00:12:02 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c63db02sm437415a12.14.2026.07.31.00.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 00:12:01 -0700 (PDT)
Message-ID: <1150f1a3-236a-48ac-b22c-e91ee178412c@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 09:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] tcg/aarch64: Implement revbit{32,64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731000503.170446-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfXyu4X6dvl7ncT
 L7pn4YT1n3/2ALhyjI4chGqibk6ZhC8mZeFlFEAmh1uWT9wJmHAAtO4uGDc3kvfpdIoHstmUVMG
 TqkhIYbWiT/G9mhr3m7awdRSpxZ16YU=
X-Proofpoint-GUID: mkxr2apIX345jsLh4c-JOyqLjU-n04Os
X-Proofpoint-ORIG-GUID: mkxr2apIX345jsLh4c-JOyqLjU-n04Os
X-Authority-Analysis: v=2.4 cv=c/Obhx9l c=1 sm=1 tr=0 ts=6a6c4ac4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=9jxvZFSeuu5kULwckcUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX0oV7XEf6jpCx
 vtciyzpwn/IHxKQTaFBebr/EGDpfX7BNKQi88w3GFfS6iJAOpALr/xvpFac6zViTeWTGgspDST4
 5rAkVX45fBj7dlPXw9TyMSgN1V+AMEG004ywk+TjPbdwbVCDD6SKo52FtgJXqGoAPpGn0KSO5SK
 lJCGocpmBZ75xj694qtvtEyod3Gl8LU56L+MEYryYAcPbSOgDT/R3zKiSDLf1h5Hal88tg9aGGW
 CeZJupPx1swyJvwx+KQ3yvUjWBvAkZlAvevbIizU9ebeO2PbHJHnHyehLFRaSpBK7yvlmKQQSGl
 5rlFGQMZ7qjZeI4DCyXz73mgpuO1/lCsXTcl+FSkTrvCEJjn5CIQaVTnrwnujXBFOjr25JhX9pO
 2EChwkOyCPQz9AtqrKnJTbCu1y+xzpuBeTDQOkfPEITa1FI9vYCmneh2rky+U4svPViT0F5jOft
 VN02EwEQCZXbUCaRKdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310050
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

On 31/7/26 02:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.c.inc | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +static void tgen_revbit32(TCGContext *s, TCGType type,
> +                          TCGReg a0, TCGReg a1, unsigned flags)
> +{
> +    tcg_out_insn(s, rr_sf, RBIT, TCG_TYPE_I32, a0, a1);
> +    if (flags & TCG_BSWAP_OS) {
> +        tcg_out_ext32s(s, a0, a0);

Back to my comment in patch #1 about having bswap flags defined once
per target, that would allow that kind of change to be done once in
common code, not per-target once. In the lines of:

   if (backend_default_flag & TCG_BSWAP_OZ
           && frontend_requested_flag & TCG_BSWAP_OS) {
      tcg_out_ext32s(s, a0, a0);
   } ...

> +    }
> +}


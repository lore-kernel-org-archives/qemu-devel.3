Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AF6C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wF1-00047h-Di; Mon, 31 Aug 2026 03:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0wEx-000470-Cs
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:15:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0wEv-0005Ci-0g
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:15:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52cXt1445820
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TexHRaMKEy5XNUjL8BWTyONPyL0y20AjQxh6OlQpuhI=; b=oDyKma8lOjZ5E9+V
 rJE2GEEpeuZuhQV6/+ev1YjNDsOoC6yJV7rJVQu+McLpn+nBI7WXLZPAZn+3UwAo
 Ik5su9uwcFgkCnJVFmPaKGsDFine2vHeQc3qIs+25xHInMkC8kXzdmZabf/JOtAA
 i1vE8A/qNB0nVvimGKZVoi1+cGJH//2RWX5LJIhdn9Gh0sbeJXVOzZdO2vtOQupG
 AzjNbkU98jcaVQJhJytL7p0FL/1rwJZpsv2DYplQA/sLYXmhL3Z3cLmgM1gkTKGM
 V6RGmBecZTyQXHwqDFDviHS1ceYS/yG3DA6aBRk+J/FpwXr9gtFFRr2Egv624NNj
 h3yJPg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrkgvxut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:15:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9382f9430deso497199485a.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788160529; x=1788765329; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TexHRaMKEy5XNUjL8BWTyONPyL0y20AjQxh6OlQpuhI=;
 b=K3DxebBS839gsvjfP4mSmVAsYaNgH7AME78jea+PKB6tfrb2KUUlms+Jc6jzXyW8p8
 SgdBbM2VRb5V9mIYM2LR5+UqehugAj2m7Rvxy7iWHH3EqLHa5dzyczOoNFGg3SugV7QE
 x9k5NBPsid8oyXWer6U0eGRF/70CNzsvaRmJAdSKD+/5vo7Pph+IPMS2pKk4VUGdsoEA
 EjyckVZsYVGyyRSyvKXEeRS8wMFElL3YsMa1BpHwRc7SUe1YoBAVB+TB7geE29VAQilO
 JcqRh8UptB1LJ5aVTofB0PYAAEgVqURAqFP9MEKnyKnX4SwnicHQ4k/Xlz5CntNcy9CQ
 8BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788160529; x=1788765329;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TexHRaMKEy5XNUjL8BWTyONPyL0y20AjQxh6OlQpuhI=;
 b=F7I9DA0lrGD3ScOt/lEV2VD6L6Z9+PvZ1PnnNHh+uyuUccPuoNuApnZ+itSI56aj5q
 Hskon5ZKRtfzGG3Sw3WLEHStMC78Fxqp1aaG5PKUzAXNjDUaf0hsi+cHMnei88W0ELQE
 hLEfBg8AK0GpbOQjRgx+Sg3/NNWugiCZFVjbB/7H100YZ4WuUtIOWtQHxOYD4Fwqe4Ir
 th1P0u5Jp5LhyajO9/VPKctcj1QE7FFZNyJN0jIdLuM3zFPxshdhDogNppZ6zYGO+pmf
 ZGkiN33prriKzU4fHoD+eChkztu24Ho6YC9Lr1p8882IqGr6K6KkTY82Mc074zMX04I4
 zGRg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJObi+3z4v51iPoPGsnTt64peRfbRKW5WvDO4fwrtZVxhqSw4yg2YM6ph1/tK4hYtdIMOGJ6Z+vk1V@nongnu.org
X-Gm-Message-State: AFuF++kcjUbMnjxKR1lARYUJfLezUuQwv8nqYjds7FzYwiABpgtjQim7
 FlMZk21zSGh33EUp4YTcso5c3KvxX+VTxL6blel9srbPPDP/e4YwiFeohh037i4pwGcDILH5+L/
 saTlOswzSDi7H4YeQtu9OjEgp/b12Tg88ihxN8lI3jywnwZn6PKAy60NbKg==
X-Gm-Gg: AR+sD11feGRS8VeZqPMsHhyxYBSMAHIiB+GmH6yX2SA29WtixH0deWKn3nLDJdQTIOT
 9TyErFMtl30f6Jgb/z4XgB3v+Iime0VEGp5BibNiB100uzFZa8JtxEV8qO/Yf3exchty4g7hiF3
 K+BOg3S3L0oGlL8BaNuQ5R0lbB22tK2W34UmvRjQckH+BwN9Sd/dK46V/E8Oc1fo0IHpYkKcpPQ
 6Hixo5h9/WfwTBqmHXWXWhgPOCIQGjT9YiQDgjqGIh0bu4jfhWeLbbs+3/rhp3YHRK3Ww6nc9fs
 YKGDmv9tjGSuiuXMwkt8D1GfoFToXHVYhPTntq8ecM6OSrB5E7zwiHIVWj1HCyq1TWX3h8xLHXp
 Hlx3Y4/CgjzZZO53BMg/lHwweiI975nsEYA==
X-Received: by 2002:a05:620a:486e:b0:938:e95e:9377 with SMTP id
 af79cd13be357-9391394c9b6mr2119990485a.30.1788160528897; 
 Mon, 31 Aug 2026 00:15:28 -0700 (PDT)
X-Received: by 2002:a05:620a:486e:b0:938:e95e:9377 with SMTP id
 af79cd13be357-9391394c9b6mr2119986085a.30.1788160528373; 
 Mon, 31 Aug 2026 00:15:28 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484397f33fesm7280596f8f.15.2026.08.31.00.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 00:15:27 -0700 (PDT)
Message-ID: <4b9aa2f9-8546-4aee-92f0-d27e935be53c@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 09:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/47] target-info: add target_config_nitro
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-26-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-26-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2MCBTYWx0ZWRfX+WtjTl2f1D6T
 JoTBxYmicFtHzjdI6s/0PjL6gExSf/mRnz0bVcvI1+ul1VOfIVmtS/aOLEka2MjxCWoX7fdoTWP
 wsTSRDEtfgVPHZPLsEsNF66LbIopSiLPF1hmQYXvN8YPRZ2ehps4tuQgVBOlDmCo96jdaLz93M0
 RXscN4J1hydjmqbH54fI1hME7d6bHnvcgJshN1POzmwoUvwLvGNd8ir0iHjbY7aRV9x2TKoE8O7
 WQnfJbLULIHz4188Y4MAanAZk3luVX87q+f6Zd5k8SVq7W9kAlWp4YXZI+OSIIGB57k/oN8jtEL
 fO9kooMSmEI+JhNeXfRRZfNRqQqjv0LawnTjRBt0cxXu9erwHPWGQ6C5BtIjektOgr5NrDexc2z
 5hQDgp3uD+sSyHW7tNktZbiNn97jSfrlrDTBL0KjNAmbxkdW4srKs+q9N3hsr+EDb2hLJnfpBpx
 bU+bxRkCVeQMsbxDJ7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2MCBTYWx0ZWRfX8QJ+D00VEClN
 mLSoI8yWAiqr40h2sMmGUXwrLV7jttmb6SuVxT7P4/FTFmqE/JLOEZGpDSHGt2jYvSJUou45kqA
 dSBNbegcrbD8p0FhnBVI3DZJAvPFM6M=
X-Proofpoint-ORIG-GUID: VpFB4QTq2mNCia1Rhwd242Buj30VHRFh
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a952a11 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=M0Kvg9QYqNqYrI85TV8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: VpFB4QTq2mNCia1Rhwd242Buj30VHRFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310060
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

On 29/8/26 00:58, Pierrick Bouvier wrote:

Also wondering why we need a special config for a target device.

So why are we listing we can not plug? Maybe the bus Kconfig is
missing the accelerator dependency?

-- >8 --
diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
index cfae85920a0..2e4125f8710 100644
--- a/hw/nitro/Kconfig
+++ b/hw/nitro/Kconfig
@@ -1,4 +1,5 @@
  config NITRO_VSOCK_BUS
+    depends on NITRO
      bool

  config NITRO_SERIAL_VSOCK
---

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info-impl.h | 2 ++
>   include/qemu/target-info.h      | 7 +++++++
>   target-info-def.c               | 3 +++
>   target-info.c                   | 5 +++++
>   4 files changed, 17 insertions(+)
> 
> diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
> index dbd7a5a2071..4f6c898c707 100644
> --- a/include/qemu/target-info-impl.h
> +++ b/include/qemu/target-info-impl.h
> @@ -33,6 +33,8 @@ typedef struct TargetInfo {
>   
>       /* CONFIG_MULTIPROCESS */
>       bool config_multiprocess;
> +    /* CONFIG_NITRO */
> +    bool config_nitro;
>   } TargetInfo;
>   
>   /**
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 579c43332fb..d775c94d1e3 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -49,6 +49,13 @@ bool target_big_endian(void);
>    */
>   bool target_config_multiprocess(void);
>   
> +/**
> + * target_config_nitro:
> + *
> + * Returns true if target defines CONFIG_NITRO.
> + */
> +bool target_config_nitro(void);
> +
>   /**
>    * target_base_arm:
>    *
> diff --git a/target-info-def.c b/target-info-def.c
> index 9d51371f766..96fd1f8c73d 100644
> --- a/target-info-def.c
> +++ b/target-info-def.c
> @@ -46,6 +46,9 @@ static const TargetInfo target_info_stub = {
>   #ifdef CONFIG_MULTIPROCESS
>       .config_multiprocess = true,
>   #endif
> +#ifdef CONFIG_NITRO
> +    .config_nitro = true,
> +#endif
>   };
>   
>   target_info_init(target_info_stub)
> diff --git a/target-info.c b/target-info.c
> index 5db2a6049ac..67127da16fe 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -47,6 +47,11 @@ bool target_config_multiprocess(void)
>       return target_info()->config_multiprocess;
>   }
>   
> +bool target_config_nitro(void)
> +{
> +    return target_info()->config_nitro;
> +}
> +
>   bool target_base_arm(void)
>   {
>       switch (target_arch()) {



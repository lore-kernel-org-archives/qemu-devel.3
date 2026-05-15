Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B4BCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvrx-0004I5-Cz; Fri, 15 May 2026 12:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvra-0004Gv-6I
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:58:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvrX-0005Pg-Uq
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:58:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBVFwP4022529
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 16:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SiYnbhkzWxNoStv+kBFCjshH4zyRmSOmVuhQ88DQQXI=; b=MfXN5588U2XBdQvk
 MGpnmOIwiz7IFDylNCcUn41xLnBAw0FetWFvllGp92JQWbCNylIHk/7ynuViUWet
 +0BohmcBRpoYPkBBzvKZV6HLMAseqj1PFN/BzoA7t5I3jUna0gi7JaF9DYd7ZxkN
 VsglT4DRA929bfcsrQsgOY8Rjpn4XTHTQVqCBuvD+DajsWB7FsquSgNHDyLIC3EC
 5MlzDzc+Mv4QRj4BYj8Dt0TzTdlrUepqq+ufVFF/DgpKotCWSoqFPOnDsL7FsoX8
 o/OmWflvbZ+lC16n4Ja0VheykW2lbXCAeJnE8XlNf8j2tOTjn3L1gek4spFySF6C
 Ol8BmQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1rv44e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 16:58:09 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dba1e866dso1027394c88.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778864289; x=1779469089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SiYnbhkzWxNoStv+kBFCjshH4zyRmSOmVuhQ88DQQXI=;
 b=LBxWQtPAWwSLBq7yxHtel5SysZX2otSzfr/ZOsAFrmSo+kdI90fGb44pstsHFPkuNQ
 8n7n5bAG3SDqB2BtGP+3yDmr/ZuJc/kz3eL7wWALESm5Ihdhs/+DPncy/JHBKb2MiQ8D
 7xgq4vs+quXV7czTrT/jeGyRtfVdUqcSDRsVqrTKxMxOahA/VC37YIw5TzJUpj725S3U
 gIZiB1GFDnhp50PiloGpbe8Um3EBcRsqrCf6wohraOCLFEiu2xrXrgR97IxNIu52z8fq
 hkmU8u3DVN/zxEAFSSjMbktCZd/xHmpFo4Qv/7l3k5FmkwvPdbQOjNuDatC3l0DW00QI
 XjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864289; x=1779469089;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SiYnbhkzWxNoStv+kBFCjshH4zyRmSOmVuhQ88DQQXI=;
 b=L72Z9VNtwmFF9iTR7UTKXkUvVsQGt9qYJZy4g01kc8AezBkPkUgNKfNOuVWGg1u2oU
 q2F8L/QgWP/u5gY6PEhK8wXw1671k+6p87gZogCKTZf4LUbqB9QT2jdY6GN02AFMSNR2
 IHkJ1WUO3bE2acl4V7/PFWztDf5WEBYUo7tvyiokgiId+j1RLuc89BKv21guAHm3peH6
 Jed0jE5h5V8Pflx9WEx8UZ7OyHCiOW/bkTzGZyfUXy4JMNtmR5H4hcwBilyeY290zysr
 GSJvkLtNpWxp4mkfi0SvIq6lf+KuEJPo6f1RH980RNVW3H0Hgf+I13YJPFsfItfQ1PmD
 m6Og==
X-Forwarded-Encrypted: i=1;
 AFNElJ+heOsLEgeU6AaY7dRsaGAfKZFfrKBdjYkv0PREf4I96k/C3h1uon4dyuEaFxhjBO5Pk8LgwnXP5yiz@nongnu.org
X-Gm-Message-State: AOJu0YyLPd9eEp9VoMXns7KxnhkgK7pM3GWEHSETof7R5CCljzXwDgNj
 L5okDXYuGrZcUXnNJYuoSy/ry2yS2HkXm54V3Oc4yyt5uObkBq0A8vhvIgF2+4i1mFghaGwM8m3
 dyD3ALRtIppbPm/SeX9UdIaLTr17Vvx2H6cl17LUlzb5yRxPRU3PjVL4E3Q==
X-Gm-Gg: Acq92OE+hg6FPAtij6if8YN8cRnB1rKCOej5I4HPuFIgD78I9dLto7CkOCWMK+KOmfw
 FiaicqEjV1T2tWLNk8+ZCmhKnphyYQExe076nhFTdkto16A0Cu0mdKnLCWqIrshAw3vJxS6kUfv
 SiZzfwzl3Brf5242oRQbzdPBMGUaoIUnCqdMT6BFI6IAGt6WAglSLNi+TIzCFbgQtOuR/ZchWhW
 Wtfuqn4Dn5vhTZ2nTGRMCfqLDF5fp/rdUcJ9sxZSM7SUY7emYgINSicqb4PHhExU1paBcBEkH7i
 ASafHgQZCuGGt1h5I6iGrcpTcPkNUDc1ucn9BirbyyLt+2/cLhkS/Scx8y+PKMww7+NqX37oLQK
 HORTB6HyQWA516TkzpAsmRbgncFAO50cMSy1Ziru1aZE372HFkZhjZwlx4y9HyNqR7DGPrU4hZE
 a9+qiZsiBj43+YaA==
X-Received: by 2002:a05:7022:45a2:b0:12d:c3d8:1f95 with SMTP id
 a92af1059eb24-134c880b6bemr4313995c88.4.1778864289130; 
 Fri, 15 May 2026 09:58:09 -0700 (PDT)
X-Received: by 2002:a05:7022:45a2:b0:12d:c3d8:1f95 with SMTP id
 a92af1059eb24-134c880b6bemr4313982c88.4.1778864288582; 
 Fri, 15 May 2026 09:58:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2ea78sm7641885eec.6.2026.05.15.09.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 09:58:08 -0700 (PDT)
Message-ID: <b63e0247-0837-4c0c-bcb3-ec6c3ec42222@oss.qualcomm.com>
Date: Fri, 15 May 2026 09:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/20] hw/arm/raspi: Initialize 64-bit CPU types during
 DeviceRealize()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515141032.3271-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b4yXYUoMciHxy5iO-YxIxUqpL9k57f5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3MyBTYWx0ZWRfX0BvfOiZkST4c
 JtdlU0x5xtLBdMy0n+xGZrRcTf54u+QWbUGOfrRaYArdayVIWsbXrt9BNYTvGUtm6DUYGT+MM1P
 lsvN+kDOuqvGvhXpmqOus06cFUED45t701asQFIZI7gWmyxuacBWc/dIA9ZwMYjtlZYhaT6c3MX
 7rXetGWV55P/Z1yVsr49H6cTTboJWSNh6/S7Q9r+++Z+kZhiuMNLNAo8Yh9FhVW0QKiLs3gYjUd
 8uYHgpgHjW5PKwf1QObMX0sesV5FrH9cnWj8sahNiZjh2gin2ip8B/HXB9lRuhN3sj3nNKFxxuo
 Ei9os/e2AHRLQiTExZgwhkax287D7NxnQPIdCxDdA5EPnVOlTohOgCQCQMTmLLW4PReoM4IMWFI
 MOeyS4j9/D7ee5Vmj0492v513ukNbK9TN8qujYbv3IURcWoeLfMTDOVwIm/oVGQrPyf0lerrgNL
 xp0PnjLa4942+BNZDng==
X-Proofpoint-ORIG-GUID: b4yXYUoMciHxy5iO-YxIxUqpL9k57f5L
X-Authority-Analysis: v=2.4 cv=JPELdcKb c=1 sm=1 tr=0 ts=6a0750a1 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=RhXjfXvIr8CSHO81VaMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150173
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
> bcm2836.c models 3 similar SoC: BCM2835, BCM2836 and BCM2837.
> The BCM2837 is a 64-bit only SoC (Cortex-A53), only available
> in the 64-bit binary.
> 
> If we build this file as common object, all BCM SoCs become
> available in both 32 and 64-bit binaries; however when running
> the introspection test on the 32-bit binary, the BCM2837 init()
> method tries to init the Cortex-A53 type -- although not
> realizing it -- which is not available. This can be avoided by
> deferring the CPU type initialization to the SoC DeviceRealize
> step (this is safe because nothing uses the CPU type before,
> only the GIC access them, just after their realization).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/arm/bcm2836.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


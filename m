Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D360C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24Bf-0007o8-Q6; Thu, 03 Sep 2026 05:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24Be-0007ng-4q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:56:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24Bc-0006bz-B8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:56:49 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68392U8J4078999
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 09:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IffPYeIX3/OB2MEqgqUkysuLNtl2dCqXHJEn506+rUU=; b=K/L6uW5ctQNGjOr8
 u/un3HizcK/EhhlKiZpd3HRCIXLKZYgowVpBIZ08RMP2STZkmJPxY2ZS8DnPH/sz
 sfK0Q5Cv7ZIaTuL/WzBjb80RXAE8VLpJfrfrS3SD20mRhGz6vDci7OZB0Zak9RPx
 FZCPZGhm5t6AoBTYPbNuV9iGHu/VaQ7DyLsy4kBIXWEFbD83QNulwqAVrWcahOX7
 actsziZO52dLh/sUmV4BtLNOpJkr2vRa/DAa4GuvHdENTBc3Km0U+mVD/mVtKxwa
 KdEqMsF00IkZ57jutnChtnGYsq3wNCy6GxvoQ4PlehmtdlIa7zJjAAOLldGh/1BJ
 qyjBlQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdvavs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:56:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930edb4362dso363715485a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 02:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788429406; x=1789034206; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IffPYeIX3/OB2MEqgqUkysuLNtl2dCqXHJEn506+rUU=;
 b=bun8t/o2eSru7CiddDcDhCROq5GLgTz7dzJ0E8/CEfuPo+gkjQirVro4DChVuWyEuh
 Cj8AEgdPb96Qz8184DqchtmOkPsEA7XQZbveOhRvAbn0ZHSYlT0MSxihaauH4/rFznmI
 5CwJDYOAebJ1Nd2KBdrrcJhm5qOBQuOTEvrTEljEkKeaPVeWZajRtIA9Ig8dVvOStAfv
 0/M6VtOVwsGm+r4p4kFkLUYv57fB9o1SAjd+mI0PAjrgjtrqMMesuHMg571DK7fd2u6v
 F0xAOmLSMGxX3F+jyRmNr03eTNQx1Y4xP8XUWfrSL9H36AMZSzj/FYpL3v/aGcLrJxuI
 HRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788429406; x=1789034206;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IffPYeIX3/OB2MEqgqUkysuLNtl2dCqXHJEn506+rUU=;
 b=i0AdAyLZKGXqiB/9dxDETj6UaPzJQBkg7xbr6APOZrmn1yzYsiiIS+1LUmGWsyVYHM
 IwM2vmlKNUQ0ZN/EA45TxJMbJqSuYgZaklv7Yd25xr5dttXtPDK6YgIna6AAIKSGyJWu
 pofiaI/xiN5YgbGv5fCNzmJxPYTLStz9PdbAg84CLOeqMM1J0EnNXRfzQdV/6WwlFob0
 8cXBpWaaUncpylLgOZ8RyJnPdiCf8VXG/k6WPmNLdn4D4aBJ913kzP4yJfzkXvT4mO0N
 UEjgPCgTv17Zth4cyfKdpLmkzg4VBEwZCeGLMcrtRwm76eXdl48wS6orTG8mx2hCcR0Z
 Rteg==
X-Gm-Message-State: AFuF++ln2e+xwen7/aJzVlt3mA6112GWAe0cZOY6+pTf9ZCgfF2y6zO8
 +TzJPUu3pnNz9o7tgNGeyU0POfY6STq2aiqAhSD9Z8rL/lurxOcCBPt+5XbB4Sp8gnrYUKQ4+0m
 JQr00CAL0DJ9SDOhOj4Ghft/8M+Y19ftm2xhRhC1zzJpwk2rH4XY8HXbnxWeEyKUFqg==
X-Gm-Gg: AYBFou1lNenZWb3Qa8v2i71RkYauIcKRF62ET2SHhlc2hCPm3WzDKwNAP6BPCQ39p2N
 fkYOeUxbrMLIOdnmdpKAkhnwBrMAnS8JUuqH+7WMp+kZxf6qcJXTnmkeDFszUiXnqyAiAS1EQwc
 /on0v3gqPs+AxamwbO4zzKG4DhzjsVqdU9xTmX47NEDhNpsnk3wBIsvqSsslWyckQdgGLl1htsC
 oDe4qhNnBCX0qDwoX7fu03l3VLeJPUByck7Xh9hlvECHiKDAQAcwIlUu7RVKGmQAj2J51qrYR1R
 pk1NDH2EpJ+mOzm1yLDeNzKv4iTv/k+9PPMUzhCsAZfeVLXf7dX3w/+700hrxuMnzxdc90ISxGg
 eb0MJeyhx1BCro8QFA7Xm7cdDBnXn0y3L4g==
X-Received: by 2002:a05:620a:269b:b0:936:dc16:206b with SMTP id
 af79cd13be357-93960f28e7amr1072051385a.26.1788429406456; 
 Thu, 03 Sep 2026 02:56:46 -0700 (PDT)
X-Received: by 2002:a05:620a:269b:b0:936:dc16:206b with SMTP id
 af79cd13be357-93960f28e7amr1072049285a.26.1788429406006; 
 Thu, 03 Sep 2026 02:56:46 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e13db0sm12921544f8f.0.2026.09.03.02.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 02:56:45 -0700 (PDT)
Message-ID: <11dc8cc9-cab2-47c2-ad5e-a63e293e0a43@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 11:56:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] accel/tcg: Make halt-to-exec transition explicit
 and remove cpu_exec_halt
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a99445e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=3m0WcAEBdxdH3kxK-OQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 28_FzZdiDeNfDpDNgb9ZzUgh4fMjyeva
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4NiBTYWx0ZWRfX4YOpERbElXQj
 NGrpiVVNIUnn6rFt40LjWV0BIFoqzG+Ozna/jseOzIj0y2Evf6g/qHHsW/UBjy+WL26JaLVh6rm
 ZRmllM1BnY49gSj5VCVS6ldF65sbacKL41tHpRgW3T+FYdbWKtRP37kLbb050+ZfYoLYQOF7rRz
 pAQ79XXJMcU0jUIdeADA3578HEFu5em4ib8DyH5B36vrEJ3IB/61668w19oBH0scQurkyAZvjDs
 HIe1KakbKIU9k/9UEd5nhgnSZgfIgmlZSUteaId91e7uKGit+z6TSNV/sMoTcfzWHR6LCstpbCo
 2D1LGI81TMwSl/OWqKISkVKEldWh5StnA/jRT6dpVd0l8AICHdSpu0yrEB++K/oLZLfJQp4S01f
 RXvljdJtFqx91Ah88SX49fEim2rBvUfEWzsVbjkZ5Mdpf7X80iwqk6vfjwS0PaosLnUHf5NiDqL
 SltRaB8Pa6iyVBPpJtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4NiBTYWx0ZWRfX0LQ2OwvF14CX
 e3jzgLGwqGdHmb4/ntnynrBqezHgDxqdQmouEQdLH7Rwpz5F78ER/djjL9QxoRBJT9ge34fS527
 XpVVghdpchmkxfRV3HYYOIzqVbjB3GQ=
X-Proofpoint-ORIG-GUID: 28_FzZdiDeNfDpDNgb9ZzUgh4fMjyeva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030086
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 19/8/26 16:56, Philippe Mathieu-DaudÃ© wrote:

> Philippe Mathieu-Daudé (11):
>    accel/tcg: Rename for exception codes named @ret as @excp
>    accel/tcg: Restrict EXCP_HALTED handling to system emulation
>    accel/tcg: Check %halted field in cpu_handle_halt() caller
Queueing uncontroversial first 3 patches (reviewed).


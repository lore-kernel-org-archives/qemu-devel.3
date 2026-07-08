Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E2AC44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whT5i-0007be-FU; Wed, 08 Jul 2026 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whT5R-0007Un-Pz
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:17:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whT5Q-0005Xs-5V
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:17:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C3QxJ2617300
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 14:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ziZQrwp0ov59MS6yy9L+hIzjer9WxIkNkjVKeGmK2N4=; b=ELDahV0Qc8WWnlDd
 OCOgOsZVuC60W01L1I3keLyRn22zYVy0oQPsNBAXDH0DGDWqpsvKxSvixw/Id9Dk
 eiJfepctNm5kyNhHq7W5v3jUrciSqf7fTisbRTQLmBuCnqyqzLIcxeVnSt/EejzZ
 d7wzheLN2i0U1MvthZk9tjiRleTpO3e68G4SnA3h0Zv04V8AijIrXrGJF3jmV5AI
 D5EUuxGeHsWpd3PkUk3fsuGEFGCL6rlWyVQwR7tRkNwAD3A0CjFBFZcg1XRPuZc9
 6qq4mpziF3XTGJydl/Wc2ZrQjYNbu9c3ATx6ER7ZupkHZI9kYoi80LGM7kqSz0GY
 vx4WYA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9gqw9w8p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 14:17:13 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ab036818efso142860e0c.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783520233; x=1784125033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ziZQrwp0ov59MS6yy9L+hIzjer9WxIkNkjVKeGmK2N4=;
 b=VcRhL7Mwp5ljPuIEdb+suXSx6DUSaiJrqAjD8q1IiITBAV2Ooy+hbpWEvHSb5h/g20
 SVRypiGIolWAeKehFeg2JGkReVCxI7sZvqcDPFbNSqgrBvo1iIjoo38AfJQ8PazANuFK
 b9dxkdsNVZiFsobh2reFkDBiDPXu1LWqqyhM45PYAJILwkQ7UHW3oZoTKDmrRzXnfX32
 QN73uUztPPoN0Qv7a12Ge8WwoPzBqC9zE6Hvc46bzTW9+3JnAfdKy7UWxVuyNrgTzRz5
 RIqxLdN9ZZt5fNoG26uG0m4H6jKodbYSAZQDIigGTuZeJqUAd5WjS7htRX8xyechR04b
 J9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783520233; x=1784125033;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ziZQrwp0ov59MS6yy9L+hIzjer9WxIkNkjVKeGmK2N4=;
 b=LeqGdlmKJOGvHvrv0MbeKExV+C4oo1Sr4oihisnihYIHlcj80JAgfQ9uLUqhfhoZtX
 xy6Jq9XSt/RiF5xo6MCdVwryeGHvJO7+tKfykii0KDJaw8EnNJKwxDUCLF8Btq2J9CVB
 X6xaKBiqEB24C0z/VfvwK5uibOab3KHXY3l9bhxjUVM7B8/TPv7YrxMTH+Qc/MWP/0kh
 dt226cR6BnoIoPWZscCzHwJqvAruaFKvZHacI/Lp/kK9Gl2WQT6NZdxhnkK2USzSOnX4
 BcqtgnGWpJREWulY/VoqaWSGYyr3lGVMBkE/7FEuxg7905PL640A1id7+aTD33CBwaPh
 wWKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqj4H2D+ZG8oEpA5qYSzx7+OTPiGDvAoPwNMlIazu92jffob/doMiVvwZLYVttUAPT8GQPUVSwiSW8B@nongnu.org
X-Gm-Message-State: AOJu0YzlPjhJY4zbLDt5qACpQLO/oD8xycaqtC4xrNNwWl8hHoT3dJkm
 ekFH1cQrTwnskhaL3LmPudWWUcIFxQIF5YJ1kJzeJRoblbgZpAJi0FG1iA/7q/o2YXUmTAKAGXY
 1TAPxXSw6kapMfa8fPQmQ5jGMpDJ2uSLsMvJxw1sn0TfLJjcn326MCmdJZw==
X-Gm-Gg: AfdE7cnW1rl+2u8vIMihS7NZKJFHvH6w9pqSSTOCnP13+hd53uUjzw6BeO5/9P6rbnj
 IAdULECtRy2h+5Fb8qGhLAVxsls7a7T/e5hd59KLbOKxibrM0utHM2xsQiyY6ciirlp15NbgTyy
 hYscPlwnb3EjgROB7+CI+4CbHc2PugSgSNhyE0Kur+G4+8Lg9cZvBl2qU04f8Ij92HI8UeSDTUy
 Vcz6iEtcToJWucgxAh+UAMtofcIA59zKGZoW83SjlSEdGH4bn1Wz5bG7gsLHW0zphE4el1/3RtW
 KqevqM4qM+50a6hqlj2L8w9uWsY4d2ixWXyocDrtqyFDotTF0c4SoUHAwWTEGWg5aNOXH6gMaiM
 qSJMaZbGYYL53ogpbNB+dIEaNBOlwNnerlwPt93Gci9Cf9W/QdXJzOTd5i7sCJw==
X-Received: by 2002:a05:6122:1d55:b0:5bd:79be:8f3d with SMTP id
 71dfb90a1353d-5bf75d907fdmr1242918e0c.4.1783520231161; 
 Wed, 08 Jul 2026 07:17:11 -0700 (PDT)
X-Received: by 2002:a05:6122:1d55:b0:5bd:79be:8f3d with SMTP id
 71dfb90a1353d-5bf75d907fdmr1242568e0c.4.1783520228362; 
 Wed, 08 Jul 2026 07:17:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f4ef53sm161721365e9.8.2026.07.08.07.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 07:17:07 -0700 (PDT)
Message-ID: <429da31c-b829-450c-85ce-ff87d05a12f1@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 16:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/devel: Document SSI dummy-cycle ownership
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260708132431.43869-1-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260708132431.43869-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX1EFiO3Zpd7g/
 AGBCqz0zfj42ixbFuy2S/gN70yVTpXVBdAyzWqc62pzLhX67r1JJf+snFNH8zU3waeL79tPYQg3
 SyVrsyQVVlhqeWcdgH8Kt4bYze/iCtJ4IaXkNN52lKbI7MFWzTXpSkqUYytcN7Il+7cwWJ3P06V
 2ise1JRkVrv7Ja7yaJXB9YdY/nkihSK56FlmsH/c2wIApEA35EnKmTKjZamXtcmmvJ4GMDcz9TQ
 CBqTiPr8mRpkHYDZlHopn/hPx223HXGkqh4TaiQ287CJmC27dQH+/8yM4S2qhJJfhQE73JUYBOO
 kNkq5BikcDstUiIW0GHDjvP+vTpKduQWyH8t8w3t1+CgdWK9ZL/JVxKi/3g+3oZ+bmLkamFAZH/
 mQcgRnul9R3mkYhW+fA0pKitYRIJ38NILadFvyBxSL7FRHwYuQgRB+NKg+vtS1IXGlwyx3ziRa8
 4On/0/+p/p29MhdmY9g==
X-Proofpoint-GUID: vIOwwVNJy2stPAAdK9y76hRrzMQh-3rh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfXxYZSaKilngmP
 BRshlDLZYFjzSFlc1sXPuzMbdTcGOCvUyn8tuSKzVh7hNqs4mNs/3lEbA0xK299nWz3+giy3Sqc
 j6/CTIv0KMuBU2nNMJ60n++YoeiK1aU=
X-Proofpoint-ORIG-GUID: vIOwwVNJy2stPAAdK9y76hRrzMQh-3rh
X-Authority-Analysis: v=2.4 cv=Wf88rUhX c=1 sm=1 tr=0 ts=6a4e5be9 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=rsnQfCYnut5FQG7pFV8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080140
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

On 8/7/26 15:24, Bin Meng wrote:
> Document the boundary between SPI/SSI controller models and SPI flash
> models when representing fast-read dummy cycles. It explains that
> flash models own command semantics, while controllers own
> hardware-generated dummy transfers and cycle-to-byte conversion.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> ---
> 
> Changes in v3:
> - add an entry in MAINTAINERS
> 
>   MAINTAINERS                    |   1 +
>   docs/devel/index-internals.rst |   1 +
>   docs/devel/ssi.rst             | 132 +++++++++++++++++++++++++++++++++
>   3 files changed, 134 insertions(+)
>   create mode 100644 docs/devel/ssi.rst


> diff --git a/docs/devel/ssi.rst b/docs/devel/ssi.rst
> new file mode 100644
> index 0000000000..864b5d9320
> --- /dev/null
> +++ b/docs/devel/ssi.rst
> @@ -0,0 +1,132 @@

Missing SPDX tag :( See v2.

> +================================
> +SSI devices and SPI flash models
> +================================


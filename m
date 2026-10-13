Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08F6CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGbJw-0006JW-VE; Tue, 13 Oct 2026 08:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGbJm-0006FW-9w
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:09:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGbJf-0003CE-IO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 08:09:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8PC9c3054908
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jDJpC0q/u6BCpQ6aMn/H9EUUQQvUxLmODL92KW0qpm4=; b=gIMyqtbwsRWx/PO4
 2FdkoYcOKT3zQ077KjnqN4SfeJgceuZlfmXx+mukBJJmckLMlksv+pWTUPs7Lafa
 EM67ztEvizyzZEmf1eYr9SxcTcEckfkYNiJIwAxMTAlTmiVFVP1Ikqo8yaTbuSBr
 TlrwdQKyvq3v9FdTpOlxyGfN70rUS3mgM8dqCeGzanpbR3kCB1eBH1UVSXE2+ha5
 LRTkVU5EGArGnBdoL3PrjT0lvRC26QAFCqk0o8B3WRBgN/2PgB5gQqOknoYoNhgK
 Y8AclqEkl6X93oo2MdWfBqBccEuAQukolHo+APGg3EaZV/rR0Xpk3efKVMkQNHu8
 f1uadQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aev6uu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 12:09:10 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5ce86cc29c6so974573e0c.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 05:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791893349; x=1792498149; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jDJpC0q/u6BCpQ6aMn/H9EUUQQvUxLmODL92KW0qpm4=;
 b=Y4xZawEcQSXZfwCcRb9AopfTUkoztCRBFVlRcd3Y6gE28oe58jNx1W3Zm5rcsLgJaW
 WM8i5xg7q6Re726Wqu7RxkRo5/yxtnMoVXa0yg/QEb7nLZ6s8Vrx8ztH/eRFwS58ThBj
 WsQEdacSO5GroLHN60T6vgggBTkF87Vh7Kph659+4A8+FZ6icVE0lJXciBbazNlNLTU8
 591VlI6ixUjKj5jJLge8LU3cSCRDXJdQLt31fHDqDvHgy5flc4ubuB1VQJIsWko9z/qI
 lXCy1FJ9HojhOOtC8Xkmu9aFbvL2sqL9ReG9sVZOt+J8QRI47m3TMOi/6/iM32Ew80oZ
 sIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893349; x=1792498149;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jDJpC0q/u6BCpQ6aMn/H9EUUQQvUxLmODL92KW0qpm4=;
 b=VesrnTbUaMIAOawIOk0kTjigftHTaRZbo0xj3sEQFOAqnq7NPD3jichc6ASVNLaGor
 iqPwuAhCQGfogFpWYG8J2SE9LITEWKuzn1N0Ppv9ulzSIesm+sgJnyK/zFtA6PVLq01l
 cSIza8SNdEetvw8tjZ6NPARpCPeHaAnGFD/FjG/FEsndzjbE8+h8tFKtfYoLaX0GlNGC
 8OptC8ZYCxj9YJU9OQ/YZORaG1JosVbKwPn/Ykji3pWQkOErxhfDb915GYLl1uYg5gyj
 aOxzHcBPG5Mg9c0AxCl6rHTmdpwrTca9ONmt0ITCN45xk5plV/JJ2SfgeNbVJsTbkHyd
 tAlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTAHlS+APWNvKwotoJvnZF0uMfT9w4K5dN+ATVUsG5Er2tYG8MOJylbxtqNcpahttX5tA+EsyZBtKB@nongnu.org
X-Gm-Message-State: AFq9FYKA3UY+bZYjwLIYnoF1kl2oc0JzzQGjHm9vy1kCt0/yIN6g9UDK
 GN1DxaQefvPPOHCmVVPnRPsIMQLvzlsOiAJmvi/Ds6LqnH0xduYuYPGA0Gg2YXe3KjrEh+yiw6L
 eTU2VoAPjMkNyrfDZjDRQm+BVYYMWAPYpIjCEX+WKJfOV71rCYKmeGREOeA==
X-Gm-Gg: AYBFou32dBPK07EVLtWa8A69WJEt4/VTCDRR07j6BiqPifZnYG/HuXKnSFIOb50CAhk
 lrPPdOOPa7ZPEbuVc7jqx98cZvQvd8JeanwMSJxSH9KBguJKYr0hTbABBg0XJKkdsQmPFlBuQaZ
 0VtW1fiaBfB+dQBO+BebU7oxOJ2wsh9kIBkAaMtUHKZrTa5NRh5rBBKasuaNIi1lQi8DCIvurOY
 EHqDSxB1Thdw5RNsgD7oxYgFfaSS+OVd0C574cU1cRpt6xdfmWfg/pnhnvTtQhH2oIdJy63Ttgx
 PBLVMpQZR07KggeAP5NePlvErXeRYuXHRJyvlFVws0ex5B9eRqBP9DfL9i+zV3T+DSOp8VKOGdv
 G6c9haCvkrAEBAzwTBfXzdkEcLT3WVe+GCg==
X-Received: by 2002:a05:6122:3a06:b0:5c9:a60d:327d with SMTP id
 71dfb90a1353d-5e91f518afamr3728695e0c.17.1791893349294; 
 Tue, 13 Oct 2026 05:09:09 -0700 (PDT)
X-Received: by 2002:a05:6122:3a06:b0:5c9:a60d:327d with SMTP id
 71dfb90a1353d-5e91f518afamr3728654e0c.17.1791893348748; 
 Tue, 13 Oct 2026 05:09:08 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm657347675e9.9.2026.10.13.05.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 05:09:08 -0700 (PDT)
Message-ID: <57f772c4-ed27-42dc-a70a-a68d41e1e399@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/86] hw/intc/arm_gicv5: Implement virtualization support
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PLpevsbq90sIlXBx1AB0ZiKwUCxjOmos
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6ace1f66 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=1X3lyv8EHgKgKI1ETugA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfX5/8oBLGutBMc
 r48JXgYrXc2IjdP8MqohW9KvJWMLSXcWZNYAZaJIPB35Uc7386/IySiQetzp8Zmj5l71lNS7aOt
 pv5ULFdR8MXlQoi7PrzI3Pgevix5Lxw=
X-Proofpoint-ORIG-GUID: PLpevsbq90sIlXBx1AB0ZiKwUCxjOmos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfX0u3YRYIvci89
 dfAM/IGhAeUMSVNjwnHFQihc7UjvsdCEnvYZiYb6TgftQj0Kk0nChWJhQ/81DJl/t8k83gNyu+F
 hwK1TcsZq2EZYTHe3kLWeAhDHkYWVFmbyiiFhtvrftWn6izqjSMfRXxDK7EltOGW4lE3XXFXYb+
 fodDQRQTeH+5UveiTRvwbj64RKBeUXJou2CIthW7V04R4+r4LqLhuU7+A8V9MQPqVZf8zza3rCJ
 BDka/wg8aOoKpM5NSohWiSIHDgCye54xYVNsIEtKsUjEFJ4Cyd9OzuBAD9OI+I9xufFcTJBYqRj
 O++26pUuJOLcDYubzwc4En7bTDQ+xo0bHSmGo/sgOiQBILe1AIP+slOtdMLZl+S3NMxbQBLEmOS
 XNTs++Lpg6EvOiiBGOkV7i2wha2WtcedLJzSfyRIwKxMJVPyMh7hr8mQMODiyMxYGPDv8lHdJwq
 e+O28F3hIlMj2+JpW8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130048
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

On 13/10/26 10:38, Peter Maydell wrote:
> This patchset adds virtualization support to our GICv5 model, and lets
> the "virt" board use -machine gic-version=x-5,virtualization=on.

> In an ideal world I'd like to land this for 11.2, but I appreciate
> that it's a lot of code to review and only two weeks til softfreeze;
> we'll see how it goes.

I did a "quick" review (2h...) and couldn't spot anything beside few
typos w.r.t. the spec. The overall logic LGTM. Better if someone else
can have a closer look at ARMCPRegInfo fields checked, but since this
is experimental anyway I don't see any issue having it merged for 11.2.
My 2 cents ;)


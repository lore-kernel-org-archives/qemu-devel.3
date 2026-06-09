Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25093CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyBN-0005A5-Sc; Tue, 09 Jun 2026 11:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWyBM-00059r-4w
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:16:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWyBK-0004y7-M9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:15:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClZfx2183119
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 15:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +3vPeeDBgiCtrR2jVl1XaEvj3UXf8jqIHGEiFIxC0u4=; b=LuC6IXPJsb9op2az
 uzdmDIJSTmpSDnLA54dDG9jKnf7z5Vw8oI9RM8Fu1IWqCdYX3ltrRy0YAwzXn6ye
 BYqfN3JZLik9jbxMMxzP6riDkZmGBbVdZ0aXO7se+ZErjRJ45IW9bnUeesSTPoUl
 yXEmoGs1Km/Ud4nQB3x06gZSStRgkybz2oOOsqk5hUzHKSswS8JmgEqtcWk+tcIi
 9WQ4fGKEVF5cllEOr77lLI9K7cOqY6Xk9v1xQkqc08LopODLlfKlb65ljOLLeZSl
 xbTmqv8VxmUYfAjtwHSmdMg/yHWE9GphEk/uoDcJJW7LU7AL3J8qp/ULJV4APQAJ
 Dtn9uw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenra53u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 15:15:56 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-963907b1ddeso5807143241.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781018156; x=1781622956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+3vPeeDBgiCtrR2jVl1XaEvj3UXf8jqIHGEiFIxC0u4=;
 b=NBnTGz88tSWtpeYdpbMIyPYnesCjA8onpLiA4CIM5VcIayvkeIbLE1Tj5MotVBys4Q
 ANYKFHm6YDzwL+qRKUkSLeQm0sEZhf3B932AQdswcJOSW71/3CC1U7azjke995VUbCDK
 CjFvku06EhxtMapp2LH7n3vhz631Tn97/bM/EUhjCVQuPxzJky9u54zxryHBLJj3b/A5
 NfVnQA57cPUrkLLwK1RhA9hvrhU79khpXEH7+EpwkVOhJI6Qd10kK1JsuDqchFOiu/iu
 pvGfWprc721f2Y2ht2s9Bx/kQgeKBGcichCc/V8K5ubN7QJd1br1xHi9EXBG0meHMK0+
 w43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781018156; x=1781622956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+3vPeeDBgiCtrR2jVl1XaEvj3UXf8jqIHGEiFIxC0u4=;
 b=VDQUVRadJqa1QGft+TeFfGo4do16XmcKaSLYSFDhGkUoMoZYzBDWfSDY6g8eKeLSBU
 V+hpPiomLO9/ekUghbptEIKi9VhPSjw0sD1uXeI3ulMJe1Kl+Exr2rTGQ3+o0QlW7z8e
 B92IL6OJaojcJeYjcfP4ZiB4DYo4tgG7SmBff9JSTkw2fHXOK1W2/qIdI1eqzxNKkwsK
 LJeJkDrH2r+whfmecKB+fLgcSgGv0w8EanL1/YwhIRnmEusD3n8DwuGCCQWtPTUuv996
 dEcdiy5NzBZkQW6El0w44Ok3SjEtomN9ZqjhFNyUdAbddhUNKZ54/gJNedmHTYOZMRgp
 JBbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ElaEfQHaLz3Ep92KU+zIFvR3okwlnfZe2m4yOLUurskAIYr3bqfGDx8akQ1ysjz7u26nIoNMzDcAC@nongnu.org
X-Gm-Message-State: AOJu0YxhgkiNZgYbPSiUjP4RenmdIWJ+8z96JlocICUk+hUhAkMw2Vwc
 sNDcn6L0bUiI2Dk0pVSnPEATstWcYmmLAuhTEIWtpOVrr3UKz3jwmb4qeiDagfb462pDYw7m2on
 kHn3SxVZ7wyjPaSpa6ueUWGEtKLb6VNa1gMXR/bbnDJyA1Kx8Qyg1q3QQ25wqZIL+tsTqvjA=
X-Gm-Gg: Acq92OHbM+GlTk93l823bKdpG8BVBZQu6qDbI/d27VBLw6TN+/DVJkrJJridwXN8eS8
 cpP2qpAU4rXvSFhQyW9mYxvG2BjHfgCR4/RiYGvMZkH4YTf98GTk0Lmia75SvmIrfUeSVxsoFWk
 QGnyYYl/AQ67f8LaG2LNRpaiYjWKu/+iEM/5NS+YBOm+xS4vIa83fg9mQjpCT35sdv49bzxdURH
 rVg1u10f2ltIKfPjyf7LsHuBAz+xJsabTy78T6qHFyZ6XK1xzhSTIOmoHZYxVBykA6FrYtdNKN4
 gRLDvAiw9fVM+cswczZ1OPr1CxFQtCZebRQgIB4g5//TurEHew1kXymyXbD9avoH1ROn0STbwbf
 J80O7+OHxmBXwvB7USUfRPXN0vScDCX2t3QafM3JIcgdsPoQKghbeoFhEkwF1eaGDPcA=
X-Received: by 2002:a05:6102:8001:b0:618:442a:9e76 with SMTP id
 ada2fe7eead31-6feff813ee1mr11467698137.10.1781018155579; 
 Tue, 09 Jun 2026 08:15:55 -0700 (PDT)
X-Received: by 2002:a05:6102:8001:b0:618:442a:9e76 with SMTP id
 ada2fe7eead31-6feff813ee1mr11467646137.10.1781018155138; 
 Tue, 09 Jun 2026 08:15:55 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b4d988sm8847946a12.25.2026.06.09.08.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 08:15:54 -0700 (PDT)
Message-ID: <b7053e5c-f2ef-4037-ae93-c75adfbe3d92@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 17:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] ui/input: remove dead declaration
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
 <20260609-ui-input-v1-8-42615deb818e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609-ui-input-v1-8-42615deb818e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QaDagiej6uK2jDe1huNyz0Spq2zjoKEQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NSBTYWx0ZWRfX7r3K1iRqO8F+
 jJRqv5v62UzLiJWR+wE+jbnGXN/6Q+rK2ulebUOneK1+aw3kjEMeY3tqyAo/sSM1G7we1bvgKUt
 3QBJc8BkC2urUHmRS0h4Jty8fVjV1VDdSq874wGGAaccC6XLZEVkqvtT+Ejw0ZEt4d5BdVS6vxV
 QXiWYhCfCf14wQdhotFycHKJVktWRAuKDDZIbIuIZWALau6Zol/37x07rIUi2zmvMMV57+hCANn
 iwTb6APTsQVts36gBracDVusHHbpvFvaNEFa6lTgAA1E2UlgyBkcj4Cxqx1aMNqUHR0RBLEnIr2
 MffVQWLWGJY+wQhFHmq2oU0RwOg7pLz83jcNTGT3FkBbIM30j0g5jq7XgEgzaCMGT5gCeQwZARr
 ZHnstb/4V98K1pha9VQmIgOWPHZO9wF84GGQ36JRT7O/VIZTm215UzGFkYRmFR1eid+l5Inflf5
 KTR1hYZZRbFvAZEWd3A==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a282e2c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=6vZ8vHfjWn_lFSypSEYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: QaDagiej6uK2jDe1huNyz0Spq2zjoKEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090145
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

On 9/6/26 16:34, Marc-AndrÃ© Lureau wrote:

Fixes: 0337e4123e6 ("input: Allow to choose console with 
qemu_input_is_absolute")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/input.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/ui/input.h b/include/ui/input.h
> index ea2d944a7ed..6df8ae3a8a3 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -100,7 +100,6 @@ void qemu_input_touch_event(QemuConsole *con,
>                               InputMultiTouchType type,
>                               Error **errp);
>   
> -void qemu_input_check_mode_change(void);
>   void qemu_add_mouse_mode_change_notifier(Notifier *notify);
>   void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
>   
> 



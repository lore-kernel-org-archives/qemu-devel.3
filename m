Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E34C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woFwr-0004m6-Ql; Mon, 27 Jul 2026 03:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woFwY-0004gR-MY
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:40:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woFwX-0007sw-6o
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:40:10 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7SF583339701
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iBfkOdqV37oVZnVxDNf8UxS8CIuif2Im/W5r9GnoYHI=; b=U5Xhijrfk4KmN79h
 Cpppi83C18JJnsFzNpfzzTGTXFTNTyaNsAhejWVWNZ9lz+rJ9u4hDQEjldC8Wecj
 9ryj2fSSlEti2TIxFUu1zPomJaGHuUhDnaat4Sw/kcE3wdCcQPQ0ImW7iEfJrXjs
 uijgBK+HxhN6XYFm7EMxfNx1rG6B/o8viGthgjKkNNghgn+JpE39ws8tFb+c7g2o
 uBEpjmX+YhvCl7Jxg3F3OWhFFOUAcLjnY7s6RN5QxfIUgUP+/s5btAyTf5scBp4E
 0oKWzuRhAs+EC2Ld3Ls/NhCK6coBy0LpKYQ2xWbhY7T8q5FArbf6mp1GUwWZbEOv
 FXGWHg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3sd545-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:40:07 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c12e43b98so30926981cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785138006; x=1785742806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iBfkOdqV37oVZnVxDNf8UxS8CIuif2Im/W5r9GnoYHI=;
 b=aVnWfFJ5ymv5W2v/3U7bmrBew+yiQ3tMK4uEX+GO19sce5eEzH86e+TDPg+2mOcCaP
 CT/n1vo8Q3yOxaSBX/nY4v68But93dho/i93E+vY2QB3Uwg3hNdrQLTuGM0LfLD7RoTL
 Ba6L8xLF0vG8vBRe9Qf1Ijlvg0pXNWTtw+47JY8IsrpBupGtaW7i4glFmrRFEInQAkS0
 Yn+gc3b/XYEIUcOsO0njEmwLf0webBK4YIO7b/vvinIQIvaPPZLMU2CEBwj4Lb3MuIzQ
 I9z806zOPV1d6bDjh2N8j+6IFrnyO8ENhP/uZadsvkDEsb4OHduj+zGXiiqQ7R547Kac
 t0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785138006; x=1785742806;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iBfkOdqV37oVZnVxDNf8UxS8CIuif2Im/W5r9GnoYHI=;
 b=VrNZqTgj9Ynhpb+hqAkRIf9pd6M3lAcSxNOfsFl3vAwZ6m3UQsfkhAcLR+XQYWxuUt
 43yvRHGJTRXLuN0wBmrWoTsST1+10sie8VsgcQqkzyxIxYuzLNxODHKPxSxOaGj9msfU
 vGUauS1+Rz2HgPVnVUmkso8k3CpB+iQop3eqM3WTjOa3WItev1bVjhDXzKz4OBhLO6G+
 6FpMEk7J/fneMQGpfAB2sOaQcqEp4A6kjzyzEgSamsFI9meirTFQSluNrhDBehwMVB+W
 hAP8krQd/FIUbTwVk/q22orko4uMdmDgvW1wUS/jwXKTWai9u0jBtBeIo1ehL1YC+mTt
 Dpcw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCsXX3N/lDGfK6LIL30StXAHbZBNqKDXiiNvQfk0q5yK3ZVnmM4SOISwu3tmG3XKF8k01wIS98+HXN@nongnu.org
X-Gm-Message-State: AOJu0YzuaiiAZb+vq8gHZD18YhwytzRK2BTDXoZntj180OGGkHPRdz28
 U810D7tziTOv/4R9MJj3QDsM6xkx2vpI6hnKCTgH9oaVRO/Qk4pFriK4/n18GvvgvjjZs+sAVF0
 K1HHv6NbH3y6O9iit1Qy7nMJLNmZJYWzMcDFktUkTvryZsUL8zIRDg7c2OA==
X-Gm-Gg: AR+sD12qjGuBIKzQzua49q/Qx5hcSfdKKEwiRe+CgX8Fzj06zQVJPMaClUNrzSTVyDf
 HF3lRAHdGk8dGgcLwQ4wNSFsgvDGYEQq6SX1y7VrMrjFTaFZpmiLdn46jFu2ZPlsSuyLqzmfUMW
 h7Lz6v6CnKG5xYy9PG7biL9dkuCzQC0Ck0k65IxjZuJVVw511uLc3EFF0nYADSHsVfxcprvXb6C
 rAa5IRuo+AX7nv1tbGdluc5AH/jZfkYphxMQkV4kL4MBS1/qjMzZmiVs3srKlVxlEZhbyQ/G/XO
 IMUkc/It6mIGtvgsG1Vdbk9J2geIovzOkIja6dKnqEhqghmAe6eoi4LdgNBHKF3i/0w/HJ2EACL
 7XYbZRF8jK6LY4I7Re8UybAJlZcny+vY3NglFNIeGV31DsOLQAEc=
X-Received: by 2002:a05:622a:e094:10b0:51c:13d6:b4e3 with SMTP id
 d75a77b69052e-529b3acc196mr28044171cf.64.1785138006286; 
 Mon, 27 Jul 2026 00:40:06 -0700 (PDT)
X-Received: by 2002:a05:622a:e094:10b0:51c:13d6:b4e3 with SMTP id
 d75a77b69052e-529b3acc196mr28043901cf.64.1785138005869; 
 Mon, 27 Jul 2026 00:40:05 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b842691sm232369865e9.1.2026.07.27.00.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 00:40:04 -0700 (PDT)
Message-ID: <0206544e-1d58-4040-9cd1-f36c917d88cc@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] hw/i3c: fix default return value of d2_i3c_send()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-6-d0c4831ed7ea@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260727-fix2-v2-6-d0c4831ed7ea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3NSBTYWx0ZWRfXwN6dHZOMDWkA
 Qok+m9yowUecB+38ERa/BRhxgR0Bzfs3dK4FuPaNvigQP9roIH8Mj3zP0ujFNpZSEIg8zpk9WOO
 hO0GmaaLLCckeGIZ/4xTipaSdgihEUmPeG6FTaD8NhVeeIVRSZpQR3u/v7/Cn4vSoRAlhGS6Vs0
 d5Kbu9KDpvvm2UqB0+NZMWFqOQ4IMMGomzn990xd8vSiqdhMiVHeCXwtWguwhPxvYFWv+5uwwYM
 G6d6SgUQG0Ql+P1oO8/QKpXgtYBHWjZnLOwuXOqg0S0TlQSBJO/oiInVhR7Jtzw4FlfnoIAgWSk
 DbyhD1+nBhKhugki2yNBpvxmIEKi8tQaByOtAr5V0vNNufeY9HCrBS1Aa6n4w/GiB1MnZNdlAoP
 3PFC9NNOH5qkPug/t0ct/noadynE/aNVzW8bb8Ab8kji/n3bWtS4/BI3GZpgwR59RbhhVUktt8y
 WXkMRt9CbSz1qGIsu7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3NSBTYWx0ZWRfX1epsh9f3pEPZ
 nAHwQ/Br+TAqx6jrWSFOAczZ/J082FQbgo8lflbWMqfy/KWfcAx0mzErzk78zNbit0+WXQCha05
 zIKxsBIRe5McAY4c8F8/MgrJ8bCeLl0=
X-Proofpoint-ORIG-GUID: 61tMVkUwME5JudK_R5dDXd8dD3WIjl7m
X-Proofpoint-GUID: 61tMVkUwME5JudK_R5dDXd8dD3WIjl7m
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a670b57 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=vpC8OiRf_cHKS7sXZC8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270075
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

On 26/7/26 22:44, Marc-AndrÃ© Lureau wrote:
> Fixes: 208772a189f9 ("hw/i3c/dw-i3c: Add data TX and RX")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/i3c/dw-i3c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> index 6386499dd9fc..7b887fbd60cb 100644
> --- a/hw/i3c/dw-i3c.c
> +++ b/hw/i3c/dw-i3c.c
> @@ -430,7 +430,7 @@ static int dw_i3c_send_start(DWI3C *s, uint8_t addr, bool is_recv, bool is_i2c)
>   static int dw_i3c_send(DWI3C *s, const uint8_t *data, uint32_t num_to_send,
>                          uint32_t *num_sent, bool is_i2c)
>   {
> -    int ret;
> +    int ret = 0;

So IIUC the issue is being called with num_to_send=0.
Can that happen? Apparently no. Could we assert it is
non-zero?


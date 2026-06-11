Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05450CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXlLo-0005ra-MC; Thu, 11 Jun 2026 15:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXlLW-0005nG-8c
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:45:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXlLT-0001Zx-R2
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:45:46 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BJ3JY71457597
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9aHErHWLMt2mPlAOUnsXt7hS750zp5n2fCkFUnAH4pI=; b=Z5H1gLv+a+u3WLrX
 tRnn+dhdPY8T3zwWz5UYVNSKV5id+bqTxllSD4Ou5XBUu85ol9BC9k6Wjdy3fi+o
 fsrTlN+YPpypGHxOK6Fh0eJma7JEzYbqAT/cGVUD19JrlAoBeCZwdEnxsvtlS/xe
 Fb2rJtkykwJgdtxzyPykomMOm+jnUkW2m0OfgPe931bqjO3ghzSn0MWednRH3EtQ
 QtQdH8aJTllfzFuitIKGKLZ1Za/PK6+CXeYBcduvu68AwxqQKrsKXs3CfYjSzP3T
 8J6U+SuOI764b00UEXPdPQiniQKDoKW+aVNA/ekFVANy5JFYQG8lUESqEhcEgd2h
 +8z/DQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r5r6ny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 19:45:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5177bddf6e0so5087951cf.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781207141; x=1781811941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9aHErHWLMt2mPlAOUnsXt7hS750zp5n2fCkFUnAH4pI=;
 b=kpD+rmqr/ST7UCEsxg27vQUldeX5SV1am0nYszgCmMTMusQPjHICAkVKoJ3mO1dTS4
 57Y7hqYEnCMgU9KuesK0f51F5PaOCzvNzrfeG5WQJr2gv+hr9tVXDPPaumftqNV2gJQo
 LtwsK36NTdgj/152loGBvtqVWhaCeFuuxqhfiAelNPCSK45Ta+r9MwPgl7BHSby3UXv6
 E+Ijc2TVWhuog+7yCaHNtdAPbQLDOV9Hgp2DgyacMlj+cEXWeAGV5dYZUSFdNjBTuPKK
 RlA4+0tcSNOiGj/qL/sxs2TSznzSDsXVqzUXidc2OH2bpI9cgHBLqfNdkqypCvI5Oa76
 YKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781207141; x=1781811941;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9aHErHWLMt2mPlAOUnsXt7hS750zp5n2fCkFUnAH4pI=;
 b=sp43wahAKzyq5amXs1flZBpH79SIQhKQVoN+KWJtgswwX6JKo5N6D1bZTcpKZ7i2Za
 KPiP0bJwWaWmBzhE9ZySZW/eRujBrCDYzfiqRcv8Bx7bbf/9hg8ASLkP5mKGx3uew5ln
 k+dDinIDPUw4G87QoHdCiFQNzozqBLMgupAe27JX0eQlebZertiFUAN6wDF3I0NDipeY
 BmLWndSMWGMEudhodVbu51yxOkQwp0IrWwwQhDVcvHFuGjOkbr+2MsgYWJ9O/P9xfho+
 DO/HDe/ajPIh9Z1G653Y326q8j50WRE3ByHj79Jt2Klitlk4tc+tcoOaWZstHqUo5jOz
 yq2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+spymo9Jue7Mnmh82yndopgtKEVMjeqjKgN59+UUGEu0Gyboh+WHDyjNEUFdlvGuJuygjFemBnH7rf@nongnu.org
X-Gm-Message-State: AOJu0YxW8q5bloq5+HsJWlsDGd/veNMqrypG9FfMm4U0budzgFSFd7Xb
 oiQqp8ut2+psUXceqnkxWYart7rR+Q52GpP+FrAO90CCIWg8ZBtE24TTl89Wj3ze0xNAte2AX/6
 tuvF6Krh44TjmPsi9/2CGFQ76IPtH/CiMrnFysSyssviMZfIRHWTnVEIW+Q==
X-Gm-Gg: Acq92OEchSF4AeyELeE/1BnQyHVq9iRfExotd5Gq7VkwBH2zKEItEcidIM1yW4PMZmD
 WRe8ogmqwv+FhKmaf2c+UxHsDPORKjwFK9k4ZGST2RE8qwMVMY5qdXHDfbCtdtCKiMssg8TSvjb
 YrGbklX4Bw8Sc3+Ge8vu6sWQx285PJkT+nVjUNtr1AVG/j9Kq/mtVmvWRzbg6aUdC0QQFG6M+xQ
 2YbmJEdn8aQ87hMrfQnw7rXMTf7l2IWLPpVPgfZLH+Kws039TVvhsa5Vyi0Q3lHxK3TULjUrsyq
 lhzPO1fjvTXv4loBggFa2kK4WQcPVnv0rE6RWP554JT4vQeeR9wlfr2qx3IuHMI047Y2LgFmN4A
 uYOIbAR8XKgZ7qCJGyTfxMdaB0GRGTN4+OT9XH27FebDtsfeviZQETYTJlSGQ9oBvKPw5GBzN
X-Received: by 2002:ac8:57c6:0:b0:517:8ed5:417 with SMTP id
 d75a77b69052e-517fbe90a6dmr1679441cf.29.1781207140820; 
 Thu, 11 Jun 2026 12:45:40 -0700 (PDT)
X-Received: by 2002:ac8:57c6:0:b0:517:8ed5:417 with SMTP id
 d75a77b69052e-517fbe90a6dmr1679001cf.29.1781207140416; 
 Thu, 11 Jun 2026 12:45:40 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c10456esm1228912f8f.37.2026.06.11.12.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 12:45:39 -0700 (PDT)
Message-ID: <6fdf11e0-1c21-4aa4-936b-f9df886e5b79@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 21:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/22] ui/spice: switch LED handling to Notifier-based
 input API
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
 <20260610-ui-input-v2-20-f68452dd6a22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610-ui-input-v2-20-f68452dd6a22@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nAPX1OgZ3QBkJM3Ucws_XERQ9O-y1JZS
X-Proofpoint-GUID: nAPX1OgZ3QBkJM3Ucws_XERQ9O-y1JZS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfX8PXFNsXrZWUL
 j/y2ccrR0YJnzCd4UQYfbvvKwXEoSXex/qgIwQ2pSLT15dWTR2BSp9jB/Yrbnsvpi9H3OBk8TIK
 GVS9vtwPgTrV3oBon8xuT72Wi2lvafU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfX7odqPNKjFm2L
 ck4Co+e66jXSR5H5WCSKae6OVkF+1BgJhs3yAOjqS2sR2es3x1m0D6jBAVbsHsO2y4m+1O0JZBe
 u37gjZoCMBvIOBic4gnGXOyfs84Gaza8Z44/cR/bVmSIEOoaAE35+cz28DDnix5hjb3eIgXl16T
 cXroXCghGtPyC2r4L2v5ytsz3Lu/Tcu2Y4yDkYqorycs8xoqEc742RI8upFhgGva98aNAafQPdH
 Pm5C/h+oIQpheIUpUqmunZLaFCHldoBIEH5M6/6afsbsx/tmVbevH8SdgGY9Z0kuI5a0i7fmN8L
 EtJpFiroRTK1fTZ/DoQSmWOHiw5Hj/n8vi+XMqIuPiy8Z+M62/A84DubRlzSm97nPr5ruOZgaBi
 ZCaQskr4M+NGYsYka6lxRLlKtGp36+X1bYTMv/MHiMdJnub1q/0re2Rs3OWJK9xciKgSGUqzePY
 QwsRHKZG8tgQdQ9OpIA==
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a2b1065 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=sfRqCjioY5KbVaXneoEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110198
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 10/6/26 12:57, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/spice-input.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/ui/spice-input.c b/ui/spice-input.c
> index f0bb915fd77..f5329b8aed9 100644
> --- a/ui/spice-input.c
> +++ b/ui/spice-input.c
> @@ -33,6 +33,7 @@ typedef struct QemuSpiceKbd {
>       int ledstate;
>       bool emul0;
>       size_t pauseseq;
> +    Notifier led_notifier;
>   } QemuSpiceKbd;
>   
>   static void kbd_push_key(SpiceKbdInstance *sin, uint8_t frag);
> @@ -86,9 +87,11 @@ static uint8_t kbd_get_leds(SpiceKbdInstance *sin)
>       return kbd->ledstate;
>   }
>   
> -static void kbd_leds(void *opaque, int ledstate)
> +static void kbd_leds(Notifier *notifier, void *data)
>   {
> -    QemuSpiceKbd *kbd = opaque;
> +    QemuSpiceKbd *kbd = container_of(notifier, QemuSpiceKbd, led_notifier);
> +    /* spice has no associated console support */
> +    int ledstate = qemu_input_get_led(NULL);

unsigned leds_mask? At least would help to differentiate from
QemuSpiceKbd::ledstate. Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


>       kbd->ledstate = 0;
>       if (ledstate & QEMU_SCROLL_LOCK_LED) {
> @@ -247,7 +250,8 @@ void qemu_spice_input_init(void)
>       kbd = g_malloc0(sizeof(*kbd));
>       kbd->sin.base.sif = &kbd_interface.base;
>       qemu_spice.add_interface(&kbd->sin.base);
> -    qemu_add_led_event_handler(kbd_leds, kbd);
> +    kbd->led_notifier.notify = kbd_leds;
> +    qemu_input_led_notifier_add(&kbd->led_notifier);



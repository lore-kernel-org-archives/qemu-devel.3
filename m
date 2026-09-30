Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4C0CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvcQ-00082o-2F; Wed, 30 Sep 2026 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBvcD-0007xa-02
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:49:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBvcA-00066E-Em
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:49:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDxsdb3519855
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ox9THxkjgMUKDstf7gWd4n2iJG7WWUiBq4JxIkPJDk4=; b=L187OyvVckTPwexF
 wlGohWnUKsjQzZHWoJT0Yv7vNlfSQ3YUsBb7k2r/paN5xiS1iJn1yIUYHINhXYc0
 TfzUxQDtHTlOStkOCGPWGMH8rRZnpmpy6rEUuOo47b12rza7qHCl8bYdtaYvsOfo
 z7l9fOQmYgYv255iVxCfgKhnFOD5Qaw/wz4upL74YF1ljnPazjoZ63hoX71g8KoA
 6rlo19gcvas+HlchgItZ5IO/LcZcRqwrBF9w1sim24mbb1gNBNqV6wBX9cR4s2Kj
 wvrnDHlXNZ8bE1kRzVc5ytdQeXoNjltRQLhyDmt0rbzQiuWs/cCoEKQGbbXJeH4X
 dZodig==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27hxkh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:48:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a082c014aso450920885a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790779736; x=1791384536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ox9THxkjgMUKDstf7gWd4n2iJG7WWUiBq4JxIkPJDk4=;
 b=gBfhW7t/nm3oIZvkmsikDOi/HN78ljgVg+ZsHM3fZEkQoD9yh/auorK2MCV/x8jX5O
 XHjwZUE+85E7bmL4nsYE4JyehtAaNjk1MbwnlNYYMV0C4iYolsu3WhmKeGwSJxX24+Qn
 iEHcxjRz5BRaBnzo1R6FALL4IKzHNjU/pvociloaUsAfaMR68KjKrAx8NIPuQvQz7e0Z
 PF1lDCWrcJBVsjARVSpx/Fc63LP8WsOuXjhnp6aEzqY/pa1W/0GFVTsrcyM0G4CecSGR
 JeqS/AgiOOk8+gL17p+xOf6i6Chf5gMiq1l8m24+ojkn6SCTx0oZHQiN1cFcZMulfcza
 T2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790779736; x=1791384536;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ox9THxkjgMUKDstf7gWd4n2iJG7WWUiBq4JxIkPJDk4=;
 b=GiMdmmVhVfNkqX7tBrXM5x3SfFakU4pOS+SVM6HNfbb/21EgVsr8QZF5yjJbImoVo0
 wokgCtlyNpKYt7nG+cTMesJHY5ICUs9CQQ8ph7LDXpGcIRnTGk+748HCUMnQ5sWBWBYy
 A8yaq/z3pbIwq2pajCH5bhlOM/auuM2s5dBOKtnOxNsRadx55UhzFwAxabzF22WYX18r
 i8++OFNLf0wlvHJcWjEQcvaF3AamsenU8Iq2THxwFSup3Xygjqy2YlgdV1DiD9ymePNN
 l8UZjVskDaOlPBY6daB0hZWtkOlkSvveclFGTURY6YVifGd0vyr6ihm/Wvftg0S64rIR
 25fw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuuxqw7a7J8F0dkrQ5+HYIOQ0/zJatpi7DgDgdGelcvixlhRuMnHFWkoOM8b14rKvbVklC7pA4wgbN@nongnu.org
X-Gm-Message-State: AFuF++kULux+ML13Q+WfS783QResAPlJ+I1NaoJxnOsXcrQrEGp0zA3s
 AVAcAQmztfpUuUHdteLkhoHf4krM3GZrymhQBox16d00KVYZoH16Y9g5Gch3803DajiqYSQGc9O
 3yjYU/Pytae2P/N9hqP7dwFPRTX/NkWWdD/YbjfXdbQ+XXNf3feQricVd3Q==
X-Gm-Gg: AYBFou1IMLTMt7XGq0NYCYQJFd+DUgx5lqKr60TIFS8kbNreBW8dcRIBUrrAhS0MR6G
 DMAjzln8c6LT0N7zBe4nNK4H/+VrkRSSf06Vzx+wNTnJsVes21m9Em6AVoDCa96Es2loYI24T5n
 NS3N2bMqjdwTi01hNdwyA0qKu+CVi/U14UxdqaPeAg7h45lg7YAiCFkXXXcj7sf3nTn9G4Wy9m9
 BM7zHxXI0BLtahvvNBFlHMhNFpxkI5Otyy/eqYZOl+0nu+945kZ15ASO97FzyyviPvo8YDVMkLC
 QdYDTm4akWQnW/oq3hfdRTaNnOj1IXINErJHWcm6tEzytNAdUqs0cPv+h5QhLrbzce5tsjoEXNb
 swbzWGHXghGB7PKxoojxVNH1rzTfHced9dA==
X-Received: by 2002:a05:620a:6509:b0:93b:c6fc:71e9 with SMTP id
 af79cd13be357-93ca9752cfbmr284966085a.25.1790779735617; 
 Wed, 30 Sep 2026 07:48:55 -0700 (PDT)
X-Received: by 2002:a05:620a:6509:b0:93b:c6fc:71e9 with SMTP id
 af79cd13be357-93ca9752cfbmr284959785a.25.1790779735077; 
 Wed, 30 Sep 2026 07:48:55 -0700 (PDT)
Received: from [192.168.15.22] ([177.188.45.232])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e31c8efb0sm14755866b.23.2026.09.30.07.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 07:48:54 -0700 (PDT)
Message-ID: <706bc560-ee8d-4529-8ece-c849fa8a4602@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:48:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/riscv/atlantis: Add machine property to select
 default uart
To: portias@oss.tenstorrent.com, qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
 <20260929031644.1016354-5-portias@oss.tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260929031644.1016354-5-portias@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OCBTYWx0ZWRfXwJqxEmTQ17ds
 70+Udy4CPFepOZhvO40tLhSvpebS7pG2INF08xghdMv6pBjwYGHFCQGO5kduShawzFaEG0V51/H
 5VgjcMaoRCjtwEcfmbSeSBD+5q2tnBU=
X-Proofpoint-GUID: 5d2qwm0BaJRKEq3jFCfYe2QUBKhLT77d
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abd2158 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6l5rUruYTVaW9RSjPQzg2g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=t9496tuAAAAA:8 a=vr2JyHze2XVrOcvLC_oA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OCBTYWx0ZWRfXzS9zkxFUABVE
 It7kkT+8eJ8qfQzdX3GP0FlIrzEyN+5+PblqHDm8b73i8dpB3lllI4FGhJVeQScVVQnvshdE1ph
 CuAAgBgix5uc1HTH5Jzk3bIWabPnGLFFDkuxwDx9E9T5JCKvcFT84kUKKz9uteHbflOqZqS1xms
 M6xihq5CqipNLkATqiqnP0tSafkWWbfQc3tqSjNjy1zKYlLiqHxYgXOGDcGl4WwlB42IO2S5Ys3
 STgP/c8ISQO94m92tD2w0LPFA3TEq0peQbVzpEk6dtAgRmB8S/JWMrQWM0fRJtTH/Ip712fsAyD
 oMN/ESZ//bYwyADliRD9gmA+O+Z8ZHt2TLYZPtjyyE+wV/EkmsJg+9qKBAOC5BxT2f1jM1+VhuS
 NuSfccdC+giv1V9hGZKl4OCUs5YOHPIR3ixhdx4shhlejEt0/GlzRfkYiUiZy2Ap5Ol5Ew1oBmC
 cohQ2sKChKWYzqgcZxg==
X-Proofpoint-ORIG-GUID: 5d2qwm0BaJRKEq3jFCfYe2QUBKhLT77d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 9/29/2026 12:16 AM, portias@oss.tenstorrent.com wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> The Atlantis SoC has 5 UARTs. This adds a machine property to set
> which uart is on the first serial interface. This is the same pattern
> that is used by aspeed. The rest of the uart's will be added in
> sequential order starting at serial interface 1.
> 
> The default value is uart1 which means the Ascalon console will be on
> serial interface 0 by default.
> 
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---

The code LGTM but I wonder if we can make it simpler.

IIUC there is a new ams->uart_chosen being added that holds the numeric ID of
the first UART.  Then there's a new string property called "console" that needs
to be on the format "uartN".  To do that there's a string parsing code in
tt_atlantis_set_console() to guarantee it.  And there's code to guarantee that
N is also in an acceptable range.  Aside from parsing N the 'console' string is
not being used.

I believe there's a good case here to make "console" an uint32_t property instead,
receiving N, getting rid of all the string parsing code.

Also, there's a couple of instances of this:


int uart_chosen = ams->uart_chosen ? ams->uart_chosen : TT_ATL_UART1;


You can avoid this ternary by initializing ams->uart_chosen  = TT_ATL_UART1; during
tt_atlantis_soc_init().  Coupled with the parsing code from the "console" property
there is a guarantee that ams->uart_chosen will always be an acceptable value.



Thanks,
Daniel


>   hw/riscv/tt_atlantis.c         | 77 ++++++++++++++++++++++++++++++----
>   include/hw/riscv/tt_atlantis.h |  1 +
>   2 files changed, 69 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index d567ec1155..32ba755bbf 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -420,6 +420,29 @@ static void load_fdt(TTAtlantisState *ams)
>       create_fdt_memory(ms->fdt, &ams->soc);
>   }
>   
> +static inline int tt_atlantis_uart_index(int uart_dev)
> +{
> +    return uart_dev - TT_ATL_UART0;
> +}
> +
> +static void tt_atlantis_connect_serial_hds_to_uarts(TTAtlantisState *ams)
> +{
> +    TTAtlantisSoCState *s = &ams->soc;
> +
> +    int uart_chosen = ams->uart_chosen ? ams->uart_chosen : TT_ATL_UART1;
> +    int uart_index = tt_atlantis_uart_index(uart_chosen);
> +
> +    qdev_prop_set_chr(DEVICE(&s->uart[uart_index]), "chardev", serial_hd(0));
> +
> +    for (int i = 1, uart = 0; i < TT_ATL_NUM_UARTS; uart++) {
> +        if (uart == uart_index) {
> +            continue;
> +        }
> +        qdev_prop_set_chr(DEVICE(&s->uart[uart]), "chardev", serial_hd(i++));
> +    }
> +}
> +
> +
>   static void tt_atlantis_machine_done(Notifier *n, void *data)
>   {
>       TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
> @@ -482,11 +505,6 @@ static void tt_atlantis_machine_done(Notifier *n, void *data)
>                                 fdt_load_addr);
>   }
>   
> -static inline int tt_atlantis_uart_index(int uart_dev)
> -{
> -    return uart_dev - TT_ATL_UART0;
> -}
> -
>   static void tt_atlantis_soc_init(Object *obj)
>   {
>       TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
> @@ -590,10 +608,6 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
>                                   &s->bootrom);
>   
> -    /* UART1, the soc console (UART0 is for the boot microcontroller */
> -    qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
> -                      "chardev", serial_hd(0));
> -
>       for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
>           SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
>           if (!sysbus_realize(sbd, errp)) {
> @@ -661,6 +675,10 @@ static void tt_atlantis_machine_init(MachineState *machine)
>                                OBJECT(&ams->soc_memory), &error_abort);
>       object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
>                                &error_abort);
> +
> +    /* Map serial interfaces to uart */
> +    tt_atlantis_connect_serial_hds_to_uarts(ams);
> +
>       qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>   
>       /* I2C peripherals: qemu specific */
> @@ -678,6 +696,45 @@ static void tt_atlantis_machine_init(MachineState *machine)
>       qemu_add_machine_init_done_notifier(&ams->machine_done);
>   }
>   
> +static char *tt_atlantis_get_console(Object *obj, Error **errp)
> +{
> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
> +
> +    /* Default to Ascalon console */
> +    int uart_chosen = ams->uart_chosen ? ams->uart_chosen : TT_ATL_UART1;
> +
> +    return g_strdup_printf("uart%d", tt_atlantis_uart_index(uart_chosen));
> +}
> +
> +static void tt_atlantis_set_console(Object *obj, const char *value, Error **errp)
> +{
> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
> +
> +    int val;
> +    int uart_first = tt_atlantis_uart_index(TT_ATL_UART0);
> +    int uart_last = tt_atlantis_uart_index(TT_ATL_UART4);
> +
> +    if (sscanf(value, "uart%d", &val) != 1 || val < 0) {
> +        error_setg(errp, "Bad value for \"uart\" property");
> +        return;
> +    }
> +
> +    if (val < uart_first || val > uart_last) {
> +        error_setg(errp, "\"uart\" should be in range [%d - %d]",
> +                   uart_first, uart_last);
> +        return;
> +    }
> +    ams->uart_chosen = val + TT_ATL_UART0;
> +}
> +
> +static void tt_atlantis_machine_class_props_init(ObjectClass *oc)
> +{
> +    object_class_property_add_str(oc, "console", tt_atlantis_get_console,
> +                                  tt_atlantis_set_console);
> +    object_class_property_set_description(oc, "console",
> +                           "Change the default UART to \"uartX\"");
> +}
> +
>   static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -691,6 +748,8 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
>       mc->block_default_type = IF_VIRTIO;
>       mc->no_cdrom = 1;
>       mc->default_ram_id = "tt_atlantis.ram";
> +
> +    tt_atlantis_machine_class_props_init(oc);
>   }
>   
>   static const TypeInfo tt_atlantis_types[] = {
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index b81b7c8abd..7bd46e9c9b 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -56,6 +56,7 @@ struct TTAtlantisState {
>   
>       MemoryRegion soc_memory;
>       TTAtlantisSoCState soc;
> +    uint32_t uart_chosen;
>   };
>   
>   enum {



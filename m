Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F503C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaFb-0005yb-9g; Fri, 03 Jul 2026 05:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfaFZ-0005xz-BE
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:31:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfaFX-0000YE-Qf
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:31:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635rwsQ3126390
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 09:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lcPRx+p7B9S0HwS0wT+o/ZNMrBaWj31lcAHNQw9xOz4=; b=TFXTpa+QuRb21a9d
 bpYyi82tBwOxWuEOz6/rEZDzGZNPBB0VIsSV0QjE7LvBhNvMHFt793TVG2pEFSTG
 /LFOeNXhISjQca5Rhv+FglK0MpBpuiP0i3ErUaC0Z3zVps54XM9CozMRBm2Yxj/I
 kyHg8bSjps4r0ZS60cw3XOPx4U4Lolu174BEDh9CgHORUsXtAIsZX63ol/SMICZ5
 6FCCKNrJpvNwhIu7YgOKnrPrImr3iEKRpTWhxLgxaBbpdcE3jOpFtkFQak/W4Ucp
 n/CwfX/CgpVhX3Fj9vmTUzDvBP1cB99XjgVNRvCe16OtN+5PXULp3xW1tSLRtiFf
 pulWdQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5tpnks33-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:31:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e820609d9so24692285a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783071114; x=1783675914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lcPRx+p7B9S0HwS0wT+o/ZNMrBaWj31lcAHNQw9xOz4=;
 b=gNUbuQHMq2efMYOCz5Q5dnEZLp3PCldFpvWIzdlVHDMRlBM7fv/cF7RXvqIAjIrDnl
 5EoimH3/GgSHRTtMSE83oL7eYyxk7qtnAE8UdSWmb0HMUEbPjldL7SeX0DDsgFwdAi0D
 hMd/JxZYL1t0pXuAN53Aia6IK1l2NjyrUpE21A8g/fHSH+Y1yF9UsnbAx5Cu79KIblf9
 OOuwKEyu18iKTK17Oyfszep+FYJrgaC2KXG3P8GQK41sWJ4MGJWhhiTomvhdhLrmHqB4
 vfeI5WhgaZ6u/zmDukVjGRE8aMjPuEp2SWwtst5LI0afD21WIeZjemKgrT/jd0mWWo7z
 tdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783071114; x=1783675914;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcPRx+p7B9S0HwS0wT+o/ZNMrBaWj31lcAHNQw9xOz4=;
 b=JZfW8TvW8ppcmc4TVEkhmOnmhUgCFUh4iX+xH5dxLvA2zaQ//fQzuyzt2DeLhQzVC9
 POPb+RhFS9ziV/HSbrpHjDO4GT09fp9olL+ModOE2JewGYM9UCJPpc/OYTRAVgy3F/q0
 NrxHBZJgHGd7LZIdqGIByB/Dba6eT7zjajBgdTvllOyCPF1C0yfBWuz9kw/Q9gjYqUJg
 QiwC/5fVQgf4gJIzFmO+7HIFoa4abwZoe6CWflQPSU9FatySgRv1Q+atMqmLmoKFsncq
 CJyPTM6qPKSTlHl0+dRMNXayZBDRev+MbCxxFw+sGRHLLFmKT0EKuL6Qx6oCUrou6/Q/
 sn4g==
X-Gm-Message-State: AOJu0YxzAx+3IQtnjP1rvyDMMaU9RaRkJtdvkqS3FhjsTikW6usBJmFa
 ET2Dy9NZ6cIQncmhMSXnZeH83JspaGxrlG0ksjxoe09MMX5mMI7n0Ek5nLDYkJ5RtOhlvgjOQTm
 PNc6HAIhEMnU11apt0/XtLgRQTniHXHPoWDXo4qisA5di0njYpblrwj5L8A==
X-Gm-Gg: AfdE7cmMXvTFeTEmoqDCU7UCSxEMg7SgqlXxCILkJh03FkZyLMZPFzOVumPaiXXfBNG
 aWeUfnINlw+2oB+gA2yNRx7ofl2OyXYiVH3YQn/r4pkYQfU4n/EBqi2Bc14i05JpKkS/WujJ0cX
 6IVmZDTiF1c0x7OslKLRvKy88mpsVGA1ZLAOJc2WnUUi2WrB2OO2E9WQJOjyzs4xRfoVii/tA5r
 Zw2Bk5synGGDBasWPyzhvGSiW/Q3ItOzbk05kpHdh/4iGpah0YHOss8jJ2cYHO5KAdW1cpcQsG7
 22hO5tVxFWV4+5kxrrHmS7Ouwc8SvnwCx6dMnpySGfFqgq2FoIZ5vWCTf23GwOVgt1LZ87pMgZF
 Q7aYuRyAE2OnU3RXFTVlh9xcycM1+H6Eu1GtbCxUR1V7EpBS7uedyNkLklXWSvQ==
X-Received: by 2002:a05:620a:4512:b0:915:efa6:d717 with SMTP id
 af79cd13be357-92e784cf227mr1365135485a.36.1783071113719; 
 Fri, 03 Jul 2026 02:31:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4512:b0:915:efa6:d717 with SMTP id
 af79cd13be357-92e784cf227mr1365132085a.36.1783071113122; 
 Fri, 03 Jul 2026 02:31:53 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c636ec8asm100338975e9.1.2026.07.03.02.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 02:31:52 -0700 (PDT)
Message-ID: <24329582-f5cf-41de-aabe-c2c3d54f03ea@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 11:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv/virt: Add optional UART1
Content-Language: en-US
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, sunilvl@ventanamicro.com,
 pierrick.bouvier@oss.qualcomm.com
References: <tencent_06551FAEA44CD75E915AE611FCA0C99CDD09@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <tencent_06551FAEA44CD75E915AE611FCA0C99CDD09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PLlLseBpl1m5y6g9IUeluDDnTYhRK-dI
X-Proofpoint-ORIG-GUID: PLlLseBpl1m5y6g9IUeluDDnTYhRK-dI
X-Authority-Analysis: v=2.4 cv=UMft2ify c=1 sm=1 tr=0 ts=6a47818a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=dZbOZ2KzAAAA:8 a=Z4mA_aLNfOJQCjkR5ZMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5MCBTYWx0ZWRfX64JMQ6z6w71X
 3nvqfVxsXZZUI4f1bOY0mZueg6bndTMRt4sNd8xnK84yd2t9W8Wqpu7HvuZz5840blJw7Vmd5ex
 UtprEjCJd2H3cfSbRswoL5fp0FtF52k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5MCBTYWx0ZWRfXyxCPCgDtGxa9
 6m6IX5/btIJEG8Thv0lSH6I60JQhhCfQW7FeAPjXKfT5WLcSf65mYBJnpxUW31cR0O3/8q72aO3
 RL77Sn0NsTTVVZcQ+C7Ug6XK4sMYqIiz/kUJTRpNbNlo9PnVQTOMHTHslmvySuzCLDvu526Ii76
 7DpScQ1oMJeqCz6FxUdB3BqENHBup/rfRc0DFTwc5bZd6VLhzsJANxaH+CZEEMdG0JvXSEdv3w4
 SForZF2eB7kUe0WVZC+YDgdnnpwtpqHajNxI58X7k+X5jubPho/HNET/oJGR7cKh1NpLwB//8BE
 qZpAXoPKIwDvCwNRksU0v/riVSH4QcA+9JtlBbh/pLBPDMVQSSosmtY04NxS5kVaJfRyKFpsH0T
 UtLrvNtkCZCyktn+ZbzmrA4kkFtWAhboAMdBUDY9ex3Hr4NxMaIdpGwNfVlkRMHetzVHFZRTzci
 hn66sqQAF1fotIId01g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030090
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

Hi,

On 3/7/26 06:24, Yanfeng Liu wrote:
> This adds optional UART1 to RiscV virt board if required at
> runtime to simplify multicore development.
> 
> Note that UART0 remains default serial_hd(0) and it is:
> 
> - the lowest address UART
> - first serial in DTB
> - behind /aliases/serial0 in DTB
> - the /chosen/stdout-path in DTB
> 
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> ---
>   docs/system/riscv/virt.rst |  5 ++++-
>   hw/riscv/virt-acpi-build.c | 12 ++++++++----
>   hw/riscv/virt.c            | 39 ++++++++++++++++++++++++++++----------
>   include/hw/riscv/virt.h    |  3 +++
>   4 files changed, 44 insertions(+), 15 deletions(-)


> @@ -1567,6 +1579,13 @@ static void virt_machine_init(MachineState *machine)
>           0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
>           serial_hd(0), DEVICE_LITTLE_ENDIAN);
>   
> +    if (serial_hd(1)) {

Checking for chardev backend connected to map a peripheral block
is an anti-pattern; the block exists on HW regardless.

> +        serial_mm_init(system_memory, s->memmap[VIRT_UART1].base,
> +            0, qdev_get_gpio_in(mmio_irqchip, UART1_IRQ), 399193,
> +            serial_hd(1), DEVICE_LITTLE_ENDIAN);
> +        s->uart1_present = true;

Thus we want to always instantiate all UART peripherals.

If you drop the uart1_present field then the patch LGTM.

> +    }
> +
>       sysbus_create_simple("goldfish_rtc", s->memmap[VIRT_RTC].base,
>           qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
>   
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 18a2a323a3..7d57c8292e 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -59,6 +59,7 @@ struct RISCVVirtState {
>       int aia_guests;
>       char *oem_id;
>       char *oem_table_id;
> +    bool uart1_present;
>       OnOffAuto acpi;
>       const MemMapEntry *memmap;
>       struct GPEXHost *gpex_host;


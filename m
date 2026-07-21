Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F166C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmC2C-00012m-5m; Tue, 21 Jul 2026 11:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmC29-00012W-1i
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:05:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmC27-00045Q-08
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:05:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDg2vr1841367
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 15:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kf1Z/SQ3EynFPb17e0XpySQIO5pi+AzMUr5Qlegps10=; b=jzBEDghUZ/bxCqjF
 a4/zXCcv4ZifxqJnV6iEHsG+5FqcqoRhWv7qiowL+du9AHBP7VPLH4NMg7I0dfU3
 EJ1oy/B8jYKh2uUyAWqyjhU2T+tSzYP1U8mA58wQdHqKCoBp7RNudRh51O8UAOVa
 OXfZQNMHk6BkFNzH8zu3XVhgahbDeYAdzA3MbDIWSkRJshWYhM4YTHs1IhgSo8gu
 4JRj0uJBVj92oYVbrSqN6lFzx/6WbsweBn0cs+zxaRuUclqN3qdTSI1+gStTg6CO
 qnsh9obuERHXJ66s2vBDjRMBxKJsgqZl/7di+WqJatvyDSfDwzuu2Sc2psznTNKu
 bcML9g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se2wdd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 15:05:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cab041eced3so14026203a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784646316; x=1785251116; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kf1Z/SQ3EynFPb17e0XpySQIO5pi+AzMUr5Qlegps10=;
 b=MnxArVHDXxvZ4D6DiiuzgvGNSPComafadGPGyrVLeUreK/7V69lsj6zuNkw2nbeiIG
 ZPqA+b38wntYizi8/OZBVmmRB+knpP3SpOWz/tVnT2kX8Maa0izflDQBybR+851XmtoP
 aauPQZfPb7jmxq00HSCGTvlrrY6I14xH1T7mGY/Lp4aLll4aw6klMFyXKtJbTiV1VKgA
 UcBz3Mg3ElCrf/kUu2ofoGZvN1Tnv61SuQh8bnCgsbe+ycGMEJGx2gB4JB+BYsGAREy6
 3cD1G5dRq+vjF2U8jpmsO/0i4a7T4ZUju0Oin+3WLRjSPF8CzyT664Vorz/goQ7BRVHC
 EzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784646316; x=1785251116;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kf1Z/SQ3EynFPb17e0XpySQIO5pi+AzMUr5Qlegps10=;
 b=FdIz5zr0T35VnvMCW/N1EfVS2ddor3jJh3MTvVm8eCejkZOY+/KIxtaMs6IL5j6mKK
 ZZlvsq0Fcoe98gKVdEH4KbJFwqJ8EGdMonApgXF7gIAF+E3U9M7Wgfoya/Y4rZV1MQmK
 o4cCaOpZV7HmX0/rQ8eMiAJcI00aZdtaFnzTEeNemCOVpm7fKOKUpfXzqGDGOMwJ7Jy8
 CoQATHY87FtG0i/vk0xxWmRPSko4XKJNYDyBnrzPENyZ1Uh94HRGUY/Zp88jESEG4NIu
 Irqej1v9mbys9jw+e736bukq0WQDhasCZIMwOGJhz/rjBvTQIZegQylClhj8XKl4fegg
 VL2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTI5Bs2c5gFwIr8bSvzMDhqAAmktlUAgEppZjhys5Bks+Cqe9PPHdULEZnCvIFWuWJlRDmEDNPEld5@nongnu.org
X-Gm-Message-State: AOJu0YwO/OAUtdsmjSBHt0dlgPrMW8nANGZP3gl0gtS9bVawrGgYvN6n
 djUwvMKjXiw/04kWe/a/FUId0O3ytwQLml1SWKIl1nGOrORCsUqNVfDMEaoMmXP3T3UGRud16UI
 oK4syLUsVjUqGK7LaHRUTX90Vkqi1kZIWo6N6zvS6wQ4i+2TgbebRQykuXA==
X-Gm-Gg: AfdE7ckmO//y/jRxsD2fIZ8OQRf/vSk/bUY4b4zTPDMv4ETniNBt0EZMUYm45Lk40Pf
 tK8Oik0eeH5XLMb6+kpnE8ZcJ0kPcXtT4pR1J8NPj3QtYwZmz49Fh63lJKCmm+RHkRe2D6U0Zrh
 jkDU+HbAdgOIYghjcsbhK00r9qRGdmJsiD23GN24KHYlnxcIukdTLfAP1OBz8aqzfwcEWegScqO
 7GCshCjvDak2dLpSORf9BQu3Nhe0eBpul0kcWqkLYlDSpi3SG7pFyq+DZ9HJ5+Z1binfirav9tl
 /DKc4vygecS6RWm66ZgfH6BNcBP5l5ZFDkyCNXHvFFXRA1Lu2jiPRtdEO+ztf5Ym30HBpLuv+71
 3ShhJDtwk/oEXZ+cUqLljp+2JkoZAIGbhNwk/B2KhG/KN6gHcotyvrlOOxxJFhQKALvFE
X-Received: by 2002:a05:6a20:160a:b0:3c3:9df8:2eed with SMTP id
 adf61e73a8af0-3c3ad7928d3mr21209496637.31.1784646316396; 
 Tue, 21 Jul 2026 08:05:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:160a:b0:3c3:9df8:2eed with SMTP id
 adf61e73a8af0-3c3ad7928d3mr21209432637.31.1784646315844; 
 Tue, 21 Jul 2026 08:05:15 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1de21asm49030964eec.23.2026.07.21.08.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 08:05:14 -0700 (PDT)
Message-ID: <ff44d4e9-1be5-4335-a1b9-c0a2436c4649@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 08:05:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/hexagon: connect qtimer device
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 matheus.bernardino@oss.qualcomm.com
References: <20260718013241.1550124-1-brian.cain@oss.qualcomm.com>
 <20260718013241.1550124-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260718013241.1550124-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cNSWPKeG7rNSI-sQXrpDLbw0FwBC7qUi
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f8aad cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=dLiZrMKScHOMH6pFX-YA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1OSBTYWx0ZWRfXyZRMlI208pW/
 eaTA2xj+XD6aBab2+RNWWbhjc4Dt4DSI9CrmrB2Pmk/PTsnVUlTa49wyFSG7fE1/gJCaiOMcuQm
 5I2HLwapc8lneXXd6KcBhs131zNgV/w=
X-Proofpoint-GUID: cNSWPKeG7rNSI-sQXrpDLbw0FwBC7qUi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1OSBTYWx0ZWRfX8J+5hO0fef44
 E52U4fQ3ohgD2DrlHfiA3uZSyjXRUl9MmyiViSQYAxgj/pmoVwOdZuxTO6FQI/EluDqE3/ehCow
 8JZqwgwBKerBWbu+6amaLmW3IXRGcqz1uVeKeBFkhX95GHq0ZbIUs9LHQoNJIFhp/JdS+Zy0DPg
 6MnXC2gnZNy7fUHWyTF62p6gTw6kZUWiEr6I4fOT3CQ2kFW+AJbVaLuTEbtWrNkmjmQtuFBp+qT
 6s3KATbdHN4Xk7gX2HyuO29qHGxoly6yQQ3CSkce+80xxORZgx85R1ZSo5e9lyGQ5uv/ItVeEaP
 VnvQEzrb99sRkm5TP9vcPSsNUrFWCKb9BaTrMYsrxjry5ymvVepjPmSEmu2YpPN9QS2En8rNqAR
 hJpx4OnQKQc1Iddr6vZzP1ZofPYyFFZTsozdm4NZbc34L+J8syYlXywTNAaSRZJ+g0egRWBnOih
 mwny0V6KSEJ9WOoQ2Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210159
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/17/2026 6:32 PM, Brian Cain wrote:
> Instantiate the QTimer device in both machine models, map its
> view region, connect its interrupt lines into l2vic,
> and link it to the globalreg device.
> 
> Store the QTimer DeviceState pointer in the shared
> HexagonCommonMachineState.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h           |  1 +
>  include/hw/hexagon/hexagon_globalreg.h |  4 ++++
>  hw/hexagon/hexagon_dsp.c               | 14 ++++++++++++++
>  hw/hexagon/hexagon_globalreg.c         | 17 +++++++++++++++--
>  hw/hexagon/virt.c                      | 16 ++++++++++++++++
>  hw/hexagon/Kconfig                     |  1 +
>  6 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
> index 6753ae32cde..3eea1e54ff2 100644
> --- a/include/hw/hexagon/hexagon.h
> +++ b/include/hw/hexagon/hexagon.h
> @@ -157,6 +157,7 @@ struct HexagonCommonMachineState {
>      MemoryRegion ram;
>      MemoryRegion cfgtable_rom;
>      DeviceState *l2vic_dev;
> +    DeviceState *qtimer_dev;
>  };
>  
>  #endif
> diff --git a/include/hw/hexagon/hexagon_globalreg.h b/include/hw/hexagon/hexagon_globalreg.h
> index 397dc6854c9..07437dfabb1 100644
> --- a/include/hw/hexagon/hexagon_globalreg.h
> +++ b/include/hw/hexagon/hexagon_globalreg.h
> @@ -11,6 +11,7 @@
>  #include "hw/core/qdev.h"
>  #include "hw/core/sysbus.h"
>  #include "hw/intc/hex-l2vic.h"
> +#include "hw/timer/qct-qtimer.h"
>  #include "qom/object.h"
>  #include "target/hexagon/cpu.h"
>  
> @@ -26,6 +27,9 @@ struct HexagonGlobalRegState {
>      /* L2VIC interface used to back the VID/VID1 registers */
>      HexL2VicInterface *l2vic;
>  
> +    /* QTimer interface used to back the TIMERLO/TIMERHI registers */
> +    QctQtimerInterface *qtimer;
> +
>      /* Global performance cycle counter base */
>      uint64_t g_pcycle_base;
>  
> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
> index 4cf88627c8f..21bb80ac27a 100644
> --- a/hw/hexagon/hexagon_dsp.c
> +++ b/hw/hexagon/hexagon_dsp.c
> @@ -17,6 +17,7 @@
>  #include "hw/hexagon/hexagon_globalreg.h"
>  #include "hw/hexagon/hexagon_tlb.h"
>  #include "hw/intc/hex-l2vic.h"
> +#include "hw/timer/qct-qtimer.h"
>  #include "hw/core/loader.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> @@ -141,6 +142,17 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
>      sysbus_mmio_map(SYS_BUS_DEVICE(hms->l2vic_dev), 1,
>                      m_cfg->cfgtable.fastl2vic_base << 16);
>  
> +    hms->qtimer_dev = qdev_new(TYPE_QCT_QTIMER);
> +    object_property_add_child(OBJECT(machine), "qtimer",
> +                              OBJECT(hms->qtimer_dev));
> +    qdev_prop_set_uint32(hms->qtimer_dev, "nr_frames", 3);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(hms->qtimer_dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(hms->qtimer_dev), 1, m_cfg->qtmr_region);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(hms->qtimer_dev), 0,
> +                       qdev_get_gpio_in(hms->l2vic_dev, 3));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(hms->qtimer_dev), 1,
> +                       qdev_get_gpio_in(hms->l2vic_dev, 4));
> +
>      glob_regs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
>      object_property_add_child(OBJECT(machine), "global-regs",
>                                OBJECT(glob_regs_dev));
> @@ -148,6 +160,8 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
>      qdev_prop_set_uint32(glob_regs_dev, "dsp-rev", rev);
>      object_property_set_link(OBJECT(glob_regs_dev), "l2vic",
>                               OBJECT(hms->l2vic_dev), &error_fatal);
> +    object_property_set_link(OBJECT(glob_regs_dev), "qtimer",
> +                             OBJECT(hms->qtimer_dev), &error_fatal);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(glob_regs_dev), &error_fatal);
>  
>      tlb_dev = qdev_new(TYPE_HEXAGON_TLB);
> diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalreg.c
> index 3d0d6f9516c..0353d89f87b 100644
> --- a/hw/hexagon/hexagon_globalreg.c
> +++ b/hw/hexagon/hexagon_globalreg.c
> @@ -141,15 +141,26 @@ static inline bool is_vid_reg(uint32_t reg)
>      return reg == HEX_SREG_VID || reg == HEX_SREG_VID1;
>  }
>  
> +static inline bool is_timer_reg(uint32_t reg)
> +{
> +    return reg == HEX_SREG_TIMERLO || reg == HEX_SREG_TIMERHI;
> +}
> +
>  /*
> - * HEX_SREG_VID/VID1 are backed by the L2VIC's VID group registers
> - * rather than the plain regs[] array, when an L2VIC is wired up.
> + * HEX_SREG_VID/VID1 are backed by the L2VIC's VID group registers, and
> + * HEX_SREG_TIMERLO/TIMERHI are backed by the QTimer's live counter,
> + * rather than the plain regs[] array, when those devices are wired up.
>   */
>  static uint32_t get_reg_value(HexagonGlobalRegState *s, uint32_t reg)
>  {
>      if (is_vid_reg(reg) && s->l2vic) {
>          return l2vic_read_vid(s->l2vic, reg == HEX_SREG_VID ? 0 : 1);
>      }
> +    if (is_timer_reg(reg) && s->qtimer) {
> +        return reg == HEX_SREG_TIMERLO ?
> +                qct_qtimer_get_timer_lo(s->qtimer) :
> +                qct_qtimer_get_timer_hi(s->qtimer);
> +    }
>      return s->regs[reg];
>  }
>  
> @@ -306,6 +317,8 @@ static const VMStateDescription vmstate_hexagon_globalreg = {
>  static const Property hexagon_globalreg_properties[] = {
>      DEFINE_PROP_LINK("l2vic", HexagonGlobalRegState, l2vic,
>                       TYPE_HEX_L2VIC_INTERFACE, HexL2VicInterface *),
> +    DEFINE_PROP_LINK("qtimer", HexagonGlobalRegState, qtimer,
> +                     TYPE_QCT_QTIMER_INTERFACE, QctQtimerInterface *),
>      DEFINE_PROP_UINT32("boot-evb", HexagonGlobalRegState, boot_evb, 0x0),
>      DEFINE_PROP_UINT64("config-table-addr", HexagonGlobalRegState,
>                         config_table_addr, 0xffffffffULL),
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> index 2256d3d53a5..7e32765d1cc 100644
> --- a/hw/hexagon/virt.c
> +++ b/hw/hexagon/virt.c
> @@ -16,6 +16,7 @@
>  #include "hw/hexagon/hexagon_globalreg.h"
>  #include "hw/hexagon/hexagon_tlb.h"
>  #include "hw/intc/hex-l2vic.h"
> +#include "hw/timer/qct-qtimer.h"
>  #include "hw/core/loader.h"
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/qdev-clock.h"
> @@ -279,12 +280,27 @@ static void virt_init(MachineState *ms)
>      sysbus_mmio_map(SYS_BUS_DEVICE(vms->parent_obj.l2vic_dev), 1,
>                      m_cfg->cfgtable.fastl2vic_base << 16);
>  
> +    vms->parent_obj.qtimer_dev = qdev_new(TYPE_QCT_QTIMER);
> +    object_property_add_child(OBJECT(ms), "qtimer",
> +                              OBJECT(vms->parent_obj.qtimer_dev));
> +    qdev_prop_set_uint32(vms->parent_obj.qtimer_dev, "nr_frames", 2);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(vms->parent_obj.qtimer_dev),
> +                             &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(vms->parent_obj.qtimer_dev), 1,
> +                    m_cfg->qtmr_region);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(vms->parent_obj.qtimer_dev), 0,
> +                       qdev_get_gpio_in(vms->parent_obj.l2vic_dev, 3));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(vms->parent_obj.qtimer_dev), 1,
> +                       qdev_get_gpio_in(vms->parent_obj.l2vic_dev, 4));

We should consider extract an init function for this, as it's mostly
duplicated between virt and hexagon_dsp.
Also, is the difference in nr_frames expected?

> +
>      gsregs_dev = qdev_new(TYPE_HEXAGON_GLOBALREG);
>      object_property_add_child(OBJECT(ms), "global-regs", OBJECT(gsregs_dev));
>      qdev_prop_set_uint64(gsregs_dev, "config-table-addr", m_cfg->cfgbase);
>      qdev_prop_set_uint32(gsregs_dev, "dsp-rev", v68_rev);
>      object_property_set_link(OBJECT(gsregs_dev), "l2vic",
>                               OBJECT(vms->parent_obj.l2vic_dev), &error_fatal);
> +    object_property_set_link(OBJECT(gsregs_dev), "qtimer",
> +                             OBJECT(vms->parent_obj.qtimer_dev), &error_fatal);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), &error_fatal);
>  
>      tlb_dev = qdev_new(TYPE_HEXAGON_TLB);
> diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
> index 191c6c5d65c..56cd5b15c55 100644
> --- a/hw/hexagon/Kconfig
> +++ b/hw/hexagon/Kconfig
> @@ -3,6 +3,7 @@ config HEX_DSP
>      default y
>      depends on HEXAGON
>      select HEX_L2VIC
> +    select HEX_QTIMER
>  
>  config HEX_VIRT
>      bool


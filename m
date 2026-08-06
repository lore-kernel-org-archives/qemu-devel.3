Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCC3C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrwMx-0003Kc-6h; Thu, 06 Aug 2026 07:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrwMn-0003IG-Bj
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:34:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrwMi-0005kn-Sh
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:34:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6769nhGR1876524
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 11:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y9oQa62LzGjHsQY0vlJNfBgfZk3ZSOrHFg3e897f7DU=; b=eeu0HA9+yH0Mf9mZ
 meFj0CxtBzam/Ex1tmoF000FFYqwooDV5FHgnLOozb7H5fPEKjziVkos8hBeOQmk
 uI+SY9KF0xKA9Jo+8y5e8NrsGJ7PvH9j2yQv2bQQ21EC5nOHrkJZfgMZ3K3QOEq9
 EFury5tT4++3r0bY8IjolIuqFKLTjkJuGU+gD138c+8O8Rr3pJbDoQZncSvIgr2N
 Lrm3G9KhnQ/T6RAetKQpKAJtS/Bk/6KxfkPoDvthqz5oFq0bAY7/qhQ2331qS+rk
 ITRa67CBb+KcavuE7TAFBDfkFfVOWsToMAaYsZVwFQjZOWRDPnZ0BbQo1Nt8p6ov
 x05m7Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjuchv3a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 11:34:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494527488so340489085a.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786016063; x=1786620863; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y9oQa62LzGjHsQY0vlJNfBgfZk3ZSOrHFg3e897f7DU=;
 b=BxQiNCKocyZusUdyLWNlBEP+OTjhrpMpjxhPKE5oH013A81wpw9Ccb6wN/FEzqbmrT
 hjedkyKKEm5qxbknoEIpLtsHdOG1v7YoCAZLarqAFRpfV9FQNKMrjZSCt/iQfajppVnV
 +2JJDD9PlzUAdQr/YnAeTOdRy7m6CTUQodB0v70B65jujOdQfzVqpEN0QDAWbveoTHD8
 Xm57pKZSQrSANLU+rkiejdQaJkcOwq4lXPYT5n1gWYpfbat+cLU1Hh3HXUP7d4IcGS7r
 zgINvvskc2mABXd48g83BQa6e78QJ3yVD3mfdoHgz4rI/uvF0nvlfP23hFRtzEIvjLWC
 783g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786016063; x=1786620863;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y9oQa62LzGjHsQY0vlJNfBgfZk3ZSOrHFg3e897f7DU=;
 b=r9v/hpj0r3GimSqCR6tOewgW2aFUYxZrcF6ts9EyJBn1NNvvopkJg7TfMd2iFIwKDR
 Vd6aYkEmGntHNEzUtS0XHJZ+30Sz+vPgLUbrRI7NZuz8tfL5EKm2x7Lo0+xxy2PkeNJW
 ZaB923DzDJpM5T4Pn27TNNd82X3pr6sKKGKmoCNXb3YzJxE6gZ6VzG/8sdi8z49X7IdX
 3mbGgp9BFW/JDww0+rB3l4w4um63L7rkwM6MG9kPDPhaF8gGjnZg15w0BISjDPCWS1K0
 vpQ8lik9nwEJeyBKEp8UTDiQS0tCsc7BTh/F+T1dPlS4h2qbADYzFJwRZIfD8cz2yl0N
 PZ2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqelyi+bmT35CLX8nCzA9FDeQgAq0QntDZbpAmdVGnOq7CalUbEkSsEGGRmSyns7oPG7h8gFFES2Sbk@nongnu.org
X-Gm-Message-State: AOJu0Yw6xiwvknNzLqiUYmtWVvPc2NdNOSUR8Z3533aj+52NUAShrDIR
 iLXlHpjRcqBU3Q6a36mP/KKGxXhrkneg89iCNKC28G1HF2iZtMl2TQOutTbbmiQyYYaH3C0/dhT
 03ufEoAj85I6/lt025o5YiA6DtWs0IJuyuTEjJvcWLAqTan8h6KaUvB74cA==
X-Gm-Gg: AR+sD121XVKNhvMKsfsvsT4vmBTZ7OYbrzAm6+8qUYWe0xpx1gHmITnjWxeGyLwqPse
 cI4N3SoEIkhWqdKGR5/BYAXRm3GpZarEbbIBa9eHci4IVd0CPOQRuEhH899ZIm3f7E6ym9QyZJr
 QQuUb6gzGL/c0+5OAg0gGYCqyQPwSHOKFjRj0YMl8bJn9WblmSRGhHy7jT61RutGkvSXrHrxw9w
 HHeZyWyR0fEHKTDaPPgKAWHM6u6FcFiVHLbeIIHjkguUum7Ib+UDmBx6qddGXNjxHb1jCSNW1HC
 bHmr0nqpuL8cn5SzdccuOfajgFwQMxcAESXMnL0frFP+subeHiM3d1G4fddiELQWMJfPHvfMjLq
 uwy2H4j/CderhOY6YQ57gsn4JOTIjDTAWZP6f
X-Received: by 2002:a05:620a:1722:b0:931:5e6c:9bfa with SMTP id
 af79cd13be357-936664012afmr67111285a.9.1786016060837; 
 Thu, 06 Aug 2026 04:34:20 -0700 (PDT)
X-Received: by 2002:a05:620a:1722:b0:931:5e6c:9bfa with SMTP id
 af79cd13be357-936664012afmr67105785a.9.1786016060326; 
 Thu, 06 Aug 2026 04:34:20 -0700 (PDT)
Received: from [192.168.15.12] ([177.196.135.131])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a42aff9sm381338185a.14.2026.08.06.04.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:34:19 -0700 (PDT)
Message-ID: <aa74fe46-22e4-47b9-8427-83f6d63ddc8c@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 08:34:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] hw/dma: add K230 gsdma
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 farosas@suse.de, lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 caojunze424@gmail.com
References: <20260727155702.36484-1-dingtao0430@163.com>
 <20260727155702.36484-2-dingtao0430@163.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727155702.36484-2-dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5MSBTYWx0ZWRfXzSU1+MLKyiiw
 mz7u3zxM8emzDgOTTXNAkaTvP528LYalSiM2WCv9jbhgBok2TpZNZn9XZHGMxSQ0vukFNzxZjEn
 gKlchM9vPz6VsdEpdkJz5rXCTRWDX2I=
X-Proofpoint-GUID: J7MeSCARajz4fUbIaco3FH0LQCiRrtrj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5MSBTYWx0ZWRfX0/m4wMNv9fKD
 mUb9i7uFWf9n4L2YHUjgLqj9vGng574m8BzFuv9z6fFSjAO3Hrq5Ihu57twadRQMRVmkLMwU48P
 R+3fGyVTF+A9piTo3lC11CUFlGskORWH6MFNmjwpd34aZcQe4G3awJNklzI+po+iLHRe0sgLokI
 dJgk5hW1tU2YESdm8V3xxDBgQHhsvZrNTIaZU1PHRzDjcqyOAsJ9lXmnJS6yuPu82L78artNaqD
 AamzAlyidXbu4nNx20Lgqbwldcu01Jj6Qq9BpBkwKi3hP/WIiMGJ5zLZXVqdCyMIKdaltxwLakr
 VV+iO4M9VxOmlJ8JLwVjnKnQ9F/QEIqHIwhXgrE94jalpm9sdmt241yWNHkrX/sIRmxdwNKI9UV
 SATMRubvqxGBkMXGJ1QbW8h/AQ/VORh+19iRNch1zkhACmugNTNDwKdYFr9UxQQx9S4taTR0+BN
 9fXPiu5E7Crof30QybQ==
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a74713f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=TqADvzrrTdHTq19dv/zLaQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Rull5dLDAAAA:8 a=Byx-y9mGAAAA:8 a=Rw_h2NQzXipV68KcJwQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=WpjELI0oDsu8BIz5_MMC:22
X-Proofpoint-ORIG-GUID: J7MeSCARajz4fUbIaco3FH0LQCiRrtrj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060091
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

Hello,


On 7/27/2026 12:56 PM, Tao Ding wrote:
> K230 GSDMA includes SDMA (System Direct Memory Access) and GDMA (Graphic Direct Memory Access).
> In this patch, add SDMA for k230 board. The following features have not been implemented:
> 1. axi protocol related
> 2. channel arbitration
> 3. lower power mode
> 
> SDMA supports transfer data between memory, in which case SDMA is the controller.
> It also supports transfer data to decomp_gzip and caching it through SRAM.
> In this case, decomp_gzip is the controller, which controls SDMA through handshake signals.
> 
> According to "K230 Technical Reference Manual v0.3.1" section 2.5.2.
> https://download.kendryte.com/developer/k230/HDK/K230%E7%A1%AC%E4%BB%B6%E6%96%87%E6%A1%A3/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> 
> This commit includes:
> - K230 SDMA (System Direct Memory Access) model (k230_gsdma.c, k230_gsdma.h)
> - GSDMA trace log (trace-events)
> - Kconfig and meson.build
> - update MAINTAINERS
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---

LGTM.  One small detail:

> In patchv1, the reviewer identified some missing features and bugs, which have been fixed.
> bug:
>      src_addr should not increment in 2d-mode and src_fixed
> feature:
>      data endian conversion
> enhance:
>      use new reset interface
> 
>   MAINTAINERS                 |   2 +
>   hw/dma/Kconfig              |   3 +
>   hw/dma/k230_gsdma.c         | 562 ++++++++++++++++++++++++++++++++++++
>   hw/dma/meson.build          |   1 +
>   hw/dma/trace-events         |   6 +
>   include/hw/dma/k230_gsdma.h | 130 +++++++++
>   6 files changed, 704 insertions(+)
>   create mode 100644 hw/dma/k230_gsdma.c
>   create mode 100644 include/hw/dma/k230_gsdma.h
> 


[...]


> +static uint64_t k230_gsdma_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    K230GSDMAState *s = K230_GSDMA(opaque);
> +    unsigned int ch;
> +    hwaddr ch_off;
> +    uint64_t ret = 0;
> +
> +    switch (addr) {
> +    case K230_GSDMA_DMA_CH_EN:
> +        ret = s->dma_ch_en;
> +        break;
> +    case K230_GSDMA_DMA_INT_MASK:
> +        ret = s->dma_int_mask;
> +        break;
> +    case K230_GSDMA_DMA_INT_STAT:
> +        ret = s->dma_int_stat;
> +        break;
> +    case K230_GSDMA_DMA_CFG:
> +        ret = s->dma_cfg;
> +        break;
> +    case K230_GSDMA_GDMA_CTRL:
> +    case K230_GSDMA_GDMA_LLI_BASE:
> +    case K230_GSDMA_GDMA_CURRENT_LLT:
> +    case K230_GSDMA_GDMA_CH_CNT0 ... K230_GSDMA_GDMA_CH_CNT_LAST:
> +        break;
> +    case K230_GSDMA_DMA_WEIGHT:
> +        ret = s->dma_weight;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
> +    ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
> +    if (ch < K230_GSDMA_NUM_SDMA_CHANNELS) {
> +        switch (ch_off) {
> +        case K230_GSDMA_CH_CTL:
> +            break;
> +        case K230_GSDMA_CH_STATUS:
> +            ret = s->channels[ch].status;
> +            break;
> +        case K230_GSDMA_CH_CFG:
> +            ret = s->channels[ch].cfg;
> +            break;
> +        case K230_GSDMA_CH_USR_DATA:
> +            ret = s->channels[ch].usr_data;
> +            break;
> +        case K230_GSDMA_CH_LLT_SADDR:
> +            ret = s->channels[ch].llt_saddr;
> +            break;
> +        case K230_GSDMA_CH_CURRENT_LLT:
> +            ret = s->channels[ch].current_llt;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    trace_k230_gsdma_read(addr, size, ret);
> +    return ret;
> +}
> +
> +static void k230_gsdma_write_gdma(K230GSDMAState *s, hwaddr addr, uint32_t value)
> +{
> +    switch (addr) {
> +    case K230_GSDMA_GDMA_CTRL:
> +    case K230_GSDMA_GDMA_LLI_BASE:
> +    case K230_GSDMA_GDMA_CURRENT_LLT:
> +    case K230_GSDMA_GDMA_CH_CNT0 ... K230_GSDMA_GDMA_CH_CNT_LAST:
> +        return;
> +    default:
> +        return;
> +    }
> +}

I'm note sure what's the intent of this function.  It's not being filled with
logic in the other patches either so it's basically a no-op.

I suggest removing it entirely.  And, in k230_gsdma_write():

+    if (addr < K230_GSDMA_CH_BASE) {
+        k230_gsdma_write_gdma(s, addr, v);
+        return;
+    }


Just do the "return".


Thanks,
Daniel



> +
> +static void k230_gsdma_write_channel(K230GSDMAState *s, unsigned int ch,
> +                                     hwaddr ch_off, uint32_t value)
> +{
> +    K230GSDMAChannel *c = &s->channels[ch];
> +    bool handshake_mode = ch < 2 && k230_gsdma_decomp_enabled(s);
> +
> +    switch (ch_off) {
> +    case K230_GSDMA_CH_CTL:
> +        c->ctl = value;
> +        if ((value & K230_GSDMA_CTL_STOP) != 0) {
> +            c->started = false;
> +            k230_gsdma_sdma_set_idle(c);
> +            break;
> +        }
> +        if ((value & K230_GSDMA_CTL_RESUME) != 0 &&
> +            (c->status & K230_GSDMA_SDMA_STATUS_PAUSE) && c->next_llt != 0) {
> +            k230_gsdma_run_sdma(s, ch, c->next_llt);
> +            break;
> +        }
> +        if (handshake_mode && (value & K230_GSDMA_CTL_START) != 0) {
> +            c->started = true;
> +            c->status &= ~(K230_GSDMA_SDMA_STATUS_BUSY |
> +                           K230_GSDMA_SDMA_STATUS_PAUSE);
> +            c->current_llt = 0;
> +            c->next_llt = 0;
> +            break;
> +        }
> +        if ((value & K230_GSDMA_CTL_START) != 0 &&
> +            (s->dma_ch_en & BIT(ch)) && c->llt_saddr != 0) {
> +            c->started = true;
> +            k230_gsdma_run_sdma(s, ch, c->llt_saddr);
> +        }
> +        break;
> +    case K230_GSDMA_CH_CFG:
> +        c->cfg = value;
> +        break;
> +    case K230_GSDMA_CH_USR_DATA:
> +        c->usr_data = value;
> +        break;
> +    case K230_GSDMA_CH_LLT_SADDR:
> +        c->llt_saddr = value;
> +        break;
> +    case K230_GSDMA_CH_CURRENT_LLT:
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static void k230_gsdma_write(void *opaque, hwaddr addr,
> +                             uint64_t value, unsigned int size)
> +{
> +    K230GSDMAState *s = K230_GSDMA(opaque);
> +    unsigned int ch;
> +    hwaddr ch_off;
> +    uint32_t v = value;
> +
> +    trace_k230_gsdma_write(addr, size, value);
> +
> +    switch (addr) {
> +    case K230_GSDMA_DMA_CH_EN:
> +        s->dma_ch_en = v & K230_GSDMA_DMA_CH_EN_MASK;
> +        return;
> +    case K230_GSDMA_DMA_INT_MASK:
> +        s->dma_int_mask = v;
> +        k230_gsdma_update_irq(s);
> +        return;
> +    case K230_GSDMA_DMA_INT_STAT:
> +        s->dma_int_stat &= ~v;
> +        k230_gsdma_update_irq(s);
> +        return;
> +    case K230_GSDMA_DMA_CFG:
> +        s->dma_cfg = v;
> +        return;
> +    case K230_GSDMA_DMA_WEIGHT:
> +        s->dma_weight = v & 0x00ffffff;
> +        return;
> +    default:
> +        break;
> +    }
> +
> +    if (addr < K230_GSDMA_CH_BASE) {
> +        k230_gsdma_write_gdma(s, addr, v);
> +        return;
> +    }
> +
> +    ch = (addr - K230_GSDMA_CH_BASE) / K230_GSDMA_CH_STRIDE;
> +    ch_off = (addr - K230_GSDMA_CH_BASE) % K230_GSDMA_CH_STRIDE;
> +    if (ch >= K230_GSDMA_NUM_SDMA_CHANNELS) {
> +        return;
> +    }
> +
> +    k230_gsdma_write_channel(s, ch, ch_off, v);
> +}
> +
> +static void k230_gsdma_handle_signal(void *opaque, int n, int level)
> +{
> +    K230GSDMAState *s = opaque;
> +    K230GSDMAChannel *c;
> +    hwaddr addr;
> +    unsigned int ch;
> +
> +    if (!level || n == K230_GSDMA_GPIO_DECOMP_CTRL_EN) {
> +        return;
> +    }
> +
> +    ch = n - 1;
> +
> +    c = &s->channels[ch];
> +    if (!k230_gsdma_decomp_enabled(s) || !(s->dma_ch_en & BIT(ch)) || !c->started) {
> +        return;
> +    }
> +
> +    if (c->current_llt == 0) {
> +        addr = c->llt_saddr;
> +    } else {
> +        addr = c->next_llt;
> +    }
> +    if (!addr) {
> +        return;
> +    }
> +
> +    k230_gsdma_step_sdma(s, ch, addr);
> +    qemu_set_irq(s->handshake_out[n - 1], 1);
> +    qemu_set_irq(s->handshake_out[n - 1], 0);
> +}
> +
> +static const MemoryRegionOps k230_gsdma_ops = {
> +    .read = k230_gsdma_read,
> +    .write = k230_gsdma_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 4,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static void k230_gsdma_reset_hold(Object *obj, ResetType type)
> +{
> +    K230GSDMAState *s = K230_GSDMA(obj);
> +
> +    memset(s->channels, 0, sizeof(s->channels));
> +    s->dma_ch_en = 0;
> +    s->dma_int_mask = 0;
> +    s->dma_int_stat = 0;
> +    s->dma_cfg = K230_GSDMA_DMA_CFG_RESET;
> +    s->dma_weight = 0;
> +}
> +
> +static void k230_gsdma_realize(DeviceState *dev, Error **errp)
> +{
> +    K230GSDMAState *s = K230_GSDMA(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &k230_gsdma_ops, s,
> +                          TYPE_K230_GSDMA, K230_GSDMA_MMIO_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
> +    qdev_init_gpio_in(DEVICE(dev), k230_gsdma_handle_signal,
> +                      K230_GSDMA_NUM_GPIOS_IN);
> +    qdev_init_gpio_out(DEVICE(dev), s->handshake_out,
> +                       K230_GSDMA_NUM_GPIOS_OUT);
> +}
> +
> +static void k230_gsdma_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->realize = k230_gsdma_realize;
> +    rc->phases.hold = k230_gsdma_reset_hold;
> +    dc->vmsd = &vmstate_k230_gsdma;
> +    dc->desc = "Kendryte K230 GSDMA";
> +}
> +
> +static const TypeInfo k230_gsdma_info = {
> +    .name = TYPE_K230_GSDMA,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(K230GSDMAState),
> +    .class_init = k230_gsdma_class_init,
> +};
> +
> +static void k230_gsdma_register_types(void)
> +{
> +    type_register_static(&k230_gsdma_info);
> +}
> +
> +type_init(k230_gsdma_register_types)
> diff --git a/hw/dma/meson.build b/hw/dma/meson.build
> index cc7810beb8..45db5e7357 100644
> --- a/hw/dma/meson.build
> +++ b/hw/dma/meson.build
> @@ -12,3 +12,4 @@ system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dma.c', 'soc_dma.c'))
>   system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'))
>   system_ss.add(when: 'CONFIG_XLNX_CSU_DMA', if_true: files('xlnx_csu_dma.c'))
> +system_ss.add(when: 'CONFIG_K230_GSDMA', if_true: files('k230_gsdma.c'))
> diff --git a/hw/dma/trace-events b/hw/dma/trace-events
> index 4c09790f9a..a494755b5a 100644
> --- a/hw/dma/trace-events
> +++ b/hw/dma/trace-events
> @@ -47,3 +47,9 @@ pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data: 0x%08"
>   
>   # xilinx_axidma.c
>   xilinx_axidma_loading_desc_fail(uint32_t res) "error:%u"
> +
> +# k230_gsdma.c
> +k230_gsdma_read(uint64_t addr, unsigned int size, uint64_t data) "K230 GSDMA read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
> +k230_gsdma_write(uint64_t addr, unsigned int size, uint64_t data) "K230 GSDMA write: [0x%"PRIx64"] size %u <- 0x%"PRIx64
> +k230_gsdma_read_sdma_llt(uint64_t addr, uint32_t cfg, uint32_t src_addr, uint32_t line_size, uint32_t line_cfg, uint32_t dst_addr, uint32_t next_llt_addr) "K230 GSDMA read SDMA LLT: addr=0x%"PRIx64" cfg=0x%"PRIx32" src=0x%"PRIx32" line_size=0x%"PRIx32" line_cfg=0x%"PRIx32" dst=0x%"PRIx32" next=0x%"PRIx32
> +k230_gsdma_read_sdma_llt_failed(uint64_t addr) "K230 GSDMA read SDMA LLT failed: addr=0x%"PRIx64
> diff --git a/include/hw/dma/k230_gsdma.h b/include/hw/dma/k230_gsdma.h
> new file mode 100644
> index 0000000000..629cce29f8
> --- /dev/null
> +++ b/include/hw/dma/k230_gsdma.h
> @@ -0,0 +1,130 @@
> +/*
> + * K230 GSDMA
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_DMA_K230_GSDMA_H
> +#define HW_DMA_K230_GSDMA_H
> +
> +#include "hw/core/sysbus.h"
> +
> +#define TYPE_K230_GSDMA "riscv.k230.gsdma"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230GSDMAState, K230_GSDMA)
> +
> +#define K230_GSDMA_MMIO_SIZE          0x4000
> +#define K230_GSDMA_NUM_SDMA_CHANNELS  4
> +
> +#define K230_GSDMA_CH_STRIDE          0x30
> +#define K230_GSDMA_CH_BASE            0x50
> +
> +/* K230 SDMA request input */
> +enum {
> +    K230_GSDMA_GPIO_DECOMP_CTRL_EN,
> +    K230_GSDMA_GPIO_DMA_WRITE_REQ,
> +    K230_GSDMA_GPIO_DMA_READ_REQ,
> +    K230_GSDMA_NUM_GPIOS_IN,
> +};
> +
> +/* K230 SDMA ACK output */
> +enum {
> +    K230_GSDMA_GPIO_DMA_WRITE_ACK,
> +    K230_GSDMA_GPIO_DMA_READ_ACK,
> +    K230_GSDMA_NUM_GPIOS_OUT,
> +};
> +
> +/* K230 GSDMA Registers Map */
> +#define K230_GSDMA_DMA_CH_EN          0x00
> +#define K230_GSDMA_DMA_INT_MASK       0x04
> +#define K230_GSDMA_DMA_INT_STAT       0x08
> +#define K230_GSDMA_DMA_CFG            0x0c
> +#define K230_GSDMA_GDMA_CTRL          0x10
> +#define K230_GSDMA_GDMA_LLI_BASE      0x14
> +#define K230_GSDMA_GDMA_CH_CNT0       0x18
> +#define K230_GSDMA_GDMA_CH_CNT_LAST   0x34
> +#define K230_GSDMA_GDMA_CURRENT_LLT   0x38
> +#define K230_GSDMA_DMA_WEIGHT         0x48
> +
> +/* K230 GSDMA SDMA Channel Register Map */
> +#define K230_GSDMA_CH_CTL             0x00
> +#define K230_GSDMA_CH_STATUS          0x04
> +#define K230_GSDMA_CH_CFG             0x08
> +#define K230_GSDMA_CH_USR_DATA        0x0c
> +#define K230_GSDMA_CH_LLT_SADDR       0x10
> +#define K230_GSDMA_CH_CURRENT_LLT     0x14
> +
> +/* K230 SDMA Control bit */
> +#define K230_GSDMA_CTL_START          BIT(0)
> +#define K230_GSDMA_CTL_STOP           BIT(1)
> +#define K230_GSDMA_CTL_RESUME         BIT(2)
> +
> +/* K230 SDMA States bit */
> +#define K230_GSDMA_SDMA_STATUS_BUSY   BIT(0)
> +#define K230_GSDMA_SDMA_STATUS_PAUSE  BIT(1)
> +
> +/* K230 SDMA Interrupt bit */
> +#define K230_GSDMA_SDMA_DONE_INT(ch)  BIT(ch)
> +#define K230_GSDMA_SDMA_ITEM_INT(ch)  BIT((ch) + 4)
> +#define K230_GSDMA_SDMA_PAUSE_INT(ch) BIT((ch) + 8)
> +
> +
> +#define K230_GSDMA_DMA_CH_EN_MASK     MAKE_64BIT_MASK(0, 5)
> +#define K230_GSDMA_DMA_CFG_RESET      0x000007ff
> +
> +/* K230 SDMA Linked List bit */
> +#define K230_GSDMA_LLT_2D_MODE        BIT(28)
> +#define K230_GSDMA_LLT_PAUSE          BIT(29)
> +#define K230_GSDMA_LLT_NODE_INTR      BIT(30)
> +#define K230_GSDMA_GDMA_LLT_GCH_SHIFT 16
> +#define K230_GSDMA_GDMA_LLT_GCH_MASK  0x7
> +#define K230_GSDMA_CH_CFG_DAT_MODE    BIT(0)
> +#define K230_GSDMA_CH_CFG_USR_DATA_SIZE_SHIFT 1
> +#define K230_GSDMA_CH_CFG_USR_DATA_SIZE_MASK  0x3
> +#define K230_GSDMA_CH_CFG_DAT_ENDIAN_SHIFT 4
> +#define K230_GSDMA_CH_CFG_DAT_ENDIAN_MASK  0x3
> +#define K230_GSDMA_CH_CFG_SRC_FIXED   BIT(8)
> +#define K230_GSDMA_CH_CFG_DST_FIXED   BIT(9)
> +#define K230_GSDMA_CH0_CFG_DECOMP_CTRL_EN BIT(10)
> +
> +/* K230 SDMA channel state */
> +typedef struct K230GSDMAChannel {
> +    uint32_t ctl;
> +    uint32_t status;
> +    uint32_t cfg;
> +    uint32_t usr_data;
> +    uint32_t llt_saddr;
> +    uint32_t current_llt;
> +    uint32_t next_llt;
> +    bool started;
> +} K230GSDMAChannel;
> +
> +/* K230 SDMA Linked List */
> +typedef struct K230GSDMALLT {
> +    uint32_t cfg;
> +    uint32_t src_addr;
> +    uint32_t line_size;
> +    uint32_t line_cfg;
> +    uint32_t dst_addr;
> +    uint32_t next_llt_addr;
> +} K230GSDMALLT;
> +
> +/* K230 GSDMA state */
> +struct K230GSDMAState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +    qemu_irq handshake_out[K230_GSDMA_NUM_GPIOS_OUT];
> +
> +    uint32_t dma_ch_en;
> +    uint32_t dma_int_mask;
> +    uint32_t dma_int_stat;
> +    uint32_t dma_cfg;
> +    uint32_t dma_weight;
> +
> +    K230GSDMAChannel channels[K230_GSDMA_NUM_SDMA_CHANNELS];
> +};
> +
> +#endif



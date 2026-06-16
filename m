Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35E4CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 00:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZI7F-0001qv-5c; Mon, 15 Jun 2026 20:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZI7B-0001qW-Ix
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:57:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZI79-0001tB-O1
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 20:57:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G0Nxdj1561404
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UTOkNm5tRGHLvfrxbbEYGVhO2qDOhTfZCRaYtMpelEk=; b=QkVmjbWaiLUfjD3o
 ofZpzmLweVCWR0ukT6Uuvw/NGsr9nYE1pN3VP+YWGkOA4GT4kBLLa2UHZf0Z1nvx
 ILpfiMJo3dcXbKBtTFoE4lU57+c59HfQd1AEuTtUV/tXrcIw9BA+sNvPPDif8FWu
 NJesJLDxLPHbcKlppKIttDljc+OwumodahFu53DJcO8+5ynETOFf0ukyto7cSoUB
 U6n4ODcRZYLNZYHe3afeZmP5MZXQDhhky/XSJS9a1KsVW9yFYm7/bYrt9geypw4e
 hjMAu4qOo4PjMxuoYsXKEqBHP6PxGM0AHs6ItLbUHCONPpXl2K4hbbYwHj2FnvbJ
 mGk+kw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteydbtsd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:57:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915b3587972so378212585a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781571432; x=1782176232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTOkNm5tRGHLvfrxbbEYGVhO2qDOhTfZCRaYtMpelEk=;
 b=Ga5ZFsXg7FtR4nbfM113AZsotq9/YSkqwP3uTc9TKB+QTHtWUnCMnA0LzXRYmN/JBS
 Jc1cmlQc3gMoqgjW+GnNkaNhGAbi6c1giWLueKUjvxE22KVC5isNjJD77u3zCCN3wwUy
 wVI1FjlgLy+A9kiYsT31/fKSisOGiMd1CdX3fvwFCmxWKV2b6TJupbdJdvY9UX2IPamb
 aX3ZRXXlGjEkqluncyZ13aHQHS7nWE6HMspEvwrnhR64dh+U18GgWdpH8i7w1wzrt+c3
 efD1mFA5YOrScfeqUKv/sUyGjJ/QvOhLBM1aNeMNsvZo5Jxkvz01Kz/1RqFU8nI64kxX
 MuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781571432; x=1782176232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTOkNm5tRGHLvfrxbbEYGVhO2qDOhTfZCRaYtMpelEk=;
 b=AmYch7Rmh75m4o4h2DoFdRcjPBPaxZQ8U+ot3yXmECYTgH/VhQAs6y4sQ4lTbYk+pH
 gddWg/8G6f62iaK67eJbyRoueQQLZmbb528v5Lb6QdUUUlBAeSAftqCjcw6cljaz+K2F
 XccvRsLqIudA639HoaxXGA+hH6+Tz7/QcewGx/Qu7iIsmyKuWGj8M/Qv19JeTU+hK76G
 Jc5zranULGzAGwF4ZnED3kZEjMtgIwN5sSzTfFqsgUcLnMYFiK6jWwGRwH9DEExXDmB7
 PZss6Q5nUhXvatCWP3wDiGH9Gdea+Eb1O1MTJzBs52zebGN8UvMahs2DQ1zyzS4OAHAi
 S13g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WSTT3laaSC6NiUAyRSx5RnLxsGrpYg4fFz7UKBomfA6AkxNaQ7s5RCvbe4DMsZzaBJT8wL8IeKWyH@nongnu.org
X-Gm-Message-State: AOJu0YyiR3xeDk3u8twBgNd6J2MLp4kigexFKpqTOvPOpRS+rK7GWrVB
 m2lN5+Z0j/h8AlT4j4HLujtaRtix7GxPHIVCVobqywMXI5rzlRQezd+J1h7oPz/ClFt+tR3xr14
 emArvbs1nfzZo6uQDsNKzjgjfAHv+hH8Wv7DgOwn4wajEUdbgjrUvD4qsHg==
X-Gm-Gg: Acq92OHjEeh+zU+yYA6COP6j9JB+NohQ4F8Tw8iWCQmt6f5B72R3gdGdZQh2xKdV016
 P0cH7k0bQzI6mLdB344Z0mEnxsvGYCQqeNEtGGhsBeJBrQs1+R5WAAzfNZ7rGdGi6xDlJdV6B0y
 Bwr57cDz1k36JPVun4qgMlDXB9XhIwK5I2P+P6zM7i/WidmxbjxrDS68gzMz+E8XBHMWNXxDUPs
 aMckuq//brMeO9Zn4OYWGQUf0kr9ZhsxWeMYEDRuFQcGRjCrJdNib0dX9L2L2hWipYSm1gTkQUk
 jkmdcyNZteOMmCmhdGJgjSNxfzLjey406HAh67/5vA3d/aq3+bf+pcotx2wTzyv6+Vp9l7UrSX7
 IGIF969ihei1BZZ138YsT1gLNOPSpwzq1XaC3PeAcZeqDb3aV0Z4xQ3m9fmwMoO8T65ENWk9F
X-Received: by 2002:a05:620a:640e:b0:915:8f08:5fa7 with SMTP id
 af79cd13be357-91c4893c61emr263388885a.52.1781571432131; 
 Mon, 15 Jun 2026 17:57:12 -0700 (PDT)
X-Received: by 2002:a05:620a:640e:b0:915:8f08:5fa7 with SMTP id
 af79cd13be357-91c4893c61emr263387385a.52.1781571431659; 
 Mon, 15 Jun 2026 17:57:11 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f3dcsm37260466f8f.13.2026.06.15.17.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 17:57:11 -0700 (PDT)
Message-ID: <20f234a0-7ddf-4967-9c2a-80a9b36a3ea5@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 02:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] igb: Define TRL registers and core state
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260615-igb-trl-v4-0-cf5739bf529f@google.com>
 <20260615-igb-trl-v4-1-cf5739bf529f@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615-igb-trl-v4-1-cf5739bf529f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: L5KsYjiirpYb2H4jOnJytVMm_aayJFiJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfX3qvSvE/qrVuQ
 913pq5Kr0EbOVbEtKDGn+5thHucBFmlJ+qWYJf8il7JOEGY2yf625ZT4FCc0dM4kWDsDHAg9O87
 m8t5xeGhhsjdJ1Pa4IcMfGlYMJ2a9Ic=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a309f69 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=1XWaLZrsAAAA:8 a=Y9nLv_mnkfPVsDtVIqEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: L5KsYjiirpYb2H4jOnJytVMm_aayJFiJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAwNiBTYWx0ZWRfXzKkaZriZ8zxz
 GC/I7Ldq0d3rlVkFO1M+Sk9wS2CYCjEvHH7ErmsdK0MsS+2JpM7pzJEbHQuBHA8+iUdxdhuDNO9
 TxjQlvCbT9lfmJVAWooLM1qamwptf/AVDNT7VUYjA0j2RgUdjsO+XS9TBJ+n1+zQOuyTTnmj0Gh
 lggXodiDvSGMh5W2LpGVjnsH9d3QtXJhNT4iY30F7PnZ/EDLEFgLAi0jnMH8ptg0sy11oMsVY9p
 VHLtjwZ6VmFLEQ+o5iVlXV2SL9qcSKJPEFNyW8fd51CfONdsB/DZLrviNcfj+kg1Sq6sdQmbfbA
 j3e35IUfF8kOzwlbQAtAZFAfuJlHT/wE7gvdJYFGH7IxP3tAJw2/7D7kunBkdIKQmWh8u8S59xL
 Qce0BnIP6rhbQfDpTSzudQRTi3AqD51+UsI+VWljMHo4W0wELtN0ZjvE/Dcj41/bAg1UwTggpNH
 j7drNw7AX53uiPfU4aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160006
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

Hi,

On 16/6/26 00:18, Josh Hilke wrote:
> Introduce register offsets and bitmask constants for the Transmit Rate
> Limiter (TRL). Add the IGBTrlQueue structure and corresponding fields to
> IGBCore to track TRL state (timers, throttling status, and target rates)
> per queue. Initialize and free these timers during the device
> realize/uninit lifecycle, and reset them on device reset.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_common.h |  1 +
>   hw/net/igb_core.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/net/igb_core.h   | 13 ++++++++++++
>   hw/net/igb_regs.h   |  6 ++++++
>   4 files changed, 79 insertions(+)


> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 45d8fd7..c94e8d3 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -96,6 +96,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
>   
>   static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes);
>   static void igb_reset(IGBCore *core, bool sw);
> +static uint32_t igb_trl_get_scaled_rate_factor(uint32_t trlrc);
>   
>   static inline void
>   igb_raise_legacy_irq(IGBCore *core)
> @@ -4282,6 +4283,53 @@ igb_autoneg_resume(IGBCore *core)
>       }
>   }
>   
> +static uint32_t igb_trl_get_scaled_rate_factor(uint32_t trlrc)
> +{
> +    /*
> +     * The TRLRC register stores the Rate Factor in 10.14 fixed-point format:
> +     * - Bits 13:0: Fractional part
> +     * - Bits 23:14: Integer part
> +     *
> +     * Combined, the lower 24 bits of the register (23:0) represent the
> +     * concatenated 24-bit scaled Rate Factor directly.
> +     */
> +    return trlrc & 0xFFFFFF;

Alternatively:

        return extract32(trlrc, 0, 24);

> +}
> +
> +bool igb_trl_enabled(uint32_t trlrc)
> +{
> +    return trlrc & E1000_TRLRC_RS_ENA;
> +}
> +
> +uint64_t igb_trl_get_target_rate(const IGBTrlQueue *q)
> +{
> +    const uint64_t rf_scaled = igb_trl_get_scaled_rate_factor(q->trlrc);
> +
> +    if (!igb_trl_enabled(q->trlrc)) {
> +        return 0;
> +    }
> +
> +    if (rf_scaled == 0) {
> +        return 0;
> +    }
> +
> +    /*
> +     * The rate factor is a fixed-point number with a 14-bit fractional part:
> +     * Rate Factor = rf_scaled / 2^14
> +     *
> +     * The target rate is:
> +     * Target Rate = Link Rate / Rate Factor
> +     *             = Link Rate / (rf_scaled / 2^14)
> +     *             = (Link Rate * 2^14) / rf_scaled
> +     */
> +    return (E1000_LINK_RATE_1GBPS << 14) / rf_scaled;
> +}
> +
> +static void igb_trl_timer_cb(void *opaque)
> +{
> +    /* Stub */
> +}
> +
>   void
>   igb_core_pci_realize(IGBCore        *core,
>                        const uint16_t *eeprom_templ,
> @@ -4296,6 +4344,11 @@ igb_core_pci_realize(IGBCore        *core,
>   
>       for (i = 0; i < IGB_NUM_QUEUES; i++) {
>           net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
> +        core->trl[i].timer =
> +            timer_new_ns(QEMU_CLOCK_VIRTUAL, igb_trl_timer_cb,
> +                         &core->trl[i]);
> +        core->trl[i].core = core;
> +        core->trl[i].queue_idx = i;
>       }
>   
>       net_rx_pkt_init(&core->rx_pkt);
> @@ -4319,6 +4372,7 @@ igb_core_pci_uninit(IGBCore *core)
>   
>       for (i = 0; i < IGB_NUM_QUEUES; i++) {
>           net_tx_pkt_uninit(core->tx[i].tx_pkt);
> +        timer_free(core->trl[i].timer);
>       }
>   
>       net_rx_pkt_uninit(core->rx_pkt);
> @@ -4469,6 +4523,11 @@ static void igb_reset(IGBCore *core, bool sw)
>   
>       igb_intrmgr_reset(core);
>   
> +    for (i = 0; i < IGB_NUM_QUEUES; i++) {
> +        timer_del(core->trl[i].timer);
> +        core->trl[i].trlrc = 0;

Better introduce igb_trl_disable_queue() in this patch and use it here.

> +    }
> +
>       memset(core->phy, 0, sizeof core->phy);
>       memcpy(core->phy, igb_phy_reg_init, sizeof igb_phy_reg_init);
>   
> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> index d70b54e..f3d50bc 100644
> --- a/hw/net/igb_core.h
> +++ b/hw/net/igb_core.h
> @@ -63,6 +63,13 @@ typedef struct IGBIntrDelayTimer_st {
>       IGBCore *core;
>   } IGBIntrDelayTimer;
>   
> +typedef struct IGBTrlQueue_st {
> +    QEMUTimer *timer;
> +    IGBCore *core;
> +    int queue_idx;

unsigned?

> +    uint32_t trlrc;
> +} IGBTrlQueue;

Patch LGTM otherwise.


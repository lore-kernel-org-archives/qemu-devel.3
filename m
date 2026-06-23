Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01EACD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwxv-00016d-72; Tue, 23 Jun 2026 04:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwxt-00016A-OW
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:58:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwxq-0008RA-6i
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:58:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6dPbD3631300
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gI73+YowE0fv3b/u9prH1KGiTJbyzKxKQMO6yQWU98g=; b=TbhQrEBHX9dgPkVF
 6Y3YQI1au0mugGWHJaqpSCd00K4Kh/tZz9Yqc58lql/8jISvUO9TQ3k2UOnk2V1r
 v7ouwVDfV55ETUMdHE4tE+jEKzA19SHgT32dzmNIIpLKS1JxOZ38oPjUW5N1nXLB
 E291faKDwPKcps6iUnAZP1bnNJcsfKwb1c/0oKesZIYJtJNv4MSCNwzAxle3I6gP
 aT3js9ASHq1vhPsoA52SSs9pSOYDFON92wXSzeVXPB9c0+U8P5UvDsgdvutBmp1w
 KtRGMPd0j/5RF3rwvGVLqihI8o+t32RRkIboqhknUQ33JbdAzymLkT2n6uAJL6Iq
 Fhwk0A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvrkww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:58:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915f6ff639aso1355889885a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782205115; x=1782809915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gI73+YowE0fv3b/u9prH1KGiTJbyzKxKQMO6yQWU98g=;
 b=VSZmZpn1un6CVWC1gNJMbGnbIXpoRxxLe1AAP+zASILSDSaRgDzyWWcWb1U9acgFgV
 j4DsKQ9IIwcksEikjkn73CcpRgkL48KNVqitJ6HyYpLRlfPAko1lZ6R3PmZ3WUuPQtV5
 84o+0LAd7CwX+rk9T6BTqfECgev7UVu5tDBIq4qHWWMXl9ppkkiptuPFlV7/08rLM4fW
 hvkgOwCSlvjxb+4CpUhiOGHhiCG48IxFDtubx/Lp1MbkQTenr4sCyz5ZE+jry/+kJqTz
 jTlKTEI+hNj3iKk7DRoV7mcpRDcnYq60CGXTxMRxOaCqkEyQMeo4/zlSJMiqLihkENGL
 bHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782205115; x=1782809915;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gI73+YowE0fv3b/u9prH1KGiTJbyzKxKQMO6yQWU98g=;
 b=oZHMZOBqXjSwXwKivAHxCoufrqt3rB17AHOjMbR9WPGQAWDdl3UjDL06cDgUr9ull7
 wvIdnfvdF9AYsLxx9sgHjeJZaJrXrFWhJtR+e43Zgz47hRHdc8RJz2EqkIm8FlTg/frJ
 acRMHAq+mnL8BEzCeJsNmllyhTIP7PexqVQzWiDpUcrgfCLAMCUeyEM6g6A/7thWFkrD
 V9KfdwHi4WRo5jlq8y4/Tj1aUaexnKZIG43ZAqL+rqoteVOoy4DgfdT71BTIqoL06XJl
 132fdPvZwDJ2xKPt5wb5V3Ti1XPU5ZTOnWhU+aOor3uaTckABVcmf5NG0RLFn0/XQOdf
 Vtig==
X-Forwarded-Encrypted: i=1;
 AFNElJ89gfGtCmWIHNy8WmMoZNZzrDQaXXDjLEAY+V5QIAIkzKf8phohmawUUusCXRa82hpRFvukay/a4jQ0@nongnu.org
X-Gm-Message-State: AOJu0Yx1YD5kcsxWv+CrZeIiI14lf6WdU2+Wmhvtxw0pYADTIKS9rLZ+
 PQqczGWBmQW2bt6AsfO/+swem0tZIaFWYWw/cCaNf0qw41BBxkawUzSDq9jMhNLofUYjkGY0mj8
 YfGb1bjnNWPNba9v2LXrsiyv2YVo3C3zFT4/RRnq+NT/QRq8AJ9dBATHUuw==
X-Gm-Gg: AfdE7cmXCQRJWwl9fAvI61Dq7BtF+iaMy4OeERl28IeY8jIRE+oAC5ny0J+4KJ6OGCm
 zqpMB0IBC32QidVkb5wHOoXxljgYMn2N2cnmMOP222HzzsipzK903dsBN6FoIwF+m9HnWWAKxxz
 SCQOv38LyHvV5itPpvbsPqzvyyBHDL5txibjiek27OBpTM6JEyj9cc6EUgkSsaUvVgOkcPTKoZZ
 VgYD9HAzoet4n6Geku3A3p0+6Y+9IG5bS9Bwcncn3YSEXlDLABTeQFHyu+skhqYFg7cdtiee92L
 MCrj9XNaM535ncglOIWnVC2qqfakxOEaZ4TjXTwrp+zn712ouAxGhZxaqsdoC8h8xcxOVC92y1q
 LlWj7Vz2zQ3pq9S+Khvf9yDIZzlXy+1Y1eqnz35ySQEIPf4IIcgK3fbtDEPL4dw==
X-Received: by 2002:a05:620a:4629:b0:914:9218:f075 with SMTP id
 af79cd13be357-9266be58e4fmr251046285a.13.1782205114724; 
 Tue, 23 Jun 2026 01:58:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4629:b0:914:9218:f075 with SMTP id
 af79cd13be357-9266be58e4fmr251043385a.13.1782205114141; 
 Tue, 23 Jun 2026 01:58:34 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c60ac98c9sm474088766b.29.2026.06.23.01.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 01:58:33 -0700 (PDT)
Message-ID: <a1b8cd61-95d4-43ea-88db-8a9cdeba46de@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] igb: Implement TRL throttling and timer resumption
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
 <20260622-igb-trl-v7-5-abb960e767ac@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622-igb-trl-v7-5-abb960e767ac@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3a4abb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=Gi6WHStShwT2Mt3TXNwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfX4cj3K7nwDPqU
 dKJB84eFukAUaiXb6VKKLwvMiUsx1kbZUnVRv13oZfEv2UXxIhjYFzJYQbUjCQ7nJ+gGZTYbg2R
 9UmBBBAO3K4N6QbL4JEtM8MZ3qq89/4=
X-Proofpoint-ORIG-GUID: azo3WLNwT7NBBtyulRk4_8P1uHGw-pJ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfX8NU/JUF4Tr2g
 8DH5TtH2i0jVnxie6LfWzUX4/Z87rwpLmyt/blaC3vqH1cwPwPzVL3qDVDfzS7BOSShfVudjAXC
 lGQ6YJN7YIujTVM331HJi3bi3lN3hPVhVsf0DzHK4eUPSXeRNeTTGkDoAgRYh3W+yh2kAzrCV81
 zE+By2p7mauvn50hCxbx3I60+H8DVbNhBNRH8nxwioHT8yPBQbH71FoI1v2fT572VSUx8cz+N3c
 P+kSAz6CCMvHA6koSA+dkTYan1fM7zd+h/VnqJwR1fmOLPtfFKIM/sUCbJAJO31xuZ1eCH3evyY
 8qA57HeIwZipWKRvaRFY6EFYbkqUGbmzIblrpCMF/E9HusxVFLwq+MrgXSnTMEKfRkr/JWQxhvX
 dkIP9Gfajsn8gzDYwW9+hPH1eDwCi1zJm2yuoNePywA0FxKCvqBMkt27N/P2aXBI64E7vVbZWLn
 PJJ7JBG0aHcUnc1+dzQ==
X-Proofpoint-GUID: azo3WLNwT7NBBtyulRk4_8P1uHGw-pJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230071
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

On 22/6/26 21:05, Josh Hilke wrote:
> Integrate throttling logic into the transmission path. In
> `igb_start_xmit`, check if the queue is currently throttled.  Accumulate
> bytes sent, calculate the transmission delay based on the configured
> target rate, and if a throttle is triggered, set the virtual timer, mark
> the queue as throttled, and defer remaining packets.  Implement the
> timer callback to clear the throttled state and resume transmission when
> the timer expires.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_core.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 9a8ef15..e158837 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -97,6 +97,7 @@ igb_receive_internal(IGBCore *core, const struct iovec *iov, int iovcnt,
>   static void igb_raise_interrupts(IGBCore *core, size_t index, uint32_t causes);
>   static void igb_reset(IGBCore *core, bool sw);
>   
> +

Hmm?

>   static inline void
>   igb_raise_legacy_irq(IGBCore *core)
>   {
> @@ -875,6 +876,48 @@ igb_tx_enabled(IGBCore *core, const E1000ERingInfo *txi)
>           (core->mac[TXDCTL0 + (qn * 16)] & E1000_TXDCTL_QUEUE_ENABLE);
>   }
>   
> +static uint64_t igb_trl_calculate_delay(const IGBTrlQueue *q, size_t bytes_sent)
> +{
> +    uint32_t divisor;
> +    uint32_t rf;
> +
> +    if (!igb_trl_enabled(q)) {
> +        return 0;
> +    }
> +
> +    /*
> +     * 7.8 Transmit Rate Limiting (TRL)
> +     *
> +     * > RF = 1Gb/s / Target-Rate (Rate Factor) is the ratio between the
> +     * > nominal link rate and the target maximum rate to achieve for
> +     * > that rate controlled queue. It is a decimal number ranging from
> +     * > 1 to 1,000 (1 Mb/s minimum target rate) at least 10-bits before
> +     * > the hexadecimal point and 14-bits after, as required for the
> +     * > maximum PL by which it is multiplied.
> +     *
> +     * The TRLRC register stores the RF in 10.14 fixed-point format:
> +     * - Bits 13:0: Fractional part
> +     * - Bits 23:14: Integer part
> +     *
> +     * Combined, the lower 24 bits of the register (23:0) represent the
> +     * RF directly.
> +     */
> +    rf = MAX(extract32(q->trlrc, 0, 24), 1 << 14);
> +
> +    /*
> +     * Delay = PL (Packet Length) / Target-Rate
> +     *       = PL / (1Gb/s / RF)
> +     *       = PL * RF / 1Gb/s
> +     *       = PL * RF / (1G / b/B / ns/s) B/ns
> +     *       = (bytes_sent * (RF_scaled / 2^14) / (1G / b/B / ns/s)) ns
> +     *       = (bytes_sent * RF_scaled / (1G / b/B * 2^14 / ns/s)) ns
> +     */
> +    divisor = ((1000000000ULL / BITS_PER_BYTE) << 14) /
> +              NANOSECONDS_PER_SECOND;
> +
> +    return (uint64_t)bytes_sent * rf / divisor;

Any reason for not using muldiv64()?

> +}
> +
>   static void
>   igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>   {
> @@ -883,12 +926,19 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>       union e1000_adv_tx_desc desc;
>       const E1000ERingInfo *txi = txr->i;
>       uint32_t eic = 0;
> +    size_t bytes_sent = 0;
> +    uint64_t delay_ns;
>   
>       if (!igb_tx_enabled(core, txi)) {
>           trace_e1000e_tx_disabled();
>           return;
>       }
>   
> +    if (igb_trl_enabled(&core->trl[txi->idx]) &&
> +        timer_pending(core->trl[txi->idx].timer)) {
> +        return;
> +    }
> +
>       d = pcie_sriov_get_vf_at_index(core->owner, txi->idx % 8);
>       if (!d) {
>           d = core->owner;
> @@ -902,9 +952,16 @@ igb_start_xmit(IGBCore *core, const IGB_TxRing *txr)
>           trace_e1000e_tx_descr((void *)(intptr_t)desc.read.buffer_addr,
>                                 desc.read.cmd_type_len, desc.wb.status);
>   
> -        igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
> +        bytes_sent += igb_process_tx_desc(core, d, txr->tx, &desc, txi->idx);
>           igb_ring_advance(core, txi, 1);
>           eic |= igb_txdesc_writeback(core, base, &desc, txi);
> +
> +        delay_ns = igb_trl_calculate_delay(&core->trl[txi->idx], bytes_sent);
> +        if (delay_ns > 0) {
> +            timer_mod(core->trl[txi->idx].timer,
> +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
> +            break;
> +        }
>       }
>   
>       if (eic) {
> @@ -4321,7 +4378,6 @@ igb_autoneg_resume(IGBCore *core)
>                     qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 500);
>       }
>   }
> -

Hmm?

>   bool igb_trl_enabled(const IGBTrlQueue *q)
>   {
>       return q->trlrc & E1000_TRLRC_RS_ENA;
> @@ -4329,7 +4385,11 @@ bool igb_trl_enabled(const IGBTrlQueue *q)
>   
>   static void igb_trl_timer_cb(void *opaque)
>   {
> -    /* Stub */
> +    IGBTrlQueue *trl = opaque;
> +    IGB_TxRing txr;
> +
> +    igb_tx_ring_init(trl->core, &txr, trl->qidx);
> +    igb_start_xmit(trl->core, &txr);
>   }
>   
>   static void igb_trl_init(IGBCore *core)
> 

Modulo muldiv:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>



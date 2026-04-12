Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BB8E937EF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 17:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wByBR-00008D-Iq; Sun, 12 Apr 2026 13:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wByBJ-00005R-Jb
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 13:01:11 -0400
Received: from 12.mo534.mail-out.ovh.net ([46.105.38.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wByBC-0000Xq-Fs
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 13:01:06 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4ftxcg4Hlfz6KpF;
 Sun, 12 Apr 2026 17:00:35 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun, 12 Apr 2026 17:00:35 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.181])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4ftxcg1kyQz7tnx;
 Sun, 12 Apr 2026 17:00:35 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 BA921240390B; Sun, 12 Apr 2026 17:00:33 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G00630e3ab5e-ef40-4054-b812-99556d65a17a,
 24D929EF98A9C54707A36CFD348010E9E2578269) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <7120ca32-33df-4e33-8d4f-b2d6228d4b76@kaod.org>
Date: Sun, 12 Apr 2026 19:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/13] hw/usb/hcd-ehci: Implement 64-bit qTD descriptor
 addressing
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
 <20260311072614.1095587-9-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260311072614.1095587-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14966305990357724171
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFc8ztq7IEgYhblPzH+8kV8crUXFR6Lxe7OYden7WF7b+tnmRJn0qCqf1L1ZuSt1CKzZos51TT+/c662OSoWowJoQW+gAA6UZfIuRlGRGSgDyZuUVCGuVZE39MrxMpvWjMsjpI95w1IEiBfRJ8lukvn9ZlV+5CPB/J0XXv0vXx0Iqpn/7Ww9ZGJYvEIATUFbuzbAeXwnIDkBp2XzIVpHs7z0RzU5VkFB/6tlHczu0VMcj4AenyakueArnml/HFsaPcLcPxtqJ4xpVmC78IqOzt3QL/aOQOsfBqE4fvw7P1hcirqO/wGXJkjzhRJ2EH0HXOmnQltNT9stQtK1ajsDwM8ndQZNomI6xeTPhDolWY6ftmwmZdKDMSP9D1zcgDWMYxJ/ZmVBfYRiCZ02eAqe8K4mAsw+gDu0wNMDvknNrJaconUC8O0gAXcMvqMAdgx6GTrotetBn3C3aOQZGrK7GPzgd9KoxKco13rxwGUXnTnislBj4bMKqOWRHQxyXsOBILCHTIKipFj3rl7dmU9y3zeTpMM3HyaUMnGSN4Krvco2pNcWggeM21ALZmeJQ37n62OyUxMhbWPnv2tYEA4QCE6FFxK5f504GXddgAjUuwVdl0oKOpFm/ROIo5O9K622oZSaJ1nVHzxfazE7P2PyOGvHqX8xJyXExJl7vamBk5OyQ
DKIM-Signature: a=rsa-sha256; bh=iwpyJYkEboTVI7y9LcivGOsDiQoBdY5v0A0zCh/vX/A=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776013235; v=1;
 b=bNpFU98cnLnwrheb38FZOaj/aLX+JpcCxaPJfyuAkpaLfFXQcOecsEHQjmtyxPWiS40uvFaw
 ijlRUspwQYZgtsAvsxefX3p7UpWsfE5DXfoIBsaeViXPpPsFC1oY3BSkGrgN70nUy0LO7ZxMhSs
 7+/I2INJsegEVrGkuy+75K0P0jWLLMA5v7UJRwPqEY+1dlDitYoYDHwZlXuJE0CBz4CRaK0Yuc2
 58n0j3cSfNYcXInw59XI6WzXS8JG2yuszi4XZ2SwmqMFaW75SFbhcatL4Qf39UVRs8plfwUjvnD
 Chl1JJbMu0oR9wQVURXblHPuzdN2/oG2opL1SzOzBgQjA==
Received-SPF: pass client-ip=46.105.38.145; envelope-from=clg@kaod.org;
 helo=12.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/11/26 08:26, Jamin Lin wrote:
> EHCI supports 64-bit addressing when the 64-bit Addressing Capability
> bit in HCCPARAMS is set. In that mode, the CTRLDSSEGMENT register
> provides the upper 32 bits that are concatenated with 32-bit link
> pointer values to form 64-bit control data structure addresses
> (EHCI 1.0, section 2.3.5 and Appendix B).
> 
> qTD link pointers (current_qtd/next_qtd/altnext_qtd and qTD.next)
> are stored as 32-bit values in the data structures and must be
> expanded to full 64-bit descriptor addresses when 64-bit mode is
> enabled. Update the qTD traversal paths to use ehci_get_desc_addr()
> when following link pointers.
> 
> Appendix B also defines high dword fields for qTD buffer pointers.
> Add bufptr_hi[5] to EHCIqtd and extend qTD fetch and QH overlay
> handling to load and propagate the high buffer pointer fields.
> 
> Introduce ehci_get_buf_addr() to construct full 64-bit buffer
> addresses from bufptr[] and bufptr_hi[] fields. Use this helper
> when calculating transfer buffer addresses so that data buffers
> above 4GB are correctly handled.
> 
> When 64-bit capability is disabled, descriptor and buffer addresses
> remain 32-bit and existing behaviour is unchanged.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h |  1 +
>   hw/usb/hcd-ehci.c | 32 +++++++++++++++++++++++++-------
>   2 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index f18150c352..df16426f76 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -149,6 +149,7 @@ typedef struct EHCIqtd {
>       uint32_t bufptr[5];               /* Standard buffer pointer */
>   #define QTD_BUFPTR_MASK               0xfffff000
>   #define QTD_BUFPTR_SH                 12
> +    uint32_t bufptr_hi[5];
>   } EHCIqtd;
>   
>   /*
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 8fd3fd60c4..5964ede05b 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -158,6 +158,19 @@ static uint64_t ehci_get_desc_addr(EHCIState *s, uint32_t low)
>       return addr;
>   }
>   
> +static uint64_t ehci_get_buf_addr(EHCIState *s, uint32_t hi, uint32_t low,
> +                                  uint32_t mask)

This routine is very similar to ehci_get_desc_addr() introduced
in the  previous patch. May be implement ehci_get_desc_addr() on
top of ehci_get_buf_addr() ?

Thanks,

C.
  
> +{
> +    uint64_t addr;
> +
> +    addr = (uint64_t)(low & mask);
> +    if (s->caps_64bit_addr) {
> +        addr |= (uint64_t)hi << 32;
> +    }
> +
> +    return addr;
> +}
> +
>   static void ehci_trace_usbsts(uint32_t mask, int state)
>   {
>       /* interrupts */
> @@ -467,7 +480,8 @@ static bool ehci_verify_qtd(EHCIPacket *p, EHCIqtd *qtd)
>               (p->qtd.next != qtd->next)) ||
>           (!NLPTR_TBIT(p->qtd.altnext) && (p->qtd.altnext != qtd->altnext)) ||
>           p->qtd.token != qtd->token ||
> -        p->qtd.bufptr[0] != qtd->bufptr[0]) {
> +        p->qtd.bufptr[0] != qtd->bufptr[0] ||
> +        p->qtd.bufptr_hi[0] != qtd->bufptr_hi[0]) {
>           return false;
>       } else {
>           return true;
> @@ -1192,6 +1206,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)
>   
>       for (i = 0; i < 5; i++) {
>           q->qh.bufptr[i] = p->qtd.bufptr[i];
> +        q->qh.bufptr_hi[i] = p->qtd.bufptr_hi[i];
>       }
>   
>       if (!(q->qh.epchar & QH_EPCHAR_DTC)) {
> @@ -1225,7 +1240,8 @@ static int ehci_init_transfer(EHCIPacket *p)
>               return -1;
>           }
>   
> -        page  = p->qtd.bufptr[cpage] & QTD_BUFPTR_MASK;
> +        page = ehci_get_buf_addr(p->queue->ehci, p->qtd.bufptr_hi[cpage],
> +                                 p->qtd.bufptr[cpage], QTD_BUFPTR_MASK);
>           page += offset;
>           plen  = bytes;
>           if (plen > 4096 - offset) {
> @@ -1720,7 +1736,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
>       } else if ((q->qh.token & QTD_TOKEN_ACTIVE) &&
>                  (NLPTR_TBIT(q->qh.current_qtd) == 0) &&
>                  (q->qh.current_qtd != 0)) {
> -        q->qtdaddr = q->qh.current_qtd;
> +        q->qtdaddr = ehci_get_desc_addr(ehci, q->qh.current_qtd);
>           ehci_set_state(ehci, async, EST_FETCHQTD);
>   
>       } else {
> @@ -1804,14 +1820,14 @@ static int ehci_state_advqueue(EHCIQueue *q)
>        */
>       if (((q->qh.token & QTD_TOKEN_TBYTES_MASK) != 0) &&
>           (NLPTR_TBIT(q->qh.altnext_qtd) == 0)) {
> -        q->qtdaddr = q->qh.altnext_qtd;
> +        q->qtdaddr = ehci_get_desc_addr(q->ehci, q->qh.altnext_qtd);
>           ehci_set_state(q->ehci, q->async, EST_FETCHQTD);
>   
>       /*
>        *  next qTD is valid
>        */
>       } else if (NLPTR_TBIT(q->qh.next_qtd) == 0) {
> -        q->qtdaddr = q->qh.next_qtd;
> +        q->qtdaddr = ehci_get_desc_addr(q->ehci, q->qh.next_qtd);
>           ehci_set_state(q->ehci, q->async, EST_FETCHQTD);
>   
>       /*
> @@ -1840,7 +1856,9 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
>       if (get_dwords(q->ehci, addr +  0, &qtd.next,    1) < 0 ||
>           get_dwords(q->ehci, addr +  4, &qtd.altnext, 1) < 0 ||
>           get_dwords(q->ehci, addr + 12, qtd.bufptr,
> -                   ARRAY_SIZE(qtd.bufptr)) < 0) {
> +                   ARRAY_SIZE(qtd.bufptr)) < 0 ||
> +        get_dwords(q->ehci, addr + 32, qtd.bufptr_hi,
> +                   ARRAY_SIZE(qtd.bufptr_hi)) < 0) {
>           return 0;
>       }
>       ehci_trace_qtd(q, NLPTR_GET(q->qtdaddr), &qtd);
> @@ -1921,7 +1939,7 @@ static int ehci_fill_queue(EHCIPacket *p)
>           if (NLPTR_TBIT(qtd.next) != 0) {
>               break;
>           }
> -        qtdaddr = qtd.next;
> +        qtdaddr = ehci_get_desc_addr(q->ehci, qtd.next);
>           /*
>            * Detect circular td lists, Windows creates these, counting on the
>            * active bit going low after execution to make the queue stop.



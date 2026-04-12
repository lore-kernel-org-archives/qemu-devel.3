Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0227FE937EE
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBy84-0007To-K1; Sun, 12 Apr 2026 12:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wBy82-0007TC-BE; Sun, 12 Apr 2026 12:57:46 -0400
Received: from smtpout1.mo534.mail-out.ovh.net ([51.210.94.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wBy7y-0008Cm-SM; Sun, 12 Apr 2026 12:57:46 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4ftxYG3mSqz6K9h;
 Sun, 12 Apr 2026 16:57:38 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun, 12 Apr 2026 16:57:38 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.231])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4ftxYG1DcRz7tqc;
 Sun, 12 Apr 2026 16:57:38 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 E3C6F19239FB; Sun, 12 Apr 2026 16:57:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0069d339da8-e60f-4932-9442-a883eea78db8,
 24D929EF98A9C54707A36CFD348010E9E2578269) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <75516430-0854-49d3-b6c0-1e9096d39c72@kaod.org>
Date: Sun, 12 Apr 2026 18:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/13] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
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
 <20260311072614.1095587-8-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260311072614.1095587-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14916484919229590539
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF27VQKDFV6uenxTZoyKBZrgBM+b90S8zIhkKm9Nti7Qay1qII7jxL7TDX1QVvuyewboZF2H0JcWcWrmEPX4RSH1ECYvOcdtGKH9ib0Dyunv4BR6PcCJp29/IlM1N/Hy4T42C6gny1SJRKDlC3wpoGofehKuPi5jxITRrROrmsCo9qsv2+HTmoDm98z8HZHY83B2JVqVG9S5imdU4uHWrBXcNoz7y0IexrDV4Z/kBjL0HARn2eu2n20gTsrAUjgm2PArMZGDEgAYRl3u8d8ACDWH0xtyXx4dIiH66+BUJHjWX9UoX8hUrY4DKYK2S6p2wgvs7uPaK9pY2Eb6acG1IG+ceBQs28VQXeAD0jLDJiLWzBOHgKaHN8ix2p6tLtaOKR3K/84Sa08v+zEutkPNkYHPZFBLVMq8pcp4a/GXXgreaHSwisMM5Mo/HT5iDUZRG8nQ9j/q1Xm30kiLT/Vt4KsiTr4WlXAtxBJW80DH7efbk9xOJ6IdUljOjfTjJDvhGP3fnst0mVcGvE+wJegbCehKl1JkHy8lvKhTvxhkvRAYM0lXZ/34DXR/GtVjI3VS2E6BNsKQwBYbGBnQQi2wx1dzBo4oDwTWWBgfRPcR2TLBrpMK1dxi3IiSKRbe9bOTFzCnRQ9DmeYg5Y359eQcrwCm2eMioCj9ciygtvA1OgZCA
DKIM-Signature: a=rsa-sha256; bh=zEcv4M1DQoWpl/n9M8Q/ngunYgYE3bNSxTI2CvXyqZw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776013058; v=1;
 b=eFd+i4k+0g52HNYxRRuObgpgfTB0YmG38jZ8qTsU5EO0Wp02ZM7oNcKIaZqGMJFjgfzFcsWs
 ZXecjZO/LYtlmCplofuBXVx13avEnzOal0TkM9Xzrlue42JPNSwHLvIwSLm2L9cKbh0EaM64Ly3
 3LNrycg23mgHrysJzq6w88iopcp1AmGoWiG2g1m50DytmIohkmRpf82dM1NnwcP3P47gP19KVA7
 m1dthskyQm8PgcyNueTP3JCBT3yWorVTFKMlo8giZFKvqD2RCLsBXB+PNUXyIOwrTIilNHUGG83
 N/61Ovi9dTh34GFQOSusYsrJRCNsJW6YYHczQxDIwYj0Q==
Received-SPF: pass client-ip=51.210.94.140; envelope-from=clg@kaod.org;
 helo=smtpout1.mo534.mail-out.ovh.net
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
> EHCI supports 64-bit control data structure addressing when the
> 64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,
> the CTRLDSSEGMENT register supplies the upper 32 bits which are
> concatenated with 32-bit link pointer fields to form full 64-bit
> descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).
> 
> The current implementation assumes 32-bit QH descriptor addresses
> and directly uses link pointer values without applying the
> CTRLDSSEGMENT upper dword.
> 
> Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit
> descriptor addresses when 64-bit capability is enabled. Update QH
> traversal paths (async list walk, horizontal QH link, and periodic
> schedule entry handling) to use the translated 64-bit addresses.
> 
> Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer
> fields as defined in Appendix B.
> 
> When 64-bit capability is disabled, descriptor addresses remain
> 32-bit and existing behaviour is unchanged.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h |  1 +
>   hw/usb/hcd-ehci.c | 45 ++++++++++++++++++++++++++++++++-------------
>   2 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 7dc6d151cc..f18150c352 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -204,6 +204,7 @@ typedef struct EHCIqh {
>   #define BUFPTR_FRAMETAG_MASK          0x0000001f
>   #define BUFPTR_SBYTES_MASK            0x00000fe0
>   #define BUFPTR_SBYTES_SH              5
> +    uint32_t bufptr_hi[5];
>   } EHCIqh;
>   
>   /*
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index d7a0917caf..8fd3fd60c4 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -146,6 +146,18 @@ static const char *addr2str(hwaddr addr)
>       return nr2str(ehci_mmio_names, ARRAY_SIZE(ehci_mmio_names), addr);
>   }
>   
> +static uint64_t ehci_get_desc_addr(EHCIState *s, uint32_t low)
> +{
> +    uint64_t addr;
> +
> +    addr = (uint64_t)low;
> +    if (s->caps_64bit_addr) {
> +        addr |= (uint64_t)s->ctrldssegment << 32;
> +    }
> +
> +    return addr;
> +}
> +
>   static void ehci_trace_usbsts(uint32_t mask, int state)
>   {
>       /* interrupts */
> @@ -438,8 +450,9 @@ static bool ehci_verify_qh(EHCIQueue *q, EHCIqh *qh)
>           (endp    != get_field(q->qh.epchar, QH_EPCHAR_EP)) ||
>           (qh->current_qtd != q->qh.current_qtd) ||
>           (q->async && qh->next_qtd != q->qh.next_qtd) ||
> +        /* 1 altnext_qtd + 1 token + 5 bufptr + 5 bufptr_hi */

That's the reason for the '12' magic value. A definition is preferable.

Thanks,

C.

>           (memcmp(&qh->altnext_qtd, &q->qh.altnext_qtd,
> -                                 7 * sizeof(uint32_t)) != 0) ||
> +                12 * sizeof(uint32_t)) != 0) ||
>           (q->dev != NULL && q->dev->addr != devaddr)) {
>           return false;
>       } else {
> @@ -1534,7 +1547,9 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
>       EHCIqh qh;
>       int i = 0;
>       int again = 0;
> -    uint64_t entry = ehci->asynclistaddr;
> +    uint64_t entry = 0;
> +
> +    entry = ehci_get_desc_addr(ehci, ehci->asynclistaddr);
>   
>       /* set reclamation flag at start event (4.8.6) */
>       if (async) {
> @@ -1562,8 +1577,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
>               goto out;
>           }
>   
> -        entry = qh.next;
> -        if (entry == ehci->asynclistaddr) {
> +        entry = ehci_get_desc_addr(ehci, qh.next);
> +        if (entry == ehci_get_desc_addr(ehci, ehci->asynclistaddr)) {
>               break;
>           }
>       }
> @@ -1688,7 +1703,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
>       }
>   
>   #if EHCI_DEBUG
> -    if (q->qhaddr != q->qh.next) {
> +    if (q->qhaddr != ehci_get_desc_addr(ehci, q->qh.next)) {
>           DPRINTF("FETCHQH:  QH 0x%" PRIx64
>                   " (h %x halt %x active %x) next 0x%08x\n",
>                  q->qhaddr,
> @@ -1879,10 +1894,12 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
>   
>   static int ehci_state_horizqh(EHCIQueue *q)
>   {
> +    uint64_t addr;
>       int again = 0;
>   
> -    if (ehci_get_fetch_addr(q->ehci, q->async) != q->qh.next) {
> -        ehci_set_fetch_addr(q->ehci, q->async, q->qh.next);
> +    addr = ehci_get_desc_addr(q->ehci, q->qh.next);
> +    if (ehci_get_fetch_addr(q->ehci, q->async) != addr) {
> +        ehci_set_fetch_addr(q->ehci, q->async, addr);
>           ehci_set_state(q->ehci, q->async, EST_FETCHENTRY);
>           again = 1;
>       } else {
> @@ -2210,6 +2227,8 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
>       uint32_t entry;
>       uint32_t list;
>       const int async = 0;
> +    uint64_t entry64;
> +    uint64_t list64;
>   
>       /* 4.6 */
>   
> @@ -2234,14 +2253,14 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
>               break;
>           }
>           list |= ((ehci->frindex & 0x1ff8) >> 1);
> -
> -        if (get_dwords(ehci, list, &entry, 1) < 0) {
> +        list64 = ehci_get_desc_addr(ehci, list);
> +        if (get_dwords(ehci, list64, &entry, 1) < 0) {
>               break;
>           }
> -
> -        DPRINTF("PERIODIC state adv fr=%d.  [%08X] -> %08X\n",
> -                ehci->frindex / 8, list, entry);
> -        ehci_set_fetch_addr(ehci, async, entry);
> +        entry64 = ehci_get_desc_addr(ehci, entry);
> +        DPRINTF("PERIODIC state adv fr=%d.  %" PRIx64 " -> %" PRIx64 "\n",
> +                ehci->frindex / 8, list64, entry64);
> +        ehci_set_fetch_addr(ehci, async, entry64);
>           ehci_set_state(ehci, async, EST_FETCHENTRY);
>           ehci_advance_state(ehci, async);
>           ehci_queues_rip_unused(ehci, async);



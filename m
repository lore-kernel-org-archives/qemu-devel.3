Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC00E937EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxtD-0002K9-MS; Sun, 12 Apr 2026 12:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wBxtC-0002Jl-RS
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:42:26 -0400
Received: from 12.mo533.mail-out.ovh.net ([178.33.248.79])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wBxtA-0004gr-3V
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:42:26 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4ftxCc09Vwz61R4;
 Sun, 12 Apr 2026 16:42:20 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun, 12 Apr 2026 16:42:19 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.63])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4ftxCb5kymz5vQL;
 Sun, 12 Apr 2026 16:42:19 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 707FF2403A3F; Sun, 12 Apr 2026 16:42:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0032c17455c-bca5-4445-b163-0ab800cfd0ff,
 24D929EF98A9C54707A36CFD348010E9E2578269) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <fda809cc-3585-47ef-af94-710069ce6b32@kaod.org>
Date: Sun, 12 Apr 2026 18:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/13] hw/usb/hcd-ehci.c: Fix coding style issues
 reported by checkpatch
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
 <20260311072614.1095587-3-jamin_lin@aspeedtech.com>
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
In-Reply-To: <20260311072614.1095587-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14657809414402911243
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFbi56yaF/qLJLKJaoVTAyuHWmATxZkGr4VVugReL+7r24k2CthVruEY4SX9sXWN/ml7A+iTiEK3Za1QXdw2N/KkQOz+ynxLbScAddhQYbkduAZfDxE8LZQ6Oo0TzEJKlnuo2pXLomAmsR1vTcKIFRDDhYQ7y0JxM+JbIbBzDWOLo9cv8k7CwXBMVuvLZMH6JZT7RuBzAanLEma/70uQZI1BOyZ6WLDvtkHJQIws7VY/Fb87cmTswhSpUp4UFl9Of1zo8RjhAUXCUBs/zenFmZnxFkLx8w7E5zaQ78x9XG777H21oHMGHkzNAMbB8OUCbtKs6NPkdUaY0tBDIHpHAw1qqqvgc0HBycuWUi8KejhqKACOdgYpwOYVm2IM7vB40Tv/6L0VyJ/Xk4IlWkLDNhbGldqKJ7PZ0BPGhxDW/9i5j3olqLxQ+Q3GIVA0GTJ8MUoVjtDALhUyVJ1GRWkp3/H7ODk0DeDBRL7f4dGaHsaT1g9J7jAed15Xfoprhng0K+nmgDKhZCqZ+9jktiSUB7bQW1Lpt0cuEMXnmosOgIdlM0yGHYIiGe9cEDtXPIYouI+MBshg/aQ0iZORIanrkYYOx+ACvaylLlwy7pafpeNOKM0tHL5S4W9g9cte9FN+QDUXH97rqtzEm4dCLd6VNEpLvx4oadebc2X08iFWiMYyQ
DKIM-Signature: a=rsa-sha256; bh=HXbQmkjsvCnZleeGagq2sW+VdwtQCwRvpDOBsuS0haA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776012140; v=1;
 b=EK9DLu4NTfLqV1EH5Y6BrFiDVVQEDZa2Xe6hePLxnt0avarBNN50skyD7Ff+KG6Z0alKeJvI
 8E+IH72RlatXS4LiDY36L8gnzjvjJgM6IM8Qml/uSxu3o1TJFy8ahC0fLoH5xP0O8MS6SlQ1Xeg
 KW0tMi1mwQVZgUVlA0tNFnl424EXyvUxxO5wKfCFZYVtoosoxVKDGQWzN7LMLhro88Hn8JP4DiC
 Z8cKqbdy8aYaMH7lkRhRcC/Er6Nr9Fz9Dz+gnzfMAfi4xvZM1JACzWhlVQy30p9OG2LtGFA5mc2
 tFNWAKWlLVkZ6mLFZsB6Jz8iVyiUs3MwSIDQwFoo+TMYw==
Received-SPF: pass client-ip=178.33.248.79; envelope-from=clg@kaod.org;
 helo=12.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 3/11/26 08:26, Jamin Lin wrote:
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.c | 129 +++++++++++++++++++++++++---------------------
>   1 file changed, 71 insertions(+), 58 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 57f930b099..e2ff0f5874 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -41,21 +41,23 @@
>   #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
>   #define UFRAME_TIMER_NS  (FRAME_TIMER_NS / 8)
>   
> -#define NB_MAXINTRATE    8        // Max rate at which controller issues ints
> -#define BUFF_SIZE        5*4096   // Max bytes to transfer per transaction
> -#define MAX_QH           100      // Max allowable queue heads in a chain
> +#define NB_MAXINTRATE    8      /* Max rate at which controller issues ints */
> +#define BUFF_SIZE        (5 * 4096) /* Max bytes to transfer per transaction */
> +#define MAX_QH           100      /* Max allowable queue heads in a chain */
>   #define MIN_UFR_PER_TICK 24       /* Min frames to process when catching up */
>   #define PERIODIC_ACTIVE  512      /* Micro-frames */
>   
> -/*  Internal periodic / asynchronous schedule state machine states
> +/*
> + * Internal periodic / asynchronous schedule state machine states
>    */
>   typedef enum {
>       EST_INACTIVE = 1000,
>       EST_ACTIVE,
>       EST_EXECUTING,
>       EST_SLEEPING,
> -    /*  The following states are internal to the state machine function
> -    */
> +    /*
> +     *The following states are internal to the state machine function
> +     */
>       EST_WAITLISTHEAD,
>       EST_FETCHENTRY,
>       EST_FETCHQH,
> @@ -71,13 +73,13 @@ typedef enum {
>   /* macros for accessing fields within next link pointer entry */
>   #define NLPTR_GET(x)             ((x) & 0xffffffe0)
>   #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)
> -#define NLPTR_TBIT(x)            ((x) & 1)  // 1=invalid, 0=valid
> +#define NLPTR_TBIT(x)            ((x) & 1)  /* 1=invalid, 0=valid */
>   
>   /* link pointer types */
> -#define NLPTR_TYPE_ITD           0     // isoc xfer descriptor
> -#define NLPTR_TYPE_QH            1     // queue head
> -#define NLPTR_TYPE_STITD         2     // split xaction, isoc xfer descriptor
> -#define NLPTR_TYPE_FSTN          3     // frame span traversal node
> +#define NLPTR_TYPE_ITD           0     /* isoc xfer descriptor */
> +#define NLPTR_TYPE_QH            1     /* queue head */
> +#define NLPTR_TYPE_STITD         2     /* split xaction, isoc xfer descriptor */
> +#define NLPTR_TYPE_FSTN          3     /* frame span traversal node */
>   
>   #define SET_LAST_RUN_CLOCK(s) \
>       (s)->last_run_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> @@ -88,10 +90,10 @@ typedef enum {
>   
>   #define set_field(data, newval, field) do { \
>       uint32_t val = *data; \
> -    val &= ~ field##_MASK; \
> +    val &= ~field##_MASK; \
>       val |= ((newval) << field##_SH) & field##_MASK; \
>       *data = val; \
> -    } while(0)
> +    } while (0)
>   
>   static const char *ehci_state_names[] = {
>       [EST_INACTIVE]     = "INACTIVE",
> @@ -472,8 +474,10 @@ static bool ehci_verify_pid(EHCIQueue *q, EHCIqtd *qtd)
>       }
>   }
>   
> -/* Finish executing and writeback a packet outside of the regular
> -   fetchqh -> fetchqtd -> execute -> writeback cycle */
> +/*
> + * Finish executing and writeback a packet outside of the regular
> + * fetchqh -> fetchqtd -> execute -> writeback cycle
> + */
>   static void ehci_writeback_async_complete_packet(EHCIPacket *p)
>   {
>       EHCIQueue *q = p->queue;
> @@ -733,7 +737,7 @@ static void ehci_detach(USBPort *port)
>       ehci_queues_rip_device(s, port->dev, 0);
>       ehci_queues_rip_device(s, port->dev, 1);
>   
> -    *portsc &= ~(PORTSC_CONNECT|PORTSC_PED|PORTSC_SUSPEND);
> +    *portsc &= ~(PORTSC_CONNECT | PORTSC_PED | PORTSC_SUSPEND);
>       *portsc |= PORTSC_CSC;
>   
>       ehci_raise_irq(s, USBSTS_PCD);
> @@ -858,7 +862,7 @@ void ehci_reset(void *opaque)
>        * Do the detach before touching portsc, so that it correctly gets send to
>        * us or to our companion based on PORTSC_POWNER before the reset.
>        */
> -    for(i = 0; i < EHCI_PORTS; i++) {
> +    for (i = 0; i < EHCI_PORTS; i++) {
>           devs[i] = s->ports[i].dev;
>           if (devs[i] && devs[i]->attached) {
>               usb_detach(&s->ports[i]);
> @@ -877,7 +881,7 @@ void ehci_reset(void *opaque)
>       s->astate = EST_INACTIVE;
>       s->pstate = EST_INACTIVE;
>   
> -    for(i = 0; i < EHCI_PORTS; i++) {
> +    for (i = 0; i < EHCI_PORTS; i++) {
>           if (s->companion_ports[i]) {
>               s->portsc[i] = PORTSC_POWNER | PORTSC_PPOWER;
>           } else {
> @@ -942,8 +946,9 @@ static void handle_port_owner_write(EHCIState *s, int port, uint32_t owner)
>       uint32_t *portsc = &s->portsc[port];
>       uint32_t orig;
>   
> -    if (s->companion_ports[port] == NULL)
> +    if (s->companion_ports[port] == NULL) {
>           return;
> +    }
>   
>       owner = owner & PORTSC_POWNER;
>       orig  = *portsc & PORTSC_POWNER;
> @@ -988,7 +993,7 @@ static void ehci_port_write(void *ptr, hwaddr addr,
>           trace_usb_ehci_port_reset(port, 1);
>       }
>   
> -    if (!(val & PORTSC_PRESET) &&(*portsc & PORTSC_PRESET)) {
> +    if (!(val & PORTSC_PRESET) && (*portsc & PORTSC_PRESET)) {
>           trace_usb_ehci_port_reset(port, 0);
>           if (dev && dev->attached) {
>               usb_port_reset(&s->ports[port]);
> @@ -1065,8 +1070,10 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
>           break;
>   
>       case USBSTS:
> -        val &= USBSTS_RO_MASK;              // bits 6 through 31 are RO
> -        ehci_clear_usbsts(s, val);          // bits 0 through 5 are R/WC
> +        /* bits 6 through 31 are RO */
> +        val &= USBSTS_RO_MASK;
> +        /* bits 0 through 5 are R/WC */
> +        ehci_clear_usbsts(s, val);
>           val = s->usbsts;
>           ehci_update_irq(s);
>           break;
> @@ -1131,8 +1138,7 @@ static void ehci_flush_qh(EHCIQueue *q)
>       put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);
>   }
>   
> -// 4.10.2
> -
> +/* 4.10.2 */
>   static int ehci_qh_do_overlay(EHCIQueue *q)
>   {
>       EHCIPacket *p = QTAILQ_FIRST(&q->packets);
> @@ -1145,8 +1151,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)
>       assert(p != NULL);
>       assert(p->qtdaddr == q->qtdaddr);
>   
> -    // remember values in fields to preserve in qh after overlay
> -
> +    /*  remember values in fields to preserve in qh after overlay */
>       dtoggle = q->qh.token & QTD_TOKEN_DTOGGLE;
>       ping    = q->qh.token & QTD_TOKEN_PING;
>   
> @@ -1170,7 +1175,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)
>       }
>   
>       if (!(q->qh.epchar & QH_EPCHAR_DTC)) {
> -        // preserve QH DT bit
> +        /* preserve QH DT bit */
>           q->qh.token &= ~QTD_TOKEN_DTOGGLE;
>           q->qh.token |= dtoggle;
>       }
> @@ -1397,9 +1402,7 @@ static int ehci_execute(EHCIPacket *p, const char *action)
>       return 1;
>   }
>   
> -/*  4.7.2
> - */
> -
> +/* 4.7.2 */
>   static int ehci_process_itd(EHCIState *ehci,
>                               EHCIitd *itd,
>                               uint32_t addr)
> @@ -1411,13 +1414,13 @@ static int ehci_process_itd(EHCIState *ehci,
>   
>       ehci->periodic_sched_active = PERIODIC_ACTIVE;
>   
> -    dir =(itd->bufptr[1] & ITD_BUFPTR_DIRECTION);
> +    dir = (itd->bufptr[1] & ITD_BUFPTR_DIRECTION);
>       devaddr = get_field(itd->bufptr[0], ITD_BUFPTR_DEVADDR);
>       endp = get_field(itd->bufptr[0], ITD_BUFPTR_EP);
>       max = get_field(itd->bufptr[1], ITD_BUFPTR_MAXPKT);
>       mult = get_field(itd->bufptr[2], ITD_BUFPTR_MULT);
>   
> -    for(i = 0; i < 8; i++) {
> +    for (i = 0; i < 8; i++) {
>           if (itd->transact[i] & ITD_XACT_ACTIVE) {
>               pg   = get_field(itd->transact[i], ITD_XACT_PGSEL);
>               off  = itd->transact[i] & ITD_XACT_OFFSET_MASK;
> @@ -1513,8 +1516,9 @@ static int ehci_process_itd(EHCIState *ehci,
>   }
>   
>   
> -/*  This state is the entry point for asynchronous schedule
> - *  processing.  Entry here constitutes a EHCI start event state (4.8.5)
> +/*
> + * This state is the entry point for asynchronous schedule
> + * processing.  Entry here constitutes a EHCI start event state (4.8.5)
>    */
>   static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
>   {
> @@ -1531,7 +1535,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
>       ehci_queues_rip_unused(ehci, async);
>   
>       /*  Find the head of the list (4.9.1.1) */
> -    for(i = 0; i < MAX_QH; i++) {
> +    for (i = 0; i < MAX_QH; i++) {
>           if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,
>                          sizeof(EHCIqh) >> 2) < 0) {
>               return 0;
> @@ -1564,8 +1568,9 @@ out:
>   }
>   
>   
> -/*  This state is the entry point for periodic schedule processing as
> - *  well as being a continuation state for async processing.
> +/*
> + * This state is the entry point for periodic schedule processing as
> + * well as being a continuation state for async processing.
>    */
>   static int ehci_state_fetchentry(EHCIState *ehci, int async)
>   {
> @@ -1674,7 +1679,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
>   
>   #if EHCI_DEBUG
>       if (q->qhaddr != q->qh.next) {
> -    DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\n",
> +        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\n",


Could you please replace all DPRINTF by trace events ?


>                  q->qhaddr,
>                  q->qh.epchar & QH_EPCHAR_H,
>                  q->qh.token & QTD_TOKEN_HALT,
> @@ -1757,7 +1762,8 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int async)
>   static int ehci_state_advqueue(EHCIQueue *q)
>   {
>   #if 0

I would just remove all the dead code.

Thanks,

C.

> -    /* TO-DO: 4.10.2 - paragraph 2
> +    /*
> +     * TO-DO: 4.10.2 - paragraph 2
>        * if I-bit is set to 1 and QH is not active
>        * go to horizontal QH
>        */
> @@ -1935,8 +1941,10 @@ static int ehci_state_execute(EHCIQueue *q)
>           return -1;
>       }
>   
> -    // TODO verify enough time remains in the uframe as in 4.4.1.1
> -    // TODO write back ptr to async list when done or out of time
> +    /*
> +     * TODO verify enough time remains in the uframe as in 4.4.1.1
> +     * TODO write back ptr to async list when done or out of time
> +     */
>   
>       /* 4.10.3, bottom of page 82, go horizontal on transaction counter == 0 */
>       if (!q->async && q->transact_ctr == 0) {
> @@ -2047,7 +2055,7 @@ static void ehci_advance_state(EHCIState *ehci, int async)
>       int again;
>   
>       do {
> -        switch(ehci_get_state(ehci, async)) {
> +        switch (ehci_get_state(ehci, async)) {
>           case EST_WAITLISTHEAD:
>               again = ehci_state_waitlisthead(ehci, async);
>               break;
> @@ -2126,21 +2134,20 @@ static void ehci_advance_state(EHCIState *ehci, int async)
>               ehci_reset(ehci);
>               again = 0;
>           }
> -    }
> -    while (again);
> +    } while (again);
>   }
>   
>   static void ehci_advance_async_state(EHCIState *ehci)
>   {
>       const int async = 1;
>   
> -    switch(ehci_get_state(ehci, async)) {
> +    switch (ehci_get_state(ehci, async)) {
>       case EST_INACTIVE:
>           if (!ehci_async_enabled(ehci)) {
>               break;
>           }
>           ehci_set_state(ehci, async, EST_ACTIVE);
> -        // No break, fall through to ACTIVE
> +        /* No break, fall through to ACTIVE */
>   
>       case EST_ACTIVE:
>           if (!ehci_async_enabled(ehci)) {
> @@ -2164,7 +2171,8 @@ static void ehci_advance_async_state(EHCIState *ehci)
>           ehci_set_state(ehci, async, EST_WAITLISTHEAD);
>           ehci_advance_state(ehci, async);
>   
> -        /* If the doorbell is set, the guest wants to make a change to the
> +        /*
> +         * If the doorbell is set, the guest wants to make a change to the
>            * schedule. The host controller needs to release cached data.
>            * (section 4.8.2)
>            */
> @@ -2191,13 +2199,13 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
>       uint32_t list;
>       const int async = 0;
>   
> -    // 4.6
> +    /* 4.6 */
>   
> -    switch(ehci_get_state(ehci, async)) {
> +    switch (ehci_get_state(ehci, async)) {
>       case EST_INACTIVE:
>           if (!(ehci->frindex & 7) && ehci_periodic_enabled(ehci)) {
>               ehci_set_state(ehci, async, EST_ACTIVE);
> -            // No break, fall through to ACTIVE
> +            /* No break, fall through to ACTIVE */
>           } else
>               break;
>   
> @@ -2221,7 +2229,7 @@ static void ehci_advance_periodic_state(EHCIState *ehci)
>   
>           DPRINTF("PERIODIC state adv fr=%d.  [%08X] -> %08X\n",
>                   ehci->frindex / 8, list, entry);
> -        ehci_set_fetch_addr(ehci, async,entry);
> +        ehci_set_fetch_addr(ehci, async, entry);
>           ehci_set_state(ehci, async, EST_FETCHENTRY);
>           ehci_advance_state(ehci, async);
>           ehci_queues_rip_unused(ehci, async);
> @@ -2246,7 +2254,8 @@ static void ehci_update_frindex(EHCIState *ehci, int uframes)
>           ehci_raise_irq(ehci, USBSTS_FLR);
>       }
>   
> -    /* How many times will frindex roll over 0x4000 with this frame count?
> +    /*
> +     * How many times will frindex roll over 0x4000 with this frame count?
>        * usbsts_frindex is decremented by 0x4000 on rollover until it reaches 0
>        */
>       int rollovers = (ehci->frindex + uframes) / 0x4000;
> @@ -2326,8 +2335,9 @@ static void ehci_work_bh(void *opaque)
>           ehci->async_stepdown++;
>       }
>   
> -    /*  Async is not inside loop since it executes everything it can once
> -     *  called
> +    /*
> +     * Async is not inside loop since it executes everything it can once
> +     * called
>        */
>       if (ehci_async_enabled(ehci) || ehci->astate != EST_INACTIVE) {
>           need_timer++;
> @@ -2345,15 +2355,18 @@ static void ehci_work_bh(void *opaque)
>       }
>   
>       if (need_timer) {
> -        /* If we've raised int, we speed up the timer, so that we quickly
> -         * notice any new packets queued up in response */
> +        /*
> +         * If we've raised int, we speed up the timer, so that we quickly
> +         * notice any new packets queued up in response
> +         */
>           if (ehci->int_req_by_async && (ehci->usbsts & USBSTS_INT)) {
>               expire_time = t_now +
>                   NANOSECONDS_PER_SECOND / (FRAME_TIMER_FREQ * 4);
>               ehci->int_req_by_async = false;
>           } else {
> -            expire_time = t_now + (NANOSECONDS_PER_SECOND
> -                               * (ehci->async_stepdown+1) / FRAME_TIMER_FREQ);
> +            expire_time = t_now
> +                + (NANOSECONDS_PER_SECOND * (ehci->async_stepdown + 1) /
> +                   FRAME_TIMER_FREQ);
>           }
>           timer_mod(ehci->frame_timer, expire_time);
>       }



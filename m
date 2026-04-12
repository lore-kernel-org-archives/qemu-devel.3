Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E0AE937EF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 16:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBxzL-0003ux-09; Sun, 12 Apr 2026 12:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wBxzI-0003ug-N0
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:48:44 -0400
Received: from smtpout2.mo534.mail-out.ovh.net ([51.210.94.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wBxzE-00066p-Kt
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 12:48:44 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4ftxLp6Lt5z6KpP;
 Sun, 12 Apr 2026 16:48:34 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun, 12 Apr 2026 16:48:34 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.183])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4ftxLp0zWyz5vgM;
 Sun, 12 Apr 2026 16:48:34 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 807EF203999; 
 Sun, 12 Apr 2026 16:48:32 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0048e1ad7b8-2270-425b-96ac-e1d92cd69912,
 24D929EF98A9C54707A36CFD348010E9E2578269) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f93ba836-9250-4a32-a93a-5ac5587b3807@kaod.org>
Date: Sun, 12 Apr 2026 18:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/13] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
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
 <20260311072614.1095587-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260311072614.1095587-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14763362528694610955
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFf4SqluAtYZu0IVtGI0EIE1usmOSzhRvSvbub7UxnNktnfdTVT6L+Mkq9mpRhWdqpZl+haZ6NKoGuikh6vcQxpxMSP8wkorNJSm2x1DqtGth0IodjVlU7z18d2FCMffKbU+oKtETfPMzcxiWSPQJcp9EYPo6tCc1vdaUEJpjYXnZ+LknHx0lZ725EBpxaNBmhYiXscujJvKxPx1yoU9e7fnmPl//ugSWTER8397cdHluNlNEB9vXOgoVdaNDTvucd1pRmPCQfkM0OXmh9WcKznOy3C5rnexbGq9GgkjT7d8czC08/rh7BwAVt7zw1uA3etj8O/tyDdYmScqOttFwdiSWWxYu6b4Dq3NXESTrlljs4ixPgVa3auGQUdOdKTsLlGUlU/aasNTseljZZpExX1v/gyUkfcQiC3pjjeM6jA4vyjbfnf/x5HWwTXhc5trx+cUPZf72QR6RLJC/bGst06AfiKX5htLeXv/Y0iR1+dqbqULC9KKJNRqdUBiqgHHxN9F6ZJxYYVN1oDsLH9ZNZqlnLmg3c5m3wIXsM26Vqy/R2Cz4jEqnlNext6oGcbYINTIhocknLc4c+ljewC9ci5dSi3bMjDTGebED0ZJtdQ/6yl4mblP6Ru5uJp6lE7Hb/8K/qwx7mzfhXRQlSwLA7i8X+725ACEJD5epAXhAAuNQ
DKIM-Signature: a=rsa-sha256; bh=9NugQO8C22PemF/eOVgFwco7k/6oni8fXwziaqHUz7M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776012516; v=1;
 b=cBU+HX6eZhQ7lbJB+ldsTA4gkr+MRyMZ7WsHdHhMisCFL6CpiYnfZsBKn+yI1ni7l9r1bDjI
 ORi7cX0kcCSsXOXKggTY5Ee65tmsux4AgHIi1yGnslLEAD8BwCDtzBpDeMJp/v1HhNPoNtz0Pe/
 LgSPEVDGM7YMHmsz1NrWV+ODACgEFrNHM2R9WrneokNEcTlDt9NfCVz2S21lKzyaLoexbHEYGhl
 OVPuDu2ZyXTQI5LkW+5RifSd9A5HP0RHBvTq+sdepVqci207TZmCN/FRpW3rw1aftbx9C9YnqGg
 jTjjxSEIv3rCdEynPUVnTDzCI2mhFPntI8gFL0HzkDVPg==
Received-SPF: pass client-ip=51.210.94.141; envelope-from=clg@kaod.org;
 helo=smtpout2.mo534.mail-out.ovh.net
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
> Change internal EHCI descriptor addresses from uint32_t to uint64_t.
> 
> The following fields are updated:
> - EHCIPacket::qtdaddr
> - EHCIQueue::{qhaddr, qtdaddr}
> - EHCIState::{a_fetch_addr, p_fetch_addr}
> 
> Update get_dwords() and put_dwords() to take 64-bit addresses and
> propagate the type change through the descriptor traversal paths.
> 
> Adjust NLPTR_GET() to operate on 64-bit values:
> 
>      #define NLPTR_GET(x) ((x) & ~(uint64_t)0x1f)

how about :

   #define NLPTR_GET(x)             ((x) & ~0x1fULL)


> 
> so that link pointer masking works correctly when descriptor
> addresses exceed 32-bit space. The previous mask (0xffffffe0)
> implicitly truncated addresses to 32 bits.
> 
> This patch does not change the on-wire descriptor layout yet.
> It only removes the internal 32-bit address limit and prepares
> for later patches that will add full 64-bit QH/qTD/iTD/siTD support.
> 
> Since the type of fetch_addr changes from 32-bit to 64-bit,
> bump the VMState version.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h | 10 +++----
>   hw/usb/hcd-ehci.c | 67 +++++++++++++++++++++++++----------------------
>   2 files changed, 41 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index ed44935302..df87f8145f 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -226,7 +226,7 @@ struct EHCIPacket {
>       QTAILQ_ENTRY(EHCIPacket) next;
>   
>       EHCIqtd qtd;           /* copy of current QTD (being worked on) */
> -    uint32_t qtdaddr;      /* address QTD read from                 */
> +    uint64_t qtdaddr;      /* address QTD read from                 */
>   
>       USBPacket packet;
>       QEMUSGList sgl;
> @@ -247,8 +247,8 @@ struct EHCIQueue {
>        * when guest removes an entry (doorbell, handshake sequence)
>        */
>       EHCIqh qh;             /* copy of current QH (being worked on) */
> -    uint32_t qhaddr;       /* address QH read from                 */
> -    uint32_t qtdaddr;      /* address QTD read from                */
> +    uint64_t qhaddr;       /* address QH read from                 */
> +    uint64_t qtdaddr;      /* address QTD read from                */
>       int last_pid;          /* pid of last packet executed          */
>       USBDevice *dev;
>       QTAILQ_HEAD(, EHCIPacket) packets;
> @@ -312,8 +312,8 @@ struct EHCIState {
>       EHCIQueueHead pqueues;
>   
>       /* which address to look at next */
> -    uint32_t a_fetch_addr;
> -    uint32_t p_fetch_addr;
> +    uint64_t a_fetch_addr;
> +    uint64_t p_fetch_addr;
>   
>       USBPacket ipacket;
>       QEMUSGList isgl;
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index e2ff0f5874..87c3991313 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -71,7 +71,7 @@ typedef enum {
>   } EHCI_STATES;
>   
>   /* macros for accessing fields within next link pointer entry */
> -#define NLPTR_GET(x)             ((x) & 0xffffffe0)
> +#define NLPTR_GET(x)             ((x) & ~(uint64_t)0x1f)
>   #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)
>   #define NLPTR_TBIT(x)            ((x) & 1)  /* 1=invalid, 0=valid */
>   
> @@ -286,7 +286,7 @@ static int ehci_get_state(EHCIState *s, int async)
>       return async ? s->astate : s->pstate;
>   }
>   
> -static void ehci_set_fetch_addr(EHCIState *s, int async, uint32_t addr)
> +static void ehci_set_fetch_addr(EHCIState *s, int async, uint64_t addr)
>   {
>       if (async) {
>           s->a_fetch_addr = addr;
> @@ -295,7 +295,7 @@ static void ehci_set_fetch_addr(EHCIState *s, int async, uint32_t addr)
>       }
>   }
>   
> -static int ehci_get_fetch_addr(EHCIState *s, int async)
> +static uint64_t ehci_get_fetch_addr(EHCIState *s, int async)
>   {
>       return async ? s->a_fetch_addr : s->p_fetch_addr;
>   }
> @@ -372,7 +372,7 @@ static inline bool ehci_periodic_enabled(EHCIState *s)
>   }
>   
>   /* Get an array of dwords from main memory */
> -static inline int get_dwords(EHCIState *ehci, uint32_t addr,
> +static inline int get_dwords(EHCIState *ehci, uint64_t addr,
>                                uint32_t *buf, int num)
>   {
>       int i;
> @@ -394,7 +394,7 @@ static inline int get_dwords(EHCIState *ehci, uint32_t addr,
>   }
>   
>   /* Put an array of dwords in to main memory */
> -static inline int put_dwords(EHCIState *ehci, uint32_t addr,
> +static inline int put_dwords(EHCIState *ehci, uint64_t addr,
>                                uint32_t *buf, int num)
>   {
>       int i;
> @@ -548,7 +548,7 @@ static void ehci_free_packet(EHCIPacket *p)
>   
>   /* queue management */
>   
> -static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint32_t addr, int async)
> +static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint64_t addr, int async)
>   {
>       EHCIQueueHead *head = async ? &ehci->aqueues : &ehci->pqueues;
>       EHCIQueue *q;
> @@ -621,7 +621,7 @@ static void ehci_free_queue(EHCIQueue *q, const char *warn)
>       g_free(q);
>   }
>   
> -static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint32_t addr,
> +static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint64_t addr,
>                                           int async)
>   {
>       EHCIQueueHead *head = async ? &ehci->aqueues : &ehci->pqueues;
> @@ -1133,7 +1133,7 @@ static void ehci_flush_qh(EHCIQueue *q)
>   {
>       uint32_t *qh = (uint32_t *) &q->qh;
>       uint32_t dwords = sizeof(EHCIqh) >> 2;
> -    uint32_t addr = NLPTR_GET(q->qhaddr);
> +    uint64_t addr = NLPTR_GET(q->qhaddr);
>   
>       put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);
>   }
> @@ -1279,8 +1279,8 @@ static void ehci_execute_complete(EHCIQueue *q)
>       assert(p->async == EHCI_ASYNC_INITIALIZED ||
>              p->async == EHCI_ASYNC_FINISHED);
>   
> -    DPRINTF("execute_complete: qhaddr 0x%x, next 0x%x, qtdaddr 0x%x, "
> -            "status %d, actual_length %d\n",
> +    DPRINTF("execute_complete: qhaddr 0x%" PRIx64 ", next 0x%x, "
> +            "qtdaddr 0x%" PRIx64 ", status %d, actual_length %d\n",
>               q->qhaddr, q->qh.next, q->qtdaddr,
>               p->packet.status, p->packet.actual_length);

Please use trace events.

>   
> @@ -1389,9 +1389,10 @@ static int ehci_execute(EHCIPacket *p, const char *action)
>   
>       trace_usb_ehci_packet_action(p->queue, p, action);
>       usb_handle_packet(p->queue->dev, &p->packet);
> -    DPRINTF("submit: qh 0x%x next 0x%x qtd 0x%x pid 0x%x len %zd endp 0x%x "
> -            "status %d actual_length %d\n", p->queue->qhaddr, p->qtd.next,
> -            p->qtdaddr, p->pid, p->packet.iov.size, endp, p->packet.status,
> +    DPRINTF("submit: qh 0x%" PRIx64 " next 0x%x qtd 0x%" PRIx64
> +            " pid 0x%x len %zd endp 0x%x status %d actual_length %d\n",
> +            p->queue->qhaddr, p->qtd.next, p->qtdaddr, p->pid,
> +            p->packet.iov.size, endp, p->packet.status,
>               p->packet.actual_length);
>   
>       if (p->packet.actual_length > BUFF_SIZE) {
> @@ -1405,12 +1406,13 @@ static int ehci_execute(EHCIPacket *p, const char *action)
>   /* 4.7.2 */
>   static int ehci_process_itd(EHCIState *ehci,
>                               EHCIitd *itd,
> -                            uint32_t addr)
> +                            uint64_t addr)
>   {
>       USBDevice *dev;
>       USBEndpoint *ep;
>       uint32_t i, len, pid, dir, devaddr, endp;
> -    uint32_t pg, off, ptr1, ptr2, max, mult;
> +    uint32_t pg, off, max, mult;
> +    uint64_t ptr1, ptr2;
>   
>       ehci->periodic_sched_active = PERIODIC_ACTIVE;
>   
> @@ -1525,7 +1527,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
>       EHCIqh qh;
>       int i = 0;
>       int again = 0;
> -    uint32_t entry = ehci->asynclistaddr;
> +    uint64_t entry = ehci->asynclistaddr;
>   
>       /* set reclamation flag at start event (4.8.6) */
>       if (async) {
> @@ -1575,7 +1577,7 @@ out:
>   static int ehci_state_fetchentry(EHCIState *ehci, int async)
>   {
>       int again = 0;
> -    uint32_t entry = ehci_get_fetch_addr(ehci, async);
> +    uint64_t entry = ehci_get_fetch_addr(ehci, async);
>   
>       if (NLPTR_TBIT(entry)) {
>           ehci_set_state(ehci, async, EST_ACTIVE);
> @@ -1606,7 +1608,7 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
>   
>       default:
>           /* TODO: handle FSTN type */
> -        fprintf(stderr, "FETCHENTRY: entry at %X is of type %u "
> +        fprintf(stderr, "FETCHENTRY: entry at %" PRIx64 "is of type %" PRIu64
>                   "which is not supported yet\n", entry, NLPTR_TYPE_GET(entry));

This looks like a qemu_log_mask(LOG_GUEST_ERROR) to me.


>           return -1;
>       }
> @@ -1617,7 +1619,7 @@ out:
>   
>   static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
>   {
> -    uint32_t entry;
> +    uint64_t entry;
>       EHCIQueue *q;
>       EHCIqh qh;
>   
> @@ -1669,8 +1671,9 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
>           if (ehci->usbsts & USBSTS_REC) {
>               ehci_clear_usbsts(ehci, USBSTS_REC);
>           } else {
> -            DPRINTF("FETCHQH:  QH 0x%08x. H-bit set, reclamation status reset"
> -                       " - done processing\n", q->qhaddr);
> +            DPRINTF("FETCHQH:  QH 0x%" PRIx64
> +                    ". H-bit set, reclamation status reset - "
> +                    "done processing\n", q->qhaddr);
>               ehci_set_state(ehci, async, EST_ACTIVE);
>               q = NULL;
>               goto out;
> @@ -1679,7 +1682,8 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
>   
>   #if EHCI_DEBUG
>       if (q->qhaddr != q->qh.next) {
> -        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\n",
> +        DPRINTF("FETCHQH:  QH 0x%" PRIx64
> +                " (h %x halt %x active %x) next 0x%08x\n",
>                  q->qhaddr,
>                  q->qh.epchar & QH_EPCHAR_H,
>                  q->qh.token & QTD_TOKEN_HALT,
> @@ -1708,7 +1712,7 @@ out:
>   
>   static int ehci_state_fetchitd(EHCIState *ehci, int async)
>   {
> -    uint32_t entry;
> +    uint64_t entry;
>       EHCIitd itd;
>   
>       assert(!async);
> @@ -1734,7 +1738,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int async)
>   
>   static int ehci_state_fetchsitd(EHCIState *ehci, int async)
>   {
> -    uint32_t entry;
> +    uint64_t entry;
>       EHCIsitd sitd;
>   
>       assert(!async);
> @@ -1804,7 +1808,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
>       EHCIqtd qtd;
>       EHCIPacket *p;
>       int again = 1;
> -    uint32_t addr;
> +    uint64_t addr;
>   
>       addr = NLPTR_GET(q->qtdaddr);
>       if (get_dwords(q->ehci, addr +  8, &qtd.token,   1) < 0) {
> @@ -1887,7 +1891,7 @@ static int ehci_fill_queue(EHCIPacket *p)
>       USBEndpoint *ep = p->packet.ep;
>       EHCIQueue *q = p->queue;
>       EHCIqtd qtd = p->qtd;
> -    uint32_t qtdaddr;
> +    uint64_t qtdaddr;
>   
>       for (;;) {
>           if (NLPTR_TBIT(qtd.next) != 0) {
> @@ -2010,7 +2014,8 @@ static int ehci_state_executing(EHCIQueue *q)
>   static int ehci_state_writeback(EHCIQueue *q)
>   {
>       EHCIPacket *p = QTAILQ_FIRST(&q->packets);
> -    uint32_t *qtd, addr;
> +    uint32_t *qtd;
> +    uint64_t addr;
>       int again = 0;
>   
>       /*  Write back the QTD from the QH area */
> @@ -2484,8 +2489,8 @@ static void usb_ehci_vm_state_change(void *opaque, bool running, RunState state)
>   
>   const VMStateDescription vmstate_ehci = {
>       .name        = "ehci-core",
> -    .version_id  = 2,
> -    .minimum_version_id  = 1,
> +    .version_id  = 3,
> +    .minimum_version_id  = 2,
>       .pre_save    = usb_ehci_pre_save,
>       .post_load   = usb_ehci_post_load,
>       .fields = (const VMStateField[]) {
> @@ -2513,8 +2518,8 @@ const VMStateDescription vmstate_ehci = {
>           /* schedule state */
>           VMSTATE_UINT32(astate, EHCIState),
>           VMSTATE_UINT32(pstate, EHCIState),
> -        VMSTATE_UINT32(a_fetch_addr, EHCIState),
> -        VMSTATE_UINT32(p_fetch_addr, EHCIState),
> +        VMSTATE_UINT64(a_fetch_addr, EHCIState),
> +        VMSTATE_UINT64(p_fetch_addr, EHCIState),
>           VMSTATE_END_OF_LIST()
>       }
>   };

Thanks,

C.


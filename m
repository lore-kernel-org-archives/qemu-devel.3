Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFC2CD3424
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 20:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJdJL-0002m5-V3; Sun, 03 May 2026 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wJdJF-0002lO-4K
 for qemu-devel@nongnu.org; Sun, 03 May 2026 16:21:01 -0400
Received: from smtpout1.mo533.mail-out.ovh.net ([51.210.94.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wJdJC-0004CT-6o
 for qemu-devel@nongnu.org; Sun, 03 May 2026 16:21:00 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4g7x466GpMz5vj8;
 Sun,  3 May 2026 20:20:54 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Sun,  3 May 2026 20:20:54 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.232])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g7x4627L8z7tkJ; Sun,  3 May 2026 20:20:54 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 2D79F24034C4; Sun,  3 May 2026 20:20:50 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001dd448317-a882-4933-9f7e-69d6fe89b895,
 15A2E2FDD32F27586AD59E6AF3E683E8C1C94C55) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <619148f8-8161-4884-b7cb-b613e76cfd8a@kaod.org>
Date: Sun, 3 May 2026 22:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/18] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit with migration compatibility
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "farosas@suse.de" <farosas@suse.de>,
 "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
 <20260424080508.53992-10-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260424080508.53992-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 12548717412026199247
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFpD9hg/oyiLr81j+TJy0JdOG6XVzodr6gE2/fQG7eKYGkkum1WPffX4jK9yyIu1+O1ZXNAE+DvBCPOPzBwPla5epDNmvVhPdR4bTw0mS3u1BU8/R32jc6+obpGrLYMRmazoTjAldWoCHJB4fqAn5CPTXxflFKNcL+UrVhLDBjGfYaRQ5y2sNWmt9+jyuD+FiaeW0s+OJbimsUSksHpX2dBhSuhjr5MwmfXZflW7G5+iQEdbHjv164CwOHQq6ordbYe4yUqS+IJFWRgBz8J3WhaIOikxGTSh1199jv22mp+hkUk7HYEOXAlWlGiTX8i33UZrdMRkv4enZ6Dn5DQIX9vc5gNDDYXyLYCxm776cE9O77gvLNOYmVSmlhXmbUMXA13d3OGfnaBPhu7opzG6A5Y0Z/zHAtSMLTsg6Qcj2/iiCX9nzO3TtTALhcSmVxw9nZJVNnM6ytooxpSrF/cD3bVdSFYlc65z/30dP25Z+O2LtChd4WFiDIInVvEhimiPlivtPmqstSXSJhfqjivpmfl7HGNsFiQ0XQzwO8D/X942NKI5noBJ7Zp5xfRsP1syrCYSd4mV12yaAkFAsn2+T3NGS+y2rhGAdA3LSBMLT/mtL3erGKWEb8gV2K2oR7RKgcgwHD59S6LuCJ0FKzUaxLhAjjyaqRbtOkTA5RtOCaOng
DKIM-Signature: a=rsa-sha256; bh=3OCkAldnYiRpbILai1qckxwFg6wWm8zhclBMVLBnukM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1777839655; v=1;
 b=nYeH1PKWaBb40XzIbJ3Xw6edI2q8nyx8EHOvhkrGJUMP1ionkGEdqBsx5h+Nqk9hSZ1d1w1u
 c/XK1HMd6LcSY+OvzYRRDm2kZt6bFhpuZadZ20c6WhABEh7ZmFRL891AFEpnAN31oJ4SsiOjatw
 GP8PPvE9APZAM6dWMtJQrJP9rHHmoq0/GmzvQfXQlVQwuAkR/DZg9CZRTR+iRhE6QIFAzXjSIp9
 RY/Sn/qyWCSlkNTz1HFMx7yGxNa53gcZOvt3XYevw9VuzdxDRDabWMaJf9G4nYOpQMFVJSjh5nf
 5pZgAJMKlo1fjd7lb+O9t2FrkzwyMGqL92ItSL9B3zDQg==
Received-SPF: pass client-ip=51.210.94.138; envelope-from=clg@kaod.org;
 helo=smtpout1.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/24/26 10:05, Jamin Lin wrote:
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
>      #define NLPTR_GET(x) ((x) & ~0x1fULL)
> 
> so that link pointer masking works correctly when descriptor
> addresses exceed 32-bit space. The previous mask (0xffffffe0)
> implicitly truncated addresses to 32 bits.
> 
> This patch does not change the on-wire descriptor layout yet.
> It only removes the internal 32-bit address limit and prepares
> for later patches that will add full 64-bit QH/qTD/iTD/siTD support.
> 
> Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD to
> use uint64_t for the address argument and print it with PRIx64. This
> ensures full 64-bit addresses are shown in trace output and improves
> debugging of queue heads and transfer descriptors.
> 
> Migration compatibility:
> 
> To preserve backward migration compatibility, keep the legacy 32-bit
> fetch address fields (a_fetch_addr_32, p_fetch_addr_32) alongside the
> new 64-bit fields.
> 
> Migration format is selected using a machine compat property
> "x-migrate-fetch-addr-64bit":
> 
> - Old machine types migrate 32-bit fetch addresses
> - New machine types migrate full 64-bit fetch addresses
> 
> This is implemented using VMSTATE_UINT32_TEST() and
> VMSTATE_UINT64_TEST() so that only the appropriate format is migrated.
> 
> In pre_save, the 32-bit shadow fields are populated when migrating
> to old machine types. In post_load, the 32-bit values are restored
> into the 64-bit fields when loading old migration streams.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h   | 17 +++++++----
>   hw/core/machine.c   |  5 +++-
>   hw/usb/hcd-ehci.c   | 72 ++++++++++++++++++++++++++++++++-------------
>   hw/usb/trace-events | 24 +++++++--------
>   4 files changed, 78 insertions(+), 40 deletions(-)
> 
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index d038ee1e31..3acbddfc5c 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -208,7 +208,7 @@ struct EHCIPacket {
>       QTAILQ_ENTRY(EHCIPacket) next;
>   
>       EHCIqtd qtd;           /* copy of current QTD (being worked on) */
> -    uint32_t qtdaddr;      /* address QTD read from                 */
> +    uint64_t qtdaddr;      /* address QTD read from                 */
>   
>       USBPacket packet;
>       QEMUSGList sgl;
> @@ -229,8 +229,8 @@ struct EHCIQueue {
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
> @@ -256,6 +256,7 @@ struct EHCIState {
>   
>       /* properties */
>       uint32_t maxframes;
> +    bool migrate_fetch_addr_64bit;
>   
>       /*
>        *  EHCI spec version 1.0 Section 2.3
> @@ -294,8 +295,10 @@ struct EHCIState {
>       EHCIQueueHead pqueues;
>   
>       /* which address to look at next */
> -    uint32_t a_fetch_addr;
> -    uint32_t p_fetch_addr;
> +    uint32_t a_fetch_addr_32;
> +    uint32_t p_fetch_addr_32;
> +    uint64_t a_fetch_addr;
> +    uint64_t p_fetch_addr;
>   
>       USBPacket ipacket;
>       QEMUSGList isgl;
> @@ -308,7 +311,9 @@ struct EHCIState {
>   };
>   
>   #define DEFINE_EHCI_COMMON_PROPERTIES(_state) \
> -    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128)
> +    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \
> +    DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \
> +                     ehci.migrate_fetch_addr_64bit, true)
>   
>   extern const VMStateDescription vmstate_ehci;
>   
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1abc8ae737..b0c1580b16 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,7 +38,10 @@
>   #include "hw/acpi/generic_event_device.h"
>   #include "qemu/audio.h"
>   
> -GlobalProperty hw_compat_11_0[] = {};
> +GlobalProperty hw_compat_11_0[] = {
> +    { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
> +    { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
> +};
>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>   
>   GlobalProperty hw_compat_10_2[] = {
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 28a60e4c1a..0c8bdb48ad 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -72,7 +72,7 @@ typedef enum {
>   } EHCI_STATES;
>   
>   /* macros for accessing fields within next link pointer entry */
> -#define NLPTR_GET(x)             ((x) & 0xffffffe0)
> +#define NLPTR_GET(x)             ((x) & ~0x1fULL)
>   #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)
>   #define NLPTR_TBIT(x)            ((x) & 1)  /* 1=invalid, 0=valid */
>   
> @@ -287,7 +287,7 @@ static int ehci_get_state(EHCIState *s, int async)
>       return async ? s->astate : s->pstate;
>   }
>   
> -static void ehci_set_fetch_addr(EHCIState *s, int async, uint32_t addr)
> +static void ehci_set_fetch_addr(EHCIState *s, int async, uint64_t addr)
>   {
>       if (async) {
>           s->a_fetch_addr = addr;
> @@ -296,7 +296,7 @@ static void ehci_set_fetch_addr(EHCIState *s, int async, uint32_t addr)
>       }
>   }
>   
> -static int ehci_get_fetch_addr(EHCIState *s, int async)
> +static uint64_t ehci_get_fetch_addr(EHCIState *s, int async)
>   {
>       return async ? s->a_fetch_addr : s->p_fetch_addr;
>   }
> @@ -373,7 +373,7 @@ static inline bool ehci_periodic_enabled(EHCIState *s)
>   }
>   
>   /* Get an array of dwords from main memory */
> -static inline int get_dwords(EHCIState *ehci, uint32_t addr,
> +static inline int get_dwords(EHCIState *ehci, uint64_t addr,
>                                uint32_t *buf, int num)
>   {
>       int i;
> @@ -395,7 +395,7 @@ static inline int get_dwords(EHCIState *ehci, uint32_t addr,
>   }
>   
>   /* Put an array of dwords in to main memory */
> -static inline int put_dwords(EHCIState *ehci, uint32_t addr,
> +static inline int put_dwords(EHCIState *ehci, uint64_t addr,
>                                uint32_t *buf, int num)
>   {
>       int i;
> @@ -549,7 +549,7 @@ static void ehci_free_packet(EHCIPacket *p)
>   
>   /* queue management */
>   
> -static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint32_t addr, int async)
> +static EHCIQueue *ehci_alloc_queue(EHCIState *ehci, uint64_t addr, int async)
>   {
>       EHCIQueueHead *head = async ? &ehci->aqueues : &ehci->pqueues;
>       EHCIQueue *q;
> @@ -622,7 +622,7 @@ static void ehci_free_queue(EHCIQueue *q, const char *warn)
>       g_free(q);
>   }
>   
> -static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint32_t addr,
> +static EHCIQueue *ehci_find_queue_by_qh(EHCIState *ehci, uint64_t addr,
>                                           int async)
>   {
>       EHCIQueueHead *head = async ? &ehci->aqueues : &ehci->pqueues;
> @@ -1135,7 +1135,7 @@ static void ehci_flush_qh(EHCIQueue *q)
>   {
>       uint32_t *qh = (uint32_t *) &q->qh;
>       uint32_t dwords = sizeof(EHCIqh) >> 2;
> -    uint32_t addr = NLPTR_GET(q->qhaddr);
> +    uint64_t addr = NLPTR_GET(q->qhaddr);
>   
>       put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);
>   }
> @@ -1406,12 +1406,13 @@ static int ehci_execute(EHCIPacket *p, const char *action)
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
> @@ -1528,7 +1529,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  int async)
>       EHCIqh qh;
>       int i = 0;
>       int again = 0;
> -    uint32_t entry = ehci->asynclistaddr;
> +    uint64_t entry = ehci->asynclistaddr;
>   
>       /* set reclamation flag at start event (4.8.6) */
>       if (async) {
> @@ -1578,7 +1579,7 @@ out:
>   static int ehci_state_fetchentry(EHCIState *ehci, int async)
>   {
>       int again = 0;
> -    uint32_t entry = ehci_get_fetch_addr(ehci, async);
> +    uint64_t entry = ehci_get_fetch_addr(ehci, async);
>   
>       if (NLPTR_TBIT(entry)) {
>           ehci_set_state(ehci, async, EST_ACTIVE);
> @@ -1611,7 +1612,7 @@ static int ehci_state_fetchentry(EHCIState *ehci, int async)
>       default:
>           /* TODO: handle FSTN type */
>           qemu_log_mask(LOG_GUEST_ERROR,
> -                      "FETCHENTRY: entry at 0x%x is of type %u "
> +                      "FETCHENTRY: entry at %" PRIx64 "is of type %" PRIu64

This should be :

                          "FETCHENTRY: entry at %" PRIx64 " is of type %" PRIu64 " "

>                         "which is not supported yet\n",
>                         entry, NLPTR_TYPE_GET(entry));
>           return -1;
> @@ -1623,7 +1624,7 @@ out:
>   
>   static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
>   {
> -    uint32_t entry;
> +    uint64_t entry;
>       EHCIQueue *q;
>       EHCIqh qh;
>   
> @@ -1712,7 +1713,7 @@ out:
>   
>   static int ehci_state_fetchitd(EHCIState *ehci, int async)
>   {
> -    uint32_t entry;
> +    uint64_t entry;
>       EHCIitd itd;
>   
>       assert(!async);
> @@ -1738,7 +1739,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int async)
>   
>   static int ehci_state_fetchsitd(EHCIState *ehci, int async)
>   {
> -    uint32_t entry;
> +    uint64_t entry;
>       EHCIsitd sitd;
>   
>       assert(!async);
> @@ -1802,7 +1803,7 @@ static int ehci_state_fetchqtd(EHCIQueue *q)
>       EHCIqtd qtd;
>       EHCIPacket *p;
>       int again = 1;
> -    uint32_t addr;
> +    uint64_t addr;
>   
>       addr = NLPTR_GET(q->qtdaddr);
>       if (get_dwords(q->ehci, addr +  8, &qtd.token,   1) < 0) {
> @@ -1885,7 +1886,7 @@ static int ehci_fill_queue(EHCIPacket *p)
>       USBEndpoint *ep = p->packet.ep;
>       EHCIQueue *q = p->queue;
>       EHCIqtd qtd = p->qtd;
> -    uint32_t qtdaddr;
> +    uint64_t qtdaddr;
>   
>       for (;;) {
>           if (NLPTR_TBIT(qtd.next) != 0) {
> @@ -2008,7 +2009,8 @@ static int ehci_state_executing(EHCIQueue *q)
>   static int ehci_state_writeback(EHCIQueue *q)
>   {
>       EHCIPacket *p = QTAILQ_FIRST(&q->packets);
> -    uint32_t *qtd, addr;
> +    uint32_t *qtd;
> +    uint64_t addr;
>       int again = 0;
>   
>       /*  Write back the QTD from the QH area */
> @@ -2414,6 +2416,18 @@ static USBBusOps ehci_bus_ops_standalone = {
>       .wakeup_endpoint = ehci_wakeup_endpoint,
>   };
>   
> +static bool ehci_fetch_addr_64_needed(void *opaque, int version_id)
> +{
> +    EHCIState *s = opaque;
> +
> +    return s->migrate_fetch_addr_64bit;
> +}
> +
> +static bool ehci_fetch_addr_32_needed(void *opaque, int version_id)
> +{
> +    return !ehci_fetch_addr_64_needed(opaque, version_id);
> +}
> +
>   static int usb_ehci_pre_save(void *opaque)
>   {
>       EHCIState *ehci = opaque;
> @@ -2424,6 +2438,11 @@ static int usb_ehci_pre_save(void *opaque)
>       ehci->last_run_ns -= (ehci->frindex - new_frindex) * UFRAME_TIMER_NS;
>       ehci->frindex = new_frindex;
>   
> +    if (!ehci->migrate_fetch_addr_64bit) {
> +        ehci->a_fetch_addr_32 = ehci->a_fetch_addr;
> +        ehci->p_fetch_addr_32 = ehci->p_fetch_addr;
> +    }
> +
>       return 0;
>   }
>   
> @@ -2444,6 +2463,11 @@ static int usb_ehci_post_load(void *opaque, int version_id)
>           }
>       }
>   
> +    if (!s->migrate_fetch_addr_64bit) {
> +        s->a_fetch_addr = s->a_fetch_addr_32;
> +        s->p_fetch_addr = s->p_fetch_addr_32;
> +    }
> +
>       return 0;
>   }
>   
> @@ -2504,8 +2528,14 @@ const VMStateDescription vmstate_ehci = {
>           /* schedule state */
>           VMSTATE_UINT32(astate, EHCIState),
>           VMSTATE_UINT32(pstate, EHCIState),
> -        VMSTATE_UINT32(a_fetch_addr, EHCIState),
> -        VMSTATE_UINT32(p_fetch_addr, EHCIState),
> +        VMSTATE_UINT32_TEST(a_fetch_addr_32, EHCIState,
> +                            ehci_fetch_addr_32_needed),
> +        VMSTATE_UINT32_TEST(p_fetch_addr_32, EHCIState,
> +                            ehci_fetch_addr_32_needed),
> +        VMSTATE_UINT64_TEST(a_fetch_addr, EHCIState,
> +                            ehci_fetch_addr_64_needed),
> +        VMSTATE_UINT64_TEST(p_fetch_addr, EHCIState,
> +                            ehci_fetch_addr_64_needed),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index 0d4318dcf1..8c90688bb3 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -86,15 +86,15 @@ usb_ehci_portsc_write(uint32_t addr, uint32_t port, uint32_t val) "wr mmio 0x%04
>   usb_ehci_portsc_change(uint32_t addr, uint32_t port, uint32_t new, uint32_t old) "ch mmio 0x%04x [port %d] = 0x%x (old: 0x%x)"
>   usb_ehci_usbsts(const char *sts, int state) "usbsts %s %d"
>   usb_ehci_state(const char *schedule, const char *state) "%s schedule %s"
> -usb_ehci_qh_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t c_qtd, uint32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%08x: next 0x%08x qtds 0x%08x,0x%08x,0x%08x"
> -usb_ehci_qh_fields(uint32_t addr, int rl, int mplen, int eps, int ep, int devaddr) "QH @ 0x%08x - rl %d, mplen %d, eps %d, ep %d, dev %d"
> -usb_ehci_qh_bits(uint32_t addr, int c, int h, int dtc, int i) "QH @ 0x%08x - c %d, h %d, dtc %d, i %d"
> +usb_ehci_qh_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t c_qtd, uint32_t n_qtd, uint32_t a_qtd) "q %p - QH @ 0x%" PRIx64 ": next 0x%08x qtds 0x%08x,0x%08x,0x%08x"
> +usb_ehci_qh_fields(uint64_t addr, int rl, int mplen, int eps, int ep, int devaddr) "QH @ 0x%" PRIx64 " - rl %d, mplen %d, eps %d, ep %d, dev %d"
> +usb_ehci_qh_bits(uint64_t addr, int c, int h, int dtc, int i) "QH @ 0x%" PRIx64 " - c %d, h %d, dtc %d, i %d"
>   usb_ehci_qh_tbytes(uint32_t tbytes) "updating tbytes to %d"
> -usb_ehci_qtd_ptrs(void *q, uint32_t addr, uint32_t nxt, uint32_t altnext) "q %p - QTD @ 0x%08x: next 0x%08x altnext 0x%08x"
> -usb_ehci_qtd_fields(uint32_t addr, int tbytes, int cpage, int cerr, int pid) "QTD @ 0x%08x - tbytes %d, cpage %d, cerr %d, pid %d"
> -usb_ehci_qtd_bits(uint32_t addr, int ioc, int active, int halt, int babble, int xacterr) "QTD @ 0x%08x - ioc %d, active %d, halt %d, babble %d, xacterr %d"
> -usb_ehci_itd(uint32_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, uint32_t ep, uint32_t devaddr) "ITD @ 0x%08x: next 0x%08x - mplen %d, mult %d, ep %d, dev %d"
> -usb_ehci_sitd(uint32_t addr, uint32_t nxt, uint32_t active) "ITD @ 0x%08x: next 0x%08x - active %d"
> +usb_ehci_qtd_ptrs(void *q, uint64_t addr, uint32_t nxt, uint32_t altnext) "q %p - QTD @ 0x%" PRIx64 ": next 0x%08x altnext 0x%08x"
> +usb_ehci_qtd_fields(uint64_t addr, int tbytes, int cpage, int cerr, int pid) "QTD @ 0x%" PRIx64 " - tbytes %d, cpage %d, cerr %d, pid %d"
> +usb_ehci_qtd_bits(uint64_t addr, int ioc, int active, int halt, int babble, int xacterr) "QTD @ 0x%" PRIx64 " - ioc %d, active %d, halt %d, babble %d, xacterr %d"
> +usb_ehci_itd(uint64_t addr, uint32_t nxt, uint32_t mplen, uint32_t mult, uint32_t ep, uint32_t devaddr) "ITD @ 0x%" PRIx64 ": next 0x%08x - mplen %d, mult %d, ep %d, dev %d"
> +usb_ehci_sitd(uint64_t addr, uint32_t nxt, uint32_t active) "SITD @ 0x%" PRIx64 ": next 0x%08x - active %d"
>   usb_ehci_port_attach(uint32_t port, const char *owner, const char *device) "attach port #%d, owner %s, device %s"
>   usb_ehci_port_detach(uint32_t port, const char *owner) "detach port #%d, owner %s"
>   usb_ehci_port_reset(uint32_t port, int enable) "reset port #%d - %d"
> @@ -104,15 +104,15 @@ usb_ehci_port_resume(uint32_t port) "port #%d"
>   usb_ehci_port_disable(uint32_t port) "port #%d"
>   usb_ehci_queue_action(void *q, const char *action) "q %p: %s"
>   usb_ehci_packet_action(void *q, void *p, const char *action) "q %p p %p: %s"
> -usb_ehci_packet_submit(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, int pid, size_t len, int endp, int status, int actual_length) "qh=0x%x, next=0x%x, qtd=0x%x, pid=0x%x, len=%zd, endp=0x%x, status=%d, actual_length=%d"
> +usb_ehci_packet_submit(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr, int pid, size_t len, int endp, int status, int actual_length) "qh=0x%" PRIx64 ", next=0x%x, qtd=0x%" PRIx64 ", pid=0x%x, len=%zd, endp=0x%x, status=%d, actual_length=%d"
>   usb_ehci_irq(uint32_t level, uint32_t frindex, uint32_t sts, uint32_t mask) "level %d, frindex 0x%04x, sts 0x%x, mask 0x%x"
>   usb_ehci_guest_bug(const char *reason) "%s"
>   usb_ehci_doorbell_ring(void) ""
>   usb_ehci_doorbell_ack(void) ""
>   usb_ehci_dma_error(void) ""
> -usb_ehci_execute_complete(uint32_t qhaddr, uint32_t next, uint32_t qtdaddr, int status, int actual_length) "qhaddr=0x%x, next=0x%x, qtdaddr=0x%x, status=%d, actual_length=%d"
> -usb_ehci_fetchqh_reclaim_done(uint32_t qhaddr) "QH 0x%08x H-bit set, reclamation status reset - done processing"
> -usb_ehci_fetchqh_dbg(uint32_t qhaddr, uint32_t h, uint32_t halt, uint32_t active, uint32_t next) "QH 0x%08x (h 0x%x halt 0x%x active 0x%x) next 0x%08x"
> +usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr, int status, int actual_length) "qhaddr=0x%" PRIx64 ", next=0x%x, qtdaddr=0x%" PRIx64 ", status=%d, actual_length=%d"
> +usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set, reclamation status reset - done processing"
> +usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) next 0x%08x"
>   usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t entry) "frame=%d, list=0x%x, entry=0x%x"
>   usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uframes"
>   usb_ehci_log(const char *msg) "%s"





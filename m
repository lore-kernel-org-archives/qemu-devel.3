Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148CCCA5FA6
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBH0E-0004Z7-Et; Mon, 28 Sep 2026 15:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1xBH0B-0004Ra-Fx; Mon, 28 Sep 2026 15:27:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1xBH09-00039R-6j; Mon, 28 Sep 2026 15:27:03 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI6Uu81862928; Mon, 28 Sep 2026 19:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EBLNnZ
 tb1tcmm/T40RzswBp4SLQ7pmUXG2nklJCRbzk=; b=EWH3MDyGttBGYweAmuKImV
 Ndwlz7CyRVnDhHCpR4grKLWePqH+kFHg2WcWV1WIs4nntWye5vdCnA4EztRYCc2c
 zZACQ4HZrgEuE7jQr0z9ksrg1I1Y1yvGHxo77LIu4X3Nk1WbmIPazvErz/ud7z6m
 xqwtCzdANxZebSVXOBy1GSo62sM8wTBzF+5UPWk91Z3MyZ2Y9VvfzOPQy+0HSL5r
 LVGFpSztCf6Hb9cgNCJ4Y1xfzPyjBlX4t0u+cxopgzn4tlcqNtInoWce3jUQhlLY
 eSdualWeTrnG76LH1naAWNv7B6PoVdgbqaAcOrx4MFZ1qwvmqWBCXeE3Ya13tiyw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j53gu9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 19:26:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI2bHF525998; Mon, 28 Sep 2026 19:26:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcppv5u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 19:26:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68SJQkXB16384574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 19:26:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 540255805A;
 Mon, 28 Sep 2026 19:26:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9E0758056;
 Mon, 28 Sep 2026 19:26:44 +0000 (GMT)
Received: from [9.61.20.72] (unknown [9.61.20.72])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 19:26:44 +0000 (GMT)
Message-ID: <e17a5337-849a-428a-b8e4-65fd92a8c186@linux.ibm.com>
Date: Mon, 28 Sep 2026 09:32:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390x/sclpconsole: implement resizing for vt220
 consoles
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, filip.hejsek@gmail.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 mjrosato@linux.ibm.com, brueckner@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, maximilian.immanuel.brandtner@protonmail.com
References: <20260921121641.1354712-1-maxbr@linux.ibm.com>
 <20260928090846.2315532-1-maxbr@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260928090846.2315532-1-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3NiBTYWx0ZWRfXwOEEanZG0e5V
 J9EtVYobQI0ocxnAeKNoiAJeUmIl/9jgedbPMxkW2mg0Yn9Kn49H+PTiQuLmmJhMD8OSoyHSudV
 IPgRRKvirso2ah4eau9HbD2ANB16a1M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3NiBTYWx0ZWRfX6HtqRiinAlvs
 Ws7WnTLzuEZ3opzGLytxuunHUFufO5gVByM7etkbj63ey8JLFVZXm+7HL9eRMuQNH4xbJZGZ9ea
 S+BVrZCxiRKP1G81t1bISo1Ol9e5nooR++V9JqUhaQE72fPdu2ASbvd1sihLeC0o1kEreg35N/P
 IhrmRA3/59ccW50d72AsqV/sp48f769+C1Y9wwBa5zXJCQVpylskLKBK+LDy/MoXnEGirqoxNzh
 2K6UV4S6zKHzyO1pWmSu1EFQMEObs4zkf12XmL8s6kckIX85EXA7DVM9grnWWz+lU6C3deEQlUB
 fSAQ6MTIPIhLU90laR9x8DNUiDPH/A1nft5tvdBkH++A6yBv1soRrQHTZZCrzR8UU8Xep7+L4Cj
 cNR1qR/Bd316BCuvz6SQthnTH6dE01AGOCCoDXgNezH/TB5StXDMOazzXbTZVTBTBWNiqLSOxod
 uFE9fgEjPDzdpY8TSgA==
X-Proofpoint-GUID: Xs1PgEPOt0II0zTKJnCIbrdnU6tS6ze5
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6ababf79 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=5IBcVxVqQIVh2jd4fTEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EqR4KJaxfzSqg4I5yK__76MIGNdF2Sy1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 9/28/26 5:08 AM, Maximilian Immanuel Brandtner wrote:
> Add a tty code to indicate a resize frame. The body contains two big
> endian 16-bit integers rows and columns.
> 
> After reset, the guest must be informed of the terminal size again. A
> chardev that doesn't report its size yields 0x0, which shouldn't replace
> the guest's default.
> 
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> ---
> Changelog:
> v2:
> - Use packed struct and named event type codes for resize frames
> - Trigger initial resize event in console_reset() instead of
>    console_init(), skip when chardev reports no size
> - Reset event_pending after resize event
> 
> Requires the following pre-req:
>      [PATCH v7 00/12] virtio-console: notify about the terminal size
>      (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c550fdcec15@gmail.com/)
> 
> Testing:
> - Tested on QEMU: commit 38879a667f with the following patches applied:
>      [PATCH v7 00/12] virtio-console: notify about the terminal size
> - Tested on linux-next (commit c1f49dea2b8f) with the following patches
>    applied:
>      [PATCH 0/2] s390/sclp: Resize for sclp-vt220 console
> ---
>   hw/char/sclpconsole.c | 92 +++++++++++++++++++++++++++++++++++++------
>   1 file changed, 80 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index 179d12745c..12033e1e46 100644
> --- a/hw/char/sclpconsole.c
> +++ b/hw/char/sclpconsole.c
> @@ -33,6 +33,9 @@ typedef struct ASCIIConsoleData {
>   /* max size for ASCII data in 4K SCCB page */
>   #define SIZE_BUFFER_VT220 4080
>   
> +#define SCLP_CONSOLE_EVENT_TYPE_DATA 0x00
> +#define SCLP_CONSOLE_EVENT_TYPE_RESIZE 0x08
> +
>   struct SCLPConsole {
>       SCLPEvent event;
>       CharFrontend chr;
> @@ -42,6 +45,8 @@ struct SCLPConsole {
>       uint32_t iov_data_len;  /* length of byte stream in buffer             */
>       uint32_t iov_sclp_rest; /* length of byte stream not read via SCLP     */
>       bool notify;            /* qemu_notify_event() req'd if true           */
> +    bool resize;
> +    bool resize_init;
>   };
>   typedef struct SCLPConsole SCLPConsole;
>   
> @@ -49,6 +54,12 @@ typedef struct SCLPConsole SCLPConsole;
>   DECLARE_INSTANCE_CHECKER(SCLPConsole, SCLP_CONSOLE,
>                            TYPE_SCLP_CONSOLE)
>   
> +typedef struct SCLPConsoleResizeData {
> +    uint8_t type;
> +    uint16_t rows;
> +    uint16_t cols;
> +} QEMU_PACKED SCLPConsoleResizeData;
> +
>   /* character layer call-back functions */
>   
>   /* Return number of bytes that fit into iov buffer */
> @@ -81,6 +92,29 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
>       sclp_service_interrupt(0);
>   }
>   
> +static void chr_event(void *opaque, QEMUChrEvent event)
> +{
> +    SCLPConsole *scon = opaque;
> +
> +    assert(scon);
> +
> +    switch (event) {
> +    case CHR_EVENT_RESIZE:
> +    case CHR_EVENT_MUX_IN:
> +        scon->resize = true;
> +        scon->resize_init = false;
> +        scon->event.event_pending = true;
> +        sclp_service_interrupt(0);
> +        break;
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_OPENED:
> +    case CHR_EVENT_MUX_OUT:
> +    case CHR_EVENT_CLOSED:
> +        /* ignore */
> +        break;
> +    }
> +}
> +
>   /* functions to be called by event facility */
>   
>   static bool can_handle_event(uint8_t type)
> @@ -104,10 +138,37 @@ static sccb_mask_t receive_mask(void)
>   static void get_console_data(SCLPEvent *event, uint8_t *buf, size_t *size,
>                                int avail)
>   {
> +    SCLPConsoleResizeData resize_data;
>       SCLPConsole *cons = SCLP_CONSOLE(event);
> +    uint16_t rows, cols;
> +
> +    if (cons->resize) {
> +        if (avail < sizeof(resize_data)) {
> +            *size = 0;
> +            return;
> +        }
>   
> -    /* first byte is hex 0 saying an ascii string follows */
> -    *buf++ = '\0';
> +        qemu_chr_fe_get_winsize(&cons->chr, &cols, &rows);
> +
> +        if (cons->resize_init && cols == 0 && rows == 0) {
> +            *size = 0;
> +        } else {
> +            resize_data.type = SCLP_CONSOLE_EVENT_TYPE_RESIZE;
> +            resize_data.rows = cpu_to_be16(rows);
> +            resize_data.cols = cpu_to_be16(cols);
> +
> +            memcpy(buf, &resize_data, sizeof(resize_data));
> +            *size = sizeof(resize_data);
> +        }
> +
> +        cons->resize = false;
> +        cons->resize_init = false;
> +        event->event_pending = cons->iov_sclp_rest != 0;
> +
> +        return;
> +    }
> +
> +    *buf++ = SCLP_CONSOLE_EVENT_TYPE_DATA;
>       avail--;
>       /* if all data fit into provided SCLP buffer */
>       if (avail >= cons->iov_sclp_rest) {
> @@ -150,6 +211,9 @@ static int read_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr,
>       to = (uint8_t *)&acd->data;
>       avail = *slen - sizeof(ASCIIConsoleData);
>       get_console_data(event, to, &src_len, avail);
> +    if (src_len == 0) {
> +        return 0;
> +    }
>       acd->ebh.length = cpu_to_be16(sizeof(ASCIIConsoleData) + src_len);
>       acd->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
> @@ -233,22 +297,26 @@ static int console_init(SCLPEvent *event)
>       }
>       console_available = true;
>       qemu_chr_fe_set_handlers(&scon->chr, chr_can_read,
> -                             chr_read, NULL, NULL, scon, NULL, true);
> +                             chr_read, chr_event, NULL, scon, NULL, true);
>   
>       return 0;
>   }
>   
>   static void console_reset(DeviceState *dev)
>   {
> -   SCLPEvent *event = SCLP_EVENT(dev);
> -   SCLPConsole *scon = SCLP_CONSOLE(event);
> -
> -   event->event_pending = false;
> -   scon->iov_sclp = 0;
> -   scon->iov_bs = 0;
> -   scon->iov_data_len = 0;
> -   scon->iov_sclp_rest = 0;
> -   scon->notify = false;
> +    SCLPEvent *event = SCLP_EVENT(dev);
> +    SCLPConsole *scon = SCLP_CONSOLE(event);
> +
> +    scon->iov_sclp = 0;
> +    scon->iov_bs = 0;
> +    scon->iov_data_len = 0;
> +    scon->iov_sclp_rest = 0;
> +    scon->notify = false;
> +
> +    /* the guest defaults its terminal size on reset, announce the real one */
> +    scon->resize = true;
> +    scon->resize_init = true;
> +    event->event_pending = true;
>   }

This is a style fix, included in a functional patch. I suppose it is 
probably borderline, but it might be best to put this in its own patch.

Other than that:
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>



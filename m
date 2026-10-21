Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D9C606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m7vEMSce
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJVbj-0007Pw-US; Wed, 21 Oct 2026 08:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xJVbO-0007O8-UO; Wed, 21 Oct 2026 08:39:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xJVbM-0000TE-TN; Wed, 21 Oct 2026 08:39:30 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBiqu71092897; Wed, 21 Oct 2026 12:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8VyDmG
 sY2b1vk4TJV8uREfvjZBrygJqqFY7EH7xZx9g=; b=m7vEMScecC0SZtHZC8ZSqp
 ooSbdiAWoR4ZepVaDOFnYFU4nEOjqBgZJiCj9hvPB/rgyOmzJTTv64EjbCph8Z9k
 fXv1zRv3TcSVXCa7SHlkDNspgFgYCIWJOaudSbnRhByaqvMpC0VILmPZFjb4Rnhi
 F6O2mKHLVw71yBY85DVdYGK4/bx8BWeSdLf6f9RdQeLLWSFOCjlIAsQSEMs+/ezF
 VbavZRDAQW7pxZ7pgalgHhKHaCwzOtovL02vif8RFdep6nKqbqLA/3FhrRTcnTEw
 4CDyF+MWJL/Bs6k05lmN7yIxkztdpkGPFQFf19qcRZwWfo9MJhtS/h8Z+BAiETqg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a0prt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 12:39:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBo1n91856506; Wed, 21 Oct 2026 12:39:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss2y94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 12:39:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69LCdDvP21430786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Oct 2026 12:39:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1A335806A;
 Wed, 21 Oct 2026 12:39:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 350235805F;
 Wed, 21 Oct 2026 12:39:10 +0000 (GMT)
Received: from [9.61.191.236] (unknown [9.61.191.236])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Oct 2026 12:39:10 +0000 (GMT)
Message-ID: <c046e951-7771-419f-b82e-a39efbbcf2cf@linux.ibm.com>
Date: Wed, 21 Oct 2026 08:39:09 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] s390x/sclpconsole: implement resizing for vt220
 consoles
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, filip.hejsek@gmail.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, brueckner@linux.ibm.com,
 cohuck@redhat.com, maximilian.immanuel.brandtner@protonmail.com
References: <20260921121641.1354712-1-maxbr@linux.ibm.com>
 <20260929152012.2696005-1-maxbr@linux.ibm.com>
 <20260929152012.2696005-3-maxbr@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260929152012.2696005-3-maxbr@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0OCBTYWx0ZWRfXynPHpjtflNvh
 5fAAWvPnAd1s2rovNC/pvsM6VDXm6fsMNbfTHpNr8iqMhN87dDPQQQG4r8WcLBX+HY6pdl4GcYF
 +ulEOPTC6aUQg2Vfp7reoXbbBNUsRta97BXYehXqRnjWWEjNoJGf2wSBdHUudJvk6MVCp2YZIBe
 mAaNUzGErkxAlYguyljNh2/ETtU5qHIwuv3AUnTU2Ejo0RTH+riwPFPX/M48mhhGBtBsHf+qegC
 SAh/6GexSd146Ce1UUrWbBwM7Vnb+lg+GRb1xoD9BlhvTo7ec15S8DVGflqJIBh3bFps4GlmeKB
 W4QQI6K7UIOqp3lUBuOn5BIZP9yxPuLLLEWVBX18mN8wMzAQDonjPHgrUTabBafMbhf3B8e392A
 23Pu8Ik1XrZmBCxmt2KJj9VEbq1y7Ur8ExE+Lrht3Q0JVsvApPYIM3d/GTpsz9IoONaftRWuYjV
 //ZNSuRz4e/RRgZERDw==
X-Proofpoint-ORIG-GUID: pytFOvnf-SZprYiQ1rXZqLqcumScAUeR
X-Proofpoint-GUID: -m8xyB-V63I5V_nGxrLcFm3TjZjJZ-iT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0OCBTYWx0ZWRfX7++ZLPOIsCrX
 EHnskELgOXcKYapHdU69h8LRD6dyo/+A3geXAJ/z6FZO21Pr9InYdSbYNhWG2MKzVk318KdEOSC
 IAsnKJo+5WaeTTXNhaCdva4kbpk4OQU=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad8b273 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=5IBcVxVqQIVh2jd4fTEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 9/29/26 11:20 AM, Maximilian Immanuel Brandtner wrote:
> Add a tty code to indicate a resize frame. The body contains two big
> endian 16-bit integers rows and columns.
> 
> After reset, the guest must be informed of the terminal size again. A
> chardev that doesn't report its size yields 0x0, which shouldn't replace
> the guest's default.
> 
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

This works well for me.

Tested-by: Eric Farman <farman@linux.ibm.com>

> ---
> Changelog:
> v3:
> - split console_reset indentation fix into its own patch
> 
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
>   hw/char/sclpconsole.c | 76 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 72 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index 1ad39084d3..12033e1e46 100644
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
>   
> -    /* first byte is hex 0 saying an ascii string follows */
> -    *buf++ = '\0';
> +    if (cons->resize) {
> +        if (avail < sizeof(resize_data)) {
> +            *size = 0;
> +            return;
> +        }
> +
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
>   
>       acd->ebh.length = cpu_to_be16(sizeof(ASCIIConsoleData) + src_len);
>       acd->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
> @@ -233,7 +297,7 @@ static int console_init(SCLPEvent *event)
>       }
>       console_available = true;
>       qemu_chr_fe_set_handlers(&scon->chr, chr_can_read,
> -                             chr_read, NULL, NULL, scon, NULL, true);
> +                             chr_read, chr_event, NULL, scon, NULL, true);
>   
>       return 0;
>   }
> @@ -243,12 +307,16 @@ static void console_reset(DeviceState *dev)
>       SCLPEvent *event = SCLP_EVENT(dev);
>       SCLPConsole *scon = SCLP_CONSOLE(event);
>   
> -    event->event_pending = false;
>       scon->iov_sclp = 0;
>       scon->iov_bs = 0;
>       scon->iov_data_len = 0;
>       scon->iov_sclp_rest = 0;
>       scon->notify = false;
> +
> +    /* the guest defaults its terminal size on reset, announce the real one */
> +    scon->resize = true;
> +    scon->resize_init = true;
> +    event->event_pending = true;
>   }
>   
>   static const Property console_properties[] = {



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51AECA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBI3I-0000b1-CF; Mon, 28 Sep 2026 16:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBI33-0000ZT-T8; Mon, 28 Sep 2026 16:34:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBI31-0002Uy-KO; Mon, 28 Sep 2026 16:34:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI5MMo4187624; Mon, 28 Sep 2026 20:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ps+j9N
 B4MVe9RueeMa8n9DoCX1SmYZeD4lmeITd80Y8=; b=iA/dddbLjvZGQQe813Nyyd
 DoC/VJOHP0Zu+bVhz7TYcAzmvZmb9IX12YWcm+5zr+n66HsMcHCjAygXIWfyMMFs
 lxFTDqRriU9Cbax2fX9K0FBh7Zx/nlJH+vlPzmahZzHv4qA+oEDnI6tdYBxW63ov
 V+IqhynC/UyMU34NDoJRYNkTqkpsZj8/3ErJGKY51QThox7G3M8rDgLiwvIen922
 eWkQ0h5uEBzb+IzStgyxgE0OKDnV/uygV9TA/5WgDQ6EWY/fiSGjGd/vI4dgwmKo
 OGbw2Vc4OBKVQRSe47wVkhplOf4+OfhrkdmefMT9eADi8eqNgD9Qtdkrrv8KSLkg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr3ncx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 20:33:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI2hcT532504; Mon, 28 Sep 2026 20:33:51 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvheu39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 20:33:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68SKXo4f62128624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 20:33:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 778085804E;
 Mon, 28 Sep 2026 20:33:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 475745803F;
 Mon, 28 Sep 2026 20:33:48 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 20:33:48 +0000 (GMT)
Message-ID: <9a2e2ac7-5f84-40cc-bd6e-4788a2375011@linux.ibm.com>
Date: Mon, 28 Sep 2026 16:33:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390x/sclpconsole: implement resizing for vt220
 consoles
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>, filip.hejsek@gmail.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 brueckner@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 maximilian.immanuel.brandtner@protonmail.com
References: <20260921121641.1354712-1-maxbr@linux.ibm.com>
 <20260928090846.2315532-1-maxbr@linux.ibm.com>
 <e17a5337-849a-428a-b8e4-65fd92a8c186@linux.ibm.com>
 <557a71b95eb900454adc477ad16154e1466f13d9.camel@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <557a71b95eb900454adc477ad16154e1466f13d9.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfX+aQ7viyj7zdh
 WdQ4o/NCHoR2wwszHIdIQuWrScZt9mrg+ZxtplrnYL3mJMZQbaYsIj/W09TqITmw4iGl1t5CFdE
 tnKnhOc0w+fNMZBo+KkZDuI4wOEX4WxjgzqCnDPjTWgprONMQIbbWTZEQ7VVJdkwecEx6sOOWdG
 VaDjLsME/Hf7e1X0okypgmj6ad5JByoNNMlQopx7iLup+p02841F5u81oP9lbqwxR9FULIiYPfh
 MboiPYFn6Ngd/VcaiC+Ic/xGSEOWElz4A2WoW8dFOBrDvQT108PqMH3pGFT350H/inUq+sAVOGm
 gdXmKVVFE4rgSjSnkZazrSBgHpeDuU3G/jVfcMIIkSMB+4bHaJBCnnooG3E3d6LyF/PKyCWNLBh
 PkD6VQvB3NbPLdtzUidxhAZOtMdrmlcP4D4ArHjVG3U1dBBWHdDtiIBuiD7fYxcNT3hnssVKDRH
 fhd8XL1qoLCFHyyOAOQ==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abacf31 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=G0mUEZQB_ZACgesOxLkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: E4cHhZF1v1pmWJuoVnvVlP4Jy4PEyxE_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfX+4yX5p7SQUnW
 Z4RU0w9u6K1YW0jjFIDGzaboSA/7jAN7OldLNAaygwT077icRiRudm6YM3FvexC3iPL6Thk60L8
 a9bfPZg6wpHAS5LPQsP++NF70LGMGlU=
X-Proofpoint-GUID: s-FMyZ1dtcHSTpMlL-lKLuvXhhePqJKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280080
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/28/26 3:28 PM, Maximilian Immanuel Brandtner wrote:
> On Mon, 2026-09-28 at 09:32 -0400, Jason J. Herne wrote:
>>
>>
>> On 9/28/26 5:08 AM, Maximilian Immanuel Brandtner wrote:
>>> Add a tty code to indicate a resize frame. The body contains two
>>> big
>>> endian 16-bit integers rows and columns.
>>>
>>> After reset, the guest must be informed of the terminal size again.
>>> A
>>> chardev that doesn't report its size yields 0x0, which shouldn't
>>> replace
>>> the guest's default.
>>>
>>> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Use packed struct and named event type codes for resize frames
>>> - Trigger initial resize event in console_reset() instead of
>>>    console_init(), skip when chardev reports no size
>>> - Reset event_pending after resize event
>>>
>>> Requires the following pre-req:
>>>      [PATCH v7 00/12] virtio-console: notify about the terminal
>>> size
>>>     
>>> (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c
>>> 550fdcec15@gmail.com/)
>>>
>>> Testing:
>>> - Tested on QEMU: commit 38879a667f with the following patches
>>> applied:
>>>      [PATCH v7 00/12] virtio-console: notify about the terminal
>>> size
>>> - Tested on linux-next (commit c1f49dea2b8f) with the following
>>> patches
>>>    applied:
>>>      [PATCH 0/2] s390/sclp: Resize for sclp-vt220 console
>>> ---
>>>   hw/char/sclpconsole.c | 92 +++++++++++++++++++++++++++++++++++++-
>>> -----
>>>   1 file changed, 80 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
>>> index 179d12745c..12033e1e46 100644
>>> --- a/hw/char/sclpconsole.c
>>> +++ b/hw/char/sclpconsole.c
>>> @@ -33,6 +33,9 @@ typedef struct ASCIIConsoleData {
>>>   /* max size for ASCII data in 4K SCCB page */
>>>   #define SIZE_BUFFER_VT220 4080
>>>   
>>> +#define SCLP_CONSOLE_EVENT_TYPE_DATA 0x00
>>> +#define SCLP_CONSOLE_EVENT_TYPE_RESIZE 0x08
>>> +
>>>   struct SCLPConsole {
>>>       SCLPEvent event;
>>>       CharFrontend chr;
>>> @@ -42,6 +45,8 @@ struct SCLPConsole {
>>>       uint32_t iov_data_len;  /* length of byte stream in
>>> buffer             */
>>>       uint32_t iov_sclp_rest; /* length of byte stream not read via
>>> SCLP     */
>>>       bool notify;            /* qemu_notify_event() req'd if
>>> true           */
>>> +    bool resize;
>>> +    bool resize_init;
>>>   };
>>>   typedef struct SCLPConsole SCLPConsole;
>>>   
>>> @@ -49,6 +54,12 @@ typedef struct SCLPConsole SCLPConsole;
>>>   DECLARE_INSTANCE_CHECKER(SCLPConsole, SCLP_CONSOLE,
>>>                            TYPE_SCLP_CONSOLE)
>>>   
>>> +typedef struct SCLPConsoleResizeData {
>>> +    uint8_t type;
>>> +    uint16_t rows;
>>> +    uint16_t cols;
>>> +} QEMU_PACKED SCLPConsoleResizeData;
>>> +
>>>   /* character layer call-back functions */
>>>   
>>>   /* Return number of bytes that fit into iov buffer */
>>> @@ -81,6 +92,29 @@ static void chr_read(void *opaque, const uint8_t
>>> *buf, int size)
>>>       sclp_service_interrupt(0);
>>>   }
>>>   
>>> +static void chr_event(void *opaque, QEMUChrEvent event)
>>> +{
>>> +    SCLPConsole *scon = opaque;
>>> +
>>> +    assert(scon);
>>> +
>>> +    switch (event) {
>>> +    case CHR_EVENT_RESIZE:
>>> +    case CHR_EVENT_MUX_IN:
>>> +        scon->resize = true;
>>> +        scon->resize_init = false;
>>> +        scon->event.event_pending = true;
>>> +        sclp_service_interrupt(0);
>>> +        break;
>>> +    case CHR_EVENT_BREAK:
>>> +    case CHR_EVENT_OPENED:
>>> +    case CHR_EVENT_MUX_OUT:
>>> +    case CHR_EVENT_CLOSED:
>>> +        /* ignore */
>>> +        break;
>>> +    }
>>> +}
>>> +
>>>   /* functions to be called by event facility */
>>>   
>>>   static bool can_handle_event(uint8_t type)
>>> @@ -104,10 +138,37 @@ static sccb_mask_t receive_mask(void)
>>>   static void get_console_data(SCLPEvent *event, uint8_t *buf,
>>> size_t *size,
>>>                                int avail)
>>>   {
>>> +    SCLPConsoleResizeData resize_data;
>>>       SCLPConsole *cons = SCLP_CONSOLE(event);
>>> +    uint16_t rows, cols;
>>> +
>>> +    if (cons->resize) {
>>> +        if (avail < sizeof(resize_data)) {
>>> +            *size = 0;
>>> +            return;
>>> +        }
>>>   
>>> -    /* first byte is hex 0 saying an ascii string follows */
>>> -    *buf++ = '\0';
>>> +        qemu_chr_fe_get_winsize(&cons->chr, &cols, &rows);
>>> +
>>> +        if (cons->resize_init && cols == 0 && rows == 0) {
>>> +            *size = 0;
>>> +        } else {
>>> +            resize_data.type = SCLP_CONSOLE_EVENT_TYPE_RESIZE;
>>> +            resize_data.rows = cpu_to_be16(rows);
>>> +            resize_data.cols = cpu_to_be16(cols);
>>> +
>>> +            memcpy(buf, &resize_data, sizeof(resize_data));
>>> +            *size = sizeof(resize_data);
>>> +        }
>>> +
>>> +        cons->resize = false;
>>> +        cons->resize_init = false;
>>> +        event->event_pending = cons->iov_sclp_rest != 0;
>>> +
>>> +        return;
>>> +    }
>>> +
>>> +    *buf++ = SCLP_CONSOLE_EVENT_TYPE_DATA;
>>>       avail--;
>>>       /* if all data fit into provided SCLP buffer */
>>>       if (avail >= cons->iov_sclp_rest) {
>>> @@ -150,6 +211,9 @@ static int read_event_data(SCLPEvent *event,
>>> EventBufferHeader *evt_buf_hdr,
>>>       to = (uint8_t *)&acd->data;
>>>       avail = *slen - sizeof(ASCIIConsoleData);
>>>       get_console_data(event, to, &src_len, avail);
>>> +    if (src_len == 0) {
>>> +        return 0;
>>> +    }
>>>       acd->ebh.length = cpu_to_be16(sizeof(ASCIIConsoleData) +
>>> src_len);
>>>       acd->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
>>> @@ -233,22 +297,26 @@ static int console_init(SCLPEvent *event)
>>>       }
>>>       console_available = true;
>>>       qemu_chr_fe_set_handlers(&scon->chr, chr_can_read,
>>> -                             chr_read, NULL, NULL, scon, NULL,
>>> true);
>>> +                             chr_read, chr_event, NULL, scon,
>>> NULL, true);
>>>   
>>>       return 0;
>>>   }
>>>   
>>>   static void console_reset(DeviceState *dev)
>>>   {
>>> -   SCLPEvent *event = SCLP_EVENT(dev);
>>> -   SCLPConsole *scon = SCLP_CONSOLE(event);
>>> -
>>> -   event->event_pending = false;
>>> -   scon->iov_sclp = 0;
>>> -   scon->iov_bs = 0;
>>> -   scon->iov_data_len = 0;
>>> -   scon->iov_sclp_rest = 0;
>>> -   scon->notify = false;
>>> +    SCLPEvent *event = SCLP_EVENT(dev);
>>> +    SCLPConsole *scon = SCLP_CONSOLE(event);
>>> +
>>> +    scon->iov_sclp = 0;
>>> +    scon->iov_bs = 0;
>>> +    scon->iov_data_len = 0;
>>> +    scon->iov_sclp_rest = 0;
>>> +    scon->notify = false;
>>> +
>>> +    /* the guest defaults its terminal size on reset, announce the
>>> real one */
>>> +    scon->resize = true;
>>> +    scon->resize_init = true;
>>> +    event->event_pending = true;
>>>   }
>>
>> This is a style fix, included in a functional patch. I suppose it is 
>> probably borderline, but it might be best to put this in its own
>> patch.
> 
> I thought about that, but concluded that a 6-line indentation commit
> would be too small to warrant its own patch. If you'd prefer it to be
> split I could also send it as a seperate patch.

I would prefer it in its own patch if possible as a preparatory commit
prior to this one.  It keeps git blame easier to read if we have issues
later and are trying to sort out where the functional changes occurred
vs what was just whitespace cleanup.

With the whitespace changes broken out:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


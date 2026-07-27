Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE33C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woRWj-0007wu-Ac; Mon, 27 Jul 2026 16:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1woRWg-0007wN-5m; Mon, 27 Jul 2026 16:02:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1woRWd-0006Qj-Ue; Mon, 27 Jul 2026 16:02:13 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RIHtAN1095227; Mon, 27 Jul 2026 20:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=C0h9zZ
 aZuoB04PaHFEBIghdeJQVm9PANP9fsNYVbNW0=; b=c0YcJDpZAEXU+LLUS2fbC9
 YBGKRb3YkKgLCitAECmdwwaw6MuX/SoXQL25bhQz7RpMBbhIw/AdNWyg4nfvtr0O
 eJJiymvGVQVtT5qBfi+PQst4jZCEq03p6CMU/98c2QZfJFgso8ZZtoa4/QknN9Zg
 eARoWMw6G2kt52ZcxWAy/Dy3WOHslLt0w73wZKvLl2YEXh8SgEHD6ydpnUP5YsmO
 ykT26EmjhWDFmpndgC+kI20ihYa0BrB7Q9+cU7otlEezZRkW2ZuQ9nVtEsrRiQ0k
 NPGdoFoSedRF8X+//gsgCQdHhJhYp6ZvTIsooc3cPLZ5qeqT63Oek6YIghP0Nvww
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc9u66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 20:02:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RJuIMv003105;
 Mon, 27 Jul 2026 20:02:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh6rne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 20:02:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RK24h910158812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 20:02:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED4275805A;
 Mon, 27 Jul 2026 20:02:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D22F358052;
 Mon, 27 Jul 2026 20:02:02 +0000 (GMT)
Received: from [9.61.67.177] (unknown [9.61.67.177])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 20:02:02 +0000 (GMT)
Message-ID: <4638e503-cb15-4b22-9333-03dc7430b6a8@linux.ibm.com>
Date: Mon, 27 Jul 2026 16:02:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] pc-bios/s390-ccw: bound zipl menu strlen and replace
 VLA in zipl_print_entry
To: Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
 <20260727115052.24289-6-borntraeger@linux.ibm.com>
 <91d5f2b9-2b32-4b62-95c7-4526261d1326@linux.ibm.com>
 <1b3104c9-fd26-4730-a148-a5e5f13beed9@linux.ibm.com>
 <2b6fe910-9b7d-4174-bdc5-ae5fb12c327c@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <2b6fe910-9b7d-4174-bdc5-ae5fb12c327c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BGQJoBvSdLEq6mZf0pia7NBkqewu81gq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE3OCBTYWx0ZWRfX/HhIi9dVGd7R
 L40OgGSjgg6DsWN9m/1PVNMEKs3naCgclTDtYDj3BDlum9wjk8Cu8a+QPay/3poTDBeWUfnzqvC
 oEGdejEImX1FBmtMY7HS8No+iFwVJ4/KWn+zB+SrlUGq0ZN3LGj1mcmVrF4/rgCaIezIlZM+Ytz
 eNCuAvaN/D7Gb/KVayMt8FY57vvJDgqYEYIOKxPN6zpZMV69blBo+Nhe4s+ZxpXNRNqGwH7X+kG
 3XnLyW6xRt57rzkAx4z25wN4CsLaYSAA88BuF383Arzy3f1kWPHX1ATxYr55+GKw5wUisi5vydd
 /FQGfAwWJPGiW4CdUYAhIWXAyap8hKOxbrUm9a8c4y1EFzgzH+eOZUiJTulLCGCrW81ZBNVAiPA
 7hGM/eWe+/wdGpDFyLJCBpi4eKuhC/4pIf99rg0/otK0OPL/3JUUZI9h86w+qtJg5InDSjbpizt
 fK5M8bEB4mha9T2bN0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE3OCBTYWx0ZWRfX4qJawVOpZAxi
 JVLjraMOrKCBAOg9qJsTuMpwa5JDk2rwbutfxk6qSw3r+WHt2phGTLpdsDK7meZK9epTfVgBcPM
 +Dl7fdaSbIavHxWYBM6rSy5KWfcmih0=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a67b93e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=vZ7KMPaVvti69QIvvswA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BGQJoBvSdLEq6mZf0pia7NBkqewu81gq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270178
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 7/27/26 1:32 PM, Joshua Daley wrote:
> On 7/27/2026 12:02 PM, Matthew Rosato wrote:
>> On 7/27/26 11:51 AM, Matthew Rosato wrote:
>>> On 7/27/26 7:50 AM, Christian Borntraeger wrote:
>>>> From: Joshua Daley <jdaley@linux.ibm.com>
>>>>
>>>> menu_get_zipl_boot_index() calls strlen() on a pointer into the middle
>>>> of _s2 with no upper bound, so a stage-2 image whose blocks contain no
>>>> NUL bytes causes strlen() to walk beyond _s2. The resulting length
>>>> is then used to size a stack VLA in zipl_print_entry(), risking a stack
>>>> overflow.
>>>>
>>>> Fix by:
>>>>
>>>> - Implementing strnlen(), a bounded version of strlen().
>>>>
>>>> - Adding a menu_data_end parameter to menu_get_zipl_boot_index() and
>>>>    replacing both strlen() calls with strnlen() bounded by the 
>>>> remaining
>>>>    buffer space. The loop guard also checks that the pointer has not
>>>>    reached menu_data_end. For robustness, the function returns 0
>>>>    (boot default) if somehow menu_data is initially >= menu_data_end.
>>>>
>>>> - Replacing the VLA char buf[len + 2] in zipl_print_entry() with a 
>>>> fixed
>>>>    ZIPL_ENTRY_MAX + 2 (82-byte) buffer and truncating len before use.
>>>>
>>>> - Passing s2_end (_s2 + sizeof(_s2)) as menu_data_end at the one call
>>>>    site in eckd_get_boot_menu_index(), so the bound is exactly the 
>>>> end of
>>>>    the buffer.
>>>>
>>>> Fixes: f7178910845a ("s390-ccw: print zipl boot menu")
>>>> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
>>>> ---
>>>>   pc-bios/s390-ccw/bootmap.c  |  4 +++-
>>>>   pc-bios/s390-ccw/helper.h   | 10 ++++++++++
>>>>   pc-bios/s390-ccw/menu.c     | 23 ++++++++++++++++++-----
>>>>   pc-bios/s390-ccw/s390-ccw.h |  2 +-
>>>>   4 files changed, 32 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>>>> index ed6e8cbbc7..81512265ce 100644
>>>> --- a/pc-bios/s390-ccw/bootmap.c
>>>> +++ b/pc-bios/s390-ccw/bootmap.c
>>>> @@ -61,6 +61,7 @@ static uint8_t _s2[MAX_SECTOR_SIZE * 3] 
>>>> __attribute__((__aligned__(PAGE_SIZE)));
>>>>   static void *s2_prev_blk = _s2;
>>>>   static void *s2_cur_blk = _s2 + MAX_SECTOR_SIZE;
>>>>   static void *s2_next_blk = _s2 + MAX_SECTOR_SIZE * 2;
>>>> +static void *s2_end = _s2 + sizeof(_s2);
>>>>   static inline int verify_boot_info(BootInfo *bip)
>>>>   {
>>>> @@ -308,7 +309,8 @@ static int 
>>>> eckd_get_boot_menu_index(block_number_t s1b_block_nr)
>>>>                   }
>>>>               }
>>>> -            return menu_get_zipl_boot_index(s2_cur_blk + 
>>>> banner_offset);
>>>> +            return menu_get_zipl_boot_index(s2_cur_blk + 
>>>> banner_offset,
>>>> +                                            s2_end);
>>>>           }
>>>>           prev_block_nr = cur_block_nr;
>>>> diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
>>>> index 8e3dfcb6d6..d9b7da444a 100644
>>>> --- a/pc-bios/s390-ccw/helper.h
>>>> +++ b/pc-bios/s390-ccw/helper.h
>>>> @@ -45,4 +45,14 @@ static inline void sleep(unsigned int seconds)
>>>>       }
>>>>   }
>>>> +static inline size_t strnlen(const char *s, size_t maxlen)
>>>> +{
>>>> +    size_t len = 0;
>>>> +
>>>> +    while (len < maxlen && s[len]) {
>>>> +        len++;
>>>> +    }
>>>> +    return len;
>>>> +}
>>>> +
>>>>   #endif
>>>> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
>>>> index b6a9a56d46..af96a83de9 100644
>>>> --- a/pc-bios/s390-ccw/menu.c
>>>> +++ b/pc-bios/s390-ccw/menu.c
>>>> @@ -16,6 +16,7 @@
>>>>   #include "s390-ccw.h"
>>>>   #include "sclp.h"
>>>>   #include "s390-time.h"
>>>> +#include "helper.h"
>>>>   #define KEYCODE_NO_INP '\0'
>>>>   #define KEYCODE_ESCAPE '\033'
>>>> @@ -26,6 +27,9 @@
>>>>   #define ZIPL_TIMEOUT_OFFSET 138
>>>>   #define ZIPL_FLAG_OFFSET    140
>>>> +/* Max printable chars for a zipl boot menu entry */
>>>> +#define ZIPL_ENTRY_MAX 80
>>>> +
>>>>   #define TOD_CLOCK_MILLISECOND   0x3e8000
>>>>   #define LOW_CORE_EXTERNAL_INT_ADDR   0x86
>>>> @@ -179,9 +183,13 @@ int menu_get_boot_index(bool *valid_entries)
>>>>   /* Returns the entry number that was printed, or -1 on invalid 
>>>> entry */
>>>>   static int zipl_print_entry(const char *data, size_t len)
>>>>   {
>>>> -    char buf[len + 2];
>>>> +    char buf[ZIPL_ENTRY_MAX + 2];
>>>>       const char *p;
>>>> +    if (len > ZIPL_ENTRY_MAX) {
>>>> +        len = ZIPL_ENTRY_MAX;
>>>> +    }
>>>> +
>>>>       ebcdic_to_ascii(data, buf, len);
>>>>       buf[len] = '\n';
>>>>       buf[len + 1] = '\0';
>>>> @@ -196,7 +204,7 @@ static int zipl_print_entry(const char *data, 
>>>> size_t len)
>>>>       return atoi(p);
>>>>   }
>>>> -int menu_get_zipl_boot_index(const char *menu_data)
>>>> +int menu_get_zipl_boot_index(const char *menu_data, const char 
>>>> *menu_data_end)
>>>>   {
>>>>       size_t len;
>>>>       int entry;
>>>> @@ -212,13 +220,18 @@ int menu_get_zipl_boot_index(const char 
>>>> *menu_data)
>>>>           timeout = zipl_timeout * 1000;
>>>>       }
>>>> +    if (menu_data >= menu_data_end) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>>       /* Print banner */
>>>>       puts("s390-ccw zIPL Boot Menu\n");
>>>> -    menu_data += strlen(menu_data) + 1;
>>>> +    len = strnlen(menu_data, menu_data_end - menu_data);
>>>> +    menu_data += len + 1;
>>>
>>> If we've already hit menu_data_end at this point should we bail rather
>>> than skipping the while() loop and immediately proceeding into
>>> menu_get_boot_index(valid_entries); with an all-false array?
>>>
>>> AFAICT the current implementation would print no options and wait for
>>> user input.
> Right.
> 
>>>
>>> e.g. something like
>>>
>>>      if (menu_data >= menu_data_end)
>>>          return 0;
>>
>> Hm, well, my proposal would still print the s390-ccw zIPL Boot Menu\n
>> message but then quietly use the default boot option.
>>
>> Maybe it would be better to move the
>> +    len = strnlen(menu_data, menu_data_end - menu_data);
>> +    menu_data += len + 1;
>>
>> up a few lines before the puts and combine it with the menu_data >=
>> menu_data_end check you already added?  That way in both cases we
>> silently take the default option without printing anything?
>>
> 
> I agree with your assessment. Need another check after the "banner skip" 
> and
> before the puts().
> 
> 
> if (menu_data >= menu_data_end) {
>      return 0; /* Boot default */
> }
> 
> /* Skip banner */
> len = strnlen(menu_data, menu_data_end - menu_data);
> menu_data += len + 1;
> 
> if (menu_data >= menu_data_end || !(*menu_data)) {
>      return 0; /* No entries, boot default */
> }
> 
> /* Print banner */
> puts("s390-ccw zIPL Boot Menu\n");
> 
> /* Print entries */
> while (menu_data < menu_data_end && *menu_data) {
> ...

@Joshua, can you send a v2 of just this patch? I'll pick up the first 
four with the little edits.

> 
>>
>>>
>>>>       /* Print entries */
>>>> -    while (*menu_data) {
>>>> -        len = strlen(menu_data);
>>>> +    while (menu_data < menu_data_end && *menu_data) {
>>>> +        len = strnlen(menu_data, menu_data_end - menu_data);
>>>>           entry = zipl_print_entry(menu_data, len);
>>>>           menu_data += len + 1;
>>>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>>>> index 1e1f71775e..f6030a6071 100644
>>>> --- a/pc-bios/s390-ccw/s390-ccw.h
>>>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>>>> @@ -76,7 +76,7 @@ void jump_to_low_kernel(void);
>>>>   /* menu.c */
>>>>   void menu_set_parms(uint8_t boot_menu_flag, uint32_t 
>>>> boot_menu_timeout);
>>>> -int menu_get_zipl_boot_index(const char *menu_data);
>>>> +int menu_get_zipl_boot_index(const char *menu_data, const char 
>>>> *menu_data_end);
>>>>   bool menu_is_enabled_zipl(void);
>>>>   int menu_get_enum_boot_index(bool *valid_entries);
>>>>   bool menu_is_enabled_enum(void);
>>>
>>
> 
> 



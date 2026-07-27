Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B01EC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNny-0006ih-Mj; Mon, 27 Jul 2026 12:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woNnL-0006Ua-7d; Mon, 27 Jul 2026 12:03:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1woNnD-0006yl-6z; Mon, 27 Jul 2026 12:03:06 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDncPJ2412244; Mon, 27 Jul 2026 16:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AdkaPC
 nNGQhnB8WOXMFP9LDW+12Y2UdqZqnDO8Et9O8=; b=fNQ/9v+vZdzTORejVzcs92
 wgGB0ISZlBi9qjxPq7F0AT6w7HhZumMW0azaV6m9evgxaSMLzFoC5eSo48AZlIVR
 Kd0xQkQpGn3BmK1XLsvS6GEB1tccl0D1wC+JjHfYLDRKzMDKDexZGjfzSG8qkng5
 Ki65yKvQD5KkQItoy4Nw6x7oyVAvUR2i6Ix3z73dYwoupM/paz6m6tr1HJ6sVEuN
 FPoUyX3FC36nYAgMKsY2lgRvt/jzY1pmTcq66Z6zhwtrXOnuL4v1fC+Y3zan7ZN1
 ALMOZ+DjdYPFYjS7J9oRkCQAHp2HADLFywZ/V/2IIi6CKszanyQjvDAqzLUuBnmQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcrffm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 16:02:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RFuJtL010583;
 Mon, 27 Jul 2026 16:02:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvx59d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 16:02:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66RG2ui353543240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 16:02:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CB3F58056;
 Mon, 27 Jul 2026 16:02:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0266A5805A;
 Mon, 27 Jul 2026 16:02:55 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 16:02:54 +0000 (GMT)
Message-ID: <1b3104c9-fd26-4730-a148-a5e5f13beed9@linux.ibm.com>
Date: Mon, 27 Jul 2026 12:02:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] pc-bios/s390-ccw: bound zipl menu strlen and replace
 VLA in zipl_print_entry
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
 <20260727115052.24289-6-borntraeger@linux.ibm.com>
 <91d5f2b9-2b32-4b62-95c7-4526261d1326@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <91d5f2b9-2b32-4b62-95c7-4526261d1326@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rm8U6wBwElV9yBev13A_wzDHcLiZQkao
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX3CRGKuGCORgx
 eIzV7HA0wagkdgRV1MzoUNScaQnt8YJDsOl4L+sv1MKIx6NzJvkC71uSsltzRCG6bhLihwuPzB2
 Zvv+o8QIsTBk/Te/yzGP2uP+Nm7Yhrc=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a678131 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=kSzweSy2UGUZ8-KAv-gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfXwonCr/nhFdtn
 TYNoJrqMFuDTPrgajoUjSDfuCfWrzsOs2GSxidoz4/yPqvqBXAD5vb4QLkPjjn8uyNvB690GEkV
 XtGPOT+W6H9S2kl+yhfFNCmCeNRjjBTqFeN1vaLn4boDOC8GW1H+HNEst++glHDzUR2DXP0JLdb
 rRZ8t6Aro7MwAsBd0DeyHceEfWaC9YWaILNY6PyHb0ayybQo3u80IIbr3DQPZxcbp/Uf8Hb/ody
 HO5lfHRfD2Xi6YWDg2Wf9yr1r9FPKplTA3CXCDY0kioz5mJ4L8OXF/d7eRGr7Gn/IFizwfS5c9X
 Bc8guktXNHR8RKqaGY/1+g7jTYMxqnjdn/79MqGZdFpAnCKiQBf1Pfro5rGZI28wXwAyyq9YVhw
 A9py5ZDiQtHCgqV3YHx7qZMjAjTPe9LG0ha/l03XrvjcLu65ga8ocROH+3TaESgFwvypo0ylyCW
 o2MY3xsAiKhHNpBhTKQ==
X-Proofpoint-GUID: Rm8U6wBwElV9yBev13A_wzDHcLiZQkao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270148
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 7/27/26 11:51 AM, Matthew Rosato wrote:
> On 7/27/26 7:50 AM, Christian Borntraeger wrote:
>> From: Joshua Daley <jdaley@linux.ibm.com>
>>
>> menu_get_zipl_boot_index() calls strlen() on a pointer into the middle
>> of _s2 with no upper bound, so a stage-2 image whose blocks contain no
>> NUL bytes causes strlen() to walk beyond _s2. The resulting length
>> is then used to size a stack VLA in zipl_print_entry(), risking a stack
>> overflow.
>>
>> Fix by:
>>
>> - Implementing strnlen(), a bounded version of strlen().
>>
>> - Adding a menu_data_end parameter to menu_get_zipl_boot_index() and
>>   replacing both strlen() calls with strnlen() bounded by the remaining
>>   buffer space. The loop guard also checks that the pointer has not
>>   reached menu_data_end. For robustness, the function returns 0
>>   (boot default) if somehow menu_data is initially >= menu_data_end.
>>
>> - Replacing the VLA char buf[len + 2] in zipl_print_entry() with a fixed
>>   ZIPL_ENTRY_MAX + 2 (82-byte) buffer and truncating len before use.
>>
>> - Passing s2_end (_s2 + sizeof(_s2)) as menu_data_end at the one call
>>   site in eckd_get_boot_menu_index(), so the bound is exactly the end of
>>   the buffer.
>>
>> Fixes: f7178910845a ("s390-ccw: print zipl boot menu")
>> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/bootmap.c  |  4 +++-
>>  pc-bios/s390-ccw/helper.h   | 10 ++++++++++
>>  pc-bios/s390-ccw/menu.c     | 23 ++++++++++++++++++-----
>>  pc-bios/s390-ccw/s390-ccw.h |  2 +-
>>  4 files changed, 32 insertions(+), 7 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
>> index ed6e8cbbc7..81512265ce 100644
>> --- a/pc-bios/s390-ccw/bootmap.c
>> +++ b/pc-bios/s390-ccw/bootmap.c
>> @@ -61,6 +61,7 @@ static uint8_t _s2[MAX_SECTOR_SIZE * 3] __attribute__((__aligned__(PAGE_SIZE)));
>>  static void *s2_prev_blk = _s2;
>>  static void *s2_cur_blk = _s2 + MAX_SECTOR_SIZE;
>>  static void *s2_next_blk = _s2 + MAX_SECTOR_SIZE * 2;
>> +static void *s2_end = _s2 + sizeof(_s2);
>>  
>>  static inline int verify_boot_info(BootInfo *bip)
>>  {
>> @@ -308,7 +309,8 @@ static int eckd_get_boot_menu_index(block_number_t s1b_block_nr)
>>                  }
>>              }
>>  
>> -            return menu_get_zipl_boot_index(s2_cur_blk + banner_offset);
>> +            return menu_get_zipl_boot_index(s2_cur_blk + banner_offset,
>> +                                            s2_end);
>>          }
>>  
>>          prev_block_nr = cur_block_nr;
>> diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
>> index 8e3dfcb6d6..d9b7da444a 100644
>> --- a/pc-bios/s390-ccw/helper.h
>> +++ b/pc-bios/s390-ccw/helper.h
>> @@ -45,4 +45,14 @@ static inline void sleep(unsigned int seconds)
>>      }
>>  }
>>  
>> +static inline size_t strnlen(const char *s, size_t maxlen)
>> +{
>> +    size_t len = 0;
>> +
>> +    while (len < maxlen && s[len]) {
>> +        len++;
>> +    }
>> +    return len;
>> +}
>> +
>>  #endif
>> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
>> index b6a9a56d46..af96a83de9 100644
>> --- a/pc-bios/s390-ccw/menu.c
>> +++ b/pc-bios/s390-ccw/menu.c
>> @@ -16,6 +16,7 @@
>>  #include "s390-ccw.h"
>>  #include "sclp.h"
>>  #include "s390-time.h"
>> +#include "helper.h"
>>  
>>  #define KEYCODE_NO_INP '\0'
>>  #define KEYCODE_ESCAPE '\033'
>> @@ -26,6 +27,9 @@
>>  #define ZIPL_TIMEOUT_OFFSET 138
>>  #define ZIPL_FLAG_OFFSET    140
>>  
>> +/* Max printable chars for a zipl boot menu entry */
>> +#define ZIPL_ENTRY_MAX 80
>> +
>>  #define TOD_CLOCK_MILLISECOND   0x3e8000
>>  
>>  #define LOW_CORE_EXTERNAL_INT_ADDR   0x86
>> @@ -179,9 +183,13 @@ int menu_get_boot_index(bool *valid_entries)
>>  /* Returns the entry number that was printed, or -1 on invalid entry */
>>  static int zipl_print_entry(const char *data, size_t len)
>>  {
>> -    char buf[len + 2];
>> +    char buf[ZIPL_ENTRY_MAX + 2];
>>      const char *p;
>>  
>> +    if (len > ZIPL_ENTRY_MAX) {
>> +        len = ZIPL_ENTRY_MAX;
>> +    }
>> +
>>      ebcdic_to_ascii(data, buf, len);
>>      buf[len] = '\n';
>>      buf[len + 1] = '\0';
>> @@ -196,7 +204,7 @@ static int zipl_print_entry(const char *data, size_t len)
>>      return atoi(p);
>>  }
>>  
>> -int menu_get_zipl_boot_index(const char *menu_data)
>> +int menu_get_zipl_boot_index(const char *menu_data, const char *menu_data_end)
>>  {
>>      size_t len;
>>      int entry;
>> @@ -212,13 +220,18 @@ int menu_get_zipl_boot_index(const char *menu_data)
>>          timeout = zipl_timeout * 1000;
>>      }
>>  
>> +    if (menu_data >= menu_data_end) {
>> +        return 0;
>> +    }
>> +
>>      /* Print banner */
>>      puts("s390-ccw zIPL Boot Menu\n");
>> -    menu_data += strlen(menu_data) + 1;
>> +    len = strnlen(menu_data, menu_data_end - menu_data);
>> +    menu_data += len + 1;
> 
> If we've already hit menu_data_end at this point should we bail rather
> than skipping the while() loop and immediately proceeding into
> menu_get_boot_index(valid_entries); with an all-false array?
> 
> AFAICT the current implementation would print no options and wait for
> user input.
> 
> e.g. something like
> 
>     if (menu_data >= menu_data_end)
>         return 0;

Hm, well, my proposal would still print the s390-ccw zIPL Boot Menu\n
message but then quietly use the default boot option.

Maybe it would be better to move the
+    len = strnlen(menu_data, menu_data_end - menu_data);
+    menu_data += len + 1;

up a few lines before the puts and combine it with the menu_data >=
menu_data_end check you already added?  That way in both cases we
silently take the default option without printing anything?


> 
>>  
>>      /* Print entries */
>> -    while (*menu_data) {
>> -        len = strlen(menu_data);
>> +    while (menu_data < menu_data_end && *menu_data) {
>> +        len = strnlen(menu_data, menu_data_end - menu_data);
>>          entry = zipl_print_entry(menu_data, len);
>>          menu_data += len + 1;
>>  
>> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
>> index 1e1f71775e..f6030a6071 100644
>> --- a/pc-bios/s390-ccw/s390-ccw.h
>> +++ b/pc-bios/s390-ccw/s390-ccw.h
>> @@ -76,7 +76,7 @@ void jump_to_low_kernel(void);
>>  
>>  /* menu.c */
>>  void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
>> -int menu_get_zipl_boot_index(const char *menu_data);
>> +int menu_get_zipl_boot_index(const char *menu_data, const char *menu_data_end);
>>  bool menu_is_enabled_zipl(void);
>>  int menu_get_enum_boot_index(bool *valid_entries);
>>  bool menu_is_enabled_enum(void);
> 



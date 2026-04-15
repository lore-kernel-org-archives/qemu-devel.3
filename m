Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FE6F43854
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD3Ep-0002ce-9i; Wed, 15 Apr 2026 12:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wD3En-0002c5-7F; Wed, 15 Apr 2026 12:37:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wD3El-0002tZ-Ik; Wed, 15 Apr 2026 12:37:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63F3K5F71860578; Wed, 15 Apr 2026 16:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=n0snwV
 AWDggHfhXr2YeMr4nfkV61EEfx5BSuuoBw/ts=; b=kZw6q8Mo8CPGX9U9Vk45Du
 5Y8rxpn4GdOdyNgOhyazqxaUZpbU7mYRp+DUKXx3kgtk8uTa2l5334molrWfGx4e
 Q6Yd2tRT1J57EEg8/qn3WlK4TXBUXObaG1GfTP2Hta0Y0LlDzTgLcRrykRw1WCP2
 aWNDw9gScnztqiZa7Yuaa8zDjJ+mmyr8ZVm38DhRfwucNr7XKPXwbltRMt12yAX+
 JuicDvchmVo9nj57kfcDgGQGXaOdwrRhDZRbaGsrOnsMw3Gp9hhdMYXk3GDefBWH
 G9wXoBVZkiFiyaeteUBKKVpQU47EqN5q9mBTv9JHAcBcXtUe5G3Jf2PRZMuuWoaw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pgjvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 16:36:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FCICFH031138;
 Wed, 15 Apr 2026 16:36:58 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10yf5dm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 16:36:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63FGavZa28443166
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Apr 2026 16:36:57 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5755558056;
 Wed, 15 Apr 2026 16:36:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30ED858052;
 Wed, 15 Apr 2026 16:36:56 +0000 (GMT)
Received: from [9.61.102.229] (unknown [9.61.102.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Apr 2026 16:36:56 +0000 (GMT)
Message-ID: <d2aff9be-2597-4d58-9185-0c805114669a@linux.ibm.com>
Date: Wed, 15 Apr 2026 12:36:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/30] pc-bios/s390-ccw: Add signed component address
 overlap checks
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-21-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260402221453.1602899-21-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aKRoTsZa4K1EExtf9yUsteM2opv8msrD
X-Proofpoint-ORIG-GUID: aKRoTsZa4K1EExtf9yUsteM2opv8msrD
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69dfbeab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ABqtuHcFZ0KkfVKGhysA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE1MSBTYWx0ZWRfX8q3sqKujXH5Y
 W+/s8bE9TWHQIHhmOCCtROpUwBeEo5GVKGbPGO1lup/bgZCmikc7giZD7P8kjwiSsutQT08+NZy
 dn8mmQ9dM1FIK0xqklo8dIRZyTDO8NjXL6kwyVwkpXXdmQAqN8W2HWgapnJOSTxfZpREbbkpwTY
 +7ehiYyUvHhfHkhAPWeiD8W0ub8Vb490w0NPcayoGqDXe3aG3aaYE4TuU2vqUAJI5yNqEqFUm0P
 /a8g616+Kv7daEstC9XXyBX8bs5tDk4IrTSrGxP6tdmeZZB/xo8BO1wFCpB36evArL2flXMqRtP
 GelgJGlcWTt5IM1RDJ5gCYI2q8hmGzzbveI6EMfwBxPNbXBQ8RhaULMj8OVNOGhoY0I3CYkysl2
 2TnAkd3iruJpltbEMBs9HC98eKlsNf+W0KxthDycPk26hiriWvqJPiZeG5kqKBaKM7Yp3xLrXc6
 Z1zBKUQgYAI6G8HQlQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150151
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/2/26 6:14 PM, Zhuoying Cai wrote:
> Add address range tracking and overlap checks to ensure that no
> component overlaps with a signed component during secure IPL.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/secure-ipl.c | 58 ++++++++++++++++++++++++++++++++---
>   pc-bios/s390-ccw/secure-ipl.h | 15 +++++++++
>   2 files changed, 69 insertions(+), 4 deletions(-)
>
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index b66ca9ca7e..d2079e19bc 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -211,6 +211,49 @@ static void init_lists(IplDeviceComponentList *comp_list,
>       cert_list->ipl_info_header.len = sizeof(cert_list->ipl_info_header);
>   }
>   
> +static bool is_comp_overlap(SecureIplCompAddrRangeList *range_list,
> +                            SecureIplCompEntryInfo comp_entry_info)
> +{
> +    uint64_t start_addr;
> +    uint64_t end_addr;
> +
> +    start_addr = comp_entry_info.addr;
> +    end_addr = comp_entry_info.addr + comp_entry_info.len;
> +
> +    /*
> +     * Check component's address range does not overlap with any
> +     * signed component's address range.
> +     */
> +    for (int i = 0; i < range_list->index; i++) {
> +        if ((range_list->comp_addr_range[i].start_addr < end_addr &&
> +            start_addr < range_list->comp_addr_range[i].end_addr) &&
> +            range_list->comp_addr_range[i].is_signed) {
Check 'is_signed' first so that we don't bother with unsigned components.

> +            return true;
> +       }
> +    }
> +    return false;
> +}
> +
> +static void comp_addr_range_add(SecureIplCompAddrRangeList *range_list,
> +                                SecureIplCompEntryInfo comp_entry_info,
> +                                bool is_signed)
> +{
> +    uint64_t start_addr;
> +    uint64_t end_addr;
> +
> +    start_addr = comp_entry_info.addr;
> +    end_addr = comp_entry_info.addr + comp_entry_info.len;
> +
> +    if (range_list->index >= MAX_CERTIFICATES) {
> +        zipl_secure_handle("Component address range update failed due to out-of-range"
> +                           " index; Overlapping validation cannot be guaranteed");
> +    }
This check can be done before calling.  We should break early and stop 
calling this function once the max is reached.

> +
> +    range_list->comp_addr_range[range_list->index].is_signed = is_signed;
> +    range_list->comp_addr_range[range_list->index].start_addr = start_addr;
> +    range_list->comp_addr_range[range_list->index].end_addr = end_addr;
> +}
> +
>   static int zipl_load_signature(ComponentEntry *entry, uint64_t sig_sec)
>   {
>       if (zipl_load_segment(entry, sig_sec) < 0) {
> @@ -253,6 +296,7 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>        * exists for the certificate).
>        */
>       int cert_list_table[MAX_CERTIFICATES] = { [0 ... MAX_CERTIFICATES - 1] = -1 };
> +    SecureIplCompAddrRangeList range_list = { 0 };
>       int signed_count = 0;
>   
>       if (!secure_ipl_supported()) {
> @@ -282,14 +326,20 @@ int zipl_run_secure(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
>                   goto out;
>               }
>   
> -            if (!sig_len) {
> -                break;
> -            }
> -
>               comp_entry_info = (SecureIplCompEntryInfo){ 0 };
>               comp_entry_info.addr = comp_addr;
>               comp_entry_info.len = (uint64_t)comp_len;
>   
> +            if (is_comp_overlap(&range_list, comp_entry_info)) {
> +                zipl_secure_handle("Component addresses overlap");
> +            }
> +            comp_addr_range_add(&range_list, comp_entry_info, !!sig_len);
> +            range_list.index += 1;
> +
> +            if (!sig_len) {
> +                break;
> +            }
> +
>               verified = verify_signature(comp_entry_info,
>                                           sig_len, (uint64_t)sig,
>                                           &cert_len, &cert_table_idx);
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> index 6d65cd5596..c625ac2e3a 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -24,6 +24,21 @@ typedef struct SecureIplCompEntryInfo {
>       uint8_t  flags;
>   } SecureIplCompEntryInfo;
>   
> +typedef struct SecureIplCompAddrRange {
> +    bool is_signed;
> +    uint64_t start_addr;
> +    uint64_t end_addr;
> +} SecureIplCompAddrRange;
> +
> +/*
> + * Custom struct for managing a list of secure IPL component address ranges.
> + * Tracks up to MAX_CERTIFICATES address ranges with an index counter.
> + */
> +typedef struct SecureIplCompAddrRangeList {
> +    SecureIplCompAddrRange comp_addr_range[MAX_CERTIFICATES];
> +    int index;
> +} SecureIplCompAddrRangeList;
I don't think 'index' is the correct name for the variable. Something 
like 'num' would be better, since it is the total number of address 
ranges, right?

> +
>   static inline void zipl_secure_handle(const char *message)
>   {
>       switch (boot_mode) {

Regards,
Jared Rossi


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B22CCA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xErAM-0002VT-Se; Thu, 08 Oct 2026 12:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xErAL-0002VK-46
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:40:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xErAJ-0007xy-0p
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:40:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698EVPrY3121446
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 16:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 atQvSf63HFOiAWQC91uK+FUQTgIxyBfYL9sEYwZR+6k=; b=cg5E93aO3Hihopux
 aVNDOooSsxEVvc5xUHjYZBzxT8D/0Sk3+yuWwgnpXkchmVR0YpWpQNz8+BMHhyVK
 lMDtBdtZrTCvsElAEHtjf9nvOOxmS74Pnx/FM2uSkvcY5+FqAkvTwV4aYou2curD
 S3KKIYRIPk3/DXri0+KML8+R8jbN6Jgjjbyc1eGdEnhUwK05Cy/Cw2Qfdlls/p1J
 Bi7hcgNMsu4IMJYjJCIbP3bptYdKB+u6KOB9+zFhDqtu3FO93X83MX7aNVACzbxJ
 CnqlhUP/SVpZf700JwipmJ7j/4adaiUBWBskjIkPKTbgktY37I5j8k65wFfwCa8X
 rRv7Dw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2uwqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 16:40:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3535c27d880so319231eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791477616; x=1792082416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=atQvSf63HFOiAWQC91uK+FUQTgIxyBfYL9sEYwZR+6k=;
 b=Lcmb7ydg8JTJCyVMl8K3UHCebF50RHgSS8r3GDFpa6W4Vlp71Y8ia4cdN8AHY2nVql
 0wvc+dQu+IWEhh/wYcKiglIJZp/K8AXiQEQeJjjHaG4SdL1IdcMvLTMkZmCLiXNcdgym
 oLM/o4xDqfJevaPGD/rUbPhlOPZT7abx9mnSOoaoDvqucJ4iMItW3RZ32fHN8Y+ZoyFE
 sXWn0ACcarFxsCzEg5/FBXkInXPQFiafExa6in59jyJSJWm5FpXd2Le07o1GEtgmJrxs
 EaNGsBdoPTbRZp0VjLlvspeOYYZASwzzikCf1pfrgWPquqo0N7x958N7+s9onJbztW4N
 0zDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791477616; x=1792082416;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=atQvSf63HFOiAWQC91uK+FUQTgIxyBfYL9sEYwZR+6k=;
 b=Lil4OSPyQW9O/JVFOCN/rcNzvtLj1lF9GfGWH4Qh4IKzYgW1J1A+EjDLfTngMS8OF8
 fvMfUbvzKUWhvlyanBfq2f6pFZhjSzdtpwuQFWnVLveUtRR+UnjVmwQcppPlwnTZa8/Z
 IreKbdb4hqI6jP3HrEXKu7PDRR3np7YRtyVejbXye7VkgCVHqgY2S0EKa2idHsty3G6F
 GDZkOsjR6TANUfh0gOh00TdKgd6Sq+x03mbVhGPLEzv76JEm4PlkIdveZNnRKlTb2ZWI
 c2QiwdKP41LCoIOUmurkJNoQYcZ4jJzhofaXJYZGkZPe48eV6jjk3zUodV4813PmCgPJ
 ibKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzQwcP7qc4Yf83pAXTVmv95uAW0wYy3F2fMF2sREoM/N8EpzZDIGNUGGd+ujYGngY5jWde8t3ji8c+@nongnu.org
X-Gm-Message-State: AFq9FYIXxm2Lgf1Db2QzCffezoHHtYCRFlr28c+wV99AN7aaaF+rTlPY
 HrUn7gZZm7sE6G5rMRnFBXTe+gPRFZNlIMvv2x7WWY1tMV6j+Vj5ZDagd8nBHrQ+kobtHwHeDQH
 qvZXqN0VJkoY8CrbaMnwp3OB4r+SkTYNYkCSiPGseOQ4fIWo+Rx2zB6Ys6nZaq4b6Nw==
X-Gm-Gg: AYBFou3gpI5cVr9yPK9X7fhxR8VJ1v3j6mELtoPXbAHCWZ1xezt5nm0RRUuCX9FQSaE
 1rC8FWzLiNjpuEQtoB6gxUTqS4h0rzRc7ZTKHyFIeTd3HiCQtUtd4sXpiVJHCjh55g9iTg0hek7
 d9DKdSDHwav6QI5oPaGTXx3qPMLOQrk0P9Qwu8VYbrjTKhYXsqE4Orc7XQWkwIQ3FmwfvkJM7dm
 ZrIK8c4bbDDBnWNzTm9XLrPf41KmAMLcjJpdhsz1nMy66XRMUmKsg041gIfsNHu8BGgenOCDaaT
 gr4U4SX+EcfZOyqLX7ABMKgve0pUKqnbrAlfDyrhYV+2ZMaBDxnNwehmEp+LQu5lnmNO1lRm4J1
 dKh5LbyZwPUJmVjwmt/eOOfSBU5/JF4UPbVfAXUfhVWZHncNM8HL20B+ZIHpXoKSYYvdERQ==
X-Received: by 2002:a05:7301:1707:b0:34e:9923:e372 with SMTP id
 5a478bee46e88-3515de444d5mr6795926eec.29.1791477615641; 
 Thu, 08 Oct 2026 09:40:15 -0700 (PDT)
X-Received: by 2002:a05:7301:1707:b0:34e:9923:e372 with SMTP id
 5a478bee46e88-3515de444d5mr6795874eec.29.1791477614686; 
 Thu, 08 Oct 2026 09:40:14 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515b03da93sm15136929eec.29.2026.10.08.09.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 09:40:14 -0700 (PDT)
Message-ID: <2d7c2cdb-b5b9-41ed-9786-dd9b4876bdd8@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 09:40:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] contrib/plugins/bbv.c: Allow selecting ROI
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20261007-bbv-v1-2-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
 <4eec19e6-db40-4658-b5b3-bc342473cffd@oss.qualcomm.com>
 <f503ffbe-0900-4b8e-ae7b-dbfcc74eb5cc@rsg.ci.i.u-tokyo.ac.jp>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f503ffbe-0900-4b8e-ae7b-dbfcc74eb5cc@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AbMkjHXG c=1 sm=1 tr=0 ts=6ac7c771 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=7TEdcREvdylIeB0XKtUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: VnBnYtzY2Q89ndSOJZrabgbAOjaV2l6R
X-Proofpoint-ORIG-GUID: VnBnYtzY2Q89ndSOJZrabgbAOjaV2l6R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2NiBTYWx0ZWRfX6kdqvN6xZYL/
 0ncCGPeV4HUHAHPVx1eGcMpHiPAaES7wDfwsWhX7mlxaVcCsVY3i5u2FmGlb0tkK1iTu39xw4hl
 Sv0ECqASbY4cRpojfdLeh4xppsLi+VE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2NiBTYWx0ZWRfX2POQcoU9RgEv
 D29PNrKnap3wIU8nTf963NfrXOuUCn2QQEiYW2npJEofeBM7Gvb6buJQLOaIVWFovtlgUkGSI+r
 z+CW521q9FypcTQWFTGbyHVhstwScydP0csQFN02iYYQC73SkO0TDEPl8Edn2nGbi0yr2aoUFQJ
 uZcb+v/XJER1w/2BD/G8aH8JltYpS+ZdfWkk/L4qs3+oSv7nXgRW2dZmA196W6tADqG9lMu44I2
 G3PcDjZULnbZrC0tc/1QmoG7l9oQ1FyORRZwqbC/Q/Uad96a1+BHQlP6S9y5R+6oRGdw8fY4z7T
 lz8jGTj9pEylbUQwL4ojkw2lemDWlJDUPDjFV2Zwtlpoq6gcPnJ/2QwHR3nJxtkdBw31wZpQmuh
 8bF9ZfUi886LeAo73Vr5RADO/i0OSCk9RyFi4XRdGS5reK/KYkrBgD5lYdvri5PIokT4Ry3jBKw
 L5wX+dpxijgMSF4Cnag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080066
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 10/7/2026 11:11 PM, Akihiko Odaki wrote:
> On 2026/10/08 10:08, Pierrick Bouvier wrote:
>> On 10/6/2026 11:01 PM, Akihiko Odaki wrote:
>>> A region of interest (ROI) often excludes the program startup and exit.
>>> For example, a benchmark may parse a large input and then run a
>>> computation kernel and the former may take longer than the latter;
>>> basic block vectors generated for the whole execution will not properly
>>> represent the latter.
>>>
>>> Add options to specify the beginning and the end of the ROI to bound
>>> basic block vector generation to the ROI.
>>>
>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> ---
>>>   docs/about/emulation.rst |  8 +++++
>>>   contrib/plugins/bbv.c    | 80 +++++++++++++++++++++++++++++++++++++
>>> +++++++++--
>>>   2 files changed, 86 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>>> index c58149086cdd..0566171b517b 100644
>>> --- a/docs/about/emulation.rst
>>> +++ b/docs/about/emulation.rst
>>> @@ -284,6 +284,14 @@ The bbv plugin allows you to generate basic
>>> block vectors for use with the
>>>       * - Option
>>>       - Description
>>> +  * - begin=A
>>> +    - The virtual address of the instruction that starts basic block
>>> vector
>>> +      generation. Generation starts from the beginning of the
>>> execution if
>>> +      not specified.
>>> +  * - end=A
>>> +    - The virtual address of the instruction that ends basic block
>>> vector
>>> +      generation. Generation continues until the endo of the
>>> execution if
>>
>> small typo here: s/endo/end
> 
> Thanks for catching the typo.
> 
>>
>>> +      not specified.
>>>     * - interval=N
>>>       - The interval to generate a basic block vector specified by
>>> the number of
>>>         instructions (Default: N = 100000000)
>>> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>>> index e5caf5d9543b..a2a779f7639e 100644
>>> --- a/contrib/plugins/bbv.c
>>> +++ b/contrib/plugins/bbv.c
>>> @@ -5,6 +5,8 @@
>>>    * SPDX-License-Identifier: GPL-2.0-or-later
>>>    */
>>>   +#include <stdbool.h>
>>> +#include <stdint.h>
>>>   #include <stdio.h>
>>>   #include <glib.h>
>>>   @@ -26,6 +28,10 @@ static GHashTable *bbs;
>>>   static GRWLock bbs_lock;
>>>   static char *filename;
>>>   static struct qemu_plugin_scoreboard *vcpus;
>>> +static bool begin_present;
>>> +static uint64_t begin;
>>> +static bool end_present;
>>> +static uint64_t end;
>>>   static int64_t interval = 100000000;
>>>     static void plugin_exit(void *p)
>>> @@ -66,6 +72,7 @@ static void vcpu_init(unsigned int vcpu_index, void
>>> *userdata)
>>>       Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>>>         vcpu_filename = g_strdup_printf("%s.%u.bb", filename,
>>> vcpu_index);
>>> +    vcpu->count = begin_present ? INT64_MIN : -interval;
>>
>> Not sure which semantic we are trying to achieve with -interval here.
>>
>> The original logic was to increment this count, until reaching interval,
>> after what we would reset it by using vcpu_count -= interval, to keep
>> the extra insn that went in after the threshold.
> 
> The counter now starts at -interval and counts up to zero. Subtracting
> interval after emitting a vector still preserves the extra instructions.
> For example, with interval=100:
> 
>     initial count:       -100
>     after 130 insns:       30  -> emit a vector
>     subtract interval:    -70  -> 70 insns until the next vector
> 
>>
>>>       vcpu->file = fopen(vcpu_filename, "w");
>>>   }
>>>   @@ -102,6 +109,22 @@ static void vcpu_interval_exec(unsigned int
>>> vcpu_index, void *udata)
>>>       fputc('\n', vcpu->file);
>>>   }
>>>   +static void vcpu_begin_insn_exec(unsigned int vcpu_index, void
>>> *userdata)
>>> +{
>>> +    GHashTableIter iter;
>>> +    void *value;
>>> +
>>> +    g_rw_lock_reader_lock(&bbs_lock);
>>> +    g_hash_table_iter_init(&iter, bbs);
>>> +
>>> +    while (g_hash_table_iter_next(&iter, NULL, &value)) {
>>> +        qemu_plugin_u64_set(bb_count_u64(value), vcpu_index, 0);
>>> +    }
>>> +
>>> +    g_rw_lock_reader_unlock(&bbs_lock);
>>> +    qemu_plugin_u64_set(count_u64(), vcpu_index, -interval);
>>> +}
>>> +
>>>   static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void *userdata)
>>>   {
>>>       uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
>>> @@ -119,6 +142,19 @@ static void vcpu_tb_trans(struct qemu_plugin_tb
>>> *tb, void *userdata)
>>>       }
>>>       g_rw_lock_writer_unlock(&bbs_lock);
>>>   +    for (size_t idx = 0; idx < n_insns; idx++) {
>>> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb,
>>> idx);
>>> +        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
>>> +
>>> +        if (begin_present && insn_vaddr == begin) {
>>> +            qemu_plugin_register_vcpu_insn_exec_cb(
>>> +                insn, vcpu_begin_insn_exec, QEMU_PLUGIN_CB_NO_REGS,
>>> NULL);
>>> +        } else if (end_present && insn_vaddr == end) {
>>> +            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>>> +                insn, QEMU_PLUGIN_INLINE_STORE_U64, count_u64(),
>>> INT64_MIN);
>>> +        }
>>> +    }
>>> +
>>>       qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>>>           tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(), n_insns);
>>>   @@ -127,7 +163,32 @@ static void vcpu_tb_trans(struct
>>> qemu_plugin_tb *tb, void *userdata)
>>>         qemu_plugin_register_vcpu_tb_exec_cond_cb(
>>>           tb, vcpu_interval_exec, QEMU_PLUGIN_CB_NO_REGS,
>>> -        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
>>> +        QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
>>> +}
>>
>> is INT64_MIN used as an arbitrary large value when interpreted as
>> unsigned immediate? If yes, that's confusing to the reader.
> 
> The unsigned comparison count < (uint64_t)INT64_MIN is equivalent with
> the signed comparison (int64_t)count >= 0. That is why this particular
> value is used.
> 
> Setting count to INT64_MIN suppresses output for the next 2^63 counted
> instructions, which is effectively disabled for this use. The begin
> callback clears the BB counters and sets count to -interval; end sets it
> back to INT64_MIN. The requested interval stays unchanged.
>

Ok I see better.
Even though it works, it's pretty confusing to be honest. Inline
operatons works with unsigned values, so with conversion and wrap
around, it's safe, but really not intuitive.

I would prefer if you could refactor this to keep a zero initialized
count value, and add a specific instrumentation path for begin, end
logic (COND_LT, UINT64_MAX - N) to keep the same behavior of "infinite
interval".

Thanks,
Pierrick


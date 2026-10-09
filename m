Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADA2CA6012
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF4FB-0003tf-Gv; Fri, 09 Oct 2026 02:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xF4Eu-0003sp-A2
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 02:37:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xF4Er-0003mm-KR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 02:37:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6993HijQ3323358
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 06:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oAQMkdOFwtWjvM0mjdBInOpZ9gebzQECGaSS27oC1QQ=; b=I72XliPYeWvtt8q7
 TEoaMaUMWeHKgv2MJhy/bBVjub36kazNvSTNOG+kS5CfYR/cFQxXospeHemyxHYZ
 vrkmXisMw6XN81oQR7cyGSteuU9h//CHVkfklsTAPy3BYkCRaU7na6ww79jxx3Tm
 drjxJKyQQwbxuo1ryvINdPCmP7L/RJ0Yr4z3B/GkWZjdxR6tEFAiS/+RGVbcVg67
 yELJp85aWupwYfj8I9XZoF79W7lTsitN59zaVNUZHH+u6TxUG+RZTjHviNQaLND7
 hFrNjgH8Xm/ruZjq45S+4rYPmMC8oonzdXwljY+xK6FPnWQjHea2uaHg4/Ol10Xo
 REulhQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ev5ahyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 06:37:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a7d2f25f65so1052617a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 23:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791527869; x=1792132669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oAQMkdOFwtWjvM0mjdBInOpZ9gebzQECGaSS27oC1QQ=;
 b=gpCGwbuTxSXcUFoYj9LwKm3dEn2ln28nVbw1DJmKzaCnBlimjdqlpV3zDp0lyzBvxT
 tWu22PydUk0dHZ0ovZaC4Mq3liSq6DyhSe+Adug06LGtP1nDkbOMyGW/0G547Li63YZM
 2pPq+uns10UCO4dLGRjseTXwBXNSgZ6KZkvPjSUzUwOPLbcESDgqpKLJBzOfMH9H0V4u
 mD5EyiXsBZiYJjJrMAen34RDaTsRwO9LkFdkebhPBm/KJh+uk5bm/VGyy0VVacfqI2d9
 S+5HwZYu0WBgNEhVhStISvKrNWp45CHc5NWRbDLPq5Wq/dWjLjzmgbJM8dmsyFqQr0zW
 567g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791527869; x=1792132669;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oAQMkdOFwtWjvM0mjdBInOpZ9gebzQECGaSS27oC1QQ=;
 b=XjYcuuPQVbXP16xOSsVo4kijNF6p8SomXdQO5wKA0kAnuMsTtaZljAfFMpODT4oEMM
 HE+Yd2iAtq/VAuLAaPF01k5/4pwqGwp9R5XGJXTjKLvJNPUM4RzSUG97NAUOWrhU+1+U
 f/awTCF2W/8sfVdnG50TLERzeaYAPDygCWE5PcaMTvbc+cxscGUabWkLivvLS1EJnzAa
 FWxMpFtJfcOOAglyD5IQe8ZqtEBqKtxqQsOvmukzZjcnX0qVR0pivBCtctJokb3QSjU/
 uEWlhlG0VNhxFvPY5NnQOZo2YXt/JEKc488BAhpM4MZx0X7iLWIgW9hVlxEFnbWORFUa
 gLQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxC59cGPP2OZs6Q+MxxSncsXhXeEC+u8qGEKep2uyvS8Gxcl6p0CfumVw9b4o/4usHOEjkxMjR56+UW@nongnu.org
X-Gm-Message-State: AFq9FYJJukSNcuFmHYz4OnYoXxPVku2vt+2LVQLdAVpnyN/8wDF5GBDi
 1cAI5BrBdETB0IQt3aC4bVbh7YI8o7ukC7/OTXeBeHR8ESJFMofBb1SL9YKuPo4viX2mbJpv5Qc
 9reEbOduuOXwWjO3n0gl9zdem92M5Dc4JkkFHQvTWrEN26S2jRfhwHqQXgQ==
X-Gm-Gg: AYBFou3C/K23zC0SAoO/TNbxq2hN0zpqvEqcHhTYTu+mBFdumO5U9U9NHYfhd/VZqDP
 FsxA0wgdexx3zQ0PGm/9YrvFBzE5iZYMir7sSsCus7QzpIzRn5tyVtfIJVHSkzxCj2IozHEgJOo
 I7v9XYmNCa4/9kkKSYhJeU56MKcJt203oyV7xgMpr8RxmvZRqSQ90ya3sV1c0RXsX+Ekv6Z2My5
 Y2a140RjD2SqPUaAqRpQPCyK7adO7OTRrbbedXpg9urxTF6yMH5/3gYCyE/cBQcAnuxIOMgegp+
 YbO3itZsh+j4OFPAQccVnroLhFsua/7ABsdazcktgvI3u8uGOgVy1t0ExU70BE1CF1IAJCjNN6B
 DH8eO3kfUrigeOLOfyEF5tUOSR8bGVGtwtdqVrJs5/UDAyw+ZsnvrnD8/
X-Received: by 2002:a17:90a:ec84:b0:3a0:eaf4:a435 with SMTP id
 98e67ed59e1d1-3ab36ec0a84mr820716a91.46.1791527868570; 
 Thu, 08 Oct 2026 23:37:48 -0700 (PDT)
X-Received: by 2002:a17:90a:ec84:b0:3a0:eaf4:a435 with SMTP id
 98e67ed59e1d1-3ab36ec0a84mr820694a91.46.1791527867230; 
 Thu, 08 Oct 2026 23:37:47 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3d9e1ee81sm448988a12.12.2026.10.08.23.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 23:37:46 -0700 (PDT)
Message-ID: <6b00ed2c-e78a-4ac7-9e5b-34d4aebefbbf@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 23:37:46 -0700
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
 <2d7c2cdb-b5b9-41ed-9786-dd9b4876bdd8@oss.qualcomm.com>
 <9cda6271-aed9-4a2b-b88f-bca8371d753e@rsg.ci.i.u-tokyo.ac.jp>
 <0b392aaf-7ce1-46bb-b39b-47744ea1e6f9@oss.qualcomm.com>
 <65391825-ef44-4771-99b4-ad3a47279762@rsg.ci.i.u-tokyo.ac.jp>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <65391825-ef44-4771-99b4-ad3a47279762@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNiBTYWx0ZWRfX/aaua6ITKLOo
 gFGKF+Kzogr/y8pokumX/cdBOTx379hWZo+/YlmPwZNOd0QJZKUnZ1qZiuIr8ZaNnR2P6MVuIYu
 qUNrDFNGNjTRdD4NhS5uGSEZHWgRG6c=
X-Authority-Analysis: v=2.4 cv=MMT1C8Zl c=1 sm=1 tr=0 ts=6ac88bbd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=5mQuFtH1dfYGMfFDJH8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: -uGGnzqJWEEGUcdtKTmDIGN_BffIOwaq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNiBTYWx0ZWRfX5lnDXj3AXXmy
 uU/xxkGiLmRUOJGqY/oZh1gn7mB+lPxGb1A0b+HQfgqnh59HCCt/Rj6mns4W1IbYMRomWv+IgaF
 cd93xCY3zIMCgtjRNj2pVgt0InIiuk91kA55YphCyd6Cln/vrjN+76zGuyggtZGdQzJoPvyH8Q1
 +6XsyyKDtTy3BHackXKOW+qp47I2gu6QtGqybqPH3aSoSgVT92xcU68PU5eydqA11PZzd7y2Cmy
 0p9uTTsFUhNl4Ne4jJEnzsrxZ3jFvMJEW+lr9yK7bAYJ15VXIe8o2xhGjJmvnL9if8vqQ0iMjsV
 3UQDFfKrs+MX2UGHixbXGaQmcb1v+EFM9EUgEgqLguASk72Bcwu9EbqpD5aNWZ1QXw9eFP0JelU
 1K8CIE6Vkxj0d7zr80m5qBT/XSrEcxpsUflRZc5EpdgUKEIpOhSnSUroJkuOvfKB7YxZ1HcqWt5
 MzdDkIFPNgj8uFTElCA==
X-Proofpoint-ORIG-GUID: -uGGnzqJWEEGUcdtKTmDIGN_BffIOwaq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090026
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/8/26 8:33 PM, Akihiko Odaki wrote:
> On 2026/10/09 11:30, Pierrick Bouvier wrote:
>> On 10/8/2026 5:57 PM, Akihiko Odaki wrote:
>>> On 2026/10/09 1:40, Pierrick Bouvier wrote:
>>>> On 10/7/2026 11:11 PM, Akihiko Odaki wrote:
>>>>> On 2026/10/08 10:08, Pierrick Bouvier wrote:
>>>>>> On 10/6/2026 11:01 PM, Akihiko Odaki wrote:
>>>>>>> A region of interest (ROI) often excludes the program startup and
>>>>>>> exit.
>>>>>>> For example, a benchmark may parse a large input and then run a
>>>>>>> computation kernel and the former may take longer than the latter;
>>>>>>> basic block vectors generated for the whole execution will not
>>>>>>> properly
>>>>>>> represent the latter.
>>>>>>>
>>>>>>> Add options to specify the beginning and the end of the ROI to bound
>>>>>>> basic block vector generation to the ROI.
>>>>>>>
>>>>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>>> ---
>>>>>>>      docs/about/emulation.rst |  8 +++++
>>>>>>>      contrib/plugins/bbv.c    | 80 +++++++++++++++++++++++++++++++++++++
>>>>>>> +++++++++--
>>>>>>>      2 files changed, 86 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>>>>>>> index c58149086cdd..0566171b517b 100644
>>>>>>> --- a/docs/about/emulation.rst
>>>>>>> +++ b/docs/about/emulation.rst
>>>>>>> @@ -284,6 +284,14 @@ The bbv plugin allows you to generate basic
>>>>>>> block vectors for use with the
>>>>>>>          * - Option
>>>>>>>          - Description
>>>>>>> +  * - begin=A
>>>>>>> +    - The virtual address of the instruction that starts basic block
>>>>>>> vector
>>>>>>> +      generation. Generation starts from the beginning of the
>>>>>>> execution if
>>>>>>> +      not specified.
>>>>>>> +  * - end=A
>>>>>>> +    - The virtual address of the instruction that ends basic block
>>>>>>> vector
>>>>>>> +      generation. Generation continues until the endo of the
>>>>>>> execution if
>>>>>>
>>>>>> small typo here: s/endo/end
>>>>>
>>>>> Thanks for catching the typo.
>>>>>
>>>>>>
>>>>>>> +      not specified.
>>>>>>>        * - interval=N
>>>>>>>          - The interval to generate a basic block vector specified by
>>>>>>> the number of
>>>>>>>            instructions (Default: N = 100000000)
>>>>>>> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>>>>>>> index e5caf5d9543b..a2a779f7639e 100644
>>>>>>> --- a/contrib/plugins/bbv.c
>>>>>>> +++ b/contrib/plugins/bbv.c
>>>>>>> @@ -5,6 +5,8 @@
>>>>>>>       * SPDX-License-Identifier: GPL-2.0-or-later
>>>>>>>       */
>>>>>>>      +#include <stdbool.h>
>>>>>>> +#include <stdint.h>
>>>>>>>      #include <stdio.h>
>>>>>>>      #include <glib.h>
>>>>>>>      @@ -26,6 +28,10 @@ static GHashTable *bbs;
>>>>>>>      static GRWLock bbs_lock;
>>>>>>>      static char *filename;
>>>>>>>      static struct qemu_plugin_scoreboard *vcpus;
>>>>>>> +static bool begin_present;
>>>>>>> +static uint64_t begin;
>>>>>>> +static bool end_present;
>>>>>>> +static uint64_t end;
>>>>>>>      static int64_t interval = 100000000;
>>>>>>>        static void plugin_exit(void *p)
>>>>>>> @@ -66,6 +72,7 @@ static void vcpu_init(unsigned int vcpu_index, void
>>>>>>> *userdata)
>>>>>>>          Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>>>>>>>            vcpu_filename = g_strdup_printf("%s.%u.bb", filename,
>>>>>>> vcpu_index);
>>>>>>> +    vcpu->count = begin_present ? INT64_MIN : -interval;
>>>>>>
>>>>>> Not sure which semantic we are trying to achieve with -interval here.
>>>>>>
>>>>>> The original logic was to increment this count, until reaching
>>>>>> interval,
>>>>>> after what we would reset it by using vcpu_count -= interval, to keep
>>>>>> the extra insn that went in after the threshold.
>>>>>
>>>>> The counter now starts at -interval and counts up to zero. Subtracting
>>>>> interval after emitting a vector still preserves the extra instructions.
>>>>> For example, with interval=100:
>>>>>
>>>>>        initial count:       -100
>>>>>        after 130 insns:       30  -> emit a vector
>>>>>        subtract interval:    -70  -> 70 insns until the next vector
>>>>>
>>>>>>
>>>>>>>          vcpu->file = fopen(vcpu_filename, "w");
>>>>>>>      }
>>>>>>>      @@ -102,6 +109,22 @@ static void vcpu_interval_exec(unsigned int
>>>>>>> vcpu_index, void *udata)
>>>>>>>          fputc('\n', vcpu->file);
>>>>>>>      }
>>>>>>>      +static void vcpu_begin_insn_exec(unsigned int vcpu_index, void
>>>>>>> *userdata)
>>>>>>> +{
>>>>>>> +    GHashTableIter iter;
>>>>>>> +    void *value;
>>>>>>> +
>>>>>>> +    g_rw_lock_reader_lock(&bbs_lock);
>>>>>>> +    g_hash_table_iter_init(&iter, bbs);
>>>>>>> +
>>>>>>> +    while (g_hash_table_iter_next(&iter, NULL, &value)) {
>>>>>>> +        qemu_plugin_u64_set(bb_count_u64(value), vcpu_index, 0);
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    g_rw_lock_reader_unlock(&bbs_lock);
>>>>>>> +    qemu_plugin_u64_set(count_u64(), vcpu_index, -interval);
>>>>>>> +}
>>>>>>> +
>>>>>>>      static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void
>>>>>>> *userdata)
>>>>>>>      {
>>>>>>>          uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
>>>>>>> @@ -119,6 +142,19 @@ static void vcpu_tb_trans(struct qemu_plugin_tb
>>>>>>> *tb, void *userdata)
>>>>>>>          }
>>>>>>>          g_rw_lock_writer_unlock(&bbs_lock);
>>>>>>>      +    for (size_t idx = 0; idx < n_insns; idx++) {
>>>>>>> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb,
>>>>>>> idx);
>>>>>>> +        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
>>>>>>> +
>>>>>>> +        if (begin_present && insn_vaddr == begin) {
>>>>>>> +            qemu_plugin_register_vcpu_insn_exec_cb(
>>>>>>> +                insn, vcpu_begin_insn_exec, QEMU_PLUGIN_CB_NO_REGS,
>>>>>>> NULL);
>>>>>>> +        } else if (end_present && insn_vaddr == end) {
>>>>>>> +            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>>>>>>> +                insn, QEMU_PLUGIN_INLINE_STORE_U64, count_u64(),
>>>>>>> INT64_MIN);
>>>>>>> +        }
>>>>>>> +    }
>>>>>>> +
>>>>>>>          qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>>>>>>>              tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(), n_insns);
>>>>>>>      @@ -127,7 +163,32 @@ static void vcpu_tb_trans(struct
>>>>>>> qemu_plugin_tb *tb, void *userdata)
>>>>>>>            qemu_plugin_register_vcpu_tb_exec_cond_cb(
>>>>>>>              tb, vcpu_interval_exec, QEMU_PLUGIN_CB_NO_REGS,
>>>>>>> -        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
>>>>>>> +        QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
>>>>>>> +}
>>>>>>
>>>>>> is INT64_MIN used as an arbitrary large value when interpreted as
>>>>>> unsigned immediate? If yes, that's confusing to the reader.
>>>>>
>>>>> The unsigned comparison count < (uint64_t)INT64_MIN is equivalent with
>>>>> the signed comparison (int64_t)count >= 0. That is why this particular
>>>>> value is used.
>>>>>
>>>>> Setting count to INT64_MIN suppresses output for the next 2^63 counted
>>>>> instructions, which is effectively disabled for this use. The begin
>>>>> callback clears the BB counters and sets count to -interval; end sets it
>>>>> back to INT64_MIN. The requested interval stays unchanged.
>>>>>
>>>>
>>>> Ok I see better.
>>>> Even though it works, it's pretty confusing to be honest. Inline
>>>> operatons works with unsigned values, so with conversion and wrap
>>>> around, it's safe, but really not intuitive.
>>>>
>>>> I would prefer if you could refactor this to keep a zero initialized
>>>> count value, and add a specific instrumentation path for begin, end
>>>> logic (COND_LT, UINT64_MAX - N) to keep the same behavior of "infinite
>>>> interval".
>>>
>>> We cannot choose a separate instrumentation path based on whether
>>> execution is inside the ROI. Instrumentation is installed when a TB is
>>> translated, but the same TB may execute both inside and outside the ROI.
>>>
>>> I will preserve this logic and add code comments for clarification.
>>>
>>
>> I took some time to read again how bbv works. Indeed, my idea to modify
>> interval was a non sense, and not what is expected.
>>
>> The current instrumentation per tb is always done unconditionally, and
>> the only need thing to do is to snapshot bbs hashtable to keep track of
>> the correct data only when being inside the ROI. The rest of existing
>> logic stays the same.
>>
>> - On enter, set vcpu->count to 0 (fresh start) and restore bb table from
>> previous exit (empty table if there was no exit yet).
>> - On exit, duplicate the bb table to allow to restore it next time we
>> enter in ROI.
>> Key idea is that we keep on adding things in bb table, but save/restore
>> when leaving/entering ROI.
>>
>> I think for robustness you should also add detection of those expected
>> transitions: Out of ROI -> Enter ROI -> Exit ROI -> Enter ROI -> ...
>>
>> Nothing is currently done to detect if if we meet enter/exit address
>> multiple times, without having the correct sequence. I don't know if we
>> want to report an error or handle reentrance correctly in this case.
>>
>> Also, should count be reset on each entrance, or do we want to keep
>> track of it also, and save/restore that on exit/enter? I tend to think
>> the idea is create a "virtual" interval than only is alive when being
>> inside the ROI. In this case, we should keep track of this value also.
> 
> The current design that resets the bb table is intentional. A "virtual"
> interval spanning multiple ROIs would be misleading because it mixes
> different sections of execution.
>

Ok.

> I don't think we need to add a special handling to enforce a particular
> order of transitions. This patch performs the same action for the begin
> and end addresses and that makes the behavior predictable.
> 
> Perhaps we can extend the documentation to clarify the "begin" marker to
> tell that it resets the bb table, making the behavior clear regardless
> of transition order.
>

I'm fine to keep a simple model, but I'll ask you to remove the logic 
involving negative numbers, it's just too confusing. Please remove:
vcpu->count = begin_present ? INT64_MIN : -interval;
and
QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);

Instead, let's add a new boolean "tracking_region" in struct Vcpu, that 
is set to true when entering ROI (or true by default if no begin 
parameter was given).

Then, modify instrumentation to replace:
```
else if (end_present && insn_vaddr == end) {
             qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_STORE_U64, count_u64(), 
INT64_MIN);
```
with:
```
else if (end_present && insn_vaddr == end) {
    qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_exit_region, 
QEMU_PLUGIN_CB_NO_REGS, NULL);
}

static void vcpu_exit_region(unsigned int vcpu_index, void *userdata)
{
    Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
    vcpu_interval_exec(vcpu_index, NULL);
    vcpu->tracking_region = false;
}
```

In addition, let's rename s/vcpu_begin_insn_exec/vcpu_enter_region, to 
be consistent and explicit on what it's doing.

And finally, the last piece:
static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
{
     Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
     if (!vcpu->tracking) {
       return;
     }
     ...

The impact performance of calling vcpu_interval_exec + one if every N 
instructions is invisible, and at least, it's a piece of code we can 
read in 6 months, and understand in less than 2 min without any 
additional doc.

> Regards,
> Akihiko Odaki

Thanks,
Pierrick


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33748CA6017
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 02:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0NM-0001EQ-LU; Thu, 08 Oct 2026 22:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xF0NB-00016N-B8
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 22:30:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xF0N8-0002ix-Ft
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 22:30:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990PUQm3813389
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 02:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0sY1/V1BxGu97lEhlixGPJpTmUGqeDc8zon5iSoLq7I=; b=ZfDsgP7BMeoeBv1w
 ukpQckg8/OuJaMIHSgiL7YZ/V2UzMRQslxWfdWmSAqKAWETSN+jSkNXNwkoywGE+
 WVnay385NkfFl6teic56HUQAGEqPFh8qkE735YjJKbsGVqX8Cq1nym6KiTx94Knz
 jC98l1goVgExYuVw0K1aEq32xnC1qorldKPIYmOXNnsUmhxuiITATreKi91fDmG6
 ZDF7lC3Fh6qJ1YiDu9PlSVxQs6U+Kk5c0DqsxyLdti9P0ZdC7n5RA32SCq50dFKE
 NH958OCQskrikbCYhpzq8eijLL77GDWxv862vTtejtvC2YFBFdKT8WSYqjeTaifI
 G3Eb/g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrsh9e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 02:30:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3515266f6eeso3228286eec.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 19:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791513004; x=1792117804; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0sY1/V1BxGu97lEhlixGPJpTmUGqeDc8zon5iSoLq7I=;
 b=eNFoZmBDcxAQ/5Z2qMMsEjZiqtpn4+sSWhAXG6M5VxXd64PyaEg3jcMtKHWDFLbzSt
 oztiBbVRT63+UPSCy4lG6QO08kmmoThElaZc6281fSzdQ1yQTRPQAhxaPiDSZyI9Af0h
 +Bucw8WRSJtry4Obu8f3PjzPcUm+DaJvWeE0NpfxFoNnFibXC5sfbz8Mx0HqXxNGuyXE
 AU5prZ/ZRHXYgPsLovksK3gpnObuTrFp40IOmzRRolpu0Wl8iVnZY7RAtHeYnI1+zdya
 TQZH6cEl70UgajxDIA6I0V2RN8+DVXF4izyKKgsV3uRB1jZE6iFV/RAgrqWQ3UYpYpgN
 fFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791513004; x=1792117804;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0sY1/V1BxGu97lEhlixGPJpTmUGqeDc8zon5iSoLq7I=;
 b=dlmKUemEzSgit8dOuKztiWetaYcNqtYmSlbP2J/6wGe6As5uws/fvFLPb0KHnxxCis
 +Sa++zsl3StpTs/hN7CMcddfc+ABTPzD9RydHCFQ5yiCq7JKmm2aJbceXZTEESJva541
 aIkJos5HTw960ebRo4Tkyal7pOm/OL7v5G5foi5tO+7meN12HdNguePWm+r6kYugZFO2
 0hWZSq3IDPPlFAOCwAWcL6HavUVrGDGxaSMuzWi9ijfpMW9RvDaaVNDan8bPptp3YQxF
 ufnRZIVKeBz/x1mzbujcLm+lmxE7HGaTVFAg5nNumlvkK4NLHauocI5UIebWLiDI6Nw0
 dZ5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQFq4QTiuhnznk75VmL1PD7QHf2h3xXb3KpJ061inu6qgcv0OA5/BLReChkujHPDVZaec/zNALE8cu@nongnu.org
X-Gm-Message-State: AFuF++lXeiT60uUwAMVf/nfXi7Zxar9KLDpii4lhH1LRgaKpfgwDrYWG
 Mf2+RyV6XNJT9/dbS8hIKE29cErzh9V0BxP8KMX24lrKwBdLp0oCcF+qVzS0W+bJDdymj/vyU4Z
 obc0OSHTYq0jpIzqjpOdiwoSq9dzIuETHOoFVtOdGRXmSdIBebIfJL5Z8Mg==
X-Gm-Gg: AYBFou344CGCWf83+TYokr63uo3ExYSrosJs/m10KUj6SoEIhTGywm0LUNzcDe1DlsH
 uxnqE2KyiUnaWh1IZ+GHfkYi++CtYiAuBlzVBmJGMAH3ygvD44ryj37Fceoi7/S9ainkHOXtQYc
 uVMTftgwhtV/o28gUqnMj8MGJmfZUfXeYIHgHsxfZqKMB1CVg25d4RtSlg6IMBeJdXKde8Y+8lI
 +wEgxVCWakfJfXkPIzaxa9hUMtxSX4NHNYCPc8P7RapagZdgKemIsG+nvyJpN+fP35ek05gW31K
 kQSCyPE/0Ieh+eszINYjPWUtGrTwWreyHsoc9EjQl8442UZUv8bmO81m+oxcqRHR6M326+FZEFA
 QmO8GoiPVOtGlSqf69SBbt32ovdHOp4iyQkT5BjWsAvHRUMl8+q6nOF2Rj/GmbzhS3UbLoQ==
X-Received: by 2002:a05:701b:4546:20b0:14e:7162:2ab3 with SMTP id
 a92af1059eb24-16a5e49fd10mr576995c88.8.1791513003244; 
 Thu, 08 Oct 2026 19:30:03 -0700 (PDT)
X-Received: by 2002:a05:701b:4546:20b0:14e:7162:2ab3 with SMTP id
 a92af1059eb24-16a5e49fd10mr576961c88.8.1791513002574; 
 Thu, 08 Oct 2026 19:30:02 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1dd57d0sm2170839c88.8.2026.10.08.19.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 19:30:01 -0700 (PDT)
Message-ID: <0b392aaf-7ce1-46bb-b39b-47744ea1e6f9@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 19:30:00 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9cda6271-aed9-4a2b-b88f-bca8371d753e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac851ac cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=nViHCvjA23iAvvxjgtkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: uUuv6BS3NU3vH4kgB2sCvbnfGfSGL3JL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwOSBTYWx0ZWRfX8gmM0+R6d3Jr
 X8ShSKHpezxAy5IEDhSV+oEUxY3KPlHsvDD6Ghhlx5h6ksFKwjo/TMXBfc8QjgxjdM476BR6sZy
 4FrzGWKcsrnHAsnIDTs7fcMxaa8/g0kp4tBo12aYEjcxBI8ZVoQncO0ykcnaM1IDymccrjMuObG
 usiwhmuCwOWprSd7oPHW53vQkz7QFEQsxV1fW2T21+OTnfKl25mS2G6M9nrX+nRT2uPk32CLKR4
 8vTD+HY7cCvAJC618xRDj6PK3y9o60VvOx1gd7fvICiRfuEZlsuKdaUSWS7gaw+4e52+4Mtpjfj
 ug4AzAkD/QEfjFjpEJ9kUr1AiEgkDzPfeycKs3l1GRwxYusOztxms6SPJP23+yesH0f3MehZraJ
 LXlVcnna/4UphKl6dpE7ELmCiWYP1InDYnOa5Y2p3ATK0dSoJSpI3snaQLM06HczA+mz9ovnUA+
 /T82Pxt52/RgqNgSF/w==
X-Proofpoint-ORIG-GUID: uUuv6BS3NU3vH4kgB2sCvbnfGfSGL3JL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwOSBTYWx0ZWRfX9T4nGZoLZ/wD
 6LplTDzeBG4im8t36IZ69gymEinC6xmcSFsD+HqaZ9ehc8LBqI+k5WhJHKVXLib+tivV3tZCoxC
 MrdodGK4YsaovMUPgLl92qQws4ewZ3I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090009
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

On 10/8/2026 5:57 PM, Akihiko Odaki wrote:
> On 2026/10/09 1:40, Pierrick Bouvier wrote:
>> On 10/7/2026 11:11 PM, Akihiko Odaki wrote:
>>> On 2026/10/08 10:08, Pierrick Bouvier wrote:
>>>> On 10/6/2026 11:01 PM, Akihiko Odaki wrote:
>>>>> A region of interest (ROI) often excludes the program startup and
>>>>> exit.
>>>>> For example, a benchmark may parse a large input and then run a
>>>>> computation kernel and the former may take longer than the latter;
>>>>> basic block vectors generated for the whole execution will not
>>>>> properly
>>>>> represent the latter.
>>>>>
>>>>> Add options to specify the beginning and the end of the ROI to bound
>>>>> basic block vector generation to the ROI.
>>>>>
>>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>> ---
>>>>>    docs/about/emulation.rst |  8 +++++
>>>>>    contrib/plugins/bbv.c    | 80 +++++++++++++++++++++++++++++++++++++
>>>>> +++++++++--
>>>>>    2 files changed, 86 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>>>>> index c58149086cdd..0566171b517b 100644
>>>>> --- a/docs/about/emulation.rst
>>>>> +++ b/docs/about/emulation.rst
>>>>> @@ -284,6 +284,14 @@ The bbv plugin allows you to generate basic
>>>>> block vectors for use with the
>>>>>        * - Option
>>>>>        - Description
>>>>> +  * - begin=A
>>>>> +    - The virtual address of the instruction that starts basic block
>>>>> vector
>>>>> +      generation. Generation starts from the beginning of the
>>>>> execution if
>>>>> +      not specified.
>>>>> +  * - end=A
>>>>> +    - The virtual address of the instruction that ends basic block
>>>>> vector
>>>>> +      generation. Generation continues until the endo of the
>>>>> execution if
>>>>
>>>> small typo here: s/endo/end
>>>
>>> Thanks for catching the typo.
>>>
>>>>
>>>>> +      not specified.
>>>>>      * - interval=N
>>>>>        - The interval to generate a basic block vector specified by
>>>>> the number of
>>>>>          instructions (Default: N = 100000000)
>>>>> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>>>>> index e5caf5d9543b..a2a779f7639e 100644
>>>>> --- a/contrib/plugins/bbv.c
>>>>> +++ b/contrib/plugins/bbv.c
>>>>> @@ -5,6 +5,8 @@
>>>>>     * SPDX-License-Identifier: GPL-2.0-or-later
>>>>>     */
>>>>>    +#include <stdbool.h>
>>>>> +#include <stdint.h>
>>>>>    #include <stdio.h>
>>>>>    #include <glib.h>
>>>>>    @@ -26,6 +28,10 @@ static GHashTable *bbs;
>>>>>    static GRWLock bbs_lock;
>>>>>    static char *filename;
>>>>>    static struct qemu_plugin_scoreboard *vcpus;
>>>>> +static bool begin_present;
>>>>> +static uint64_t begin;
>>>>> +static bool end_present;
>>>>> +static uint64_t end;
>>>>>    static int64_t interval = 100000000;
>>>>>      static void plugin_exit(void *p)
>>>>> @@ -66,6 +72,7 @@ static void vcpu_init(unsigned int vcpu_index, void
>>>>> *userdata)
>>>>>        Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>>>>>          vcpu_filename = g_strdup_printf("%s.%u.bb", filename,
>>>>> vcpu_index);
>>>>> +    vcpu->count = begin_present ? INT64_MIN : -interval;
>>>>
>>>> Not sure which semantic we are trying to achieve with -interval here.
>>>>
>>>> The original logic was to increment this count, until reaching
>>>> interval,
>>>> after what we would reset it by using vcpu_count -= interval, to keep
>>>> the extra insn that went in after the threshold.
>>>
>>> The counter now starts at -interval and counts up to zero. Subtracting
>>> interval after emitting a vector still preserves the extra instructions.
>>> For example, with interval=100:
>>>
>>>      initial count:       -100
>>>      after 130 insns:       30  -> emit a vector
>>>      subtract interval:    -70  -> 70 insns until the next vector
>>>
>>>>
>>>>>        vcpu->file = fopen(vcpu_filename, "w");
>>>>>    }
>>>>>    @@ -102,6 +109,22 @@ static void vcpu_interval_exec(unsigned int
>>>>> vcpu_index, void *udata)
>>>>>        fputc('\n', vcpu->file);
>>>>>    }
>>>>>    +static void vcpu_begin_insn_exec(unsigned int vcpu_index, void
>>>>> *userdata)
>>>>> +{
>>>>> +    GHashTableIter iter;
>>>>> +    void *value;
>>>>> +
>>>>> +    g_rw_lock_reader_lock(&bbs_lock);
>>>>> +    g_hash_table_iter_init(&iter, bbs);
>>>>> +
>>>>> +    while (g_hash_table_iter_next(&iter, NULL, &value)) {
>>>>> +        qemu_plugin_u64_set(bb_count_u64(value), vcpu_index, 0);
>>>>> +    }
>>>>> +
>>>>> +    g_rw_lock_reader_unlock(&bbs_lock);
>>>>> +    qemu_plugin_u64_set(count_u64(), vcpu_index, -interval);
>>>>> +}
>>>>> +
>>>>>    static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void
>>>>> *userdata)
>>>>>    {
>>>>>        uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
>>>>> @@ -119,6 +142,19 @@ static void vcpu_tb_trans(struct qemu_plugin_tb
>>>>> *tb, void *userdata)
>>>>>        }
>>>>>        g_rw_lock_writer_unlock(&bbs_lock);
>>>>>    +    for (size_t idx = 0; idx < n_insns; idx++) {
>>>>> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb,
>>>>> idx);
>>>>> +        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
>>>>> +
>>>>> +        if (begin_present && insn_vaddr == begin) {
>>>>> +            qemu_plugin_register_vcpu_insn_exec_cb(
>>>>> +                insn, vcpu_begin_insn_exec, QEMU_PLUGIN_CB_NO_REGS,
>>>>> NULL);
>>>>> +        } else if (end_present && insn_vaddr == end) {
>>>>> +            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>>>>> +                insn, QEMU_PLUGIN_INLINE_STORE_U64, count_u64(),
>>>>> INT64_MIN);
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>>        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>>>>>            tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(), n_insns);
>>>>>    @@ -127,7 +163,32 @@ static void vcpu_tb_trans(struct
>>>>> qemu_plugin_tb *tb, void *userdata)
>>>>>          qemu_plugin_register_vcpu_tb_exec_cond_cb(
>>>>>            tb, vcpu_interval_exec, QEMU_PLUGIN_CB_NO_REGS,
>>>>> -        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
>>>>> +        QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
>>>>> +}
>>>>
>>>> is INT64_MIN used as an arbitrary large value when interpreted as
>>>> unsigned immediate? If yes, that's confusing to the reader.
>>>
>>> The unsigned comparison count < (uint64_t)INT64_MIN is equivalent with
>>> the signed comparison (int64_t)count >= 0. That is why this particular
>>> value is used.
>>>
>>> Setting count to INT64_MIN suppresses output for the next 2^63 counted
>>> instructions, which is effectively disabled for this use. The begin
>>> callback clears the BB counters and sets count to -interval; end sets it
>>> back to INT64_MIN. The requested interval stays unchanged.
>>>
>>
>> Ok I see better.
>> Even though it works, it's pretty confusing to be honest. Inline
>> operatons works with unsigned values, so with conversion and wrap
>> around, it's safe, but really not intuitive.
>>
>> I would prefer if you could refactor this to keep a zero initialized
>> count value, and add a specific instrumentation path for begin, end
>> logic (COND_LT, UINT64_MAX - N) to keep the same behavior of "infinite
>> interval".
> 
> We cannot choose a separate instrumentation path based on whether
> execution is inside the ROI. Instrumentation is installed when a TB is
> translated, but the same TB may execute both inside and outside the ROI.
> 
> I will preserve this logic and add code comments for clarification.
>

I took some time to read again how bbv works. Indeed, my idea to modify
interval was a non sense, and not what is expected.

The current instrumentation per tb is always done unconditionally, and
the only need thing to do is to snapshot bbs hashtable to keep track of
the correct data only when being inside the ROI. The rest of existing
logic stays the same.

- On enter, set vcpu->count to 0 (fresh start) and restore bb table from
previous exit (empty table if there was no exit yet).
- On exit, duplicate the bb table to allow to restore it next time we
enter in ROI.
Key idea is that we keep on adding things in bb table, but save/restore
when leaving/entering ROI.

I think for robustness you should also add detection of those expected
transitions: Out of ROI -> Enter ROI -> Exit ROI -> Enter ROI -> ...

Nothing is currently done to detect if if we meet enter/exit address
multiple times, without having the correct sequence. I don't know if we
want to report an error or handle reentrance correctly in this case.

Also, should count be reset on each entrance, or do we want to keep
track of it also, and save/restore that on exit/enter? I tend to think
the idea is create a "virtual" interval than only is alive when being
inside the ROI. In this case, we should keep track of this value also.

> Regards,
> Akihiko Odaki

Regards,
Pierrick


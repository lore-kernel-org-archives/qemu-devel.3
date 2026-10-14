Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BF2CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnZ4-00041g-F9; Tue, 13 Oct 2026 21:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnYy-00041H-O3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 21:13:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnYw-0005u8-3w
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 21:13:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DKHWs2442761
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MbNAk8bisyqNqOxQwvG/QQj8i0/h/8RN0wBAOzVm+PY=; b=mVk23SFgr0mgWvBY
 zKhYb7Zsn9NRzVjpa6JFDWQYbUFEIUs+ya56GmhPZqHYSFsWA524ZRFEiCckY1L7
 bv267lIMKECy5yZtxhfidwfVrdKRUH7kJ9aog+VF3Sz/I9QOaHMENGoNMpaj3SPB
 yttNi2CBZskSbvM9z33izCi7UvkJVtJa4tyrF/lE5k6sI2XY3msZkk6p10whBpYL
 Fxt+f87ol6xgFP9NjmMNZ7GU0HJZ5HNnly0pu4/H7rPiZGp2nUnQC0MEtmJ8eof3
 4Xly4vXivn1Drc3SdS9m4d/QD/n2hwANNMSNvnX3MACRpmOe1dqNRVWfpe0kQeau
 CcNFKQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71jwue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:13:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso8078323eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 18:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791940423; x=1792545223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MbNAk8bisyqNqOxQwvG/QQj8i0/h/8RN0wBAOzVm+PY=;
 b=i0zpXhp2Rttvi4JSOOB1+19yThPk7F9k9ob8ZxusnM/xCMKsduz29mfemOcxKcTYT4
 11CiT3vl69ZajCYQP0Oq81mS31Hg/5yjdKGff9Y9yPP3lG6bKGKGCU4smHHlZSpRte3R
 Q33/G4anBA3fSYnMGaKKe03oj7X/TxMF/9Te/Q6Q0ENlmv2ZwJXuaIqVedK7YaLyewY+
 7dpwW5MvuEyl9CeKLjjK1jwjKiKy6ENLTittLL0WyJtk15GleOaKZeqDYQPTibFr56/N
 tNRDF4Hm40TTW5O1vy+smX3JdeEhi75G5SS0Kcrc6hlBU8xpqG5Jf01T2/jCmTCN6Vzo
 z5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791940423; x=1792545223;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MbNAk8bisyqNqOxQwvG/QQj8i0/h/8RN0wBAOzVm+PY=;
 b=18WBGQEiNYf+A6T7x8toFK4or8Ti9jdIijER5nrPQ7i+bUB95M1sn4sxww0StnCbuJ
 vx8+PBLKfYC1eXpES2o4sMg0LnmClFF6NpaCTvZ8sCnNfRdHhSEl63LNZpIXa2/C1w/k
 8cICpCTc3OzG7sMDwvuNxvwI5O42geDUVGcY5WKgbZFxwqsIX0Mrq0A3VGkgNY0Fp2Ll
 iQ+U2aDgY760WcAIHG7RxcOLK/f3usKiT650voLe7AFHuOLYL2zEsfQfFLJ0uOrYP1Q/
 Z5DQO0U2O4doEDwoLDpq1CNhkrCo3llTaBHzosfEIdpDCD/Bmdhwt2pTqqf7z/jEU0Bu
 MigQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+C/EVn1eQE74ntlDSaF2ZG6Mk54Fs6MkYGqi12EUst1JFfdwOI7B7gj1Sqi5ax7sLF4HPP945MW2f@nongnu.org
X-Gm-Message-State: AFq9FYLR/BspM+6Ug/fXcrrFYmrAleF6zxyg7WgnAUcxqvvKYp6tpLxv
 N4Ay08eSSylXZw4jwE2Ldj9ixCVCjCubigfAW8SXb6oGh7gK2/JYUUf4p1P/vq4CEoMwcyEDEqC
 yUnjTAFZ7qqw7h75vKi35bdiOBZ97KXGCmMu8ZlSs8Dr6ESpvHdfS/cNALqUOELsDCA==
X-Gm-Gg: AYBFou0sIf7Gd0uv8v8gLZYAbLtTuIY/UgvZgGEJJUl0XAQv2aHdGQpCCfNmsY0Lqt9
 qRIIuduFaGNzTEX5AcPMyBUm1RBfTOv1pCwnuojBnaFMu0RZS4RKyJoCAFpTBp+aAN0PJyrINEX
 Ide3kNmmFKYxl3F4mr4XwYzwoSJOCeAGwgdx2vjkLlQS9MF+JJynfIrL7hEP2Aivr+DT2LpfAXk
 9cSsb7hnkG2pPSgyo43UDbldJtiHqXQBY0yf6/rtV2pOLLVwP7Gzfn/5Da77UtHx5j88peG5mts
 zDdXWGzBEliTGXe8N3P12BhrvaQUeXU/ftD3Pk2ZVjk/SEHcID7860aqEmVhJyNu3k9KwLT5VJl
 DtBIMzDOBL+Nt+VHx2l7nLa1gw9H4OEotLDTXkp5d2+Z8JPqvj5Lu+VeNVjs58srxRSETOA==
X-Received: by 2002:a05:7300:8195:b0:350:869:d106 with SMTP id
 5a478bee46e88-3537e2363d1mr26060161eec.34.1791940422633; 
 Tue, 13 Oct 2026 18:13:42 -0700 (PDT)
X-Received: by 2002:a05:7300:8195:b0:350:869:d106 with SMTP id
 5a478bee46e88-3537e2363d1mr26060095eec.34.1791940421793; 
 Tue, 13 Oct 2026 18:13:41 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca329d9sm50118396eec.5.2026.10.13.18.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 18:13:41 -0700 (PDT)
Message-ID: <5ad30a8d-b52f-4a9a-b299-a0caa98f2a67@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 18:13:39 -0700
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
 <6b00ed2c-e78a-4ac7-9e5b-34d4aebefbbf@oss.qualcomm.com>
 <ea052c05-88bb-4640-801e-8b9937bc5955@rsg.ci.i.u-tokyo.ac.jp>
 <d4552417-493f-4577-ac64-b3b63b15cdd5@oss.qualcomm.com>
 <9ce93dc1-b374-4732-97f8-e7a236759346@rsg.ci.i.u-tokyo.ac.jp>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9ce93dc1-b374-4732-97f8-e7a236759346@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6aced748 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=I6D0sq9qET5inyjeHjAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: Knn400Syx-UyrZ8Oyh0M_FGM2SObVWLX
X-Proofpoint-ORIG-GUID: Knn400Syx-UyrZ8Oyh0M_FGM2SObVWLX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwNCBTYWx0ZWRfX6hfYr69c5g3o
 buLncp1GqQAQmxJV/h2PI+3w6dxVOCbKtsv0llgcW++GUx1kO2zgUSgmEoQEmoxxZEOV9wm5ywE
 XnEtBLayuZ4L2fdgcMoQS+kir6W/M8jSScbZi00BILEQHQbDhfDtz+oZNGZ2ruZI+3Jwpc9gVLu
 XQMEW86+cyU0Vn2G2PrYlcyCGdniLZBWTN/I6QHTLp4BdkqtInlU6GrsF1CN+cHDnnyAjCi+j7X
 fqrAxjIkAVtTBfMPxAzQmSg5X2Evo2v/X4Qv/htHa2xd9QUHiSCZCtZtSZLVaDhuRfneNuZhGvz
 8H129z1n0vcLtOMRL69xmoMaN98ffH2XsKxmNrvPgxaZt0SJi/4m3dqqx7VIyu9b1JrcP+Ct77S
 g8j4CNZJgZB+EhP5I2ndIyRiTGFMympAkjhmFpkPX/lsH7Ut3AdOGlU83lr34Nwhn5yyhZo9b5w
 dEh+f+qLM2/UQS2C4NQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwNCBTYWx0ZWRfX5Qloke4WqwlI
 Sc6mIXtdg+/pdWhy8WLMQ4Rg46UEFJ1NPIgC8/LEaPJFpaHAqrPKkt3+hm6zMBBv9PY4/eWZw/t
 lpL8tjmen4ExZ6U7ANUZ9IzIvtBcoX4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140004
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

On 10/13/2026 6:02 PM, Akihiko Odaki wrote:
> On 2026/10/13 11:12, Pierrick Bouvier wrote:
>> On 10/12/26 7:00 AM, Akihiko Odaki wrote:
>>> On 2026/10/09 15:37, Pierrick Bouvier wrote:
>>>> On 10/8/26 8:33 PM, Akihiko Odaki wrote:
>>>>> On 2026/10/09 11:30, Pierrick Bouvier wrote:
>>>>>> On 10/8/2026 5:57 PM, Akihiko Odaki wrote:
>>>>>>> On 2026/10/09 1:40, Pierrick Bouvier wrote:
>>>>>>>> On 10/7/2026 11:11 PM, Akihiko Odaki wrote:
>>>>>>>>> On 2026/10/08 10:08, Pierrick Bouvier wrote:
>>>>>>>>>> On 10/6/2026 11:01 PM, Akihiko Odaki wrote:
>>>>>>>>>>> A region of interest (ROI) often excludes the program startup
>>>>>>>>>>> and
>>>>>>>>>>> exit.
>>>>>>>>>>> For example, a benchmark may parse a large input and then run a
>>>>>>>>>>> computation kernel and the former may take longer than the
>>>>>>>>>>> latter;
>>>>>>>>>>> basic block vectors generated for the whole execution will not
>>>>>>>>>>> properly
>>>>>>>>>>> represent the latter.
>>>>>>>>>>>
>>>>>>>>>>> Add options to specify the beginning and the end of the ROI to
>>>>>>>>>>> bound
>>>>>>>>>>> basic block vector generation to the ROI.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>>>>>>> ---
>>>>>>>>>>>       docs/about/emulation.rst |  8 +++++
>>>>>>>>>>>       contrib/plugins/bbv.c    | 80 +++++++++++++++++++++++++
>>>>>>>>>>> ++++
>>>>>>>>>>> ++++++++
>>>>>>>>>>> +++++++++--
>>>>>>>>>>>       2 files changed, 86 insertions(+), 2 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>>>>>>>>>>> index c58149086cdd..0566171b517b 100644
>>>>>>>>>>> --- a/docs/about/emulation.rst
>>>>>>>>>>> +++ b/docs/about/emulation.rst
>>>>>>>>>>> @@ -284,6 +284,14 @@ The bbv plugin allows you to generate basic
>>>>>>>>>>> block vectors for use with the
>>>>>>>>>>>           * - Option
>>>>>>>>>>>           - Description
>>>>>>>>>>> +  * - begin=A
>>>>>>>>>>> +    - The virtual address of the instruction that starts basic
>>>>>>>>>>> block
>>>>>>>>>>> vector
>>>>>>>>>>> +      generation. Generation starts from the beginning of the
>>>>>>>>>>> execution if
>>>>>>>>>>> +      not specified.
>>>>>>>>>>> +  * - end=A
>>>>>>>>>>> +    - The virtual address of the instruction that ends basic
>>>>>>>>>>> block
>>>>>>>>>>> vector
>>>>>>>>>>> +      generation. Generation continues until the endo of the
>>>>>>>>>>> execution if
>>>>>>>>>>
>>>>>>>>>> small typo here: s/endo/end
>>>>>>>>>
>>>>>>>>> Thanks for catching the typo.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> +      not specified.
>>>>>>>>>>>         * - interval=N
>>>>>>>>>>>           - The interval to generate a basic block vector
>>>>>>>>>>> specified by
>>>>>>>>>>> the number of
>>>>>>>>>>>             instructions (Default: N = 100000000)
>>>>>>>>>>> diff --git a/contrib/plugins/bbv.c b/contrib/plugins/bbv.c
>>>>>>>>>>> index e5caf5d9543b..a2a779f7639e 100644
>>>>>>>>>>> --- a/contrib/plugins/bbv.c
>>>>>>>>>>> +++ b/contrib/plugins/bbv.c
>>>>>>>>>>> @@ -5,6 +5,8 @@
>>>>>>>>>>>        * SPDX-License-Identifier: GPL-2.0-or-later
>>>>>>>>>>>        */
>>>>>>>>>>>       +#include <stdbool.h>
>>>>>>>>>>> +#include <stdint.h>
>>>>>>>>>>>       #include <stdio.h>
>>>>>>>>>>>       #include <glib.h>
>>>>>>>>>>>       @@ -26,6 +28,10 @@ static GHashTable *bbs;
>>>>>>>>>>>       static GRWLock bbs_lock;
>>>>>>>>>>>       static char *filename;
>>>>>>>>>>>       static struct qemu_plugin_scoreboard *vcpus;
>>>>>>>>>>> +static bool begin_present;
>>>>>>>>>>> +static uint64_t begin;
>>>>>>>>>>> +static bool end_present;
>>>>>>>>>>> +static uint64_t end;
>>>>>>>>>>>       static int64_t interval = 100000000;
>>>>>>>>>>>         static void plugin_exit(void *p)
>>>>>>>>>>> @@ -66,6 +72,7 @@ static void vcpu_init(unsigned int vcpu_index,
>>>>>>>>>>> void
>>>>>>>>>>> *userdata)
>>>>>>>>>>>           Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus,
>>>>>>>>>>> vcpu_index);
>>>>>>>>>>>             vcpu_filename = g_strdup_printf("%s.%u.bb",
>>>>>>>>>>> filename,
>>>>>>>>>>> vcpu_index);
>>>>>>>>>>> +    vcpu->count = begin_present ? INT64_MIN : -interval;
>>>>>>>>>>
>>>>>>>>>> Not sure which semantic we are trying to achieve with -interval
>>>>>>>>>> here.
>>>>>>>>>>
>>>>>>>>>> The original logic was to increment this count, until reaching
>>>>>>>>>> interval,
>>>>>>>>>> after what we would reset it by using vcpu_count -= interval, to
>>>>>>>>>> keep
>>>>>>>>>> the extra insn that went in after the threshold.
>>>>>>>>>
>>>>>>>>> The counter now starts at -interval and counts up to zero.
>>>>>>>>> Subtracting
>>>>>>>>> interval after emitting a vector still preserves the extra
>>>>>>>>> instructions.
>>>>>>>>> For example, with interval=100:
>>>>>>>>>
>>>>>>>>>         initial count:       -100
>>>>>>>>>         after 130 insns:       30  -> emit a vector
>>>>>>>>>         subtract interval:    -70  -> 70 insns until the next
>>>>>>>>> vector
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>           vcpu->file = fopen(vcpu_filename, "w");
>>>>>>>>>>>       }
>>>>>>>>>>>       @@ -102,6 +109,22 @@ static void
>>>>>>>>>>> vcpu_interval_exec(unsigned int
>>>>>>>>>>> vcpu_index, void *udata)
>>>>>>>>>>>           fputc('\n', vcpu->file);
>>>>>>>>>>>       }
>>>>>>>>>>>       +static void vcpu_begin_insn_exec(unsigned int vcpu_index,
>>>>>>>>>>> void
>>>>>>>>>>> *userdata)
>>>>>>>>>>> +{
>>>>>>>>>>> +    GHashTableIter iter;
>>>>>>>>>>> +    void *value;
>>>>>>>>>>> +
>>>>>>>>>>> +    g_rw_lock_reader_lock(&bbs_lock);
>>>>>>>>>>> +    g_hash_table_iter_init(&iter, bbs);
>>>>>>>>>>> +
>>>>>>>>>>> +    while (g_hash_table_iter_next(&iter, NULL, &value)) {
>>>>>>>>>>> +        qemu_plugin_u64_set(bb_count_u64(value), vcpu_index,
>>>>>>>>>>> 0);
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    g_rw_lock_reader_unlock(&bbs_lock);
>>>>>>>>>>> +    qemu_plugin_u64_set(count_u64(), vcpu_index, -interval);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>       static void vcpu_tb_trans(struct qemu_plugin_tb *tb, void
>>>>>>>>>>> *userdata)
>>>>>>>>>>>       {
>>>>>>>>>>>           uint64_t n_insns = qemu_plugin_tb_n_insns(tb);
>>>>>>>>>>> @@ -119,6 +142,19 @@ static void vcpu_tb_trans(struct
>>>>>>>>>>> qemu_plugin_tb
>>>>>>>>>>> *tb, void *userdata)
>>>>>>>>>>>           }
>>>>>>>>>>>           g_rw_lock_writer_unlock(&bbs_lock);
>>>>>>>>>>>       +    for (size_t idx = 0; idx < n_insns; idx++) {
>>>>>>>>>>> +        struct qemu_plugin_insn *insn =
>>>>>>>>>>> qemu_plugin_tb_get_insn(tb,
>>>>>>>>>>> idx);
>>>>>>>>>>> +        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
>>>>>>>>>>> +
>>>>>>>>>>> +        if (begin_present && insn_vaddr == begin) {
>>>>>>>>>>> +            qemu_plugin_register_vcpu_insn_exec_cb(
>>>>>>>>>>> +                insn, vcpu_begin_insn_exec,
>>>>>>>>>>> QEMU_PLUGIN_CB_NO_REGS,
>>>>>>>>>>> NULL);
>>>>>>>>>>> +        } else if (end_present && insn_vaddr == end) {
>>>>>>>>>>> +           
>>>>>>>>>>> qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>>>>>>>>>>> +                insn, QEMU_PLUGIN_INLINE_STORE_U64,
>>>>>>>>>>> count_u64(),
>>>>>>>>>>> INT64_MIN);
>>>>>>>>>>> +        }
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>>           qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>>>>>>>>>>>               tb, QEMU_PLUGIN_INLINE_ADD_U64, count_u64(),
>>>>>>>>>>> n_insns);
>>>>>>>>>>>       @@ -127,7 +163,32 @@ static void vcpu_tb_trans(struct
>>>>>>>>>>> qemu_plugin_tb *tb, void *userdata)
>>>>>>>>>>>             qemu_plugin_register_vcpu_tb_exec_cond_cb(
>>>>>>>>>>>               tb, vcpu_interval_exec, QEMU_PLUGIN_CB_NO_REGS,
>>>>>>>>>>> -        QEMU_PLUGIN_COND_GE, count_u64(), interval, NULL);
>>>>>>>>>>> +        QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
>>>>>>>>>>> +}
>>>>>>>>>>
>>>>>>>>>> is INT64_MIN used as an arbitrary large value when interpreted as
>>>>>>>>>> unsigned immediate? If yes, that's confusing to the reader.
>>>>>>>>>
>>>>>>>>> The unsigned comparison count < (uint64_t)INT64_MIN is equivalent
>>>>>>>>> with
>>>>>>>>> the signed comparison (int64_t)count >= 0. That is why this
>>>>>>>>> particular
>>>>>>>>> value is used.
>>>>>>>>>
>>>>>>>>> Setting count to INT64_MIN suppresses output for the next 2^63
>>>>>>>>> counted
>>>>>>>>> instructions, which is effectively disabled for this use. The
>>>>>>>>> beginEmulation
>>>>>>>>> callback clears the BB counters and sets count to -interval; end
>>>>>>>>> sets it
>>>>>>>>> back to INT64_MIN. The requested interval stays unchanged.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ok I see better.
>>>>>>>> Even though it works, it's pretty confusing to be honest. Inline
>>>>>>>> operatons works with unsigned values, so with conversion and wrap
>>>>>>>> around, it's safe, but really not intuitive.
>>>>>>>>
>>>>>>>> I would prefer if you could refactor this to keep a zero
>>>>>>>> initialized
>>>>>>>> count value, and add a specific instrumentation path for begin, end
>>>>>>>> logic (COND_LT, UINT64_MAX - N) to keep the same behavior of
>>>>>>>> "infinite
>>>>>>>> interval".
>>>>>>>
>>>>>>> We cannot choose a separate instrumentation path based on whether
>>>>>>> execution is inside the ROI. Instrumentation is installed when a
>>>>>>> TB is
>>>>>>> translated, but the same TB may execute both inside and outside the
>>>>>>> ROI.
>>>>>>>
>>>>>>> I will preserve this logic and add code comments for clarification.
>>>>>>>
>>>>>>
>>>>>> I took some time to read again how bbv works. Indeed, my idea to
>>>>>> modify
>>>>>> interval was a non sense, and not what is expected.
>>>>>>
>>>>>> The current instrumentation per tb is always done unconditionally,
>>>>>> and
>>>>>> the only need thing to do is to snapshot bbs hashtable to keep
>>>>>> track of
>>>>>> the correct data only when being inside the ROI. The rest of existing
>>>>>> logic stays the same.
>>>>>>
>>>>>> - On enter, set vcpu->count to 0 (fresh start) and restore bb
>>>>>> table from
>>>>>> previous exit (empty table if there was no exit yet).
>>>>>> - On exit, duplicate the bb table to allow to restore it next time we
>>>>>> enter in ROI.
>>>>>> Key idea is that we keep on adding things in bb table, but save/
>>>>>> restore
>>>>>> when leaving/entering ROI.
>>>>>>
>>>>>> I think for robustness you should also add detection of those
>>>>>> expected
>>>>>> transitions: Out of ROI -> Enter ROI -> Exit ROI -> Enter ROI -> ...
>>>>>>
>>>>>> Nothing is currently done to detect if if we meet enter/exit address
>>>>>> multiple times, without having the correct sequence. I don't know
>>>>>> if we
>>>>>> want to report an error or handle reentrance correctly in this case.
>>>>>>
>>>>>> Also, should count be reset on each entrance, or do we want to keep
>>>>>> track of it also, and save/restore that on exit/enter? I tend to
>>>>>> think
>>>>>> the idea is create a "virtual" interval than only is alive when being
>>>>>> inside the ROI. In this case, we should keep track of this value
>>>>>> also.
>>>>>
>>>>> The current design that resets the bb table is intentional. A
>>>>> "virtual"
>>>>> interval spanning multiple ROIs would be misleading because it mixes
>>>>> different sections of execution.
>>>>>
>>>>
>>>> Ok.
>>>>
>>>>> I don't think we need to add a special handling to enforce a
>>>>> particular
>>>>> order of transitions. This patch performs the same action for the
>>>>> begin
>>>>> and end addresses and that makes the behavior predictable.
>>>>>
>>>>> Perhaps we can extend the documentation to clarify the "begin"
>>>>> marker to
>>>>> tell that it resets the bb table, making the behavior clear regardless
>>>>> of transition order.
>>>>>
>>>>
>>>> I'm fine to keep a simple model, but I'll ask you to remove the logic
>>>> involving negative numbers, it's just too confusing. Please remove:
>>>> vcpu->count = begin_present ? INT64_MIN : -interval;
>>>> and
>>>> QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
>>>>
>>>> Instead, let's add a new boolean "tracking_region" in struct Vcpu, that
>>>> is set to true when entering ROI (or true by default if no begin
>>>> parameter was given).
>>>
>>> The flag may look simpler in isolation, but streamlining the
>>> interactions with the counter requires more careful thought. Please see
>>> below.
>>>
>>>>
>>>> Then, modify instrumentation to replace:
>>>> ```
>>>> else if (end_present && insn_vaddr == end) {
>>>>               qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>>>>                   insn, QEMU_PLUGIN_INLINE_STORE_U64, count_u64(),
>>>> INT64_MIN);
>>>> ```
>>>> with:
>>>> ```
>>>> else if (end_present && insn_vaddr == end) {
>>>>      qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_exit_region,
>>>> QEMU_PLUGIN_CB_NO_REGS, NULL);
>>>> }
>>>>
>>>> static void vcpu_exit_region(unsigned int vcpu_index, void *userdata)
>>>> {
>>>>      Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>>>>      vcpu_interval_exec(vcpu_index, NULL);
>>>>      vcpu->tracking_region = false;
>>>> }
>>>> ```
>>>
>>> vcpu_exit_region should only disable tracking. Calling
>>> vcpu_interval_exec directly bypasses its count >= interval precondition:
>>> it subtracts interval even when count is smaller, wrapping the unsigned
>>> counter, and emits a partial vector or potentially an empty one.
>>>
>>
>> I'm fine with it. I was unsure if you wanted to dump the partial data,
>> aggregate it when reentering the section, or simply discard it.
>> With a discard, it's even simpler, just need to set tracking_region to
>> false.
>>
>>>>
>>>> In addition, let's rename s/vcpu_begin_insn_exec/vcpu_enter_region, to
>>>> be consistent and explicit on what it's doing.
>>>>
>>>> And finally, the last piece:
>>>> static void vcpu_interval_exec(unsigned int vcpu_index, void *udata)
>>>> {
>>>>       Vcpu *vcpu = qemu_plugin_scoreboard_find(vcpus, vcpu_index);
>>>>       if (!vcpu->tracking) {
>>>>         return;
>>>>       }
>>>>       ...
>>>
>>> The early return must come after vcpu->count -= interval. Otherwise,
>>> once count reaches interval outside the ROI, it remains above the
>>> threshold and invokes the callback on every subsequent TB, rather than
>>> once per interval.
>>>
>>
>> Right, thanks for catching it.
>>
>>>>
>>>> The impact performance of calling vcpu_interval_exec + one if every N
>>>> instructions is invisible, and at least, it's a piece of code we can
>>>> read in 6 months, and understand in less than 2 min without any
>>>> additional doc.
>>>
>>> I agree the performance impact is negligible, but at least you need to
>>> consider about that to be sure. Adding another flag requires those
>>> additional considerations.
>>>
>>> More broadly, I don't think it's ideal to introduce application-specific
>>> logic for this. Looking at the bigger picture, a counting timer with
>>> variable expiration is a common pattern that should ideally be supported
>>> generally.
>>>
>>> An alternative option is to have signed integer variants of
>>> qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() and similar
>>> functions to support for that. However, I don't think those are
>>> necessary either. Taking at an even broader perspective, C allows
>>> avoiding such specialization by letting unsigned variables hold signed
>>> values in a well-defined manner; even the underlying implementation of
>>> the inline op uses signed and unsigned types interchangeably.
>>>
>>
>> If the argument is "C allows that with a defined behaviour", I don't
>> think it makes a point for me. There is a lot of well defined and
>> confusing code you can write.
>>
>> Something like:
>>   qemu_plugin_register_vcpu_tb_exec_cond_cb(
>>          QEMU_PLUGIN_COND_LT, count_u64(), INT64_MIN, NULL);
>> with limit and counter being unsigned is not readable for me.
>>
>>> Although it might not be immediately obvious that an unsigned variable
>>> is storing a signed value, adding a brief clarifying comment is still
>>> simpler than introducing another variable overall.
>>>
>>
>>  From there I'll let you decide between introducing the flag, or
>> reimplement that with positive values (sticking to init count=0) only
>> if you really prefer this approach.
> 
> I agree that "C allows this with defined behaviour" is insufficient on
> its own. Ideally, we could express the signed interpretation directly
> with int64_t without adding complexity. That would improve clarity,
> even though the existing arithmetic is already well-defined.
> 
> However, we need to consider the whole design. Both approaches require
> readers to understand more than the individual expressions.
> 
> The counter-only approach requires knowing that:
> 
> - count is actually treated as signed.
> - Any non-negative is smaller than (uint64_t)INT64_MIN when compared as
>   unsigned.
> 
> The flag approach requires considering:
> - How the count and flag together determine when a vector is emitted.
> - The required ordering of count and flag accesses.
> - Whether the number of callback invocations will significantly
>   increase.
> 
> The count-only approach requires fewer considerations, and the ones it
> does require needs no deduction. The first point is a common practice,
> as seen in the underlying implementation. The second point is simply a
> matter of the int64_t definition. In both cases, knowing the definition
> is sufficient, and both can be documented clearly in the comments.
> 
> In contrast, the flag approach requires real reasoning. Comments won't
> help here; explaining the ordering and interactions via comments would
> be as complicated as the code itself, thereby imposing a greater
> cognitive burden.
> 
> Furthermore, supporting a variable interval (as done in the count-only
> approach) is a pattern we should embrace, rather than working around it
> by introducing a separate flag.
> 
> We have also already discussed why retaining count=0 is not a drop-in
> alternative under the same counter-only instrumentation. The initial
> state must distinguish execution that starts inside the ROI from
> execution waiting for the begin marker.
> 
> Putting all together, I still believe utilizing the existing signed
> representation is cleaner than inventing an alternative approach ourselves.
>

I respect your opinion, but I would prefer to not introduce such usage
of the existing API in contrib/, since it might (wrongly) inspire other
people reading this plugin code.

> Regards,
> Akihiko Odaki

Regards,
Pierrick


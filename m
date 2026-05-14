Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5420ECD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 15:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNYPR-0001GC-Gq; Thu, 14 May 2026 11:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNYPO-0001Fh-Q7
 for qemu-devel@nongnu.org; Thu, 14 May 2026 11:55:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNYPL-00077h-Vz
 for qemu-devel@nongnu.org; Thu, 14 May 2026 11:55:34 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeYb72238425
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 15:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tikmx5ESVToLo3wZAmEJ+g9HonWXIH+jbLKKWpz56zQ=; b=QEvFnN9FnMTGXoPk
 X34sE8uG/S28xNYsiai+ZrE+C8okETBfhUVSIrRIMYrAe3QP0VHcz2eI84ctQSZd
 7rSle97Am/ULfMWpi4h6X5nQahbkU0rX6XRpjDXiBtiSBZqBC5xFjqIlP6ugSIB5
 shfbhcIk6M5d5mBgGHYscs0MCxGaMlaF++MVnkoIgtkV1eYLkf82YbWhkV+wjASX
 hpReJCHKmioqDUF+5hLN9aVe1RrO/iAJHVpbG0SOVMU0lalt0cZxyBElB/+KagFs
 5hexHmoa/E5cpeYWVfH5hvq1j+i4pMTCp16J7yNQcoRj+77lGi7D3aEgttK973z8
 VOKokQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e566bjjc1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 15:55:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f5943ca81aso15997836eec.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778774129; x=1779378929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tikmx5ESVToLo3wZAmEJ+g9HonWXIH+jbLKKWpz56zQ=;
 b=jgNB7cQ5b4RpIYtmck21waUfIsWOqdZM1LqrZ3pURw4vYLw7ZXgJkifvf0FCoYTUhV
 4DKLvQZnH+NmoMOm+X84lcD0icwpyX00CG+CW3h+BrCM+1lv/GmrdIMPDzGrE2krm0W2
 /hlUwNP1rshdUuGKtI8jErmpsHJqAsPthBJd/ZIty9CRPQddBUb9fDnJpiwuQmCNT+T5
 KpG5KR0ILgAdKTeN/gJodAyBMJ1XQwESVFELuMW5oRseaifc8YNU78SpdNzwyMBHgMA1
 Xx6ZHzwRcQ4KJ7xaLoUYOkSMUv8AV+Va9oUw22Qggs6Lx3JRfvhQ1tiFSgAx16YjgsSV
 9trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778774129; x=1779378929;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tikmx5ESVToLo3wZAmEJ+g9HonWXIH+jbLKKWpz56zQ=;
 b=GJ8dxYDttumXDMtiIvXF+dHt80BzmJOLSQdRTtMXENHTRdsUQmu1yny2+g/5VriaSe
 Bew3jpGBK7DrTTHboclkltTAPyEyJUiZmmGTCHgdjKmztKCnPToMgXNI1ecuDDtNaCqP
 iv9aimFQI6o8UjF9XR7dB5EdtFY52KHOgkxqM6sc0yJwAmxEZjtzgiDzaqieXXVxlzP5
 eKfrlceIowTq5FtrY7DoIIWKO/9LSfsS+oEHzpDJsauhLWVP5uBNO5jG+jHZcsWTiNY8
 BuScSg7mBOzTopXz6JKfQW3C/Yi+OQ4sSzejRJ90lhwtnHyeUKGtSdBW5C/hnjpFYJJ7
 lVRw==
X-Gm-Message-State: AOJu0YwLUYFsZdFYlrO5gXkNfKFl04fjtN7ZmKIo335/7Bv6RpbHITCm
 ibg2dS6EKRisFZKV5+79gIFPDfKsJjyS+WuwvWBqgGEL6+Ez2LUagPNYZsdlg1t8xHb28MqsIwq
 WCLyNuSvzYy5UKr86vRZWo8XmeE7q4Msg8lk/skcG/WhenY22lHox/4AAJQ==
X-Gm-Gg: Acq92OHi/2cWhXdRvLDhJzY1X9fdEeh0oKfqOFo7W9GRFc5AF+CEfWrT1ugNmv047q2
 wYKS79VJdiKKKwGf0zTFQKyz60AaBMtpqVlrzD0hukzJidjApmKlMwKoZBSOpfen7orJSAY3iPh
 56EHvT7n+Gz/y3A4ccfw3v7tLoXK3TPYfWjR1bEY/KnV0chEblMYylSN99bmAn4JtwS1030EGqs
 TjQCPtKurChXgf34VxlGUGJMre55v+NUXtgiMa8lflSH1umwR6m0+qzkBnoIKhkE+jjY9FOVSQk
 8exrjiTKzd600iIrAC4Af/gsrUHhbm2tzs11tXEFJW7vrI6RO/ZT0JOuX0RmhanHxI689YS41Q1
 9w3YcrekN/E+SZBM4vOtIvFTQzHQGmDDqO1kPqmQez/vq1KhIfRlVcI+4c577m9UodWDMvru1KZ
 IUozotA97Zo9BwKQ==
X-Received: by 2002:a05:7300:ac90:b0:2ff:9d6b:4f31 with SMTP id
 5a478bee46e88-3039812b389mr20771eec.6.1778774128690; 
 Thu, 14 May 2026 08:55:28 -0700 (PDT)
X-Received: by 2002:a05:7300:ac90:b0:2ff:9d6b:4f31 with SMTP id
 5a478bee46e88-3039812b389mr20728eec.6.1778774127920; 
 Thu, 14 May 2026 08:55:27 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bbd50sm3291701eec.20.2026.05.14.08.55.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 08:55:27 -0700 (PDT)
Message-ID: <009a09cc-a017-4f19-b0e0-0df8149daa8b@oss.qualcomm.com>
Date: Thu, 14 May 2026 08:55:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Target-info update for 2026-05-12
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
 <CAJSP0QXjoF0qPpNq==p1fqTHMWQdezzQLHKKwm6iUBXHdPr-fg@mail.gmail.com>
 <953abafd-3dbd-4055-a500-d089ace35470@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <953abafd-3dbd-4055-a500-d089ace35470@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lVkx0nk3nM8D-4uGSJ0PCFd5c5_g0E-e
X-Authority-Analysis: v=2.4 cv=WsMb99fv c=1 sm=1 tr=0 ts=6a05f071 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ISqSk_lbuIkOd-NZrP8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE2MCBTYWx0ZWRfX4j5CAJXZk9/g
 aViOhl8EXoSpj8nVigdnFD4WwDWEEzGzIn3/9S5CBR4VJRnN2DVjb4W2KVN9lEiIEjU1f/fl8Y9
 C5IvLLMmL0wqMwX7J6q9DlO3v6qqF4qFUJMqEbXDn5+F1adsJfmGzE0rW+rzoqPpXkPMjn6qumk
 BQmsbUZbANXFFoqw2+uGafLei9iz+RMD4qYEjKu9cRkFp38knn7OECpg2uJ6fVk72MIW2zCBct8
 sl5Yb9TVdOhUUtURTqcWjMXgOMdPghUFYXI4+Fx3w6YtyAATctxMoemy+yha0wKZrnyUGEYUp78
 N+H5sciDmK0W+p9gMhcS3heZwOvkpF3Ad+GPm9qV9ewwsN0jl5Z0WBr3GFYOOILcwq80J1iGerq
 nXLsWOCQGpN5/zriifxNXc0u/O/eQZTRVkrTb/XJii1Cwr5kZGDPtSPX9l8ujLtVm3IhEDLRqLK
 CyQ5ISI1nj5HdMm//Pw==
X-Proofpoint-GUID: lVkx0nk3nM8D-4uGSJ0PCFd5c5_g0E-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140160
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

On 5/14/2026 7:46 AM, Philippe Mathieu-Daudé wrote:
> On 14/5/26 16:16, Stefan Hajnoczi wrote:
>> On Tue, May 12, 2026 at 2:32 PM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>
>>> The following changes since commit
>>> 5e61afe211e82a9af15a8794a0bd29bb574e953b:
>>>
>>>    Merge tag 'ui-pull-request' of https://gitlab.com/
>>> marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/target_info-20260512
>>>
>>> for you to fetch changes up to 0fc2022c6331c5d5bdd9060c73d067abba3f5515:
>>>
>>>    target-info: replace target_info() in system-mode (2026-05-12
>>> 11:29:18 -0700)
>>>
>>> ----------------------------------------------------------------
>>> Changes:
>>> - [PATCH v6 0/5] single-binary: deduplicate target_info() (Pierrick
>>> Bouvier <pierrick.bouvier@oss.qualcomm.com>)
>>>    Link: https://lore.kernel.org/qemu-devel/20260512150208.1167711-1-
>>> pierrick.bouvier@oss.qualcomm.com
>>>
>>> ----------------------------------------------------------------
>>> Pierrick Bouvier (5):
>>>        qom/object: register OBJECT and INTERFACE QOM types before main
>>>        qom/object: initialize type_table in static ctor with
>>> fundamental QOM types
>>>        target-info: introduce TargetInfo in QOM
>>>        target-info-qom: detect target from QOM
>>>        target-info: replace target_info() in system-mode
>>
>> Please take a look at this CI failure:
>>
>> Testing ./build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-generic-fuzz-
>> cirrus-vga
>> ...
>> AddressSanitizer:DEADLYSIGNAL
>> =================================================================
>> ==5334==ERROR: AddressSanitizer: SEGV on unknown address
>> 0x000000000020 (pc 0x5bd0beb39ef4 bp 0x7ffe0ad764d0 sp 0x7ffe0ad764c0
>> T0)
>> ==5334==The signal is caused by a READ memory access.
>> ==5334==Hint: address points to the zero page.
>> #0 0x5bd0beb39ef4 in target_endian_mode
>> /builds/qemu-project/qemu/build-oss-fuzz/../target-info.c:42:27
>> #1 0x5bd0beb39ef4 in target_big_endian
>> /builds/qemu-project/qemu/build-oss-fuzz/../target-info.c:47:12
>> #2 0x5bd0bf4f1da1 in qtest_process_command
>> /builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:705:13
>> #3 0x5bd0bf4f1da1 in qtest_process_inbuf
>> /builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:778:9
>> #4 0x5bd0bf4eef54 in qtest_server_inproc_recv
>> /builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:910:9
>> #5 0x5bd0bfe18f85 in qtest_sendf
>> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:715:5
>> #6 0x5bd0bfe15294 in qtest_query_target_endianness
>> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:804:5
>> #7 0x5bd0bfe1f2f3 in qtest_inproc_init
>> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/
>> libqtest.c:2043:23
>> #8 0x5bd0bfe71778 in qtest_setup
>> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/fuzz/fuzz.c:64:12
>> #9 0x5bd0bfe71778 in LLVMFuzzerInitialize
>> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/fuzz/
>> fuzz.c:206:16
>> #10 0x5bd0be9b3b56 in fuzzer::FuzzerDriver(int*, char***, int
>> (*)(unsigned char const*, unsigned long)) fuzzer.o
>> #11 0x5bd0be9e2166 in main
> 
> 
> IIUC the fuzzer mode doesn't call main() -> qemu_init() but a distinct
> one via LLVMFuzzerInitialize().
> 
> We'd need to squash something like:
> 
> -- >8 --
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index ca248a51a6c..90f07dcda3d 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -172,6 +172,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv,
> char ***envp)
>      /* Initialize qgraph and modules */
>      qos_graph_init();
>      module_call_init(MODULE_INIT_FUZZ_TARGET);
> +    module_call_init(MODULE_INIT_TARGET_INFO);
>      module_call_init(MODULE_INIT_QOM);
>      module_call_init(MODULE_INIT_LIBQOS);
>

Yes, this looks like the issue.
I'll reproduce, send a v7, and send PR once all tests are completed.

> ---
> 
>> (/builds/qemu-project/qemu/build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-
>> target-generic-fuzz-cirrus-vga+0x46166)
>> (BuildId: 845b9265a3ae1439c62fb86e3bc4973f7ea7c960)
>> #12 0x7f7fef9a65b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4)
>> (BuildId: abd2a4d896fed122b3f7da571746f193feeb86a1)
>> #13 0x7f7fef9a6667 in __libc_start_main@GLIBC_2.2.5
>> (/lib64/libc.so.6+0x3667) (BuildId:
>> abd2a4d896fed122b3f7da571746f193feeb86a1)
>> #14 0x5bd0be9a8f34 in _start
>> (/builds/qemu-project/qemu/build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-
>> target-generic-fuzz-cirrus-vga+0xcf34)
>> (BuildId: 845b9265a3ae1439c62fb86e3bc4973f7ea7c960)
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/14371480130
>>
>> If this issue is caused by this pull request, please send a new
>> revision that solves the issue.
>>
>> If this issue is not caused by this pull request, please let me know.
>> Thanks!
>>

Seems like it's definitely related to this PR, I'll fix the series.

>> Stefan
>>
>>>
>>>   configs/targets/aarch64-softmmu.c |  6 ++---
>>>   configs/targets/arm-softmmu.c     |  6 ++---
>>>   include/qemu/module.h             |  1 +
>>>   include/qemu/target-info-init.h   | 53 ++++++++++++++++++++++++++++
>>> +++++++++++
>>>   include/qemu/target-info-qom.h    | 30 ++++++++++++++++++++++
>>>   qom/object.c                      | 22 +++++-----------
>>>   system/vl.c                       |  4 +++
>>>   target-info-qom.c                 | 45 ++++++++++++++++++++++++++++
>>> +++++
>>>   target-info-stub.c                |  6 ++---
>>>   9 files changed, 145 insertions(+), 28 deletions(-)
>>>   create mode 100644 include/qemu/target-info-init.h
>>>   create mode 100644 include/qemu/target-info-qom.h
>>>
>>
> 

Thanks,
Pierrick


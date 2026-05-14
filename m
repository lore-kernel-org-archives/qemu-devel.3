Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2E9CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcAk-0003Xw-2W; Thu, 14 May 2026 15:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNcAj-0003Xj-40
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:56:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNcAh-00035w-3O
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:56:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpXoY3795596
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0z3xZM2LMpeUpVPMuZqCO5ocY2cwfXE9cTVrtxScxLk=; b=d194T166s0DXZrod
 92Ie473vFhx1u0ea8cvXrXsdrVTszaWo6/4gtHgvRTqvigasu8FIR1cwb2QF/CuG
 KJlyT2Y29bsdCaOTi37FK9RanNwFjBP80zVMaq8zPEObpl6fwfU2OQCBpgl5DiAI
 SqaFgPh7sMOLGHDMWrqifpRudg+VslyZwNeNw4oKf/WNeilB3VtYJUrOI1heZ7Z2
 RzFV7Qtgi16AjjkmoGDdxOZwdvbj3ba1KTWHEFpWSn/EG0J9wDnuzVT+4/52YF+C
 bDIg//nsOiqtCuasK6eI87SoumLk23ugASLzkwCEUfM951WousLQl0hnW2QcO8ZI
 XQF/OQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1sr633-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:56:38 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f5943ca81aso17095522eec.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778788597; x=1779393397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0z3xZM2LMpeUpVPMuZqCO5ocY2cwfXE9cTVrtxScxLk=;
 b=b5Cl0Oq2rGct2EPQmO1Wbv31rkWROd24xUKsKt0+MvtC6Jq2N8aYoJxd0ylszWwZDv
 Hc9H3/RwDzgNprBsAsMPEK5IMydJnEQF7v1Hy91luClxhaQyMgSIeZnqNl5zQt1rckH3
 hxasPhxEpnKP/HY5qIQTdqWhFG37R/8N84AfJnRHnXy8XQbf6drjdVdzZcaoW6fzkT45
 6H1oZO1Xpr782tZW6Qjh0bg5e2947P6cxmnU5Eyv8nATgjq4VZ6vXY87gTqTZC2YM/oj
 /I/x8fYLfwACz2fJeN+0vNBAPwJp7skCNCyKMqYMF9l1aaU7CPUN6POL8IwTv7VCEaJm
 BF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788597; x=1779393397;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0z3xZM2LMpeUpVPMuZqCO5ocY2cwfXE9cTVrtxScxLk=;
 b=a3NmxCkBb+y9O5t9uvM8+QfH3e4JaL0eTYhThozTf3qcowCtz6mURrw7ORpjanmQIT
 i3Kf2tn43HkeQqdUfebZRZPBjQS8BbpgHHauGdYNwDjNRQxUV5apwJ9ndxXtpzHWDu+r
 leVxdkjWQqhGc5965xfP+aYScY2u7yhqOl6niQPbENe2Ox+OT5Lxmhm5fM4N+kvWo856
 LP0CgoZpp82MUcThAXbm0ZC3tu/xZortjBhfun+TijiMp+cQFr+3ly6PE0HikNCo60EO
 UwtHw9Uk22F1NwX/mZFgHmr29OjZQcJh2ca8yrMH9ab6geia1gbn5SxUHehmY/WqqV+Q
 C3MQ==
X-Gm-Message-State: AOJu0YwIr9dqBmNDTt7tUxwUejpmQGvKV6Zy5z8WPaBc9hpd9KfQd5nk
 G1hqlz097+RM7jQjyqERcAuqZCn2wWelZGpwU/qda9njLmDelVad4cqRqN4qtQTfYn5Wca995fv
 f5LVT1kFzamdlWzH+MUZFg++SWDbUbMVIEjxvFhD7+c4Q8I+SVpWsK8FCjw==
X-Gm-Gg: Acq92OF5AFBx3ennmd6n3+1XJecdb29e6HBpqSd4LlWtj6mujCOLt2u4EtR7rcBSpa6
 dkJOBvWYgIKjq2ZDrKv1huS3bauSgmR3fSp0vE3ToplHU7+pUZHMjH+v08jHfn2mpnSVh8WZNSJ
 C/Roj/7Jd8OUIAy1VqHQ8f3UClGq122kZUp2e8yNehq0GpgGna/7du2o/t2VLBUE2fdMCqUfdkM
 MZD99MtLEuU/YTerX2KyoDfTuFCJ3KXyTsY4cNli2l9FizmdUSm6vhinSAtg8FZyytjJ3GY1p7s
 counCA0vhhRK9HzAbCwhBYGRr3wBFoUOiY4DnSmriFqHQj8YkCjKeFDGe1F3DBo/6SL29PI99AH
 89G1KT8brpgdb8PBXTVBANVRGfhBVLAIRW3vBBLRltTHzdrehgwPDv6GSkaXSuTT4YijYdnhTOl
 iykCZEKBZIVDECvMBDNNFY+Rka
X-Received: by 2002:a05:7300:5789:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-303986370bdmr514753eec.24.1778788597066; 
 Thu, 14 May 2026 12:56:37 -0700 (PDT)
X-Received: by 2002:a05:7300:5789:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-303986370bdmr514728eec.24.1778788596412; 
 Thu, 14 May 2026 12:56:36 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978afe8dsm4400891eec.27.2026.05.14.12.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 12:56:35 -0700 (PDT)
Message-ID: <ba4443eb-a8ea-460c-9b29-a30813e739ca@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:56:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Target-info update for 2026-05-12
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
 <CAJSP0QXjoF0qPpNq==p1fqTHMWQdezzQLHKKwm6iUBXHdPr-fg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAJSP0QXjoF0qPpNq==p1fqTHMWQdezzQLHKKwm6iUBXHdPr-fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfXxrlyBG7X2aLl
 hL2p5fM0/AswHOQbwUePoRRqLFjy1gGrHRO79b6iPOqcSY0kKQDOzC1UtbRV/GCOqrxF0DhSa6+
 AqX5o7P22o2umksN5XGYlsITPDp0Ur8sFWYCj/+QaXYlpUj1t4U5ZwrCc1iZN7lj17pKhGWnAMe
 zqS2QC82zf8q9ULTc1enQbntaahtG1uvBTG4A4yW+UffdvAGT4Qep997M4gPL5Id1lBWUp6SP8N
 aMK4MsvMF82Nz+QLa1BCIlOq2IESWZvE0FSzsBAqR25wKGXDedvBtEc6gCzMwY1xO6f6NIm3/ZR
 eNfNAIDgdeHIXn2odgzTHZHKPnI104/7QBX7YEExE0cm0ihtm8x8pZLCCjdUTPVuPgN9JrsYk6k
 w+FZmyKVG7nH1Zt3v0wwEQd6/8hUxklhg6fOepm8CuRBHlGNqIaKLuA58a9aRnMpyyqMV9j/30j
 20ZcEPxnk0NmLoLFUTw==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a0628f6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_g9wHOP8AzAl37G-8kMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 601nk3aoDF3o6Gj5QpYR89xUmoGHoHve
X-Proofpoint-ORIG-GUID: 601nk3aoDF3o6Gj5QpYR89xUmoGHoHve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140197
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

On 5/14/2026 7:16 AM, Stefan Hajnoczi wrote:
> On Tue, May 12, 2026 at 2:32 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:
>>
>>   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/target_info-20260512
>>
>> for you to fetch changes up to 0fc2022c6331c5d5bdd9060c73d067abba3f5515:
>>
>>   target-info: replace target_info() in system-mode (2026-05-12 11:29:18 -0700)
>>
>> ----------------------------------------------------------------
>> Changes:
>> - [PATCH v6 0/5] single-binary: deduplicate target_info() (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
>>   Link: https://lore.kernel.org/qemu-devel/20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com
>>
>> ----------------------------------------------------------------
>> Pierrick Bouvier (5):
>>       qom/object: register OBJECT and INTERFACE QOM types before main
>>       qom/object: initialize type_table in static ctor with fundamental QOM types
>>       target-info: introduce TargetInfo in QOM
>>       target-info-qom: detect target from QOM
>>       target-info: replace target_info() in system-mode
> 
> Please take a look at this CI failure:
> 
> Testing ./build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-generic-fuzz-cirrus-vga
> ...
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==5334==ERROR: AddressSanitizer: SEGV on unknown address
> 0x000000000020 (pc 0x5bd0beb39ef4 bp 0x7ffe0ad764d0 sp 0x7ffe0ad764c0
> T0)
> ==5334==The signal is caused by a READ memory access.
> ==5334==Hint: address points to the zero page.
> #0 0x5bd0beb39ef4 in target_endian_mode
> /builds/qemu-project/qemu/build-oss-fuzz/../target-info.c:42:27
> #1 0x5bd0beb39ef4 in target_big_endian
> /builds/qemu-project/qemu/build-oss-fuzz/../target-info.c:47:12
> #2 0x5bd0bf4f1da1 in qtest_process_command
> /builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:705:13
> #3 0x5bd0bf4f1da1 in qtest_process_inbuf
> /builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:778:9
> #4 0x5bd0bf4eef54 in qtest_server_inproc_recv
> /builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:910:9
> #5 0x5bd0bfe18f85 in qtest_sendf
> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:715:5
> #6 0x5bd0bfe15294 in qtest_query_target_endianness
> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:804:5
> #7 0x5bd0bfe1f2f3 in qtest_inproc_init
> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:2043:23
> #8 0x5bd0bfe71778 in qtest_setup
> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/fuzz/fuzz.c:64:12
> #9 0x5bd0bfe71778 in LLVMFuzzerInitialize
> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/fuzz/fuzz.c:206:16
> #10 0x5bd0be9b3b56 in fuzzer::FuzzerDriver(int*, char***, int
> (*)(unsigned char const*, unsigned long)) fuzzer.o
> #11 0x5bd0be9e2166 in main
> (/builds/qemu-project/qemu/build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-generic-fuzz-cirrus-vga+0x46166)
> (BuildId: 845b9265a3ae1439c62fb86e3bc4973f7ea7c960)
> #12 0x7f7fef9a65b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4)
> (BuildId: abd2a4d896fed122b3f7da571746f193feeb86a1)
> #13 0x7f7fef9a6667 in __libc_start_main@GLIBC_2.2.5
> (/lib64/libc.so.6+0x3667) (BuildId:
> abd2a4d896fed122b3f7da571746f193feeb86a1)
> #14 0x5bd0be9a8f34 in _start
> (/builds/qemu-project/qemu/build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-generic-fuzz-cirrus-vga+0xcf34)
> (BuildId: 845b9265a3ae1439c62fb86e3bc4973f7ea7c960)
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/14371480130
> 
> If this issue is caused by this pull request, please send a new
> revision that solves the issue.
> 
> If this issue is not caused by this pull request, please let me know. Thanks!
> 
> Stefan
> 
>>
>>  configs/targets/aarch64-softmmu.c |  6 ++---
>>  configs/targets/arm-softmmu.c     |  6 ++---
>>  include/qemu/module.h             |  1 +
>>  include/qemu/target-info-init.h   | 53 +++++++++++++++++++++++++++++++++++++++
>>  include/qemu/target-info-qom.h    | 30 ++++++++++++++++++++++
>>  qom/object.c                      | 22 +++++-----------
>>  system/vl.c                       |  4 +++
>>  target-info-qom.c                 | 45 +++++++++++++++++++++++++++++++++
>>  target-info-stub.c                |  6 ++---
>>  9 files changed, 145 insertions(+), 28 deletions(-)
>>  create mode 100644 include/qemu/target-info-init.h
>>  create mode 100644 include/qemu/target-info-qom.h
>>

Sent a new PR with the fix included:
https://lore.kernel.org/qemu-devel/20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A448ECD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 22:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4ef-0008IU-42; Tue, 09 Jun 2026 18:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4ed-0008Hq-Fe
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:10:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4eZ-000428-UO
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 18:10:39 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4KC03230220
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 22:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JUnTLcgtaDsF+cGcTfD1Yl0hWwqDOAFQZG4nnvbJ+ew=; b=ighItmE49myl549E
 hlmeHBcHT8HEwSx1avD3u6J1Spy7jDWgYJDIIpz1oP2ZFLHaBLb3iT+J+dwi0Xmr
 /fSvftgeP+CJ8alLXr4YZqULVndlLIZtBvNak2jmZk2kdhxUKH/jBV2GCQ7poM8j
 CgmyDPmNICRku2TM3vfIGXvOJ8qzuWrSCoMX3zQPuOJeNsIhwusEpcAw+OVhmcr3
 b8FsAC640FzzyEmi7RfGnc1PwL+OAMZ3u6lcrfkeIEuadJzQnVDwssVCQMaiJJ0Q
 Q4QZh0RAmLVyhmVZmLTmuvTj/o743CVcIkWPY/hR0QSB3LIOtk8AsjpL8lozaVGX
 9FnYfA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgm176-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 22:10:30 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-13825e1dc0dso10377547c88.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781043030; x=1781647830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JUnTLcgtaDsF+cGcTfD1Yl0hWwqDOAFQZG4nnvbJ+ew=;
 b=hVq6Ru3JPeOjdG7UM0iaJ9PzOF7txD5965ExZdHyv3c2LHNimcxE7fsrpIA3zWLzn2
 Vo+W9Ux0mCoGTmm0nYP+RsayyYm2VZG7lKGvHpmxtGo+iet10RhTMcn9trPmT3/AIwpQ
 MjBrvHJDSOUNfuWgUW3p8RAD5jvVVpqu9ghoJTHhxLSpUNNZRT8G3L6OEzoK/YJOaE/q
 AlyfcdpvQtvOcxhPp+KGabwtm0TlzycIgqohdoej8U/cT1bA1TPukXe4OsVxhk/Nusdh
 kBniOpjodoitV4ebv0QPRt4m8VY2suCccPSAZaoyWzMHd0QY4WNfnNmOLWnVKLZs/3uj
 Kc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781043030; x=1781647830;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JUnTLcgtaDsF+cGcTfD1Yl0hWwqDOAFQZG4nnvbJ+ew=;
 b=Dnx56j0wBDs8jEHbWXoqQJKfiefQ0FlQk3hkA9n/y+l3vQRRE0lGURa6ybA8UJe3so
 Bg9jy721tl58/OapKAib+GPDcYd2Igk9HBOrYzyQbf1mSYn8r1e8Pj8a20lxREs9mz2c
 8u4nc4/Thg/xJYVE2NSI20hVpuYwhhU5W4Lqu+4jbdq5GhjD0x8rvSi6M5B71UtbqP/v
 RrgOCaKvvv64KKVvH/NTxJgi5UgNNNYVe4AfVuc5O7/cTqXVyv7Kq/MpLBPdXUcdQ2Mm
 Qtnn/AY3Cn/2bzSDZkwUjzJfj30XBZuz/OGXbxB1Q8YEcnnRd8vKKwHYU2qUyxWz/qb+
 F6uw==
X-Gm-Message-State: AOJu0YwQzr+dzVYMDzNBP0+9Lh2gZ4HlJVSc6hAEa8m42nqpqCwnSiUM
 6ReGUQavGHTc9Ucf6cJMYz/KakOjM6i4hVcerHf/qBXMxBOAaIDo+Flf7NesKhLaTfhZaQGuzUi
 l/UFjQcit7hDnsxS9uoAP9ZiqqpqcyI+BYvU2mzfYgpbYokDm4eX38H4RW+LeHcS6erf4
X-Gm-Gg: Acq92OFQVGQCGey76pz+Owjlpw+2CKLNQq12TecCCEKnIbP/edsevU+hV54wxym2xq3
 UYotUeqoPJwktfMplDDUI6Iagp+Bl86Y/9i69VWWVoGrTQEE3+fP5di3AZC5vkQCR2EBSfJTBx/
 U2XFzx9HGeVfZFHN0k8tip9Ghezm5zekGJ2joGu6XN7STpTfrq5YRioOkwLmqufBQ2N0rpzcBhv
 98OVyNZtlGmNAKUQ6zDbHob6sxjAaLCbpqnRSCPDhakPZBSGwcqdh0Bz5CY7YNzhsju41FTRaG3
 Ws7TgVZ3cauaRvuVq1odUrfRUwzZ29brmv3QqLJfHXi8yRt1reoHvwSRA/9MGK8zxaC2lfWmkZn
 itZZ4GVZBn9skMqPG44tRD0y+97A8Dd6+kRptZ0bRqtp2fp72Y0oBhkpQEnkLvDNmg6AuCqz7Tv
 TfE94jk5UpQldnWaybuBztdfH0
X-Received: by 2002:a05:7022:6a6:b0:136:d421:9efa with SMTP id
 a92af1059eb24-1380674e90amr14261171c88.32.1781043029968; 
 Tue, 09 Jun 2026 15:10:29 -0700 (PDT)
X-Received: by 2002:a05:7022:6a6:b0:136:d421:9efa with SMTP id
 a92af1059eb24-1380674e90amr14261132c88.32.1781043029366; 
 Tue, 09 Jun 2026 15:10:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5539432sm19854695c88.9.2026.06.09.15.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 15:10:28 -0700 (PDT)
Message-ID: <26d378c5-e5f9-4973-9db8-9c07f9eef8de@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 15:10:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] tests/tcg: run tests with meson
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwOCBTYWx0ZWRfX3cWamveIu5uJ
 RTMNMcguNbOGlp8xsRvfO04JAMRWtxKvlQ2BKuVNyCSnogJXTxmt9cesBRHhGWYWavtTs+w8EPr
 dcsWfWUePFysSCMVedVST3fsn9k7hI5lm/XxRXbRFRdksH8BI3uXV1EoWr+UF9f2/8RucThXg1N
 5rXb5C9f2gJ03Bf8BYQEtLGwocXxrU8AVyRRnc7kAornjBGDmDWiCF72yW2GT8p6zNewFmF7/qi
 Pa+Pizv9VUuxhh4Uu8ALf9dxFAzTVTl8TdVv2kkwAdv0KQveQCmRNrZsorLxxw7SFvgRcUBWhcS
 9ijORykYWt/QKWNYjdpg5ndfcjJcwjDshCx4tNnaEtIW2Wj3EjVU4nEBxwqi629KRJ1hpWA8ECu
 oBBQ8xalIKsLCvSCsfBPiCTWL5KCT1/v/g1xFVLOmFWAwCCrIWV0+43AGpVNemst4x+W/Con03m
 MEPZejBraMnM0ml4stQ==
X-Proofpoint-ORIG-GUID: zFrSRfMY4GkKPJEuvZWmqBlVoFO7NTBp
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a288f56 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=piWfC1Svpkpg1JSOyhkA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zFrSRfMY4GkKPJEuvZWmqBlVoFO7NTBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090208
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For reference:

On 6/9/2026 2:47 PM, Pierrick Bouvier wrote:
> It implements all requirements listed on original thread [1], except cross
> container support, which can be easily added on top once we agree on the base.
> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
> 

>>   - support building tests with containers

to be implemented in future version, but nothing blocking.

>>   - handle all existing tests
>>     - per-arch *-user and *-softmmu
>>       - including post test validation checks (conditional-diff-out,
validate-memory-counts.py, etc...)

Done by adding the 'wrapper' concept.

>>       - per-target overrides (some targets are broken for some tests)

Each target includes what it wants, so it's free to skip/customize any test.

>>       - custom QEMU_OPTS for some tests

Done by adding 'qemu_args'.

>>       - including sub-arch tests (e.g. x86_64 includes i386, mips64el
includes mips64 etc...)

Each target includes what it wants, including sub-arch if needed.

>>     - multiarch tests for all *-user targets
>>     - multiarch tests for all *-softmmu targets with boot.S
>>     - gdbstub tests

Done by adding 'gdb_test'.

>>       - don't forget gdb feature probing for arch and arch features
(e.g. GDB_HAS_SME_TILES)

Done by comparing gdb version as needed from meson.

>>     - record/replay tests

Done by adding a record_replay wrapper.

>>     - tcg plugin tests

Done by adding 'plugin_test'.

>>       - modulate plugins over tests to avoid combinatorial explosion

Not implemented at the moment, but we can use any heuristic to limit the
PxT expansion.

>>       - filter some plugins from general testing (e.g. patch)
>>       - filter some plugins based on mode (e.g. syscall)
>>       - specific plugins with specific tests (e.g. patch, memory)

Each plugin test is explicit, so we are free to implement any policy.

>>     - support build variations

Done by adding 'cflags' and ensuring we can't create an accidental
duplication.

>>       - compiler feature probing to gate tests

Done directly in meson by testing compiler.

>>       - custom cflags for some tests

Done by adding 'cflags'.

>>       - alternate cflag builds for some tests (e.g.
sha512-[vector|sse|mvx|...])

Done by specifying a different 'cflags', and an alternate executable
name with 'exe_name'. We ensure duplication is explicit.

>>       - build scripts (e.g. test-mmx.py)

Not needed in aarch64 at the moment. For this use case, we'll generate a
header using a custom target, which will be a dependency of final test.

Regards,
Pierrick


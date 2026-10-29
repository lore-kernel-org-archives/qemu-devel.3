Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2963A606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m8RQjGBo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HK1MLXND
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJLI-0007DY-SL; Thu, 29 Oct 2026 02:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMJLG-0007DP-7l
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:10:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMJLE-0002kC-54
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:10:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5GmqO204358
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K7Ls1t8bS5Tv1AWEvvKFHTmy5e/6/NhXGPucy4Feekg=; b=m8RQjGBoKW/BAGpu
 paVw475D5cMNV//vaoyJ/9Oal41I3m8X7TXNeiFyiO4Gxf0NOd+WwMjjRR5kmgej
 00x60uh9nqEoExKelHlgqIRhUc0Zcvhhy4vF0g4LoFQyDHhqwq38IbZ9PyHLHdI8
 Q1ZDsTbyf8ruvBOue7eiSbTVRAQPnYQk01qV103W+QRJpzmtsmky8b00xnvpbUn2
 zmdr82Su+jVxkXhbcLO4njyE86ACQkWjq2aJwuuOHxQuA5yuEte8wv00voMq8Cyo
 N+ClzW2F3DZfGJPoSqnPvTOYNX1stex8fmfpDHh/loi8iGyAIsMqZHscBZOJlmiG
 L1WCgg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkneutfuy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:10:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f3969a2a7so253663385a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 23:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793254221; x=1793859021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K7Ls1t8bS5Tv1AWEvvKFHTmy5e/6/NhXGPucy4Feekg=;
 b=HK1MLXNDJJgQwhJNfLhDe1OymBsSL6IeLX6i0u6ipDS6xK8S7FTvypcqFXM/g+bdh+
 dxIOnbT5iNS79rdmXlVfkYfYgtisAY2x6UPXs7shYzcR5hQeVw+P1VtJJr5gsQKe0lV4
 XNkTrDyu3r6rwublXpg6afHv+nezByReqUhwfAoN9LfqcPeMhMNOXqVAYLE0jdH7WYi/
 5zwu3q1eCB+zF4PJrEz2M6LrrGxG8wow069hbgy3LH7x6eklFNRDP07W0bM/lawqg03m
 RI60huTxWC8jc/j+RDvRLWkHeq56xgS0HHZCKvGblRCkRQXTPOytUE0rcM71VBlgrodX
 LOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793254221; x=1793859021;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K7Ls1t8bS5Tv1AWEvvKFHTmy5e/6/NhXGPucy4Feekg=;
 b=K5w/FXdm0WtGvx2j9SnftJaqaen+Eisctu4qbGwn3rRNheCQYAxA5N/WJzOTBkEvMX
 PI/W4P0y5BhYHsptSzvd/v8W+olur7Rdbcu1m/Wf48Xc+0souCrSeDzfgjzA1E3kl2i3
 0Kb4K5LlMjuABXN9HiVtWFo70/iSBwFie8QGWU4pgQV/HqC0OoRo5NWPh7cljYEEJYpP
 A9rUkYNzUb7iCuefOLq6nohNXmy8C0t8oeQ5Eq1QfGhziSnifPm3N1/tco4/szqZqq0M
 s1O+nU/Y0hLy78qVvJffzYQkWFO6BIWUhFhmsm175QwzC34EdNrlUGCyPYkHpSXzBkX+
 P9vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjmY+ABLXNzMLzPvYJ1NlkCEvcaqzmwiKs8Y22fmuUqbHURovhvEt7hBH0wMKuvYK5Zf4EO0f3k1KQ@nongnu.org
X-Gm-Message-State: AFq9FYKSDcjeHEG5JmQacifbWbRrgJ/qZBV3Ynw0qBg5JHb/cfmsePD1
 5U+I7cokky/Os62jHl3GO/bekZbT9WwabBR42/W3eZN+7pJlooq2fcVdmCyV34WYePcf1HGEvyp
 uhuR+yGtSRZeIJZN+lhnNQHh9culgvxQ+/x37L4v1RV1nze9oODpkFAlWeg==
X-Gm-Gg: AYBFou27OFcXJd5ryhdQEp+K7mGZ1iKX7W/TRnlWOUoSgaTvAl1UcULqW9Mbweb30An
 lWp4FG1bmwya20plb7q5ngFaT67Vq6/B+HsaUmSUTG6d5CwmfYjmwSpFG5898Ifym7Zpxni2zwb
 LHwvANRn7a2z+EYl3DC07qznSiItAMLCcM/cYwJflxlNnspD8yxM/qSAxHmZqI2ME0d4j3F3O3s
 TbsgnuvLZNztCPTGexCP+Nx1prjlhnW9t3sQqUCdWU74hELOLw3bAhGPr8Dlsab7V0Yl42FwvkC
 GEVArB8fm3AVR71C78Mqzxq0a5+ndhsy1ZLEf1UjIxXOU4CKQq7fuJ3/+ywKXeaDcJp6WSiOou5
 52zoqtzSUsBnV2/axYcqj8rRtWiuCxpNqAFOHTkz7e8WOkw49Eqmu1JtqWPu6v9wuCP9crsNv0b
 D6jGjl34iEDd2YBLvvtnSGVUo=
X-Received: by 2002:a05:620a:4102:b0:93e:c12c:43fe with SMTP id
 af79cd13be357-94408d4f5b4mr654401485a.75.1793254220757; 
 Wed, 28 Oct 2026 23:10:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4102:b0:93e:c12c:43fe with SMTP id
 af79cd13be357-94408d4f5b4mr654398485a.75.1793254220131; 
 Wed, 28 Oct 2026 23:10:20 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm30560201f8f.22.2026.10.28.23.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 23:10:19 -0700 (PDT)
Message-ID: <6d7bb396-7f1a-4732-81ca-adb16b8baeda@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 07:10:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] target/mips: Re-introduce the R5900 CPU (system) +
 sort tcg tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gustavo Romero <gromero@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <28e90058-6b1d-40ad-9aed-590107f3f77f@oss.qualcomm.com>
 <a3555348-c24c-4df5-95a4-b4ab0a7490c1@oss.qualcomm.com>
 <4ef98888-b13d-4033-aa02-f48482fc0b7a@oss.qualcomm.com>
 <8628b8e5-7138-4f2c-bd32-ce8a8cb9acff@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <8628b8e5-7138-4f2c-bd32-ce8a8cb9acff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMyBTYWx0ZWRfX/wPLsFuFt7cg
 gYR69yosq8X19Qt+T3fjZRW+wKtgUqUbh4dL+bw6EApO9Kf40G2COS3utK25KevMtvzNcUoho10
 AWwfgNt+tpdbDXglz78P7dN393VKbR0PFNboWZyC9u0/Qu468Wz6LXjGvwQROBPhpwCNVxsa6mU
 D0A6HjObp6/65HOhmMF8istQ47v7MjQBrqoGiU/NYpY92VQkWkhWccxP+U3isHXyzAfs7XHqmwH
 UfdYL51EQZdzjxXjD4H7uaUNtyjeB0oDWkQomV0pZ2xs1vEMGJIZyWgBY8RcxoEgHd/+o2+cfM0
 3qYzpoda5JSgL7rgfJpvtPNPyAhFyy7zGrK6+bu64nysR+b3lKVfDt3k6Y38al0qUEnSfCxT9HN
 COe8wvpIDbWOZlhQuxmcy5Osi0q79bzuDk2BCv2nmb59X+UsVVhdRnsxNV6skHxpyWMQdJbJUud
 dHm0HG2L2cD2sthhAXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMyBTYWx0ZWRfXz2tUfdqYPO6s
 GhwJIzf/CRC25kf8MJc7zDLrWw/vk/sPRcw8zlgkBiOy7lvSYy6QvuUuwi+Ibc+uUDUM3vmtj3/
 FubP55oZDOPVJcEK9oGRuHztTlY9kDc=
X-Authority-Analysis: v=2.4 cv=LoAHWXdc c=1 sm=1 tr=0 ts=6ae2e34d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=1PkH113_3MLykW84BhQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: gLfkla5NyBWAcjf7Rj3xCFiLD27NkfvJ
X-Proofpoint-ORIG-GUID: gLfkla5NyBWAcjf7Rj3xCFiLD27NkfvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290023
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26 06:51, Pierrick Bouvier wrote:
> On 10/28/26 10:46 PM, Philippe Mathieu-Daudé wrote:
>> On 29/10/26 06:39, Philippe Mathieu-DaudÃ© wrote:
>>> On 29/10/26 06:33, Pierrick Bouvier wrote:
>>>> On 10/28/26 12:25 PM, Philippe Mathieu-Daudé wrote:
>>>>> Add R5900 system tests, code is covered, CPU can come back,
>>>>> allowing to fix a bug on PCGT opcode.
>>
>>
>>>> See some test failures, related to gdb:
>>>> https://github.com/p-b-o/qemu-ci/actions/runs/40776744817/
>>>> job/123131480244
>>>
>>> Ah hmm I had similar failures due to too old gdb, I might have
>>> missed to check the version in that container image. IIRC
>>> Gustavo had similar problem with ARM I'll see how he fixed
>>> that (I suppose check gdb version and skip the tests).
>>
>> Found it, this is 'gdb_feat_version' :)
>>
> That's the right way to deal with it indeed.
> 
> That said, the gdb used in this test (on GitHub) comes from debian 
> stable, which is fairly recent (16.3).
> 
> Is a more recent version needed for complete mips support?
> If yes, I can update to the latest gdb so we can get full coverage on 
> GitHub. Meanwhile, you can find which minimum version is needed.

Indeed, the problem is simpler, located in the 
tests/tcg/multiarch/gdbstub/registers.py.

Before there were no register descriptions for MIPS and the test was
skipping (registers with no names). Now it runs for real. Apparently
this is what commit 6ef164188d00 ("tests/tcg: finesse the registers
check for "hidden" regs") aimed to resolve but was a bit too
restrictive, this fixes it:

-- >8 --
diff --git a/tests/tcg/multiarch/gdbstub/registers.py 
b/tests/tcg/multiarch/gdbstub/registers.py
index b3d13cb077f1..8d886413eb28 100644
--- a/tests/tcg/multiarch/gdbstub/registers.py
+++ b/tests/tcg/multiarch/gdbstub/registers.py
@@ -180,10 +180,13 @@ def complete_and_diff(reg_map):

      for e in reg_map.values():
-        if "initial" in e and "hidden" not in e:
+        if "initial" in e:
              name = e["name"]
              old_val = e["initial"]

              try:
-                new_val = frame.read_register(name)
+                if "hidden" in e:
+                    new_val = frame.read_register(e["regnum"])
+                else:
+                    new_val = frame.read_register(name)
              except ValueError:
                  report(False, f"failed to read {name} at end of run")
---


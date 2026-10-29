Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52209606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ChlDgbP+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aBGN7z29
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJ7T-0005Ua-4O; Thu, 29 Oct 2026 01:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMJ7H-0005U0-GW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 01:56:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMJ7F-0001el-GR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 01:55:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5GwM42974023
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vvPWAeRxJhh9z8HfITX65IMqzZd0bXsT5v21LC/R3Io=; b=ChlDgbP+TOdEyPyn
 Sxm7ZfzwCKeXAq4SAcHBBmtXBX2z9BJnoHaPkabg2/M9FgTQxULqrl9DC9dipWW8
 VWOsYXHEKtsqQrNC19F6AoBJPfbKYIpiKMNygM7Cb9pn+6wnWZ8TN1xBA7nCp9pu
 176ulrv4byqoLlgfT3qsqCWGq0RXY/74qU4yxXPKV9xX2ebs/Navhf91CKLWpS6g
 pA9X1XuytSQwOUzAm7HjrlajESzA16intnwMKgu7a51VLrQmL0MXvNYed+Ai4rHI
 eS3g9h9bGPbQcSc3kZG/sG43ADK+j10g9yPFoFUWBS4Uo7fRL5Soe+c7/IhWhvFB
 Vjexcw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkpac83-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 05:55:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f1e62510cso423706185a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 22:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793253355; x=1793858155; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vvPWAeRxJhh9z8HfITX65IMqzZd0bXsT5v21LC/R3Io=;
 b=aBGN7z29Z4gmbGvgwrOJhawSFFZPoROYULoHufincZq061NO5mVoTm+sB4g+tDX9xm
 wii4EfykR3k3m/Bdb+IRTHgaXWlPrczUJfvfInohykS2W7EGxsogAY1uI3OMtKDmPq9Y
 6KEQd/zNTwrs3h3Wqhk8m9JLwTkzhU3jqD1aGkmficm+AygLdJak9KhnRE3pnJFSlNr2
 1QN8kGf1b8oXv3Vhr6nmcB8PP4ASgmYUrGssqgDrI1DEPKI1eodcXoE3GDS10d700XAZ
 xma2vKxEQ2/iCehmO/iX1SC+lnPIQITX8VdE5EOe8EIiPImVeU6Nd1gKDLcXwG/R7Zsz
 1ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793253355; x=1793858155;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vvPWAeRxJhh9z8HfITX65IMqzZd0bXsT5v21LC/R3Io=;
 b=jWuUC/fEQAzrQH/L+fMtSZyb05gooyaLm7SDvZB4CHTGYTFfTNLO/h6/D2LhX1icte
 tHPJByWU+P4qnbTMM2KMBjqWG9QHSJFQWL359RPUM23IFrX4PWeztf3jNjbbBONLGqfY
 OSdFelSSApgUSeBDL4hXvOiJNHAWuHho+cZiLu8AeQz4Fp55TgcIHTH2gpKNXX6emea8
 HlavbrMSAUBmoDQAsw/JFUW+eDvywRDVvKzjdkqCww4l0a5OSDpVOUCrL4zdUZO6JLDP
 QOnCj07v58+7JZGMaUXv7pfddVsj4YhtmNm8iWw1MTY4xmw0UMLnZgGSsDwauPc8y6Wh
 91Bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVmQ73ibhVjPmO3mdXYLmyx4Ex5qhY4Qn9xPGZKj21FfDjyQA6LN4EOTWyA2ifwhIqkqMrngA3v2Ll@nongnu.org
X-Gm-Message-State: AFq9FYJTERB0Bk0oxatOD3/zpBBA9Lv30lQVhZYbH6VMLTWtgd18gWJn
 Hf9xxw7IfHEzPFfXjH6B8Ez2HwO3S9mkQn17ERf6142jYroGNe/FiiDFwnJAGCRkalQCPFnKv5Q
 XcF5WQripH+hQ0B4geJoNhj1gPh/S4m4MpQoxGe2lljkwPmZlFWkY08qOrg==
X-Gm-Gg: AYBFou1888xt13fh9Y8fXarB2SYBuMDxaWEBpxtPeFSIfelVM+hPErdXzj02qRPnlJm
 xDYftvQzD1BmA7ibicAEe9qiUP0f5LGSx3vOe822bEUTMmyf/ScUO0/mFXy27qZxWq87xKOZjYA
 VsNq5Jx/1x7XSoA8OP//e33qVCYHNv97PHcHWuAM9VyAUJXY5KlcsI6udZyOdvZGc/4VogvAP6S
 kjNkBSuiBskGKZtNebTWqrTRAlWLPUUYRQKHWgZ1c+GgifR1lugShmkU8+oKisdd7fVfo/Iz+jO
 nOtqX8rFgwaqJlJXWMM/jsLGbhL4LaVlDUGxwVlFViv/wBO/cFV1YJ4vVdX283ERZMOEvDcBBQd
 beEiJgMAB9XhyolP0tzbYAxNU5CCKNegc+xn6gjZddSiJt98EHV5SFC9L/QqAi78pX38V4yGjwU
 Ws7Ts8lWhfYgwhLUnT/VmBPa0=
X-Received: by 2002:a05:620a:4147:b0:943:b019:f011 with SMTP id
 af79cd13be357-94408a6fc8amr678694985a.28.1793253354760; 
 Wed, 28 Oct 2026 22:55:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4147:b0:943:b019:f011 with SMTP id
 af79cd13be357-94408a6fc8amr678692785a.28.1793253354278; 
 Wed, 28 Oct 2026 22:55:54 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3c32sm33673945f8f.47.2026.10.28.22.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 22:55:53 -0700 (PDT)
Message-ID: <845b60de-e87c-4025-94ca-166a9e518226@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 06:55:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] tests/tcg/mips64el: Move R5900 tests to system
 mode and build with meson
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-6-philmd@oss.qualcomm.com>
 <aff7564f-c8e6-4c56-8e1e-cd7f7613eefe@oss.qualcomm.com>
 <7e6c2d31-9bca-41ae-84b9-10b6dd11c6d3@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <7e6c2d31-9bca-41ae-84b9-10b6dd11c6d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae2dfeb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=gKY22YZMuZRt3QebDc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 4ZpxMfhpdkj4xWekJHnrQSjpoPTGTvW5
X-Proofpoint-GUID: 4ZpxMfhpdkj4xWekJHnrQSjpoPTGTvW5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX7+4zM06liuaF
 2sHwJaA92Hr4v0GHBA+K/mj51N5QziRCSoF51aHakDQ88n35oVhX097MLuAmw/D6nzxuz9Glied
 GuX22fLR8pNLmu1tme3+Ae7kW2d7itc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyMSBTYWx0ZWRfX3tlinh70cjyw
 0emjfHwmQWdiGKD64IdA0Z4IPhAvV39ZE6uoyq6KC+nPUA3pcW8I8mDvJisxZycKf4QgJoM46H7
 UuXBjL6wfH1RkV2WVxFRcdndwoi4kQEuAk29zrhKghBtJMNDtS7p6ztJwQCqj1WMr7OnqoVWFEN
 ORyPyQIihpq/pGuYHsPwdNUN6rkvYw7QzJaZQwaNZQbX9Pqdyq34zeYbafdlNACc6kfDsXBTPZ5
 EVqWWC85Fzj+ZINVCOM02hMScHOYWW+NUJNFjCiu1KGvgs87ltBNUkJiwp5ufUrrwyuY406FuZ7
 VXu82L04H2jspqFAQpHaDa7gg9XIbSiCDI4QgxI+TKBJDL1wV+shR854Fvw6+YTMKyVF2rfqUtE
 im+DhRl32OPkF/GykbnTBopHNV7Is4ijGi0TI3Kno6K1OUfZZv99pk7wno241fovI/ZvngEFJZF
 jcLEUr6YD9Q8TIah7AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/26 21:41, Pierrick Bouvier wrote:
> On 10/28/2026 12:39 PM, Pierrick Bouvier wrote:
>> On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
>>> The Makefile needs a toolchain we do not have and qemu-mipsel,
>>> which no longer provides the R5900 CPU. Move the tests next to
>>> the bare-metal harness, register them in meson.build, and remove
>>> the Makefile and the obsolete README.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>   .../system}/test_r5900_div1.c                 |  0
>>>   .../system}/test_r5900_divu1.c                |  0
>>>   .../system}/test_r5900_madd.c                 |  0
>>>   .../system}/test_r5900_maddu.c                |  0
>>>   .../system}/test_r5900_mflohi1.c              |  0
>>>   .../system}/test_r5900_mtlohi1.c              |  0
>>>   .../system}/test_r5900_mult.c                 |  0
>>>   .../system}/test_r5900_multu.c                |  0
>>>   tests/tcg/mips/user/isa/r5900/Makefile        | 32 -------------------
>>>   tests/tcg/mips/user/isa/r5900/README          |  6 ----
>>>   tests/tcg/mips64el/system/meson.build         | 20 ++++++++++++
>>>   11 files changed, 20 insertions(+), 38 deletions(-)
>>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_div1.c (100%)
>>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_divu1.c (100%)
>>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_madd.c (100%)
>>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_maddu.c (100%)
>>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mflohi1.c (100%)
>>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mtlohi1.c (100%)
>>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_mult.c (100%)
>>>   rename tests/tcg/{mips/user/isa/r5900 => mips64el/system}/test_r5900_multu.c (100%)
>>>   delete mode 100644 tests/tcg/mips/user/isa/r5900/Makefile
>>>   delete mode 100644 tests/tcg/mips/user/isa/r5900/README


>>> +# o32: 32-bit pointers, 32-bit GPRs are enough
>>> +foreach t: [
>>> +  'div1',
>>> +  'divu1',
>>> +  'madd',
>>> +  'maddu',
>>> +  'mflohi1',
>>> +  'mtlohi1',
>>> +  'mult',
>>> +  'multu',
>>> +]
>>> +  tests += {
>>> +    'test_r5900_' + t + '.c': {
>>> +      'cflags': cflags + ['-mabi=32'],
>>> +      'qemu_args': qemu_args,
>>> +      'gdb_test': gdb_test,
>>> +    }
>>> +  }
>>
>> Just a small nit, please keep full file name in the original array
>> (s/div1/div1.c), All other meson.build for tcg/tests do this also.
>>
> 
> (s/div1/test_5900_div1.c)

Squashed:

-- >8 --
diff --git a/tests/tcg/mips64el/system/meson.build 
b/tests/tcg/mips64el/system/meson.build
index fd5a759c20fa..c16a21f57aef 100644
--- a/tests/tcg/mips64el/system/meson.build
+++ b/tests/tcg/mips64el/system/meson.build
@@ -21,17 +21,17 @@ gdb_test = ['--gdb-args=-ex "set remoteaddresssize 64"',

  # o32: 32-bit pointers, 32-bit GPRs are enough
  foreach t: [
-  'div1',
-  'divu1',
-  'madd',
-  'maddu',
-  'mflohi1',
-  'mtlohi1',
-  'mult',
-  'multu',
+  'test_r5900_div1.c',
+  'test_r5900_divu1.c',
+  'test_r5900_madd.c',
+  'test_r5900_maddu.c',
+  'test_r5900_mflohi1.c',
+  'test_r5900_mtlohi1.c',
+  'test_r5900_mult.c',
+  'test_r5900_multu.c',
  ]
    tests += {
-    'test_r5900_' + t + '.c': {
+    t: {
        'cflags': cflags + ['-mabi=32'],
        'qemu_args': qemu_args,
        'gdb_test': gdb_test,
---

> 
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Thanks!


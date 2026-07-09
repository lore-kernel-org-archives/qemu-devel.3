Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBFFC44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whplh-0006Pk-3j; Thu, 09 Jul 2026 10:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whplf-0006PL-3d
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:30:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whplc-0000Ww-DH
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:30:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669DwBJq1884242
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 14:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8fRMdA80WYiCFZ6oJDpKtaSl3RjQ+wPCaXagRFMigZw=; b=d0bb+9LKrxSVhxZJ
 yAKxNvfy3M/dnEpwtoAogAUsjVpEUNrDT35n5LHZ/hUXy//GMy8BSsV5GLmZAtJY
 B9XQVLqJGWgePqzZHVGopj+ng+cq9lPGqj+mhwDdudPZ+H1nR4HAvmnB95O4GvIi
 a32WJckq9l55wiU5fD/2fWWg7XvEEB7ApDY7HPt3aIcO3NG6+3SmGRSUkyRq6vdV
 eHQVY4sBFkG1frEr4fI/LDCj1XbKFFA3wzChDhIXsOnlv4EVUsLU944OA4gnYb/d
 sSBpXRNVKJea7kTQkoF+Fl2Tg0yQiPpjSOn22W0lLbn9ohZkEHwlr8iLp3Bp1wj2
 +9eP6w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydu777-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 14:30:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so705655ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783607418; x=1784212218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8fRMdA80WYiCFZ6oJDpKtaSl3RjQ+wPCaXagRFMigZw=;
 b=bRsCBLSIhoYUxy5uAwJbucvkacpN0X8TSS3WS03HmZ9ZhD0jpzWEzn9lsL0AW+uuC8
 6qmUJxT5BaevnxUeqGNNzuMede4Z7/m69ymEXwrZqpRlDuoTLetHJrQIGOlr6TOIb+Yv
 Hy/gh1OOJT+dCetUMhWNdR/8T42a9sQ4LvSgMaHL1bYeMjPN7Fxj6qUgae6WXEGAfPCA
 tSMx9bgf2LblXpz8Gi/V/HWrV/Y+U4ZYIjFI++wmTfme0rxx7CsRBKJFRgrLfQIodLyh
 sTmurIaStR/pMJs17v70CaQ2DFrbkbul7JlhH8N9F8BZgQsZ2buL48eG0cZgUI/hvhgE
 rIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783607418; x=1784212218;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8fRMdA80WYiCFZ6oJDpKtaSl3RjQ+wPCaXagRFMigZw=;
 b=hwLB0wlcJrUI2lOqCY+FlLsiYE5ati+H1CXuLRKtKopnKZBB13JkdB2Ma6ltUMAZE/
 SQfAwrcG+FBh1WWUQ2kKbPYAl4fNaDzVReAg/9+/VtxVanUQywCs3EHhspxkS0PY4muw
 kUD7rhBMMf04/XlcX83T73FCLHCA0bYJmQM9vXNSIqmJ+AcL2fftlBzfJLFCOE7/e4MM
 Q1Bh3B9/bo1O5D/bx5ApWPoYlwNYXL9qNsmC/9Rz8XzgCQ/3T+M9ecVnRnnDCXHySXee
 sq9NFSKTA4AD/qqznkZgmOCCGWmOWWBeyFxeqy7kREVsn+zcbarGaa/YMlk9M05MaIJC
 rMOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrd1pwJe1py+cotnBReIFT8AvZz0BKv/uVFsRmrizIxwUXc1AuOl/jPMeS5Yk0woLNAZERS2+wl0S/4@nongnu.org
X-Gm-Message-State: AOJu0YwRsUNUXxEky9OYfyyypQDCWj0H2mepDRA2Uor4SeXT4z8z7hxP
 WG9sFJXEe7Vx3T/ejXtmDdHxAz4XJXlu9eQjI4fpeBZGbbY0sY+TVF4OXznZJ6CGe1tlAT7CDcy
 nuLNn4Ry5V3lC3IsecaLi3GqqFS7xeXlmudpUUDozVksz+uHdJKO2TI8JtQ==
X-Gm-Gg: AfdE7ckMELqbluLDGrv5V+R6xMiR5W+nq2fdMyIidMHX+BdJtbengL2xGP9ufPqyst7
 YOA2Si5nue1xZKT6Y+26MuziVoACqhMh0dXyI0hG0q0JVkJPbuq4lZhee4IoGKhwbeolfe4KpJk
 HW8oVHKjJKcT/nTMTFo69LIen9rwbGpWkJFR+InL0h7vlxeg3V2bqV1rCWtvwcmeKsvzsXgRSvt
 1ltZqk59F1F/jfqwu7eEDcpmkYMlwt0rwpkgWXWj/H25EfUtwYrWnlBmOp7DhcAmVvongSZaxCZ
 OxKnbGNsJ/MGLX3LB0s9K0mVPW80sAG5U0foatxxiiADtvfPyTavSg5839LB2iMmE8HqjS9AsUX
 WywCTF2HxN3040zZtkFuvqXLXg6MR28q/lQlXD//QCkoWehfMCZunc+NgSR4Dnc0AW6y0WBDiGK
 QlwT8=
X-Received: by 2002:a05:6a20:12d1:b0:3bf:a517:cdcd with SMTP id
 adf61e73a8af0-3c0d68a85c6mr4219354637.12.1783607417457; 
 Thu, 09 Jul 2026 07:30:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:12d1:b0:3bf:a517:cdcd with SMTP id
 adf61e73a8af0-3c0d68a85c6mr4219293637.12.1783607416817; 
 Thu, 09 Jul 2026 07:30:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d7c8bsm33852051c88.12.2026.07.09.07.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 07:30:16 -0700 (PDT)
Message-ID: <baa75488-b9ff-4183-92df-e5f375575839@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 07:30:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260708152043.251537-1-functioner@sjtu.edu.cn>
 <20260708152043.251537-3-functioner@sjtu.edu.cn>
 <6abd4f15-03b5-4036-a016-74269e87c36a@oss.qualcomm.com>
 <f6600480-2cac-4708-8a3d-b2c69d454196@sjtu.edu.cn>
 <2c33043b-da8e-4b3f-8f17-c574b4632fcb@oss.qualcomm.com>
 <2b67de22-f710-4b44-9e37-858a9b5b1e64@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2b67de22-f710-4b44-9e37-858a9b5b1e64@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MyBTYWx0ZWRfX9FrxKbvAMdtg
 G53V5b21bsy3/dGeKRVig0uIGNmU9v6i8En/R0mvIFScywPqPAjv7hngzbVGwyWHW02Z4kyjpeq
 P1HzNApwg95uvBcOtzIQ83iA0pD/xIE=
X-Proofpoint-ORIG-GUID: 5oVjdjt07k2t1yLU4qsP8kmoBWINk_Rc
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4fb07a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=9QnkZOefQ_BZJSPh0l0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 5oVjdjt07k2t1yLU4qsP8kmoBWINk_Rc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MyBTYWx0ZWRfX7glQuHSvrOk3
 hm/0W/KPzglsrS02MxVTozhKnpwGFsEqEsd7TBjUAsemG708ZwwWG7JalS+vgCDUcICeNuC3sRg
 1gw0xae4lwTU6pdBpyHClobpUot7UWxox+FBJl3YcC3wv4+9J15LkiOj+ho5nQIQagX1BOALd/k
 R+0hUbic8tUJ5EsvkrogGdS49H0qEC8y4818AaT5sO/SqOfhCINksfsu6SOFLscZ1EHBsr3SuM/
 cRSe5/tHJvTHUEJ5Zd3ad61iGaAcEvgq7NzVa54GEgB/bn8j0MTcOEHDx3T0owWXaBTa4U1CDis
 uBG+3l6Lm4KS6dbXpTZyjaK4iO8jfHQiytF3ogf06xooQmAygXAXlFaZ4XQKjD51ZV3h99iw7O+
 qdUd/3Bnk/+vLf04SXyibOYTMGlS9Is2ruyJwJ6zgwX92c9p45xxRcJ26B9srzUEqj93mW+D1B/
 /uVRtJ5GKQK1Dk4GIFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090143
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

On 7/8/2026 7:52 PM, Ziyang Zhang wrote:
> On Wed, 8 Jul 2026 18:29:59 -0700, Pierrick Bouvier wrote:
>> On 7/8/2026 5:27 PM, Ziyang Zhang wrote:
>>> Hi Pierrick,
>>>
>>> On Wed, 8 Jul 2026 16:55:19 -0700, Pierrick Bouvier wrote:
>>>>> +A minimal end-to-end example wraps a one-function library,
>>>>> ``libhello.so``,
>>>>> +declared by ``hello.h``:
>>>>> +
>>>>> +.. code-block:: c
>>>>> +
>>>>> +   void hello(const char *name, int lucky);
>>>>> +
>>>>
>>>> Please include full files for example:
>>>> hello.h, hello.c and main.c calling hello function.
>>>>
>>>> Also, please include compiler commands for libhello.so and main.
>>>> You can give a full example assuming it run on a x86_64 host.
>>> Good idea. I will get it done in v8.
>>>
>>>> I could not get it to work.
>>>> Following all the steps, the error message is:
>>>>
>>>> [GRT] failed to load host runtime
>>>> qemu: uncaught target signal 6 (Aborted) - core dumped
>>>> Aborted
>>> On the error. [GRT] failed to load host runtime is the host side (QEMU)
>>> failing to dlopen the Lorelei host runtime, which means $DEVKIT/lib was
>>> not on the host LD_LIBRARY_PATH, for example if $DEVKIT was not set in
>>> the shell that ran the command. -L only points QEMU at the guest's
>>> loader and libc, so it is unrelated.
>>>
>>> I reproduced it: dropping just $DEVKIT/lib from the host LD_LIBRARY_PATH
>>> gives exactly that message and the abort. The real fix is making the
>>> example self-contained so nothing stays implicit, which is what v8 does.
>>>
>>
>> I paid attention to follow steps correctly, but maybe I missed
>> something. Please see here a full dump of my env and commands:
>>
>> $ git status
>> Untracked files:
>>    (use "git add <file>..." to include in what will be committed)
>>          a.out
>>          hello.c
>>          hello.h
>>          libhello.so
>>          lorelei-devkit-x86_64-1.0.4.0.tar.xz
>>          lorelei-devkit-x86_64/
>>          main.c
>>          thunks/
>>
>> nothing added to commit but untracked files present (use "git add" to
>> track)
>> $ ldd a.out
>>          linux-vdso.so.1 (0x00007f5855c3a000)
>>          libhello.so => not found
>>          libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6
>> (0x00007f5855a0a000)
>>          /lib64/ld-linux-x86-64.so.2 (0x00007f5855c3c000)
>> $ LD_LIBRARY_PATH=./ ldd a.out
>>          linux-vdso.so.1 (0x00007fef23831000)
>>          libhello.so => ./libhello.so (0x00007fef2381f000)
>>          libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6
>> (0x00007fef235fc000)
>>          /lib64/ld-linux-x86-64.so.2 (0x00007fef23833000)
>> $ env | grep DEVKIT
>> DEVKIT=/home/user/.work/qemu/lorelei-devkit-x86_64
>> $ tree thunks/
>> thunks/
>> ├── lib
>> │   └── x86_64-LoreHTL
>> │       └── libhello_HTL.so
>> └── x86_64
>>      └── lib
>>          └── x86_64-LoreGTL
>>              └── libhello.so
>>
>> 6 directories, 2 files
>> $ LORELEI_THUNK_PATH=thunks LD_LIBRARY_PATH=$DEVKIT/lib:. \
>> build/qemu-x86_64 -plugin build/contrib/plugins/libdlcall.so \
>> -L $DEVKIT/x86_64/sysroot \
>>   -E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64/lib/x86_64-LoreGTL\
>> ./a.out
>> [GRT] failed to load host runtime
>> qemu: uncaught target signal 6 (Aborted) - core dumped
>> Aborted
>>
>> Any idea what could be missing?
> 
> The "[GRT] failed to load host runtime" message is the host side failing
> to dlopen libLoreHostRT.so, and until now it did not print why. The next
> Lorelei devkit (1.0.5.0) fixes that: the same failure now reads
> 
> [GRT] failed to load host runtime: <the exact dlerror>
> 
> so upgrading the devkit will usually tell you the cause directly, with
> nothing extra to run.
> 
> Set LD_DEBUG for the QEMU process, and unset it for the guest with -U so
> the guest loader does not also flood the output:
> 
> LD_DEBUG=libs LORELEI_THUNK_PATH=thunks \
> LD_LIBRARY_PATH=$DEVKIT/lib:. \
>     build/qemu-x86_64 -U LD_DEBUG -plugin build/contrib/plugins/
> libdlcall.so \
>     -L $DEVKIT/x86_64/sysroot \
>     -E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64/lib/x86_64-
> LoreGTL \
>     ./a.out 2>ld.txt
> Then look in ld.txt for the block that starts with find
> library=libLoreHostRT.so [0]; searching.
> 
> A healthy load tries $DEVKIT/lib first, finds it there, and ends in a
> matching "calling init" line. A failing load has no trying
> file=$DEVKIT/lib/libLoreHostRT.so line at all.
> 
> So the difference is a single line. If $DEVKIT/lib is never tried, then
> it did not reach the host LD_LIBRARY_PATH of the QEMU process for that
> command. If instead that line is present but the load still fails, the
> message after it (a missing dependency, an ABI mismatch) is the real
> reason, and that is what 1.0.5.0 would print.
>

Thanks, I'll try from v9 and latest release.

>>>> We talked about not overriding sysroot, so please remove -L part.
>>>> Also, Why do current dir is passed in LD_LIBRARY_PATH?
>>> In this example it assumes that the host libhello.so is in the current
>>> directory, which must be able to be found in LD_LIBRARY_PATH.
>>>
>>>>> +The guest ``LD_LIBRARY_PATH``, passed with ``-E``, controls what the
>>>>> emulated
>>>>> +program loads:
>>>>> +
>>>>> +* ``$DEVKIT/x86_64/lib`` contains the guest runtime support shipped
>>>>> with the
>>>>> +  devkit.
>>>>> +* ``thunks/x86_64/lib/x86_64-LoreGTL`` contains the generated guest
>>>>> +  ``libhello.so`` thunk, used in place of an ordinary guest library.
>>>>> +
>>>>> +The host ``LD_LIBRARY_PATH`` controls what the plugin and host thunk
>>>>> load:
>>>>> +
>>>>> +* ``$DEVKIT/lib`` contains the host runtime support shipped with the
>>>>> devkit.
>>>>> +* ``.`` is the current directory, where the host's own
>>>>> ``libhello.so`` is
>>>>> +  located.
>>>>> +
>>>>> +See the runnable
>>>>> +`hello <https://github.com/rover2024/lorelei/tree/main/examples/
>>>>> hello>`_
>>>>> +(minimal) and
>>>>> +`demo <https://github.com/rover2024/lorelei/tree/main/examples/
>>>>> demo>`_
>>>>> +(variadic functions and a callback that reenters the guest)
>>>>> examples, and
>>>>> +`Lorelei <https://github.com/rover2024/lorelei>`_ for prebuilt thunk
>>>>> trees and
>>>>> +the runtime environment they expect.
>>>>> +
>>>>> +.. list-table:: Dynamic Linking Call arguments
>>>>> +  :widths: 20 80
>>>>> +  :header-rows: 1
>>>>> +
>>>>> +  * - Option
>>>>> +    - Description
>>>>> +  * - syscall_num=N
>>>>> +    - The magic syscall number the guest issues (default 4096). Must
>>>>> be high
>>>>> +      enough not to clash with a real syscall.
>>>>> +
>>>>>    Other emulation features
>>>>>    ------------------------
>>>>>    
>>>>
>>>> Regards,
>>>> Pierrick
>>>
>>> It looks unexplained today only because the walkthrough never shows
>>> building it. v8 will.
>>>
>>> v8 will also include the full hello.h, hello.c and main.c, plus the cc
>>> and clang commands for libhello.so and main, as one runnable x86_64
>>> sequence.
> 



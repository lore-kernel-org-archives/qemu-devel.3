Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2689C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGRx-0005K1-9A; Mon, 27 Jul 2026 04:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woGRu-0005JZ-H2
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:12:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woGRr-0002sl-UU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:12:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7SN2u2532904
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WU/BYZpmr2Qquila26lG1btyOsT+i5qnoSYdiXZBvTs=; b=CbiOuDACLZG+2sD0
 lylEvx5WE74cKdRx8Kn/Ew8/WSyPwiazAwIHpuoCKmWvTpODhXHyBr2PGmzTZKPg
 iEzP1H8wXaBh9tJ80x74+dI9cPqkh/6kBtrhAes28JMMsony7tGiP/NCeQzWhw+w
 VZLEcheSx4H+rgqCJzek3+hzNdY5zh0caAmbjouWBp7mjaBKVHQtmc5C56ykQZbw
 7jyK2NT8MFFYdfKOc8FqCdGl/g+emaphsS8jSH+AMzdWX6zTvFqqGInWbrex5jp/
 cybajE1AgAcMp85Fjrr3qbJaXm6srPCy3uQbpKBbCDXn4JwPF48lSPSNffsNtnro
 Hyf30w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmpajmy9y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:12:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso30247531cf.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785139944; x=1785744744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WU/BYZpmr2Qquila26lG1btyOsT+i5qnoSYdiXZBvTs=;
 b=P2RE4jYAH+jiZEDocyUuIuxWIt1bjPJxI5l4MTzCiyGesXGmLxp5D9O/JR/GmhdI9q
 D5lqGdD3s0iE3WOm5t4K1rOZMfGi80vnaRVmltzzIp5oimm3oUQm8kDG/ziSdw6V1iCm
 2X88WmnAqnejMJM3mO+a75IC211kl3UK1sgsKUDkHLCCISbg/dFT50OK6GcsUo2Cnfdw
 UAfqFrWbu+JeH1TnXxGlU3oE9mFCiJFyB5W7Ot7qjJ9C3R57n/BxxKlJRu2CPjIaT/Vn
 9I8AI49WlePp/264wLXlITHxVBfod0peagovO3SpIJg4JM6Ba4yLfH0s6UJDlM9pxwHa
 794g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785139944; x=1785744744;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WU/BYZpmr2Qquila26lG1btyOsT+i5qnoSYdiXZBvTs=;
 b=IZy1KO4Xe3WzqWSA7AemVgu9KcQ8igR30IipxPyxjNF59/JFi6ktpNJ8IZjDmOleaP
 l/Z/fD77lxBTgR3Gkzsj2rs1T9+xSBB6fgXL3mSY8L3ZT/prEPwkHLRgTiEPiiey0lk3
 1SpchnbtfalcHB4nHeQmezOiVhWfJUicvqAlXg0ny7W4QpOSYHlspk685xaDjjAGfVpI
 B76BhYdCM4Sl6R4gGygupEni62243Y2wd+/MtBHL0AoTGGRKKP0xjS0cbZf6hWns35gp
 H2vhSZNyNb6MvOrw8sMiuxK1PcDSFj9mxULqhEXM10fgl5xlYjDYKlVPIUfI3+c0wYrl
 cRww==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYHRB5Z1alSUU4TLTg8j44dR9eeN9jlEIx1K4phg7p5x01LnzmZSts/+CzTllxnZd2ybjlA8VRla1L@nongnu.org
X-Gm-Message-State: AOJu0YwLEW+f29AUPDdEOXFzFZ6fEDwDzsqBXopul3E+BqcfMdKM8lbo
 yXt76xuTs8m34YEFZrgnaOcAidxkdw69cK0gQqfc6nJ5RufQYVKi/uZIk9CiFSdo3KBxLRwfF6V
 uaYzhZG4KHYDqQ8OvThnnSR5k4mTqpfcCjq0g3nbmjsEcC+hKdST9BcPROw==
X-Gm-Gg: AR+sD13jt8ojmlXeMV5lQzMaktnnpig7qGTg30O1p51At7bm9kX4HQjG1xCfJyCmQgq
 jUWjSNcnFusbEXKiOJTo9FmCZv8V19W2W9NNghEyyupTClEAaxSQK6HyZYpnW/0MtU29cwRTnui
 e34o4KepxiNAgxx00+md1b5Q90WEhjO2VCYQLLYXTBiFdsdSyLHU0aowcoimGrzXvSz7LRwuyo5
 5xHPcWbC738VndBZwZNsUn+f72R0Vb3ZPLL4Dvj3vFeRHU5g09tPPyrxp86gm41Dqbuv272T3Jz
 0F3bJOhVNyIkV5XqIGu3UOoPSHfbTk+r2qpBXJ4erpE2GgQ2+uxzKCPAg3Di5qPbejVbMPn1t6h
 u9IoWni/LRvc1vCQ5aH7aINP1P3XvsVLrhLPhrn4p1L1CY6jo/PU=
X-Received: by 2002:a05:622a:2b07:b0:51b:fca2:af71 with SMTP id
 d75a77b69052e-529a86acba6mr76844951cf.42.1785139943967; 
 Mon, 27 Jul 2026 01:12:23 -0700 (PDT)
X-Received: by 2002:a05:622a:2b07:b0:51b:fca2:af71 with SMTP id
 d75a77b69052e-529a86acba6mr76844691cf.42.1785139943427; 
 Mon, 27 Jul 2026 01:12:23 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm51069362f8f.24.2026.07.27.01.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 01:12:22 -0700 (PDT)
Message-ID: <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 10:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add option to disable building tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Florian Schmidt <flosch@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260724135413.1716872-1-flosch@nutanix.com>
 <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VX418L9MDH0SlrFtXvAunIWxdRZc8S_5
X-Authority-Analysis: v=2.4 cv=A8Bc+aWG c=1 sm=1 tr=0 ts=6a6712e8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=Cylgt3L8zxttCafvfRgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: VX418L9MDH0SlrFtXvAunIWxdRZc8S_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4MSBTYWx0ZWRfXzCfmZa9sMXZh
 +Rw3yYPjFuYlBLNevduD1AF19aHp78AErd93S01bSr+hzQcKq/TjI6gBBgY6SdnyNgW6WDbfl+c
 pEtQbdnQbCVUw5kgHTBU+g8FJWhVmYuOv7fA8krdPRoP8zgLuAC5VZXpCmIHlsu6Qfya9TX5Kfj
 EpN84PvIQDplN5PWMeIRyhFd5ynX0Zu19qgQOu2GqUiDR+aC/HnfEpT4it0n8ogQmmtKX31/DCW
 c/50t/r4d/8DTmRBH3GaQ0cOdsUslQEeAtS+rdTNMJtfZX05Y9waRDs7RKCSxv2ynWjv14Uox/N
 5wfrq+UOLrBD9nW9eblTpIARlG1xpnzFvhNGdgFaPpxYr0cIMv9qzwAzIj68DpEfxC9Cr2w8f7R
 ZKJ1j/kZ+GhEf9D+7RPKybx04v6oD0ecDMTqeE9z5q5fLIHvkT1CyJwcE1d/61ZaUjmsjbvd6PC
 gdRgu6osjPDh/LocyGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4MSBTYWx0ZWRfX2WDvFYrVW8Gq
 9ql0YXZuq4a6PZmtZqyMLdoxh7084xY/Gm8zBsiOLMp1BlR90JOdeBSGhoojRF+ZYgcAh22WzRK
 K1UtJNXcUYRV2k1DwSe4HYEGFqz0M+k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 24/7/26 18:45, Pierrick Bouvier wrote:
> On 7/24/2026 6:54 AM, Florian Schmidt wrote:
>> There are situations in which you might want to build QEMU without
>> building the full test suite, which in some configurations can take a
>> considerable amount of time to build. This is especially true when using
>> LTO with clang. For example:
>>
>> $ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64-softmmu
>> [...]
>> $ time make -j8
>> [...]
>> [3078/3078] Linking target tests/qtest/qos-test
>> real    6m43.250s
>> user    101m15.967s
>> sys     4m3.813s
>>
>> $ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64-softmmu --disable-tests
>> [...]
>> $ time make -j8
>> [...]
>> [2024/2024] Linking target qemu-system-x86_64
>>
>> real    3m14.277s
>> user    33m13.174s
>> sys     1m36.642s
>>
>> Add a toggle to optionally disable building tests.
>>
>> Signed-off-by: Florian Schmidt <flosch@nutanix.com>
>> ---
>>   meson.build                   | 2 +-
>>   meson_options.txt             | 2 ++
>>   scripts/meson-buildoptions.sh | 3 +++
>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 49a5baf5b5..ad728c26ec 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -4605,7 +4605,7 @@ subdir('docs')
>>   subdir('pyvenv')
>>   # Tests are disabled on emscripten because they rely on host features that aren't
>>   # supported by emscripten (e.g. fork and unix socket).
>> -if host_os != 'emscripten'
>> +if get_option('tests').allowed() and host_os != 'emscripten'
>>     subdir('tests')
>>   endif
>>   if gtk.found()
>> diff --git a/meson_options.txt b/meson_options.txt
>> index a07cb47d35..68333ca402 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -43,6 +43,8 @@ option('gdb', type: 'string', value: '',
>>   # on the configure script command line.  After adding an option
>>   # here make sure to run "make update-buildoptions".
>>   
>> +option('tests', type: 'feature', value: 'auto',
>> +       description: 'Build the test suite')
>>   option('docs', type : 'feature', value : 'auto',
>>          description: 'Documentations build support')
>>   option('fuzzing', type : 'boolean', value: false,
>> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
>> index c003985047..3fec13a336 100644
>> --- a/scripts/meson-buildoptions.sh
>> +++ b/scripts/meson-buildoptions.sh
>> @@ -194,6 +194,7 @@ meson_options_help() {
>>     printf "%s\n" '  spice-protocol  Spice protocol support'
>>     printf "%s\n" '  stack-protector compiler-provided stack protection'
>>     printf "%s\n" '  tcg             TCG support'
>> +  printf "%s\n" '  tests           build test suite'
>>     printf "%s\n" '  tools           build support utilities that come with QEMU'
>>     printf "%s\n" '  tpm             TPM support'
>>     printf "%s\n" '  u2f             U2F emulation support'
>> @@ -515,6 +516,8 @@ _meson_option_parse() {
>>       --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
>>       --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
>>       --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
>> +    --enable-tests) printf "%s" -Dtests=enabled ;;
>> +    --disable-tests) printf "%s" -Dtests=disabled ;;
>>       --enable-tools) printf "%s" -Dtools=enabled ;;
>>       --disable-tools) printf "%s" -Dtools=disabled ;;
>>       --enable-tpm) printf "%s" -Dtpm=enabled ;;
> 
> That's a great addition, including just for speeding up normal builds.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> If we want to overengineer the thing, it could be possible to still
> declare all tests, but not build them by default. However, it's probably
> too error prone and much less simple than this patch. So I don't think
> it's a good idea.
> 
> Regards,
> Pierrick
> 

When is it useful to build without the provided test suite? When another
one is better? Why not contribute it then?

Or is is just that you don't want to test your changes?

The problem might be we build the tests by default but don't run them by
default.


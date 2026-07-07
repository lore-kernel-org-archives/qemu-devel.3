Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0D6C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAPS-0001Xo-5t; Tue, 07 Jul 2026 14:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whAOG-0008NM-6E
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:19:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whAOD-0006sF-Ap
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:19:27 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTFba4059268
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n1//I204OqO5CVGflgfh7aJxW9Lw8hbN0mogFQq/AlQ=; b=dtJg+k06YUhC5rJL
 fmEMGHHLnvIliIK3Vbgb7dgpkVP+8q7S3WLIpmrsR/SesU4Od8DGDbEk0HLGGTJ5
 NbM0ro7Jxl6ZPvwGBd3vVcuuIvotmGp+I8EJgjozaolOanXMEo+GZVbtXhj1knVw
 vRf/fsqK4jbbsN7B1LPxRC8ayE7jSctGwmqG4gatpwaA6sM2Yy59mSbMIUngc9dD
 pt3IUeDMJ5v8+RfFXIEnc2xbBUAQJ7HgEsgQDuYVdPtqdVMFYaKKu4CnV8HyZWI+
 erTBaRKj9Ur/j/0hnagkL69FgPx1lVzbCcnQDYYBxpGYBZsVNYM1RlYx2IzrZYQu
 1HiKIA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8kgvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:19:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-847ad67cc51so4706716b3a.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448363; x=1784053163; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n1//I204OqO5CVGflgfh7aJxW9Lw8hbN0mogFQq/AlQ=;
 b=YP0O3ltzHl5Z0dIdw4E+5fgrU6mqwl4oEi+hweTNjlm05mozx8z5JU/xPLEI8wZCcr
 OXcwzeih8aVaK0wcHKjMKmUmrjV7Rx/bzwdx6fRzPgu6ClIzJSCdfbMrlaR7AezUFWp/
 O4L1PNCmhJAaGx89rJZx/bxSJQjjPhtQLfn0l2UdiWSQRcBp8pcWL1B+wENJdk83OPk4
 XpyP/+2wbGJjCMGAAOlhdAqKxiELGZYpDfGPoFEFUiyaEVZ6Xz6hArabOxW1dB3f1pev
 aAN/Inpm1ljgZx3fAC9p0R+EGOSgJugoWAdHzcSPHXeUGmuTUo9WBKiA1DGKYip4BRas
 dM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448363; x=1784053163;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n1//I204OqO5CVGflgfh7aJxW9Lw8hbN0mogFQq/AlQ=;
 b=aOdyE44mdlWL5MxM7KRJeJ4IjhhGoV+XGF68gVpMx4t6JCvXCLX0DAZaVb1bp0tZvu
 6ol0mfqE3d3LF9VGs1eIxCm6vIWdvzNnRI6fQdtw1X0/0G/BRDf51PzuVxhOZbTdNqNh
 grv4ZSaOfPv3TVq8npI+9fpJIIE/UQz8yYwNu++5r95LRvawiVemNVGFRRx7E/noBI+X
 b5X5Ycwe4wpVc5080oyqR2l+Hier3sQ7tlVP0W/9JjItyvTJpJToWwUKBPbB3otcnJU4
 gPYbckHfaVxtx/DEX42Vl7h4Y968qTLqndhQJjD7BNoB9lkdtY6i2qGI5PnmFIDpoUNY
 Cpng==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOQWZviIl4vRaeXDzVlRl0Za5gtZR6Fw038MuL73G9Zeb+SdilZtQJPU8IDjwC/GBz2syI6OUCOQ1h@nongnu.org
X-Gm-Message-State: AOJu0YyQrspldASOLUhPSU6VK0Yu01Ai1rIb7GIPw9FBIcO7zdOFIYPq
 VlWtGWby8wSE9OKUMpBC5ty2XpPjMElrRy64JXTXV/Dtskb5bogBcs7d+jpl+BjSqBoQxagJYyg
 S/DzfyLdCqPMWFC86wiJVaf2EK87jgN7YM1ntTdbXCzUpP46LwZs4NVSvQg==
X-Gm-Gg: AfdE7cmPD7+e1i0RKj46Cz9W0irw9hURZvTcKOTGn/bbC/lyhWcfELd2xBEhmyV4lfz
 nB8Fcg41tpG+6iGHC8Xe07XzFbErV+cT8iUXP/NjhDO3q9ZWURr5Ic7AR8GWVEVP52DJ89Wwctz
 pyFFzgGAVDQnn0lkyIIQpk/RTDXbWMxpjsBes6h590Yh8eoAFQwUkHSBzCNrHA7DrEeXQLyfuR0
 7YQ5fKK8lI/fQ450gJNFa4esB3EIlRFcZjORVTXgPhF8nLKCCiWhc5l9TbmgQVk3s93NzUUhdRC
 Euix5QMw3Ay8Ntt+JcTFh8Odg4E4eB3yqJnk6q4UzwS58rqrtjQlPwGSnaaduxUgRA4Tes5Cal9
 f11Q7bajSqm7Znsu2z5hJbhMRlhdxNBAlWkEjjR3wTtvwm10y6gEaBO280B7H7IE/iofwMn2PEF
 kzBw8=
X-Received: by 2002:a05:6a21:a383:b0:3bf:6c04:a817 with SMTP id
 adf61e73a8af0-3c08ef95aedmr7321021637.56.1783448362630; 
 Tue, 07 Jul 2026 11:19:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:a383:b0:3bf:6c04:a817 with SMTP id
 adf61e73a8af0-3c08ef95aedmr7320988637.56.1783448362177; 
 Tue, 07 Jul 2026 11:19:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm16492904c88.14.2026.07.07.11.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 11:19:21 -0700 (PDT)
Message-ID: <8fcbfdcf-cf43-4021-a4d5-aec1a3cd4afc@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:19:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 82/91] tests/tcg/tricore: system tests
To: Parthiban <parthiban@linumiz.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Christoph.Seitz@infineon.com" <Christoph.Seitz@infineon.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-83-pierrick.bouvier@oss.qualcomm.com>
 <04b2f0a1-3046-44c4-ada7-660273230748@linumiz.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <04b2f0a1-3046-44c4-ada7-660273230748@linumiz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfX9isx+IrGFklZ
 RQZo28/dcvn6K6skKrpwaMIAtg6dLVKul58PexUmD7Sd20UnyumK2JYoctwG6qS5BcdqGtgJz52
 Tp9dU3tGxaxO9NM6xJYviRqcImutWGUWCpvDFeaHptiEY3QuuPqbWQngcVBtzkEYORkCs704IFa
 0VTLt+GnCt95wLhayy48sa10Ge6n7YqNGCV8YwhaMGfyoPgwpX4d0eAaQv+BABwYJFDfNnM3Bwn
 VwmT6niXNXiSWlig9+yi82fVJTOih11rO0vwG89DP7aIUX7fIjh15iW35ejb13qZycO60XCLFdR
 +g3lmML+KSCnrLT7Lg8/nmHZdJmS/P6C3R6gGcnhVp7xDD4zt5iRIixAS6ksEA0N2F8i/RdsKJm
 w3NqYF5SbAM7K3NYqvsT4MeUZz9hNsek99T+1zi/CvGr2wxI2SrzNgGMJrZtT94OH8D3Jge6eHb
 oQHK85f0dWuMcD2E45A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfXx2yItcQRsDDX
 phjLxAUIhei2usSRAFGMt8NLTovM2WhvuaRJFygV+NmHCU0nEZJkPaZsJ8iTSvGqv1t3UJiBqe6
 r1fbVx7kdbCwYrnj2o78g6bekqtePcw=
X-Proofpoint-GUID: V8Uj25uxAwYMkXiSJW2tOfYS0qFuwXw0
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4d432b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=fWaBl_-QiwakItxLsEoA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: V8Uj25uxAwYMkXiSJW2tOfYS0qFuwXw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070180
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

On 7/7/2026 11:09 AM, Parthiban wrote:
> On 7/7/26 12:33 AM, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/tcg/meson.build         |  1 +
>>  tests/tcg/tricore/meson.build | 56 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 57 insertions(+)
>>  create mode 100644 tests/tcg/tricore/meson.build
>>
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index 59e71d82c99..b2630176b7f 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -152,6 +152,7 @@ subdir('ppc64le')
>>  subdir('riscv64')
>>  subdir('s390x')
>>  subdir('sh4')
>> +subdir('tricore')
>>  
>>  image_targets = {}
>>  exe_targets = []
>> diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
>> new file mode 100644
>> index 00000000000..6303d6a912c
>> --- /dev/null
>> +++ b/tests/tcg/tricore/meson.build
>> @@ -0,0 +1,56 @@
>> +tests = []
>> +
>> +link_script = files('link.ld')[0]
>> +crt0 = files('c'/'crt0-tc2x.S')
>> +asmflags = ['-Wl,--mcpu=tc162',
>> +            '-Wl,-T', link_script,
>> +            '-mtc162',
>> +            '-nostartfiles']
>> +cflags = [asmflags, crt0]
>> +qemu_args = ['-display', 'none',
>> +             '-M', 'tricore_testboard',
>> +             '-cpu', 'tc37x']
> 
> -             '-cpu', 'tc37x']
> +             '-cpu', 'tc37x',
> +             '-kernel']
> 
> This should fix the TriCore timeout issue.
> 
> qemu_args is missing a trailing -kernel. bare positional argument and kernel
> is never loaded. PC unset.
>

Thanks for the second pair of eyes on this, I deserve a facepalm here.
Works fine with it!

> Thanks,
> Parthiban
>> +
>> +# Multi arch tests are not supported
>> +# tests += tcg_tests['multiarch-softmmu']['tests']
>> +
>> +setup_asm = {'cflags': asmflags, 'qemu_args': qemu_args}
>> +setup_c = {'cflags': cflags, 'qemu_args': qemu_args}
>> +
>> +tests += {
>> +  'asm/test_abs.S': setup_asm,
>> +  'asm/test_bmerge.S': setup_asm,
>> +  'asm/test_clz.S': setup_asm,
>> +  'asm/test_crcn.S': setup_asm,
>> +  'asm/test_dextr.S': setup_asm,
>> +  'asm/test_dvstep.S': setup_asm,
>> +  'asm/test_fadd.S': setup_asm,
>> +  'asm/test_fmul.S': setup_asm,
>> +  'asm/test_ftohp.S': setup_asm,
>> +  'asm/test_ftoi.S': setup_asm,
>> +  'asm/test_ftou.S': setup_asm,
>> +  'asm/test_hptof.S': setup_asm,
>> +  'asm/test_imask.S': setup_asm,
>> +  'asm/test_insert.S': setup_asm,
>> +  'asm/test_ld_bu.S': setup_asm,
>> +  'asm/test_ld_h.S': setup_asm,
>> +  'asm/test_madd.S': setup_asm,
>> +  'asm/test_msub.S': setup_asm,
>> +  'asm/test_muls.S': setup_asm,
>> +  'c/test_boot_to_main.c': setup_c,
>> +  'c/test_context_save_areas.c': setup_c,
>> +}
>> +
>> +if 'qemu-system-tricore' in emulators
>> +  tcg_tests += {
>> +    'tricore-softmmu': {
>> +      'cc': 'tricore-gcc',
>> +      'cc_dockerfile': 'debian-tricore-cross',
>> +      'cc_docker_arch': ['x86_64'],
>> +      'folder': 'tricore',
>> +      'gdb_arch': 'tricore',
>> +      'qemu': emulators['qemu-system-tricore'],
>> +      'tests': tests,
>> +    }
>> +  }
>> +endif
> 



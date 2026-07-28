Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F002C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocgO-0000Wu-MX; Tue, 28 Jul 2026 03:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wocgJ-0000Mi-If
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:56:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wocgH-0003EQ-K1
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:56:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3tvY41920116
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8vdctjL+VrjBPBcPdbX9+K5I4ehJXJi3/vnfww/18cw=; b=aLBKKWjcir5xjc8m
 F+eEFtk3XZtRBWPELYqHz3T51YyKLAOJPf+iLQ7qpeXx/EGIAiGV/pAR7ev0SRFS
 cXE2/uae5vzbO6c6obLYS/iODKSPHX78g2Xs1DlO07zLVk/S2CXYaIZhYwDLdCc7
 R/0FQSDSZSbZ7ygU0VsFdk17ylRg6822aQU/dP+QRAD19cn/I63Aae9sxdLDIZbL
 9aTAdAroytDr4M2XUNSluBONpm0FirDVdcpGpva409MDrXR0o3DP/U96QDAbzjrq
 hQwVWgzfxIBgHaJsANLwmJ5vzTDJg25Hq1wE/kHvoTG33kOxNY15hEiWJ3iWyweG
 6cdfEQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy10um1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:56:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so8888678a91.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785225411; x=1785830211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8vdctjL+VrjBPBcPdbX9+K5I4ehJXJi3/vnfww/18cw=;
 b=Lr8F00UNg1zAg/3B4qgIlHp9W3/SubRXK/Bm1IRWUr9pNKqi5NFl6vem4aekkCk3nW
 fizH8nQGp2VHcHFj3+VonL+HMxt8gqVJJY/W1YBceFrD9e+R5JTT7ZW9AWphKGlmte1g
 rk2xUnVGKrIelNxFwalAKR4ss/vsBolteiKxYiTXfJbxhAPv2pHqt3zC95Z1+bLeaBiJ
 cCfKGNXXU/zBHeYRu5YLn0daMnCAyPnEShKk2CVSIdOasu6Y4t+JQIU+oOq7ZVy82XX3
 QximcKd+f30iNSwWVQpMQpiIDhjyDYjtUfzl03jFijUxLYxRgpONLvIfzi2+GWHwnUJy
 Px6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785225411; x=1785830211;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8vdctjL+VrjBPBcPdbX9+K5I4ehJXJi3/vnfww/18cw=;
 b=dYsIWRlPuPppBCXCUhwuew9o3XGaeA9KRoxslrVASpdxjEpQ/su/3cuPg4LFkxaRJC
 yA4qaJky2iOfylKvEgJF0UA/oehvPMmNOSG+OgkOSQ86FrUml1h3dIPihebK6TVE75Cv
 p/+iv/93z5EWDS7+JfCPxpyh+NV8VFJx1Ye3zhALiD2+YdQ5aQkkCeC1NrhYZj8SxHWH
 6OKSWzUB+P6SitoytZCEz/VZtbm696RDmlW2x4qXWWZmB+r8GSFXYxd4ka0nT0nQVSn7
 rEdcB/aV5YoLff/61lf8enaVh8GnZVKPo2Uf6SfeoxHrynnVsxFvMaJMZiiPPsCxl07c
 h+vw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6t4CQvfaFpp9F2HpDWzTQ4jw8hl3vd6U7K74hEAjdMrTXiS11x+70QEYptHQx+9mwV13uKEYSKTUn@nongnu.org
X-Gm-Message-State: AOJu0YyALSnt6d6tZCR86DyT0ujAuWHFUpHJ4eC8IwW+Pv5m1b+NDx5M
 u+vPC/qgAsfsRzBYJnTKABeGjm7o6ShoGZQkmNLbGgaMC2AcKPMnH1cJUut2xHsFByHBsf92pzl
 mTAGousqtBhQR0BGQ/6T0IqkF7MH1gvV7/iXzXXSN5YkMaH/QPClqF7D/Lg==
X-Gm-Gg: AR+sD10DsxxBNgm3PH9SPEYs/yCE3XgVGROxJdYGi5tKR/0hRsFFsEdncehxxgkyS+O
 gvgJKSudYu+qLJbEwWyh372+4MIOBDc3COzVYTda4Tu9c8qcXzA6IvbtIgsxOD/89SrqxBFnfFE
 VSCk1fMsgQxFn4znJ4zZQlGfqU2jo27qEpQ8r8iESA5EHaGOKS8McwLfzKr5oTHnFMUA7ipsrQw
 i8UvlUSGDzsxXUjPfN5Yo2DbzKzB3UEGP0TaQWb2//wuCsDlIUSNdei7abNxOr6dtxSkfFARh3r
 KFtV4paP0jbvDh7T5fyOuh9qdNrjIxvMVIqbo/iRQGjaGm6lOE7bRLnwic/gZ530mRv7uJ2euMm
 ECo3Fkc35TjN4wiBiKkm29E2Rxx72EDRbVF/JBzXwyhzHKBBlvnLKZ58=
X-Received: by 2002:a17:90b:390b:b0:38e:2f21:3bb5 with SMTP id
 98e67ed59e1d1-38f6a4e3667mr1569052a91.21.1785225411464; 
 Tue, 28 Jul 2026 00:56:51 -0700 (PDT)
X-Received: by 2002:a17:90b:390b:b0:38e:2f21:3bb5 with SMTP id
 98e67ed59e1d1-38f6a4e3667mr1569031a91.21.1785225411068; 
 Tue, 28 Jul 2026 00:56:51 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f64041358sm908020a91.0.2026.07.28.00.56.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 00:56:50 -0700 (PDT)
Message-ID: <0ff8f6cd-41dd-480b-a7ff-c23dc35792a7@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 00:56:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 095/103] tests/tcg/xtensa: xtensaeb system tests
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-96-pierrick.bouvier@oss.qualcomm.com>
 <3b4719d5-6dfe-4bdf-83cf-563d9caa0996@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <3b4719d5-6dfe-4bdf-83cf-563d9caa0996@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nP62NinBFrCrTXwn8H3t99sL9tBBvY2M
X-Proofpoint-ORIG-GUID: nP62NinBFrCrTXwn8H3t99sL9tBBvY2M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2NyBTYWx0ZWRfX+u7Pm4Q98GQI
 vDqnabAgL9AJ3N9PJ9fPKkiLFBscyvf+IxBTUbCZg4akKzbgxl6hZuFj9vI079iXmo81zpCG8Gf
 Gx9m4oC0+E72SMA9PP953VezCXEyVSrF+pYddPCN1H/fGliPHACz864V/31X4TGjhzzcF/xyjQi
 iN57lTplOc+XgZE39lOWBIbBRmWM1s7zzavjV8yLD82kbzjyV/wos2mZoTb6dO2KEPm3+LoVgH2
 6e2HHcy/PlHAFJNXU3boMFqCTuqcTkkTO2K15pH2VhByh9pVirNFQ9eWGoW8zt9Po34B2H5kzC7
 UmoIiXDHanqeVIsMR/eC90SYo37Wb307FAxCnHSutShzMI23ekVGLhxACpIHVw2e5OwkR+Ks2fR
 tsqjdOHLTKh9PlK3ZoLdc4LekS/v+V1mSXONxTQ/cpkj58Ux1HuRfUHiVur35ijjQwOtqv9YEC5
 JhuHdp/b9o93yCKEniQ==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a6860c4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=D_euF7S7wvw4LH7Ie6EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2NyBTYWx0ZWRfX/X6HN1uRcddH
 e6D4t4KqxTQKDdYrmfAHk2orRIrG2tdT0H+2FWV51Jv9vJO8Utgj1bL52B39kwZcCeKgJXA46WV
 sFRb5vk3KIBzn2PUQtPfHALHdxbx1cU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280067
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

On 7/27/26 10:06 PM, Philippe Mathieu-Daudé wrote:
> On 28/7/26 06:42, Pierrick Bouvier wrote:
>> Deactivate test_timer which is flaky with xtensaeb (25% of the time)
>>    ./build/pyvenv/bin/meson test -C build xtensaeb-softmmu-test_timer --repeat 100 -j 100
> 
> Is this comment still accurate?
>

Definitely a leftover, I'll remove it, thanks.

>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>    tests/tcg/xtensa/meson.build               | 16 +++++++++++++++-
>>    tests/tcg/xtensaeb/Makefile.softmmu-target |  5 -----
>>    2 files changed, 15 insertions(+), 6 deletions(-)
>>    delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target
>>
>> diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
>> index 7c3c4f7cd62..680fa02ff5d 100644
>> --- a/tests/tcg/xtensa/meson.build
>> +++ b/tests/tcg/xtensa/meson.build
>> @@ -1,5 +1,5 @@
>>    tests_per_core = {}
>> -cores = ['dc232b']
>> +cores = ['dc232b', 'test_kc705_be']
>>    
>>    foreach core: cores
>>      tests = []
>> @@ -94,3 +94,17 @@ if 'qemu-system-xtensa' in emulators
>>        }
>>      }
>>    endif
>> +
>> +if 'qemu-system-xtensaeb' in emulators
>> +  tcg_tests += {
>> +    'xtensaeb-softmmu': {
>> +      'cc': 'xtensa-test_kc705_be-elf-gcc',
>> +      'cc_dockerfile': cc_dockerfile,
>> +      'cc_docker_host_arch': cc_docker_host_arch,
>> +      'folder': 'xtensa',
>> +      'gdb_arch': 'xtensaeb',
>> +      'qemu': emulators['qemu-system-xtensaeb'],
>> +      'tests': tests_per_core['test_kc705_be'],
>> +    }
>> +  }
>> +endif
>> diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
>> deleted file mode 100644
>> index 3df131acea7..00000000000
>> --- a/tests/tcg/xtensaeb/Makefile.softmmu-target
>> +++ /dev/null
>> @@ -1,5 +0,0 @@
>> -#
>> -# Xtensa system tests
>> -#
>> -
>> -#include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
> 



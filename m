Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27639C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBHp-0005oO-8S; Wed, 12 Aug 2026 11:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBHn-0005o7-4a
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:54:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wuBHl-0004aT-G7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:54:34 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbqwK3949947
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hiVrKAku2263ENdgKpEtF0ZxXApckPZ2N9/0XlZ4BTw=; b=QsTRivHd2I2CPkgG
 VfCkUzGpfw/KmyOsgRkTm9/Fi4G6alClJHaWzrn18KFnpWe6SYCC5yFmRVm0L/bX
 OkI6jqjUhDJJcwtxtYFHzHMcQtDMer6UC3XjZV8FQCu3MGuHUtq74S736CrCRsoD
 pA4K7JJkK287962KcjbGqqbTw7SPBpD9ziE4N4plH0vpkF/7+vYDGDd9uwo38xm4
 xd4FX3n7pVO0M6M+BDf2jUvitZkeej+2RY7yvY4xm7i3IhBqvtUhmi2Exxkt2MI4
 kExj2KG0eOkfWb6uD3dX9N1/WZXWuevJr639Y6EKWjFJ1j7uGEcur4ujicir/PB2
 IFwC4g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2tuqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:54:32 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84865f326efso1318362b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786550071; x=1787154871; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hiVrKAku2263ENdgKpEtF0ZxXApckPZ2N9/0XlZ4BTw=;
 b=IYSwTp3hwIuIKce6R6L7IhByJLatJ4cL6iKmpnElTWJBol/03ZWkaKa/fgwJ9GbVIJ
 Fe7NjFxw/2koyOLdx4x6hKtNEWvkldRBux1KPnOzy4Dm3x0DP78/JYJbf+wzqCgOD7VX
 WwTFbmmOpoPCA+LYjG91w96zTAtZD5em5YviLtLTL8En6VJZj5Yf/yzirZ4FAuNNb1dQ
 RH+UCEajOJwIjK9CJ4GeO5oYQzFdnL/oYoKFFIegxkSbQm1Tq3SwK3bPsOb8MVJuZ1T9
 LHkfgeBMFAH0pKzoL6/H4FTIOpmex6qDJWFZr7v+cIZWs701VirsV1C9WzexeQKWLFLs
 yz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550071; x=1787154871;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hiVrKAku2263ENdgKpEtF0ZxXApckPZ2N9/0XlZ4BTw=;
 b=pr45BcM+0uyDv8uQHtoEfUgbP8l17iKUIxYF8fA5poKHLE5Tk+RwMKko7qqCoa76ng
 +s895wjgrNAoxo+nEP+BkwmsOkVBBrQ0UAyfcleQDS4aAnlkisi+H5TsYJ7XxAdG8h90
 r8K5V0fvcSuygK8N6kUYRulKKe35UmsldFA9bPr/rNEGyv6MtsBqcgEKuJiFhpuxOCkO
 HtIlxXrhCoq7rdljgyKfHx7nYVbdCZ3Gd6E9YrvKKIVamrCmjxtoP131+A5spgGgFd+E
 lmQGWF2jMOg+7o0JSPY6+npkAIjaL3v1Ri8EKBjNwrikLOT/rlaAr/955oft7MS0GFUd
 m3dg==
X-Gm-Message-State: AOJu0YxMMmfXRPQcnyYq22gupJ6PBiwhilqZhIdzRgLD93PZCLeLDjhQ
 m4n+g9VKanUxJqH4f6ghntJxb++TxEqWhGL2/bc1fisq0Bw8RRQ5+xTONz5Kbwf2tWrgQB6WSe2
 BWfnASUau6YS5Tmh2Exako7StI23cUe+Dk7b6GVJYL1mVAAGepk+VNH4388wgFBaI4w==
X-Gm-Gg: AR+sD10/MPjTZXyRFD/CmZrgaVBZZZ04cjeYLzdiApEsBU6uJhIWSEzyNjsLbavCtu4
 061Sif/VrZ/Xk/ZFp/83fx/2R3iQmlqLboC3V+LrvtOFHM5k5qRmETnfrCHlzAvk0v8aPnVuXsw
 mztA8Gem/LS9+qA2J2/Mzr5meTUQJ2cNeK2ERP1ZUWSHrgWoj9M/NzPUW1ApReBzB0vIg4Zh9+4
 OP+JNJeO7mkg/2lT2B7a8iqjXVlMFWW18kiluhB8yEr2nO8+aqdYQ5Mqh/54oklHU9b2S5U78XV
 pp8a/P11KPEJfKXACm5V7mbj3dXnXIKMnKEpUTul29JssV5VyIka+ewnCX7FrQfw3yFzEuRIHU2
 QBOdYH69sKa0IDcbJVspMs+UNRq0kjy5eCsPy5wcEaeKnaOoQ73aPd7jL7/sh594nuurD
X-Received: by 2002:a05:6a20:72a8:b0:3cc:1d29:f172 with SMTP id
 adf61e73a8af0-3cc3f72c049mr6800453637.22.1786550071130; 
 Wed, 12 Aug 2026 08:54:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a8:b0:3cc:1d29:f172 with SMTP id
 adf61e73a8af0-3cc3f72c049mr6800393637.22.1786550070696; 
 Wed, 12 Aug 2026 08:54:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbee7a8d612sm963051a12.12.2026.08.12.08.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 08:54:30 -0700 (PDT)
Message-ID: <76b257f2-9227-420b-9ffb-de42b5f626ba@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 08:54:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 041/103] tests/tcg/aarch64: system tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-42-pierrick.bouvier@oss.qualcomm.com>
 <87jypvza7v.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87jypvza7v.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c9738 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=eFRXyiSF-FEnGALm390A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: bkqBCYEtYeGEQENB59Kl81ZW5pD7eMpm
X-Proofpoint-GUID: bkqBCYEtYeGEQENB59Kl81ZW5pD7eMpm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOSBTYWx0ZWRfX626tMBLWwXSU
 dAi8NKn2xiX7daDEy6RLjnoJgfKYdk3lYW6pWUU7dqG/nC6xOb+v2WjIHFqeZ7p3TyqantZRBCS
 GtHS37kU4qQhPhNKBxXNzo/8j/9StH0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOSBTYWx0ZWRfX3acQDJOA1Fko
 Q9fKSKRVUYXql2oWhxtq3PedT5yuoL5fohQyMo1/WZwxzkm29tbQMGllpNNA58sRXOWXvHHcnVG
 jk3A9BurCX2rSfJ4I4Ml21R02xZkNs/NZdRNiOvLot1gNxKh4PG+2L25bzs9KUPZn8g88KzCNSN
 BNjtDLeRZ17Tm5HSSHSDGWOTfmK4rrcq1phRh2wBNg/7SFoILYq1Y7iTn/+jKffVX9wwFulKsPe
 SL/dCH3EpWm4C9tEOb2gaV9w4E/e3V9hXH10IK2WKLdxa0lYhB58jb8Cz4q4SRsGilk6uZ1iPJc
 pXW2IrId51uI6yH2sI6/5ZKsnsuqsCm7QhP+XyVV/RoRyxFEdAFksB1BhrMEZoknt4n6Ugn/8zw
 vR/Ewa+5Eu2y7tuCyA4eKpRRk5nY6FQ9C3bEnrlg9beAfMlyXBcPqA7CflEwHoM4YkYSrev4lE0
 V6JEGwvgRAo+4YUPi2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120129
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

On 8/12/2026 7:26 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
> <snip>
>>  # Multi arch tests
>> diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
>> new file mode 100644
>> index 00000000000..9c31694fbac
>> --- /dev/null
>> +++ b/tests/tcg/aarch64/system/meson.build
>> @@ -0,0 +1,108 @@
>> +tests = []
>> +
>> +minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
>> +minilib_printf = files(minilib_dir / 'printf.c')[0]
>> +link_script = files('kernel.ld')[0]
>> +boot = files('boot.S')[0]
>> +cflags = ['-nostdlib',
> 
> We need a -ffreestanding here
>

I'll add it, thanks.

>> +          '-Wa,--noexecstack',
>> +          '-I', minilib_dir, minilib_printf, boot,
>> +          '-Wl,-T', link_script]
>> +qemu_base_args = ['-display', 'none',
>> +                  '-semihosting-config', 'enable=on',
>> +                  '-kernel']
>> +qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
>> +
>> +# Multi arch tests - add cflags only once per src
>> +multi_src = []
>> +foreach t: tcg_tests['multiarch-softmmu']['tests']
>> +  foreach src, setup: t
>> +    new_cflags = cflags
>> +    if fs.stem(src) == 'memory'
>> +      new_cflags += '-DCHECK_UNALIGNED=1'
>> +    endif
>> +    if src not in multi_src
>> +      setup += {'cflags': [new_cflags]}
>> +      multi_src += src
>> +    endif
>> +    tests += {src: setup + {'qemu_args': qemu_def_args}}
>> +  endforeach
>> +endforeach
>> +
>> +tests += {
>> +  '../../multiarch/system/memory.c': {
>> +    'exe_name': 'memory-sve',
>> +    'cc_feat': 'sve',
>> +    'cflags': [cflags, '-DCHECK_UNALIGNED=1', '-O3'],
>> +    'qemu_args': qemu_def_args,
>> +  },
>> +}
>> +
>> +tests += {
>> +  'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
>> +  'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
>> +  'gpc-test.c': {
>> +    'cflags': [cflags, '-DLOGGING_VECTOR_TABLE',
>> +               '-Wno-main', '-Wno-unused-but-set-variable'],
>> +    'qemu_args': ['-M', 'virt,secure=on,virtualization=on,gic-version=3',
>> +                  '-cpu', 'max,x-rme=on',
>> +                  '-semihosting-config', 'enable=on,arg=3',
>> +                  qemu_base_args],
>> +  },
>> +  'rme_gdi.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
>> +  'semiheap.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
>> +  'semiconsole.c': {
>> +    'cflags': cflags,
>> +    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
>> +                  '-semihosting-config', 'enable=on,chardev=stdio0',
>> +                  '-mon', 'chardev=stdio0,mode=readline',
>> +                  qemu_def_args],
>> +    'wrapper': [prog_run_with_input, 'X']
>> +  },
>> +  '../../multiarch/system/memory.c': {
>> +    'test_name': 'memory-record-replay',
>> +    'qemu_args': qemu_def_args,
>> +    'wrapper': [prog_record_replay],
>> +  },
>> +  'vtimer.c': {
>> +    'cflags': cflags,
>> +    'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
>> +                  '-cpu', 'cortex-a57', '-smp', '4',
>> +                  '-semihosting-config', 'enable=on,arg=2',
>> +                  qemu_base_args]
>> +  },
>> +}
>> +
>> +tests += {
>> +  'pauth-3.c': {
>> +    'cc_feat': 'v8.3',
>> +    'cflags': cflags,
>> +    'qemu_args': ['-M', 'virt', '-cpu', 'max,pauth-qarma5=on', qemu_base_args],
>> +  }
>> +}
>> +
>> +tests += {
>> +  'mte.S': {
>> +    'cc_feat': 'mte',
>> +    'cflags': cflags,
>> +    'qemu_args': ['-M', 'virt,mte=on', '-cpu', 'max', qemu_base_args],
>> +    'gdb_test': ['--test', files('../gdbstub/test-mte.py'), '--', '--mode=system'],
>> +    'gdb_feat': 'mte-baremetal',
>> +  }
>> +}
>> +
>> +if 'qemu-system-aarch64' in emulators
>> +  tcg_tests += {
>> +    'aarch64-softmmu': {
>> +      'cc': cc,
>> +      'cc_dockerfile': cc_dockerfile,
>> +      'cc_docker_host_arch': cc_docker_host_arch,
>> +      'cc_feat_cflags': cc_feat_cflags,
>> +      'folder': 'aarch64/system',
>> +      'gdb_arch': 'aarch64',
>> +      'gdb_feat_version': gdb_feat_version,
>> +      'qemu': emulators['qemu-system-aarch64'],
>> +      'tests': tests,
>> +    }
>> +  }
>> +endif
> 



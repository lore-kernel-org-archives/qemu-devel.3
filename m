Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA892CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU5kl-0004T6-I2; Mon, 01 Jun 2026 12:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU5ki-0004Sb-S5
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:44:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU5kg-0008Tx-Ej
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:44:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651Cbt1r599781
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 16:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UjLBKhKszmocnYPvikfKApl6WGTIDb8J6CUq8j9GVDY=; b=b8KuHSh2J3Mt+gcT
 EPAGv/I+TcgLVDOlA2Lu5rUdPsj3bVJWEXwCVR9v1ZIl15COismJhgkAayibX4ia
 JRkK3VDoaPgCLxbF/dD+PGhtljOKhUG10aPBuIF0xNEHoD6+BOwwQtB/AyrlLMOW
 qij0zgWr1Hx3MgPIrOoevJIjDZJKRHM711ACqPUD5Rm95OsoSzgdtUc+rf1wms5B
 uXvqUMPJl/kGPzartYz9hmBL5pacoaiRxr+HG5NziHYWSaeehjrnVo4RiSuIhyk1
 d7B/ousVmXFWd+qXz+4fShmkDXheoA6jBNW7JwLKP19vF9z5Rgn1jBPPvET4Y4Jn
 2RAU+A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eha8r930q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 16:44:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304e3e3fba5so16046563eec.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780332271; x=1780937071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UjLBKhKszmocnYPvikfKApl6WGTIDb8J6CUq8j9GVDY=;
 b=Y5Ru90lQ71DT2bhuKNXs+Vi4e/vwknQXOxXUCMpakN+GT2+5Op+Yf86WJOCbvo8RIZ
 f9F3QMY5mBscggLnU9LjEtKSt0edx54hMHBdCq8oikaYiO6iGyAqdsIVgY+5d9XCkLOk
 mLZJvJpe7kBEajK34PZv5+deqozf1inROV/DRP5t/G8KyrcyChxcXyU51agqAvYofGzb
 goneS7SRejCKu/5PvyrOtY5KVOkGCO81LeRXi2dmpPcgKDoXFtvnlYvcVPE/auMZ5sfQ
 7VyGTPJnhy/eSj7VkE4yo7vZPlKtsUjFi8h/n4eB4rpjtdDnU0Zcvi3dMk19j7Wiaumh
 fISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780332271; x=1780937071;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UjLBKhKszmocnYPvikfKApl6WGTIDb8J6CUq8j9GVDY=;
 b=P5qDH/nMjJjg1ZVUHOm5FW0OyP31u8Q/tLoFCqhzQvdXnDvdnBCQSM8W0iLcHCpcK/
 zEX1u27lshoy2Lv+MmFdBhAZgE6e+MXzwFqJ4VUBtci36dZDvWV7E9mvE28kfdUosJuY
 SfnOfMtzv4AUnOcM4190eca/7sHBjjRP8c2LHa/RI19bxWes9Xt9fwksdj3uczTMyVqk
 dvQUV37huyEXMSZGE7EAkCfUqckP9z3vhnzUDrkngZ/7+GfYw7mv6USS3oJwnclmCMxW
 d01PGTVT7xaMEf9IGpDZdoHg6rgZ+8sffLl30E3M/DPRAb5EPuERHOq0bOnOP62TGJkP
 T5Ug==
X-Gm-Message-State: AOJu0Yz1+S+NqdO5QNlvX77wluKSqvu96bL/rXIfo9TYB/JlGlAX+7mc
 texztBL3Z2UUs+bl10fbQWhLD6aQJ5Qb8c1rNEKRNeeCnocGq6fMdQc/S/7sdpywa95+X14nbjW
 /y5WZuTbOZMP1Y8k8QP+9x05qr39nOdmZ77QcXDSXbg7i2dosPSp4u0fpqQ==
X-Gm-Gg: Acq92OGgLxlsEus6ChbilKqZq3STk6+OObCKjfv9hXk510kp5OGWo2Q3C26MSuYhgtU
 qfVkskNY6CEWWYQ47hT4ZGd3dCfNV2VptvuOR+l85vT3gl/yntGn92wmKLMqjSBoY58udcYDhki
 PZuvEjOym6lauAiacbiA0wBEPss2dOHWPUu1GVoDcVKiEtkV9RAEjkz4tv1MnZ5gzJ3ceVY+nQX
 /nbsSeLX4KQOtbOm/7EiXX6/OplPjOkWkNqNXyqf0GIUqzWrQhyAJuUdJFIDZd6j+tFQb+otBK4
 nCJDiHq/kAhq5wHWxFsc45omX224TzVTvi40rUxrQtw0jiEf0Xdi/cQ4NRNltMfcLHQXQ4UCl3t
 cw0/Y0pyPqdkF0vszq3jlSByrlh13KZusYLEdyHI+uU5BWW/s8en865QeIDdKYoUeNZ8VdFRrqf
 7Nh5Z5Y0Q+EI8DA/EXEn0D64ID
X-Received: by 2002:a05:7022:252c:b0:128:d4be:7428 with SMTP id
 a92af1059eb24-137d4271b93mr5583098c88.19.1780332271449; 
 Mon, 01 Jun 2026 09:44:31 -0700 (PDT)
X-Received: by 2002:a05:7022:252c:b0:128:d4be:7428 with SMTP id
 a92af1059eb24-137d4271b93mr5583076c88.19.1780332270886; 
 Mon, 01 Jun 2026 09:44:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137dc179940sm4861576c88.5.2026.06.01.09.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 09:44:30 -0700 (PDT)
Message-ID: <22a283dc-38a5-44f5-b402-c334205e81cc@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 09:44:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] gitlab: work around the inability to build targets
 for MacOS
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Brad Smith <brad@comstyle.com>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cornelia Huck <cohuck@redhat.com>
References: <20260601143129.144786-1-alex.bennee@linaro.org>
 <20260601143129.144786-3-alex.bennee@linaro.org>
 <57d0477a-3bbd-4948-8e18-33df41991545@oss.qualcomm.com>
 <87bjduxmne.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87bjduxmne.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aKnAb79m c=1 sm=1 tr=0 ts=6a1db6f0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=RvC67grr7DDNViFLJkwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AbIxS2nrV1afA69gkHiVB_gq5hJ1r1pQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2NiBTYWx0ZWRfX1vwOyTy8p+CO
 JSRBHxJS69x/25Tx7erbx2fdDETCAZfGXyvNLSjv3s9dnhyCTycQBnqWE29hpi8KJT5Fa8Op9S6
 Hyqb9yIpYPicKfWcXTHiO/60ngdgdsa+VFdAMwMC7JeC4atSrLFj0wi1kjHS1d5MQTYLJpH9x7O
 VetQwFojVh9mmeuQp7WkCXa3HWH2h95Lv3ySZfwLK91DNDuwh4v7kibsymTQ8hGb4/Uo8xY6zuL
 jxGHOFOltzDZNQdS/0sSgEpOfPfWLvW2YGsuSJMfMEq5sKmZMqVb5Bw3mPHEn0oOmRTvmpL1wF+
 6/jou6NcM0KfiEQ/MfP54Tb2YRAgYhavbLTTVRvzohnX+Fiq/jWaoDp3xVTJwpEtp3WbHeq+c4x
 vNARgh1m9FoNQ5j4GkZ8dKuFnGMUaq6uuX/7SO9odoC1OKj76LxaMasx7yBVqWCn3Qeay+XOhP0
 SmMnYUu3S7lcoFaUezw==
X-Proofpoint-ORIG-GUID: AbIxS2nrV1afA69gkHiVB_gq5hJ1r1pQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010166
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

On 6/1/2026 9:15 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 6/1/2026 7:31 AM, Alex Bennée wrote:
>>> Unfortunately a previous fix to ensure .ninja-goals was set for the
>>> TCG tests broken the ability to run check-functional-FOO. As we have
>>> now reverted we need a solution for the MacOS gitlab run. The simplest
>>> is to add an explicit make invocation to build the signed binaries
>>> before we run the tests.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  .gitlab-ci.d/macos.yml | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
>>> index f61750a3f4a..8366b4ad564 100644
>>> --- a/.gitlab-ci.d/macos.yml
>>> +++ b/.gitlab-ci.d/macos.yml
>>> @@ -29,6 +29,7 @@
>>>      - cd build
>>>      - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log meson-logs/meson-log.txt; exit 1; }
>>>      - $MAKE -j$(sysctl -n hw.ncpu)
>>> +    - for TARGET in $TEST_BINARIES ; do $MAKE $TARGET ; done
>>>      - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
>>>  
>>>  aarch64-macos-15-build:
>>> @@ -44,6 +45,7 @@ aarch64-macos-15-build:
>>>          --cross-prefix-i386=i686-elf-
>>>          --cross-prefix-x86_64=x86_64-elf-
>>>          --disable-plugins
>>> +    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
>>>      TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
>>>  
>>>  aarch64-macos-26-build:
>>> @@ -60,4 +62,5 @@ aarch64-macos-26-build:
>>>          --cross-prefix-i386=i686-elf-
>>>          --cross-prefix-x86_64=x86_64-elf-
>>>          --disable-plugins
>>> +    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
>>>      TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
>>
>> Could make all be enough?
> 
> No - not without the goal having the signed binaries in them.
>

Which comes back to my initial (unanswered question), why do we need
signed binaries for running tcg tests?
Signed is only for HVF access.

>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 



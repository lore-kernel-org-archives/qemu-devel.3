Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD226C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKRA-00024K-Ka; Fri, 10 Jul 2026 19:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiKR9-000245-MM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:15:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiKR7-0004TX-MN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:15:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Z5Y1623342
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 23:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 40yOhYY/lYPKjLjVSE9aiodgXt8cy+o7JwY2DHmihgg=; b=L5mO3wValsdKafyP
 ELEg19guyQ5q/btgb7d9Ly6lXBPsrVfAndbjo7aJwvwPwpCtSyP2ihSbib5luzmM
 RUqz9cRpzXyyVe1C1cArnrj5Tp9mPn4I48uxdj16hAc+twDLvqa9QLWXzKRs23wj
 sckBif6m1mUP+sF/7wp5K38lqSz23SNfXUoRl+FwULVmU3+a9Isasqv2eqAsKOlW
 OIdDvcj5MUzEPuClRy+ewNoT+i+/BliwJz+fIvWsNDQYbVhs9APS9Z+29dF+uKKz
 ViNaq4gjcsh/oqM0Rt8euBLRDfqtZjmBSFDN2Wk8OCdsbmd0cswPsR4PN74gapCk
 O5TZ7Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm92kw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 23:15:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c892143db7fso1353152a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783725310; x=1784330110; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=40yOhYY/lYPKjLjVSE9aiodgXt8cy+o7JwY2DHmihgg=;
 b=IJoCCI7kXEXfEjkaIrVWiA3M/YITvs4pVxlbEaJk8IOAxXf98CrONTgA9mxbaQJV8o
 gDG4MqcjrHKGI1LZUDb7j+hAf25N+FbOCMuOeRp/h+oDbz/DYQ3wRAYPZCrhu6+otwV6
 /2J196YX2YPlzeCPWGXShRUOCvcaW/PLpi7c/EP8nrn/asfk88nsx8Y9qmS1+IS3SLYE
 W/yvVlfSpVy9eV3Uq7pdOypvOURfdyV3wBfwg1LPJEI2hWXVCboXybkT5+vLWB29xyVQ
 GqXN2U37Q73QqYeeVGadMJHSOkYz2/kVxJuk9b4eoaR4WTXmypAZHa3UFIaLtFR3E1o4
 czCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783725310; x=1784330110;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=40yOhYY/lYPKjLjVSE9aiodgXt8cy+o7JwY2DHmihgg=;
 b=lqhkV5waIhVBY2041xuGHplQkKIv4oLwLzANLCIBDjtF3XPoUVmWuSqLCZTW5W6SnK
 UmitWgHgCHvRdbqHDvAm3D+PnkKkkJVWj5X4gfnu4JeqIqN+vb0ALx9KbbNK/rNxUz7Z
 2e1jIh5cy5f4LAQ1CBHgfCSRgK8U/5vWotaqZZvlcOadnKzeRnIilX0pQqeeJ6j0Fyhr
 QyI6O8nmKzktTB69Tz64bFVwpL7kDJDbcaSC0UGgtJHUT+Ok/PAiGlL/boe5ly7fbcQe
 +iflp7ZsIbNRD/r0LHcGCWr+dQGq3aoi96H45EDmaPmEOpUsRWaU9gX4dplS7yHqoitY
 4XyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMGbNkeHMRSUpIx1WQN2qVvm4LfdsZnukhAl9zF38260b0zYLwdM5WEZnFKRTSmoi/rXVH99VJEA4H@nongnu.org
X-Gm-Message-State: AOJu0Yw1UYucgSA1YFULNQJMtL8r7tvqZcNmg2C5Z1TVVDSf2WtjOYs4
 XN6JmzK8pIgXKqywhPXjyx6HfpSNpn6V7HuXxIn/HNPHLgfmMsUowAnTyGUD59jt16Sb2c+l/f7
 byS18DnYuZXmQOIpG1ZEyVxM84EsYWXuYQRoEtP5NiR+2okn9NI9l6JQdrA==
X-Gm-Gg: AfdE7cl09+p9m7+n0VC2XMVonZOTGh+bh1xeTIoLnqNngacJ+dD2/kgwoqKdSX32yiN
 YH31n3f235TLDqaObYy/SCzfaE17pO2D0pZEm/HLWLjKNlu5Oss4fdRNgrqgnjGW+cj0moCHk4V
 tsVa/eVC9QTGLzJzBjFy2y0/Yc+24ZDFpeNzZSzL3TZyFyvx9JN8BfO2uDKnmad40P/1rqVOUvc
 yjMqXTt/0t2llxyNgZvPL3On1QeNTA154+rAWyHVKISKXNhxFgkTs/JBuafWeVzcUZnQD2oKu1y
 QqlkaxisQ0KLL4ZAvpt17uWJ2Hzu0ahzhzJeRqMmbJk6ToCRkvz9u9oZuaXG0vZN9nzaahUqzH9
 bTX6fnrNWeuPNCoD/8JiWhH0WQhe4aJbxudpRLUqg0R8BFyQKE3MegRFPyw8KU9rLv0OzBb2nh/
 3SYII=
X-Received: by 2002:a05:6a21:398d:b0:3c0:b3f7:e5dd with SMTP id
 adf61e73a8af0-3c110a74439mr888344637.42.1783725310285; 
 Fri, 10 Jul 2026 16:15:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:398d:b0:3c0:b3f7:e5dd with SMTP id
 adf61e73a8af0-3c110a74439mr888307637.42.1783725309744; 
 Fri, 10 Jul 2026 16:15:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm79561130c88.14.2026.07.10.16.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 16:15:08 -0700 (PDT)
Message-ID: <a57b4879-b850-40de-a665-089b897b98a3@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 16:15:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 51/98] tests/tcg/hppa: user tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-52-pierrick.bouvier@oss.qualcomm.com>
 <eac788e5-bb7a-4644-8355-110975562531@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <eac788e5-bb7a-4644-8355-110975562531@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: buH13VXTNfHdTDEWK_ZvcZF5bfKuM2Pt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIzMyBTYWx0ZWRfX/+Yr3+flnwPn
 s/pHFsgLRMLE1OPAc1ZDDNMl1sIDed0v7HJCpO4yCI8Vt3I+T5TzL3Wx7x91g3GR8s695QqvV6R
 D/gGeTGtItGnvuaDNHRTRhPk7gTAhmE0swXeeOVZtkntk8+0XtcPWJ4oNbWopmWiRclBKyaGGbp
 d7HkNAFEg1eFcNxY7C9Fr4CoXbBwcve/ZYN/G54YkeYrUeO8XjnF5mI8Y+VlgUxYmROcpjHY1D8
 GIu9OEH5u8VFV5e7FOOzDkLjg5S+bHiPqJTqxDRgpT5eQimsk3wb0kN2gpSPapdVcgcCg8EYCUV
 0UhFUASe+7pwRqHQwqqs4b+rJgBd3WYmKg0j0I/5021kX/p+HPvjLo/RO4zxA6XzPyWwUTpLQe5
 wtx8Nw1DYja9+GW0gU+/amH6dT0w4mII963AACbhWwr3qBOrGv0LOYoYFxJCcYIItQkbYswv3DT
 MmsrQ2IbLuEl4MlLQIQ==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a517cff cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VZqxrUBuObkCrG7nq7kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: buH13VXTNfHdTDEWK_ZvcZF5bfKuM2Pt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIzMyBTYWx0ZWRfXxz/5k5VPMYm0
 tn0yDeHfnhJqMXFKtNPwwe4Ee353V7DCM35UCeXNmlcjlXmfe9CixMChjCL9xz5w+UZdq6m2OW8
 S/9KewF9EkFxyHVVxKrxAruDhzfCW5A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100233
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

On 7/10/2026 3:24 PM, Philippe Mathieu-Daudé wrote:
> On 10/7/26 23:42, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   tests/tcg/hppa/Makefile.target | 14 --------------
>>   tests/tcg/hppa/meson.build     | 22 ++++++++++++++++++++++
>>   tests/tcg/meson.build          |  1 +
>>   3 files changed, 23 insertions(+), 14 deletions(-)
>>   delete mode 100644 tests/tcg/hppa/Makefile.target
>>   create mode 100644 tests/tcg/hppa/meson.build
>>
>> diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/
>> Makefile.target
>> deleted file mode 100644
>> index ea5ae2186df..00000000000
>> --- a/tests/tcg/hppa/Makefile.target
>> +++ /dev/null
>> @@ -1,14 +0,0 @@
>> -# -*- Mode: makefile -*-
>> -#
>> -# HPPA specific tweaks - specifically masking out broken tests
>> -
>> -# This triggers failures for hppa-linux about 1% of the time
>> -# HPPA is the odd target that can't use the sigtramp page;
>> -# it requires the full vdso with dwarf2 unwind info.
>> -run-signals: signals
>> -    $(call skip-test, $<, "BROKEN awaiting vdso support")
>> -
>> -VPATH += $(SRC_PATH)/tests/tcg/hppa
>> -TESTS += stby
>> -
>> -stby: CFLAGS += -pthread
>> diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
>> new file mode 100644
>> index 00000000000..9ca8f29fa93
>> --- /dev/null
>> +++ b/tests/tcg/hppa/meson.build
>> @@ -0,0 +1,22 @@
>> +tests = []
>> +
>> +tests += tcg_tests['multiarch-linux-user']['tests']
>> +
>> +tests += {
>> +  'stby.c': {'cflags': ['-pthread']},
> 
> Should we mention the 'signals' test?
> 

It passes this torture test on my machine:
./build/pyvenv/bin/meson test -C build hppa-linux-user-signals \
--repeat 100000  -j 256

So I would be inclined to give it a chance and let it run by default.
What do you think?

>> +}
>> +
>> +if 'qemu-hppa' in emulators
>> +  tcg_tests += {
>> +    'hppa-linux-user': {
>> +      'cc': 'hppa-linux-gnu-gcc',
>> +      'cc_dockerfile': 'debian-all-test-cross',
>> +      'cc_docker_host_arch': ['x86_64'],
>> +      'cc_feat_cflags': cc_feat_cflags,
>> +      'folder': 'hppa',
>> +      'gdb_arch': 'hppa',
>> +      'qemu': emulators['qemu-hppa'],
>> +      'tests': tests,
>> +    }
>> +  }
>> +endif
>> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>> index e6206ae670a..018bc480e18 100644
>> --- a/tests/tcg/meson.build
>> +++ b/tests/tcg/meson.build
>> @@ -138,6 +138,7 @@ subdir('aarch64_be')
>>   subdir('alpha')
>>   subdir('arm')
>>   subdir('hexagon')
>> +subdir('hppa')
>>     image_targets = {}
>>   exe_targets = []
> 



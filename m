Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCA2C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9ULs-0005zq-4l; Wed, 23 Sep 2026 17:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9ULM-0005z4-3Z
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:17:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9ULK-0000iy-0L
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:17:31 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NL7jj91339598
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 21:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qxjw6fCFrurM9xFxSnJDTp+HiIk+RGMe1nbquH2JRt8=; b=E9LIpdG0fcpvI8aI
 GeNDQBr4qRom3kbzDxHkmK7YMwHWClFMH6rfyaww/1WQVtc265FiXsLlFhSTpspg
 Y1dNOckxqGcD7KMxwnw3g8+uS3GNEVE1v/h/8fNib40NCPAtfggRWGOAJcA0Edh4
 1CnZ5+U8El4Zrlo3vFYNs2BLnYA1UhL0EQi3EzHcgQzMZ7I960cnK68kR6o8qPar
 6Xhnheta7MH4067w1XS0CBX8Np9XDVc/TAyRJ40I2gy7JXnqFQcJHeh9sAopvpiz
 6GI/6Jt64oq3iba4HfCPP2TrkSfQEd3Pu7iMhnIXWzug5sVEkzB6bsCVD6LMrVYt
 kDXeyQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjsj2ea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 21:17:27 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-331b2ec616fso868107eec.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790198246; x=1790803046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qxjw6fCFrurM9xFxSnJDTp+HiIk+RGMe1nbquH2JRt8=;
 b=LREUn8a34T138dqZ5nQu/rSXPNIgIWmD8Nj3egeElACJ1rnNQYXtY3Pxg9ElDl9Ntr
 qkefSdKXPnOi9c6r0bPOPR8EDUIvszNRq8qXDaMZCJDyoI+Jbxmmf3F8IM984C3gyfBV
 U5HxDkHkxjBucgQi+DYDZ8dwT0hv/neGuctZ9Hjjzek7HXgqKgeaHt1ULzFvg6po/9yc
 z/lNYabrScjBmpY+ydvGSHSMvZZTyQtAmvE2zzhNZidd8asbr9qIdm0H2W8HLgPSMgpR
 B7PjtyZH3iwcLFrKaGKggIUnRFrH/TDsIWowN2Q7IbNmezwG6vPAIAjB772on6z/iTMX
 bqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790198246; x=1790803046;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qxjw6fCFrurM9xFxSnJDTp+HiIk+RGMe1nbquH2JRt8=;
 b=x/8JM1sNAKKx5lmXlLy9RvWz+/7Pt9d4B0DvxQ+F6yjvDljBaKi9qPRJh9eAmcor93
 J+zyUEq+Pxf5WJt0LBR8XcPUmd22AVgY11v038Jc4rXJ+1bwGLu3kqzTLzrnpRa9r76M
 Z7i/uj76lN3+Ui0kq88mcNsUDNJjho+xjlYz4kQC9gTt5gqDDVupMBFwpOCAN03xLK4b
 Cp0QdDPVuEELuwM6PNlIz3un5tTFNC3hb5RO7wZpYRovcKxR4XBPlbuosUhZBRpo5Sxs
 DUQtUzpOc/7JVxNv/ly4c7G2IZt7yUNA6xfw0NrACEVXsN0GPdbjxd2ZZoc+Y+q1QKYu
 Gg5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwP8WYxuVjq8KN3gn3kEsUd3EqZU+xiqsLhnzUvM6wtD9ulzO0x9W9OZ1TAel0HEJgo9sIVSoDYxKXs@nongnu.org
X-Gm-Message-State: AFuF++lVP87fqlGh6Ju6e1cqrSNeoNtwSW+Dbd3/Dj1AzAjAMtgwaX3K
 RHvuE1CeepKC1fa1yRmcQOvGwZBxOEIY9++CE8k+H+2Kg00w8/0xH9M+f4hda4Qg0PIgYlFsXK8
 +Ywf5zjpVTz1ywED87Ohd3R3vSBrI9elxGW7zNhu9wvumhH3JyBk520jkOg==
X-Gm-Gg: AYBFou28vQdjKMXGnmmJzGmVtfo/RSNTGxDZ1aCXoSaigiCh1KYEX5vYEqDIBOURNiR
 /2IQjHD7ev6c+RlTijTnQ8F8qgdGmCj9wW6uDoD1/B5w+4Vmrs4yYufN30iGetEBsfgAA3Tbzgu
 skx0daRzE39soxijtnn+q84+Y29z7E9yD1j0zZQccfBLrLFcB1Q6B6gzErknvDFgqIuJLqR3Qpv
 qD2LieMZjR4UO7vYftQC9uBufScdTPETGJtf8zZnJcwAcY/2C3pzieVC4ezimTL5820XwVKaJ8D
 bLfZjuytFrYorTFISCyrmxSOGd7Af7U6eku1aDUBKiqKepysMYt+V72QkqW0yi6MIjnAtHHBi0v
 ZdrYhxnMrO7by7xVdPbe2G5yY8+38B9eQ9DArO+6JPcsk1AZIcBdbCFa+79A9QXV+LNg=
X-Received: by 2002:a05:701b:4343:b0:143:2984:6517 with SMTP id
 a92af1059eb24-14503ff8f1emr262542c88.38.1790198246246; 
 Wed, 23 Sep 2026 14:17:26 -0700 (PDT)
X-Received: by 2002:a05:701b:4343:b0:143:2984:6517 with SMTP id
 a92af1059eb24-14503ff8f1emr262509c88.38.1790198245374; 
 Wed, 23 Sep 2026 14:17:25 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f986e465sm8248250c88.9.2026.09.23.14.17.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 14:17:24 -0700 (PDT)
Message-ID: <3ea1a277-f291-4824-8969-1cd9784de1fd@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 14:17:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 091/105] tests/tcg/x86_64: user tests
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-92-pierrick.bouvier@oss.qualcomm.com>
 <935e6ab6-5f86-4f1b-80ae-42c7219eec46@redhat.com>
 <5f719ab6-442a-4eb2-90cc-0475016a816b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5f719ab6-442a-4eb2-90cc-0475016a816b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA4NCBTYWx0ZWRfXxZ7RoB4aQ7gz
 ZLr/Ozm7w94TmFFCOfX+s6SSsPhKpuFp1IhVCLYt7Dk1abxa1FjgAM6p0lI+VNTWZDohwcpIDr3
 KbNP/0oomog5acs5XtDaidtu5M7bA02uOVC/6psoEoLDfZzrbAYOC8cfd58wXjnJQC+pUEfs3V5
 U05euHmr4MBK5ceq/zjiOqQyl4FO93j7nH79OzympGxbzR0Yl40SdGq1ybJa7jKlKLCly8ZSMkb
 fkBHxzHBRPwRGlEEXWUSKfHYls6KeG+M8+C+z7Ly+X2ANGr4jm667QLwdsNeROfFWQ7/9QRjzpr
 ss8beefCZJZ7ZHp/6LBa0N2ZTZLCo+Hh5HyL70/TLXGNCNKOYkkEIl5+9aOcmwVYy4g/r61OpCz
 yU3TeHeMMm9s92OpxVrUL1NmLtCwe57p0uv8637Au/P1zn9CpXu2a1R/XzB29Jl8qVUb/SgzHgS
 /2Y04mOIWZ6ijSlqJdA==
X-Proofpoint-GUID: db1X9bsqPvTBf9BppV4y1reeN0CjY7Sq
X-Proofpoint-ORIG-GUID: db1X9bsqPvTBf9BppV4y1reeN0CjY7Sq
X-Authority-Analysis: v=2.4 cv=K4+3jCWI c=1 sm=1 tr=0 ts=6ab441e7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=kqyVvINrTMZH2b-3Nx0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA4NCBTYWx0ZWRfX670XWqzHZ631
 UVbEsYiZLpHrPbyCgRPzeb6LGUfArbkcEYUTpGqJiHH4PKdIAXGgHiEwp2RVvQT611wps+Z9jx3
 NufIW4ejshw+jBis/sYyI47SzNNfndY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230084
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

On 9/23/2026 2:08 PM, Pierrick Bouvier wrote:
> On 9/23/2026 12:55 PM, Paolo Bonzini wrote:
>> On 8/28/26 00:14, Pierrick Bouvier wrote:
>>> diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
>>> new file mode 100644
>>> index 00000000000..2607a1cbcf4
>>> --- /dev/null
>>> +++ b/tests/tcg/x86_64/meson.build
>>> @@ -0,0 +1,82 @@
>>> +cc = 'x86_64-linux-gnu-gcc'
>>> +cc_dockerfile = 'debian-amd64-cross'
>>> +cc_docker_host_arch = ['x86_64']
>>
>> Configure was able to reuse the local compiler instead of requiring docker:
>>
>>   if [ "${1%softmmu}" != "$1" ] || test "$target_arch" = "$cpu"; then
>>       case "$target_arch:$cpu" in
>>         aarch64_be:aarch64 | \
>>         armeb:arm | \
>>         i386:x86_64 | \
>>         ppc*:ppc64 | \
>>         sparc:sparc64 | \
>>         "$cpu:$cpu")
>>         try='native cross' ;;
>>       esac
>>   fi
>>
>> Paolo
>>
> 
> On debian, gcc automatically comes with ${arch}-linux-gnu-gcc variant,
> so I didn't replicate this mechanism.
> Maybe it's different with fedora?
>

Checking on fedora, gcc comes with arch specific variant, under the name:
- aarch64-redhat-linux-gcc

What I proposed before (and let me know if it would work for you), was
to add cc_extra field as a list of compilers, and so we can cover names
for at least: debian, fedora, macos (homebrew linux cross toolchains).

With that, we cover 99% percent of setups, and we can automatically
switch back to containers if nothing really worked.

It would solve "reuse my host compiler for target == host arch" + cross
compiler on multiple os at the same time, and for multiple targets.

> In all cases, I can see to restore this behavior at configure level by
> setting --cross-cc-${arch} automatically based on host arch, and if gcc
> is installed. Would that work for you?
>

Let me know if you prefer the option above, or just an additional part
in configure.

> Regards,
> Pierrick



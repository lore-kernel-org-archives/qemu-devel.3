Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCC0CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEGN0-0002nk-OM; Tue, 06 Oct 2026 21:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEFRR-0002PK-UV
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:23:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEFRB-00029o-Kr
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:23:23 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696HCbMg018299
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 17:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /6BiI61Cte1mhMhN3Xi5Ms/6VjIniSBqjSgqFpfWm5o=; b=k312MgpzyNnuRWJ4
 G31U2AWDUe+6iIWOBeQIKS4NT/vZc1KmceuL748GtMvYNC//mTjBil0HFwONozoL
 owPgGJrXUkfcjjnSoB+JF3bK51FXDF1SGlXNMWdFK6EDbsUe/1xF/NAVPU1LJWn4
 r2+cAP0uiyxKooqdF4ROKGxAtYTCO7eZlVFZQt+O8GWcMz9h7I2UA/DazZgRvAhz
 UEqSTWZERs/79NNZ4x065LYx8dlABuaNJLeH4NLiDEyCJDhmUhhjMLg6dxcHDpW6
 7tLUvIfx2o409agj5LV+4IXP2nyRzLH+d9+wMFS8jNlsH2vDPAQtme03gHz2MwH4
 CrW55A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4y91hq7h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 17:31:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34d49d8dee1so1668817eec.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791307910; x=1791912710; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/6BiI61Cte1mhMhN3Xi5Ms/6VjIniSBqjSgqFpfWm5o=;
 b=bATI1jq4Pq8mRAPvw3fzL/h6CrQMYlTBuCsVd/Z/FH7yBiCS0IUOfZwV3HF0LG3yOX
 9V4lltZUupCGenDUd/RywhlwjLcKzmdlwyhD2W/6Rme/bacI5snRXDMugOVfaarYOgWK
 1kunDkStRQUwviprAygzLDzlyEnjADlcm528x5r3kglRQAmtvcEbFEACaD07Es/ohbiY
 uAQJdVnK/nNJd2nm1xT2VSI1t22LcMOts/Y7hBpgPzw2cQxMquBLSA6aKt4AUrlkm84O
 ojDus6gdGU1NHM028MxUGjQSkspAmSSKfnEpodGiadggGWLqYtPDWlTuPXFeV6L7f75F
 OFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791307910; x=1791912710;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/6BiI61Cte1mhMhN3Xi5Ms/6VjIniSBqjSgqFpfWm5o=;
 b=oZLKvyKi1c6TL7AItLJG1Y0blLbFzkzZvK0/yAz/Q5wl1yFmlt8pxoWJ0WS71Vd1nA
 2MQDmCqzS72We1xlMjN2jt4fWHCzdP0hmdYc8emrTZqPS05RRBbZLAaMBdnpl5KMVZyg
 25V9NxLT9jhPDIcnqATNPWOhr69so74cE6OQokPNApRc4fzcO+K5OuKVZi2SXZpBmynH
 JuoR6OezfQTVmfgg6OxvWavwPBRQ2L+QF5jTad9GEqnWVe8CuvXC2yT3eit2BS1W0aqc
 /YzD68z/D/nZvsoiIGHGM6RZ4o8hFgvt8eFEADz5h+N20R6IVLgRLSOHw2OjHDCe2H81
 i4tg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVzpVsTCskcBo89QMv7/t+nWAWbrGgFlBXMrNL/f+zfKpVgHccQQC5gHPS3bZ5rAKZUNLzdlDNaHIE@nongnu.org
X-Gm-Message-State: AFuF++mMa+OQ+hCEQuQKEOgtC/T9cOSlRS1irSuV3bGHcdhbkYOpTrj/
 09a2XXz7StojQl3WkdTwiY9OJsRlVIG2Z2Q9LMvMSC5xCajaT+SOMP/BW9HxkBLxWd+mWfdtdHH
 wkGkeGtQ9bzgONLhbhD0TJtDn11RQ+6u4aU83XsxafvPu4ybT6CbAlprfvw==
X-Gm-Gg: AYBFou0OeYqHIaXHguBjioVYRXuBFrRqpmQ3CHfwXgGmjiwez/iiJ6T6FwnPaFyQj9n
 +Zape4OIF5D545AEhggGqFJtnR72C5IzLW9Vl+lTYa3V+Twv5NCZkpsSXvHSKECT1kYJ2OpOKzr
 qhLwgtDk90IUzBIoLvh6RcrIDYF3DZbQ5BgqoaM22yXDqwfLWQ3n7evANPqQOUNCVD/oCvWCJml
 WCXOhu9uv7ZnALPjl2y+YQ+g3sCh6hyZxTH2dcpnAYjIHReL/P/hQGnCcbxngDoOmVOQCIoPfc+
 DLwZ2jvl1pax6NF+fGITsay5P6+XbVJhOxG3xmWc33RN+vnZtCxabxHjhclAQTCjwU9Hu1l18fv
 uq1YsdQ/qY/i+fQxgkDh5gAltm+HMMmJ6ZeJlaBkPZ2jiPJqE1+NkgU6u360PY5VbhJQ/MA==
X-Received: by 2002:a05:7301:7004:b0:351:3c34:9bfa with SMTP id
 5a478bee46e88-3514e3523e1mr2479506eec.31.1791307910158; 
 Tue, 06 Oct 2026 10:31:50 -0700 (PDT)
X-Received: by 2002:a05:7301:7004:b0:351:3c34:9bfa with SMTP id
 5a478bee46e88-3514e3523e1mr2479469eec.31.1791307909420; 
 Tue, 06 Oct 2026 10:31:49 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35159d58ff3sm199457eec.28.2026.10.06.10.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 10:31:48 -0700 (PDT)
Message-ID: <2dc73982-a162-415e-92a3-48bd0cb018ce@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 10:31:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: luoyonggang@gmail.com, qemu-devel@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <asT-GoQ6xH4-dLET@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <asT-GoQ6xH4-dLET@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2OSBTYWx0ZWRfX8fgn165+gjzG
 S8yqfNoeB9lwB+CqVwV41YsX+WsjrX5HaRE67tlQ2d1QM9gv9qLHE7K4kTXKZXR7w7Tuc85RMFT
 cnCw2Ct4tztmRw7VcchhzOLEvvGmY0M=
X-Authority-Analysis: v=2.4 cv=Ho/jiETS c=1 sm=1 tr=0 ts=6ac53086 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=tpycsQwXMIYJ9kwHvnUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2OSBTYWx0ZWRfXyUzBzCKABGTh
 5VZ558swPaN4UmRjlZMl8EO1yC3vZ4dEZUjZd/mPyqbz2xIpI0tgsMvYsRLd0Ei0lJ4OA8O2TnS
 fSiicvdY0a0tRsqn8oVXmoSgL6rDnsu7JdkRDueQDBrihwtX9ibT0LKQENReOgoGOaBGwB8codS
 y+CRqqzD9tv2i1NsCKbyss5S0QhPvsOTcZRNaEidbvB9dWlFd37IJdPJVqoThlIfVdl77Z9Z/wR
 D2hB6PWs7uNuq0+G64FhunV/nM+9Mu4FwSLzxaBXjzcA4r0pD7lFqlB/FdaYHsNWLL0R6ouyPP9
 LfD6FDMrgW+/tWaMfJ1y/U+HRqyfkOF+jc9T9qjIFcFN/8fV6068XNIdVZlzLBX7aeBxd8N5rht
 voKreY13hrLVn1SzmdzZjwsUMR3pW1sWE5tmb6guI89rWnQWzAurFM7Yax6f3cYFg4NS9zPzWa2
 frk34056r9yYwgIn9qg==
X-Proofpoint-ORIG-GUID: _13aqSMsib3mJu8lTT1wToyatZKJHpDI
X-Proofpoint-GUID: _13aqSMsib3mJu8lTT1wToyatZKJHpDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060069
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

On 10/6/2026 6:56 AM, Daniel P. Berrangé wrote:
> On Mon, Oct 05, 2026 at 11:52:48AM -0700, Pierrick Bouvier wrote:
>> On 10/5/2026 11:45 AM, Yonggang Luo wrote:
>>> On Tue, Oct 6, 2026 at 2:06 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
>>>>> On Tue, Oct 6, 2026 at 12:25 AM Pierrick Bouvier
>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>>
>>>>>>>> Ok, but I'm not sure it answers the why.
>>>>>>>> Could you explain the benefits?
>>>>>>>
>>>>>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binary because
>>>>>>> The following original code would return -1 for some user-binary
>>>>>>> +    SysEmuTarget arch = target_info()->target_arch;
>>>>>>> +
>>>>>>> +    if (arch == SYS_EMU_TARGET__MAX) {
>>>>>>> +        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
>>>>>>> +                               &error_abort);
>>>>>>> +    }
>>>>>>> +    return arch;
>>>>>>> So basically assigning any value for the user binary is valid.
>>>>>>> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTarget.
>>>>>>> -1 is another option but easy to confuse.
>>>>>>>
>>>>>>>
>>>>>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
>>>>>>> "target-info: Statically initialize target_arch"
>>>>>>> doing that, I am not sure.
>>>>>>>
>>>>>>
>>>>>> I guess there is a (good or bad) reason for which sub variants of
>>>>>> targets are not reflected in SYS_EMU_TARGET enum. We should double check
>>>>>> that before doing any change, as it might have other consequences.
>>>>>
>>>>>
>>>>> You’re right to ask, and I need to correct my earlier suggestion:
>>>>> leaving user-mode target_arch
>>>>>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by ARM
>>>>> code shared with user-mode builds,
>>>>> including cpu-max-v8.c, where its result indexes a two-entry array.
>>>>> For aarch64-linux-user, the sentinel could therefore cause an
>>>>> out-of-bounds access during type registration.
>>>>>
>>>>> I checked the distinction: softmmu needs the full system-target
>>>>> identity, including variants such as mipsel;
>>>>> user-mode variants such as aarch64_be use their base TARGET_ARCH
>>>>> (aarch64) for this enum. I’ll keep the full TARGET_SYS_EMU
>>>>>  value for softmmu and use TARGET_ARCH for user-mode builds, rather
>>>>> than leave the field at SYS_EMU_TARGET__MAX.
>>>>>
>>>>
>>>> That's technical details, but not an answer to the initial question of
>>>> why we need to change anything for user binaries, compared to what exists.
>>>
>>> The first two patches revert the current static initialization so the
>>> token can be replaced. They are not a user-mode behavior change.
>>>
>>> Compared with current QEMU, user-mode still uses TARGET_ARCH.
>>> qemu-mipsel already reports mips, and it still will. Names such as
>>> aarch64_be are not SysEmuTarget values, so user-mode cannot use the
>>> full target name for this field; keeping TARGET_ARCH preserves today's
>>> value and avoids the runtime parse.
>>>
>>
>> Why should we need to expose this precise information?
>> So far, if those targets were not exposed (and aliased to 32/64 bit
>> variant), it's probably we didn't need it.
> 
> Current git master is exhibiting a regression compared to previous
> releases.
> 
> For example on 10.1.0:
> 
> $ for i in /usr/bin/qemu-system-* ; do echo -n "$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ; done
> /usr/bin/qemu-system-aarch64: "aarch64"
> /usr/bin/qemu-system-alpha: "alpha"
> /usr/bin/qemu-system-arm: "arm"
> /usr/bin/qemu-system-avr: "avr"
> /usr/bin/qemu-system-hppa: "hppa"
> /usr/bin/qemu-system-i386: "i386"
> /usr/bin/qemu-system-loongarch64: "loongarch64"
> /usr/bin/qemu-system-m68k: "m68k"
> /usr/bin/qemu-system-microblaze: "microblaze"
> /usr/bin/qemu-system-microblazeel: "microblazeel"
> /usr/bin/qemu-system-mips: "mips"
> /usr/bin/qemu-system-mips64: "mips64"
> /usr/bin/qemu-system-mips64el: "mips64el"
> /usr/bin/qemu-system-mipsel: "mipsel"
> /usr/bin/qemu-system-or1k: "or1k"
> /usr/bin/qemu-system-ppc: "ppc"
> /usr/bin/qemu-system-ppc64: "ppc64"
> /usr/bin/qemu-system-riscv32: "riscv32"
> /usr/bin/qemu-system-riscv64: "riscv64"
> /usr/bin/qemu-system-rx: "rx"
> /usr/bin/qemu-system-s390x: "s390x"
> /usr/bin/qemu-system-sh4: "sh4"
> /usr/bin/qemu-system-sh4eb: "sh4eb"
> /usr/bin/qemu-system-sparc: "sparc"
> /usr/bin/qemu-system-sparc64: "sparc64"
> /usr/bin/qemu-system-tricore: "tricore"
> /usr/bin/qemu-system-x86_64: "x86_64"
> /usr/bin/qemu-system-xtensa: "xtensa"
> /usr/bin/qemu-system-xtensaeb: "xtensaeb"
> 
> 
> but on git master:
> 
> $ for i in $(find ./build -type f -name 'qemu-system-*') ; do echo -n "$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ; done
> ./build/qemu-system-hexagon: "hexagon"
> ./build/qemu-system-x86_64: "x86_64"
> ./build/qemu-system-s390x: "s390x"
> ./build/qemu-system-m68k: "m68k"
> ./build/qemu-system-xtensa: "xtensa"
> ./build/qemu-system-xtensaeb: "xtensa"
> ./build/qemu-system-rx: "rx"
> ./build/qemu-system-loongarch64: "loongarch64"
> ./build/qemu-system-riscv32: "riscv32"
> ./build/qemu-system-hppa: "hppa"
> ./build/qemu-system-ppc64: "ppc64"
> ./build/qemu-system-microblaze: "microblaze"
> ./build/qemu-system-sparc: "sparc"
> ./build/qemu-system-riscv64: "riscv64"
> ./build/qemu-system-i386: "i386"
> ./build/qemu-system-mipsel: "mips"
> ./build/qemu-system-sh4: "sh4"
> ./build/qemu-system-mips64el: "mips64"
> ./build/qemu-system-mips64: "mips64"
> ./build/qemu-system-sparc64: "sparc64"
> ./build/qemu-system-arm: "arm"
> ./build/qemu-system-tricore: "tricore"
> ./build/qemu-system-mips: "mips"
> ./build/qemu-system-or1k: "or1k"
> ./build/qemu-system-sh4eb: "sh4"
> ./build/qemu-system-aarch64: "aarch64"
> ./build/qemu-system-ppc: "ppc"
> ./build/qemu-system-avr: "avr"
> ./build/qemu-system-alpha: "alpha"
> 
> 
> so we need to fix that behaviour change for query-target.
> 
> If we want to be able to expose only the "base" target,
> then query-target's  QemuTargetInfo struct could be
> extended with a 2nd field that presents the base.
> 
> 
> With regards,
> Daniel

Thanks for finding this Daniel.
SYS_EMU_TARGET already has the correct variants, the regression was to
use TARGET_ARCH instead of TARGET_NAME in target-info-stub.c.

I think Richard used this one just because TARGET_NAME is a string, so
it can't be concatenated with C preprocessor.

I'll fix that part.

Regards,
Pierrick


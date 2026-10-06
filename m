Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CB4CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMvK-0002Nl-Gn; Wed, 07 Oct 2026 04:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEHSs-0004C3-IF
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:33:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEHSY-0000wM-DT
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:32:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696HetNh1499677
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 18:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p6rdK3oNag6tqRp/EmofF/7N3hmV/kNcLXQryikaLiA=; b=QwjbxToIpMezkKk7
 nmZiloztR6JfH3Bd3pctAwThus83n7421Pk810+MVan+aPJyXV2cTtzBtvYVLIGx
 ISAj5NMYphrS6TuGUydYl0SmhwCkM96DGR9NRFCZ31uUS4L8yCKJrvsb5Sc2EN1N
 8cPfVfVm9ALMwlV1MbeY9z2RMrX3FRCijLSBIUpLnALmcfxCk6Md1dNTdMAOQlj+
 hLSOhwRWy7f4yRLqR/y0ctyF2etgPIMAiBSfaDlQjrPKSemZy2E+JaC3KQAUx4eb
 1TEmbAwTF5iGr62s/YIXBrlP+3Q97ED2fiaCW+xKYrL1IH/9QZSNb/B62AgmrhQ1
 JHFb4A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9t5r3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:30:05 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1493b09d6bbso1335198c88.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791311404; x=1791916204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p6rdK3oNag6tqRp/EmofF/7N3hmV/kNcLXQryikaLiA=;
 b=WT7EayfF2htk74pmdRmisQW3lM7EjYJqhaO/XcN8172eZbOVftX5pMyj7hG/1AMGN3
 +ubEgE0K+IFUU7HgzBgGN94I+rturUfCw4vMlSGhmeXBvJrpWhUSJ1Wza9+5xmn6GgBb
 SIy7QZyn+vXaqCo9mdbJAGsp2n6LbZh2AHpAIzGWysstjVPAHBzE2GmytGlVM1Lp6yoZ
 Sg0bkPPDx7Cg36jKWPVpp3P1rF6+Wz52xUa2i5AdpqS46OBEJGWg4JIFzCpd6KcV1aHE
 aNpAxrlG5fGo2rfOHRHxitrrANBtioCvWlBWIS3SW9ZkkWpsQ6tg4jUmIG8etpEIsXu/
 CFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791311404; x=1791916204;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p6rdK3oNag6tqRp/EmofF/7N3hmV/kNcLXQryikaLiA=;
 b=m+ohnLLi/yDolDOz0MLBgOukMM2samDXZx9pZp6VnVq64BIqYgMVP5BLm6Q47//qjy
 WJ9HzLaCHVyWr4kgX5aDnZb2p/6b2t5IvGfmVcRLoKcawlgC+AxpLXY/AzOrFolDATEO
 NDObLU50PQKTTItEJOtXdp6Az2HtL7ZErzVYJPhR/mNf5iQtTpOxXa/hgqck7PbDp3Ix
 1Q7GZmh0GYXE7MyTnNWVctYlFq/aSqdlCTZvxPXgPs156GoFmxBVlQVJtfGgXfuPTH7E
 pRiVrPP/H38cZdHgSA5DwEibsLhKjklrmO79kFY1rpoWlPHlwhPFaQhw8sUpaW7qgQQ3
 3OiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzV46gJmsTBKrL+LFdryJdj9tAGZeJUr5ptNLNTbluRK+HBj1TUQEGmKyd1YxXAQUlM4tnecaMDy9YA@nongnu.org
X-Gm-Message-State: AFuF++mh2wZgqO/y4GVOny/6riof7FrS+qlVqCnsNCsPOSKRaR9N5ESK
 OxZ4zXBCgQlRZ1Cs07ID3bUGZlxW8Trcv1jq9DHXgqGlIaJlpekExdcRhrGw9qT1n+RLxosJQeM
 f7PXq1k1kcVx1AiRNZ1tGyk89ZyfCxIPwUBE81pI8YEWaR9NLiJK6qr/MlA==
X-Gm-Gg: AYBFou1Up1YBMJ14kkqLVGwNeuxO12aeIyd25SIlFhKXMj60PxaiGDIbmevopWBit8C
 kdvkrvIm9vvEFlWZ7HpJbsMinHT2L6BDMmgiexzfnPlwdhMhtONolRA6ftzdzuy5uPFGieXFCbe
 SfCJOXRSg39dlMCRodZQ/+4GwYlMBX4Ifa1cQVmmbaj1QzNDG1mqjIPqgo4XH8NwtOjT1xUGyeM
 cZ6BTBud76haOiW5ex/1Qp7BG41SSEPLaUqs/2lza/e69U3QfXL+YBrN6CpMGElsaBEEE5P9Ssh
 HvnEtYEM/OmsQlvBDQglaRMJiGgTI/bviYIJfB6xjkgH6tMYijEK54ewDaGB28OAt5wIvj8ItRz
 15knxvxUI8EGxen9+trU4eA+YvlXlGuNAvBpAU6XSGanCWIrecO6I2PQdlybVJieUKQJ2PQ==
X-Received: by 2002:a05:701b:281b:b0:14f:78be:9d07 with SMTP id
 a92af1059eb24-15ec911a927mr2190334c88.35.1791311403797; 
 Tue, 06 Oct 2026 11:30:03 -0700 (PDT)
X-Received: by 2002:a05:701b:281b:b0:14f:78be:9d07 with SMTP id
 a92af1059eb24-15ec911a927mr2190310c88.35.1791311402824; 
 Tue, 06 Oct 2026 11:30:02 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515afee963sm332991eec.24.2026.10.06.11.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 11:30:02 -0700 (PDT)
Message-ID: <c51c23de-fe63-44bb-b8da-611e4ac27cb5@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 11:30:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
 <2dc73982-a162-415e-92a3-48bd0cb018ce@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2dc73982-a162-415e-92a3-48bd0cb018ce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac53e2d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=a7_7i4KdvYFoX_wXuEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MyBTYWx0ZWRfXzYpKgn9SGltj
 9Kz3Fcp6GHXLUe9N/K622rJkEUUKZOTdIKxI+vEk8Y9LMiQjSd5Fc4D46GNSld9FwCA5l7G3F1d
 H1A8nS879cCeynETbBlyLD//WdutVj8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MyBTYWx0ZWRfX3z1K90leS7Xx
 IIWDCVAE069MBZMJN+CBQSDHQ58CdbGEkbw5x1fGPc6Dji5DYKZT74UyUQ6poZdYvMvsKRAu7Am
 N+q/HJOk3kBaYzQ0ALzVkGwinGkjMJLc6ZWey+l0Yc7zXFH9UleFh+yWA83H4BxBSQwkofzpowP
 QJ4SWrqPvvQewMV7GVNq8AJJ5TeApWCY9z4zGswB8RXMwiiHtRfBErFQSIBvLGZlw8teiTvcbxn
 +yOC09BT71rNl7DRVuzH4DA+iO+8uO/27YslkLlupi7zJawt4NJyxMGEpsLQSK36J9U2Po79eaK
 4Q+Uv6+SoloZXqH43yM2HODjRIZ2AJuvwnnM0K2sTcEMQk7q9B23Y3HX7kAPD8EvcsI6TJq4XTu
 iGdxdYOrC05UVZcx5wwaD6dUUKYZiq/oZrGyYUY/JuuvDiT9kh7Z2JEhUosWllK7gjORb6bQN8+
 U1I9mBC6p6TzL5A16fw==
X-Proofpoint-ORIG-GUID: VUbsJ5J_jmiE0eXEYF8YWU9KqJ-k1jvL
X-Proofpoint-GUID: VUbsJ5J_jmiE0eXEYF8YWU9KqJ-k1jvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060073
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

On 10/6/2026 10:31 AM, Pierrick Bouvier wrote:
> On 10/6/2026 6:56 AM, Daniel P. Berrangé wrote:
>> On Mon, Oct 05, 2026 at 11:52:48AM -0700, Pierrick Bouvier wrote:
>>> On 10/5/2026 11:45 AM, Yonggang Luo wrote:
>>>> On Tue, Oct 6, 2026 at 2:06 AM Pierrick Bouvier
>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>
>>>>> On 10/5/2026 10:04 AM, Yonggang Luo wrote:
>>>>>> On Tue, Oct 6, 2026 at 12:25 AM Pierrick Bouvier
>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>>>
>>>>>>>>> Ok, but I'm not sure it answers the why.
>>>>>>>>> Could you explain the benefits?
>>>>>>>>
>>>>>>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binary because
>>>>>>>> The following original code would return -1 for some user-binary
>>>>>>>> +    SysEmuTarget arch = target_info()->target_arch;
>>>>>>>> +
>>>>>>>> +    if (arch == SYS_EMU_TARGET__MAX) {
>>>>>>>> +        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
>>>>>>>> +                               &error_abort);
>>>>>>>> +    }
>>>>>>>> +    return arch;
>>>>>>>> So basically assigning any value for the user binary is valid.
>>>>>>>> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTarget.
>>>>>>>> -1 is another option but easy to confuse.
>>>>>>>>
>>>>>>>>
>>>>>>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
>>>>>>>> "target-info: Statically initialize target_arch"
>>>>>>>> doing that, I am not sure.
>>>>>>>>
>>>>>>>
>>>>>>> I guess there is a (good or bad) reason for which sub variants of
>>>>>>> targets are not reflected in SYS_EMU_TARGET enum. We should double check
>>>>>>> that before doing any change, as it might have other consequences.
>>>>>>
>>>>>>
>>>>>> You’re right to ask, and I need to correct my earlier suggestion:
>>>>>> leaving user-mode target_arch
>>>>>>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by ARM
>>>>>> code shared with user-mode builds,
>>>>>> including cpu-max-v8.c, where its result indexes a two-entry array.
>>>>>> For aarch64-linux-user, the sentinel could therefore cause an
>>>>>> out-of-bounds access during type registration.
>>>>>>
>>>>>> I checked the distinction: softmmu needs the full system-target
>>>>>> identity, including variants such as mipsel;
>>>>>> user-mode variants such as aarch64_be use their base TARGET_ARCH
>>>>>> (aarch64) for this enum. I’ll keep the full TARGET_SYS_EMU
>>>>>>  value for softmmu and use TARGET_ARCH for user-mode builds, rather
>>>>>> than leave the field at SYS_EMU_TARGET__MAX.
>>>>>>
>>>>>
>>>>> That's technical details, but not an answer to the initial question of
>>>>> why we need to change anything for user binaries, compared to what exists.
>>>>
>>>> The first two patches revert the current static initialization so the
>>>> token can be replaced. They are not a user-mode behavior change.
>>>>
>>>> Compared with current QEMU, user-mode still uses TARGET_ARCH.
>>>> qemu-mipsel already reports mips, and it still will. Names such as
>>>> aarch64_be are not SysEmuTarget values, so user-mode cannot use the
>>>> full target name for this field; keeping TARGET_ARCH preserves today's
>>>> value and avoids the runtime parse.
>>>>
>>>
>>> Why should we need to expose this precise information?
>>> So far, if those targets were not exposed (and aliased to 32/64 bit
>>> variant), it's probably we didn't need it.
>>
>> Current git master is exhibiting a regression compared to previous
>> releases.
>>
>> For example on 10.1.0:
>>
>> $ for i in /usr/bin/qemu-system-* ; do echo -n "$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ; done
>> /usr/bin/qemu-system-aarch64: "aarch64"
>> /usr/bin/qemu-system-alpha: "alpha"
>> /usr/bin/qemu-system-arm: "arm"
>> /usr/bin/qemu-system-avr: "avr"
>> /usr/bin/qemu-system-hppa: "hppa"
>> /usr/bin/qemu-system-i386: "i386"
>> /usr/bin/qemu-system-loongarch64: "loongarch64"
>> /usr/bin/qemu-system-m68k: "m68k"
>> /usr/bin/qemu-system-microblaze: "microblaze"
>> /usr/bin/qemu-system-microblazeel: "microblazeel"
>> /usr/bin/qemu-system-mips: "mips"
>> /usr/bin/qemu-system-mips64: "mips64"
>> /usr/bin/qemu-system-mips64el: "mips64el"
>> /usr/bin/qemu-system-mipsel: "mipsel"
>> /usr/bin/qemu-system-or1k: "or1k"
>> /usr/bin/qemu-system-ppc: "ppc"
>> /usr/bin/qemu-system-ppc64: "ppc64"
>> /usr/bin/qemu-system-riscv32: "riscv32"
>> /usr/bin/qemu-system-riscv64: "riscv64"
>> /usr/bin/qemu-system-rx: "rx"
>> /usr/bin/qemu-system-s390x: "s390x"
>> /usr/bin/qemu-system-sh4: "sh4"
>> /usr/bin/qemu-system-sh4eb: "sh4eb"
>> /usr/bin/qemu-system-sparc: "sparc"
>> /usr/bin/qemu-system-sparc64: "sparc64"
>> /usr/bin/qemu-system-tricore: "tricore"
>> /usr/bin/qemu-system-x86_64: "x86_64"
>> /usr/bin/qemu-system-xtensa: "xtensa"
>> /usr/bin/qemu-system-xtensaeb: "xtensaeb"
>>
>>
>> but on git master:
>>
>> $ for i in $(find ./build -type f -name 'qemu-system-*') ; do echo -n "$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ; done
>> ./build/qemu-system-hexagon: "hexagon"
>> ./build/qemu-system-x86_64: "x86_64"
>> ./build/qemu-system-s390x: "s390x"
>> ./build/qemu-system-m68k: "m68k"
>> ./build/qemu-system-xtensa: "xtensa"
>> ./build/qemu-system-xtensaeb: "xtensa"
>> ./build/qemu-system-rx: "rx"
>> ./build/qemu-system-loongarch64: "loongarch64"
>> ./build/qemu-system-riscv32: "riscv32"
>> ./build/qemu-system-hppa: "hppa"
>> ./build/qemu-system-ppc64: "ppc64"
>> ./build/qemu-system-microblaze: "microblaze"
>> ./build/qemu-system-sparc: "sparc"
>> ./build/qemu-system-riscv64: "riscv64"
>> ./build/qemu-system-i386: "i386"
>> ./build/qemu-system-mipsel: "mips"
>> ./build/qemu-system-sh4: "sh4"
>> ./build/qemu-system-mips64el: "mips64"
>> ./build/qemu-system-mips64: "mips64"
>> ./build/qemu-system-sparc64: "sparc64"
>> ./build/qemu-system-arm: "arm"
>> ./build/qemu-system-tricore: "tricore"
>> ./build/qemu-system-mips: "mips"
>> ./build/qemu-system-or1k: "or1k"
>> ./build/qemu-system-sh4eb: "sh4"
>> ./build/qemu-system-aarch64: "aarch64"
>> ./build/qemu-system-ppc: "ppc"
>> ./build/qemu-system-avr: "avr"
>> ./build/qemu-system-alpha: "alpha"
>>
>>
>> so we need to fix that behaviour change for query-target.
>>
>> If we want to be able to expose only the "base" target,
>> then query-target's  QemuTargetInfo struct could be
>> extended with a 2nd field that presents the base.
>>
>>
>> With regards,
>> Daniel
> 
> Thanks for finding this Daniel.
> SYS_EMU_TARGET already has the correct variants, the regression was to
> use TARGET_ARCH instead of TARGET_NAME in target-info-stub.c.
> 
> I think Richard used this one just because TARGET_NAME is a string, so
> it can't be concatenated with C preprocessor.
> 
> I'll fix that part.
>

Please take a look to the following series that solves this regression,
and also allows to detect endianness variants through target_arch():

20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com
"[PATCH 0/2] target-info: expose full target variant"

Regards,
Pierrick


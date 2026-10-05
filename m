Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E85ECA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDo9i-0002Gy-0p; Mon, 05 Oct 2026 15:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDo9U-0002C6-Hy
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:15:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDo9S-0007Pw-Fp
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 15:15:08 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HKn211583248
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 19:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ndOP4Hdl9NhFDj9tZFWfKTsNOUm2oTeZ4YinVTSYhyY=; b=Fkp2kD5kIXuUCcU5
 EEFjmzoR40IUE+Fm2XKCm6KhAvKHk/cbYY4jqo4C2Cxg2YPC3sP1JiSPlm8u5ZXN
 uzDQRX3nM6M2c28JP35sqHL5zlPDM5DSKvhc4fJpoOUWc6rmdpb2knbk1nFG91Hc
 GCE/ZOkym4m+oB9R+exrW/aeLsHezGRhgR8L6MTwM6Zv2ZQTRDAUrtV2aX6rVm0d
 ANPMTHsbcsk9e7EEAR5ltESQV8B3siljG3Dv8VObjqNDVto9GXXGmAOIlSF1PcKo
 fnymtEY5TYv2YiyCYzh+uuP9RzAPv/6y7Hr3we6KuXDN9Uq5pByuseEq++U81omA
 F7R/fA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4fkugkdh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 19:15:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34d84114044so8873514eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791227703; x=1791832503; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ndOP4Hdl9NhFDj9tZFWfKTsNOUm2oTeZ4YinVTSYhyY=;
 b=X06l6CsO1P6TlzdWzk7ZoNzRPWE1E70/MVL5RRv/OQQEZK92dNlwf2n5XEP/ebKjhK
 mTWFjedWuN2OJjaX+mv9w53LGXRedFzMg13Z0eKSgO00NQI5a3rzgXTXExKxn1pXS+BV
 UrKaa9WofVEHpuiPldyKUtOqF5jGIkJKTMMybv6Qr47BZsab0CSLjsYZVwvA/sKkQMy/
 Utp+OCRToo4967lp7/Bfb18sSKe0/pEc2iPirKk5QBFjmpzGtmZh+W85U6sXEEE1ajSp
 cCnLN+E/bnjzDrfndSmM+bBKFQ6k8Iv7nrl+u9ft//fIPfLbUVt7VThkNxVfFNNg5KpM
 3aYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791227703; x=1791832503;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ndOP4Hdl9NhFDj9tZFWfKTsNOUm2oTeZ4YinVTSYhyY=;
 b=Pe3pw9mgmAFdRBtBLSM2BQJ4dzgcxV35Vyeg85NKBGg9OTalciXMO0NWvCut+BUWQK
 GXuhGSZjFaQv1b2UohqXuVBd0/UL92bHTJFb1bYUsDyeKxrAhm2wWidZ6gsy5nUl5Yu5
 Xc2O4zea7osQB0Xcg0Ff581lI/Le0WkoSWvbcCRV5am00Yqb/YC1awMKcfB38gNpX+U4
 u8tIN9VB01s3nEhiWZe7zKc8tMXMQreCBnFbJwtILNYkBDFjdnI0UuSz74MIWoHYVZ1q
 0C94x3n528STICr8OESACIbQPBs7Ln1y3qXJk7Ozk029Zq9RqSGDZCz2M9tC8s0lhG6i
 xQ1Q==
X-Gm-Message-State: AFuF++noZwb4Ywdxq1DiUs0lYo2jr5Vfv1/JCaeiWKhfM9qpfI0W8js5
 KS7YTH2amMbzwKPA+SpkM4Bfysx9oDHm/0VUJe1EEXRtnfsVJ1ChRirQ9Ex6aWRh9D/Wg9aSwY/
 kSqLmCfccgrxvw37ooQ8d7cBP0Kc0DlHLdx7/CMXa/9KJcqqIvtej6NdvjQ==
X-Gm-Gg: AYBFou2dQ/gNCEvJDZQTTPzoITQs8zOWM1yTDFBTjGspFNDqG2+5sMAjnB0GZ6ann2A
 J1m6JDFGSTPVBFNUIfH3ddr6uOWwpkIHyIJ3sRXyzAX7wuKnCYMJDpVBymWE4IICXkvMMpRgdWj
 nGyh+SV7z20IohWmUbUxF50XEiihB7ZqZGkQwjCI/09GGI/mbdzSqmEqSE4FN/ON/jAaE4ElkN+
 ab2j2XnA+2COd4T3lSWw8pyj9xOk7SVLVotNCwx4k4OQeuzuCj2FDgRrnbXxli0MHHTMHr3yFmU
 Z8YkaTP2sHxW8up3rHzqLPOw+gAEDCemosAYYYVRk2J4ZAIUOghJT2mN9RLMZHXOEWeVr+YOoxD
 w/pm2+tIyRWfG6gO7skauzmj8gLzsicyOEAfdseAcTopMu93KzrnqLTB2u6haFIU74zwWUw==
X-Received: by 2002:a05:693c:87c1:20b0:351:3f6c:20e1 with SMTP id
 5a478bee46e88-3513f6c228emr1637799eec.35.1791227703369; 
 Mon, 05 Oct 2026 12:15:03 -0700 (PDT)
X-Received: by 2002:a05:693c:87c1:20b0:351:3f6c:20e1 with SMTP id
 5a478bee46e88-3513f6c228emr1637756eec.35.1791227702735; 
 Mon, 05 Oct 2026 12:15:02 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35146b16846sm659644eec.28.2026.10.05.12.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 12:15:02 -0700 (PDT)
Message-ID: <b361fbd9-7dce-4364-bc3b-bb98fed52bb4@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 12:15:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
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
 <CAE2XoE-89zTC4wPnyi_ZUu_dcVuLmwr4uyp-txkxEYQ29Y8uvw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-89zTC4wPnyi_ZUu_dcVuLmwr4uyp-txkxEYQ29Y8uvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6ac3f738 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=r7acrQG4xVPWFpTVu6IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: jR28bFtXNlYXGROHfZg5X-FCNEIsVcEQ
X-Proofpoint-ORIG-GUID: jR28bFtXNlYXGROHfZg5X-FCNEIsVcEQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NSBTYWx0ZWRfX02OXrxxK8TOq
 2DGXFvvxvlHc3V3CTjprHgRXDM7YVDa93jkDmLDxwCbgIwTjsRETRh4yHSQ9yPIModSZbWrnZAs
 XZH5OK9x+05pjPcGEFvp1P+EYIW9tpI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NSBTYWx0ZWRfX31QZq7Ux/aHP
 sqU6MDZ7fcjMyA5M+Qzf4EVFXeZHaor777dTIQMbEIkdtGVuQ9i3j9euTTK1BLX28j/r7KMR/Rj
 Tnj5W2yuEEaD4I+gNlW1nDIG65r58KkMNbeAirqLTZ6YdjBbHQlv2L1//WH6zfwmbnADCYJVDfv
 Cq+JHD3bl5MD8iecDRFm64G/hW/rfXMQH48onDxrzPWsJZBrkFPsl2rZXow2BZIFwFeBB4DyCSu
 fbRTvcWe7v10lO4KO9ltdGSB3npdpqMrCs4/vsUdasU4JQwGIlqn26XUsmg2sC3Qn5kQfC4lowz
 3arHspRh7M2HJnZcoj9B0ORnEU16QoVzWQbfNe8xv8TOrKkL9j8LDIi/J2+OBOuhTVb5jfGxBjT
 GQTA/MIEcyafacxzvQuanDiolVDEQIG61iPYQ+O3VxxR0PgdWoCY+FYx8cgi4zKmxG8XMAPdHwn
 RoJSoSAg5jfHSxfO67A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050075
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

On 10/5/2026 12:06 PM, Yonggang Luo wrote:
> On Tue, Oct 6, 2026 at 2:52 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
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
> because for different SysEmuTarget, the machine list is different.
> return a wrong SysEmuTarget would cause a mismatch between SysEmuTarget
> and the machine list. for example:
> 
> static const char * const mips_machines[] = {
>     "malta",
>     "none",
> };
> 
> static const char * const mips64_machines[] = {
>     "magnum",
>     "malta",
>     "none",
>     "pica61",
> };
> 
> static const char * const mips64el_machines[] = {
>     "boston",
>     "fuloong2e",
>     "loongson3-virt",
>     "magnum",
>     "malta",
>     "none",
>     "pica61",
> };
> 
> static const char * const mipsel_machines[] = {
>     "malta",
>     "none",
> };
> 
>

I see, in this case, I would invite you to first work on how to declare
for which target a machine is available, as discussed with Daniel on a
previous thread.

What comes out of this will give the answer about how to deal with sub
variants.

If it's a callback, it should be easy to use:
is_available_mips64el() {
  target_mips64() && target_big_endian()
}

If it's a static list of SYS_EMU_TARGET, then the easiest path will
probably be to extend list of targets in this enum.

In all cases, that's the first thing to work on before any other step.

Regards,
Pierrick


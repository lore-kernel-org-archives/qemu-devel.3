Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EE7CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESfH-0003Ic-JW; Wed, 07 Oct 2026 10:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESdv-0002z8-4b
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:29:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESdo-0000UU-HY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:29:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BV612640844
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 14:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PlfX/xkb6ugfI70yDAyDlTG/TB55Gd3ja4v45pIs5bM=; b=gjnh8FcHeWqKcewF
 Pf4wnyhMzmh/KtAY6Q71AV+vsvDeIalZjzz3B2NxCV0iqxtcgxYGevcJ9pkuhNPb
 GAomPU76BK/5JqSEqxtSBtGgRby3QXDiG2K5ORkdR253hTx5q8UdHJKDYzalR9LD
 tyu3r9ZOWbzVnOn3utlA9cq6fIAJoVJWCzflpnacWYmJBJlFcaUrEszBGb3TMApM
 REm5BF70sNa5gMtbXL1sWytG65saL8s7cMbmq94s2tjNbW93cGoJhBSkWiZ17i8+
 usbsNaDmgVxtL/bVev5F4LYmCKNzrJEEx0bX2h5lexvgaVuTpyT8SFFqFYlhIOLc
 tGvlHw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c71b2kv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 14:29:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so9008861eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791383344; x=1791988144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PlfX/xkb6ugfI70yDAyDlTG/TB55Gd3ja4v45pIs5bM=;
 b=WPsRPzEbEvcMAs5gY2pd/9njlfUDMzl0pSEn9+hDtWv9VG/ENg2rc2CN6hDzxYyFhT
 3olqs76M8CiN3dmvTCVJbkt9+drY5+HtDJ4HPnePMBLU4K+eyNGlw1rAvi60sh+NBnNN
 WbBMZ5joVymEctB58fPye/u6uDu5ZKLj+Y3m0yavfJe8kOaro8/B2WXzJvntrH17G9tW
 +g8pH9FidIi+zkhujrRIbDncxITNJxeXscVjNTKNl/U27BUsZj10PPeP96YjkBKgcO+d
 BM0p+8lfGbOkiSvz5ywI4VmlO7vFK4L+luR3l5VrwKN4qpXTWZWOv42dipmb+GDXJIw4
 MkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791383344; x=1791988144;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PlfX/xkb6ugfI70yDAyDlTG/TB55Gd3ja4v45pIs5bM=;
 b=E5zAUDhs2kRn2/0r6gL+UyZyASzbiNhYY1Hx/5+6stL3YFYhMv6IVBztTiQykF2uTD
 TDjKSDHHZQ9x9c6vuqNcAOsiJK3kw9l74AOAk/XF92KFfN09/u29sXXet5Irk2zIVzYx
 XxRSU13j3+dRdGEJ11Nd/OyrjXlzBTJhRTfKai6pLyXU8sBf6gs3+tvuNn0h+8fQLASe
 31l82Sv8Raua3GXiI5w77wU/9ARTVj0hOYQEzVf6D0cwrDZjc93+C3Ys6CWFGFLF26Jh
 D9uTmt1u0npdVJeBVSShxMuozJmXW1HJLv7EjLl6hc4xGuSxKkryJoe+grOU6Tn9RjFN
 3kVg==
X-Gm-Message-State: AFq9FYKH/cC2BiT8j2eTm5kECbLmk+XmVJYsA7z9Z15HDaWD6OcsKQfx
 p9ZL+NQ8qKAbroRHxegpvVexLV9xEko9dgkce1vwN2YY9bZ228sjPmpCLuNagu5znKzg6H9w6Wv
 FsPhGiZlf4eeGq0oeQ37NswaeJfnH49OZhHt1CP719KD+XWzMD2y3c8j7Hw==
X-Gm-Gg: AYBFou3uX9g1sm5snS0KZGM4mfNjeFcbalyyKcPJRPir17JR1JC7VPJhRF3MQWhZ2iF
 y9WT0hNSOPZGOc7dtVgbykBgOFkGu+zNgjHQL7XZfi3+n8iDwSSDVyXXgwFPWS7aJ21qvgNzNHV
 E/g4cNxBr4gF7mApygH1BLoW7hXRlbNqk5qCQUnphKcoAfF4pAdCh+7fp7A5LT4uFwMJ4xH20kR
 MuGfx9KkARRXjJ/DUTT+hbhTalsMW8wo42re8fedwUJS9udYs2y4BQnlxGjV3KzTR4JT0gQQWQ+
 g3iNG07PHnuiJGA3rtKDs9GLIXaOTsR721xhnFjcorvJMbUiRS7K9ExKKJwYmtn9QAdiHceeKxi
 uwSVbQw9AOrA8oUzRxKbg0iGPvxuppRqH1+9KSkMj0l0rxWaJ96x6AHI0SCcq4moFxVnLYA==
X-Received: by 2002:a05:7301:fd07:b0:351:2616:6231 with SMTP id
 5a478bee46e88-3515deebc0fmr2337421eec.40.1791383343603; 
 Wed, 07 Oct 2026 07:29:03 -0700 (PDT)
X-Received: by 2002:a05:7301:fd07:b0:351:2616:6231 with SMTP id
 5a478bee46e88-3515deebc0fmr2337328eec.40.1791383341455; 
 Wed, 07 Oct 2026 07:29:01 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515b03da93sm6878717eec.29.2026.10.07.07.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 07:29:00 -0700 (PDT)
Message-ID: <52b6baff-e692-4379-a724-3e9ae968110c@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 07:28:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] meson.build: export TARGET_ARCH_VARIANT in target
 config
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261006182558.151956-1-pierrick.bouvier@oss.qualcomm.com>
 <20261006182558.151956-2-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8mDS9dadJzb_rt9ofj+g7T_-Mn20TRMMia0HOeu2bvkw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8mDS9dadJzb_rt9ofj+g7T_-Mn20TRMMia0HOeu2bvkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NyBTYWx0ZWRfX/xZPCJWBXJge
 su8d2EX9abjm+Li2EXEneDzbgNvlk+P+BKWGpqgBkCdXdWknD2ffMRcF3ZwkoBmHlKcE6SGAmnK
 DBrTJxunOcKqjW0ijcW2b89SG9G5Rsg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NyBTYWx0ZWRfXzS+mHjOZbdMa
 S9sEx5BLWAegG7rqK3FR0EToxPC3EyHHPHbrgv5T3kat51fNZ3wo296182VCinoVAVWAg++xWM3
 mJMwm/osEREfBybRPh785qo9q3llMjYuAztqlEzCfJ66/B8pkvM1w6+UtG+J3qGraWDvfBanVNk
 D7BJSgwPX76vi48ZUVAVrTUTlovqGZgzY5p9tCcTmm45UN0JqowqSG3iyKNUTa7gtHOnUuQ9/Jn
 YzY2Uyfl0kS7BSHcU/CCxZTr2QDmwJl0/WrPmBIcw9egs/4b7moOzYqiWMRJ3AH/7ru9IGq8zSx
 tO2z2mKFZZZiMdLu6kTIZNcxdDiKxTbnU0i+7Xr1NUP4d8ragsQop0CcWg2nikFucV4FaTs/BiC
 IucOFjFQiZ4V0G4v2YIIeG4PNZi+idigJLh03kCig8H3BZlxhKOGMmrcCdRIroUVTM7kvn3fkVF
 b+28bglGWF+WScv+SIA==
X-Proofpoint-GUID: fVMS3f_Admy1K8Y4T4CgXynM_HhmgaQR
X-Proofpoint-ORIG-GUID: fVMS3f_Admy1K8Y4T4CgXynM_HhmgaQR
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac65730 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=S-mbKdkM36BRUBZYnd8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070057
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

On 10/7/2026 12:48 AM, Yonggang Luo wrote:
> On Wed, Oct 7, 2026 at 12:03 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> For now, TARGET_ARCH only contains 32 vs 64 bit arch. The variants,
>> based on endianness, are accessible through TARGET_NAME. However,
>> TARGET_NAME is a string, and thus can't be concatenated to generate code
>> and retrieve matching SYS_EMU_TARGET enum entry.
>> Thus, export this information in TARGET_ARCH_VARIANT as an unquoted
>> identifier.
>>
>> There is one more subtlety, user binaries have extra targets that are
>> not present in SYS_EMU_TARGET, like armeb.
>> Thus, for user binaries, simply export TARGET_ARCH.
> 
> 
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  meson.build | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index cae1591cd28..9bcfe84daba 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3288,7 +3288,14 @@ default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
>>  actual_target_dirs = []
>>  fdt_required = []
>>  foreach target : target_dirs
>> -  config_target = { 'TARGET_NAME': target.split('-')[0] }
>> +  target_name = target.split('-')[0]
>> +  config_target = { 'TARGET_NAME': target_name }
>> +  if target.endswith('linux-user')
>> +    config_target += { 'TARGET_ARCH_VARIANT': 'TARGET_ARCH' }
> 
> If TARGET_ARCH_VARIANT or just called (TARGET_NAME_ENUM) is just a
> direct mapping of target_name regardless linux-user/bsd-user/softmmu,
> the logic would
> be simpler. That would need add more enum to SYS_EMU_TARGET, the
> current form is:
> ##
> # @SysEmuTarget:
> #     The comprehensive enumeration of QEMU system emulation
> #     ("softmmu") targets.  Run "./configure --help" in the project
> #     root directory, and look for the \*-softmmu targets near the
> #     "--target-list" option.  The individual target constants are not
> #     documented here, for the time being.
> #
> # @rx: since 5.0
> #
> # @avr: since 5.1
> #
> # @loongarch64: since 7.1
> #
> # @hexagon: since 11.0
> #
> # .. note:: The resulting QMP strings can be appended to the
> #    "qemu-system-" prefix to produce the corresponding QEMU
> #    executable name.  This is true even for "qemu-system-x86_64".
> #
> # Since: 3.0
> ##
> { 'enum' : 'SysEmuTarget',
>   'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
>              'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
>              'mips64el', 'mipsel', 'or1k', 'ppc',
>              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>              'sh4eb', 'sparc', 'sparc64', 'tricore',
>              'x86_64', 'xtensa', 'xtensaeb' ] }
> 
> 
> The list target names that missing from SysEmuTarget:
> 
> Comparing the target-name prefixes of `configs/targets/*.mak` with the
> `SysEmuTarget` enum in `qapi/machine.json`, the following seven names are
> missing. All are Linux-user-only targets.
> 
> | Target name | Config |
> |---|---|
> | `aarch64_be` | `configs/targets/aarch64_be-linux-user.mak` |
> | `armeb` | `configs/targets/armeb-linux-user.mak` |
> | `microblazeel` | `configs/targets/microblazeel-linux-user.mak` |
> | `mipsn32` | `configs/targets/mipsn32-linux-user.mak` |
> | `mipsn32el` | `configs/targets/mipsn32el-linux-user.mak` |
> | `ppc64le` | `configs/targets/ppc64le-linux-user.mak` |
> | `sparc32plus` | `configs/targets/sparc32plus-linux-user.mak` |
> 
> All `*-softmmu` and `*-bsd-user` target names match enum entries.
> 
> This comparison uses names derived from config filenames, not the
> `TARGET_ARCH` values inside those configs.
> 
> By doing this I think it would be more consistent.
> If these target names are removed in future, then just remove it from
> SysEmuTarget
> along with. So SysEmuTarget is just a direct mapping of TARGET_NAME. Though
> The comment of SysEmuTarget needs updated, it's not just about softmmu, but also
> for linux-user and bsd-user. But the fact is, with the current
> changes. *-user also
> used SysEmuTarget as an enum.
> 
> 
> And TARGET_ARCH should also be exported by TargetInfo for other usage.
> And it's enums is the subset
> of enum SysEmuTarget
>

I tend to agree, but didn't find a real reason to do this change (yet).
Also, I would be in favor to rename SysEmuTarget since in EmuTarget,
since it would now be decoupled from system emulation only.

@Daniel: Would you be favor to see such a change? I know that
introspection/QAPI is related to system emulation, and I'm not
completely sure adding user targets is the right move at this moment.

> 
> 
>> +  else
>> +    config_target += { 'TARGET_ARCH_VARIANT': target_name.to_upper() }
>> +  endif
>> +
>>    if target.endswith('linux-user')
>>      if host_os != 'linux'
>>        if default_targets
>> @@ -3372,7 +3379,7 @@ foreach target : target_dirs
>>        # do nothing
>>      elif ignored.contains(k)
>>        # do nothing
>> -    elif k == 'TARGET_ARCH'
>> +    elif k == 'TARGET_ARCH' or k == 'TARGET_ARCH_VARIANT'
>>        config_target_data.set(k, v.to_upper())
>>      elif k == 'TARGET_BASE_ARCH'
>>        # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
>> --
>> 2.43.0
>>
>>
> 
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo



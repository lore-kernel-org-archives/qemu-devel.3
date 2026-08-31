Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B663CC61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16UM-0005kW-Jf; Mon, 31 Aug 2026 14:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16UK-0005k7-CC
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:12:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16UH-0004yb-Hd
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:12:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VHweNo837228
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rcVM6mju79RYzu5hUn33WQIaEprORi3XpgUvyy44wKY=; b=BN09wODdqN7YPKES
 qEcf4bIKjty24+J3GFxDYglMbb0jpCEJD1tQFPivHKkCI4GkRaq/6EgijZfiv4UI
 fay8z5aOqr69AuEF/Nekgfw1nweO/aUnGjr6PLriIBaKLZywAIvWui7Bza9wBJdm
 Rm75yBmxaNlyjgK5PCgbrg9HKPAXeDAofBGVTqPC+Mwt5vDo3p/HFPhTtzvu7yZK
 upMCcBbj6fC/9Vd+15k9Q2lYDW0ZNisgzmvO3llfI4RFkl53iqW8Pc+k5ZG2KLx/
 XnW+NbqK5LDRIU5PdV5h1rVtihXO5pNQkfzW/4lSPBbFgMKd9mXevVH4heMkqNum
 17LBDw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdeg382ss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:12:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d001671a54so70750185ad.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788199923; x=1788804723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rcVM6mju79RYzu5hUn33WQIaEprORi3XpgUvyy44wKY=;
 b=AWXqVkjIyWcF3GEPWlkON/Rcc4GiPhOnf7qcLRGBpLlzbH5zjN/K1jWQsKo43dhTWP
 aSmzNBwDaCWioyqSFSPcs42Yvy3QRA37MQ9NlD2Sx+cnv5L+bjXF19BmkN3+aoB1fAvu
 0emAy/wbs5MjmCleEIoNI7t6bQf6p4/+1MXqom1MhFDUQaVW1VHu71RBfWG5MEt8nt14
 +ck90dPrLFl7c1RI0axxOOTBQm/YGq5JzO4LtxpxJgYMY3Dx/lVyof6BgHaU1p8eLpQl
 F8VTeaKKoLe97giKwPJoa/h/OJdFu2VISvFxl8f01POdD2ssGy2FSbkpcVkDfl1t/wd0
 v2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788199923; x=1788804723;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rcVM6mju79RYzu5hUn33WQIaEprORi3XpgUvyy44wKY=;
 b=a+B4ma++3svhbpCQ1JxC1rBx3fo+oUXDj7f3MNqwgIAhGRb5sfi21mdSJ+L9tzrM1W
 ZcUwsMVEVBTmFEmnMnhd6MliYA98/jiDoh2c0K4aoY2JwgxGFuzn7spZ4ZLeBwHV4cTt
 LyfwfEbjr91AQpivC5lyyzwY1fvMwwFS+hzEvR0WVdMtRvot39Pm1toprjZdUvU8aOR4
 4KS9IG8/Vk0XoaVM8IaRh6SP9PQiv8VjNBjtTXokDaY7j2pbwE0Pv/H8s/sYAoKVLgEU
 U4nfMuPzIOiUmmn/XahUHftogUFL5mhqd323e0yaigUxQpdh9AAi+dnQ7kRC3Zwg6AYG
 QExg==
X-Gm-Message-State: AFuF++l4hqs5hf1uR3+JNZtPa5sknWACrJygMWt3OJhDcN3p8bvuYH+4
 dT/cglht4axJsE+AIgt9Vxp2UCputLAhvl2J5IDpTukLCfT6PFNvgPJ0Z3McW3mF/Kt8CrGfZ+w
 NOaxhTdM2e/IiJY0aQzYPWfDssTKyPzItkYY3ojOq53tp6pLp+cDJ7s/VZg==
X-Gm-Gg: AYBFou1RPK5GnDqhBvQ8WvoTZj3ti3EMlUCrrpbuZGO0rl1wLeewhREEAN0mjG4oyM4
 tk+baF5rcbhPBD+XBbtO2wKgIamhfe0b6Y7UDN/4bCayhxs9SdZBo7FDdtgtfhEo+AiiYyyT8Jh
 G8SAolrgoIi9HpdAv3j9pyWsRveUDzfbQZsBClzPQaBB/kvn0zOWYE2Bbz3AML2IUk7JpYDS1Hl
 bXAMk2W3283gh7pGy7ycizzxIsDxzTs2aW5zymobr3ux8sqviK6jHa6Lr7AMtmqJwxVbKj3AqfE
 BRD/cDQvXbj1RYkjDSPvxQ4I9Tfoa7qpdUwWB+CxqOoWcZOjTpqOL/INcHkmiIgJjYVIrXyEWf4
 FVCCnFEtyegGNX1DoAPZZe8K/k/MFSUy/FtFFtEAoxY4/gygwl0gipwYum7BqjwWciTrA
X-Received: by 2002:a17:902:f78b:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2d74dc78debmr445807875ad.4.1788199922831; 
 Mon, 31 Aug 2026 11:12:02 -0700 (PDT)
X-Received: by 2002:a17:902:f78b:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2d74dc78debmr445806905ad.4.1788199922227; 
 Mon, 31 Aug 2026 11:12:02 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286fa5517fsm34813568eec.31.2026.08.31.11.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:12:01 -0700 (PDT)
Message-ID: <20b7742c-cc60-4472-83c6-937f86e791cb@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:12:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/47] meson: build single binary for arm+aarch64 targets
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-36-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE9JF6eY08oRJ4qxQTn=u4bQ61vtWN-1Eyi5DpbsChdczw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE9JF6eY08oRJ4qxQTn=u4bQ61vtWN-1Eyi5DpbsChdczw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1NyBTYWx0ZWRfX3eaT7mtHZwZK
 wBAd8lvIvNQyLfP8dGBAHhbDpMA8zHZPrgCInEvw8wZjvR6GAqqeJXJjY/uzEb9TQ7qTCcm9HEz
 Ngs7TpQez+fhHeyI9uOavXA6J62/MmMnb1sWUlP51WVNkjUBLBFwEdejwG4v9t+J3EF1wtxaHpr
 VMQKIZcAZ+jpsMAXH1KSBdxa3k175yeeqsCRnpJFMngcuBu3LGYVVAltEUFLBQc84JeaPEetp8+
 Cf6QlsN7Ttmr4ozt4h0B7KcNh7rek5PBWJE3P6FsVL1HejsXs/Wp2llfmUnznl3YW2ex1+CsODB
 oO14bezTHYCj36XVynT+0iroOhjMadBlq98MBSf52ZrbY9jAd5hycd6rjuuKGIxiXwTp7OFJH4U
 uya1B1bpW1nnsojQVyP5lhlkMKcVt8SR0TxJ4dkvIiX0phpzVbusRA7xstCj1lyNxVvgyXQR2ML
 P9uQUveworOn0ikOzNw==
X-Proofpoint-GUID: zimGY9b0vbivoQj7yLzy9Qcj5aNmh99B
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1NyBTYWx0ZWRfXxENiTCtQ1PXo
 29kaHXoERtHuflThYP4Y0z2Jph2pRhCOlyV8DmN24xxmCMpdwR1QEzaFmrB78+JhdBfREJ/breM
 X6c8E9so3Vuf+A2XdUDzvVqGfxUaS1o=
X-Authority-Analysis: v=2.4 cv=NZnWEWD4 c=1 sm=1 tr=0 ts=6a95c3f3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nhDdoGCR8L6X8qQFZXUA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: zimGY9b0vbivoQj7yLzy9Qcj5aNmh99B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310157
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

On 8/31/2026 8:21 AM, Yonggang Luo wrote:
> 
> 
> On Sat, Aug 29, 2026 at 7:03 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>
>> Build with: ninja -C build qemu-system
>> This is not built by default.
>>
>> All available *-softmmu targets are aggregated, ./configure
>> --target-list can be used to restrict which targets are included.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>>
>> ---
>>  meson.build | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/meson.build b/meson.build
>> index 8023da4a147..9cf441382d3 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -4250,6 +4250,16 @@ if host_os == 'darwin'
>>  endif
>>
>>  traceable = []
>> +single_binary_libs = []
>> +single_binary_deps = []
>> +single_binary_crates = []
>> +single_binary_available = false
>> +
>> +single_binary_supported_targets = [
>> +  'aarch64-softmmu',
>> +  'arm-softmmu',
>> +]
>> +
>>  emulators = {}
>>  foreach target : target_dirs
>>    config_target = config_target_mak[target]
>> @@ -4402,6 +4412,13 @@ foreach target : target_dirs
>>                   build_by_default: false)
>>
>>    if target.endswith('-softmmu')
>> +    if target in single_binary_supported_targets
>> +      single_binary_libs += lib
>> +      single_binary_deps += arch_deps
>> +      single_binary_deps += target_stubs
>> +      single_binary_crates += main_rs
>> +      single_binary_available = true
>> +    endif
>>      execs = [{
>>        'name': 'qemu-system-' + target_name,
>>        'win_subsystem': 'console',
>> @@ -4483,6 +4500,33 @@ foreach target : target_dirs
>>    endforeach
>>  endforeach
>>
>> +single_binary_objects = []
>> +foreach lib: single_binary_libs
>> +  single_binary_objects += lib.extract_all_objects(recursive: true)
>> +endforeach
>> +
>> +single_binary_link_args = emulator_link_args
>> +single_binary_link_args += enable_modules ? ['@block.syms',
> '@qemu.syms'] : []
>> +
>> +if single_binary_available
>> +  executable('qemu-system',
>> +             sources: [single_binary_crates, files('system/main.c')],
>> +             dependencies: single_binary_deps,
>> +             objects: single_binary_objects,
>> +             link_depends: [block_syms, qemu_syms],
>> +             link_args: single_binary_link_args,
>> +             build_by_default: false)
> 
> A. better assign executable to qemu_system. so it can be tested.
> Maybe a simple test is better.

I'm not sure to see what you mean by "assign executable to qemu_system",
can you tell us more?

> B. single_binary_available should be a meson option, maybe
> single_binary_enabled, and disabled by default maybe... don't know which
> is better.
> as it's still experiential
>

We could add an option needed, but since binary is not built by default,
I don't see why it should be enabled optionally.

> The patch to squash is attached.
> 
> 
> 
>> +else
>> +  error_str = f'''qemu-system only support targets:
>> +@single_binary_supported_targets@
>> +
>> +use ./configure --target-list= to choose at least one of them'''
>> +  t = custom_target(command: ['sh', '-c', 'echo "' + error_str + '"
> && exit 1'],
>> +                    output: 'none',
>> +                    build_by_default: false)
>> +  alias_target('qemu-system', t)
>> +endif
>> +
>>  # Other build targets
>>
>>  if get_option('plugins')
>> --
>> 2.43.0
>>
>>
> 
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo



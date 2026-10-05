Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F242CCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDn4q-000527-Ld; Mon, 05 Oct 2026 14:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDn4n-00051P-Gm
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:06:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDn4l-0001DU-Mt
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:06:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLFPX1973243
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qRF2Mv02dHOEikIfV9YDFKVLFBfWI4j/rizS53fTrjs=; b=LqK6On8SeN280N+x
 QIAIlu9himd9xNxCtyYBebd24LHwV+WFwi824aq8eHfdfHiOsE8oIRkRTCNibt2u
 SqctVw8YN9N6NP9l4qQYv3B/OPpXDxNs7NjusfX2ODuI8wS7DgMYnpaP7FkcwWj2
 SxLmM2JtD9bG+Y3/8oYSbWks5E1CvuIHli+96HbOPwpfk7vfea/vgpAhqnb1K1un
 RQO+N2J6npLy/2ryx2ZTAURHjQJHgHnqp/XrJ8M9dHqlSsOzTHTw3s42hOcroeSZ
 yNBDeMmuGPc6rvNdr0riWS6RKqvdnCDZ1quCSrJMk8AuRlaswyp+PxclmXLNgzOg
 3cWtYw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h41gnb6md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:06:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3512ff5e032so1071432eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791223568; x=1791828368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qRF2Mv02dHOEikIfV9YDFKVLFBfWI4j/rizS53fTrjs=;
 b=ez64IENJn7jap8HlubmMZ3DX8Tc2eZzfZSy9mY2KgwUDsS/U/Rb22HEM/1/hFf05rl
 rQWtbTYgOHAt9/xk4sBEUhC+/1We1j/YlP2Pd4+n/iRvHF01T0EGl2bZNVgejOuIeW3d
 FeH9DbBYSVBDuOIrljXcCI1GFuPyvylVCEPQxlaAYhKMjwGjkmp6c9ae7lIRGHh78VsU
 g1MmEN1FH9nXC9iySrCWvOWJYp/G+eiA3CViLHiNh/xSpGK9gx2AvPt6kJ9n5gzJkD/H
 lSStdaxU1AgTgVDIGPFEtcUGAwX5uGlTF04NUvOuflNHnqcThJRQMu+IC+rK3CCCl5y1
 fU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791223568; x=1791828368;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qRF2Mv02dHOEikIfV9YDFKVLFBfWI4j/rizS53fTrjs=;
 b=u1VvrpuTAv7xqeTIeqQIjQ0VSIFtCyUxBgV5vavGj738kNWC4/g7vAYAcZmeQn+whJ
 1efw4rSmNUHTG7Y2TW1wTlO4UJWfrk+g45KHgbch7dgOXvK7sqUDh9Mh70BpeX+meGEx
 db9mVVweLgP1MYgARwaBOGcbvReNYHhLX3Z6/GufO/5MDj32Uwddgot9gvONvMnJLxZm
 izO37zm1exuMTAykdD3kfz7LwhDBUJoDPELktEKQyqKqa7gmLClEvbPbhQ+Tl4ldwjlu
 EO2dUG/U/wd90XSufKADSalATY8LpXdmsQQOCZvvVMlt4XkdXcMwbQjpniUrhlwXrX3a
 O5kQ==
X-Gm-Message-State: AFuF++nNW4+w1TbdPHiE3ZSqwqOW4stYXjFyQ1+YBiU+giZ7l11H5DDh
 sID/2+V6DnJMvoGub4WKFKBTYpkUWBUTSfIajWFoNxrqY4zGRk6CuJA4EuflctTHOh3GjlK5zaS
 VGRk1Dt3IY6tFRNW7Bxj6d9UB3SqMBe6+nxEZNnnXUsJdaeJMyDt+zpMsYg==
X-Gm-Gg: AYBFou2I/VhAayoICYxodpSuMSKl8aMy4wqvNPOxo8u4tNVDn1xrjqFyrRYPPRQrjCT
 U2t4z9FTvgVWYuoRHf49e6JZYNF+Dxmd3ZrM15oeWmYoi5w2ob8NqgDn/JeFBnUEozxyshvRwJy
 qEe4uyFaz2Y3N3NAwz7MnyyPnZ8NGw1OvdVDC40rbxFYPXJAB04m42XAUC5ih5eLDqmA4ulIk4U
 CIx4S5kYU1BpSONkUTv4AvO+8sopKjqEprit9ob67VPoN2S9KT47Jwug8bXEhyYtHWTpdCrzJQI
 Nn1doBmlN6fL5myTmi5Ee3i43xAoMLk5uHbDE7w04H58vK6XfgKuqAvFGlDh+kZrikOZpu6+Xq1
 wruCDN0dkStPNFqGa8aCVB/woSxFbWSpSpxPZPIm+4qkNA9T+nhJpBcZFyvw6cp8LcYivTw==
X-Received: by 2002:a05:7022:30e:b0:15c:20b8:7973 with SMTP id
 a92af1059eb24-15d2e03cf44mr620681c88.6.1791223568174; 
 Mon, 05 Oct 2026 11:06:08 -0700 (PDT)
X-Received: by 2002:a05:7022:30e:b0:15c:20b8:7973 with SMTP id
 a92af1059eb24-15d2e03cf44mr620469c88.6.1791223565579; 
 Mon, 05 Oct 2026 11:06:05 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d84523b6csm47859c88.12.2026.10.05.11.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 11:06:04 -0700 (PDT)
Message-ID: <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 11:06:03 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wMWeiStp3URki8g4dIsMhMV-UvBZZ-8K
X-Proofpoint-GUID: wMWeiStp3URki8g4dIsMhMV-UvBZZ-8K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfX+HkF41EaQ2wM
 JvXSKCE8/U7nSyOiTCqi80YiPwDzCduW0gLwftwRpVynNP7Afm/73lDuOLwm3LJpCavB49SqV5X
 10M1vJTNfANSZe50S9g58Hnp4E0NZykhqlFUAWLpUABruJOH/WXLov2fC76UqyleK0SAdCh5AC2
 3/rKESz5LOFw9hmZC/OiBAKVOz+F8VRcKgXc1kvmCs5hbbWh+TzTj/4BZa7iy8htH+3BQUK+usc
 pDFpp1Xdi+y72pmCog4M1sLCFevyIMY5Oc8ZuwqwL1YP5aqkIVl34NrMEKIOh7B8wP0/Wn3BbD4
 yXO9R7oh7PLa5heoVQlHK6lnosZgJ8SsOF8M/+59PSjdIjM5F3uJ9F0yh1OMYkysvtS95EmZXjD
 rIvcoqhZwJQvJI8jZeMRoeFS9ALxhGLNf7kIV2eyFFUk5mRq4hw5IrdUvwcrhUsLqpu6mlWtuxl
 7M8wl/oMqkikwFjekUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfX+bpyLRp8F9Ye
 E+qyLIaObQJpNcdOS0bKV1VnK87TPzCQJrISkDpCvM9JpXHK/CuTJrwjS1+fREKor9jj0ZW/Bk7
 pTMUcjo/xfX9dkNirrAG5ZpMVdDffFc=
X-Authority-Analysis: v=2.4 cv=P9WvFSAu c=1 sm=1 tr=0 ts=6ac3e710 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iNjRNI7rvLvbMmTCvfcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050071
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

On 10/5/2026 10:04 AM, Yonggang Luo wrote:
> On Tue, Oct 6, 2026 at 12:25 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> Ok, but I'm not sure it answers the why.
>>>> Could you explain the benefits?
>>>
>>> Which part? keeping target_arch as SYS_EMU_TARGET__MAX for user-binary because
>>> The following original code would return -1 for some user-binary
>>> +    SysEmuTarget arch = target_info()->target_arch;
>>> +
>>> +    if (arch == SYS_EMU_TARGET__MAX) {
>>> +        arch = qapi_enum_parse(&SysEmuTarget_lookup, target_name(), -1,
>>> +                               &error_abort);
>>> +    }
>>> +    return arch;
>>> So basically assigning any value for the user binary is valid.
>>> SYS_EMU_TARGET__MAX is more explicit as it's related to type SysEmuTarget.
>>> -1 is another option but easy to confuse.
>>>
>>>
>>> For why commit e934c624f32f6f44f427d73a2e6a67e983a02ae6.
>>> "target-info: Statically initialize target_arch"
>>> doing that, I am not sure.
>>>
>>
>> I guess there is a (good or bad) reason for which sub variants of
>> targets are not reflected in SYS_EMU_TARGET enum. We should double check
>> that before doing any change, as it might have other consequences.
> 
> 
> You’re right to ask, and I need to correct my earlier suggestion:
> leaving user-mode target_arch
>  as SYS_EMU_TARGET__MAX is not safe. target_aarch64() is used by ARM
> code shared with user-mode builds,
> including cpu-max-v8.c, where its result indexes a two-entry array.
> For aarch64-linux-user, the sentinel could therefore cause an
> out-of-bounds access during type registration.
> 
> I checked the distinction: softmmu needs the full system-target
> identity, including variants such as mipsel;
> user-mode variants such as aarch64_be use their base TARGET_ARCH
> (aarch64) for this enum. I’ll keep the full TARGET_SYS_EMU
>  value for softmmu and use TARGET_ARCH for user-mode builds, rather
> than leave the field at SYS_EMU_TARGET__MAX.
>

That's technical details, but not an answer to the initial question of
why we need to change anything for user binaries, compared to what exists.

>>
>>>
>>>>
>>>>> "target-info: Statically initialize target_arch"
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Pierrick
>>>>>
>>>>>
>>>>>
>>>>
>>>
>>> --
>>>          此致
>>> 礼
>>> 罗勇刚
>>> Yours
>>>     sincerely,
>>> Yonggang Luo
>>
> 
> 



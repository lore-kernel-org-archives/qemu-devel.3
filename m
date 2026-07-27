Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F25C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woMGR-00051r-CO; Mon, 27 Jul 2026 10:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woMGL-00050e-Ow
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:25:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woMGI-0001Mm-Nr
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 10:25:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlaXC3414011
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 14:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mjjz05ITIpIi4vKTzhbO6sCXDkqnG6r8bdRbUXn9LcQ=; b=PF2wb8d/30wmke4Z
 ynRwnzClfrtw9B0leZGkuVPIdbfQqvZXrYR4zOm5MNRMBK3+zggWsLQIIbmMaXbk
 EiPCX51lj/ZkHRfB1qQ13tvqKApzFI930gDSXS9yTSFVRpE1P4S/jHjdJaPVPAM9
 cvknUZe6HBXN2ZzhJoF5wJtbCXT3MN8Pv14BaA+CT6karoECBIqJFkVEXlTXl9d8
 yCPAvq72YZIBkwT6J2hlT+a6Xv8jbHUIR0tWUNPqqfDsgIuusrlXdp92UTIw2aWG
 3sY3irvB15GstMP8CzcjtKo5SWQiZMiQwi8ku5VmncxorYpgYsSHGwY6Unuxhplt
 9o6WJg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v692fm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 14:24:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0408254aso59041561cf.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785162295; x=1785767095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mjjz05ITIpIi4vKTzhbO6sCXDkqnG6r8bdRbUXn9LcQ=;
 b=E9TrlJc78lvGyAer8n5CaGWFaVjd7wagCg+mWR1QXjucbJs4IlZ4QN60UjUTVF3v9X
 +MFkZCpU7G2J2Ob5kBqG7vIHuSG+rLeUXFiq0Ao2/z/s7wCDo+29BzcZQx+HW461Uom1
 VSQb8IGg1ttUGWXEMSuAjIYKWQZ5FzFel0Y3MVvg0fa5U9xOJEl7prPbagCsfLXrUWHg
 hxP2zEXdCir0UpcM25+BGJUFRdT3XbS8wsoSVvzU4hC2PAP5hwDKSvlGPNj+pCRUG3pA
 /PmNMxwQmHSlhuFKzsFM6xsvDLHZ40FGZhbnb8hxxLAC0iKeT1LEoudQMg08R2O7xdsT
 Dv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785162295; x=1785767095;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mjjz05ITIpIi4vKTzhbO6sCXDkqnG6r8bdRbUXn9LcQ=;
 b=IQFaxGRkZdksVAYbNMcvEDbCL1wXiaR8JJnu1mPIwEwtdNJrkQgu0wu4KwMNgA9x1/
 kEKpXzIWAEAx0KvgyVVWJkFFGRRgxg5K4fWmzhqxUlXZxfUSKFnMAvAfRokHESXOic9C
 XY/a30Bjufukrjs19H7klJTHVpkx/D6lx+ZlzrA5Yjtgtc/CUfOM3m+j6+EgdJmd2M7h
 nS3aoEQCb03Xx4WlGiK5IAH2KX4wYl7gmsRcbcYGuzTPvJHaXiig9BY62xmlWJ0KghBE
 F53zLOee4vtzfgPEZxjWU/o3iDn6Wp119aOJafXpoku39G7NjnKJnuHwK32mZ1DG6Lau
 G94Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1FVzpcfnAEkC3P8/DbVtsTSScD9ZjxfMP4IVAu6cHqv9pj9MG+oX5x/Uv0gpfLrEv99LWpkqyGMxE@nongnu.org
X-Gm-Message-State: AOJu0Yx5CEwZwDakOzA//Q1X+jcJAAP8Hsvod58GK6so3uPxtPqcBSZ3
 kULAFS0YRCzU0GT/DjQWqdVf6o7zt2uXJnggQYt7gSTOAZWADo41+zU+v0DlAxsHHK/JeW836WY
 SHVVb5y7y2/CpksaOguO9GD+Y39lsc3yngx8XyHiL7ajYLaXQ/zeCp4SSVQ==
X-Gm-Gg: AR+sD13bTEqurrW+xrwI1wCjg3cru/db8LRoxzbGSJUw1RE+rIyBuMrlfQ1Cclb1f92
 aGvZdhl0D61Fk+GdJOZPgS4PxiXlIO1L+veUca1VlnAukrNWMSvcosDAfpjMjR1U0dZm9RLcBGJ
 btqNVl445iYqKzJBvk4elTXG6ekjrWDgVe5WLWWzIdXwOCCjvfcPsYOelGZkvR1teRN5946XuRZ
 AJ3sSBdfKC/vFZwUhUyWQH270S3mSOfhFxbqUQ3eiwwK/OnPGXVsS9sOwDe6pbt2f+xolXFp0+e
 3uxd0uCEIkxSZ6CJwLcnclfefVUp0GUB6hRjBzxmqiXgKyFDv8sOuOvixbWL4KUWxr2oQD1naBI
 O13QRXlyXXeUZsm0ceuhq8UcbTQUFTwveONuIx5by+N8W02Zjruo=
X-Received: by 2002:a05:622a:314:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-5295d37817emr112817071cf.22.1785162295073; 
 Mon, 27 Jul 2026 07:24:55 -0700 (PDT)
X-Received: by 2002:a05:622a:314:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-5295d37817emr112816701cf.22.1785162294639; 
 Mon, 27 Jul 2026 07:24:54 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f864305f5sm48315559f8f.17.2026.07.27.07.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 07:24:53 -0700 (PDT)
Message-ID: <3677fd2b-64fc-45fe-8bb7-04f84773c77e@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 16:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add option to disable building tests
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Florian Schmidt <flosch@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260724135413.1716872-1-flosch@nutanix.com>
 <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
 <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
 <c68be7c9-113d-4de1-8ab5-bee142e8db15@redhat.com>
 <6b432df2-b318-75ec-e26d-e1134baa06ca@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <6b432df2-b318-75ec-e26d-e1134baa06ca@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX+Bt9xZtaj6YQ
 MW38eyVxPhIggTPNG6ojcNWqEYP5OGAyLI89DuPUSVVQ+NQjNA+8Muf+YN2PyMGwRLsD5z3LVSQ
 0A7W7JAzXvg7Xk3gWJ/7AsS94+ZMzCQ=
X-Proofpoint-GUID: 53OV8vYzrQxYc2Sxd9LGYpsmfaL886C5
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a676a38 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=rWaqrvi0zTk1m8YWIH4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 53OV8vYzrQxYc2Sxd9LGYpsmfaL886C5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX01I/dMdbaTW/
 VJqiz+Or3NSHsANuSNeQIMsfNU10tTn8hNTD1URN5aZYpjh3OB9sxqbgvZHXtVen0erFZSRDpCU
 1Czsw/1qB2NDZfl1KTDwbaaj+hu3fjJ3tkUhg8btTS1h/Ga5JHNCbxP7TcUGmO1YCDyb29NqFhb
 X90LWIr/ytHX5D3MiNcjohewYms+WgWogc3k1UfhP3ho7tmbOAR/dt4p0QVV+htgDhnE5swqy6A
 v8cej5XAzhtSFjE1ucCDqdlhbuABFzRQu0TKS6JmkjYT1rMHK+Voach/FlSOXmM9igymSCqiRWb
 CEbWJYk2x9SD3GV0OTolzn2wCxvGjW7BI+WZYN+KWThmhAdiAzYadk8AQo/UUkGR8TyxDm8Qotk
 148btBFeB+IDrfUz7gOrhXlbeIzIWJ6ORE3xSirm7B6QQ1AWSkTZrOHV+nxnewCV0JVyPgcJEl8
 i+1ZVlRwD1rauYz0dlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270136
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/7/26 13:19, BALATON Zoltan wrote:
> On Mon, 27 Jul 2026, Thomas Huth wrote:
>> On 27/07/2026 10.12, Philippe Mathieu-Daudé wrote:
>>> On 24/7/26 18:45, Pierrick Bouvier wrote:
>>>> On 7/24/2026 6:54 AM, Florian Schmidt wrote:
>>>>> There are situations in which you might want to build QEMU without
>>>>> building the full test suite, which in some configurations can take a
>>>>> considerable amount of time to build. This is especially true when 
>>>>> using
>>>>> LTO with clang. For example:
>>>>>
>>>>> $ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto- 
>>>>> objects' '--extra-cflags=-flto=thin -ffat-lto-objects' --target- 
>>>>> list=x86_64-softmmu
>>>>> [...]
>>>>> $ time make -j8
>>>>> [...]
>>>>> [3078/3078] Linking target tests/qtest/qos-test
>>>>> real    6m43.250s
>>>>> user    101m15.967s
>>>>> sys     4m3.813s
>>>>>
>>>>> $ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto- 
>>>>> objects' '--extra-cflags=-flto=thin -ffat-lto-objects' --target- 
>>>>> list=x86_64- softmmu --disable-tests
>>>>> [...]
>>>>> $ time make -j8
>>>>> [...]
>>>>> [2024/2024] Linking target qemu-system-x86_64
>>>>>
>>>>> real    3m14.277s
>>>>> user    33m13.174s
>>>>> sys     1m36.642s
>>>>>
>>>>> Add a toggle to optionally disable building tests.
>>>>>
>>>>> Signed-off-by: Florian Schmidt <flosch@nutanix.com>
>>>>> ---
>>>>>   meson.build                   | 2 +-
>>>>>   meson_options.txt             | 2 ++
>>>>>   scripts/meson-buildoptions.sh | 3 +++
>>>>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/meson.build b/meson.build
>>>>> index 49a5baf5b5..ad728c26ec 100644
>>>>> --- a/meson.build
>>>>> +++ b/meson.build
>>>>> @@ -4605,7 +4605,7 @@ subdir('docs')
>>>>>   subdir('pyvenv')
>>>>>   # Tests are disabled on emscripten because they rely on host 
>>>>> features that aren't
>>>>>   # supported by emscripten (e.g. fork and unix socket).
>>>>> -if host_os != 'emscripten'
>>>>> +if get_option('tests').allowed() and host_os != 'emscripten'
>>>>>     subdir('tests')
>>>>>   endif
>>>>>   if gtk.found()
>>>>> diff --git a/meson_options.txt b/meson_options.txt
>>>>> index a07cb47d35..68333ca402 100644
>>>>> --- a/meson_options.txt
>>>>> +++ b/meson_options.txt
>>>>> @@ -43,6 +43,8 @@ option('gdb', type: 'string', value: '',
>>>>>   # on the configure script command line.  After adding an option
>>>>>   # here make sure to run "make update-buildoptions".
>>>>> +option('tests', type: 'feature', value: 'auto',
>>>>> +       description: 'Build the test suite')
>>>>>   option('docs', type : 'feature', value : 'auto',
>>>>>          description: 'Documentations build support')
>>>>>   option('fuzzing', type : 'boolean', value: false,
>>>>> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson- 
>>>>> buildoptions.sh
>>>>> index c003985047..3fec13a336 100644
>>>>> --- a/scripts/meson-buildoptions.sh
>>>>> +++ b/scripts/meson-buildoptions.sh
>>>>> @@ -194,6 +194,7 @@ meson_options_help() {
>>>>>     printf "%s\n" '  spice-protocol  Spice protocol support'
>>>>>     printf "%s\n" '  stack-protector compiler-provided stack 
>>>>> protection'
>>>>>     printf "%s\n" '  tcg             TCG support'
>>>>> +  printf "%s\n" '  tests           build test suite'
>>>>>     printf "%s\n" '  tools           build support utilities that 
>>>>> come with QEMU'
>>>>>     printf "%s\n" '  tpm             TPM support'
>>>>>     printf "%s\n" '  u2f             U2F emulation support'
>>>>> @@ -515,6 +516,8 @@ _meson_option_parse() {
>>>>>       --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
>>>>>       --disable-tcg-interpreter) printf "%s" - 
>>>>> Dtcg_interpreter=false ;;
>>>>>       --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
>>>>> +    --enable-tests) printf "%s" -Dtests=enabled ;;
>>>>> +    --disable-tests) printf "%s" -Dtests=disabled ;;
>>>>>       --enable-tools) printf "%s" -Dtools=enabled ;;
>>>>>       --disable-tools) printf "%s" -Dtools=disabled ;;
>>>>>       --enable-tpm) printf "%s" -Dtpm=enabled ;;
>>>>
>>>> That's a great addition, including just for speeding up normal builds.
>>>>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>
>>>> If we want to overengineer the thing, it could be possible to still
>>>> declare all tests, but not build them by default. However, it's 
>>>> probably
>>>> too error prone and much less simple than this patch. So I don't think
>>>> it's a good idea.
>>>>
>>>> Regards,
>>>> Pierrick
>>>>
>>>
>>> When is it useful to build without the provided test suite?
>> I sometimes wished indeed for a --disable-tests switch in the past 
>> already (was just too lazy to contribute a patch): I'm sometimes 
>> building QEMU in a separate directory, just for a very special case 
>> like testing a patch with an --enable-asan build, or for doing a "git 
>> bisect". In such cases, I never want to run the normal tests since 
>> it's simply not necessary. I run the tests from my main build 
>> directory instead once I have a final patch and want to contribute it 
>> to upstream. So IMHO this patch is a good idea.
> 
> I similarly have a local patch for this for such usage, that I never 
> cleaned up to submit but I think it's a good idea.

I'm not saying this patch is a bad idea, I'll likely use it too;
I want to clarify what are the valid use cases the community sees
here. Building pointless things clearly has a negative impact on
resources and our time, but not testing changes also has.
IOW in somes cases this change is acceptable, but I'm a little wary
on massive use by default.

Anyway I didn't wanted to start yet another endless discussion so I
won't intervene further in this thread, sorry for the usual noise.


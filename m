Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC88DCA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 18:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCLCy-0003g6-A8; Thu, 01 Oct 2026 14:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCLCw-0003fd-8M
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 14:08:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCLCs-0003dF-Sn
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 14:08:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FscaJ2686639
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 18:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5K7m1L8mKqvo30Z/n9TpcPqcxooEdCbyy3woEyMg3Sw=; b=K9tltFe2bXo213wL
 ttjBpMUi25orNoaE94+ih9jgDe3ILpt/82+VZRqEc+t4UzLE75PELtoq7r+WKy03
 mFWgndC7nwiGAaSGlfrlvpSFqtvfXQ2fh/puGjwdoZNQ8JCKL8V6qk2EYIbDqEbK
 6gzoNZ5v88ZsYDQaXS6BKK8JO1xga1M0VKljInaGaSuHn+YUoOKIWbAOEaHO4T9h
 +L8WWuK8BrCfQMTOVr5UslVGksuchRec3H9iqKHIg5F/1czTOPjrjQ02xKhKwzvM
 XH8uCwvlMqsZzOziQePHggKH8mp6rhu5aovhEXIDhWUDZ1QSkbQvqNmr6oJQ4tpR
 ry64Xw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a8r9k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 18:08:33 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-14373747468so6469180c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 11:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790878113; x=1791482913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5K7m1L8mKqvo30Z/n9TpcPqcxooEdCbyy3woEyMg3Sw=;
 b=O5DzB7vu7KfCsZbwv2al2f4qlKg8MJbavZcUP4PLDZAmgDo3r6QH0xR/qxrLgbSU8w
 vOaihHLT1C3IDaugWfyB0BcR09JiTwghM01uBFrMOWUXaaNPfdpwY1+D2UM2upaqeeOg
 HcchaC/tEGXs2svPEH+HAXoT8IC3LTxCxBhqan9tF0pwod+NwhYO11DoAiVIXfk/405V
 FAvcmrK9H848x0KlHFYRGIMAVnXfwptXE3+5tTIA+q50nNgOwPSQAESXhFjwlYOx3TQ3
 8sem6eBwZAVvAegcTwcaHpKmO2C9qICoxn5yEqUmz++0Lp1JhrwuBI42eCoHpx2zn6xj
 /2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790878113; x=1791482913;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5K7m1L8mKqvo30Z/n9TpcPqcxooEdCbyy3woEyMg3Sw=;
 b=H5xHMVte8A9A53Mlj0m2oGg1xVUir5k+t0THbp/fEgdKi8GnMlWc8tHEBc6Ic667Rv
 hpeAo5xGoWeJL4qy//q/fpSxnP2xWzNtYF2DphT0+cHAdoey6PLHIrBFOEeRPME+FMoX
 NmxKmbtbz4UAeEtIX6dJSyUR3/xPfuIR3jaglICm79jAt9ouaUUtT1vltPZYXyBBXqMm
 AEc73OGA90F8MYPuqz+igjRKlULDWR5tzj1bnTVnPjE0JD/8CXXr+ZOPvuRouB3W7tp4
 ias5p1D0K9LO/rgiYa4NDepQR/ED6aifh0XbWrbPIl1oHl44koeEh4qI2fCjh5pD/48I
 obdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYQKNp3BsnSwXCHFyGJGGay+JEdBeHsEJpRbsVOFMcMd5ifGZai/K3mtjSvUK8LnUFACikedwwY8NS@nongnu.org
X-Gm-Message-State: AFuF++l0dILL+ZpcdLwfS6GVlIEYGlp0iPs0dd7hbwVsPeHHxrdUufH1
 sBTGV8ZVhTtfCAjf3JLqezeGpJmHz5rvfzp9c/0q9oje+qItgp6eOVAt3Jkxv8tpq2N8rCYQekI
 LaRgMd/KAmBlYmVtzPzxosWY/VuDT3/RzWVsJUAKbi9IcAa3taDuSPIpKig==
X-Gm-Gg: AYBFou0tOoypRT77SOuT2sLoOpyCSkseaQ8xqzB/OzBSHHXXd+rq7pqDCVzN0teq3F/
 fO1+HqsDpnjlBJjkY16krv6jQGW9BsRCOPyQzDr51YLarjfNLR4te+8N2IRKZcp9WT975VlU4Vl
 EU0bhJL/M3g39C+ANf2s8TDLUwmisXtkkpquW3/aFMSlBQSql05nn+0Arz7UCa71GG8zEPNPjfT
 BxM/JyrjjzRTX/tS6INRzj1xqfg75WYswhZEtVHjlxvs+5/ryc/6t62f6eouuo2mBJ1VMr+hz+f
 yNi/c4hIdv4Ckl4PxNziPBoXADjeGowMQLnCjI5XAwLwvshH1tCKpXj/DoaNwSMcTAUZjPA+wl9
 94oznPgUaz5S2/fKqSsyAKUyXl0sCI5KTOSwXK322vW4txtQ/NN/9MpPDsgd6fmE158Zq5g==
X-Received: by 2002:a05:701b:454d:20b0:143:54c6:6a5 with SMTP id
 a92af1059eb24-14d35193f6cmr5172709c88.37.1790878108822; 
 Thu, 01 Oct 2026 11:08:28 -0700 (PDT)
X-Received: by 2002:a05:701b:454d:20b0:143:54c6:6a5 with SMTP id
 a92af1059eb24-14d35193f6cmr5172243c88.37.1790878099813; 
 Thu, 01 Oct 2026 11:08:19 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43eba13bsm302559c88.2.2026.10.01.11.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 11:08:19 -0700 (PDT)
Message-ID: <6bf4dad5-4fa2-4df1-b6b8-d594dbd3842c@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 11:08:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: luoyonggang@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-2-luoyonggang@gmail.com>
 <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
 <CAE2XoE_+nhj58M9_yx6wf532qCSVcERpTw7F4AU7PXN7prhpzg@mail.gmail.com>
 <74853ef8-7315-466a-99ac-41c8182f9b13@oss.qualcomm.com>
 <ar4TQtKqfXX5Ul9O@redhat.com>
 <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
 <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
 <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
 <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
 <ar6a_uDw9OeLng6c@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ar6a_uDw9OeLng6c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MiBTYWx0ZWRfX/82pO/BtS/yx
 Lqcey1kF4sFj5GdarkZIt0c5PSPzuWgMmWHQqjGrkngFtKWbavB1qqRUfFpVROgMm2oCyjSvJ97
 siAv9teB/TXzg2AtP9YxVEFO4WQxARQ=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abea1a1 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=pGLkceISAAAA:8 a=2UyaynILr8k7rYdUywsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: jtS4PQZ9ncLHOSkS-ySsGVDtx_BdgsMk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MiBTYWx0ZWRfX/YhCgzy001W1
 F1tzVMMJa4/t0QkBe7w8WrY1UByibTjBelsb72NSQt8avqg3jbKokt2WfocCDiHRgcnra1m90j3
 wpEtQgQ6iPQto1zrYgkIz+c1Miwm4tyZQj+1IPjHSzcWy3va3m+9bsNHPZ/ZK+st0lskUHWXE7z
 0W/Oim33k0UxJRLNWNiQrtrCeB4Ej0+xXgKhF2ioGENOizT7tAwnmMvKzp+uLdIWuWUnG+V75Ys
 loA4IPk2nIfpXUC6rAv72C+zrcqTC+yguc+1wj5rRb/ZA28vRUhFia3T+7mIwioIzI9TIjThaLx
 P2W5xpNhQ3l/A0AkMq3WYJNktPpLMpRW8pHLj/GRUZLZoegiS+KI7UYx/023zi4WgG1SPht1Lc+
 tvutb8Xt17ufN3B2giHcb6VERjHal5WeHGdJVPIpMzu+AM1yJ9pgGlQuP0+kVw+3vk+3D8izRsS
 l0Bmz2sRYZBrgCa4zzA==
X-Proofpoint-GUID: jtS4PQZ9ncLHOSkS-ySsGVDtx_BdgsMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/1/2026 10:40 AM, Daniel P. Berrangé wrote:
> On Thu, Oct 01, 2026 at 09:19:48AM -0700, Pierrick Bouvier wrote:
>> On 10/1/2026 9:14 AM, Yonggang Luo wrote:
>>> On Thu, Oct 1, 2026 at 4:44 PM Philippe Mathieu-Daudé
>>> <philmd@oss.qualcomm.com> wrote:
>>>>
>>>> On 1/10/26 10:13, Yonggang Luo wrote:
>>>>> On Thu, Oct 1, 2026 at 4:01 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>>>
>>>>>> On Wed, Sep 30, 2026 at 09:23:50PM -0700, Pierrick Bouvier wrote:
>>>>>>> On 9/30/26 6:55 PM, Yonggang Luo wrote:
>>>>>>>> On Thu, Oct 1, 2026 at 2:19 AM Pierrick Bouvier
>>>>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>>>>>>
>>>>>>>>> On 9/26/26 1:15 AM, Yonggang Luo wrote:
>>>>>>>>>> - Add machine_class_set_name() so boards can keep a stable -M name
>>>>>>>>>>      when the QOM type is uniquified. machine_class_base_init still
>>>>>>>>>>      defaults the name to the QOM type without -machine.
>>>>>>>>>> - Document that MachineClass::name is the -M name, not the QOM type.
>>>>>>>>>> - Sort -M help by MachineClass::name so order matches the printed names
>>>>>>>>>>      when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>>>>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>>>>>> ---
>>>>>>>>>>     hw/core/machine.c        |  6 ++++++
>>>>>>>>>>     include/hw/core/boards.h | 12 +++++++++++-
>>>>>>>>>>     system/vl.c              |  8 +++-----
>>>>>>>>>>     3 files changed, 20 insertions(+), 6 deletions(-)
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> First, I'm not opposed to this series, and if anyone wants to pull this,
>>>>>>>>> I'm ok with that decision. It's just unclear for me what will be
>>>>>>>>> direction after this step.
>>>>>>>>>
>>>>>>>>> If I understand correctly, the goal here is to allow to register
>>>>>>>>> multiple "virt" machines, while still having distinct QOM types behind
>>>>>>>>> the hood, which does no affect behavior of current binaries who have
>>>>>>>>> only a single "virt" type at most.
>>>>>>>>>
>>>>>>>>> That said, if we project in the future where we have a binary with
>>>>>>>>> multiple of those "virt" machines, how will the current series help? The
>>>>>>>>> situation we'll have is distinct QOM types, that all answer to the name
>>>>>>>>> "virt", so we have no way to select them individually.
>>>>>>>>>
>>>>>>>>> Slightly worse, find_machine() will just pick the first machine name
>>>>>>>>> virt, which is a non-deterministic order at the moment.
>>>>>>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/system/vl.c?ref_type=heads#L846
>>>>>>>>
>>>>>>>> That will handle it properly. For single-target binary qemu-system-$arch.exe,
>>>>>>>> this won't be an issue, as there is no conflict as they won't be compiled in.
>>>>>>>> For multi-target binary qemu-system.exe, we will choose the target through
>>>>>>>> -M $arch:$machine, and when no $arch is specified, the default to arch
>>>>>>>> to be "none",
>>>>>>>> so still won't be non-deterministic.
>>>>>>>>
>>>>>>>
>>>>>>>> "when no $arch is specified, the default to arch to be "none",so still >
>>>>>>> won't be non-deterministic.
>>>>>>>
>>>>>>> That's my point, the current abstraction will create something ambiguous by
>>>>>>> design. When people will specify -M virt, without $arch:, a random machine
>>>>>>> will be selected. At least, maybe this series should ensure there is only
>>>>>>> one virt alias, or make it forbidden and uses unambiguous names only.
>>>>>>
>>>>>> Yes, if there are multiple choices, we should not pick an arbitrary one
>>>>>> non-deterministically, we must require the user to narrow the choice
>>>>>> explicitly in some manner.
>>>>>>
>>>>>>> "$arch:" is just a workaround to not add -target option, except that it
>>>>>>> comes with additional problems, creating inconsistent command lines.
>>>>>>> I already expressed my skepticism about the "machine prefix" based approach,
>>>>>>> being more in favor to strongly filter types per target with an unambiguous
>>>>>>> -target option. I'll accept the community's choice on this, but just wanted
>>>>>>> to see this explained before someone hits the pull button on this series, so
>>>>>>> they know what will come down the road.
>>>>>>
>>>>>> Historically, QEMU do alot of things like this where we invented magic
>>>>>> syntax that needed custom parsing of the command line. Over time we
>>>>>> came to the conclusion this ad-hoc parsing was a bad idea, and we
>>>>>> should always explicitly model things, even if it is more verbose.
>>>>>>
>>>>>> Thus I would not want to see "$target:$machine" as something that is
>>>>>> parsed into two pieces.
>>>>>>
>>>>>> IOW, "aarch64-virt" would be OK as a unique name which treated as an
>>>>>> opaque string, but "aarch64:virt" as something split into "aarch64"
>>>>>> (target) and "virt" (machine) would be a bad idea.
>>>>>>
>>>>>> An acceptable way of modelling the latter would be to use
>>>>>>
>>>>>>    '-machine name=virt,target=aarch64'
>>>>
>>>> Why mix target information parsing at machine level when the
>>>> machine already know it is target specific? People wanting to
>>>> use the ARM virt machine don't want to know (and don't care)
>>>> about the M68k virt machine.
>>>>
>>>>>
>>>>>>
>>>>>> or
>>>>>>
>>>>>>    -machine virt -target aarch64
>>>>>
>>>>>
>>>>> That's made me confused, as different people propose different ways to
>>>>> handle it.
>>>>> Can we just choose one first?
>>>>> '-machine name=virt,target=aarch64' is introducing new options, so is
>>>>> '-machine virt -target aarch64'
>>>>> I can not argue which is better, my suggestion may land one first. Both
>>>>> "-machine virt -target aarch64" and "-machine $arch:$name" I have
>>>>> already implemented. And currently I chose
>>>>> "-machine $arch:$name" according to
>>>>> https://patchwork.ozlabs.org/project/qemu-devel/cover/20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com/#3749257
>>>>
>>>> You still did not explained what you are trying to achieve
>>>> with all your contributions, so my view is surely biased by
>>>> what we envisioned 3 years ago when we started to pave our
>>>> way for heterogenous emulation.
>>>>
>>>> My options so far for a single binary:
>>>>
>>>> - infer from argv[]
>>> This can be easy to implement and can be defer till the qemu-system-$arch
>>> is symbolic link to qemu-system.
>>>
>>>> - enforce with CLI -target
>>>
>>> I want to post my personal options, I'll prefer the -target options as
>>> it's far easier to implement than "-machine $arch:$machine".
>>> -machine $arch:$machine is very complicated to implement correct.
>>>
>>>> - not expose any machine
>>>
>>> I think not exposing any machine in the command line is a good option,
>>> as it's easier to
>>> implement and clean for the user. But I think this series is still needed.
>>> As we want the means to inspect all machines and devices for all
>>> targets(that need all of them
>>> to be registered into the QOM type hash table).
>>
>> It's not strictly needed to expose all types. -target can be parsed
>> first, and influence what is visible from help (including -M help) also.
>>
>> Also, if we go down the -target option, we should decide if we expose
>> all types or not, which means if we implement filtering or not. If we
>> expose all the types, I'm not sure what -target is supposed to choose.
>>
>> Daniel, what do you think about this one?
> 
> *If* we take the starting assumption that the new multi-target
> binary does not need to be a perfect replica of the existing
> binaries, then filtering devices is creating extra work for
> ourselves, to solve a problem that isn't especially important.
>

Yes sure, just brainstorming here, to help Yonggang moving forward with
a clear direction.

> Even with the current per-target binaries there are countless
> devices linked in which are incompatible / not usable with
> certain machine types. A new multi-target binary with a union
> of all devices will just be a bigger example of a scenario that
> already has to be dealt with for today's binaries.
> 
> So if we have that assumption that we don't need to do device
> filtering, at that point, a --target option doesn't have as
> big of a role to play. The machine type code knows what target(s)
> it wants (1 or 2 targets depending on if there are 32 + 64 bit
> varaints. The CPU model the user requests (if the CPU is not
> hardcoded by the machine), determines 32 bit vs 64 bit.
>

How can we deduce this information (bitness or target for existing
machines/cpus)?
Also, how to deal with devices that are only available for some targets,
but not others, depending on various Kconfig knobs?

> A --target option (or similar -machine name,target=xxx) could
> be used to dis-ambiguate between 'virt' machines if keeping
> their user facing machine names as-is, or it could be used as
> a way to be more explicit about the 32-bit vs 64-bit choice
> and sanity checked against the CPU model choice.
>

We could also not register them as virt if more than one target is
detected, so people have to call explicitly aarch64-virt.
Would that be a possible way to move forward?

> So overall "device filtering" or not is the key question to
> decide IMHO.
>

Fine for me. Just want to see how things will be before spending the
effort to review many patches when outcome is uncertain.

> With regards,
> Daniel



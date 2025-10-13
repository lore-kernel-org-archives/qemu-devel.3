Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6778CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 10:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Fz3-0001ga-3B; Mon, 13 Oct 2025 06:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8Fyz-0001fV-7D
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:40:49 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8Fyt-0007Ce-IU
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:40:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso3569959f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 03:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760352038; x=1760956838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7rjDlVmUfZdLPTVDi7Qx47Ou5H/phUo1jMSqY/mGY8=;
 b=EYGVPQpQc4QV/tv7Iw2dJc0SELpHDXtMYdXcAygmDaEQl+b3KDkHszDpmn4DXY6bv2
 PF5/F9n9i1LTXylG5sDJzQ9TC8MeMeh0RPOsj8aOeaOyQYFMFULTELu57YtOvEUN0aA7
 hW8xZMzLSum3Kbg45WzgwDRVZYD/ZZ7MGOud/TrdGcomoUPpMI7DpUnPX5+593gHVdYi
 rXkgUG0rf+QdWDZjNa0cqoqVIWTZaR0PCf0kUier8aEAXWoqRW5bu4S9uHMdyKB9XPcY
 /nzTyjZlb2iK/KlAOH0X3E1+j6Z+p02bBZN1xhXFf65VvFMtaqTBwNbiIR3vmvzk+LQD
 b4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760352038; x=1760956838;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7rjDlVmUfZdLPTVDi7Qx47Ou5H/phUo1jMSqY/mGY8=;
 b=Xub03OnUnxHvlKfPgZHQyJnRPm9/zRc8jyiVGVxIn7dGjn3mfQpjTB+jOA7Va/GlpA
 GUHvPblsd0oo0emqFJJQacG1ofN38pQmBLlGe+6yoOtvX5TLQ5BDuWzry7339YB0Loye
 WSOv/pu0MPPYBVAdnrgo1oFgwqgXtj30BaU5u4PGbG9x0dBH1atcEadF1smLqE6iHhE5
 eNDhClsGmxIJth5Smy3a5z+bYunm6NEAp4sm8OzFZA19YjVNX0r9WFJljgSrP/NdoOmW
 mAk80rJwGlUP+dUp/kEfJ+UOUKxO456hjCeKikmXpKn6/R9pA9Hy0ZulaTQ7Yf5hIrJ5
 zxkw==
X-Gm-Message-State: AOJu0YysK/TW8aUC4UVB/ih1QrNiE9DFpn/8j+8LxOkm1idjyjscoYGx
 FCRJ9GdMTVHnhCNEpfR9jricGHtW0aZgB2bl/vDYAUIEjaki6Vwsr/SB
X-Gm-Gg: ASbGncuFsbVm4dSuu8qk4VL+3WEGV1ABZzmSvqqvQ14K1xoiC5pEHpuW51O6nIokLiB
 /nfFTNjbetKJPf30aASk/YTXgBYuylDN+gOE8ILmBeTC326xcS8IAKhgnbvU3Fa2lvHATKVKhG/
 2G+wbLS2jNDaUXemJKmpE0jzfyLLeEHiIChh8E82eqGeb1bBHfOjfoAFS6oSdVU14yvdi6nZs/9
 HF6gd/H4zOpbwfgrlyECBg+/2OsuHD+0BV5LXVMzmBQ/hPYt/1HKYuR5L/vvW1GWVOjfgdM6pnJ
 4jaUVEln65pjZ3ARm4kIIeSN2uzqc1RovI6QoxXevIA6ROiv11F8SMwZWh33iuf+3sJeNanX6Y3
 qaTJFcyu8CwT0vB1llE3hGBWpbFdv9KKBEuKewupYchXutq+rKDMNlan25Y7SsgFvZ+gev6Bffh
 HPqmQ1/88EchqAocwz0954CZiQW8HPgZPpqDoP9r+FjoKylp8t
X-Google-Smtp-Source: AGHT+IFPVhr7fnoczXLCRNb6LwQBSyPKZNDA9JKVJp9dGBkL5p30KO9p7NF8acWRbOPcfnJZvH5XtA==
X-Received: by 2002:a05:6000:4304:b0:3e7:6268:71fd with SMTP id
 ffacd0b85a97d-4266e8d93b2mr14112114f8f.52.1760352038054; 
 Mon, 13 Oct 2025 03:40:38 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400a0afdc243fcb5392.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:a0af:dc24:3fcb:5392])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d4bbsm17875064f8f.2.2025.10.13.03.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 03:40:37 -0700 (PDT)
Date: Mon, 13 Oct 2025 10:40:36 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_docs/system/security=3A_Restrict?=
 =?US-ASCII?Q?_=22virtualization_use_case=22_to_specific_machines?=
In-Reply-To: <20250908104125-mutt-send-email-mst@kernel.org>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
Message-ID: <46AA9C03-CA7E-4C4B-AD05-A9053666BA52@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 8=2E September 2025 14:45:40 UTC schrieb "Michael S=2E Tsirkin" <mst@re=
dhat=2Ecom>:
>On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
>> Currently our security policy defines a "virtualization use case"
>> where we consider bugs to be security issues, and a
>> "non-virtualization use case" where we do not make any security
>> guarantees and don't consider bugs to be security issues=2E
>>=20
>> The rationale for this split is that much code in QEMU is older and
>> was not written with malicious guests in mind, and we don't have the
>> resources to audit, fix and defend it=2E  So instead we inform users
>> about what the can in practice rely on as a security barrier, and
>> what they can't=2E
>>=20
>> We don't currently restrict the "virtualization use case" to any
>> particular set of machine types=2E  This means that we have effectively
>> barred ourselves from adding KVM support to any machine type that we
>> don't want to put into the "bugs are security issues" category, even
>> if it would be useful for users to be able to get better performance
>> with a trusted guest by enabling KVM=2E This seems an unnecessary
>> restriction, and in practice the set of machine types it makes
>> sense to use for untrusted-guest virtualization is quite small=2E
>>=20
>> Specifically, we would like to be able to enable the use of
>> KVM with the imx8 development board machine types, but we don't
>> want to commit ourselves to having to support those SoC models
>> and device models as part of QEMU's security boundary:
>> https://lore=2Ekernel=2Eorg/qemu-devel/20250629204851=2E1778-3-shentey@=
gmail=2Ecom/
>>=20
>> This patch updates the security policy to explicitly list the
>> machine types we consider to be useful for the "virtualization
>> use case"=2E
>
>This use-case sounds reasonable to me=2E I also imagine that
>some machines can get fixed down the road perhaps to
>the point where they enter the "virtualization use case"=2E
>
>However, since we are
>getting this elaborate, would my old idea of a runtime flag
>make sense now?
>
>To recap, the idea was to add a "-virt" flag that will
>block any machines, devices and so on not considered
>part of the "virtualization use case"=2E
>
>We could also create a mechanism for downstreams to
>tweak this as they see fit=2E

Hi Michael,

Thanks for confirming that the use case seems reasonable=2E

For now, we'd like to sharpen the term "virtualization use case" to allow =
for KVM to be usable in machines that aren't inside the security boundary a=
nd where maintenance commitment is unrealistic=2E The current approach is t=
o adjust the policy and to spell out the machines where these commitments a=
re made=2E

The trigger for this RFC was to be able to add KVM support to the imx8mp-e=
vk machine=2E I have it working but can't currently upstream it due to our =
policy=2E It asks for unreasonable work and commitment which adds an unjust=
ifyable burden on the maintainers=2E

I do see a need for further enhancements on the broader topic like adding =
a -virt switch etc=2E Maybe we should come up with a different term than "v=
irtualization use case" which appears to leave a lot of room for interpreta=
tion=2E I propose these topics to be addressed separately=2E

What is missing for your R-b?

Thanks,
Bernhard

>
>
>
>
>> This is an RFC partly to see if we have consensus that this change
>> makes sense, and partly because I was only able to identify the
>> machine types we want to cover for some of our target architectures=2E
>> If maintainers for the other architectures could clarify which
>> machine types work with KVM that would be helpful=2E
>>=20
>> Notes on the listed machine types:
>>=20
>> architectures I'm pretty sure about:
>>=20
>> aarch64:
>>  -- virt is definitely the only supported one
>> s390x:
>>  -- s390-ccw-virtio is the only machine type for this architecture
>> loongarch64:
>>  -- virt is the only machine type for this architecture
>>=20
>> architectures where I've made a guess:
>>=20
>> i386, x86_64:
>>  -- I have assumed that all machine types except the "experimental"
>>     x-remote are supported
>>=20
>> architectures I don't know:
>>=20
>> mips, mips64
>> riscv32, riscv64
>> ppc, ppc64
>>=20
>> Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>> ---
>>  docs/system/security=2Erst | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>=20
>> diff --git a/docs/system/security=2Erst b/docs/system/security=2Erst
>> index f2092c8768b=2E=2E395c2d7fb88 100644
>> --- a/docs/system/security=2Erst
>> +++ b/docs/system/security=2Erst
>> @@ -35,6 +35,34 @@ malicious:
>>  Bugs affecting these entities are evaluated on whether they can cause =
damage in
>>  real-world use cases and treated as security bugs if this is the case=
=2E
>> =20
>> +To be covered by this security support policy you must:
>> +
>> +- use a virtualization accelerator like KVM or HVF
>> +- use one of the machine types listed below
>> +
>> +It may be possible to use other machine types with a virtualization
>> +accelerator to provide improved performance with a trusted guest
>> +workload, but any machine type not listed here should not be
>> +considered to be providing guest isolation or security guarantees,
>> +and falls under the "non-virtualization use case"=2E
>> +
>> +Supported machine types for the virtualization use case, by target arc=
hitecture:
>> +
>> +aarch64
>> +  ``virt``
>> +i386, x86_64
>> +  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``, ``is=
apc``
>> +s390x
>> +  ``s390-ccw-virtio``
>> +loongarch64:
>> +  ``virt``
>> +ppc, ppc64:
>> +  TODO
>> +mips, mips64:
>> +  TODO
>> +riscv32, riscv64:
>> +  TODO
>> +
>>  Non-virtualization Use Case
>>  '''''''''''''''''''''''''''
>> =20
>> --=20
>> 2=2E43=2E0
>


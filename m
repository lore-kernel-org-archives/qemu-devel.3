Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED88C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 10:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYNPR-0008U4-ED; Mon, 29 Jul 2024 06:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYNPD-0008S6-9I
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 06:15:04 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYNPB-0000YC-9Y
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 06:15:02 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7abe5aa9d5so393660766b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722248099; x=1722852899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SVis92b7eBt0n3MfQrBQflb9Btq8/XJC0Xl/kDfWkuI=;
 b=OvyS6ozi/hUeoEGUc5gQWtxYTUPVOlWahXawVCeAiRksQ1TohL1X9coviidiyB9VfK
 Sr/lAtha2ybTd41+ZLluamHMsxdY1wh+6g0QTBuEHjYkxQi9/XGyQ5zRVR26lIy4G7kc
 WcKGYGnNlFeolKogUdIY9dB6WRloD09fKCJwhe5PD11ZQxkrNztltv/2rEMgXxT70YtF
 GOXcVJ2JdC9vdaXqFW41ntEXPwjwqSwDaZ04RLzmc+6metJpuFzwJDXu1NarWJYjmu07
 tzXQtvLjiVpgzEETfiRVVHnSqnBgzCmzR8ZYRKiaHIXSEWskEBT8NJNmY1nQBz0O9gjR
 XnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722248099; x=1722852899;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SVis92b7eBt0n3MfQrBQflb9Btq8/XJC0Xl/kDfWkuI=;
 b=itkuip+ASxy0UdPh8im3tJ4bj5iA4Ee2WrSFSGgGmj3DxPutAkYRJo792IoafsZ+rB
 CvV4Gy9OtV5WhdnK5AMmjLlyZ3E/CAACzDhBEE5cerxAI5uotrQRCz4uulvAm6X9Udg+
 ZkmvNZ0RG0m2fBj1SDkJ8pIvyKKpszcroZ0Pt4+k0+kAD2UriU7v7FznS4zoEkWFdDFc
 wXey8swxL0DYuOVRVXkJ0yKFXEkbZR8bSmmYb/5B03wtcxSNR2vprfr5dL3w5903QOnf
 sUzOUqvp4BovFwjf7v5RtbDqDSeorcP+aBZY1U6MP0nqLCaWRDHXjBOxNBL+RUmD2Uaf
 hk5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrMjrBuARZhoHRtw2M4/jsnR6Lj3MMD/e+RzZvKqwqzIcx0XrFQoatCd3Y7dlsZdJ/ZRqzYyFMwfQk6LVpTm8xBWcm310=
X-Gm-Message-State: AOJu0YwsT8Wy1ueIXTyxmR9nXv9eTSipLsWg6is8FM5DJ5NFLgCZieC5
 XdHgQBiunqz+Evl/wr25zcNo2ro9C0R5gfJL5LZ0UTk6TmkznchLmf1LfpCMNQM=
X-Google-Smtp-Source: AGHT+IG0OvMsP08uL78SuZ7w1oFldioo5KHUfd8K5ruBsuFjj498BcDSs/9LAF3e0KDh7IiyZIcU9w==
X-Received: by 2002:a17:907:3ea1:b0:a7a:a4be:2f92 with SMTP id
 a640c23a62f3a-a7d3ff55721mr559412766b.13.1722248099279; 
 Mon, 29 Jul 2024 03:14:59 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb8015sm486576966b.203.2024.07.29.03.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 03:14:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B80B85F844;
 Mon, 29 Jul 2024 11:14:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 darren@os.amperecomputing.com
Subject: Re: [PATCH] arm/kvm: add support for MTE
In-Reply-To: <0c171de4-a8ea-4859-b78c-272244267bb3@os.amperecomputing.com>
 (Ganapatrao Kulkarni's message of "Mon, 29 Jul 2024 15:07:51 +0530")
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
 <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
 <0c171de4-a8ea-4859-b78c-272244267bb3@os.amperecomputing.com>
Date: Mon, 29 Jul 2024 11:14:57 +0100
Message-ID: <8734ns1p3y.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> writes:

> Hi Peter,
>
>
> [Apologies for the delayed response]
>
> On 16-07-2024 09:15 pm, Peter Maydell wrote:
>> On Tue, 9 Jul 2024 at 07:05, Ganapatrao Kulkarni
>> <gankulkarni@os.amperecomputing.com> wrote:
>>>
>>> Extend the 'mte' property for the virt machine to cover KVM as
>>> well. For KVM, we don't allocate tag memory, but instead enable
>>> the capability.
>>>
>>> If MTE has been enabled, we need to disable migration, as we do not
>>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>>> off with KVM unless requested explicitly.
>>>
>>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>>> which broke TCG since it made the TCG -cpu max
>>> report the presence of MTE to the guest even if the board hadn't
>>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>>> then tried to use MTE QEMU would segfault accessing the
>>> non-existent tag RAM.
>>>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>> ---
>> In target/arm/cpu.c:arm_cpu_realizefn() there is this code:
>>      if (cpu_isar_feature(aa64_mte, cpu)) {
>>          /*
>>           * The architectural range of GM blocksize is 2-6, however qemu
>>           * doesn't support blocksize of 2 (see HELPER(ldgm)).
>>           */
>>          if (tcg_enabled()) {
>>              assert(cpu->gm_blocksize >=3D 3 && cpu->gm_blocksize <=3D 6=
);
>>          }
>> #ifndef CONFIG_USER_ONLY
>>          /*
>>           * If we do not have tag-memory provided by the machine,
>>           * reduce MTE support to instructions enabled at EL0.
>>           * This matches Cortex-A710 BROADCASTMTE input being LOW.
>>           */
>>          if (cpu->tag_memory =3D=3D NULL) {
>>              cpu->isar.id_aa64pfr1 =3D
>>                  FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>>          }
>> #endif
>>      }
>> With this patch, for KVM we will end up going through the
>> "squash ID_AA64PFR1_EL1.MTE to 1" codepath, because KVM doesn't
>> set cpu->tag_memory and this is still using that as its check.
>>=20
>
> I looked at this function and it seems we are not entering this
> function for KVM boot. I do see -DCONFIG_USER_ONLY added to make
> files.
>
> Also Linux kernel wont detect/enable MTE until unless the
> ID_AA64PFR1_EL1.MTE value is 2(b0010) and above.
>
>> More generally, how does the enabling of the MTE KVM cap
>> interact with the ID_AA64PFR1_EL1 value that we read from
>> the host in kvm_arm_get_host_cpu_features() ? We care that we
>> have the right ID register values because we use ID field
>> checks to determine whether the vcpu has a feature or not,
>> even in the KVM case.
>> Since Cornelia first wrote the patch this is based on, we've
>> landed gdbstub support for MTE (so gdb can find out which
>> addresses in the memory map have tags and read and write
>> those tags). So I think the KVM MTE support now also needs to
>> handle that. (See aarch64_cpu_register_gdb_commands() in
>> target/arm/gdbstub64.c.)
>
> Ok sure, I will go through this file to add/update MTE part

So to be clear the current MTE gdbstub support is linux-user only.
Gustavo has a series on the list that adds the system emulation part:

  Message-Id: <20240722160709.1677430-1-gustavo.romero@linaro.org>
  Date: Mon, 22 Jul 2024 16:07:05 +0000
  Subject: [PATCH 0/4] gdbstub: Add support for MTE in system mode
  From: Gustavo Romero <gustavo.romero@linaro.org>

which of course is focused on TCG. But if the KVM guests sync to the same
registers to cpregs I think most stuff should just work. However the
current code uses the TCG only:

  allocation_tag_mem_probe

which I guess needs a KVM equivalent to query the tag memory?

>
>
> Thanks,
> Ganapat

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A757D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 13:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhpPG-0001AA-8o; Mon, 19 Jan 2026 08:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vhpP5-00017V-19
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:34:47 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vhpP2-0007Xk-Np
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 08:34:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso28194835e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 05:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768829683; x=1769434483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66TYfErV6eSs8qKE2wURwFkJQVXktBsY/tk+9mOsrgE=;
 b=qPlsi1Kn2davSGV/3OQi+c8ROYsjdmd4mRoZpbvMFcYjQoJ2BHl12UpXVSgkLivim0
 KttIjEIYFJWkssso2k+u19pSuxI/K3PYFcr0EJg7BAI2w/TT1/G32amq6vMiXjF6kZ6t
 dJ+1cTA1fBuImxpjwhitKFBRpKxUhtrJXpFPw3vpd7d/NsH9KeETU2zbO4B8WlZHUHQN
 rv8WrmqA0ylDYY5U9KaBtCysJX322Dm4rraOp4h5R8Dp5e2/NGFM94t192F7h7qY3EJl
 zwqxr9bXbvtqNt43SYx/N0yra1YU5cx4fAYHOckC6Y2/ZTn6/XeFLkvKTvYAuuag2MaY
 STTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768829683; x=1769434483;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=66TYfErV6eSs8qKE2wURwFkJQVXktBsY/tk+9mOsrgE=;
 b=DHAB/sWyxXUjrW+e/lJWuOa+SfB1Ogt24mUJd5dBLeV/rLHnOZ08KJ6pokgT8eyCbS
 1TSmVjizj9oO/IExkB3Xu/UdjAVtjbsZW+k2cfD4hlbQHN0nUJbKvogbGRQa6vRhqe7O
 VWRJ0r4aBTxJ9F9RSKFq9FiX9Pd3I5CCK8+/dXuct1KuO5AlVHmMDAy3V9UkMATUKimc
 3iBj3TD8THjiNoeJklrssBMD5YI4bdCpcV0/0IUFGIpYdxHtjTBa6TidWTno8q4HXQav
 cJ0hkG7B++wLDAeoQ55nEHJOmUBHmYLIN63ciLVuX/37jy+vTgAKcsqeUhgnq20QRCmN
 QVCQ==
X-Gm-Message-State: AOJu0YxSDcQpShEF1R8xgOOvGJR82itsN9lHzFoUBAsolcx9tRFKkSC1
 8wIOIdQdjSe6jZ4np7HVGDjyLr1NHBliZIoHUeYAc0G4VnCnf33QFBVGxHe68wb7flI=
X-Gm-Gg: AY/fxX4/3o2hnJbVg3oMkaBirL9OP0jQANid/9uOH2HB/q/vxRLDQODBA3p1xNIlgwi
 1IumnSM00mmPKcpIs1btErV6Sz13iLNboYD7cfOq7EL1MiWP6ixm2v7jPQtWsNaA6TavJFFTeDZ
 GFqGn/Z5eKUmlLRxtR6FPx3cz2OdjKLaYK+tNXZ3b/IJMRrfYkupcKiob7Z/bNRxYivFQ1gvZrg
 AoLWu7aX8wjZoZFrQlLNdO7Nijcn/W9y0tkIpp9S4OAYN3+HUDOpfa/yzeDEOvi6as5mMQXKcdk
 rlDd/rCjFWnOsC4wltCA/q8+Tt4ylAH1+you2LxzghaDM7adVj5PMcrqBRHftAcxKy11RQkDV7w
 oV8i8WR+gVtn71rQm6R6pZfD+YA3DnlPVDjCXi46PqU1c4QZGzZaxt0XxxCyZDeogqjFNpurkzW
 bBrQnJALoQwLU=
X-Received: by 2002:a05:600c:458c:b0:476:4efc:8ed4 with SMTP id
 5b1f17b1804b1-4801e30d9famr127345675e9.11.1768829683099; 
 Mon, 19 Jan 2026 05:34:43 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926ff1sm22929824f8f.13.2026.01.19.05.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 05:34:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9D1BE5F87E;
 Mon, 19 Jan 2026 13:34:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  "open
 list:ARM cores" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH] hw/intc: avoid byte swap fiddling in gicv3 its path
In-Reply-To: <2d379a95-d3ec-4f6b-8b21-188540656019@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 19 Jan 2026 13:21:34
 +0100")
References: <20260119120030.2593993-1-alex.bennee@linaro.org>
 <2d379a95-d3ec-4f6b-8b21-188540656019@linaro.org>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Mon, 19 Jan 2026 13:34:41 +0000
Message-ID: <87o6mpsp3i.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 19/1/26 13:00, Alex Benn=C3=A9e wrote:
>> The GIC should always be a little-endian device as big-endian
>> behaviour is a function of the current CPU configuration not the
>> system as a whole. This allows us to keep the MSI data in plain host
>> order rather then potentially truncating with multiple byte swaps of
>> different sizes.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   hw/intc/arm_gicv3_its_common.c | 4 ++--
>>   hw/intc/arm_gicv3_its_kvm.c    | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>> diff --git a/hw/intc/arm_gicv3_its_common.c
>> b/hw/intc/arm_gicv3_its_common.c
>> index e946e3fb87b..60a5abd8d3e 100644
>> --- a/hw/intc/arm_gicv3_its_common.c
>> +++ b/hw/intc/arm_gicv3_its_common.c
>> @@ -81,7 +81,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque,=
 hwaddr offset,
>>       if (offset =3D=3D 0x0040 && ((size =3D=3D 2) || (size =3D=3D 4))) {
>>           GICv3ITSState *s =3D ARM_GICV3_ITS_COMMON(opaque);
>>           GICv3ITSCommonClass *c =3D ARM_GICV3_ITS_COMMON_GET_CLASS(s);
>> -        int ret =3D c->send_msi(s, le64_to_cpu(value), attrs.requester_=
id);
>> +        int ret =3D c->send_msi(s, value, attrs.requester_id);
>>             if (ret <=3D 0) {
>>               qemu_log_mask(LOG_GUEST_ERROR,
>> @@ -97,7 +97,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque,=
 hwaddr offset,
>>   static const MemoryRegionOps gicv3_its_trans_ops =3D {
>>       .read_with_attrs =3D gicv3_its_trans_read,
>>       .write_with_attrs =3D gicv3_its_trans_write,
>> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>>   };
>>     void gicv3_its_init_mmio(GICv3ITSState *s, const MemoryRegionOps
>> *ops,
>> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
>> index ae12d41eee1..a8d6d4fb540 100644
>> --- a/hw/intc/arm_gicv3_its_kvm.c
>> +++ b/hw/intc/arm_gicv3_its_kvm.c
>> @@ -58,7 +58,7 @@ static int kvm_its_send_msi(GICv3ITSState *s, uint32_t=
 value, uint16_t devid)
>>         msi.address_lo =3D extract64(s->gits_translater_gpa, 0, 32);
>>       msi.address_hi =3D extract64(s->gits_translater_gpa, 32, 32);
>> -    msi.data =3D le32_to_cpu(value);
>> +    msi.data =3D value;
>>       msi.flags =3D KVM_MSI_VALID_DEVID;
>>       msi.devid =3D devid;
>>       memset(msi.pad, 0, sizeof(msi.pad));
>
> Could we also clean the other GIC uses in the same patch?
>
> $ git grep DEVICE_NATIVE_ENDIAN hw/intc/arm_gic*
> hw/intc/arm_gic.c:2065:        .endianness =3D DEVICE_NATIVE_ENDIAN,
> hw/intc/arm_gic.c:2070:        .endianness =3D DEVICE_NATIVE_ENDIAN,
> hw/intc/arm_gic.c:2077:    .endianness =3D DEVICE_NATIVE_ENDIAN,
> hw/intc/arm_gic.c:2084:        .endianness =3D DEVICE_NATIVE_ENDIAN,
> hw/intc/arm_gic.c:2089:        .endianness =3D DEVICE_NATIVE_ENDIAN,
> hw/intc/arm_gic.c:2096:    .endianness =3D DEVICE_NATIVE_ENDIAN,
> hw/intc/arm_gicv3.c:420:        .endianness =3D DEVICE_NATIVE_ENDIAN,
> hw/intc/arm_gicv3.c:429:        .endianness =3D DEVICE_NATIVE_ENDIAN,
> hw/intc/arm_gicv3_its.c:1909:    .endianness =3D DEVICE_NATIVE_ENDIAN,
> hw/intc/arm_gicv3_its.c:1919:    .endianness =3D DEVICE_NATIVE_ENDIAN,
> hw/intc/arm_gicv3_its_common.c:100:    .endianness =3D DEVICE_NATIVE_ENDI=
AN,

I did look to see if we where doing any byte swaps but I forgot to check
the .endianness fields. I can re-spin.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


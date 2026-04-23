Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176E5FDEE46
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzrF-0005Fy-3W; Thu, 23 Apr 2026 15:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFzrA-0005Fc-Rk
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:37:00 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wFzr8-0006nf-L0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776973017; x=1777577817; i=deller@gmx.de;
 bh=a0kEmVWLLmJaZPWv41Qa5oi6Ct41T/emPeKIT8n3h5w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rfHovvCf4HcJt4q3N42Im/U548fiq5ZE4PbU+qQ2/vZuZFsYPE4SqfQ1IY26tkJk
 Yz/YryjCe+paNG5GnGmwln9HWFGCIZ/+0o2Yssizxq8nCQL+pvzxelzQnulwectik
 kPV+K27+jIQ73VIiIEtSakYFDY0FRrdg4uWJj8AOZGAEhwLJLJMhAwsqNYoqdnnFj
 iJEiODh+oJkc6Quoc9jERCwK/q7QBO35AdCMHQQ7zOL7Lenrc0eXaYej3638eGhi5
 4I0wUC9cdnnTscMts3rPuTMAwNsgJOaBeUmJZbbNYS5FWid9/yR15z8emEQAMeR/3
 f4nI6MX9Ss83njRXXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1vbw9C3gsE-00fIqg; Thu, 23
 Apr 2026 21:36:56 +0200
Message-ID: <35ffe929-9a02-4d6e-b9ad-45487b623e46@gmx.de>
Date: Thu, 23 Apr 2026 21:36:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] linux-user/mips: sync k0 TLS for
 EF_MIPS_MACH_OCTEON userlands
To: James Hilliard <james.hilliard1@gmail.com>
References: <20260410020012.98778-1-james.hilliard1@gmail.com>
 <00b95efa-81de-43e1-811a-0ca63fac4449@linaro.org>
Content-Language: en-US
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <00b95efa-81de-43e1-811a-0ca63fac4449@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u09nsaBY57YDP/z8bZBD3i0t2LKrFY/SbUUoJYuy5ENTSgpJ5if
 Mxm1f1wq+KdkyQ6Kk0fmy8AbtfFQCNgIb/1poAin2MlrOGO29az82C6KYv6oZtl8QXPUqj4
 FBMHb7FHAq41ayXO+8rE3vr6Pve+kWJ2mXSaQAHA+W2+awJ7OTet1MSVSfn3Nm4YctUZe89
 eX1gGyJ1hOWwGgYlSCBqg==
UI-OutboundReport: notjunk:1;M01:P0:pPQvomY14/Y=;yJVP3SKHBnktg69R9W53z8t24Si
 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
 UBF4hz0fCtvuaTwlbm1TJK9lJOA=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/10/26 04:10, Richard Henderson wrote:
> On 4/10/26 12:00, James Hilliard wrote:
>> Cavium Octeon userspace is not following a generic MIPS Linux TLS
>> ABI rule here. Older Octeon glibc uses the k0 register as the fast
>> thread pointer, while newer Octeon2 and Octeon3 glibc variants use
>> the normal rdhwr $29 path.
>>
>> linux-user already updates CP0_UserLocal for cpu_set_tls() and
>> TARGET_NR_set_thread_area, but it does not keep gpr[26]
>> synchronized. That leaves EF_MIPS_MACH_OCTEON userlands able to
>> complete set_thread_area() and still reach pthread startup or
>> pthread_self() with a stale k0 value.
>>
>> Use the existing MIPS ELF machine flags from linux-user/elfload.c and
>> mirror CP0_UserLocal into gpr[26] only for EF_MIPS_MACH_OCTEON.
>>
>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> ---
>> Changes v1 -> v2:
>> =C2=A0=C2=A0 - only enable on EF_MIPS_MACH_OCTEON
>> ---
>> =C2=A0 linux-user/elfload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 3 +++
>> =C2=A0 linux-user/mips/target_cpu.h | 5 +++++
>> =C2=A0 linux-user/qemu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 1 +
>> =C2=A0 linux-user/syscall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 +-
>> =C2=A0 4 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 59b543f740..0e757787d2 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -1476,6 +1476,9 @@ static void load_elf_image(const char *image_name=
, const ImageSource *src,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usual start for brk is after all sect=
ions of the main executable. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->brk =3D TARGET_PAGE_ALIGN(hiaddr +=
 load_bias);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->elf_flags =3D ehdr->e_flags;
>> +#ifdef TARGET_MIPS
>> +=C2=A0=C2=A0=C2=A0 info->use_k0_tls =3D (ehdr->e_flags & EF_MIPS_MACH)=
 =3D=3D EF_MIPS_MACH_OCTEON;
>> +#endif
>=20
> Note that we've just stored e_flags in info->elf_flags.
> Better placement for this is in mips/cpu_loop.c, init_main_thread.

James, would you please send an updated patch with the suggested change?

Thanks!
Helge

>=20
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
>=20
> r~
>=20



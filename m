Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B86C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKCc-0005m4-S1; Mon, 27 Jul 2026 08:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1woKCW-0005ln-7P
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:12:56 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1woKCT-0007NU-Hg
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785154367; x=1785759167; i=deller@gmx.de;
 bh=L/9N09cILSm9rkI3owGQH7tFaN7Lk6mmwynohtUQC34=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GQTsgbvCdk0IYWyeyKuSn1K1ztYCIPx554TXwoaaCJwu78M+eZ9C0yg/4eH9U4o0
 JZxvABchiwb5VDhCL+9bQ0wAIJOFN3vsFOlLR57Nq1aMnaWpkxuEVJfSsW7gmQH26
 Bnu5ko0sRu5XGaDYZOqS+aFHtzDyd4CWpgHkNY04l/tjDAi6GlzvmEIs20Jn9tm+A
 VrMWoujZhowpxrxhPY9iHevrhNeH/KyepwDcnL+bDanPMDKM6Rn7pTZLkJFhOADwa
 TM4vW8cWblVI832sP9xjNw7urOV3OB8ITGbkoLeFR9OULPSp4EIbLdDE7esmm9Ih1
 9ImhcSD6pHH2ejOkjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS9I-1xGXCP0BMg-00h3lc; Mon, 27
 Jul 2026 14:12:47 +0200
Message-ID: <f9e481ee-9d9a-46df-90ef-9eb9c1fdbd4b@gmx.de>
Date: Mon, 27 Jul 2026 14:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/sh4: allow full 32-bit address space
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20260727114848.1041856-1-laurent@vivier.eu>
 <cb98e6fd-d343-4c45-b4a8-78b92fef8d66@vivier.eu>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <cb98e6fd-d343-4c45-b4a8-78b92fef8d66@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UhZ1B8d0NQa6qs+oqhWKQmAqBCeePXya97VotrkJxiutHWGrJLT
 GmqL8/DhKBkmwEVOEJKJ08Wi3Kp9tqjn49Oz8STixfy275LdmfegcNjh1O3m4JjsTCuFkI/
 uZurhm0EbOlzqt/TBKbGpTtHRQUZiiiVazj499DhLx5IT/4F5RtLX0BwFXF9iRyZFT2SN9b
 ak9LFaJbQQSOQytRKfJYQ==
UI-OutboundReport: notjunk:1;M01:P0:sWgwCUKHkoY=;wCs3KORoIcH3uL0dRWGFmYhkY8h
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

On 7/27/26 13:56, Laurent Vivier wrote:
> Le 27/07/2026 =C3=A0 13:48, Laurent Vivier a =C3=A9crit=C2=A0:
>> On real SH4 hardware, the address space is split between user mode
>> (U0, 0x00000000-0x7fffffff) and kernel mode (P1-P4, 0x80000000-0xffffff=
ff),
>> so TARGET_VIRT_ADDR_SPACE_BITS was set to 31 for CONFIG_USER_ONLY.
>>
>> However, qemu-user does not emulate the MMU, so this limit is not neede=
d.
>> The only effect is to restrict reserved_va to 2 GB, causing OOM failure=
s
>> for memory-intensive builds (e.g. webkit2gtk on Debian sh4 buildds).
>>
>> Set TARGET_VIRT_ADDR_SPACE_BITS to 32 unconditionally, like most other
>> 32-bit targets. Also fix the TASK_UNMAPPED_BASE macro to use 1ull inste=
ad
>> of 1u to avoid undefined behavior when shifting by 32.
>>
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4093
>=20
>> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Helge Deller <deller@gmx.de>

>> ---
>> =C2=A0 linux-user/sh4/target_mman.h | 2 +-
>> =C2=A0 target/sh4/cpu-param.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +=
=2D----
>> =C2=A0 2 files changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/linux-user/sh4/target_mman.h b/linux-user/sh4/target_mman.=
h
>> index dd9016081e9f..2d05837c2f36 100644
>> --- a/linux-user/sh4/target_mman.h
>> +++ b/linux-user/sh4/target_mman.h
>> @@ -1,6 +1,6 @@
>> =C2=A0 /* arch/sh/include/asm/processor_32.h */
>> =C2=A0 #define TASK_UNMAPPED_BASE \
>> -=C2=A0=C2=A0=C2=A0 TARGET_PAGE_ALIGN((1u << TARGET_VIRT_ADDR_SPACE_BIT=
S) / 3)
>> +=C2=A0=C2=A0=C2=A0 TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_B=
ITS) / 3)
>> =C2=A0 /* arch/sh/include/asm/elf.h */
>> =C2=A0 #define ELF_ET_DYN_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (TAS=
K_UNMAPPED_BASE * 2)
>> diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
>> index c3b8114e538b..d95827078260 100644
>> --- a/target/sh4/cpu-param.h
>> +++ b/target/sh4/cpu-param.h
>> @@ -9,10 +9,6 @@
>> =C2=A0 #define SH4_CPU_PARAM_H
>> =C2=A0 #define TARGET_PAGE_BITS 12=C2=A0 /* 4k */
>> -#ifdef CONFIG_USER_ONLY
>> -# define TARGET_VIRT_ADDR_SPACE_BITS 31
>> -#else
>> -# define TARGET_VIRT_ADDR_SPACE_BITS 32
>> -#endif
>> +#define TARGET_VIRT_ADDR_SPACE_BITS 32
>> =C2=A0 #endif
>=20
>=20



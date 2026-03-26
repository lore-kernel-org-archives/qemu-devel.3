Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA8910A62FE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5m15-00014V-Md; Thu, 26 Mar 2026 10:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w5m14-00014N-7C
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:48:58 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w5m0y-0004ON-B2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774536527; x=1775141327; i=deller@gmx.de;
 bh=vqy2jDXur7cZhbbAzNCWoje+1x69PhTjcMC0Sro5aF0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Y4KOIPe/S2QzjFvCIeyshk0nlHCvwnuMnbmCHfuvZPlSK+CnG/s0tK7nDGcVzBL6
 Ry1NYP1H4YRWTLQi4sGCe6GNScRNAWH+nXLgCb131IFH5m7/bZXZccj07SWnFVpeJ
 5YXI6/Xz+r0l1yykLdmQ35OrEwcV1YyGsWrS3Roqvef+dEgW+0DTjyWGAiuqtBD/5
 nOHpZ0/Yogz1SNnqwLIIwY412mhn6/Q0jyzwsrLqRHYJSC/nTDtHKuljQdJvI3wXH
 QJ7ikh33JUyKfRWghT+ZtstnQvg4gAXR6rkJL538HTEwMTXLqk2A/UnBspQS1b/nQ
 rhpmZVK9GGXZg62x3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1vq2PX3azB-00TCqd; Thu, 26
 Mar 2026 15:48:46 +0100
Message-ID: <046420c8-63e4-4113-b33e-7b8c070af5da@gmx.de>
Date: Thu, 26 Mar 2026 15:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix name_to_handle_at when
 AT_HANDLE_MNT_ID_UNIQUE flag is set
To: Clayton Craft <craftyguy@postmarketos.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260325-fix-name-to-handle-at-v1-1-49fb922e6fd3@craftyguy.net>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260325-fix-name-to-handle-at-v1-1-49fb922e6fd3@craftyguy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m3imTc15X9DpjnE1MVxSkKOapPyCK4TIdZ8YLT0VYYrf0g9z4UX
 AQhSbOLzs90fezETiZieH9KgKlC3XP99FuoR/dPxJ7klXSxdO9AxT8fV2rFa0bOBkuEx7tj
 BTSXYRGD84dom3qzU2cooNNBn7jkOM8LSzxMGHyaPDNibEEmdGzBUJ4YLPgeoaZ1lWx1v9V
 Y5LTJrb3SO57uHswogQBQ==
UI-OutboundReport: notjunk:1;M01:P0:a2xPM4Kp0m8=;XaGxcr4Y7evSCVDxUyPIQQGDdrR
 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
 g2
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/26/26 06:59, Clayton Craft wrote:
> Linux 6.12 added AT_HANDLE_MNT_ID_UNIQUE, which indicates that mount_id
> is 64-bits. If name_to_handle_at is called with this flag set then qemu
> passes a 4 byte int to the kernel, which then tries to store 8 bytes in
> a 4 byte variable, causing a SIGSEGV[1][2].
>=20
> This stores mount_id in a 64-bit var if the flag is set.
>=20
> 1. https://gitlab.postmarketos.org/postmarketOS/pmaports/-/work_items/44=
31
> 2. https://github.com/systemd/systemd/issues/41279
>=20
> Signed-off-by: Clayton Craft <craftyguy@postmarketos.org>

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

> ---
> This fixes a crash experienced recently while running qemu user mode
> with e.g. systemd which set AT_HANDLE_MNT_ID_UNIQUE when calling
> name_to_handle_at. AT_HANDLE_MNT_ID_UNIQUE was added in Linux 6.12.
>=20
> I'm a bit unsure of defining AT_HANDLE_MNT_ID_UNIQUE like this,
> it's part of linux/fcntl.h but this header isn't included in
> qemu/linux-headers.
>=20
> 1. https://gitlab.postmarketos.org/postmarketOS/pmaports/-/work_items/44=
31
> 2. https://github.com/systemd/systemd/issues/41279
> ---
>   linux-user/syscall.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7832a1aba5..3cb00c643e 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8166,6 +8166,9 @@ static int do_futex(CPUState *cpu, bool time64, ta=
rget_ulong uaddr,
>   #endif
>  =20
>   #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HAN=
DLE)
> +#ifndef AT_HANDLE_MNT_ID_UNIQUE
> +#define AT_HANDLE_MNT_ID_UNIQUE 0x001
> +#endif
>   static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname=
,
>                                        abi_long handle, abi_long mount_i=
d,
>                                        abi_long flags)
> @@ -8173,6 +8176,7 @@ static abi_long do_name_to_handle_at(abi_long dirf=
d, abi_long pathname,
>       struct file_handle *target_fh;
>       struct file_handle *fh;
>       int mid =3D 0;
> +    uint64_t mid64 =3D 0;
>       abi_long ret;
>       char *name;
>       unsigned int size, total_size;
> @@ -8196,7 +8200,12 @@ static abi_long do_name_to_handle_at(abi_long dir=
fd, abi_long pathname,
>       fh =3D g_malloc0(total_size);
>       fh->handle_bytes =3D size;
>  =20
> -    ret =3D get_errno(name_to_handle_at(dirfd, path(name), fh, &mid, fl=
ags));
> +    if (flags & AT_HANDLE_MNT_ID_UNIQUE) {
> +        ret =3D get_errno(name_to_handle_at(dirfd, path(name), fh,
> +                                          (int *)&mid64, flags));
> +    } else {
> +        ret =3D get_errno(name_to_handle_at(dirfd, path(name), fh, &mid=
, flags));
> +    }
>       unlock_user(name, pathname, 0);
>  =20
>       /* man name_to_handle_at(2):
> @@ -8210,8 +8219,14 @@ static abi_long do_name_to_handle_at(abi_long dir=
fd, abi_long pathname,
>       g_free(fh);
>       unlock_user(target_fh, handle, total_size);
>  =20
> -    if (put_user_s32(mid, mount_id)) {
> -        return -TARGET_EFAULT;
> +    if (flags & AT_HANDLE_MNT_ID_UNIQUE) {
> +        if (put_user_u64(mid64, mount_id)) {
> +            return -TARGET_EFAULT;
> +        }
> +    } else {
> +        if (put_user_s32(mid, mount_id)) {
> +            return -TARGET_EFAULT;
> +        }
>       }
>  =20
>       return ret;
>=20
> ---
> base-commit: 007b29752ed06e467d3c830bc2c17a8851f8bcd3
> change-id: 20260325-fix-name-to-handle-at-02208f294e88
>=20
> Best regards,



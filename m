Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34215606A6B3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=eVXkMKE6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUYF7-0004cQ-Je; Fri, 20 Nov 2026 18:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xUYF6-0004cA-Tx
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 18:42:08 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xUYF4-0004Vd-Rt
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 18:42:08 -0500
DKIM2-Signature: i=1; m=1; t=1795218125; mf=PGRlbGxlckBnbXguZGU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=gmx.de;
 s=s31663417:rsa-sha256:JNcDDGNkSO+P6CAa7InxfeVpKc45
 yM9BVfGQaNOdfDpeIqxGM65adrLg7uyWFon34dKlBFVWLIe3sX51iCgGIjRijfCXuH7/9WVFVbC
 +kqtu8DMMoygGxM8sPZ/LCLgQnr63JoxcCn8Df4jNO859Fq8k9PXvYaY338v2WFqklemfuTJ+pZ
 RxDEwgsfO9L22u8luiVN9yrCuG6Qv1FlyeUS8Y5RYpFz+Un8gcvtUuMyBzf38K/wzShckPLF1ta
 sSxi9ByVR/ZuHAuWHGO+ndGorUVzPCsj8EYtvp2GDjPM7+jqRFx4l6/Is66mISSx9menhFStA2q
 4+nvOCPhRI/ybw==;
Message-Instance: m=1; h=sha256: VK/26h5YNd3kHwHiwxo7u0GZ4PxZpdiYz3QDPeaXAuw=:
 R9kZbFbWpIeSG7KNAILn5fVK0btDCg+c93ezCAii/HU=, sha512:
 e6IE+IdFzLwG3M1yqur+LR0q2U0fUB94SWX4q4Y3OogC0XhizasToIH0xZ+Ab+2HSS+f2g+yPNDi+u6S7uwTBQ==:
 hVnK2AoLincTOdauAVWIToV+Ul5W73cv2HmpE6kyCLVQ/AIMFl963qAWK/l+srVloGtHwG8dKlLlCfk/kQ6AUg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795218122; x=1795822922; i=deller@gmx.de;
 bh=y8Z5LMyvnaxAoJx42R1lUxkAGuVStyJ5J7uOetsXqio=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eVXkMKE6UM4pcCdlI/32F3F6tk6Qx8v4L8oVOIqri7CFRqie8cDt1wjTACw+dC0o
 NVngC7hg0rn+4rtpG8xe4jri+aFqkY/ifE+VmOF/Cj/Gx7uPU8xuQiLoYu/SrSnt0
 DoVH5VS1RR28osrV1vnvzAGhSSs8/Vd82b1oVAfHUalVybaxT4j5mD2O9FJAth1W1
 e6PV14nX7BXbUHF1SCRUsm4PFKmq+vmNOY8/TZMGL2J7X238jMBmAGRbkYh6piKQo
 vdXdoVtBVyTfAfT8NC8wG4ybBwQw4ttDGMfI/YWdvslFOosHPq8+n9OAWkS0gMYxg
 k8nZcw9uRNlbA31KcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNNy-1xzqTw0iRu-00Wy9a; Sat, 21
 Nov 2026 00:42:02 +0100
Message-ID: <d48a6e69-a07b-4dda-98d0-2bfe0194839a@gmx.de>
Date: Sat, 21 Nov 2026 00:41:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] linux-user: do not emulate PI futexes given
 endianness mismatch
To: =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20261119191247.391446-1-pobrn@protonmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261119191247.391446-1-pobrn@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WzhRyoYlscLltZFZCcCbmMan42SkrTVg4lYF3Uao3mZ7Gd3Ezo/
 dP9oatH5IMJfbjdH25qUoMKnZTgBt1EF5zldSmuzZWNndY33vyaV65DPcu6MZI+z9Wga4dW
 RKwrmLrGxjEeNRmli5qnJNzjUfEXCejdqsIGHu7Uw750whAUQGXoXsEHzRNIZTlYoo8TyUW
 3hYQ2mLp6mEx+Ag/RXygQ==
UI-OutboundReport: notjunk:1;M01:P0:v0E6Zlu7rMI=;l1AJJrjfZ+cyj7Ktv19Qx58o/kP
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 20:12, Barnab=C3=A1s P=C5=91cze wrote:
> For PI futexes, the futex word is expected to contain the thread id in n=
ative
> byte order. And failing to emulate that leads to issues as e.g. glibc do=
es
> not expect `ESRCH` to be returned from a `FUTEX_LOCK_PI` operation.
>=20
> If the mutex is set to be "robust", then this is detected as unrecoverab=
le
> failure and glibc aborts (since a robust mutex should've been unlocked b=
y
> the kernel when the owner dies):
>=20
>    Fatal glibc error: pthread_mutex_lock.c:450 (__pthread_mutex_lock_ful=
l): assertion failed: e !=3D ESRCH || !robust
>    qemu: uncaught target signal 6 (Aborted) - core dumped
>    Aborted (core dumped)
>=20
> Since `FUTEX_LOCK_PI{,2}` cannot be easily emulated when the host and ta=
rget
> endianness differs, do not handle them, and return `ENOSYS`.=20

Your patch seems correct, but that makes me wonder if it makes sense to
propose a kernel patch (and additional qemu patch) for
FUTEX_LOCK_PI3
and
FUTEX_CMP_REQUEUE_PI3:
where the thread id is always stored in little endian format?
That way emulation is possible (I think so), and little endian format
since nowadays all major architectures run little endian. That way only
the big endian arches suffer a little, but have the benefit to be able
to be emulated on any arch.

Thoughts?

Helge

> This allows
> e.g. glibc to detect that they do not work and handle things accordingly=
.
>=20
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4911
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> ---
>   linux-user/syscall.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 2fc61b3eab..c5fbd30e28 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8243,6 +8243,7 @@ static int do_futex(CPUState *cpu, bool time64, ta=
rget_ulong uaddr,
>       case FUTEX_WAIT_BITSET:
>           val =3D tswap32(val);
>           break;
> +#if HOST_BIG_ENDIAN =3D=3D TARGET_BIG_ENDIAN
>       case FUTEX_WAIT_REQUEUE_PI:
>           val =3D tswap32(val);
>           haddr2 =3D g2h(cpu, uaddr2);
> @@ -8250,10 +8251,11 @@ static int do_futex(CPUState *cpu, bool time64, =
target_ulong uaddr,
>       case FUTEX_LOCK_PI:
>       case FUTEX_LOCK_PI2:
>           break;
> -    case FUTEX_WAKE:
> -    case FUTEX_WAKE_BITSET:
>       case FUTEX_TRYLOCK_PI:
>       case FUTEX_UNLOCK_PI:
> +#endif
> +    case FUTEX_WAKE:
> +    case FUTEX_WAKE_BITSET:
>           timeout =3D 0;
>           break;
>       case FUTEX_FD:
> @@ -8261,7 +8263,9 @@ static int do_futex(CPUState *cpu, bool time64, ta=
rget_ulong uaddr,
>           timeout =3D 0;
>           break;
>       case FUTEX_CMP_REQUEUE:
> +#if HOST_BIG_ENDIAN =3D=3D TARGET_BIG_ENDIAN
>       case FUTEX_CMP_REQUEUE_PI:
> +#endif
>           val3 =3D tswap32(val3);
>           /* fall through */
>       case FUTEX_REQUEUE:



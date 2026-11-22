Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F947606A32A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=rwui/gl5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV8tV-0007yr-Hb; Sun, 22 Nov 2026 09:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xV8tP-0007xP-Bb
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 09:50:11 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xV8tN-0001V7-9B
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 09:50:10 -0500
DKIM2-Signature: i=1; m=1; t=1795359003; mf=PGRlbGxlckBnbXguZGU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=gmx.de;
 s=s31663417:rsa-sha256:XOiB0lWBrbn7D9q9ZCy4Ymas20xd
 sXyPTSN5JsfvsxbzzjXTtJlw72t8v0kvwAUDn3Dcx9LqEHz6x7BNdDM0WeVyHJ0yH6DfpwXeK+3
 VWNIe87FRBoN0pV5IFyUWtlhTa6KLWYEO0LQrdSaMZCwRj0P5eKw2Cn2AE+wHy++ovPHrL1IGnJ
 4NpKNqvqGhsM4dh+6c91lOpu7j70epiQVVq5Oulsl3AS//SUxyLglWZx2fkZx786E735NyZQJ7A
 6rOpC6Z3k+gqamjT+QfhCJ0D/g6UBxINV/OQaDlMI3svl1zjYIdV26u7bbkgex8PnImelnw5SGF
 /tMj06KJGuft8Q==;
Message-Instance: m=1; h=sha256: 1Bi05ZaG4h9krp/fj3GWyUJ+WUoypBm8+dd4pP4XLpw=:
 0hHyEle4zg1cf9EyuTeu5Aor8qyWcOPE8/R4UidRX30=, sha512:
 aKpUxkDRaHWnJilrWUlTUgcPvxllMABD9jOEhW0XYdWwld2pFcKpdvFrP75n5y7CgNbIMppKpv4k0ATlwnrMnw==:
 qXc2V1NxV2mpL8OiNx1/5BpW0jErDFUMy7iOQrVOS3GKYV3pZjrfAWTVleXhaaHZ3MvrFBYhxXkr6KW+5/J3Ig==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795359000; x=1795963800; i=deller@gmx.de;
 bh=hXO3pVL1k16qJm7TE1eavO8YGH3UTGtPJUSYgsz36Jk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rwui/gl5pHT39fPWYYHqZDc3VxstMRnwdmw1IMQ9i1C43WFNmzFsINImLz5kzpft
 a1x+84LxMnSEntiQwb4xwFtmpFLPNHhEBOs2idCAHcLCehvp1eCrWjf99TqLU36it
 O6Y28FjGm9PhDUAu87k5UfN7uqQCKuJClzQlCLl4mTt7Xj37fGg9gRO4I6SkdHC1G
 GrM7Gbhb4D6rQmugbdWjZ77K+j0G/WsAH22ljTFOrTPM8dF9i97r10EgOH8aH280R
 DtJFXWExKR+CuY1KCPPnPhTlcnY1JE5AZGq4dCAG4lXfTU2ynioPnae2YIMiB++Ec
 GYdrAojNc3irUUuwLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3siA-1yUyoy11rE-017W5q; Sun, 22
 Nov 2026 15:50:00 +0100
Message-ID: <2810afa2-4f26-49d9-ba01-a85398b84839@gmx.de>
Date: Sun, 22 Nov 2026 15:49:58 +0100
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
X-Provags-ID: V03:K1:AbFXnXmgC21rRNrX/7UV95sA1Vo5oNmijTvVyjOVnzOae2UkK4f
 Oui883o5KL6Pi3WXHIvxBMgHdl9/S/nbdeNKCCIDf2EzuaRE7j8F+VzamBy21jYwvP+pHTg
 PyrlprCvAlZvAuuiy5WSO6IY6m6YWFFGAzZb5XNQHr/zo5nWLENZ9uifNKmktOEN//i73Us
 tCSOIIIYStWGejYbNlAyw==
UI-OutboundReport: notjunk:1;M01:P0:GUFkudff6Ec=;UV97se25jOjpnd8bIcUkaIuy4XH
 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
 lx/xxpM2dw==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
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
> endianness differs, do not handle them, and return `ENOSYS`. This allows
> e.g. glibc to detect that they do not work and handle things accordingly=
.
>=20
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/4911
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> ---
>   linux-user/syscall.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de> # on big-endian hppa guest

I've applied this patch to the linux-user-next git tree.

Thanks!
Helge


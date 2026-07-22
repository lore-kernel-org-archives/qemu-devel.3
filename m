Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E971C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVWC-0001UC-6D; Wed, 22 Jul 2026 07:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1wmVW8-0001RG-Px
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:53:40 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1wmVW7-0002ox-3v
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1784721208; x=1785326008; i=laurent@vivier.eu;
 bh=4ypxNAeMrYtOM4i1sQQs1MwdbcJg18gJPpwj+tjZiYw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EYrb85BAoxsTbPbI/FLxIsTnCFEdO1ZzqFf3YJqPixjEdSCf4krbvwOXMLTvJZDF
 +/Na6sDpSVInGSw6LttNHS2g3VMgynJNWlMdEtoAqRqGwOqFDet0+7D8PFznM9Uq8
 0HITnF4rS7Tryvm7wMyA0ycR5gqXqdk0dZj6b1WErNz+zuw7i9SzvcdHRD5ERnpcS
 P3wqCTdxFDkxt3VIxQmNpcQEvxfjp1/HCxUbldGPtoFfJz2+TkCFv5tdiE/fRcJ3n
 QQW+XvUwl/o7R6cXO03ZP8Dj/84VIw2kqkyTWji1AYPECXx47o+07qdxH9j8O+Uae
 LsOHdu6NMqcWopu5YQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [213.165.67.103]) with ESMTPSA (Nemesis) id 1N8onW-1x1GT02j9a-012S1A; Wed, 22
 Jul 2026 13:53:28 +0200
Message-ID: <f61f4efd-9b71-497a-89f0-9a17066fa917@vivier.eu>
Date: Wed, 22 Jul 2026 13:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Remove local FUTEX_CMD_MASK definition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260722083253.528442-1-clg@redhat.com>
Content-Language: en-US
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20260722083253.528442-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0an04Cei65jyImafvugLSROdF9CkwD2IeewCT9cGAR+7x5x9KcQ
 2wrhBHpL3Moc8y5qFD5GhD44mHLuP6RR6z0zNFXcNt+35NULbQ+zPa/Ptg45os5NdIonrbV
 +bAyCfpa4WNmVRYrtETHCItf9KKmIJW/r5rx9hlg7odWBPnN1EN+78qh05yBl/8AkmPeJ3o
 3ikDFJKKoYb6WvGnn5O+g==
UI-OutboundReport: notjunk:1;M01:P0:2oi8h1qGLbI=;hNzob1WztPur3ZPekiLZgJfFnj3
 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
Received-SPF: pass client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

On 7/22/26 10:32, C=C3=A9dric Le Goater wrote:
> Building linux-user on a host with Linux 7.2 kernel headers fails with
> a macro redefinition error for FUTEX_CMD_MASK. The kernel commit
> 3ca9595d9fb6 ("futex: Add support for unlocking robust futexes")
> expanded the mask to include the new FUTEX_ROBUST_UNLOCK and
> FUTEX_ROBUST_LIST32 flags, which conflicts with QEMU's local
> definition.
>=20
> Since the host FUTEX_CMD_MASK is always available, remove the local
> copy.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>   linux-user/syscall_defs.h | 1 -
>   1 file changed, 1 deletion(-)
>=20
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 5799769f832fd953fe731a33ad7746113dff9957..c17013beac6f6b6407290c31=
8310b7bb820c590b 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2593,7 +2593,6 @@ struct target_drm_i915_getparam {
>  =20
>   #define FUTEX_PRIVATE_FLAG      128
>   #define FUTEX_CLOCK_REALTIME    256
> -#define FUTEX_CMD_MASK          ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REAL=
TIME)

To build with older kernel, I think we need to have:

#ifndef FUTEX_CMD_MASK
#define FUTEX_CMD_MASK          ~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIM=
E)
#endif

Thanks,
Laurent
>  =20
>   #if defined(TARGET_X86_64)
>   #define TARGET_EPOLL_PACKED QEMU_PACKED



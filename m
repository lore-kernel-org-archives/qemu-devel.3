Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BF0FC6175
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 15:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc39z-0002ma-Nk; Sat, 03 Jan 2026 10:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vc39x-0002e5-RX
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 10:03:18 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vc39v-0002uI-Vb
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 10:03:17 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so83211765e9.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767452594; x=1768057394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeZj2ZQtdY8FAoWlI5KwKq/STWOdIJp4CZfl0pH4btA=;
 b=STKgEPOpuvcYWlLvTGoLT7t05+R+AR+CeIrdLa4Y2SGRM5ZTusllFJFAZY05fJaPYg
 oMNDAMl/belpe+dLRppNcZwQKD7zER8xMJLhk85jdcisT+mvVYB0PUDyaKiKgU1DdEwr
 Mzfn+hr2oDqmEJUlHDo9TtsMnu84Co/JzyDWhBxyvWgecrUxzSE7XeDmZtzStLpZNVM0
 qXWoMepkMhYotkxygkbrlhpwXE2QT01AEi2aIIUyN4EU32ul9J4z1LzETuSOQ/deCVCd
 6hTUROJQ9nxullv7UMQGhFpalH8X/Fdfc77tiUAH8CtL94ZN6KQF6jAOzTriqXfwwTFL
 ykZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767452594; x=1768057394;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UeZj2ZQtdY8FAoWlI5KwKq/STWOdIJp4CZfl0pH4btA=;
 b=L8KEVaJBQfBiYQbwlV0yiQGUuaIfQ5jZsRCjJ8YdJe9AoZ9MR34EUEjPzIF/xgqwZG
 8YR64U4SobNv9NFn2xGAN0B2CdZoUj5KSTn2yd38uiRpKztyOBlNKhbWnQTP8J8NbILx
 GMIU/uYakNJugzR8WXBsdiw0Ud7NjJV8pvPXu8kYjt2aALB2sOf9DtHzwQsTjXYa1KOM
 3pcVS11aLpVS44779PCej5Du91Z65KdVMXEFmk/E5fAbM22w7RRco/e4j/vx0TBpvqNj
 gAP0B8xYS9iXBOzi3k7JB+YB65Tn9lvvrsAXzCwxbbPg1BZGyqmKO2vvsOQwh8cE1Syz
 JtWg==
X-Gm-Message-State: AOJu0YyddvTBQN3jb7bHTzlz+DEwKyeY1KKrXEcxpILy376HIJx5QJna
 nnR1uSD4Xws4sXeg0cbOXW6vksbJ8z2ARKOmh21FzPoDVmH/nEhzMPqV2Ou0mifcHw4=
X-Gm-Gg: AY/fxX6AWcuctOERnsw5o1avw68vH7o8HlXBkbDW4dp41Syk4u1AQxl7q0krL0uy3Tn
 Qgj/2+6evgRFQNu4BNf3687P4eYeuI+GoGqV64igW8oeF5HLqD88px7Bk8SZmZvQH4htlkFfmg0
 ImqblGWMVD3YPknXCN5BA5Z0DOZn1372GRzwJ/FNK0hHBY/eIcrtTkUh/4pYUsbTnvX9yRTBT4J
 NdlItYXPXd37xNuXXwAyTnZGm2aC/64mNYT3tSc8ieHoO5RdEMQ/nHhpunsIRzv4DF3Qi1fpCqw
 0Aa0fO+LrRSYliL9fphFNa9lFv/N2fRQFyiWf/CGWSi0PZTSQ1l1sUkua3rJ1a1F/AS7EuF2Dqd
 ACzqfZeqlhqaJv3QYDmMxltYjcHfhgRp1AFVaKeVBa21yoKzX3o+c/pYNzM5El0GYqt/I9pxYyQ
 JwDOdxrDIkuiU=
X-Google-Smtp-Source: AGHT+IEQx57yfi11Kh20XcGH2IfFWJY38ZYL3kJFIdBSn5xAJIMgdtrIxlzB+GnSXdmL17acJgK6yA==
X-Received: by 2002:a05:600c:154b:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-47d1958fd40mr518129635e9.29.1767452593639; 
 Sat, 03 Jan 2026 07:03:13 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d13ed0asm43115965e9.3.2026.01.03.07.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jan 2026 07:03:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 197745F7FE;
 Sat, 03 Jan 2026 15:03:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH] docs/system/igvm.rst: Update external link
In-Reply-To: <20251230-igvm-documentation-fix-v1-1-865750a66cc8@linaro.org>
 (Jim MacArthur's message of "Tue, 30 Dec 2025 19:23:33 +0000")
References: <20251230-igvm-documentation-fix-v1-1-865750a66cc8@linaro.org>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Sat, 03 Jan 2026 15:03:07 +0000
Message-ID: <87h5t268no.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> Also updated revision to 3.43.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3247
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> Just fixes a broken link for the AMD64 Architecture Programmer's
> Manual.
> ---
>  docs/system/igvm.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
> index 79508d9588..f45eb1707e 100644
> --- a/docs/system/igvm.rst
> +++ b/docs/system/igvm.rst
> @@ -166,8 +166,8 @@ References
>  ----------
>=20=20
>  [1] AMD64 Architecture Programmer's Manual, Volume 2: System Programming
> -  Rev 3.41
> -  https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/p=
rogrammer-references/24593.pdf
> +  Rev 3.43
> +  https://docs.amd.com/v/u/en-US/24593_3.43
>=20=20
>  [2] ``buildigvm`` - A tool to build example IGVM files containing OVMF f=
irmware
>    https://github.com/roy-hopkins/buildigvm
> \ No newline at end of file
>
> ---
> base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
> change-id: 20251230-igvm-documentation-fix-6a937c2cb9fc
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


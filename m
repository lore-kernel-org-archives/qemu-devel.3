Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFB9CD6E57
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUTz6-0005as-Cq; Tue, 02 Jun 2026 14:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wUTz4-0005ah-Tk
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 14:37:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wUTz3-0006fe-D8
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 14:37:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490686877a1so71740475e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780425419; x=1781030219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kxF4A+GXKZmqgJ9pZmjzQvPsjyAQj4zfGvX9UoeWl8=;
 b=JQLEg6EP/WguAtlPfU9UYCJuieTvg1fuJoJRihV8vTr/klDwfIGRxbyZ2Ap/suFJBx
 ZV/l3a3ozrokwHDuqBAtfMVs9BhRv6D2yCYKeEgFwdhlI3Fhn9Vvm9apRc6i0qcDXd2s
 ct8TEASQsjkKVbJ00l+RwHYUAqz0xj7fFJkkowMnzu6WuHgj2IFb4tEpuTN6FG8SVdWr
 4L9ERlrKwxEo1pzjh1bAqTkosxfa8dJx+WUbsvc8dNlcCHyggmBW9xN/wHYTZh95OGEU
 v925yqDe96op/e99J7Zs4RNgaPrCfz6AqRS/MY2XugA7G+X13FMyKuPiPbxjc14KL648
 37TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780425419; x=1781030219;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4kxF4A+GXKZmqgJ9pZmjzQvPsjyAQj4zfGvX9UoeWl8=;
 b=pBW07l/qnI2ZWSHo3GqAOWyBtaG6TRzj45e20Qs8eopK9V7TAH9moYuvrMUyiDc/4F
 JXQqOx3CSd3vk0IhPT66zwb0IGEJJZ8Ky09aNuEfh0Uh+KuEl3dtpRpqBYymX3P9Vj4a
 pYNSg0L28pkdaJxtRYRkXeeSyMMCksNdGJPvF+hEL66YzQh316X2IYGHC7Y6Ew70MQN9
 1n5coOtv1Um8dNu4ax49PmwN7gqL6TPNEWZe1NoHVj3TBSbewW/BdUkXsgcSbd9y43Kq
 2QiL/gj2Q8SMzOPmOlLnQB4hLbLkAz9y2TpCtdAkf0mpzBIdOMKThaiX1D3biX0I7f1u
 v5TA==
X-Gm-Message-State: AOJu0YyXjSnVmB1Dfiq4pHmqSO4pu9jaSbR1+jorBXdP8flSTzUY5JWA
 cEpf7geAQmodErIe4z+Fr6It8iFZlytGpPr/4Lyl5WLHDtmiDnVpo2CyYmgi5Q/sPcI=
X-Gm-Gg: Acq92OEUJXg3TKDV7K3sIi8H9jZr6PdaIKttuoq9aHU8uiZ6xYTVqFk5bC2aOhrNYte
 nla+7UKowaDyuBI4s2pAkxBXV7b1tQaJ0M3scKhylQaWP6xIg3pfrbjsHe1lSMUmUQb0o26WnTQ
 DBtT+zn6a/XwgYmzeUIojGX375lu4+9FynvRHI7NP2skT+FKyeLyFv22l97bKN3N/7+8+Y08OZN
 GhWVVJF8pZ+CBLs8r5L18S3d42omEU8zjFTjQMKpmXoTD/EKndgu6QktUd8kisZ1sHUXuG5WIu8
 s1IcaUquZP15S+z8gpDfllsh8AG3MrFGHKr35IaPsi5xpMA3QGgqC7X1208upaa3FMaghy8Vv5s
 /YC3mhaJEXlLmhlWP9ouWh4GXYok3d0Mzn68REFmRoobzN21xyUfYm6T3SwkC+H9zg2F3h5pTZf
 CSwUcON4jWfAhidzhNFnm+2OJDDH2wilLeLA==
X-Received: by 2002:a05:600c:6290:b0:490:ad1e:1846 with SMTP id
 5b1f17b1804b1-490b575348cmr6136995e9.9.1780425418875; 
 Tue, 02 Jun 2026 11:36:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b575ad77sm1678015e9.17.2026.06.02.11.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 11:36:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9F7E55F7F7;
 Tue, 02 Jun 2026 19:36:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Li-Wen Hsu <lwhsu@freebsd.org>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@mailo.com>,  Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: remove stale Cirrus macOS build job path
In-Reply-To: <20260602162457.828969-4-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Tue, 2 Jun 2026 12:24:56 -0400")
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-4-stefanha@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 02 Jun 2026 19:36:56 +0100
Message-ID: <87ik80vlfb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Commit 984b192bdf37 ("ci: drop cirrus MacOS build") removed the Cirrus
> macOS build job. The MAINTAINERS file now contains a stale path that
> should be removed.
>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ff33eb630..0c0c8c0a37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -701,7 +701,6 @@ F: scripts/nsis.py
>  Darwin (macOS, iOS)
>  M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
>  S: Odd Fixes
> -F: .gitlab-ci.d/cirrus/macos-*
>  F: */*.m
>  F: scripts/entitlement.sh

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


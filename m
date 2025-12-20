Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D07E668B4
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Dec 2025 14:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWxYJ-0002qr-81; Sat, 20 Dec 2025 09:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWxY2-0002pf-Fk
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 09:03:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWxY0-0005xb-Qd
 for qemu-devel@nongnu.org; Sat, 20 Dec 2025 09:03:06 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so29655805e9.3
 for <qemu-devel@nongnu.org>; Sat, 20 Dec 2025 06:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766239382; x=1766844182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yla0ysvd/srx1Ud0V48VoFCIDJGbJqPuC+Hw2Gd9euk=;
 b=cLa3u8F5C0896BpGvJnDRPP7jbOh4FcF1iK9XacjMxVizvGqZ+dBeUsOfVtR4eSDSC
 ShfKqphxl7zs96vbQaftJgq83GGTpYLDx8bKESHbCXwlbHK1ADrkRSxPcZZ+9eUPWHep
 8V48+edVos35kUn9kqq/7F2TnNAHDGerRLyttpdoELEdjSPP/WWdGTzVSI6HJYMcxv4x
 RyJCiZAQe2DYTcu0LhwHAWTVhyQTpVGP85BdG2jCHSgS0Oxgz8bX3sRJZqYwdZ/jbAsY
 Jw1FiTLsa/fxg3MV9VM0HEUGODBHZS5s+BJCXArELKFzpWZv4IkA91i3XsJk61DeD7EW
 W3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766239382; x=1766844182;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yla0ysvd/srx1Ud0V48VoFCIDJGbJqPuC+Hw2Gd9euk=;
 b=vKdPRn8qC5PlW4DIDdiyc/YydNQYERJ7/UG5fXANWMTnctE29qb6Ma0yYgp8AL+NPX
 KPc98pQcjvvXGcynPQ67ICmRnPqIT2DAYaI8G6PtPcmHAb0wk3eYNfnUxH77r378xvya
 C2VEfLroafH3Lvhz7eTcQgpZfDt1/HB9O9YyEYeJX4gASniO7E4oQQi0SkbXC8h+vxBS
 njzgnCIYiJzxGI9URjSJyVEtEVa9aiwV2e7bGK/0y6Ar2v5ESIdDjY8z4QUJ6C1uE22b
 yWvxNjoclncTCKr+GZYsFBwoUGQrjV5cbGjGf5tMSdR5gYxMK+ifVbrdtbyzfDgvoMIZ
 RQFA==
X-Gm-Message-State: AOJu0Yz+Oi3JOJfL1UqKYYUYSBgQJjZzgXW2mEd3wUlyWGJC3Ir/3Cwg
 ffSioX5wIBG7/1CKy40Rk0AvVkLTm/+m7kT/UpfeLKKIXC92o2a4eGexPM5uPEJslZ7QQ20AlYf
 pPF6e
X-Gm-Gg: AY/fxX6u2l1ug66kjfaWf2iw2Q5Kz6m+LWjltHl5DsTuFysC5WKQdVVGcxJg10+V8rW
 kJcvnF5LdB0lv4S090Gkx6KE5qGIbHw96TcS1F9HRiJiQCHeN7Ht0pY6g4AeciWB3tC7MV5Gokk
 qBrzYPLD8QBCX3Gy8rI2Ro0YlIV19SsiDPugj6W8xVrraZi0SQghNOpwZ2ZqhgJ6jb1qrdBysRz
 AVqREPJU1hjQ76EYDmLl/i4R92kn1sAJwZSZSgnlGeZXjRcKpgJ4pMDXGBjZ0KEfeq2MdyPHEEv
 /mPm1hx+bxbJswfGRljweEcc1ontbNGN5J+sMLsy2iwNIKCxOJz/WWdTW5hUnbh/n50MuGzeQup
 yC/5CwVpI61BSY5q6brkqKfCJ7vFnyQElPsQkanimYiM1gZKaBuavBpiW1DIDSh8IX60GBwsoba
 X5lEI0maWI0IThOOLj3fXC3w==
X-Google-Smtp-Source: AGHT+IGuDN732bxKbR+AzbQwdfa3rU3z6EW6HiWf/8ubl/i5+OKaYNnkz6ZmxHKpjL+6fv7qVGpekg==
X-Received: by 2002:a05:600c:3b05:b0:477:6e02:54a5 with SMTP id
 5b1f17b1804b1-47d19594d77mr55879445e9.18.1766239382526; 
 Sat, 20 Dec 2025 06:03:02 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab33f5sm10973493f8f.41.2025.12.20.06.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Dec 2025 06:03:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D2F515F7C2;
 Sat, 20 Dec 2025 14:03:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  berrange@redhat.com,
 philmd@linaro.org
Subject: Re: [PATCH] meson: Optimize summary_info about directories
In-Reply-To: <20251219230456.37178-1-guobin@linux.alibaba.com> (Bin Guo's
 message of "Sat, 20 Dec 2025 07:04:55 +0800")
References: <20251219230456.37178-1-guobin@linux.alibaba.com>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Sat, 20 Dec 2025 14:03:00 +0000
Message-ID: <87cy49z1wr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Bin Guo <guobin@linux.alibaba.com> writes:

> Clear summary_info first, otherwise there will be redundant output
> about build environment.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/meson.build b/meson.build
> index d9293294d8..73aa535d10 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4634,6 +4634,7 @@ summary_info +=3D {'Download dependencies': get_opt=
ion('wrap_mode') !=3D 'nodownload
>  summary(summary_info, bool_yn: true, section: 'Build environment')
>=20=20
>  # Directories
> +summary_info =3D {}
>  summary_info +=3D {'Install prefix':    get_option('prefix')}
>  summary_info +=3D {'BIOS directory':    qemu_datadir}
>  pathsep =3D host_os =3D=3D 'windows' ? ';' : ':'

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC2F606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IXQkXQRS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL1nJ-0005jf-AD; Sun, 25 Oct 2026 13:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xL1nH-0005jM-7U
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:14:03 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xL1nE-0005rO-Ur
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 13:14:02 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1215176f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792948438; x=1793553238; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L9prwJqao+fteE7eLkvGaO8TeNF83n+IQvCKxHiSPNs=;
 b=IXQkXQRSJ2aqzXiwQY5xOZdJ09x2JMX5+lzoPlAnljnCaitesv8CwLNQdU7Q0L9MDn
 8QLMZoxBQIusQEtp8A/Z2B16FPRmXf6xZYy5akF+BNKZOQJAyi7xaNYIRbaaHQ0mYIBf
 7frGOSXNOQyO6ZUeKFEvkOlwfok4048b2yrN3p1LjguoBACZtP9fLyghCUrRu2hE6MuU
 Yy0HqKxYfFzG32JRKnCdRebakd5cwlTXMWs8nONrRepBBMdRS1f6aUp/oFJAt6bJ7Qpg
 0cCthfGqgjsvLQiegk90HX763NwRoH9ouM3SF0FSkQXZpS9Xubao6Z/1esgpQOWdd4U2
 yJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792948438; x=1793553238;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L9prwJqao+fteE7eLkvGaO8TeNF83n+IQvCKxHiSPNs=;
 b=yy4/AvNhEXtewmAzU2O0xp2apzyCpGf1V+bo/sZuHowqiBsWVuhFYLRTxFACZtKLPV
 rL+kqCdCusU/hpnbTWXIaEBcBiEXMkVvBg9A5HDH1WiA9pefJEKz5yoqlYF6UBAcX+DL
 NfyENr19qBJhndJSOwEzk4fwVd6pa/Zi+2LEo84F0vEm1oKUMiXPR/yo54OK/veAaonW
 eNzPCBONVIRl1teG2+zInIuNbBxvqbkQ1VpAhX481cf9BVrnQ0NfR94yOf82yGnNMgB8
 c84z9X9WeC0zhKL5ihWFcUTqPX87SZrkmn1OP6P+kzrh5BzBqJWfrdAxZQ4sedxh5+57
 mEmA==
X-Gm-Message-State: AFq9FYJ2fSbmpOjVvrYMGzHc0wK6OnBULfhKavCr2s3MPgFuLds1yZPm
 Pv6vE0ySOFDbapxpSPnwxo5d+Ww6lIn0XJ7lqfsQjEBNgctN+cYbseptxJ9BJQorwG0=
X-Gm-Gg: AYBFou0WgbkbcMKaML/9tfGNCAtR6WjV+47ib9serxmpHUsBMf5Z1Ibodw76bYuGd4C
 RGAKcRQNiC6Q2grGhBwdszB+l/h111IqRAJm5fqh4NPfOlAK8SPJn10ZO4YM4n9MJpPNJ3/i0f0
 4TDJE74hbgyEJuGnpbHwckUwu6je9il9XUAfnPKxjN5MbjP6NnGMVQhIMriDVUtKombi1s5VzxC
 0WNKqMiLnZi2Zj31PK2RIlcPoe0FCQizKZpABC8OTj3Jsjoo7EA6qt6K1fQ3CvtD884jMYoqESb
 8b7UCnltDgFT7/HEvMBD/NacDU3JoXootJwFCwPu0tcIeHEll7Ckh+F/X0q+fZSendkaCvWvDkR
 P8974fRuKAt/+ASlAr2bcpHNDjihut1qTTbzZaTB6C20BIAYxcv64zNJyOY/Nl3gMxkepXq2DhA
 55nvsOvSVfD/dhQOAuHE14qY7tixMXZelLQWmf1CNCl90RPULWI2JM6IxiT9AyBK2MUe+xtn1HA
 FBvw4dBSsJAWcZNnwUvcO8MeMUqqgj2TfR31CNjAT5gT5juz8QHmhE=
X-Received: by 2002:a05:6000:4910:b0:487:767:b301 with SMTP id
 ffacd0b85a97d-48e3eba5e15mr7558575f8f.57.1792948437995; 
 Sun, 25 Oct 2026 10:13:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3a1csm10907242f8f.16.2026.10.25.10.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:13:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3EF3E5F905;
 Sun, 25 Oct 2026 17:13:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  Helge
 Deller <deller@gmx.de>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] linux-user: validate the fd for a zero-length
 readv/writev
In-Reply-To: <20261025071203.1214199-1-takano32@gmail.com> (TAKANO Mitsuhiro's
 message of "Sun, 25 Oct 2026 07:12:02 +0000")
References: <20261025071203.1214199-1-takano32@gmail.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Sun, 25 Oct 2026 17:13:55 +0000
Message-ID: <87o6chn1nw.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TAKANO Mitsuhiro <takano32@gmail.com> writes:

> lock_iovec() returns NULL with errno left at zero when the vector count
> is zero, and the readv/writev family turns that into a successful return
> without ever entering the kernel.  The kernel checks the file descriptor
> before it looks at the vector, so a read from a write-only descriptor
> fails with EBADF even when iovcnt is zero, while qemu-user reports
> success:
>
>     fd =3D open("/dev/null", O_WRONLY);
>     readv(fd, NULL, 0);     /* kernel: -1 EBADF, qemu-user: 0 */
>
> Return an empty vector for the zero count so that the syscall is issued
> and the host reports the real error.  This covers readv, writev,
> preadv, pwritev, preadv2, pwritev2 and vmsplice, which all share
> lock_iovec(); sendmsg/recvmsg already handle a zero iov itself.
>
> Reproducer and measurements: https://github.com/takano32/qemu-user-zero-i=
ovec
>
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
>  linux-user/syscall.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 0380691a8b..3197ccaec6 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3093,8 +3093,13 @@ static struct iovec *lock_iovec(int type, abi_ulon=
g target_addr,
>      bool bad_address =3D false;
>=20=20
>      if (count =3D=3D 0) {
> -        errno =3D 0;
> -        return NULL;
> +        /*
> +         * The kernel validates the file descriptor before it looks at t=
he
> +         * vector, so readv(fd, NULL, 0) on a read-only fd fails with EB=
ADF
> +         * rather than returning 0.  Hand back an empty vector so that t=
he
> +         * caller issues the syscall and the host reports the real error.
> +         */
> +        return g_new0(struct iovec, 1);

I can't imagine why we would want to leak an iovec structure every time
this is called. All the callers seem to have handling for NULL. Why are
we not just setting the right errno?

>      }
>      if (count > IOV_MAX) {
>          errno =3D EINVAL;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1396C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 21:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYtkY-0002KF-Du; Fri, 17 Jan 2025 16:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYtkR-0002Jm-Vo
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 16:19:24 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYtkQ-0008Mt-Bb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 16:19:23 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5da12190e75so5089838a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 13:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737148760; x=1737753560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+egERJj47ySd6G4AysZcCZlgph0yKOktKHfzmttkE0=;
 b=c98aXjMEPHrNor9orWA3K8OyTQyNowPDcCb2uGHNgpPIxbL5OAJLsd2SL2J/VMiG/Y
 Vx5TYE0AR9JbdRmWVtEvQrqROZUB+wdUc4kaRGTOR2hzEuG2DUbVjU2014GaRHD3Yx6x
 X7Oj4wwOTfS5Ph8KgcTGaUT7Nhn3VKweRde+rguX/egQg1E/BlJJEAkContXmF71kGYF
 o6bQTDjJMV7mNA6XS+pM5cTRxUiBDq5PUfmbeC95LzoDnuO3A2mozjUCRhfAAOYxUeB6
 czI4fWs0TBB6pO2dc4MeFBEXJVevZwlthZFfbUsIbD6Znug1URes+KnbxoX0rFRxUHKe
 BXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737148760; x=1737753560;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o+egERJj47ySd6G4AysZcCZlgph0yKOktKHfzmttkE0=;
 b=wvaxC7LWK7W+wfBKtoT2P/hLt4ssDgKSdJow4xnyl+S6knva7PRRe2W3UxbuppNKhz
 CHt9Rt5464xF1nCfhLNzxoQST0a4L87Ab1fAhlOvMbOR7j9e0K51hKpYCcfsVXDtYtjY
 YIIxCS06cOiBCye86092C82Tke1pKRCBDPMu0d8C6PqKKfMinqR8riJx++lnqF4EJvVf
 pewIfy2WodGhb7/bYHFIVxYiwtSWx3jsziqvWKsqD82Ot2IPk6normcMHW8JSXg0BLGo
 4QKIOHoa2n5GeI/78vczBWsjprvvMxf2P6o6d7xaJP1jCGmdQbhZDE8UJJAghP1lDMGi
 4eIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWZ3YipTxTkLN+lbAtc9y/R7V2X6YTO+3/UsGQjqSw1G83q1pN9fMnJDR/EVX1nD/1cprPzggKbQr0@nongnu.org
X-Gm-Message-State: AOJu0YyC3aO2Buie/VYarNCPXoCpioo8qlD9PPeqRh6hMHy8F18aB87D
 mbXGY5BfgiRB7vHL/p2nf+S2xPLub6qrSHJLjgrE2IlrfGhhIl/wOdy3/kTf7As=
X-Gm-Gg: ASbGncuHyNhtVW2z+ni12fOjcNnyEIwI4+dxvCmpSK24jM0/Srl9p2K0oBaATsZ7kIs
 1VkbdKIOVq41jRv0YKgYRHMqGrVjdiVmjqVSA6Y08CVlSImy4xX/HBYHZjN2L3XDDTdpBbRcDSt
 oZ2BLbamGBJUVJj9NgxX4hl9vWbf69FXv2ngDAnO6/kk+wbrZCrmnUGdgmCV3PDzxZ3GYgph65M
 wGL6g+yvusP23qo2GI87bZUVr1LL5pfghAfrbKlKzs+zmc1XFuhGN8=
X-Google-Smtp-Source: AGHT+IErdmPNQQegAGesFhXAxjn7H4yDC6TNT0T8EGF24BOEUod3ykpVEjnYXfM5zXX+M7vQBbajrA==
X-Received: by 2002:a05:6402:1e95:b0:5d1:fb79:c1b2 with SMTP id
 4fb4d7f45d1cf-5db7d2f9ceamr3907489a12.11.1737148759890; 
 Fri, 17 Jan 2025 13:19:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73edccd4sm2044238a12.77.2025.01.17.13.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 13:19:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C5AF06083E;
 Fri, 17 Jan 2025 21:19:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Warner Losh <imp@bsdimp.com>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Kyle Evans
 <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v6 2/8] gdbstub: Try unlinking the unix socket before
 binding
In-Reply-To: <20250117001542.8290-3-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Fri, 17 Jan 2025 01:11:27 +0100")
References: <20250117001542.8290-1-iii@linux.ibm.com>
 <20250117001542.8290-3-iii@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 17 Jan 2025 21:19:16 +0000
Message-ID: <871px1nnor.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> In case an emulated process execve()s another emulated process, bind()
> will fail, because the socket already exists. So try deleting it. Use
> the existing unix_listen() function which does this. Link qemu-user
> with qemu-sockets.c and add the monitor_get_fd() stub.
>
<snip>
...
> -    ret =3D listen(fd, 1);
> -    if (ret < 0) {
> -        perror("listen socket");
> -        close(fd);
> -        return -1;
> -    }
> -
> -    return fd;
> +    return unix_listen(path, errp);

Nice ;-)

>  }
>=20=20
<snip>
> diff --git a/util/meson.build b/util/meson.build
> index 5d8bef98912..780b5977a89 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -84,6 +84,8 @@ if have_block or have_ga
>    util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-c=
oroutine-io.c'))
>    util_ss.add(files(f'coroutine-@coroutine_backend@.c'))
>    util_ss.add(files('thread-pool.c', 'qemu-timer.c'))
> +endif
> +if have_block or have_ga or have_user
>    util_ss.add(files('qemu-sockets.c'))
>  endif
>  if have_block

I guess have_block is synonymous with have_system:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


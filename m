Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EC606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y0TFX+li
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUbF-0001lo-HK; Mon, 23 Nov 2026 09:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xVUaO-0001XI-2Z
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:00:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xVUaL-0006CW-PN
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:59:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so31200845e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795442395; x=1796047195; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=td172pmAcSRFxH8mO0YORH9KtIUCQxkzXWhqTpf1Rjc=;
 b=y0TFX+li/7OjJGq2CIkI2NV3hmukiL3gDyKfwFdNsqid+Dz9+9VnQMgsLBMDHUHJjX
 Xd3Rqeoj1qkd791CpmM/okstl3JjZAFJB5eFjWJBG4JLY0JtHEPe8RvE7dZcAXQ9ygfq
 zHgp4+k/vBnQdnJucBc0NzSK/TFf+ZY3/9NEI3YHH8jQL4kEqkTOHzgqKlpUCzlY5FM2
 UEhu8LPT2euDInVfFFMnSt5dsZyiiMlE5i1HRdtJp9ML3y9f3a8u3DaPj62BmbKE/h/r
 bfKx2GhXo+k/8WScu945gQLNmOWvrLqJjdzyEV+2ZPVUV0024MdHLlWSv8iA3dAdmAZa
 w4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795442395; x=1796047195;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=td172pmAcSRFxH8mO0YORH9KtIUCQxkzXWhqTpf1Rjc=;
 b=bCyl/WCWpJfVVHlsOcMXL0yKNYYnjkyLLe0CIBhC5YH9GHViQWFs9E144NlidTb6P6
 Pi2Y1PrJup5jXvUNJiq8NY8R/Wug9UDx7CjnmxidCr6/wsFtffw3cyb9fwxHzBjCjjrV
 ekVaqafgHN9W2OZy7XZEsoLR4XlAMYKcieR9Gm8W/EW6IcrwY9r8OryiQ9ZLW/6+P8Rd
 e1pP3F/HoI0OMLqNoFBlwEsYobv1we38xIJWgrzoIoAxpHl/8Fid+4mjqunPPiCggG6P
 cJaA3i4m17Q23TYfU/lVtVCB4GSKfGuw1Uy1PF0p37o2ahlpWWnx0iOiYEHpbZolnBwL
 2Hpg==
X-Gm-Message-State: APuU4Z8w5KgNCvwSG7VU0+VXjZYu+xeOYfAjYQr6COkyW2SiaW5CoNdl
 gmJ80LqWAB4hmUWpkdfEtToHzh717xha347WeRIAPRu7xwoln774B3FNor3LRolbFvR58+crYC8
 TrUxn
X-Gm-Gg: AZFdTZck1hQtHI4d0+zknq2Ma5CnDX0xYvl7QFpVOc+USw5rELNnCJ+sQPE9QLirwy5
 rE/jK1efuU9dExXu40vfFoIMtv+YSIR3Zh6FoMSlcXJLucJaAY9/bmXvUkANuMsRNSSeCH0iPo0
 qlhKAx6DN6O7m69aydF9ehc7L+fXHEiJTZnw9EjaQvJ8wWRNRNiL3SgolNuFsJCc97hjP32/TcT
 RvNlZbQoiHg0Zgdbwv/jSFctyiVYS4PBDMZOcFQCZT19LuPSyS/Ii7DaorJzUqcQm3dT/aM2uyh
 McxIRrKxsv3v2Zol529pOrIpdnBJEaatn7fAlumQufAf9GrA2HDNe2RfooS3oeEDfkL27PO3HhC
 QvfJXPv8zAjXqMW4qJ9+bygM0LD/xgiy0dyqhrzwfBikwNtL1b+T60NeMTesfI/f9Sva98YxsYi
 7iFV1hbIZfDyuk+Qte9uui+7keGbuh0Kzc7bPoVij6b/rBzFFwaUi4u9xEvbwAhYOzdFBubdh+U
 AFiw3yGwEk3k70ldoumk9781KgAxbXwPqnEgNc0tN46QAjVKudo5Bh2bUZdM2U/aLtb9Bpe/Eao
 KPRn99Hk5HN+KsNg3cPCc7YYjvViGYsn2IgmlVmxVjdWUFaubQ==
X-Received: by 2002:a05:600c:3509:b0:4bb:76f6:d23a with SMTP id
 5b1f17b1804b1-4bb88814d16mr254293255e9.21.1795442395332; 
 Mon, 23 Nov 2026 05:59:55 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm552144805e9.14.2026.11.23.05.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:59:54 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6BAA75F914;
 Mon, 23 Nov 2026 13:59:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: update Daniel's entries to be consistent
In-Reply-To: <20261120182200.789086-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Fri, 20 Nov 2026 18:22:00 +0000")
References: <20261120182200.789086-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Mon, 23 Nov 2026 13:59:53 +0000
Message-ID: <874id7wsva.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> When testing my get_maintainers.py I was shocked to see:
>
>   =E2=9E=9C  ./scripts/get_maintainer.py --list-absent-maintainers-since =
"2 years ago"
>   Maintainer              Last Seen   Email(s)                        Sub=
systems
>   -----------------------------------------------------------------------=
-------
>   ...
>   Daniel P. Berrange      2024-06-10  berrange@redhat.com             QOM=
, QDev, Seccomp, Cryptography, Buffers, I/O Channels, User authorization, S=
ockets, File monitor, Functional testing framework, Build system architectu=
re, Meson, GIT submodules
>
> Which is of course incorrect but tripped up by the fact we have been
> utf-8 clean for some time. There are some entries that are correct so
> fix up the rest in solidarity with my fellow utf-8 using hackers ;-)
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


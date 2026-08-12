Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3014C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuBTK-0005lN-R2; Wed, 12 Aug 2026 12:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuBTB-0005Pd-Tw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:06:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuBSn-0001lq-UK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:06:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so998380f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786550756; x=1787155556; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+qsqh5D/kh4D2ubqBjDGj4n4rAjwI70qiKvdYA5tuO4=;
 b=T89t9HWhq+I3r6nEdhH3f0MiggtxCH/nGZW543K7+gyLFezFav0OqJ1FSThdPHWbAq
 +vSJ3069NzyNzaC07je30a+PdAJTlniHCNU+tSDZT1tYUTNjz3sxj4FCPziiA7LkbXr3
 CTBnxYuCc1vTSpkxs8aK11NtzfWOtTqoqgA81LYslHVnuSOU+oVlzPQyiqvk3WRj+i76
 o93AbRecMArezvpfpOJDuJI60GqEAfimSEeCXPnM0GI3IoafinT2d23MZcTlSPBC56FE
 nIrY/tcV41KG0fBhRTxUG4FGqMo5RIRQbyRsXOUpMUyPKScC/DdzGRvm4VDQA/ILtcsG
 oueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786550756; x=1787155556;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+qsqh5D/kh4D2ubqBjDGj4n4rAjwI70qiKvdYA5tuO4=;
 b=AaMoLpJFAF0/PhkK2eprgF3ZHnwo3giuPH/bmsYua0pJuHVImwJUbEXO3lv4ggsOTP
 9/UHLNboCm8ReHmDxCMZ07il7VEqv91UFS983LxCeD8QxGEdUjAmX3U4e9Pnf5MpW4bn
 QY5jbiqTZYEsG10W3RSv3DsWGCmdYJtQuRrdlIH65mD8o66nfLmN8ZbET1m6M15kLu1r
 vLqIzPJRs6ViHn4lS2+BkdwX/33sVty2kjsvjCoO6qWo5Io6uNaPEgP1etoxa9sspm9M
 p1gD/0kb+QRuUD6tAoIL7cjFaeCm2sOprqr8+me/ZfFB7sqwdrH1bDzJaE2jLEg1scXl
 06pQ==
X-Gm-Message-State: AOJu0YxLQndv3Y0UntDQuY99KhPPpeBPyUPtb3NjXF3wkhoEeAH/yqHp
 YvOR79zkZgTKWLrqB5DfTfhpDuCiyvZK3EPjZ57M/PNsPr2NKUHW8HS9Jo1NzYGwPPM=
X-Gm-Gg: AR+sD12YyuI81D5kpFpIZyEMhZ5qjtJZKYpv/Jg5sr0wAumw+eCRLHqSEU+81sAn49/
 icIIZRVhRsgFhfGgPAFaI8C4oXnuwxLX7JpX2U7YcXfNyHHP1OF519gI50Gilz84E2VuOF4w8Zt
 eoAZ6qotEv+Hw6wGe/Z0sbBg0sJxO917fTf0DGHqfmdpnQt/8PQD7eiehIvv1GSqC3sPKv1DosH
 vrGGv73n0V6Av2f2F+EIPiD2n49hPXRuKbguPskvX/fehMV8F2KelWqyTXCON7SzpuSpD9U64yL
 q/HvKDIysM4ccX9XYNSy7EynuuYy5AAiAKzu0bQGaBydLXeQIMauQLcP0lpl18CCL7Cum+oJpeZ
 nE/UaKPoaJGu/dnI3ShdFaCeOnUwfK0eWHh/GfLafhtMmuc/gLemDh0ZzyNb9UDy8MLDVqV1EcI
 IJtU2A1OBwQkS6weFzeIpQ4UbGb0+7hnB9Q+YPNDdRlBVhvIClsBJtft2aYHTv
X-Received: by 2002:a05:6000:24c6:b0:481:474a:9a05 with SMTP id
 ffacd0b85a97d-48152dc7662mr8157726f8f.26.1786550755828; 
 Wed, 12 Aug 2026 09:05:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4e0cfsm8059519f8f.19.2026.08.12.09.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 09:05:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 21FC25F886;
 Wed, 12 Aug 2026 17:05:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 103/103] docs/devel/testing/: update documentation
In-Reply-To: <20260728044248.137626-104-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:42:47 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-104-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 17:05:53 +0100
Message-ID: <87qzk3xr1a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> We document how to build and run tcg tests with new framework.
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

With Daniels's run suggestion:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


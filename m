Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508D606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PbRPBH7n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQ7V-0000s2-G3; Mon, 23 Nov 2026 04:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xVQ7Q-0000rP-EN
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:13:48 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xVQ7O-0003C9-S6
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:13:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so28451565e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 01:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795425225; x=1796030025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uTTE+l6YI9JuWAqmG1kclELSlKlQuPwIA0YAkWZ+Izs=;
 b=PbRPBH7nLYyocAAuOZ6jKPLuCqYB+1DFfGf1E1yaOhh2JNr456uYcYYGm5RDhzod6F
 WvvTRNNZ6xO6ClVA8r4YQ75zMAIQdVLFz7PWrsOkt6TntT4t+wsWDz9+BcEj8OfR4iGj
 1xeBBD8gZDrOMZ0wtK8UztVWt1sdgp5E6vTeCTqTINo7J8noRg38y/qJaSn9l4AK3NwL
 SITtCUH81ODJStZTLmp3V7bG/MkqUpmr8RDV2Lipw7kvTQ37JKUnN7i/g+bCGYGUooIn
 LVjA3MibaroZhcj5/2o8ULNKF2zHiwxgNxMG2OPjMwOxqRBfLPghfEU4/wJs9NsyaJRT
 0fXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795425225; x=1796030025;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uTTE+l6YI9JuWAqmG1kclELSlKlQuPwIA0YAkWZ+Izs=;
 b=VnVgPuTG3FOoK3o3ChdEGa/Gc1KdVH2DbXHPSJFgQElVbAw+tRbIHDEXsm93HZWpzy
 eK/K/OLKPSJu20/AWwkdbHDLT/+Xch3bWIYQppytLTiy2XftDKqD5piTVMOqQ1joFGKI
 yMAoxlgoh1Qk3/xSrHKxSnPhgxGZnkW8GtEFL1dPJfJLnyOZo8NQtxpxmYpilpmRikf4
 +GnTrbUr4dGXPvYsmmIFraKwhf77KQ4KgmYv76IYQgzt677BjuhCqRs5N1NLDmmFW3Lt
 PIg7xTgQiWGYJ9GNAAVHZEfU0wTqxAasg9cD+H83Kb1n3P+TSU/JPNu3IZcjAFggwxWO
 +c7Q==
X-Gm-Message-State: APuU4Z+/BL0ToSv/INV5T6GAf6U4oG8AIcCR1k0PvebebTJPv+jVB6/w
 QHWmkpLDLXYhkVx0scuh0ynmH839ZJTsYw42rr/VKWBPu0GWvv/VWtIMBIs/5BX2G+I=
X-Gm-Gg: AZFdTZdSKdHlGocSoeRooiqXhw8woDgh8HntlggpT6QVm7Q23OChxp6Up4JaRk5CoXU
 u9TmLbt1ahTLHcdGPiiEW2Ehdbf8FmF4C4N8NitpGFRBM7cWImy9J0fGiquXqnGz4z8Klx/gOJ6
 VsfUb7LCfQgIFsM1IDWlEZGo17rQ61uFjQDBOIvUzt/gfAu6PJNK7P9osrmKtVQHZ3RifKJrxcf
 zE+/132HHk//MwpvKnfeX0UyJ59hz/L0bjTqbV0YC/jsVa3/kHViC7tkCeVTVzH8ZM6FUPFUQKP
 7nONJ/Vx8tsxbpbzr25H1lRoWaEcxnhCRIKL48NIDlCKKtQ+u2xQWxeZvrzFKX2Aal7bKWuiY3M
 qzCe08Ea8KQQL2vfmmfaXCJ0Ul+h3p/kocU0kKE6A30P1ACriumWRuPp7OzRGa/GOLe+FBV0tv3
 Pw/nqZmL5lZ9v5pL2I7zH/44UVoKT/XBA2Io3hLBf+Uz7j5lAwebumpiSyoGDVp03H+w794zl5C
 Kz8G0Xhrj3wh17O/Z7Dw70X6As4+PP9XOZ/FvPaK5SfrWGKmnecspOOdeMgltQKYKtgTfppXN0z
 5H5fO3pU9M5d+oW6gKPM3yWDLOXb
X-Received: by 2002:a05:600c:5249:b0:4bb:665c:a078 with SMTP id
 5b1f17b1804b1-4bb8893a89bmr218098255e9.28.1795425224856; 
 Mon, 23 Nov 2026 01:13:44 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm480682815e9.11.2026.11.23.01.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 01:13:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 171975F914;
 Mon, 23 Nov 2026 09:13:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Kuan-Wei Chiu
 <visitorckw@gmail.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
 Joel Stanley <joel@jms.id.au>,  Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,  Michael Ellerman
 <mpe@kernel.org>,  Portia Stephens <portias@oss.tenstorrent.com>,  Halil
 Pasic <pasic@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Matthew
 Rosato <mjrosato@linux.ibm.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org,  qemu-riscv@nongnu.org,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v2] tests/functional: use immutable tuxboot kernel URLs
In-Reply-To: <20261112133320.418012-2-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Thu, 12 Nov 2026 17:33:20 +0400")
References: <20261112133320.418012-2-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Mon, 23 Nov 2026 09:13:43 +0000
Message-ID: <87fqwrx648.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> tuxboot rebuilds the 6.18.54 kernel images in place, so the URLs
> without a datestamp now serve content that does not match the recorded
> hashes and the tuxrun tests fail to fetch their assets. Point the
> x86_64, arm64 and s390 tests at the immutable 20260930 snapshots and
> keep the hashes that were recorded against them, instead of implicitly
> switching to the rebuilt images.
>
> Do the same for the riscv64 6.11.9 kernel assets, which still used
> non-datestamped URLs; their recorded hashes already match the 20241122
> snapshot.
>
> Fixes: 8ac1aab21fca ("tests/functional: update arm64 tuxrun images")
> Fixes: 09961fafc5a0 ("tests/functional: update s390x tuxrun images")
> Fixes: 467c9eb7dd31 ("tests/functional: update x86_64 tuxrun images")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


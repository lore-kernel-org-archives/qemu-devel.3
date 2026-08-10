Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0583C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtYCE-0004hw-Bq; Mon, 10 Aug 2026 18:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wtYCC-0004hb-Lt
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:10:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wtYCB-0003xh-1e
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 18:10:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so24327005e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786399808; x=1787004608; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y0MiKQh0QT3KVSacP0pMcPVQMv7Zt13iPIC6t2GQW7c=;
 b=cdNn4bG+pJmlKAC3vCWbkicYrmLViJ2qui6/4QojfZtpSLsMudCo2aT5rc6kYAQdOF
 0ui6zuIFkDlxwNKHoQ9CuEjhyrHSZPW1mk48bJK/kqkQCnnQhl+NhnuIwjLp7i5QRuMY
 Y0gfJn8jI8C85I0MKSOfnYZCIL/vkpvWQDBBlMvKMal8CAiFIeaHL502i+UtohfTDWeW
 pjEqqESheUDLvH13DIhqvSLW7oKDl+Co1l3d+j1kVLOBnjMVuVlMWPgpeyewFWmXAmhZ
 Zx/mWQBv5Gqdez0zy1n0f8ee8mv8JfeqYU6u0jb/Ce6GGsdGdUvfq3ffnHOQlLCuj8wa
 /oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399808; x=1787004608;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y0MiKQh0QT3KVSacP0pMcPVQMv7Zt13iPIC6t2GQW7c=;
 b=KNWrY40inGVUlF6fxRYTDpSTkGuNH9ulbjkOvIQEDVmMSwoSWjFo5nFsQvCzHJJC/B
 5WWUPMWvW7uMErnskDAF1QG+ys7EbsNpB8MdJPq1ytuoaKjqYCwrMxe6lG7llDJ7dUx7
 9QQIIsnx0zpg07hx4KsusolSIYelIM6pLI8MxZdcmqtC3/jo9IzyZ2JTjQg0zKPeJj2G
 0dUwwyH5VyWmoAt313NIKFUbhl5KybZ2+BIHYrBhepRYHxRJJVzVryb5h/aGqeILsMJ/
 PvL+m69QkeoK7kER2MkSMbx5UHSSgr+hJ+nKFOJnmcTOCrkRAbxd5OrpXUfpDOiY1F+6
 5jHQ==
X-Gm-Message-State: AOJu0YxrrMVX+EgyXyrUAbcBbLUBd2EpZ1n3LXgaH1azvtfjO6K9JUwu
 P3YG9pTihLSYqAmYrioaLeNQyzs3pWXt8dniTuX0lMm9HAkYmEHvE/00C7p1O38oGiM=
X-Gm-Gg: AR+sD11FTbWtHHrjQpKKmhVOf08YfNpnY7fzGrJXJRVrOR+EGirSGO5eIjaJzIYD43f
 wR2obOLciV53PXNJh4XyVdmm1xiyM2g7SYp5JwyU/ak1bw57542sJdRRGzZZf7yPJ8j1RasNpvV
 swxQ+5YvwtfoHnpIDAAo2KF3i37exr1uYQZcVtw7g8rj1DZwu1qWBt3Teb+bYzbgDre9hjYG2Lb
 RS9UTXl5hGYf14AwHUa6a4T6lkbEUx2l0lU3cUmEvXVPXe1ezOrnvHCzQlaNALZ8W07VVf8OW2z
 BwHs8Z2KJNolwSxOwMDiwIb2M6Pbqi3D3TS7p9RaP60RnZITlg7KWTmQvuoHz7eDQbM5bwTAeed
 VXFoOvmo+8N3ISewb+00kTk2ZO8F3vqEcfGfHc93qGoV2hY8EoNR2nhmhG2mWhNr5B4GbMrdkdz
 /1txlng+ieXK60H3Mcmp8Ymo6xJNNiuD0ch82xZc+UnfyF8gyrBSwPlsIWpAmq
X-Received: by 2002:a05:600c:8287:b0:496:bbcb:b0bb with SMTP id
 5b1f17b1804b1-499727c5cf1mr71332215e9.18.1786399808244; 
 Mon, 10 Aug 2026 15:10:08 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995d85254asm153029525e9.1.2026.08.10.15.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 15:10:07 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 268AE5F7F8;
 Mon, 10 Aug 2026 23:10:05 +0100 (BST)
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
Subject: Re: [PATCH v6 005/103] tests/tcg: introduce meson.build
In-Reply-To: <20260728044248.137626-6-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:41:09 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-6-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Mon, 10 Aug 2026 23:10:05 +0100
Message-ID: <875x1h39vm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

> Every target declare its tests, and add them in global tcg_tests
> dictionary, indexed by target name. See comment for full description.
>
> We make sure that if a user repeats a test several time it won't result
> in duplicated executables or tests. In next commits, we'll introduce
> what's needed to deal with that.
>
> A test is compiled from a single source file (and later, a single set of
> compile flags). We make sure dependencies are correctly handled by
> generating a depfile.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


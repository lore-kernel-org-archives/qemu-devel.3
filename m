Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B836DCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOUD-0006NK-8p; Wed, 24 Jun 2026 10:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcOUB-0006My-3E
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:21:51 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcOU9-0007y6-Kv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 10:21:50 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-46cbf263113so526220f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782310907; x=1782915707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnXpZMdqQfKdjZBdNd7Tc2qVPloMYt9KTFGuavuUuWg=;
 b=Ts2cvjoy9WWzENpacOubIElRK0fWnrRsHW+lJy58yxawPYnMQ1vXk5Kvex7lx1W+td
 uRcWiD21X1Vb7XPVqIaQJioeozlty3wRI3i0z+X/43Dh1ULW/+SO2zmMs/XI4qUuC+F5
 Y90D2p4WLIcno/EtGjGSdUm4tgUdEvqU3hlDR5GzfJhHqQBm/ERFoKD422KJQFHAqRNE
 EmFfBvYd8ndI6A+87xqDnVkh6H/ZJQXLU4DBgJGJnN6Js3pCn5l8u7iFHswur/btumAv
 vvs3FFOrNxYbG8pkU+vsed0t5PP0FM937Cd8e8XGhHLcCkesG23jim9QNCAPVTZg24GQ
 g7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782310907; x=1782915707;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnXpZMdqQfKdjZBdNd7Tc2qVPloMYt9KTFGuavuUuWg=;
 b=EEA9w15cWV6UpbHl7fD+93afijRAWLaIOei5nAFpROHmwLCa9LzV0GXYH3ORid2mcp
 7P6P1krryQ/GGwQhhmAyOa4pOoiVqd/oEoCmR2PwT/CZrS2WHNpyf+5AqK5ljRu18sH2
 g82FEYng3k8TRE9FeLtlcI0uiXdLQjrpqZVmh+VaDKw0IXAcR9+RkaW+OxxpELk+TQbi
 Drg9zjt70DyyRLjIrU23o3XtnzN8hdpPnMDH9YN1mMMM4aFhn3DwJ480E0KFnQWfaL6P
 otvGHYeS9VNj8TOt0QYvGSH9vamUqZ94l8MZ81+1xi5w/Lq15IsmG2fgtEZ7hU4WJ7kz
 PvRw==
X-Gm-Message-State: AOJu0YwR4t6pgsHUzNj/wsjj6K19s33tTO8tdC6jmmk7Lr/oVFB6guT5
 k40ggvxEnOJW/X6d1bUayroNGGlkMoj5JWmPFZvcOJhaucBirzzMya7f8aQ8DepWk+w=
X-Gm-Gg: AfdE7ckuYQGxPWU05ZDCms+g0V8WsCm5cC86u/7AL79Z6knltWpU8DOfw73OvpHTVNl
 H9eMFWebU27cSQNn3F+XjvhL2nLNgMSUiW6h64qm7XseA1Qd6rD9v/5oUp5kz476f18VCxaKa1b
 PxF2UfWf896PHK+gculGOTHn8RWu5duCnRUpCThlqsdVcVQry+8u+kjf6+YKxFGF5hrYESvO2P+
 D8eKGbPivUP8+YrHSGOD/FmfuuCXoLpak5prHbzwlH4W6X/iVu/7UKmA3UeomaVIFYkB9jMQwOZ
 i5W0OmxSr/yM2p2qLuEk2F9TjdQfUjYyIWYsjKpXLmZ0ji1lTumc7r5BxrUxmiGt52Fu7AN8NJJ
 ubXwpONpjpy/dKIdHzxqZSaZcYzBwnbuXYl4Mby00F+PnFQskEiCBmXpXIYH+j/sVNoOLr6hx11
 LWkM+XCHCEWv1i
X-Received: by 2002:a05:600c:6097:b0:492:4a56:68fa with SMTP id
 5b1f17b1804b1-49260872e27mr52303015e9.24.1782310906988; 
 Wed, 24 Jun 2026 07:21:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd30078sm459101905e9.7.2026.06.24.07.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:21:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F26B5F80B;
 Wed, 24 Jun 2026 15:21:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 01/27] tests/tcg/multiarch/system/memory.c: remove
 unused variable
In-Reply-To: <20260609214745.772536-2-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 9 Jun 2026 14:47:19 -0700")
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-2-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 15:21:45 +0100
Message-ID: <87cxxgkohy.fsf@draig.linaro.org>
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

> Caught this since by compiling this file with -Wall, -Werror.
>
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c: In function =
=E2=80=98init_test_data_s8=E2=80=99:
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c:97:18: error:=
 unused variable =E2=80=98bottom=E2=80=99 [-Werror=3Dunused-variable]
>    97 |     uint8_t top, bottom, *ptr =3D &test_data[0];
>       |                  ^~~~~~
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c:97:13: error:=
 unused variable =E2=80=98top=E2=80=99 [-Werror=3Dunused-variable]
>    97 |     uint8_t top, bottom, *ptr =3D &test_data[0];
>       |             ^~~
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c: In function =
=E2=80=98read_test_data_s8=E2=80=99:
> ../tests/tcg/aarch64/system/../../multiarch/system/memory.c:384:14: error=
: unused variable =E2=80=98ok=E2=80=99 [-Werror=3Dunused-variable]
>   384 |         bool ok;
>       |
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE59C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzVh-0006Mr-Az; Mon, 19 May 2025 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzVd-0006HM-HQ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:22:21 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uGzVY-0005Oj-0A
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:22:20 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70caa34282fso19103837b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747657330; x=1748262130; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4I93fY7OYciV8EQR+hvqriOOcUP3pj9SGrWr5dU5lY=;
 b=J1DFxdr4JMJoaGln25LrjJCzRmVxV/cLUekPUi+482YaPYB+RYkGguZ3bP7N4uNOIs
 BgRhzi47ExY0zfjKruX7zxZuab3wQRaJ+1cQq9VkLOZwyu0XS2TGbCbHZwAURKzYx668
 NIvmGeJ79kWxHMNh0piHDO2xa3+ZkDSqqR9Ozoh/khrBgoqp9Bg18FtrZFln8O2dWdn1
 JHCp2DYBLrMzBPDQY1mctOBzx1NC9y4l9iuJoQZvP6s/VQkMyt+iKC1S/OTFLLzoUwQN
 w7aOQd1xDZKLIClr6dpMAQl4StWks2vvtbcUGJUx1JzNtXDNd65tACIwA/0Wnyc14vTs
 VYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747657330; x=1748262130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4I93fY7OYciV8EQR+hvqriOOcUP3pj9SGrWr5dU5lY=;
 b=YiDFFBb63uNWFmM2ixUqp4N79rtSItu5srH5F+jp36HjxEvedFJqCeaZv0gpvnUrkk
 ZHStS0ulnL9+FFs+7qkCk6R1gmrAvt08QDWVjiO+skxThufbpplTpLRKdPsz4S0S9iBD
 RE/lnXCg4v+WwUVE670FM6WdQ20UZewTy7V2CvYbXkhjPyPG7IRDOUE5xT3IzaRxhlBo
 t4RvpYsR9rozmeJXXuL+FteZQwuhC5fMmeVVJWaMbD0Mw27He4wi6mWHh//VhfE1Ojhm
 2hkC7+atcXFOqgSgbxwDJf6LA7LbQzKmW0bIMAi5tZ6pkt3aq/y6qL31oqrVrECkdut8
 mbNA==
X-Gm-Message-State: AOJu0YwPxe5Xk+HpptmU6idRLP+jIkIIHiD5a2w6/UbARWjbj+4AR6AQ
 Fm8tCZGi3lGCwE+P1OP30JhRYVQHmxSfkEk1BblBRoKoGvJc/cZYqyouR1Q6Q6k+UlEZw9LRKC/
 XeTXsZ2sj6mr/3u/6cT6+AU1ofEwnkJtmhLpPNrbJKA==
X-Gm-Gg: ASbGnctW/iQFpiMPebqKHXd/0146yvaVmyBqsgIpGDK71k/SjQFeH9ECzBtmkb6z2qD
 GIWZY161kMF2785jzur+c3sIaOc8DEcFiYiUZ1yqobTgoB1EA8Wx/yFYu04Xrx5l7pOpHJW8K4V
 XWmOelPMMWk0iGj5i5G1fVM9nmZ3I//9Sqvw==
X-Google-Smtp-Source: AGHT+IG3xx9V01HlRP09F9uTe1Qi/QOb5BoN1YSuarFUxoVY4xABBeD5g06nU9Ybv4wEeFIhgasUHJC1diDM4WMlf8k=
X-Received: by 2002:a05:690c:968a:b0:6f9:a53b:2a84 with SMTP id
 00721157ae682-70ca7bc5ae7mr171958847b3.36.1747657330393; Mon, 19 May 2025
 05:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-9-berrange@redhat.com>
In-Reply-To: <20250515135936.86760-9-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 13:21:58 +0100
X-Gm-Features: AX0GCFvTohGfy_x-S4aRS4LIcEMTwxsHQUFmSHhDEGM20UdcZBthAIY9r_2Z91s
Message-ID: <CAFEAcA9DpN6QqLDUgcuHwJqhewUB0wZV+Og1mwDkTVbSTvnsVg@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] scripts/checkpatch: reimplement mandate for
 SPDX-License-Identifier
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 15 May 2025 at 15:00, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Going forward we want all newly created source files to have an
> SPDX-License-Identifier tag present.
>
> Initially mandate this for C, Python, Perl, Shell source files,
> as well as JSON (QAPI) and Makefiles, while encouraging users
> to consider it for other file types.
>
> The new attempt at detecting missing SPDX-License-Identifier relies
> on the hooks for relying triggering logic at the end of scanning a
> new file in the diff.
>
> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


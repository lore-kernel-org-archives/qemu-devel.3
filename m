Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1B9D32D82
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 10:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAngj-0000Su-Cr; Tue, 12 Nov 2024 04:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1tAngY-0000SG-Gk
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:59:48 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1tAngU-0006cl-Eg
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:59:43 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2bd0e2c4fso4343839a91.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 01:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731405580; x=1732010380; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FA1+GCWsISa2+AAZdMyFD3goc3WDoEqk3wSlMT879EA=;
 b=L7dxV30J/7W6gdWvksgj70uxiaPI/BK4avIZ6+osKQXTFxJmgS5vrGPUtYpIVA1lWZ
 bCEA3QHjocOcDVZ1Ufr0wumGIfD+LFtRUtabd8WIfDO4O1wBXm9wkftpbIdRVDZiUPHX
 3kGgn+gBeiDxDWPVO67bIsrCdiaq1Mfq94sRIEeIPR6K/lmec/qbdT3fypftSF/w/QG8
 YADNYa11XIZGG4CuFJ9Bd0H7Zb2gUIAZgqvUSfePhrvn3FUK4jSxsF226NHkq9jxxezf
 muiavPaLDbJy1Qno6r7FdkhKxa2ravXh38+6+4UF9cf/LE49CaGp4yR4ieErYj/4hc73
 4WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731405580; x=1732010380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FA1+GCWsISa2+AAZdMyFD3goc3WDoEqk3wSlMT879EA=;
 b=n93q5KYaIkzPssJ5W1BaQkaTWAfL3A+NTPCmhkbweljeUUeh7P1k12btiR10SKGp2f
 0if5dnFFyYiXNX/tVG2iOTPGZ7dpM4nYizwMM37Bo/V9GNOCA6q9Udsz2vziXA0wlvU8
 nSlWOIjIiXwn1KW9yawv3pNDcFaGrh4E7SbT6ibNODYrCqOJ0EO+VB1qzlbs2l33bYsx
 8yt/MZtohws4xHAMNYXjjX3GsWgz0LF27Lgpmcc/iE/qttAuaMCcht+rUgC1nvxCz6+s
 yWma9b5vEUyYkxF1xva42g4p5/0oxy2Dr8pmgCqf51S7z/zp8lZIP0dhsjIhU3Hshdt7
 1R8g==
X-Gm-Message-State: AOJu0Yw4q/t1s+3DtoiPuLwui1g6+uAALKj54491XShnu+o4N0OFmSsB
 ZqXV4ICMdWB9vK/8/usRKQ0lfkHuVctRakzVPgKIsYz+u5CeMuva7D6uPDYpnaYZdEroXF3ICr8
 srIgkQgXM+72H/524DMob1PG4HcY=
X-Google-Smtp-Source: AGHT+IGhpJEoCS0Tn3FQgAvNdKRS0qMIRqP8oevnSvK8zw61sf7NHhy8z/pDvGqQtKPfo/PPjEkIvvLS+vzyktld5Zo=
X-Received: by 2002:a17:90b:38ce:b0:2e2:d15c:1a24 with SMTP id
 98e67ed59e1d1-2e9b174113cmr19625719a91.23.1731405580246; Tue, 12 Nov 2024
 01:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20241111224452.61276-1-philmd@linaro.org>
In-Reply-To: <20241111224452.61276-1-philmd@linaro.org>
From: Aleksandar Rikalo <arikalo@gmail.com>
Date: Tue, 12 Nov 2024 02:59:29 -0700
Message-ID: <CAGQJe6oGKkx0EB35jm7ijUWzDXhKaL1=P9QyszMSxM0L3VWSyA@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/mips: Convert nanoMIPS LSA opcode to decodetree
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=arikalo@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

> Yet another 2 patches extracted from an old branch
> I'm rebasing. Trivial decodetree conversion of LSA,
> however this introduce the basis to convert nanoMIPS
> opcodes.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   target/mips: Introduce decode tree bindings for nanoMIPS ISA
>   target/mips: Convert nanoMIPS LSA opcode to decodetree
>

For the entire series:

Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>


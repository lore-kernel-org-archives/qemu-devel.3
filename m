Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02026EF48C4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 13:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrFWy-0005fr-TE; Sat, 14 Feb 2026 08:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vrFWU-0005Tf-Ge
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:17:26 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vrFWS-0007uY-Jz
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:17:21 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso14617935e9.3
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 05:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771075038; x=1771679838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pqlSXYathEHV11u/uIM5GwbGooY1vyyO9QJqrD6F69Y=;
 b=KDlF1i5Afl0eN8/wzfvv2bb/WlzsYyLcDl9pGm7pvDjJH9vB2YKpUm8SlEXIK+pgEV
 /BrxRT/ZmjQ9Bhlm0KVltoRuH+G5gJBxPJxtiez1Y2HiMSleaPZgkXNqkYLZJ6pAYcm4
 1SK9L+hijM1u74I1C/hVR3jZPLGGL9cOobXuKjDOnrf2u95tIHf3foCNEySaNWr6z+Qw
 hTizmsq+xgEi2XQeKlHK/HY3a6jD7LkTr8KXlfMi84tBClXu07nIr3K9QjUIOQqFKadZ
 Vx6eTMLQDwNPwjBUsic0jBVe3HxEG3/koVCeTGr/w1h+JNqEJ+pssiZp8/oD9sDetnKK
 PZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771075038; x=1771679838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqlSXYathEHV11u/uIM5GwbGooY1vyyO9QJqrD6F69Y=;
 b=nHjEocQ3tsEuXDqjElnh9oQOEpJnfG0si5Gki/P9FFu2pkEgn8SeAjuh/TsIMHXlEN
 8Fxh/wODisBlPr4G95QLRlVt0Rw+Wi72zolF7FoYbsuP91t8D0OMr73jXrwkDQlzWWd3
 cUVezzLbgAoqe9HOa8gELfTM5iVXAzxvo79KDBDVCnmquio1fPQ10cH7ILgYXK+9n4mR
 fR8BPcGlKg7riDI0hybX7uUtsxu4UFDHEj6CvqHklCos32qxJicUF+VuR7YXyuqAPqJM
 StKyAUe5QbWzswEJC0SSV5kNpqEywQ8/xGrAuaX9AqrOvc3eXCb6Wif3MDfWNTmmQwTY
 w6Jg==
X-Gm-Message-State: AOJu0YwM3STaWSQL0fQnTLSDovr4Q3Rbrxp8PlbFtbDMF5g2Nd1uBRHE
 3Y2qNqjNyAgWfahT1vEwrStoy6AAsKQ+3KYwYdKyQKFrq1hfG9ONobZOtMxcWA==
X-Gm-Gg: AZuq6aJhDxuIeflANvtBCVQnqO6YnpkWfHsaUpWHVeClvTXCoEeIHejmTl5JLYkOATb
 wGlPEyhf9XWn1g0Fh0GAxO1AKuAkuxLH3cMIsNfTzkQEeRyYj/d2fTdJs7WWGOIyCU5iuF/Uhee
 rXlFxmTaVfcv65feZisiyeDusggs58RBdVMAfjf0D3+eDyNiW9G67f8dfjBf13p6ec6Eid1rjXQ
 E83vhFMr49FJylEokZSO5gaXoOGNxteyENLyJ3S1TEqZR3/rCSMudR2WNts7aDHsTFtrPyn5BbZ
 SdWcqMTkhp7qBvH+RcIeysplP2zpeKNZnYiVsCx+Q9vJO+epY7GBAo5PJVTD3Jww+JYBc+dISLo
 4dH14b7x8pVB1bAGflNVa9Du7Ylb3TQmNIknIuz5X62nXQ9j+d6Xw7bFUjTodjPfQQQk8Qj2CxY
 5ujb3pYzbid8wDvG39KT7P+qOXIQIBO0mxeMU0mZArMnF8XWPV7HivJJdgYFxGPSgB09HQVRzAE
 vgdp0x97e4Msppa
X-Received: by 2002:a05:600c:609a:b0:483:7020:864 with SMTP id
 5b1f17b1804b1-48379c178eamr43243805e9.25.1771075037658; 
 Sat, 14 Feb 2026 05:17:17 -0800 (PST)
Received: from archlinux (dynamic-092-224-176-164.92.224.pool.telefonica.de.
 [92.224.176.164]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac800esm13340471f8f.27.2026.02.14.05.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 05:17:17 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/3] i386 emulate fixes
Date: Sat, 14 Feb 2026 14:16:56 +0100
Message-ID: <20260214131659.31378-1-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
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

When testing Mohamed's recent x86_64 WHPX updates [1] I encountered two=0D
compilation issues under MSYS2/GCC which are fixed in this series. The last=
=0D
commit fixes a missed optimization opportunity in MSHV code.=0D
=0D
The MSHV code will be reused in WHPX [1] which allowed me to test it. I=0D
didn't notice any performance benefits, though in theory there should be so=
me=0D
due to less guest memory accesses.=0D
=0D
Testing done:=0D
* Use a Linux VM for a couple of hours=0D
=0D
[1] https://lore.kernel.org/qemu-devel/20260213034556.13471-1-mohamed@unpre=
dictable.fr/=0D
=0D
Bernhard Beschow (3):=0D
  target/i386/emulate/x86_decode: Fix compiler warning=0D
  target/i386/hvf/x86_mmu: Fix compiler warning=0D
  target/i386/emulate/x86_decode: Actually use stream in=0D
    decode_instruction_stream()=0D
=0D
 target/i386/emulate/x86_decode.c | 6 +++---=0D
 target/i386/hvf/x86_mmu.c        | 6 ++++--=0D
 2 files changed, 7 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.53.0=0D
=0D


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3A6C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 20:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvk3f-0005Lx-IF; Sat, 13 Apr 2024 16:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1rvjXd-00088F-Kt
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 16:00:01 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1rvjXb-0004Pa-TR
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 16:00:01 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d6ff0422a2so23564631fa.2
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713038397; x=1713643197; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rx0CUEij1ak1vZo8U79r3AHKneG8LMPpuql7DdyhxPw=;
 b=Fgd0C98WTgwdbQgdvBXwRZqJO28q1ICTt5NuOSc5WqFR1zhHoiOe+cNA+Zxu46G+7O
 Vj23GBFXdH9YL1+cPLH69Rr7+MZY7/HwYrqmujDSTL/rJmoS4y64/F9wV7erWOBVKRCi
 xaCDS0buYN424DEr326g+lHCY7BuvIBwbd1ENA7snhSo+55c2dMmc6OsMXsjlSmcd7Xw
 tiGlwPvtGwGBto3tUpuLhPsbtsi7z7mCW7zDe0K5t1ylhHzpIBfhFzK8L5ZUXYc1gkIO
 5B6mfiFTQi5IIv1AYb+lEmBOAwkOy1Wnz5c2h0oqDTwqAq7gIGl+peH4lHcHThF6oh9z
 X/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713038397; x=1713643197;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rx0CUEij1ak1vZo8U79r3AHKneG8LMPpuql7DdyhxPw=;
 b=blU9bVRtDgj6+rbB1z0WEQFnzznvEtCvQVTLCfppoUr+BOiDLO3PW0c63gUzqa7let
 qGI/+G1whkVaGD/7ZbR/9TWlP9BUItkS4AUQPSYc40RYHvuiFEuggL1eHF5zfkSzx050
 uwY0gQqf9nrl1jGJ+SclGTEZYsRmL2tUMjfFD50B1y51YTYOK1m1834MNc6MQ+33f9cs
 2w8GiVvqGdTvfbznzUIGpKcr688lS1cgqxR2mSmdc5vEZCzLa/b6Jb7Jsn61IVCVuIAi
 xsSB8fpA7FocJjH2nNKnFEzNbN54SeyFZwcmd34u+FNMM02KcM+cSNIS2O/njCDa6eq+
 Su9w==
X-Gm-Message-State: AOJu0YwRsR+vG9vpxpFH4F/9WjZxVomAlYlNaVCyHBK0ebHMcb7ZYAwl
 ATVTO+9YsUCQwIuHwTClfGcy7cG4n2j6Uf5J+es2rGZMfmyxbI5uwB2mxSwDV9evhsIQgG9PAlh
 elic67mn+Twi27rqzqu1YpG2EVcfMZY4c
X-Google-Smtp-Source: AGHT+IG6HH/ooAVHZfq0b7PP5BGw/9TNvUdfzQ/ERdqCO/8U2PD/2w6Z/cQbPbbtb/EFYnw5t10An9WuuTkMlC8KZqk=
X-Received: by 2002:a05:651c:508:b0:2d8:1946:3025 with SMTP id
 o8-20020a05651c050800b002d819463025mr3851825ljp.22.1713038396944; Sat, 13 Apr
 2024 12:59:56 -0700 (PDT)
MIME-Version: 1.0
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 14 Apr 2024 01:59:45 +0600
Message-ID: <CAFfO_h6LZF4T1zfTWh9qhJLcMZWxZ5VAPx-pgO66pXbWiWhNtw@mail.gmail.com>
Subject: Questions about "QEMU gives wrong MPIDR value for Arm CPU types with
 MT=1" (gitlab issue #1608)
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 13 Apr 2024 16:33:04 -0400
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

Hi,
Hope everyone is doing well. I was looking at "Bite Sized" tagged QEMU
issues in gitlab to see if there is anything that makes sense for me
as a first time contributor. I see this issue "QEMU gives wrong MPIDR
value for Arm CPU types with MT=1" (gitlab URL:
https://gitlab.com/qemu-project/qemu/-/issues/1608 ).

From the bug ticket description, it is very clear that I will need to
add a bool member variable in the "AarchCPU" struct which is in
"target/arm/cpu.h" file. I believe the next logical change is to set
this member variable to "true" in the corresponding arm cpu "initfn"
functions (a55, a76, noeverse_n1) which are in "target/arm/cpu64.c"
file. I have a few questions about the following steps as I am looking
through the code.

1. I believe I will need to update the "arm_build_mp_affinity"
function in "target/arm/cpu.c" file to now also take in a bool
parameter that will indicate if the function should instead put the
"core index" in the "aff1" bits instead of the existing logic of
"aff0" bits and the cluster id in the "aff2" bits instead of the
existing logic of "aff1" bits. But I see this function being invoked
from 3 other files: "hw/arm/sbsa-ref.c", "hw/arm/virt.c",
"hw/arm/npcm7xx.c". Should the function calls in these files always
have that corresponding argument set to "false"?

2. As per the bug ticket description, I will also need to update the
"mpidr_read_val" function in the "target/arm/helper.c" file to only
set the MT bit (24th) to 1 if the member variable is true. I think
there is nothing else to be done in this function apart from checking
and then setting the MT bit. Is my assumption correct?

I think doing the above steps should fix the bug and probably we don't
need anything else. It would be great if someone can help me answer
the questions or any suggestion would be great if my assumptions are
wrong. Thanks.

Regards,
Dorjoy.


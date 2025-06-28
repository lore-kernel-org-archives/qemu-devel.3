Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50497C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 10:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVSeD-0007AW-1u; Sat, 28 Jun 2025 06:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1uVSeB-0007AI-N8
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 06:18:59 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1uVSeA-0001Vf-5m
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 06:18:59 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e731a56e111so489336276.1
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751105936; x=1751710736; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LMiNIXhxYfMNIgJ+IxSRWvhkTbj6qDOTRQvzbgpazV8=;
 b=XXeo73cfHyOFEecEtIPZMKutnehoKbvvHf31Dlh77iN9o2KRenZi2KiXdq6WP3lgtc
 sqlYRtMKgz5qnKSc3bvhvcuRH9PfUSUcuN72Mydb39F97vbl/j/orV9mwhXP5ypeWjT+
 xBWoqohFNcagRW1dtD7ghqgog6ks/ZbnbtEQebwuszpIclIlQ+UcnEVl2gylmxezpdFi
 lpg01nT3+ujD7f5knOrNehtS3BGdT/OPpGGcvVMicGGJQwcJOkXQytc22SbIckQztP/z
 aE1DPjl9MKf9WmGN5G91RSGrKHYdwLbemWIgHvBy4QLiuRcy8PB8VhWY5E0Gja/JeSaE
 p9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751105936; x=1751710736;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LMiNIXhxYfMNIgJ+IxSRWvhkTbj6qDOTRQvzbgpazV8=;
 b=XoNN/VwG2ElPSkz2lfeZRAUNsEfIjg4+AUy0HJhp5J3pa/Iafm6CdoCzdYOdUnNu7H
 NimA/KlBIfVJ/QY9nMtZIu4ByxIDcAxG9GqLxDiYos2tLNIazt2paTvd5E9v31/6zPkb
 PO/7LC62WPNAyTyE3eL1YG4GIKVi61TSPjSTRFhRWxc0q18Hxk68nnZtP0ZClUnSh8YN
 JSZlbjjxmAfxImpuxHOkqvjzN7s5xSLG/f25kQ8PJYVvyvhM1Zutiu8T+MoF+sTyiJkg
 X73GIH4iubEgHbJWdgym+cu/lYG4a/nVq5CXZ9NSuYR3JV9tmqrxefZN9eCfon9NsHZi
 oMkA==
X-Gm-Message-State: AOJu0Yy+jaaQPMp9bzc0TrUpvfGfXcc1fx57+ZS7TTDK4VeEWskos0xV
 lEscI9IfkA3qW8Ek2tTapFvzz4ua4Vpqui25bpRMlDd8qJUyd5w2H5Q4LuN69465GwXNLu+OIpv
 g4txe/55MBLzxhcxABLMTZQgktXlOgw592Q==
X-Gm-Gg: ASbGncugfcAPHG9fGPsA4JWC5Lyeh972ijmPoQ4jwNBhupEnIvwIZRijtUSaZJSdgGG
 0wqXsZYr0vjR6tP1VDmgzD2SREMtFkiaToLe7TmSa0g+V+o7csQZRPCPKAESkQx8Z83zgIAmcQZ
 lXjlHMIrLI9AgFiMWJqKUA/ytvRJoO2b4ux9cAeH/hhkTYyoZkM3N6mqrV7wRcBGZflFcRdE+HR
 w4h
X-Google-Smtp-Source: AGHT+IGMsuGAbJlpM0HFwzrRPAK3xctm6ELKHXMevTOBVHlGkR0+tTBbvbOH1JbkiKgETJk1+ukEh7Fcz4/F9Rryy+4=
X-Received: by 2002:a05:690c:4d47:b0:714:349:583a with SMTP id
 00721157ae682-7151719c76fmr104761047b3.32.1751105936183; Sat, 28 Jun 2025
 03:18:56 -0700 (PDT)
MIME-Version: 1.0
From: mindentropy <mindentropy@gmail.com>
Date: Sat, 28 Jun 2025 15:48:44 +0530
X-Gm-Features: Ac12FXxss6vWjcAJyNUlPq8srmCjHBxIOvHwVPAhr8f8E4sa0ZH8NXycNt1oOlA
Message-ID: <CAM2a4uyBMNSdKNtJWWTgNivj6dpDFzJJepkfpU5RN-wir9vQEQ@mail.gmail.com>
Subject: Options to output the preprocessor code
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=mindentropy@gmail.com; helo=mail-yb1-xb33.google.com
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

Hi,

Is there an option to generate preprocessor output while building the
QEMU code? It makes it easier to understand some of the macro template
function generation.

-Gautam.


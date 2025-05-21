Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBC9C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 18:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHoD3-0005RK-MA; Wed, 21 May 2025 14:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uHoCy-0005Qg-Bt
 for qemu-devel@nongnu.org; Wed, 21 May 2025 14:30:28 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uHoCv-0006g3-Ci
 for qemu-devel@nongnu.org; Wed, 21 May 2025 14:30:27 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-601aa44af77so8145481a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747852223; x=1748457023; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bwWw+8zTnoOmHrKTP8As4UlmnrKEdd/cVfBIsLvNDeA=;
 b=DetznAYGgygjseFXC0F/C2paI5guY/YQ4jPnDDQ444lehlbl8rCq9l3QpvlAiZS/1u
 EOA3H6GR1yZeKkIhVrZu1zEjprAlkMif32zZG2jAHZiMdIOtt/OGUjqOO9ZpycDSuz48
 un65VFBQ3GyHK14gTGmPaZiSqChDVARE/YxrnZ8vtCHqAc0dVorI5URp6EsMfGfCVDst
 rx382Zsc5GY13kaUDCVfpoTzltuGXEobTcY4vpfBlj76O5/kmlKcQNH3sM4f9UMxZJFP
 R1QnsHJK+FWVALwmyF36kmkjQ7GgdPmLytNM3EaTXSvZnSsMeCc5Ba+x8SiaWNtVt5P5
 6C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747852223; x=1748457023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bwWw+8zTnoOmHrKTP8As4UlmnrKEdd/cVfBIsLvNDeA=;
 b=I1aq6WoSAtGQgEmR6p9dqAKZyJL/jz12tG/WUjfBpviX2186fTKsCrMsLp6wdgVN+U
 6BgqOQoJyexm1BmZxNSMlUOypx01usayPIVo/QLQrX+DJnzJBmhL/9A1OnZBF1gkWslf
 XV4JjdrEfFI0vEcyIsz8bSTt1hns4B6hvWkiO+yvwwQfn+gVgnP9yNsJMiNNXi87F61w
 bA2K9EG70G2OCYHQzMki1SBHguagyhqKz8I2cEAQQg7HEnqCfExSx6itnNa5IdLRSee/
 X43W1R4eTv+Fao5GA2eeYmZ7l0DxDbiEN462hTEIixtBc+exR8k0k2h4YdkMcVnzOhyq
 45Kg==
X-Gm-Message-State: AOJu0Yw1Is4ftYjd7FkKkwhmeoW2NWyg/X5BHPT1tGU7VFLJcFsLwpui
 VerERSYELgRRgTulKxIedQi6S7TxLLeKYmwbvsSW1JXF2uXOTRH2VKPLT9nxwg8zp1V64zFbO8p
 T6sa28W3pBNu7QhmetJz0iRgCgjYKjrWdFiuX9AE=
X-Gm-Gg: ASbGncsvGEI9XX4SNCq/zTArGpuV6WIHNOAfSMTNlcsIhuthEPhFWGvMF7aY6I8SYms
 24UnW4rx3poybZ35jEhLRA3ZW5lRX7nwGIq0ZDnpTtN1anf88LpFuLojJHB55R12/rfzegQjotH
 kimeaIEqLVD2G2xh129pu5D1ZoJQ7Oxrc=
X-Google-Smtp-Source: AGHT+IGL2gqGM01BWIp60ULj/CJUReFQL9XYG4iFmzHDX0mPdPEPQtOTHyvjzLExFLFSzXB3t1o7AqZxdPlK8t97i1k=
X-Received: by 2002:a05:6402:2112:b0:602:266d:5865 with SMTP id
 4fb4d7f45d1cf-602266d5b7dmr4907380a12.9.1747852222609; Wed, 21 May 2025
 11:30:22 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 21 May 2025 14:30:10 -0400
X-Gm-Features: AX0GCFs6e_9fMkn0meplHZ_sPJk_hPgkDIr38IL2jOuK6C0SDsC5EqpsEJoANy0
Message-ID: <CAJSP0QXoQBbA-HATMo0OTLOnUcvYjHiUM2nmAQj1i=ZXkbStoQ@mail.gmail.com>
Subject: QEMU 10.1 release schedule
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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
Daniel Berrang=C3=A9 has proposed a release schedule that looks good to me.
The release will happen just before the KVM Forum conference.

Please reply if you have any questions or concerns about these dates!

- Soft freeze: 2025-07-22
- Hard freeze (rc0): 2025-07-29
- rc1: 2025-08-05
- rc2: 2025-08-12
- rc3: 2025-08-19
- Release or rc4: 2025-08-26
- Release if rc4 was needed: 2025-09-02

https://wiki.qemu.org/Planning/10.1

Stefan


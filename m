Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD29C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiZuX-0007vO-Pa; Thu, 13 Feb 2025 09:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikrant1garg@gmail.com>)
 id 1tiW2w-0006lu-RJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 05:02:14 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikrant1garg@gmail.com>)
 id 1tiW2t-0005LU-RZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 05:02:14 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fa44590eebso1522576a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 02:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739440929; x=1740045729; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5EP4nQyK89Ky7Y0fsEqPhuRpiFQspYBrVAzOzQFuiUg=;
 b=kJOJkGRSaa5LEEGvZBiznTzViUVcaXp76PLfdNSKv0weWWo5NZh8lJLGtpvqE5FKOj
 Cdv7emown2PL0ayeDzZHvAsvZIN0hQkABBQijmlY5pkn5oDJS2E1AvJ+eE9wTUeB2TIv
 qvJUk8uW7gqmtcJKG/IXPlaqYSaXlRs2hUN8KSMuM6L0pKh2uax/Df78rLpH9l4WwpjK
 2sYYXIXXppduiCrE+9dGSqgMyrqFaw+Uk5MDlocWJVVjgdmiXNRap2pqF1jBAuFmxW5/
 YihUZ1GKo9pzr0gUsDMqXhVAy2zKCQgpA/VPk0wN8wTeML+cO+/XhNNrdaOfA27T6kCc
 N3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739440929; x=1740045729;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5EP4nQyK89Ky7Y0fsEqPhuRpiFQspYBrVAzOzQFuiUg=;
 b=Gx98UAefvwcHK4WnavQsIz7BVv6WBNNVeoBdjbfTjbcoUpydzetcttjMP/DCj+dp93
 z0FA1Ck89OpmNqQw00OGfLJHZeNuHMqLe6rjX5JsevsCOk4up3VyGu96VfLuF8GHw1UH
 WYKDuTOb/6RKdbYWeP3k5gQVD5gBZUCIUKGi6100qKQUzhE1h5sLryZXhp+Ez+o1Pibh
 KtHZQDJViN3WVoEdchTmrteA9NmV3kqTorfgxqSRQUPaI8KisfHuUcBn/WUE7tZRkArX
 yMAQMfJt81pnSnUXY0k71YCcIOoQCsOVzmcX8gP1PzL7DgY8klahVsyf7DZOe5ia/A4P
 kcyA==
X-Gm-Message-State: AOJu0Yypz14Ji2q/QYWaagG1yTjTeJetyMcfrm247S2Nb7BL4KATP1Eu
 scG3iPG4I879YlNMcuCCjmpjC7Fy8zcB0Bbmpw4wK+hlVpRLtDvi6xbQedYo4UPguDBCSkPP0Ab
 cgjn7y2FvXmUPmP/c6IkRozH71bAr3tQ7g9M=
X-Gm-Gg: ASbGnctz9wIimK5zH7DNfrxRU0wHKzn6TTplZmn60VU6RNO90qN0juaHCnW9fFZ7mLg
 J6IXR+FxIocMrJQiH4oZnw+3hUjdzMSPQeENjep0uvZK0YGg8OTp1DOx8Qwon7jiEXGG4campYg
 ==
X-Google-Smtp-Source: AGHT+IGS+OM1zctga5zs7TnQOiXc4jxEnwE+Idxq0CPl4kksQk2EN0q0sIR2qxdvTtOr0uaxKvqRqNuNH2EARHHKUJI=
X-Received: by 2002:a17:90b:384d:b0:2f6:f107:fae4 with SMTP id
 98e67ed59e1d1-2fc0e1c626fmr3817267a91.8.1739440928965; Thu, 13 Feb 2025
 02:02:08 -0800 (PST)
MIME-Version: 1.0
From: Vikrant Garg <vikrant1garg@gmail.com>
Date: Thu, 13 Feb 2025 15:31:57 +0530
X-Gm-Features: AWEUYZmRAaZRfxMNbGWbDZIdeWtGyV1UW7dUNLYnsHPMUYimQE1r5ustMAS2wXA
Message-ID: <CAKXOwk1_zPNBaQZyiHb8A5D+3euZuvjW__Cqi3_PKgad95rDKg@mail.gmail.com>
Subject: [Qemu Nitro Enclave] NSM virtio attestation response is always of
 size 0x3000
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, graf@amazon.com
Content-Type: multipart/alternative; boundary="000000000000adcf1b062e032604"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=vikrant1garg@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Feb 2025 09:09:45 -0500
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

--000000000000adcf1b062e032604
Content-Type: text/plain; charset="UTF-8"

Hello All,

I am using the QEMU for emulating nitro enclave images. In my enclave
image, I have an attestation service implemented in Rust. This application
fetches attestations using IOCTL command. I have noticed that response from
the nsm virtio device is always of length 0x3000 (i.e. maximum NSM response
size). Instead, it should be the actual size of response bytes. Same case
is also happening with the attestation service implemented in python. On
the other hand, the same Rust attestation service is working with AWS nitro
enclaves. It looks like an NSM emulation issue.

I would like to confirm if this is the expected behaviour and need help on
further debugging.

Regards,
Vikrant

--000000000000adcf1b062e032604
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello All,</div><div><br></div><div>I am using the QE=
MU for emulating nitro enclave images. In my enclave image, I have an attes=
tation service implemented in Rust. This application fetches attestations u=
sing IOCTL command. I have noticed that response from the nsm virtio device=
 is always of length 0x3000 (i.e. maximum NSM response size). Instead, it s=
hould be the actual size of response bytes. Same case is also happening wit=
h the attestation service implemented in python. On the other hand, the sam=
e Rust attestation service is working with AWS nitro enclaves. It looks lik=
e an NSM emulation issue.</div><div><br></div><div>I would like to confirm =
if this is the expected behaviour and need help on further debugging.</div>=
<div><br></div><div>Regards,</div><div>Vikrant</div></div>

--000000000000adcf1b062e032604--


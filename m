Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7A3C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1bb-0006Xp-9L; Wed, 16 Jul 2025 08:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uc1X9-0002Am-1w
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:47:00 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uc1X5-00011p-0D
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:46:49 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ae9be1697easo164533066b.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752670002; x=1753274802; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OQQHOH036lzK2/lR2CPj9pEdFWk43E3YGTCjm+aR+lY=;
 b=fjIOec696wB/U1uOUnnHZ8qAiPrrbVMwW85Cr63+gZwxwDnS7mrYictZqMdf9IsHw+
 PN2W1/N3KC/exkVz+WAhG1Wrw3vSThOQZbtHO6IDN98/yl/WtzMHxwjynbE9BvbAXcJO
 ccvT/MmOcK0wL1GyQuJQGMcFwJ+UZlNgWSSuKKScGS3bHbqxQPeR/JOop5sXJEbPgKUC
 qY4KO8dr0pt2wSdF9+Z8EG2BPhBTRaj+DPSevhDvHMTjD8Yxu4hfhJQRFpm3Gue4RosG
 c/WW53NqRtkQeD/3+pPbcU3beIFrgIxPkkuoQFaFZj1xIhAPXBgrvyLfje1bMf4wGHxb
 siag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752670002; x=1753274802;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OQQHOH036lzK2/lR2CPj9pEdFWk43E3YGTCjm+aR+lY=;
 b=JZtNH16DMLVT/G+//pzjZOdkc5GJFNElRQtI2j3BZihQ4U/oPzTARBK3mpmzHQw5wl
 Dw6yRTlIpgmSlbwZKuWE/igUZA7TcmsAL9I1x/UDVtD1xQBkp2Sztb9wSxQupyacstWf
 KLojmXRTAivzYn/qIjrnWLWv8FjsjD+xEsnnUhR0UBnhQ6YdHXElaOBS8rUjYCwOvIbW
 k92YnR0KsLD7kH1MZgN7LWl5jI2PW8NG+V1n7vENOxLwfDFG5KeFT9yJRJKFgvIGu5Mn
 eZzYuKw9EG34lGSSnGNRDzEPejGp+UTE7PbGl//U6EPUPycPJZfJnqNRwoqEi8o6XWZS
 niNw==
X-Gm-Message-State: AOJu0YwW3Khn4RLfmeQXttia+EIm/GM18dGF9Z8x+1fbGaSp8jNa2c6P
 ZUfRhFEpZYJ/TQDuWUvk7yD5eNt8eDpLps8f15jnDQZQMyUed/q4g6N4Pj7+uOo14inrVNPqkMr
 pqRrQWolCOHsPFSpMAPm3/qRW25QiPUP/IfaB
X-Gm-Gg: ASbGncs1YVAu9ocT+EFKWvczeu4y5zbE2mNRnktLnMfWOaoxMORnWFgvUDybi4vkose
 Q/5aWIZq23fYht9B7KjkXx8Xh9AyMLLiDvQkGfF6L5qOF2eshw12N9j/ys3oI7IpTb/k3av8SV4
 rYBy1CMXxQCmv1LCQ9bcaXhvn8eX390MeEXdLT48k7wOB9Z2h4/3oKryZFL/dgbUX0TonZSTpNo
 +EeAw==
X-Google-Smtp-Source: AGHT+IFAlqBAHI03/D7HAUUpUE2vRO8lMwadeUYmLfQT+sLtCbiQ5KTV/ceMnZWW6wecZu9m8h3AkHYVMoxrKMM5kdU=
X-Received: by 2002:a17:907:cca1:b0:ad8:e448:6c64 with SMTP id
 a640c23a62f3a-ae9b5d844f5mr503884866b.24.1752670002078; Wed, 16 Jul 2025
 05:46:42 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 16 Jul 2025 08:46:30 -0400
X-Gm-Features: Ac12FXwCgHkaJt4S-zotP2PiITTuMp5ihv9AewnEgDDlBW3R8PI9lgiiJ-uuSyk
Message-ID: <CAJSP0QUD5-4wSqAm7kfEiCsuoqpZ0nf4zcfumQO3=xh6vEXcxg@mail.gmail.com>
Subject: Entering QEMU 10.1 soft freeze
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x632.google.com
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

Dear QEMU developers,
QEMU has entered soft freeze for the 10.1 release cycle. You can find
the QEMU 10.1 release schedule here:
https://wiki.qemu.org/Planning/10.1

What is the soft feature freeze?

The soft feature freeze is the beginning of the stabilization phase of
QEMU's development process.  By the date of the soft feature freeze,
maintainers must have sent their pull request to the mailing list.
This means that features, and in particular non-trivial ones, must
have been merged into maintainer trees before the soft freeze date.

Stefan


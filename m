Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D08DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Vs9-0000eu-Nr; Tue, 30 Sep 2025 04:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1v3Vs7-0000eN-QJ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:38:07 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1v3Vs1-0005WO-OV
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:38:07 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 83EC93F861
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 08:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1759221474;
 bh=rxvoYiPVlV2AMiY/BLVsONmUu2KVIioLgihYH+EWT3A=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 b=j5Tk9103MdGY8/nBs/ukDHHgjEArlYhThSo3CM/jtfbzu2jAEy6hz2s0v1+PcJw3H
 yeYzmxpgtSxYt9ENFq02DoDW6r/ERGAGWq8lpr5rniLH9LIz2CxZsFb2vyQoOh0b3x
 +lXIMzlULxR4RP5hsHSSyLN2LPRa9KpHKRIKM+Lh/1klI+JLINfj2r4Bcmy90mY+Fa
 I6gq6KQwEPAwMpa93ajf1nchjHYz6OySJBv2DSk/kEIHHhefV8dB6c7dTr4udB8+FJ
 3cqSct5MhFYxk63e/0GgdHAB5kXQnofwTzKYNTmCVWll8+x/aWHhT02UBVSfxTSxof
 OwYqRx8hiMHWQ==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-634ae1ee0a5so5428514a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759221474; x=1759826274;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rxvoYiPVlV2AMiY/BLVsONmUu2KVIioLgihYH+EWT3A=;
 b=JhtsT4GtaXJgeMmrrMvIE2Q/UMHXHGHx9kitJypA0IrCkuV9nEXEd+yAHyWmDAfQNp
 FPXTBjjnvTDtQ70trUwN7ojNA7EHNfzsI81DQCi6mVAi28Thw2LLmwqCsK/G7XIBRVqy
 O43bWgWhwrYJJvpXIJQKPZT4Xn8100Cdx8yrGGbBM1i9BnQX7i51rVwsbwr7OBzbugse
 Zx7gjClrp8ARIZX/PuAQTNXCKVmFi/F8PMUOsQppq1/M9VvTLJJAHhpEWFTPKhdXqk7w
 tczpjg8OW6lB3cwi/eoHuVRZBt+dJpx+HB7MG9MD5umn33FE3XFTK3dmosLyIz7OI+2p
 i7ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIb8nU8yDH5qWqmlW7iFMzSdWbSHFDp2fSBsmkuzB3L2M4PppgcjmUn8zbWLBLYFO7tsBMvLli5uwQ@nongnu.org
X-Gm-Message-State: AOJu0YyJ+PD2g6wBhj8mQYI701aDBSvquFb7lKtclVnWyRA50PCr3Kgg
 xgfKIwTtMXl7WizLPGDf+K/RK8VKvB8nXrEaDZJ8LHXjXYVqijgiEKb509mw/8qz7nxSiJjE1Q7
 wuWi/NU38LtOTbcpOsns90IEpfOCMM2eBayzqU0gI0RiSu3jnm5rGpzi0gl+aHjNG8ddpSZFLkO
 Q6RTPrIKpzPlpXG6PK/3xuHhs0Cln0CmcNNwPHJ3axhhRs2Fs=
X-Gm-Gg: ASbGnculxfuWahbuGsG8IYOoygIWaCB0ApxJvcNxnHJUchjot964nqElUtSdBcbaP/h
 SG6KbVMwCfbfeLLWoYsnTprnqHTdWGM+VmQHfYgzFsr0UMBNwBdAFPolp+adV8eHqsRcNT1Pm63
 6QGn3CUdT6zM/sb/yLfprGaY1mFC5TGKv7O2jnCl80q+ScVLIi86+3HZal4zHIpxJ1/cRHm7U+c
 94bpot2hzfU46Xt
X-Received: by 2002:aa7:d588:0:b0:628:7716:357c with SMTP id
 4fb4d7f45d1cf-6349faa99edmr13099313a12.25.1759221474004; 
 Tue, 30 Sep 2025 01:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8kz0hbFup2GP9gwTRW2WnSc6Df0hE69z4ZLlIRQp5/6eNcIjQdFoJOUTYjxjnr36JGMUSHNDryCm3Ydp+kq4=
X-Received: by 2002:aa7:d588:0:b0:628:7716:357c with SMTP id
 4fb4d7f45d1cf-6349faa99edmr13099299a12.25.1759221473674; Tue, 30 Sep 2025
 01:37:53 -0700 (PDT)
MIME-Version: 1.0
From: Hector Cao <hector.cao@canonical.com>
Date: Tue, 30 Sep 2025 10:37:42 +0200
X-Gm-Features: AS18NWCHCkc57HVkKlf31P1ehEI_rAX6KV4RyQVU4mQyflxqoIc5G1q66J2tXZM
Message-ID: <CABjvBV5MgSnf28WO9nqE7VpsPkpHJ1wrWsVnua91HfCsTkwMGQ@mail.gmail.com>
Subject: [RFT PATCH v2 0/2] Fix cross migration issue with missing features:
 pdcm, arch-capabilities
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000005198f064000abd6"
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000005198f064000abd6
Content-Type: text/plain; charset="UTF-8"

Hello Paolo,

I tested the migration on both Intel and AMD CPUs and the migration issue
is fixed with your proposed patches.

Thanks for the work.

Hector

--00000000000005198f064000abd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Paolo,</div><div><br></div><div>I tested the mi=
gration on both Intel and AMD CPUs and the migration issue is fixed with yo=
ur proposed patches.</div><div><br></div><div>Thanks for the work.</div><di=
v><br></div><div>Hector</div><div dir=3D"ltr" class=3D"gmail_signature" dat=
a-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div style=3D"text-align:l=
eft">

</div></div></div></div>

--00000000000005198f064000abd6--


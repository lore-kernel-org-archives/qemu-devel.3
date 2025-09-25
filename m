Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E4ECAC5AA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 08:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1hXa-0008O3-0u; Thu, 25 Sep 2025 04:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1v1hXX-0008Nq-VZ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 04:41:24 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1v1hXQ-0001ZA-GG
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 04:41:23 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E77143F94C
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1758789665;
 bh=6h8lHxgWeK4v8KPEtoKwoe1WC1MIiH6bwxHaV4HdlH8=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 b=s4NX36xOGH/rRsrkOjfQcQyc5F41f7QhfLgNwERklKtVBuoZgJSeQwADwIqVEvHNO
 eqzB//1o16RximaWZdBnWuQoiQC8TgNxbj4T3w0L4zKTqI6zHKfHNZbnGlzUQucfU5
 cBjo2rQuJWkvLAS1Ti6UQU46L2hG0yaL6GT48Rhp2FVsE96z8OEQ+5FrBiED456e7i
 8axJVgb+UqokAMC3FlVQ6eGAqw34mKb37mipjefDRH//VYkkoFy0wQMbrtSgjnYsh8
 T8LQw43LV2NKaBDXLS86hXRMrtW9lgWaW/WF7/2PoFFuXvh+LbHsqBGShSyCL0qPjo
 48gbnyRscLUsw==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-61d32034b66so1894292a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 01:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758789663; x=1759394463;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6h8lHxgWeK4v8KPEtoKwoe1WC1MIiH6bwxHaV4HdlH8=;
 b=PVSDS18ulENq78aORVujpo2Jr+l8PrZpPoTMNULeSkRtWkqJLtg5VU4f2B5uKa9eHL
 uFSk6ThOzHV5LYp3+pXDdtCabPGcx6S1pHP02H5mNpD0RDUYvVA/DEK4X45SBzdZ55F3
 cSgqwishOrmLbVU8ugJLMlpaSWDKoWLTHbte++EO9PDWMcVgd7QHMwO4ofnSoYDjzb3J
 /loXLhNzD+2KPmapGLfOIR/G/motGYIFfQfjTIXJ/0d5AI12r2Dh1mhOZkz3yxjAIGmp
 u8/jgy4alSYOG/5Ochn2BlyqpkHiE3GIokdfSJMW3NSpsWiOl1l72vPWP91yrrRFqyMf
 mUMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5tNMOUngMUePxsSkL6orDd1oRvWfmMs1JGPNBNw42PPZvGGaos8t3cGnx8dA9uabPgR9/MkHjEPI4@nongnu.org
X-Gm-Message-State: AOJu0Yz1ORd1MxdCjAt261sRR8+WEw5MGqSsM1d+DsZocIimoICiltaC
 MwKG6EloRCK/s0PMrD2CK22fxN5sY+RMbT6hjE68rLUfwj3MEoqVOKTsH0EP06wR6K/2ACUSq6B
 n0tBm3TUy6oNFpRxIBguOS4YWMnGc5aKgG3Vk982OBj0EfUZqotqdMV+xqpn0LDr1WBfhyddJFe
 WdjMlSjGcI8D+KtCMUALTBjz3hKoVjxFYOrmNf7mIwHol4Fnr73qSdrArabL26
X-Gm-Gg: ASbGncvk18IgV2nAZXQPAUttbTm2d7TEIcD0Dr+EyGg3/owdA99nEpNM22eipw8s/D1
 O9hYHdMlirCSY4xWEiH8kJB6sRIHh5iw4wLJ4BLXIjuHJlvuFauOc4qCXqS40Q/BxqoLbwAZb1G
 oHyOS9i4nkPgykd+KpKIb0jEV3GZjLNc8RqRCpzdRmE2I6Fj2k5VWhLeDYLhT/ksRa4tLia8jp
X-Received: by 2002:a05:6402:4614:b0:634:9acf:f33f with SMTP id
 4fb4d7f45d1cf-634a335aa7emr1621641a12.16.1758789663497; 
 Thu, 25 Sep 2025 01:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWc7a/W110MzRES/AnoJELX/wq/ztwcH02Jbpyl2Jlj156mJHE2JDz2FqU8T2JJtfB2m/20klNqe8+dUAVAqU=
X-Received: by 2002:a05:6402:4614:b0:634:9acf:f33f with SMTP id
 4fb4d7f45d1cf-634a335aa7emr1621631a12.16.1758789663086; Thu, 25 Sep 2025
 01:41:03 -0700 (PDT)
MIME-Version: 1.0
From: Hector Cao <hector.cao@canonical.com>
Date: Thu, 25 Sep 2025 10:40:52 +0200
X-Gm-Features: AS18NWDGIrKehDxhFhG4PfRoFpCV2lOhgNuIeG2166bJk8Lf3vKVB_Q3qLCX0Ec
Message-ID: <CABjvBV4Lgih8dJneZnz66Yd0LGmrmJgeRvN1CZHFKLcbaCcb_Q@mail.gmail.com>
Subject: [RFT PATCH v2 0/2] Fix cross migration issue with missing features:
 pdcm, arch-capabilities
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000001a6d1f063f9c21c6"
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000001a6d1f063f9c21c6
Content-Type: text/plain; charset="UTF-8"

Thanks Paolo for the great improvements you made to the original POC
patches,

I can confirm that the migration we had for Intel CPU (Haswell) is fixed
with these 2 patches.

I can see that for arch-capabilities, in addition to the
compatibility property, you did slightly change
the behavior by limiting it to AMD CPU (other x86 CPUs like Intel will have
the old behavior prior 10.1 so no migration issue).
Do you think it is good to make it clear in the commit log ?

I'm also trying to test on an AMD CPU and will report back.

Thanks,
Hector

--0000000000001a6d1f063f9c21c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Paolo for the great improvements you made to t=
he original POC patches,</div><div><br></div><div>I can confirm that the mi=
gration we had for Intel CPU (Haswell) is fixed with these 2 patches.</div>=
<div><br></div><div>I can see that for arch-capabilities, in addition to th=
e compatibility=C2=A0property, you did slightly change</div><div>the behavi=
or by limiting it to AMD=C2=A0CPU (other x86 CPUs like Intel will have the =
old behavior prior 10.1 so no migration issue).</div><div>Do you think it i=
s good to make it clear in the commit log ?</div><div><br></div><div>I&#39;=
m also trying to test on an AMD CPU and will report back.</div><div><br></d=
iv><div>Thanks,</div><div>Hector</div></div>

--0000000000001a6d1f063f9c21c6--


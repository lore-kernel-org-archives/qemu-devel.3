Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C8606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Nov 2026 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wMal4bYy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xXBuE-0004XX-Pl; Sat, 28 Nov 2026 01:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xXBuA-0004Tv-JW
 for qemu-devel@nongnu.org; Sat, 28 Nov 2026 01:27:27 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xXBu9-0001tX-2C
 for qemu-devel@nongnu.org; Sat, 28 Nov 2026 01:27:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso83501195e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 22:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795847243; x=1796452043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wcZBeuMIMZGh5V5Nkisgmrflj3EBBSr6rcajrufM/Cw=;
 b=wMal4bYyhw9L2rLHaTHSiHHr0Pq4jmtpj4dSgaaYAhBbUdl9TX3bJnr2oWAsyNKyMk
 cUN7K/Zt+6PfOMtgbJs39d0/E4T/XuogKSUg1veQ+9fAGTc7apm9B90RnXLJtv0wqd2j
 Babx+dnn+5SfVFXBKkeZ+5QCiCUKtvm4YgkxhMwnEPiWCf9Uk8wOxq0djFftE9iQh5J3
 Jx8ealg7bksFb48T5zDPwCwOPlWZYdra9seNEmNUg++zZvBJgxhv/GsqMIGan3R6qU9d
 4dJoiS+zXueXSAnXNYYkKdkZ+E78O5X96BegHN62JVQV12jKQGOAJQ957PbBK/cWwPk0
 pZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795847243; x=1796452043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wcZBeuMIMZGh5V5Nkisgmrflj3EBBSr6rcajrufM/Cw=;
 b=f9HwNFXRWSkBQ5LWmDU0tGFbUZYF1xJVbR2maVWA2e6tvLOfmCO4dtD/5aINifvC5B
 GMsuWEAQkYPiY/cIOMSq2k6tILpbKxr+7fBEFNGgB0mmHe0TQDMUWf0UjA13TAwhQUgo
 3nej8VQjFnlqccH7ZC4XianqTqo8dIyZiFV078d5PVDkdS125LJWH4w6uFPveiY1/6JK
 yaabmEb/WD9/0UfwJd/K+rjd+EKFMdOSCyKdHCAB2K6akJJbBbT2y7ju3zV6qAG6EfLD
 9lbsaeIt8lx15SFciuvoD9gMt0U4b+HYEFvgUjWhj1GT8R7xo/lbdGIG6LqGUp5uid81
 6bOg==
X-Forwarded-Encrypted: i=1;
 AL+hErHVwLuQYFWWny9yPWBf4GHM4OZDRYsY2e9z1CGOjGQrAtJsTG1oG00D/kS6fLJYsvxXUMtz0+Urtcp0@nongnu.org
X-Gm-Message-State: APuU4Z+T+bfS/S9Azc0TmV9KuuR8wRO8+bX0t+36LNHiPWZYCV8qfAxU
 L1EFFLC27/TDJNyN6Z3bVHV7Q0OJlaR4qNjKpiyuwwe4GNTQWNYvI4zs
X-Gm-Gg: AZFdTZd8k+Z5MfjINCd6+yxzb3GjWmqYkHzmseuayXheHl5USaA/iADUWtKqB24Am9d
 sJyZOX5Qk2m3Y9sRzda+agS/QCEZ1uhDxUjGI1Rfxot9hwTIuaN1x8lyfTYxQCKWV8o9Xx0PaPR
 ye6H2opWhKEYaOyUSDaR6mSYo2a20+sF/ra20DxGrTH5pG0/JIEZm1P5Q8Kf0vfo43Ox7JpdiE8
 JaPnwkavXceO4LGqrpE400hIF/K16MaY2oxAl3pigs4W50B5pv54pB4Tm+0JHkZ1NI1JPz8W9cb
 cqUFwOlMHqNtJehwXOhU4nj05ZVOWHXfAkmOQHtmZy+EmF2+RJYrVMSglKCR7Hipdy0Uv5jVARd
 WH7OooG2habZsfUyRvNl3UY1TrExa+dBCnf8Egh4ZYfBSAiFo6ME6Ll+4Eu9PiWHGV4hIzeQbIl
 iaiCXcMw8KhepyzNQJ8tRzf7wdhdVLisQsJMlb7qhqNYnWMvWKQ1OC6t/ibTwsHH80Cz5yG+Hma
 mGO27kb3PE1ojxMenlY55s1Cxa2qIpPXxF53eZabHhIqcEVnLauA/UN+ijFc+V1OxaEd0S4+vNY
 dsZOntXE8kl5JxFvrlSxswDzlCXNtThFnmtbF3r79dPGPuGE36+Vsjh8TStyI74zqxJHJBXI5vC
 oGfo38L3YQLAgq8kPV2JCw1yj
X-Received: by 2002:a05:600c:1d8c:b0:4a1:c5eb:b445 with SMTP id
 5b1f17b1804b1-4bb88820436mr553100495e9.35.1795847242750; 
 Fri, 27 Nov 2026 22:27:22 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm685756885e9.9.2026.11.27.22.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 22:27:22 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Haseeb Ashraf <haseebashraf091@gmail.com>, Eric Auger <eauger@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Khushit Shah <khushit.shah@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>, Marc Zyngier <maz@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v3 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
Date: Sat, 28 Nov 2026 11:27:15 +0500
Message-ID: <20261128062715.130056-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9746F4BB-6688-4B39-AC6E-DC0295599927@unpredictable.fr>
References: <9746F4BB-6688-4B39-AC6E-DC0295599927@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

Thanks for the feedback.

For the ID-register cache, I can drop
kvm_arm_refresh_e2h0_idregs() from this series and let Eric's SYSREG
series refresh the affected ID registers generically after property
write-back. Please let me know if that is preferred.

Regarding the interface, there appear to be two possible directions:

1. Keep VH in the SYSREG framework with an explicit init-time
   exception, as in the current RFC; or

2. Introduce a higher-level CPU property:

     -cpu host,vhe=on|off|auto

   Here, on would require VHE, off would require nVHE/E2H=0, and auto
   would retain the accelerator's default behavior.

The first approach follows the SYSREG_<REG>_<FIELD> model, but VH
differs from ordinary writable ID-register fields because its selection
takes effect during vCPU initialization. The second approach keeps that
implementation detail out of the SYSREG interface and lets each
accelerator evaluate the requested mode before vCPU creation. That may
also make future HVF support less awkward, as Mohamed noted.

Since v1 used the separate-property approach and Marc objected to it,
while the current approach adds an init-time exception to Eric's
framework, I would appreciate guidance from the maintainers on which
direction they prefer.

For now, I will wait for that design decision before posting v4 and
will adjust the implementation accordingly.

Thanks,
Haseeb


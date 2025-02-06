Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E859C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3X7-0007J0-8z; Thu, 06 Feb 2025 10:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tg3X4-0007Gf-Va
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:11:11 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tg3X3-0000on-CP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:11:10 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dcebd8604bso1361601a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738854667; x=1739459467; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HGcJvmPsA6VpGt/KK/cUj81/o/UDMPIaCrtDZurrAUo=;
 b=Dp+UZX2IQUdmqJgL4003Kq/rLnoR8v7mmq0sNQoAjtOYZouyPObbHSKmeXnUNyo7J1
 gWfoGmKX+FDzUtTVF72RdrdM609UX/LzKYSIPEaN/J8q/qAd8geMyyMV3zix55i+L0BK
 9vL9rm0kI2sfMcmrr9eWE8IMAKAvNjpuiv4HQr9GiohyvAQmV78fzl5Sly1AIyyDmQA5
 eLF2oh/1S5WaKxrGRWq10r90wFwC0Jbt0lRzgqf1DPhfazPhuL0IjiXIc+eLAQOtlDOA
 aV/mu7UjsOLLOEioNGqaTRR5V/oR6l4xJ0cS1DOQtvwQhdigAfaw8+GKbpYL6VWW+YbL
 7Exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854667; x=1739459467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HGcJvmPsA6VpGt/KK/cUj81/o/UDMPIaCrtDZurrAUo=;
 b=unRuUemS3FnXAqMYd1UJovdZYkpv/7JBlM5erzYnmMuK/FbtbxlrVJF1YQ1tT8nCKb
 w63xkPWz30sjLrPg/q/34rHALCwLz0Kv/1vCFcCLTPU/TNTW0cj46K3aQ8dixYsKNak4
 qXvezJc4wifBFwD80AsD3T64HxGrYTpNb/zgaXtf73svfg2OyrnDEF3flo5Fj8+SNnfE
 4I5CiknbIrfwSELi3Hv74n+De0qW/TuNXvteoAeLAG/VJzXfsdVg4pFgsFQA03W7y5vm
 lG9efnC0sBsZBBAgxL8l/u4IPGYZx3mYjpbon4vMgPEwLhmcF2QuDfyCAtqqLlAbLKrY
 heUg==
X-Gm-Message-State: AOJu0YwCFGwugpNScNJgS/xXQnKJx9DD9X0Pp9bIpyRT3al0XkkVePZ2
 HMJejXYwRRloLR0kk35ywnEC0W7W2HplunvvS8JUaf/tsNMP4Ll3cktK77iaVnYbCIxPAt5Yrcj
 zm0BlgvJPm5lP/e7zlUid49bLblw=
X-Gm-Gg: ASbGncsdLzQtMyQ2wmdWdScvUgHK6aOMRJmTe4BwDDJMa4CwM3u3X7FMohwl+5dv83Z
 PW58SVcnfzYZpgLCEfw9epNz28JHFEE1nMRL4J1V1CYLJAsXUxmPy2ldo20JjdEVSaoml2h8=
X-Google-Smtp-Source: AGHT+IGP3KVjBq5joN2hvizSzR2CKIpkxWd+Wdla18g45vM5djnc7fvnLtfJ60Q3uZWqhnRyk/4SDaN62BZBaoaRfkU=
X-Received: by 2002:a05:6402:3506:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5dcdb775fbamr17536301a12.32.1738854667203; Thu, 06 Feb 2025
 07:11:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <Z6SCGN+rW2tJYATh@fedora>
In-Reply-To: <Z6SCGN+rW2tJYATh@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 6 Feb 2025 10:10:54 -0500
X-Gm-Features: AWEUYZkEgh3cyBoslP70EQWlaP_AQzysfImv92tTEUARYq7n1jgef6N53O8LJYM
Message-ID: <CAJSP0QUn5HHXKnxgt-Gfefz9d4PmRzPbgYv7Hoo=wcyO-rwQEQ@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Bibo Mao <maobibo@loongson.cn>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, felisous@amazon.com, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
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

I have added your project idea to the wiki. Please make further
changes directly on the wiki.

https://wiki.qemu.org/Google_Summer_of_Code_2025#Adding_Kani_proofs_for_Virtqueues_in_Rust-vmm

Thanks,
Stefan


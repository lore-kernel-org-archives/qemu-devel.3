Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89E5C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 05:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s22vo-0003i9-SW; Wed, 01 May 2024 01:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s22vl-0003ho-Cg; Wed, 01 May 2024 01:55:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s22vj-00033M-QX; Wed, 01 May 2024 01:55:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so6217448b3a.0; 
 Tue, 30 Apr 2024 22:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714542897; x=1715147697; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaW/UHZT2YxQg9u50HEufJirVFyT/Y2nbp/0zqyBRq0=;
 b=DtUxZURHqSexKNsvtNJ6/g6WgSmFU5tJ4oQeyEA7VW8kK3jlooETIi7xB0CE4Z89n4
 ht6FJG3zX4dWSs1/uM4IeSpMQM1cr2uu6zJ0ieKvL3BhVmJx33b2rvTalXZEBBqIt/i/
 CS2QMNQfRMrCsM67pNj0bHPQnfAD04vFclrGKEVQ3Pzj6E0cC7m74rP5u0dPFyrs3KbH
 E6hzYK75XNufcUonz0diecpH5o5YKXMFGRmbJG0zJPcFmbvAhC/aP0Z/LOwGLq8d+5hj
 e6N2hR32Wn/IRdLAubQh2rkcXQ5p9rudbB6jWkHHh8e9jtDts28ZOQiOqJfIKKeQCrcD
 /J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714542897; x=1715147697;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CaW/UHZT2YxQg9u50HEufJirVFyT/Y2nbp/0zqyBRq0=;
 b=lFNigHdPteHOzMbIeHsMBpmDJIG89iGsRXhyTKJ4FGsgcgivSD1COfCz+ruiwiB6s6
 j8/pMSyhS08LVRcPIKbHpnR3jiBWUe/GcZy35zJpJ9nb8GF+EJcDxyo/rVD/xmiZtjt5
 mfkWcaLdbCkRF+heBaprY75S4IbiwY0pOmAZJSjv1HOzQX4Oii2oi/jqEH+FU24KWRTm
 WUWJSOSyG8bXOeV2eg/9VAE8EesvlkRKV2RbYXxmBXfmJLrCKpqchvmLcIX4IEj/ETzt
 il7EwrC2ptE2vEoG+WIRiMXhyoP3xpMwjeLZm1ysL2tuYZYgUeGuI9hX5mNQ94DG1SYn
 1w6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG6lY5eAu0GcrrlkMpEVkhtZJqEoXQL3tIrP7ffWRLBzFzIIuv49aAJ/SlXiU9KXkKXoWSEeOP3irld4o3vZiUctqo0d3UlC4HyKstYSGDJPSyI+ZTE0trIyo=
X-Gm-Message-State: AOJu0YzV4645Z29EiwAF5xEdihraLMH/K5dxCkhLR9tn6BJa2qhg8w4p
 tXGdgyotNFftgqULjsoJe2K/WKpydkqaxOvbnxYMnNQFBrDe3BBr
X-Google-Smtp-Source: AGHT+IHJvT6Fg4nMHB9Q9VXH0s2+pUjPzG13vTCPio4+zVchB0/BZ9+gJk70htQQUSwT0nq/Td+hLg==
X-Received: by 2002:a05:6a20:d04c:b0:1ac:e379:5548 with SMTP id
 hv12-20020a056a20d04c00b001ace3795548mr1559268pzb.45.1714542897484; 
 Tue, 30 Apr 2024 22:54:57 -0700 (PDT)
Received: from localhost ([1.146.19.156]) by smtp.gmail.com with ESMTPSA id
 ei16-20020a056a0080d000b006ed06c4074bsm21995010pfb.85.2024.04.30.22.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 22:54:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 May 2024 15:54:51 +1000
Message-Id: <D0Y2QAXQNIIJ.RFAE3TAMRXEQ@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 00/24] Misc PPC exception and BookE MMU clean ups
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1713907038.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1713907038.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

On Wed Apr 24, 2024 at 8:31 AM AEST, BALATON Zoltan wrote:
> This series does some further clean up mostly around BookE MMU to
> untangle it from other MMU models. It also contains some other changes
> that I've come up with while working on this. The first 3 patches are
> from the last exception handling clean up series that were dropped due
> to some error on CI but I'm not sure if that was because of some CI
> infrastructure problem or some problem with the patches as the error
> did not make much sense. So these patches are only rebased now, I made
> no other change to them until the issue is understood better. The rest
> are new patches I've added since tha last series. Please review.

Hey, I'm just back from vacation trying to catch up. Looks like a pretty
nice series. Will take some time to review it.

Thanks,
Nick


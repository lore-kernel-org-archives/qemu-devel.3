Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786D606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QCFR292/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRr6F-0004pj-Cq; Fri, 13 Nov 2026 08:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRr6D-0004ol-KI
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:13:49 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRr6B-0005oV-U3
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:13:49 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67c6a0abc2eso954150d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:13:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794575626; cv=none;
 d=google.com; s=arc-20260327;
 b=NKD6v6wUdN46wf6ewE4Hxx9rgDKI9dubsiQbpuDkZzAynUkKEO4j90KHlTpbv3TIxV
 vE4kmOeDHuFfOsJd3EKoU7lD6wpao46QbgOWYByg9ay4Kt2yxJTDwNDD+gfaRVYvBw6o
 KdKFTE27tPWTe8/jjWWhb1UWLIH0QMor6f3ljMMeGZeWGM6J0I0RMSDuWJrdZv+bxGn4
 2ShspbG5RLJ06b1qANlMYZYm9E5RMq7mlPPsOPkIYWVR15ijq0qR/CtExDzLXwpo/eJq
 R5/DspgHpGDNhNS8sKYZkdEL6ka7g840h6A2Poz1X5JYbUcqlrVVDLYuB3+zfrqFct50
 sdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zk7bmnZNXj6cnN7LQ19Cl7riQmoxwTFpgUG81aSLYDc=;
 fh=auXky6MbHvI/BelePkZYald8UfencEibALzsoTdXrYs=;
 b=srGUpHsAT+7fe3cM1UQ2zcM+vTzdL1gIGFzMTA5z1eUP701P7xUb/0HXrmf2/e76EX
 zLhuTmIjkSKRrxjSnCOEVjBa25hPfB690/2nzWnB1tLZmiDCDf/f48yf1UmQSCQIOTlE
 ticepcRhJd/BtSIuBmTLo9zZoh3YjMzgdwpJisvObdSJrD8QQz56M4jJvnPa4JE8dsy2
 BTOteOOQyo+WbIu+Ilx+0PSxBAUNRajUm7kL2QVs/JDMaMxaB4iY0NBBjo3CxPCfXnuU
 dhpcYG8u4eGzx5PgVwcVgO1lG7NdYMW8KvbI/k2CICVNCiavexo/7uWB7jvrejxBmMDu
 3wUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794575626; x=1795180426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zk7bmnZNXj6cnN7LQ19Cl7riQmoxwTFpgUG81aSLYDc=;
 b=QCFR292/KgWjiX2TsYxRK7SC571QX+nXaoo7fKkvgMLVaNCho0PHJMAddYS9YCqos6
 U9Ibbw+4TNDcU0g+0p/kO47yR9VzVkBuWGD0cD0qPucjLbPrv/wrmIjcHwPQB+xQmkku
 +hK/0tDWhDC+YXaY/B+O75vcKJF7pzsnps5yMgU8IJhOQFz9mpEFWMK/5N3bDcGn0dDT
 Xc1ZHsnMsF0jFqQ+sYgYB7r9MEmszaOC0/RZ8Iu4wM7nPSPJVA2jE0AOTmDLthnWSBSw
 uBG6QiL6CPzyPvhZeKYWe7oCeYC+yQKflpFZTmFl/WYbt3F4sfBwpZ9S9wV/rxA4cJqt
 eSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794575626; x=1795180426;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zk7bmnZNXj6cnN7LQ19Cl7riQmoxwTFpgUG81aSLYDc=;
 b=Nm/aGNnMA0EDx2t78/Qd3g/9Aw1bvQbPaZx4aFHPa8S4dsKI6fANy/P8tUmRRMT1zu
 JWPLAyYjhlSbiaE/DZYTbcutAhp7hdSnLEqHXHA2wovu67iSisKxgmsV6ClJjSFatdAr
 vLW2cBnunT1GC0gwfMlWl+6YHkJFkPDVaAMwAQHdWrwGL5IvudHQrAvodu6EdpaQxjm2
 i5BX0VUiJv0corqBhukiKRG5o9Ep5Kr45ifL7/p+a+zEByd8FPAkcAgtSTfHxNhfZbDH
 1sflNRF+8YHPZRZsKh2+pxKjqa2g9GJ/ASeUJBgcf++5jl3JCzDc1ofNGKelKoxfc7DB
 3FFQ==
X-Gm-Message-State: APuU4Z8jguuT/hWOVDKejCuN/cm7oQUTfJPEbBnNoCAeiVgJBar3mJDj
 NbrXIT36Gf6BHmGoDLpGoQYk2MhAg61RfUEwsTm3uu/wWiAqU+cHqlu07o2ZJzLVkP/rGvWaOFL
 O/l5qgMUXvik3WRDtpmNTMNRg/MDF9jxTz6xgpxK3IA==
X-Gm-Gg: AYBFou3MS9s8lUv8cqmB03JTXbZPpvBcpbpZDs8nfqsk1R7o964M2K1Rbg4bbHrJMCs
 f2QuS4SHL4NmmG+dK2HCZc1G0FcfqMhx/c1VqVTmeiovJxSNLw7WvB9A+NsTBhYrdEWJgPFmfBc
 00MgkrhWtY7ufLYEvLv5/ylXWAxg0miWXroPj3Ur+9BnmzLN6l+6SWvdPO/tMckHi9I5AmNVpV5
 cHbMEkF/om0XFRFf42rDrssl69YCU2Nfecx+XPNpCVWzMLIxEuS5ydPi0TkQoZKUeJ8CKFVk0Od
 KBnF9jV8OaDbzifxJtwROX2jEkuWF9t1fE5KV2VwSYnrWdiPZD6ZekRxx2EiwXVlp6EzNzdkB92
 Cij9OaTbpSNk0RV/K/2s782BBSKoFs2k3AW/9qw7D9pRUgkX0acC8PRGKAFalOYYb82a+6Ujp0i
 KuhnYvTWfMYTPhAxMdFvmB47agbo3g9v2iAFUzwOIoCw==
X-Received: by 2002:a05:690e:4886:20b0:679:980d:9989 with SMTP id
 956f58d0204a3-67d895e4676mr885362d50.30.1794575626257; Fri, 13 Nov 2026
 05:13:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113004452.3027978-1-alex.bennee@linaro.org>
 <CAFEAcA9YSmdh+FR8VEfxZcn3nn7tb96M_2d6Axtf+_-Uk4ekEQ@mail.gmail.com>
 <CAHDbmO2RzYGJ5UDeGEHHTRGmgvXknu7eQ+By57AYuPaY8uvbrw@mail.gmail.com>
In-Reply-To: <CAHDbmO2RzYGJ5UDeGEHHTRGmgvXknu7eQ+By57AYuPaY8uvbrw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Nov 2026 13:13:34 +0000
X-Gm-Features: AclHuK__r0rGJ4HMWqCyvCnbpPllroVhuHiuHQ87ROPCJYcgtHFoU7syoEWHNtc
Message-ID: <CAFEAcA-bk_BeU7yffUqZo96NY3EkPbx-YPaCU9gp6Kx6GKV7zw@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert ".dir-locals: include QEMU code in PYTHONPATH"
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 at 12:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Are you happy to take via your tree or do you want a PR from me?

I'll put it into the pullreq I'm putting together; thanks.

-- PMM


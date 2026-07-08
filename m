Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7685AC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whR5g-0003jl-Ce; Wed, 08 Jul 2026 08:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1whR5f-0003jV-Bl
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:09:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1whR5d-0005UE-OP
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:09:23 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc827a68fbso1338995ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783512559; x=1784117359; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xIwGmMScCNda2wV8XIYMCjyqYevP8jNLtpsQzxgFY9E=;
 b=nfLhqQVG4EYRtDo2Xwm5Nym58XPRHHWsa2JGWv5c239FUPzl9yWSmdhAETo7v0N6JD
 zXa7lpM4OaebrqPQgnHuMDrCAfJuW+8kJzOWFIKcipAYn/dFG+H3Bug5e+PQqPm4TCOE
 XY1t+SWvZ8LPOeMYuj15cI+mzEzMLpbWM2DKN/lNrAiXsFaQxxKgornT9/JCEC79f08p
 nlBouynMLwpCKiPGEhDNwNAqW8BTaJWAmyPh13M2sZyijYwegxZRzfxNwkK9+6F3MkL2
 3FXjWpfczIssGOyALwAjTOrx7S26TZVRaFG0HJoCxo9JKOvHSQSi3nQXCAEvzFGx9JtZ
 ud1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783512559; x=1784117359;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xIwGmMScCNda2wV8XIYMCjyqYevP8jNLtpsQzxgFY9E=;
 b=jUJNF4Bgq/zf+CdH4IYYADRRoQorBBV197Pz8YTXUfLXWI2cXvczGxOTNnVRmKuoSO
 0JmCwGSvd+tUScgHcFj0SBDVP8AY43HObBDWTyeBcMQwXTqj437Aqmz/8JgsYJiP7Ixn
 a7OnK/MirE4bNKBm6Nj+7AnQRy/NssdLPNVmYA2NUQnQXBcJD7zOEm82iBCYbhwD8UfL
 dyHW9TLpMEyKhjm7oRU7ekzn4sBxlBWR48v29rEIWPKF6zYOyQTFjNUkCIkcaAQH9Lgd
 9zlmsyUPuRiTAkvW1zmQzTvKzmRMvX5oUg/vFkG3Um+IUOHCNPN2tb8c1rLTpurs9pXW
 CQQA==
X-Gm-Message-State: AOJu0YwtRasHHay3ELWuiB9Gh22SBda2h217yIs+YIpgdyPQYfEgOLh6
 obCIujdLt7bylwPoTd1LisDQXTv0nC/ZY/aWMUQK3qXzGL73Y9k9T8z8R1n3TIii
X-Gm-Gg: AfdE7cmQ6kpA3ErRdqHx7WKbfDWC0/JFh3Sx60p3h13FpjjN4Vv751dQUPVpfSm/nuQ
 4VCsUoQQPXad5MHW3bJxgxYAfokVVmJVaF6U/EcqlUGMRnLp7Vz2oV6RKak90I/ejfZueENQv7/
 XPt7JKybyS+YLHGrnjhh6cou1aPSjwsT3dnJC48t7m3+Ydy+w/qtDW1d0R9lYKAZzDL2MR7N5OR
 rpa/izC/C+YO3On3ussrFFCKNHUVc00HupizEPiDF3qkodCPBT4YoOeL7GchZvztJc/q2guLioX
 vF8zHUnJQQLhIie6AfAzSRVfR97PkhgEXk4qc14iWD8t7bV8KyAbHB/dJk2grWAbahaqLnryx3b
 qeb5lK/NUOy1MNGtPkKigFhTsIMpdyFuBhtzSeueQwg0/IZdggT6aRZLHkd2Hyi9fOtGG4/2W4p
 vjPgoToJWI8fiU4ICUOMC3Xo5d6m5q3n7SW6k=
X-Received: by 2002:a17:903:2352:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2ccea2af751mr17330575ad.2.1783512559290; 
 Wed, 08 Jul 2026 05:09:19 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e51sm27424045ad.76.2026.07.08.05.09.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jul 2026 05:09:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] target/loongarch: Enable TARGET_PAGE_BITS_VARY for
 loongarch64 user-only
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <2018af95-66aa-40c6-b3eb-b7bba9bd26a1@tls.msk.ru>
Date: Wed, 8 Jul 2026 20:09:04 +0800
Cc: qemu-devel@nongnu.org,
 Song Gao <gaosong@loongson.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A00A6FC2-6077-40F6-BF48-4318A2BAB9FC@gmail.com>
References: <20260630-loong64-vary-page-sz-v1-1-1d1a894674be@gmail.com>
 <2018af95-66aa-40c6-b3eb-b7bba9bd26a1@tls.msk.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=shankerwangmiao@gmail.com; helo=mail-pl1-x62a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> 2026=E5=B9=B47=E6=9C=888=E6=97=A5 19:38=EF=BC=8CMichael Tokarev =
<mjt@tls.msk.ru> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 30.06.2026 10:56, Miao Wang via B4 Relay wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>> Hard coding PAGE_SIZE to 4K will prevent user-only emulation from
>> working on hosts with 16K page size.
>=20
> Doesn't the same apply to all other targets - hard-coding PAGE_SIZE to
> 4k for any linux-user target will prevent this target from working on
> hosts with 16k page size?

I believe so. It seem that qemu-user might have trouble handling guest
with smaller page size than the host, IIUC. If a certain target requires
4K page size while the host has a larger page size, then there will
be no way to handle this. Using this patch just allows to use the
same page size as the host when possible.=20

BTW, in Debian, there are currently two "special" architectures,
which are s390x and loong64. S390x is the only one with big-endianness
while loong64 is the only one with 16K page size by default. As a=20
result, testing results on these two architectures can catch more
cross-architecture related bugs.

Cheers,

Miao Wang=


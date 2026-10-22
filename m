Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC3606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gqd9MkTX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJjBZ-0001eE-Dd; Wed, 21 Oct 2026 23:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xJjBW-0001cp-2i
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 23:09:42 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xJjBR-0007I4-Qm
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 23:09:41 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2e60f9af6e6so12781335ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 20:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792638576; x=1793243376; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7SIcXKIvUz45ObNdQWCMDG5gKCSnTvx/RMnL+UYiwoI=;
 b=gqd9MkTXZ5uSg92ih/CMYwAbze79kbHB3m6nKHm4oOEC0VMGJMgv0yYPgOWR60JSqN
 4Mkp1bRdgvYpU1OZol52+2bN9ZWCNeshhsOq39SzMth0sShd8UYqvJZaZaaKuWq63AJl
 gPoSrGxa1QIVE7srhKIZwcbOSwZYPoWBT5/bvnRZlApAP92GcWVYyCoAPhEIcXMcXB+d
 0ID/NWt044DSBlKs8ig0pfl/m3xR90GgsCVyaae8nZ0mwkursj6uhcyT4nEmlwqfmy1T
 /GIEPs+D2ws94IE3beeY1/9tUkpevI6TKPBvsVq61HD2xci+p1q3m26SZkbmJRVyHRtO
 LeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792638576; x=1793243376;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7SIcXKIvUz45ObNdQWCMDG5gKCSnTvx/RMnL+UYiwoI=;
 b=ChclpN3Fj24fL7D1cxCKh8PUNeuusgSyR8wlGbby9Fcfsbh05c6y5Ny52Gd5dz24pO
 GGH7yEPsCr/GmXdCszGyMEgQMvUMnGnp+Ro6DA/eixYmpYSIGpTyMIc7qdVUwoG/Zllg
 oyUWOtkoakTcGVJVrOp6Panox0xAX55L8/YWjEUD0ek/3GYQkvYZ0XcEiQYWtH05XCSv
 G+tBHpqvCz91KHVpYA9JV+DAYcnd1f7SVT9QKmKRwwyCm1Omui9n0IkiJF2t2Xq6rJZA
 RkmeBKCho3x1YYRIEw5pAx0KN3gSvXOg9boFH6y0k3sRV7wq+KSueUnmjUyJKH8S7/xK
 dm2Q==
X-Gm-Message-State: AFq9FYJ7MgSFQLmLSdBoDXhBFYmGHDET902lEm9qfPODvVYcJ2EppGdw
 H2AFovLKTNffxR3yHMwZJ5qkgyQm+EPiCHSmFrMcWztxRk6BENuARoGCiAfHWw==
X-Gm-Gg: AYBFou1c+MOIKqC1jDbnNu/dQ+kD5Romn7/AULYTzbCI1OiGtn3vL5FemwFws/3yAqI
 oNzdeIjufkxvwwBYuUVqG9oY4It//MM3sGBZ6tTzGITUsz8CtKi1WBmw1Ibp3EwSOWN4IuPFqtW
 H4KEuSmkOxzD5ph79RQYZcNWWT2iqu2HZZuniQqq7YEzbxUtwovexzIIWxYKxClikLn+HKSPTvd
 bV5cCWPR0V7XCsTo08PqTZhbNMQsL9Kubp/yzWPbq2CkOMlXR8218dj3lC8o2CNPIrKws+dOZE0
 MadOHoaVh+X7lcQApGYbcKdCCxNf2Ekd559fm31mBcyf6f+rCtvxj0nuCK4o0dsShEIUDIW9FlD
 Fhfn0CnjlizAATAeCoflERG7ZNKlrFfwDPVMNc8Jat08cFMwXgJ4ch7F9E+vapbdHkKgtSVCdqr
 1MrHHBZyNqhQeJhV5irUSZ0zqZL8eQw8VVSuuLDmTKIR2lY5V4TIYtVbiYseyE//pbONzhgGiQF
 SWuXZHr0H1eceumR3ztebz2CXlquwn7oGpIv8cR6af5b9tqO9kih6/h9GIbJQz55KBkP8adcAoi
 XNUrer/J+1GKI/A=
X-Received: by 2002:a17:90b:570f:b0:3a8:bd51:205b with SMTP id
 98e67ed59e1d1-3ad870711e1mr3856251a91.37.1792638576147; 
 Wed, 21 Oct 2026 20:09:36 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4890bb2sm1978642a91.1.2026.10.21.20.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 20:09:35 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/6] Support for Zoned UFS
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, pierrick.bouvier@oss.qualcomm.com, 
 stanleyjhu@google.com, Keoseong Park <keosung.park@samsung.com>, 
 qemu-stable@nongnu.org, Daejun Park <daejun7.park@samsung.com>, 
 j-young.choi@samsung.com
In-Reply-To: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
References: <CGME20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
 <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
Date: Thu, 22 Oct 2026 12:09:24 +0900
Message-Id: <179263856414.574876.6588883779051255918.b4-review@b4>
X-Mailer: b4 0.17-dev
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x634.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 09:16:47 +0900, Daejun Park <daejun7.park@samsung.com> wrote:
> Support for Zoned UFS
> 
> This series lets a ufs-lu be a host-managed zoned block device (ZBC)
> with zoned=on, so that the zoned storage stack, for example f2fs on
> host-managed zones, can be tested on UFS without zoned UFS hardware.
> Patches 1-3 fix the command path that the zoned code relies on and can
> be merged first; patch 4 documents zoned logical units, patch 5 adds
> them and patch 6 the tests.
> 
> [...]

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>

-- 
Jeuk Kim <jeuk20.kim@samsung.com>


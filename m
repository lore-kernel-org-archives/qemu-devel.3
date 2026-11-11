Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB23606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M/y+3DoN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8ai-0004Xw-Ep; Wed, 11 Nov 2026 08:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xR8ag-0004WC-Ij
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:42:18 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xR8ae-0004Kj-V4
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:42:18 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c3f04e0e65fso463292266b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 05:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794404534; x=1795009334; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LWqOPAsDIg2dqwewxVppScvOhia1XLIa75L7KEOkwTk=;
 b=M/y+3DoNcDOMb79TY6g5lmZb2b/C9huG2Kw04AuBDptoIz+RDeZKJ9SpxQRP+GZjaI
 6aA1F4yjLCfwN6DPfrIAEAbVMYk8gC4OM9ijPHCwSlZ66KZFc+zOGIzTVaRrwKbL3rWi
 6CDiFrqnMVuwRM401wfUyRRUiFV/cJq8BS7xjRmWagGNez3XfxKpv1vtq5+v1zaHhhqL
 s4v42ev/pGccmMoxrZt7MJJ6jCUS8Bj9S0ceIeUgzRR8BdcmzpivzUilMCpnnbZhKahe
 ANqJY0Hjn72znn/ud5/Y/kB6dEWPu8wDBvqvJQPz9xrCuOD036OjEy2INARUMk/xKgOF
 i0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794404534; x=1795009334;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LWqOPAsDIg2dqwewxVppScvOhia1XLIa75L7KEOkwTk=;
 b=dfluJKNhgDZXpOTXE10t3Lb3gutQJl3OtLi0lB7my2W4l2VxwP5LkU7IjS83OGXoCg
 VY9SySaoYNDcxJhozDr5nG0Yds0IPjoq85JQkvQ27PS0HjXguaeTpO8pEHr7m+qFMCuT
 gxfI6W7qrz+52v5fKmqXFDarFytlGHl+QNllg9N35cfsvqMV31WHVorWrRXhVZ2hesMK
 LbChulwPeO1CNQnBwCV1+p4q1c4jHdmCCuQT+MuYeU3gZIabjyjOkKAxizAPZShRJpeQ
 05McAUn24o8a/IZIS5Qzjk0Kjeb9m9pK01/1Yiw0t52h3zusFFSQOOuBt+UtLwYQH0eh
 BhSg==
X-Gm-Message-State: APuU4Z8nNMzV/5spK7Pq3IEqj4IfMn8qsmJ2Sg+Gi/5w3zJcRMQL1CLs
 qwEdPod32U7rTBaVJsbi8CHYp5zIEbI7yNsIppd3N+mTezCiHxrIDQh9VYMgTpVXHLI=
X-Gm-Gg: AYBFou28UF6usDpF4VMroC2hwbDRymJMp0vki8ghGBn9UAfPBGwBZMokBBYw7FqGAPK
 gYrMp/jDWDjNuoDH7zOEmw+b25YqMCoRh0rEkZPOr5Ean9lWRiL65QK5wrKQuMWlxsM42Aui7V6
 Zw4R0e/kkRjV9ENkK1zwfbScfExSIeFP0l8Vn/ZwMFm9EZLNygJMzWFE0adrAOosRXtgpcEYOWa
 nND9PfQESmXxEBoWtcIJsHclnbkdE2oeFX/PHmD12W25+Wv87vycp9VMMlEyMymb9rqBp1iABGC
 /xztEztyFgA71fyYf7fExfL0TIM3V9eZ8W0xMGNHrHwUJexVWyhV2wLTXHd7hyWjiDxHCQVhPSd
 Szm7gVTBFQIUTeK2sZkeBQgO3INBYGHDFq2QgKByOeuElhszsF9fDoO6ZWVc8RKfYBnFl4oqrL9
 EXvOlBLZ3KOkjP2s62CKWbj+wmpiY/4anGx2fMKX9Bf4WEjWqFpukAWCREpL+34e/Wc7JLQS0Au
 CWFn4veJdE2mkr7cn2Ou8X956b13Ep6leCWNamxT1IiAgt/BWUqzsBVQN0zNxKNh4naONsE6ptQ
 H43HSycbGCmUNuIrReZ/cB1867As9CuFKDiEFKLS4m33uADOUXlwx1zHfy/jV7eg0wx8IDtkrba
 eDQgV7/k5pSF8gBWAWCWU1g44lQ==
X-Received: by 2002:a17:907:980b:b0:c50:5426:54ba with SMTP id
 a640c23a62f3a-c5066d3db1emr194413666b.37.1794404533652; 
 Wed, 11 Nov 2026 05:42:13 -0800 (PST)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a6723e4sm235209166b.74.2026.11.11.05.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:42:12 -0800 (PST)
Date: Wed, 11 Nov 2026 14:41:17 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, michael.roth@amd.com,
 kkostiuk@redhat.com
Subject: Re: [PATCH 0/2] qga: illumos fixes
Message-ID: <avRwffwZoHMaN8WU@tulp>
References: <20261015173250.65942-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015173250.65942-1-bogorodskiy@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x632.google.com
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Roman Bogorodskiy wrote:

> I was testing my other qga patch [1] on illumos
> and noticed a couple of issues I addressed to unblock testing.
> 
> 1: https://patchew.org/QEMU/20261015142342.50436-1-bogorodskiy@gmail.com/
> 
> Roman Bogorodskiy (2):
>   qga: fix build on illumos
>   meson.build: fix getifaddrs() detection on illumos
> 
>  meson.build          | 2 +-
>  qga/commands-posix.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

ping?

It would be nice to get these into 11.2, as the first patch fixes
a build failure and the second corrects a build system issue.


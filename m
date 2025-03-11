Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7653C282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 02:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trpk5-0001It-5K; Mon, 10 Mar 2025 22:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1trpk4-0001IV-5O
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:53:16 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1trpk1-0002Ij-CQ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:53:15 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e6ff035e9aso2925849a12.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 19:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741661592; x=1742266392; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=k0V9X2F1tRTnhoqDkyRfE/pyfAiGjyVA91JI6NsZ9uc=;
 b=SF+7ZnK4eKu+W+EntsiH6Fw+xYkpxJG9axK924auVDiaZJxxLqr3Ky37Z59o+KsScP
 J55MipRro/dcv2e+Fl1myhLZaYaDZUgYHvWPq8nvQQJyWtal1uM2Kl0BHLQ6sw+t/S5N
 dzL0FIsEgU/ecRzXDtq9McVbfXfAjpi53pJrcOEgd5Px1Jsm0Wszp2UFFYXl0jejqZBe
 Y308zq4qhxW042BOrBmja8yUKGOgEpBuhMpDdjRbLaGADhdzv/oZSJ8PxYam3ulPGx2m
 7ZgXCChsCoUH9gf7bHYVSXfzSKPSzzyNtHXsfCUJjGRBuVqsMcxblGycieRPLzfxyrPR
 F5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741661592; x=1742266392;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k0V9X2F1tRTnhoqDkyRfE/pyfAiGjyVA91JI6NsZ9uc=;
 b=afxmiRDTF3QrcQLzBa1djyMziU/X/M+JpAPIYImurES3t67e4JxtHrZL5cFguHB+2+
 TI6dRhAJbDjFDFSoS7iz2ooPxQb1SaCsFooGmpP6sUuopOhDABpZxahP+MlJvqfAeJSf
 KJ48DXTwsZ+XGRl2FPKp0LliZsHOmVLAXGBO3d487FSxijp8rtVS2WzGX0c9rDIA64Mc
 p7CLUzlp1HetrrCjexD1iue5m1cYFiz9MtOQho9hU6En8WnpiKut59yfVKTA+8wCU9hI
 UKHDYFXip0CrIS9czpqyASP1OpaF5jhd9yLxF5ajoEZDrHO3pjIvIvauh7oCUgRehK8I
 AZvQ==
X-Gm-Message-State: AOJu0Yw0iWLDj+gPfQzzvRLvbWvw93ruKX+Uq7z7LrdZ2aUB7nO2tRfj
 iLfdvEHuesCUbOa+upe89VPZmGZAK+wuWa+Yk8WSIpl2YGGfwrFsfk5MMPQnAKROTo+Q+r5qiPC
 KdgzZzqESx+eHy0EmvPdem9i21CcqTzUz
X-Gm-Gg: ASbGnct7EiotJnFokN6Srmr5dSaoh4TaI31Mc7KlNEHwiZM3QsLCqCvi20NTlkf+Vec
 fk+YXdimV/RSydUnpE8QE/VWUuiD3Id7q27rtHRh8IiK+qqUbnFiY+5JfCPtFXukyELfAQ/x75z
 We8Xok6mTVa+4906LoD2r7ImJEZg==
X-Google-Smtp-Source: AGHT+IGcXXi6dJQ9yTbEtvOs+JpkV87sd8iT7FFzzImFIXrktcyt6NXK0HTfSQ+AqYzDZeTZR6H3MGqxkrz4R+pK/yQ=
X-Received: by 2002:a05:6402:3512:b0:5e4:b874:3df7 with SMTP id
 4fb4d7f45d1cf-5e75f5a3457mr2135006a12.25.1741661591509; Mon, 10 Mar 2025
 19:53:11 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 11 Mar 2025 10:52:59 +0800
X-Gm-Features: AQ5f1JppwYBBCJHNeqowUMxo7VeRQJBDuYZcGNJdSVL1PNh4V6YAhK_fDnds5us
Message-ID: <CAJSP0QVxj5jeGHPUWheheFwYYRO=dy==9TJXrLyhBQVBBRUfbw@mail.gmail.com>
Subject: QEMU 10.0 soft freeze
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

Hi,
Today is the QEMU 10.0 soft freeze:

  Only bug fixes after this point. All feature changes must be
  already in a sub maintainer tree and all pull requests from
  submaintainers must have been sent to the list by this date.

https://wiki.qemu.org/Planning/10.0

This is a good time to review the changelog and add any items that
should be highlighted:
https://wiki.qemu.org/ChangeLog/10.0

The QEMU 10.0-rc0 release candidate will be tagged on Tuesday, March
18th. This is when hard freeze will begin.

Thanks,
Stefan


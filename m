Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E87C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmq0-00081b-MP; Fri, 17 Jan 2025 08:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tYmpy-00081O-Vq
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:56:39 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tYmpx-0004Qd-Ce
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:56:38 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso3218015a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737122195; x=1737726995; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v804b44pqbaXJHdnWbsXOKQhx5m98xwWf/V+CtD5pCQ=;
 b=kFXnyk3E9PAfHJll2JZj/lpMZMBJ7jb4rB6H4z3ntCa17tAOnCvR4ejdk23Pvw5ODh
 I/T0z4lUEclpRjOrNXzCyjvMkVl8/9VwCHWW6+wdXsDMA/5pBNUXWxwjymbsu4HrMQFt
 f2UNYenw3VS6OOdocNnbsRCDCFWgKUhm48PVtg2WaOyRNumD925mDCCQJoqMT+AqJQCK
 Kta6T8QsbqbsJ3cgxpp0pyn6mqH1kjpFXjztqQRC9U76ThnNLLsfCZU1VgaC4bqKPpeP
 tHIetaoZsZeSLTZG5UH/FA+IfJkRoaLxJk0y5GoVolDSWsWytM6UeVetxk+zPUZe5LEn
 JBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737122195; x=1737726995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v804b44pqbaXJHdnWbsXOKQhx5m98xwWf/V+CtD5pCQ=;
 b=TxlZYzK1I143pkShxZvW1ClrRZMibx5uHSPbfdjioLbc/v4HpzLy1YTd3ASyb2smDb
 MwcaNDG5dNfKpOK39IfWwdhTBHaDFAxdBZfNBUNBDUZ5pRNmZSEidDW+0WsBdAvZ6AzE
 Z0y3Gg6Ja1Td390DKVZPpU/0L34NRg3+6Hdzs2IAV0h7sW00zoJZkvSBM5UEytdsJ7WY
 7N6q+mDWeae+TNJ4Gd8F1JXU+Mr5LCaRRUvISVEW6j6AacLwqavQsaiJ0DDAqprP8zmy
 uMTTkRKwdSF9qXnuJzmwFSyUPPTWC1y393mRD7ygiUH5jcZDzAS+SIK1TSuoK+Dx/BXK
 tMiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnj3tQZdlK813fEEoTn7YS2SFkWBbgecSei7r8UIDZ9OLMmo4GWb8r+h6G/xfIfU+l4AMMV6CAwEwD@nongnu.org
X-Gm-Message-State: AOJu0Yyw65aMWorCazqDVLPKpNpCFOD2JOyq1F3jX8az6coPAxrQLNY9
 rMotLTUBbA80AvFE5nxZDJIMtibWcUMcpGNlUvEzcygjS3jVkT8IX785NS7APkWbowzcJP6Prp4
 yLwbZCYYMmD0DGYL4AVT23+wxReg=
X-Gm-Gg: ASbGncv+7Irz3hgvDqKpHY/gza/q56PXoToEE0q0hSYFs6sdMDvOSf1dJTrYAH7uGG5
 G5MSKsi+h3pPIlvLbEpEL21qbvUeRLRxdoyOq
X-Google-Smtp-Source: AGHT+IFGJO6PtPhRgT0lXBPRYTiuPy6Oh6hhdJYMgvusiG5zWnA5SlsKS+pmJ2Jba/Wx8K9Y8Dwx28oPZrPLZjwhGl4=
X-Received: by 2002:a05:6402:2681:b0:5d0:8f1c:d9d7 with SMTP id
 4fb4d7f45d1cf-5db7d2dc2d0mr6547236a12.4.1737122194447; Fri, 17 Jan 2025
 05:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20250116084332.1864967-1-dwmw2@infradead.org>
 <20250116221027.GA378432@fedora>
 <CAAibmn0Tsn9ZQ1wgoLLhCY=DQAkSDDtKBYOKKoSGmYe2TDTZuQ@mail.gmail.com>
 <43e9e8b7b2aea133d0353908b1bf09ae8d75a3d0.camel@infradead.org>
In-Reply-To: <43e9e8b7b2aea133d0353908b1bf09ae8d75a3d0.camel@infradead.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 17 Jan 2025 08:56:21 -0500
X-Gm-Features: AbW1kvZ6Qb0Dhqexpko0g3oRhNT3NRR7KJgYRzw1ZW3GjBK0zUxSoTalsuqXO_M
Message-ID: <CAJSP0QWFCnf5zweSLwYXKJA=ByBB8JyJ1OOT7uAn0wQoYem0MA@mail.gmail.com>
Subject: Re: [PULL 0/8] Xen regression fixes and cleanups
To: David Woodhouse <dwmw2@infradead.org>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
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

On Fri, 17 Jan 2025 at 06:37, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Fri, 2025-01-17 at 11:49 +0100, Phil Dennis-Jordan wrote:
> >
> > This note made me realise that my feature addition (macOS PV graphics
> > device) that caused the regression requiring my patch in this series
> > hasn't made it into the changelog. I'd be happy to add it myself, but
> > I don't have a wiki account. How do I get one?
>
> I think the automatic account creation and you have to mail someone to
> get access, but I can't remember whom.
>
> If you want to give me something I can cut/paste, I can add it for you.

Any existing wiki user can create a new account for someone:
https://wiki.qemu.org/Special:CreateAccount

I have created an account for Phil and will send him the login details
in a private email.

Stefan


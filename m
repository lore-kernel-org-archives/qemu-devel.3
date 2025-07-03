Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F77C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMuI-0008UL-4S; Thu, 03 Jul 2025 12:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMuC-0008NX-0O
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:35:24 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMu6-00028D-9r
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:35:23 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-710f39f5cb9so81496397b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751560516; x=1752165316; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wVjbPFTVxyeqZk1Hq3isT9C60m5446h74JqHjmvPqO8=;
 b=HJH/8WKS/FCMykA9KMDRvMgs87lKG8fbfAL0r2SjTponjVqtsacyK1ifxXI1EfCSxH
 jEvlmYr54B9gUIp4K8jkSHAmgEw7V6YKsbXa9VegXX17tt+A3lkbErJWU0Qb0rPpQIA+
 0CsAM1+D0PoWd12gcoG55y47sXvS/f9jLB0F301vy26Oj+WWqUcEJ6iq5qvEfVjFWoIJ
 JvVVMR20wJJLE08CKe9tEEGcfvhXI6qJe/q3/DqQwo5rHXELScTtJgUF6WJcUqbTFTE3
 Ihy9Iogigk1OJW3qTeaGdaNhhX7wG4WBLz/efKcTWWGnyrEDNTxoc8jxtaFLZ/KDpJ+x
 Wg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751560516; x=1752165316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wVjbPFTVxyeqZk1Hq3isT9C60m5446h74JqHjmvPqO8=;
 b=xP+i4I3kx0NrHe9sqv5Uojsm9sgfcNPEF+u0nZWrfdYSgytilFOAm1RKXscUpPpBkZ
 48AA3kLztB89w9aLru0hQhzlx221QlaMS+a5Eov47czR+UCE5TR6eIfg5xN2XDJ+yA8O
 AQGnsFRYNoscxJs0rJv2/Ic2k83Yi3bABcRTqdkF/5tiU2AebF+krYytT6upioO87ivZ
 zVFjBYK/UveLDhEFGSsRcaHfz3DZLK3W2rKymmk2ecq4ErZiNwQ7je+yeuoajUPPTQsS
 NT72fSxuxdoySsA3ZSywbVQWhmm5Pj7aLvjcjDff+3bCnV1nbaLF5bq4tVVLHUTJ6gBl
 qJMg==
X-Gm-Message-State: AOJu0YxKv5YfOx1TsfoTQb7bOucjuW0lZZcY9rS5YTunRyvcl8Efe06Y
 TxUwW8PrrOpn6zsY1QSjpcA+EFjzRhFA9Gfac1dFB2U6oIcYWzMfZbLgU8SecXXT69G+ZPCsR3Z
 azbUxmKVpdJbHLuB0dB9nh5lbDM9XPwBwklXINYQUxg==
X-Gm-Gg: ASbGncupm3sxqnyY96Yf9lA31xzXzAkLJZzMU41mK00DYlbeIBbRCUKVJVfTBV3D4r6
 ePWfg0WhWvpegJiatdpBaikmxU1ngEQ/VmANbIkrEYjsiBfh0ACSWnTHPcSVMrm9ZzPCqBZNqbs
 dGUsoCxDW82h0zLxdEaWCjwC5bkiFlmvTHN9tk6fyvNLaeLyym8JGpwQg=
X-Google-Smtp-Source: AGHT+IEA8TRwNJpvW8w1S//ksqeSISBQBRJXzPsBwkZicS3tOiKbQ1CyI3bey8BlGtsFVMlFSFjgAk9FX2Al1hI/3C4=
X-Received: by 2002:a05:690c:692:b0:712:d70b:45e2 with SMTP id
 00721157ae682-7165a32017bmr56367737b3.6.1751560516033; Thu, 03 Jul 2025
 09:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <7BC53C6E-6F35-4F96-8B59-E77083220372.1@smtp-inbound1.duck.com>
In-Reply-To: <7BC53C6E-6F35-4F96-8B59-E77083220372.1@smtp-inbound1.duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:35:04 +0100
X-Gm-Features: Ac12FXxkGG0AFOyEWvUF077hXv9vnku7svEuH0NJK7AUYAsXJV1wjH_Q2rpZ3aQ
Message-ID: <CAFEAcA8Marfaj-RbSthm+oNgsDn7Gp8nNir6A2t8Aq+hq6XKTw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] MAX78000FTHR Implementation
To: jcksn@duck.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 19 Jun 2025 at 03:50, <jcksn@duck.com> wrote:
>
> v2 changes: Addresses comments by Peter.

Thanks for sending out a v2, and sorry it's taken me a
couple of weeks to get to it for review. I've left comments
on the various patches, but this is looking pretty good.

I should mention that QEMU's softfreeze for 10.1 is on the
15th June, and that's when patches have to be already in
submaintainer trees, so if you're interested in trying to get
it into 10.1 then you'd need to send out a v3 by early to
mid next week. Otherwise this is likely to slip to 10.2.

-- PMM


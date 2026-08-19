Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9CEC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwc0F-0001ur-Mo; Wed, 19 Aug 2026 04:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1wwc0D-0001so-GN
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 04:50:29 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1wwc0C-0003tK-36
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 04:50:29 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c214e625259so105548266b.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787129426; x=1787734226; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CFIYqyOyqTxLK80KrKxLckpEud5kZlxrCRWwQPEImUk=;
 b=LvXbSKIB0R/sSJyyNOjKu27l0I/MyolnRIt8kNwg4x0kK8MfZc3U4doVliy+PLTZtx
 6lYJtz/o4xpFs6h++ZA8alOk9jqugdsLgvJDslUEa6jmsx48p+Ih4oGkuZUdE5qZM81i
 hVnmba3lYZn/U/mb8qkkDP6yrZ7LeTTvo7Cj72l4zUaEuG69XINt35jetB2t5s3uIUqe
 YH/SKq6TO29OuJ1dNle8GKWTTJ4FZNmLaxElc+mbH1SefgQ9Uf6SwhIJKYbhhmEHMBcB
 W8/pr+j7y2LCvNoOFerDTkFRUXQwSDBuv+WNsEz8Hf1nIdC8iHyrwJA70iFFcZC6L+fD
 EtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787129426; x=1787734226;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CFIYqyOyqTxLK80KrKxLckpEud5kZlxrCRWwQPEImUk=;
 b=GKutGy0noYgOzxEguHGANu69rjZ2nkhO8tYMIv2rPWvCpCP5OCyEDktRCoOQ8ZaaeJ
 hLemeRuuhqOaJLy9LEHvbftfLj4wKz+fYc6kmyJNMHKcpRXOfZI53jstlO0TfK2Mczn8
 A24HABakZDf43D6S9VW/fTlslaiN5Xum4Xkk6nPUWutqHvvdRcZRn+Ig/rPt0fe7qoY8
 HjnEcEFtkbJtKkGUhHq68iyEnMvhIkW0XYmiD93aGuZxVPkfF+GgGyThTiLniJ8GyhmA
 Q926qBrJJ2FrhhmS3hLw7x/uLFSk4/bEQk3IfOdrjJ+78JtK7orrHJ6y33jkF1skeUDO
 UtEw==
X-Gm-Message-State: AOJu0YyQLG31G5r7gPwpXaS7fxwpCotrHVbCrzbogSirv6riOGSfrv1K
 m54dtSJWHjAz3dQoMpubxtatQS89Yj0DibxouU0pUlI3MefaAXmNGW2oBVEI3XX0
X-Gm-Gg: AR+sD13u1C9a/uk/l1OZMYx3CQ4cjYddjKOg0eEEDngVHmZM9cIiocZzPgyVCuQZR9Y
 paNWHo1t5pPW07j9sPTCGgqn2XwxBPPash7VJ+VH/3OLqNn4zJFwlzGPHhnpWicMlfF8jZE4GyP
 W7jHoiAyYFcFP76GobOGVUE4IK47gDwyALV/9htzfwbdb73TKXhoX/aPg810GNV0cXjeYFeF1DL
 0ft7xvgz490qrlVO+MKnN4U60R/mnurZ0pFxEPCmw0AcByun8A+T70wKBQXkNKftmghWY/G+67t
 GAWVAH1o8Bu/QUXKE3Xy4OM5LR4WzehoGlz6zlv242YoS0qpJWc/CrKoh91cIXMvhglnoIvvPqI
 sMgZMpRcvHWAVpo99CEfQLBx+L0MNVCPd81dxrcXabgQ2Ew3hz2/Av7xPS52FLmfLLolyUxNuT6
 paoOjB2L/PCrYI4VEIHWCRPaaBjsS54hlvh5OUDLREea4+aF7WPWttx1DU3J0LYbLrTCRUp1x7O
 okO28h28GneEAnsSjSno7+/qqjBp0lVfjK0rg0iLUrthIFkELQelojlaxOQmbEcAfYobQy6
X-Received: by 2002:a17:907:d26:b0:c21:960c:ec23 with SMTP id
 a640c23a62f3a-c2420debab9mr159864666b.1.1787129425798; 
 Wed, 19 Aug 2026 01:50:25 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-ee82-4536-a8f2-9e22.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:ee82:4536:a8f2:9e22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c243c3b4ca1sm45049266b.37.2026.08.19.01.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 01:50:25 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:49:49 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qga: implement 'guest-get-diskstats' for FreeBSD
Message-ID: <aoVuLYwdP9KHPxf5@tulp>
References: <20260719160329.73695-1-bogorodskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719160329.73695-1-bogorodskiy@gmail.com>
User-Agent: Mutt/2.2.16 (2025-11-22)
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x636.google.com
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

  Roman Bogorodskiy wrote:

> Implement the 'guest-get-diskstats' for FreeBSD.
> This implementation uses the devstat(3) library which is a part
> of the FreeBSD base system.
> 
> The build system is updated to link qga with `-ldevstat`.
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> ---
>  qga/commands-bsd.c   | 127 +++++++++++++++++++++++++++++++++++++++++++
>  qga/meson.build      |   3 +
>  qga/qapi-schema.json |   6 +-
>  3 files changed, 133 insertions(+), 3 deletions(-)

ping


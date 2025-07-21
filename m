Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CB0C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxht-0007nn-Rq; Mon, 21 Jul 2025 17:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udxab-0001nT-QS
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udxaY-00057f-Fh
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753131501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEZ2KHKOvlK5O9hwIzcxzzpf1amG8RrSqz2D31ADJF0=;
 b=PsJO5GixpoC6JYWxrWxZUvdNp1pJMmf3SVbjke7HuVaJHw2REK8Rl1FUOf9pkOaP6oi3YK
 XkRgafrhNu7x3fTGbkqhNaxMmJWqzGosGwvz7dyMWMLuLqaZuO3f01scrDHge3fuyK5mXo
 xopYI/8zpzOs5tED3ezpzTqX8ywlX/E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Le1Aga5FP_uAgMV66MEyIw-1; Mon, 21 Jul 2025 16:58:19 -0400
X-MC-Unique: Le1Aga5FP_uAgMV66MEyIw-1
X-Mimecast-MFC-AGG-ID: Le1Aga5FP_uAgMV66MEyIw_1753131499
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31cb5c75e00so4471256a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 13:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753131499; x=1753736299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEZ2KHKOvlK5O9hwIzcxzzpf1amG8RrSqz2D31ADJF0=;
 b=n94ReHTx/wZH9vq+ONhfu+lr93eOOXlUGssoM+YRgKCG0r9wZtY12MRiYiL4Yfif6n
 5tKGlZypqAFKMiYDlEzal99DIH45i1e6fMTcffIiw1IPMDboL7qyPlGtGCCg7Ovcae5K
 PdhS8FyXHAS1DwHsVqCuhgKI+CpP2aVi0qOrbEUAXRbgYNua/Kg59ZxbeIIIgAW7OxHs
 c09icXR+pptK1Ah7kmQjPl6y9PQ8D7ntTbZNhq7Z8WSaZr1YdMi89e5XzKX0tEvcSXl5
 +h+7Pkl3jXEqGO36Uc0o7xLOsTRNE0Vj9sNoOHHc+h0IygNxG9Gee9vibHeR5PPPWLpl
 yatg==
X-Gm-Message-State: AOJu0YzlRO9B4egHZ9tzI0lF1G5jQUlUubhpHAI+KQ7viH5URNwvwUfp
 Voq21qxHsse0zCMRlDkoxsG1/tipKaN4cWxkgHWRWnac5iK6ATuoFliAluCDVEa9TXGaCDgdpV1
 VJ0EEoB3b7wmc06cK71bM9oo3awqx46i2sDZmYvukM+zqMhJlhKePl26Vl52Nvxceazdz4kNywO
 L0hH+A1mbFGLLkNw1lxl0u+QAg3Dt3RcY=
X-Gm-Gg: ASbGncvDTMpCtU32qzO+zWIoN5a/qaTO5m4nyh+I0atPtJ883SK6e9kTRMPpkJH/KdB
 wvJ4eVHOVsInflepnraDJTzxEEWXyY7XQCaoEE68UyKjpl/ZltZcMvPDqqdLcscJR1lCVeMhspM
 OxZ3zqOGOUwGgg9SRCVjoB/9M00rsMy5eCeQtUuh28DGzTwTyG+ZKt
X-Received: by 2002:a17:90b:5646:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-31e3dff05d0mr1443043a91.0.1753131498852; 
 Mon, 21 Jul 2025 13:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvk8DZqiHezfektSTtcU289QixqEizeRzQ/bdOf7+G3J5vEwKKOR0912a60/EKkdfU+vmX1j8tdOTpEKfo/go=
X-Received: by 2002:a17:90b:5646:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-31e3dff05d0mr1443018a91.0.1753131498487; Mon, 21 Jul 2025
 13:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250717115246.3830007-1-armbru@redhat.com>
 <20250717115246.3830007-4-armbru@redhat.com>
In-Reply-To: <20250717115246.3830007-4-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 21 Jul 2025 16:58:05 -0400
X-Gm-Features: Ac12FXzYvyAka-03d54D3WodjzNs-cyOuu6F1Ta91uqPdsA_9mZzxkJfjDYJ3pY
Message-ID: <CAFn=p-YciTJt7SOcRDXyea6niasHV7Uhuq9VkAhqWemeRanSPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] qga: Rephrase return docs to avoid type name
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, michael.roth@amd.com, 
 kkostiuk@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 17, 2025 at 7:52=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> "Returns: <description>" is rendered like
>
>     Return: <Type> =E2=80=93 <description>
>
> Mentioning the type in the description again is commonly redundant.
> There is just one such description.  Rephrase it not to mention the
> type.
>
> We did this for qapi/ in commit f7296f8de5c (qapi: rephrase return
> docs to avoid type name).
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  qga/qapi-schema.json | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a9cc9150dc..6c26ace3c9 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -534,8 +534,7 @@
>  #     discarded.  The default value is zero, meaning "discard every
>  #     free block".
>  #
> -# Returns: A @GuestFilesystemTrimResponse which contains the status of
> -#     all trimmed paths.  (since 2.4)
> +# Returns: status of all trimmed paths.  (since 2.4)
>  #
>  # Since: 1.2
>  ##
> --
> 2.49.0
>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E5AC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUQj-0003ZL-SY; Mon, 10 Feb 2025 09:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1thUQg-0003Yi-0b; Mon, 10 Feb 2025 09:06:30 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1thUQe-0003NH-EY; Mon, 10 Feb 2025 09:06:29 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5de7531434fso2229306a12.0; 
 Mon, 10 Feb 2025 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739196386; x=1739801186; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pb2xhhq3/7K2yCbO0CUQWdg6iyyhNb9njS7vuQ7ZH7w=;
 b=WkncihD3GEwixN1/nCakRZv4ViaagtqDgAJd2HqVl8f64fcxPc71B1zy5o+UCgEIpn
 Mryctxua+JB2rG9YWCrO6BuN5SSyP4y+uO8uaU2C2RG0radyKMMcJ4MYn03B90Vi9SRr
 dWfhd0aHyJGRkcmAAkJDYRRruX5dzxycV/F2WGvBslaib6/yFj5fBtOocEGoVKuTefPk
 hX9QP3G8JbA9yT2KDxeO240YOC2mlUmaNwnTuvZnQwZkYVEYOqhEpamavT2PjMIB+1e0
 Ly8JX7oG6RtXzi14twJIBvXNI9BI86OCbfHJSYJU9Q1rfzGqVvBj5nd8JZvH6OM0fCdg
 ymXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739196386; x=1739801186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pb2xhhq3/7K2yCbO0CUQWdg6iyyhNb9njS7vuQ7ZH7w=;
 b=GBcXnX7u/jrD2lsc4YDYA1bn45B6/pv1uNXB1Etkd+x3jVY0wtTefxeFQpGNScycac
 oEj+DmvgwWhMmYtFu4Ze6IgW1GilKD/1okP4643Xj7GRtqjs/o0R5YgkJDz7/JJnjrTL
 rFsui38Sq5OAVmggkQcReNRCJnS+OUy/GuIqj9QxMbai37b7OKM/UctgLhokjgqHtqqW
 KalXqEOKYW5oguYj2wDnIkCYaCP6Lwxu9tYGlNuSqSJpjMkotPFhscWw1JIXSxgR1iWR
 YNM7xQMNTUe/djrXoi09LU1RRjdeck2NArUYqKJxND3cW4SlSRNI55nKgQ8zJSHYPREM
 PAYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQq6kqgLeBKKq5pFxikRKTM+CTL3H8yiqtlOeQ9qM5n3OXl+W4HtC1iLoVQ2CR54Km9pUC+GVnWQI=@nongnu.org
X-Gm-Message-State: AOJu0Yx/x0aYYg4UFzdsxZdC+M6wvq1oqFPwkKmfJ+refFNKMzcnxNQ3
 ohIeV94g+x8awvNylyboJ9wb6WbYf3VTuPt7HzrDThmtIyxDORFzFlFhLuOFaTXRmNRpZCoMlRS
 ybUypztSbeSGU7zW9Hfe8LCGUNyOipg==
X-Gm-Gg: ASbGncsVAxFQunFa8rWJ1JSIStlkzNwUmlRPdhEVN0fGbZtOJ2D8IyytQYb6mGx8OkS
 mXjBvxLkZa610SD+jl9Nuf116q6bnYCLWio+sbLWkyyPdfb6VcN8NgeA2Tpo/3DXIufgi5R8=
X-Google-Smtp-Source: AGHT+IFIc5AMgqXpnb0ZE/IWlPWCNgw1zlA/mZAh0YvW/8ZZ7iW5vYImNAGMjLaQhwLHl651Y77Mc+AzIQqZZ/bk6CQ=
X-Received: by 2002:a05:6402:1e91:b0:5de:39fd:b2ff with SMTP id
 4fb4d7f45d1cf-5de44e5da3bmr16374436a12.0.1739196384118; Mon, 10 Feb 2025
 06:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20250207143952.2486587-2-pbonzini@redhat.com>
In-Reply-To: <20250207143952.2486587-2-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 10 Feb 2025 09:06:12 -0500
X-Gm-Features: AWEUYZk-2472gv1IJcA8ntSdkATkHi9p-pwUVgUEn9HCXNummoif23Zic4txkIk
Message-ID: <CAJSP0QV+wfAFOeC_Jw5PBd5sOgzozPLPeEN=ddWd81Hok6uf4g@mail.gmail.com>
Subject: Re: [PATCH] rust: restrict missing_const_for_fn to qemu_api crate
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Fri, Feb 7, 2025 at 9:40=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> missing_const_for_fn is not necessarily useful or good.  For example in
> a private API you can always add const later, and in a public API
> it can be unnecessarily restrictive to annotate everything with const
> (blocking further improvements to the API).
>
> Nevertheless, QEMU turns it on because qemu_api uses const quite
> aggressively and therefore it can be handy to have as much as possible
> annotated with const.  Outside qemu_api though, not so much: devices
> are self contained consumers and if there is nothing that could use
> their functions in const contexts that were not anticipated.
>
> Since missing_const_for_fn can be a bit noisy and trigger on trivial
> functions that no one would ever call in const context, do not
> turn it on everywhere and only keep it in qemu_api as a special case.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


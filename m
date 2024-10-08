Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA132CEF148
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 09:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy6nF-00033C-Aq; Tue, 08 Oct 2024 05:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sy6nC-00032G-Rl
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 05:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sy6n9-0001AN-MR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 05:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728380765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtFq+gn9DmLy9r8VTyGQc61omoKnLU+alqNDlAao294=;
 b=G6UEx4UxhWOD0ST26dcveVejPC7zLrrrBXH010Tk6Tk6yegXwSLswZItbYmlgQ4I6JfAa1
 VeuyHlL75WGBCzHrnG0v0aDPim0s08ZexNoqEZEXtMxl46nc4j6zb0jQ+kkO2074TSMw5n
 XymTcwlm3BsMvNgVjmIqB59N15+M8wY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-hMAKVmKqNTuiF85d7iIaiw-1; Tue, 08 Oct 2024 05:46:03 -0400
X-MC-Unique: hMAKVmKqNTuiF85d7iIaiw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37ccbb420a9so3292885f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 02:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728380762; x=1728985562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtFq+gn9DmLy9r8VTyGQc61omoKnLU+alqNDlAao294=;
 b=T8lw+SiDp4unq2645Dj0ikNt0yITofITqtZ3Pl6YzIZdEbNWeiBWlBOiEm1gkXs1Su
 AuevgffxeZvAZmtcCJ97lxsStzIFr9dniHy4WE0U1jfpgDr+eEBUn14PPvk4Wi8JBqa6
 IIdLOKqS5C4wN7UjLsnPditgdGDcG6DDTrLCkgsN9MVFmHcuGIQ1C0VMZzV93XV+UBcS
 uc44FUDUl40814cKmFEpxsyLo0EYK84weeFI6OrTVsN9PZAfwZYbdUmusqhKzntVDc2e
 k5Fqp7nOXDu40asHqIb5eFChsR3kigB1/hNtE4REwc8ncq8gVpQyZ6UyJ4+7/woORr+/
 zZRQ==
X-Gm-Message-State: AOJu0YxYHNbeC4hlmS2bACZJgm9wjfu80JTefGqhXKCKktZeUFy052Ly
 d8KY4UqEKXexKB9/R/99AwH3SQ1iBsJ9TZoGHSn0Yh+HJnHExUO5dAk75c6sJfTbZ7QCUrdX1Da
 EODGJ8jwOd6MENXH2ctdSxp8ZZgs8unoBT2qmduunJqC/RBuoip387z1iSTFsL4DxtpO4jXH2DB
 nhYN8GJnbq0sYKph4elODg6TJkz3k=
X-Received: by 2002:adf:f808:0:b0:371:8cc1:2024 with SMTP id
 ffacd0b85a97d-37d0e502d60mr8126277f8f.0.1728380761982; 
 Tue, 08 Oct 2024 02:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlLl0rjDWKFDEvwIlYHIZBlFLt1VZxaCrZOcibwoPxb5em6qsC71TRAdgb8UsvKaiD3M5Muvt1NgV18+0ca2Q=
X-Received: by 2002:adf:f808:0:b0:371:8cc1:2024 with SMTP id
 ffacd0b85a97d-37d0e502d60mr8126265f8f.0.1728380761589; Tue, 08 Oct 2024
 02:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241007171717.1436982-1-pbonzini@redhat.com>
 <ZwQmDzjojjAs-dQR@redhat.com>
 <CABgObfYPHFyBShEY2Qxdg+2yG_7aXp-cN8rdkMB8Ha8v1Qe=Ew@mail.gmail.com>
 <ZwT5U2FsG6ugWZVu@redhat.com>
In-Reply-To: <ZwT5U2FsG6ugWZVu@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 8 Oct 2024 11:45:49 +0200
Message-ID: <CABgObfZHMAT18nCgtfKDuu96WN__ZNMJizOvVqFLMMNa=Zn5uA@mail.gmail.com>
Subject: Re: [PATCH 0/2] dockerfiles, gitlab-ci: add CI job using nightly Rust
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 8, 2024 at 11:20=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> On Tue, Oct 08, 2024 at 11:03:47AM +0200, Paolo Bonzini wrote:
> > Ok, I'll work on adding bindgen support to lcitool and then do this as
> > a separate submission.
>
> FYI, lcitool already has a package mapping for 'bindgen' defined as Alex
> added that for QEMU's benefit a few months back :-)

Hmm, it's missing on SLES15. I wonder if we need to add support for
cargo install, following the model I used in this series.

Paolo



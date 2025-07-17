Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED36BC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTCs-0004iZ-B8; Thu, 17 Jul 2025 14:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1ucQb9-0001cn-Fn
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1ucQb7-0005i8-CD
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752766355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uhn6BLbVv5iMyDashu1Hh6ot6uyhvqJgGPc0IbKWsRY=;
 b=BQlKwuwAhi1krl2yNzJUD9w/8QaeP/ZjLbdzY1TEV1yKsChrGhZrVqdKJs1K10WagCg9sd
 ZYpz4SYK7+b/iMJ4lYPKVCFPke9DXHmFl5h/0tQ1MrEFpl55w2BwTSjMNKV06zTSXPKJDw
 5jvIXS33FzC+n5LHwhrCxYKfQ2IezJc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Zr-IGWPLNqic9gfX796Pcg-1; Thu, 17 Jul 2025 11:28:38 -0400
X-MC-Unique: Zr-IGWPLNqic9gfX796Pcg-1
X-Mimecast-MFC-AGG-ID: Zr-IGWPLNqic9gfX796Pcg_1752766118
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-70e4269deb2so13862487b3.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752766118; x=1753370918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uhn6BLbVv5iMyDashu1Hh6ot6uyhvqJgGPc0IbKWsRY=;
 b=OaaMWMDeQNT67d58FuWOZtQMDDgbHvBkVSQYKb63pR37lZv8xImZZwBfGxobC/HOm0
 5mG0dETC0sq3uiHP2N2juIHeWuZKDntEDB73HdEOHwef5g2Y8vcXeVLNzXwmRfqfDwXj
 vA+rO8hC4LRIXvlYRHmvd9zCuBAxHlzLxSbei+WuOBjexbJ5yS7dXoxuYX/YLHirEGLa
 9i7+wpMrPq9AynGK2CVpi1BZWihFHkJ999JR4RwjYeKbmiXD4Fi4+6VfVONzS5dTHVnv
 HtxYvgBdtVaB4czkflgpxycGV97+YTJUJPgRvfWz2QdKAF5JmRox2/3CVMqyGVQ2YuSU
 uRXw==
X-Gm-Message-State: AOJu0YzAi4TcgnJTSahGYCnQ6W/YDRiso+Ws5Iepi2zSkpH5iPO5LHXx
 R6hw8fKdixgIAA2g9JFgeaZAf0zTDDCqzKug8oSu0mc3N4LJw7FEhQQxHnxT7M5l6EG6IL/w81z
 LBREcJqv1iQoUIEImFK66SofpmN2tWzxCZzWy16OwKBQ6cGs61ZLzkM/je3S+zZXlWrlmT30Eno
 bJzxELEtydbXgC3q6yUudDu4BQhu5928Q=
X-Gm-Gg: ASbGncuS3nJBqFYhfuj5qsJTmcd88wAOQYcPtsYS6rU61pW4klSHNcwOZCKq0Q14e5A
 0Dtvyd3c/ZCgfLfAKZAw+09+kXYXbfBLP8f6pHtGf/Uk9wyekLH5RpEkm2HkiDfNQQChr/nKW0p
 n/jT3nTDxcpmInfmq7JP7UINc5cAS5z0+cS5TV+orPNhJ9Ny86GzHizeU=
X-Received: by 2002:a05:690c:9:b0:717:c649:7849 with SMTP id
 00721157ae682-7183515f438mr112236107b3.31.1752766117842; 
 Thu, 17 Jul 2025 08:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECUJ+FZheo7t/BC00YsCCS4CVFgpM0z/1KpNSsLUcOC22t+ODkOh1QNFhqaxeu+ZhXiTwgir24oMyAfvMezOE=
X-Received: by 2002:a05:690c:9:b0:717:c649:7849 with SMTP id
 00721157ae682-7183515f438mr112235627b3.31.1752766117369; Thu, 17 Jul 2025
 08:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250717145948.77870-1-kkostiuk@redhat.com>
In-Reply-To: <20250717145948.77870-1-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Thu, 17 Jul 2025 18:28:24 +0300
X-Gm-Features: Ac12FXy17nTgHmHi_hP4IVyxwptrz-NixSF4mfkkIATcpOnr38YoDIxdXIZ5Gqo
Message-ID: <CAGoVJZwqxicH1Pd=j4MbijvcnSM-E5bx0H_CtzQrtt-D-K+b1w@mail.gmail.com>
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 17, 2025 at 5:59=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com> wrote:
>
> g_win32_error_message - translate a Win32 error code
> (as returned by GetLastError()) into the corresponding message.
>
> In the same time, we call error_setg_win32_internal with
> error codes from different Windows componets like VSS or
> Performance monitor that provides different codes and
> can't be converted with g_win32_error_message. In this
> case, the empty suffix will be returned so error will be
> masked.
>
> QGA error example:
>  - before changes:
>   {"error": {"class": "GenericError", "desc": "failed to add D:\\ to snap=
shot set: "}}
>  - after changes:
>   {"error": {"class": "GenericError", "desc": "failed to add D:\\ to snap=
shot set: unknown Windows error 0x8004230e"}}
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  util/error.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/util/error.c b/util/error.c
> index daea2142f3..b1342558ae 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -188,6 +188,11 @@ void error_setg_win32_internal(Error **errp,
>
>      if (win32_err !=3D 0) {
>          suffix =3D g_win32_error_message(win32_err);
> +        // g_win32_error_message() failed
> +        if (!suffix[0]) {
> +            g_free(suffix);
> +            suffix =3D g_strdup_printf("unknown Windows error 0x%x", win=
32_err);
> +        }
>      }
>
>      va_start(ap, fmt);
> --
> 2.48.1
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>



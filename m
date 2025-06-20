Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD703C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSasH-00009v-61; Fri, 20 Jun 2025 08:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uSas5-00006X-Ky
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1uSas2-0008IR-Qe
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750422565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AE5n5QzhkPCVAfzHXlR+Ihbf4rSW0uCv/M5UEgHiwwk=;
 b=ZPjjZxyB18ZZzEzSO+I653hhq/Uj9xq0hJdYp0rMJjXIV8vKyOQfQevg5JN6GjQHSeilFI
 7J8P1/h4Ee21j3SZgPwpGVtmv80EuE3b9N9ipvPhkgx3DJ20/OG4iaEhGPJke+HTHAe5AF
 8UzJLr0qq85SZc0/KwbOx3b5dQnKJ+Q=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-6I2GjCF5P2KHgmebNjhvXw-1; Fri, 20 Jun 2025 08:29:24 -0400
X-MC-Unique: 6I2GjCF5P2KHgmebNjhvXw-1
X-Mimecast-MFC-AGG-ID: 6I2GjCF5P2KHgmebNjhvXw_1750422564
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7111ff9c057so26129397b3.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750422563; x=1751027363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AE5n5QzhkPCVAfzHXlR+Ihbf4rSW0uCv/M5UEgHiwwk=;
 b=ubLycgSZDmxaOcsXsYIxG6wR/CPR/KLxE0krTg6FFXpmWh6I2bsa8YY1OVr+GhKcxa
 De/6BxL5YEeQjjQI4i7qmMlHhqJ7kcb9mXWqR0bJA3QPvua8C8JlxZIGPPAXZBzOxQzV
 WXQezFnTxWiggVlUq0Wc0Lrk9i+m56XqEj/cIaRVY810j1quAiQooD23fj2lMjGF2nzr
 aSSViBVcUZTK/Ym6ixFZYzUqv5fTE/4qH0iNj3B1+m1N+9YhRNKLf7Ua16zVBzwCqSBo
 L8zJo/M37jmg4xxDHJpH+++AbjUcTZr+xsQ9k7cmmbayA7FhcBaxccD5tPZe17fdiZCI
 1pMg==
X-Gm-Message-State: AOJu0Yxl1Lu2wY2ufbQEuEH4kqozc76NsmV5wSrpQKI80Xaq0KvxhwEO
 TKuNSNIxjFvHj4ThwBgphLgQw5FNw0pM1p76sfqnDzaggvtZdNUQI50r7r167HYtPnNXsgtfKVC
 /wU9JdN4WmhR86VHvuocdIK29AWdpoEY904Uj3a4kGHzBhMVAcS+CTGV9hQ4kHGgO/N1F7o5dyS
 LXzwdP9siUQrpwRMuhL0/HhrZRiUXHAbJChaXTZt8TS2nZi9c=
X-Gm-Gg: ASbGncs7gV6aAC6XHUsmbZ0Zdsar6B5p08pCfzgNShgLOvDKUGC/myekPkIuOovoMcf
 8VXF+3KONVDH+3fR13yPGG3sSCr9bTje7k0Qtq93/RbD/cm0GvbAyXcSDkq7+tirogmQKNtwVHX
 /S4ug=
X-Received: by 2002:a05:690c:86:b0:70f:9fcd:2075 with SMTP id
 00721157ae682-712c6389736mr39413187b3.3.1750422563702; 
 Fri, 20 Jun 2025 05:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4FpYlaeGwCTChY1ZwHMcuhBwwtj3hJ0pcfxxxtDWRQEd0sCsPBWVrec/Ima2wBmQNsldQANOsxeaKpyd+K7s=
X-Received: by 2002:a05:690c:86:b0:70f:9fcd:2075 with SMTP id
 00721157ae682-712c6389736mr39412977b3.3.1750422563366; Fri, 20 Jun 2025
 05:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250620083132.28347-1-kkostiuk@redhat.com>
In-Reply-To: <20250620083132.28347-1-kkostiuk@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Fri, 20 Jun 2025 16:29:12 +0400
X-Gm-Features: AX0GCFubVRXbM-TIrCd13Jtq3rsRfGGm_eN_UWCFdPPeFeUPlCvVEj3r09eBrOw
Message-ID: <CAGoVJZw0-ShHSc3cLkO4tcUjAwifOFksWLF3mFmX-x3bWk5oVg@mail.gmail.com>
Subject: Re: [PATCH] qga-vss: Exit with non-zero code when register fail
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jun 20, 2025 at 12:33=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redha=
t.com> wrote:
>
> QGA installer uses rundll32 to run the DLLCOMRegister function
> from qga-vss.dll and perform VSS provider registration.
> rundll32 ignores the return value of the function and always
> exits with a zero exit code. This causes a situation where
> the installer does not know the status of VSS provider registration.
>
> This commit forces to change exit code when the VSS provider
> registration fails.
>
> https://learn.microsoft.com/en-us/windows-server/administration/windows-c=
ommands/rundll32
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/vss-win32/install.cpp | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 5cea5bcf74..6ee2f44a10 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -385,7 +385,10 @@ out:
>  STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int);
>  STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int)
>  {
> -    COMRegister();
> +    HRESULT hr =3D COMRegister();
> +    if (FAILED(hr)) {
> +        exit(hr);
> +    }
>  }
>
>  STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int);
> --
> 2.48.1
>
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E107C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 03:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmloi-0006rL-1l; Mon, 24 Feb 2025 22:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tmlof-0006qn-W4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 22:41:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tmloe-0000fV-Cd
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 22:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740454856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+ehHo4FpiFkTJGa28jSCBx7YuM1XYMmrJjDlnsMn+0=;
 b=etFRF0hq/jT9GJPxBEyur26uVWdWbJyvcJeV/4hVb1+i64uwzndXFSs5z3SaZRxt1d1Rf9
 djlvq3GOn7aEj57SDLkWS2K+sfu+6NBfeHezoqs2FNt0wg9ZcyHIHlJgShslpUr7tkin0c
 UlwAcxOoXlGfw6livFh0W9Ql4xKSzk0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-cCGDVlL2PWm0mlRbVCAaHg-1; Mon, 24 Feb 2025 22:40:54 -0500
X-MC-Unique: cCGDVlL2PWm0mlRbVCAaHg-1
X-Mimecast-MFC-AGG-ID: cCGDVlL2PWm0mlRbVCAaHg_1740454853
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abb9b2831b7so574276466b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 19:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740454853; x=1741059653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+ehHo4FpiFkTJGa28jSCBx7YuM1XYMmrJjDlnsMn+0=;
 b=W+uOnidMT5YRN428rieWm0ur7JSaLadwI4tm4gfPXfQvdPQByyuEyxkYcDeY+s4kLF
 GZ8pcLq1cHKETll77gi6rbeRhg+uyVfKuOgZUhVdB6EmWfFg3EHYEm3YxuRlSBz0iVLg
 0BX97OXuUkV0YIMibctcsswtJM2jCLP6i/VgBEJz0JAa5oJaJjvRQcTy0Vmoyl/bJvcu
 gRYu+N6kH25EGapSi5kLl5LkL3Zqmh1MyXFettWz9LK+okhWkJACrJlPcl6s0y3lI16B
 tWymjSFVkx/NfozxYbGqAfPDTGUk1bNA12gJCVwcRoGD9ZDm4TXtQ4RcaYywTyipiSKI
 p61A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwczcpEwNy2v8CfrtQ9dQZwTV8xLLvZGbI4kFvbPvU1GnT2oQXPP8+o+AehMDyLhdP5Gm+eJaFpHxN@nongnu.org
X-Gm-Message-State: AOJu0YwRppTCvaxmhtzfvhDBfEVzSxdWRZ6zkTBG5wxJt8SM8MKZw4Wd
 BXGdY4E1DH7QwWXIGK6Pb828PbvsMKqnB9Xf6hwasYfLg+fdZBmLvF4XgspGSoKScLAvs4hEG49
 T42YmSklmGsdRegtAGsj7+iFcsLRTLypsXy5SBJCGxOedcxGPdUMBxpxpUcm/bR4vlMywA9ZkAl
 61Nv5AwRtlNQswQDi5eSrOqqYPVH4=
X-Gm-Gg: ASbGnct6hpTPoPcurxpaQQQe4PSDv9uAlX76K5YJMsISUEDPuffPyPhJ2rZjK2LAFfp
 7snMJmvQWX0/eRqzL22JTlpEENPDsB7zkXQyaASzkmJDRCrZ7eoSfAIqDPZAVuIr1HJxvhX5Y6g
 ==
X-Received: by 2002:a17:907:8995:b0:ab7:cf7c:f9ed with SMTP id
 a640c23a62f3a-abbedf564b1mr1858046366b.24.1740454853177; 
 Mon, 24 Feb 2025 19:40:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIEe56I3g1K7buGEpqvsh/XKK/Uc5a2b44ZpBPHzuIKsvDnahig9n9lFjqzRGTueix1gB3NyY/vgQrBgSH6nU=
X-Received: by 2002:a17:907:8995:b0:ab7:cf7c:f9ed with SMTP id
 a640c23a62f3a-abbedf564b1mr1858044766b.24.1740454852882; Mon, 24 Feb 2025
 19:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20250221032051.35033-1-anisinha@redhat.com>
 <wdwnpkhgisjqzztersvs3vov4piwqaaxf7gqfm2v2tibbaeakd@rfe24yyhrflr>
In-Reply-To: <wdwnpkhgisjqzztersvs3vov4piwqaaxf7gqfm2v2tibbaeakd@rfe24yyhrflr>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 25 Feb 2025 09:10:40 +0530
X-Gm-Features: AWEUYZnrRCE5dv-WcC9Pow6AJmSy0iAIN382Z1lblbOt0R14rGqB2Mjnf8eou3k
Message-ID: <CAK3XEhOHOKM-XqozhY4Vod8R7-kWhdi1EmnTT38RorG8DRYTdQ@mail.gmail.com>
Subject: Re: [PATCH] hw/i386: introduce x86_firmware_reconfigure api
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Mon, Feb 24, 2025 at 9:01=E2=80=AFPM Gerd Hoffmann <kraxel@redhat.com> w=
rote:
>
>   Hi,
>
> >      /* should only be called once */
> > -    if (ovmf_flash_parsed) {
> > +    if (ovmf_flash_parsed && !force) {
>
> I think it makes more sense to clear ovmf_flash_parsed when replacing
> the firmware (instead of adding the force override).

I thought about that but wondered if that is an internal
variable/implementation specific detail which should not be exposed
outside.

>
> take care,
>   Gerd
>



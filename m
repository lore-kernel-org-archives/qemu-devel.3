Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D8CC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 13:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBvQ4-0002K0-Hg; Mon, 05 May 2025 08:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBvQ3-0002Jm-1R
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:59:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBvQ1-0008RN-5O
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746449976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eP9Sehb2XuJvfRKNgADVlnF7gQcyvw5g2uwOmev3WDY=;
 b=c9faVUtT410IFuLPwdh9zdo52nAZBkeYszfAyCYVLZdq3Lgby/z8yWqT7lf/sOGLWrc2/l
 mgdV+HQLA4/y11G6Nl8d3IqFFI/PJdBaAdSjuH/NGrZ2jNMy/gFqZbsuvTp6PHquVTrl7x
 Lajk17AFCd++UY9tCBojOSrBkqp9bfc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-xHOsHivbPoieA1lCUV4FVw-1; Mon, 05 May 2025 08:59:34 -0400
X-MC-Unique: xHOsHivbPoieA1lCUV4FVw-1
X-Mimecast-MFC-AGG-ID: xHOsHivbPoieA1lCUV4FVw_1746449973
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d3b211d0eso21389395e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746449973; x=1747054773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eP9Sehb2XuJvfRKNgADVlnF7gQcyvw5g2uwOmev3WDY=;
 b=R9OdMf5k8SN9NMQNAXbPGfXpDEdMzk7o7g1Jmui0AByo/BvxYmyTBe3ihA0+5u/cUp
 NzOlVV4cMdbOkYt0+BCXFdnJgcQWSr+4yBfgXouspiCiWzPK71SCkNbeZUJ7XQ3unV8+
 ls+JC6JmIvpxbDxTUoWh0tx1OfUTdsSfAPgS2rF/ro7URUbw63zXh7P8hPwCAmio1DMe
 OQ4sSw376pn1WTuijQ0fJX243vHZ/cywqxN2lfZfnPDvVSoWTbSojMpoRsN83c18h9qW
 x1YuJr3IRyJ6LlUHN82gi6/ndk280w5qHkCYpvK3dTFJpnnD1liIrnxY3xcAr8aMzS6l
 JQfA==
X-Gm-Message-State: AOJu0Yzhq+I3eIpwMKWQbTSXryfCBhz/CuTH2p3tn3J8ItnphNXDSQxS
 FphtZxh2oC/zzDEGX+zm3A4yMDn0yWglNUKaLR1k98OkJ5W+l3Gj2BYmdOEZMRkk5fkWLv1bRoM
 3TDoIFHOPM+0i4nQnQsb/ddyPn3s1vegPTi5+ECV1h89XO6XujPrANN26tC7GwL6lHnZIeAVo76
 SOn3Mwj5mVPLSOR2oPybThCmLi0Os=
X-Gm-Gg: ASbGncv+kRCvqgfo/onMpNNYru0qKvoO0zLopHA05gV25LC3frzP5Zix9XHVrnD2Sln
 NmUiRJhJJ7et/e8hFZzpSDhpcx5sl5tgbKZzBmoHsE6arm2N88GafuANiN/UsI6V6TW6d
X-Received: by 2002:a05:600c:a06:b0:43b:c7f0:6173 with SMTP id
 5b1f17b1804b1-441bb85274fmr94384685e9.4.1746449973610; 
 Mon, 05 May 2025 05:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9JH4uGoiy0WjIhu/G3UtUlrIX5BbdAu/jRyaCGd4Ga902WDey9nz68ci13hDKbogZBQVhAxE3qSrR2+m/bJ0=
X-Received: by 2002:a05:600c:a06:b0:43b:c7f0:6173 with SMTP id
 5b1f17b1804b1-441bb85274fmr94384545e9.4.1746449973289; Mon, 05 May 2025
 05:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250502214841.242584-1-pbonzini@redhat.com>
 <20250502214841.242584-3-pbonzini@redhat.com>
 <5d461945-155b-40e8-bab4-502e57d94b03@linaro.org>
 <674de496-b0fb-486b-b74e-f4f856e6d9bc@redhat.com>
 <120a2e48-ded8-400c-bfd5-83b47c8c17fd@linaro.org>
In-Reply-To: <120a2e48-ded8-400c-bfd5-83b47c8c17fd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 5 May 2025 14:59:21 +0200
X-Gm-Features: ATxdqUE3K4ncwEM0tF8n5iiSVcwYAlZJI1MeuDoTwVPENqzZv9vYEqta6ZirGyo
Message-ID: <CABgObfaNoytDo5RZwoP3r14DHuVvjmscyH72QfvaWjfOn5E4Xw@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/i386/emulate: stop overloading
 decode->op[N].ptr
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, wei.liu@kernel.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 5, 2025 at 12:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> > I don't think target_long/target_ulong is a big blocker towards single-
> > binary anyway.  The trick is to confine it to target/, making it
> > essentially a #define.  That is, let target/* include one of two new
> > headers target_long_32.h and target_long_64.h.  See lore.kernel.org/
> > r/68b6c799-6407-43cc-aebc-a0ef6b8b64fa@redhat.com as well.
>
> Yes, I have this tagged to understand and address. Maybe Pierrick
> already understood the issue (similar mention from Richard? [1]) and
> is addressing it, see [2].

Those are different.  TCGv_vaddr is able to store a *host* pointer,
i.e.  a host uintptr_t.  But target_long/target_ulong are already
completely absent from tcg/ (there are a couple appearances in
include/tcg), so I'm proposing to remove them completely and leave
them as just macros.

Please give me a shout once the target-arm/ series lands, I can look
into this further.

Paolo



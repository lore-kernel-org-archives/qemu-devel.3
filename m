Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB08C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0DT-0000h4-Di; Thu, 06 Feb 2025 06:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg0DR-0000fb-7K
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:38:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg0DP-0002hc-Ea
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738841918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fuCwd6gmcD0q8LQlCXMmaFkFh++j2NBuIIAJ2XPBjRs=;
 b=LUEsjMubYyFSHbwuFTaOeY+rSCyab7rZ3ms6/X/eQs4UlNQlOO1I8QnJqZU/Y5jYhF7VUJ
 NmUwKWmB5FH+CT4W4rwXDZF6yGsR5MtJr7P2kzK0sgn9ch/OnTLoJCTEAdugR+USeH8NVH
 zBvEXsUYvpENaL2nTUr9NOu7WhiJVBw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-f8uNsuUZPV631md0cLXhmA-1; Thu, 06 Feb 2025 06:38:36 -0500
X-MC-Unique: f8uNsuUZPV631md0cLXhmA-1
X-Mimecast-MFC-AGG-ID: f8uNsuUZPV631md0cLXhmA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361f371908so6361935e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841915; x=1739446715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fuCwd6gmcD0q8LQlCXMmaFkFh++j2NBuIIAJ2XPBjRs=;
 b=liQz6LlMERsRXNfJ1shpa5KouJKW4B+e4qlEh2TnJ54tf65qsRlUELs7yPKBXpQ742
 N46vWtXoM6jHXmtYWmZAseuMaU/H/LUFknCpbR2klOfj34OX47RU8YCvoFEj09SYNmYN
 QqGxULyqetapdG04rMLii/6E5VcFe8CapCSvncq+7vWcYRHWrBiP/zY9TEYNAE/C+3Qv
 1sHRuh/L0IsJ9JFwJXB/WJFmnai+PD4qizZYyAr7Q2xxweFVkEOsRuxUwK+NHvOG4YlM
 4NzOwFaVh6gDYY9YFxhl6oywS+TTbwHoVdq5qFk5IvAGnoOEzRHpBO7eeGHqodgqLOfs
 fDgQ==
X-Gm-Message-State: AOJu0YzGdxybrbBQSps+bxvb1fAwnrgdsAni2ALcObyR/DT0+ILWsx+i
 3841yeuRWZsrnGrNlk7qM/grWV+rSys6qyytiSblGjdZjL0wXIyEZiZofi+x3RY5AjHtrW2VcFE
 mEknSOl4Q49cRn3rqptEut/IPDZIlWMlzEL6+GApxX0wVxYOOu7KhMJwtB2QYviyRFfAqOuFl60
 9MJs/AUn7X+BX5KaT/FRp1ry89DQM=
X-Gm-Gg: ASbGncv0s8dAF4TVqVu+zFXbYwuOid9yAT15KSq3nCt5Hr41kFgJ68hDG1Ow6kNd3Nx
 zoen2/Wn1PYU8eGCfj8GsUIsXuJ68+kqc4BN5ostXszGmyYgbnWe0rwBBoGEp
X-Received: by 2002:a05:600c:4e09:b0:434:a5d1:9905 with SMTP id
 5b1f17b1804b1-4390d574c4bmr42007465e9.26.1738841915044; 
 Thu, 06 Feb 2025 03:38:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCT48Lsi5MtAl7N2AUeYfaeJIQNJPHAHVGarctUCAeBOjy2wFypVdb8gho0JFlcoZGGlKKgsuUyy9p2ffTKzw=
X-Received: by 2002:a05:600c:4e09:b0:434:a5d1:9905 with SMTP id
 5b1f17b1804b1-4390d574c4bmr42007275e9.26.1738841914732; Thu, 06 Feb 2025
 03:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20250206111514.2134895-1-pbonzini@redhat.com>
 <298a7473-e5e5-418d-8902-2cbd30730db6@linaro.org>
In-Reply-To: <298a7473-e5e5-418d-8902-2cbd30730db6@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Feb 2025 12:38:20 +0100
X-Gm-Features: AWEUYZlBwJMKe0PFy_urG_tmTbfKNiaqXZ0UZfqzGJJ7wbNdiVM7OBs0AT10ELE
Message-ID: <CABgObfYzncjR=DtvE8asLfqJA89JjatMzs352F=4PbfTBrq1sw@mail.gmail.com>
Subject: Re: [PATCH] rust: add --rust-target option for bindgen
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, qemu-stable@nongnu.org, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 6, 2025 at 12:37=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> >     if bindgen.version().version_compare('<0.61.0')
> >       # default in 0.61+
> >       bindgen_args +=3D ['--size_t-is-usize']
>
> Should this be merged directly on master as build-fix?

If it's breaking CI I can send a pull request later. I wasn't sure if
it was just my branch with other Rust changes.

Paolo



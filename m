Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E0DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJuY-0002wv-MZ; Wed, 27 Aug 2025 13:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urJuW-0002vr-P0
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urJuU-0003Bf-IB
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756315560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqtdo45yfZ59Xenw349d6laLyJdcIHIVyOugR+OF3zY=;
 b=KdR3cWU/fiNX3/kJTpjo9/JeVUaVMxxuSW3DQFQibg9rzZUY9IIc4lUWYOX2NmT4dJk1FJ
 5Fzlw4GU02gNnTspb/J9YQh6/zqJC7j3Cy3RciEsZAbtxUeLzymGZtMNe876yMtbV/8Eli
 X7WS/lsmECQakYqW6A7kuDb72BZlyOo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-vY92kwrAOuSAIRyw_BOdEA-1; Wed, 27 Aug 2025 13:25:57 -0400
X-MC-Unique: vY92kwrAOuSAIRyw_BOdEA-1
X-Mimecast-MFC-AGG-ID: vY92kwrAOuSAIRyw_BOdEA_1756315557
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c584459d02so25309f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 10:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756315556; x=1756920356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqtdo45yfZ59Xenw349d6laLyJdcIHIVyOugR+OF3zY=;
 b=OlykgG29/O9uRP8CiUf+5aAxLaUhGq11mVWxUieAmOUZidO8h8fqhFn+fPaXWsuXvX
 CrvUcnbAvtPwTSEcuaTIOJ7HD/QMk6ARoTg4Cv/2xgsx8z7Sc2wn720UwDB/VNDcSmWe
 GNluZggN6W8cdYbOXRWzK2MmmRXSrut7djHHx9udU3iKE69DXmL6k+Em4dI/bNf+7QiU
 aC7m0v+PRWr9LA/vNXySL0AAMg82mUffxOGJcb9K7UFUf3lBXHCpI8ml2/IgJ8pGZGQR
 ByEnUD2TMwYFlF0g434YSJMB05Yv0/g43cewL0TI4Ggt1Qwf/A0wx03GUAbBu2RH8G8j
 d1Nw==
X-Gm-Message-State: AOJu0YzvAdWuluW3+fhvgUuNbL7rjgQ05WyiKUjqmX99GICpMF5+bNyT
 G9DreM3F1kkPVwSt17+E2qV50orWh5qXirvkuOUumDYRJlDm88GABEHPHlE3cx1N0URAmFmxayB
 d2lfgf8IBzs0hzmPWy9deYzm/eRMy6/jnoSuQHEeGL99Ki4IyWHQUNM64MgAL/bYE3DeXd8+i9+
 T7UyGaxcvuPZe10wcIgdhVmvbqFUG1O4M=
X-Gm-Gg: ASbGncsQyqiLoj8Fi1LIcr47QQO7p7herVmQ7T/CEuDzVTWsyw1qyXr09dLqCmJTNko
 JNn1fLpie8s/VvqxLqdrFkI8kl5W/d997cWA9OMf9lFJPiinWlumIjBG/kNZMwhF1JVO3rS88qk
 fhCHmcgH9oA8/wVe4KFpo1YP39ZkYiNunLTbaTWAO8wOtb0hzwQf6ymT/fswMhkYyUw7yKfY6Vi
 GjLBfcd4behU8ntMpOfm1ul
X-Received: by 2002:a05:6000:40c9:b0:3c9:52db:9f64 with SMTP id
 ffacd0b85a97d-3c952dba323mr9274302f8f.22.1756315556578; 
 Wed, 27 Aug 2025 10:25:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj2B8F0gX2zqSi5oUd0dmgAOtMZCRqFZW6+faOXyrPLoZa8Jluznh/kqIYStSYjFl2ILAqhWGXl6XZAKinR2M=
X-Received: by 2002:a05:6000:40c9:b0:3c9:52db:9f64 with SMTP id
 ffacd0b85a97d-3c952dba323mr9274286f8f.22.1756315556151; Wed, 27 Aug 2025
 10:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
In-Reply-To: <20250827104147.717203-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Aug 2025 19:25:43 +0200
X-Gm-Features: Ac12FXyo8WIeMmAiMQhntMuSM3t8U04awH6yQ4Ew0JS44Wd30kR8YTRn5_MBWiU
Message-ID: <CABgObfb0tQZz5WHWuHW8Q3nkEjFcYxGzoMTTxW1oyVCWv+5MUQ@mail.gmail.com>
Subject: Re: [PATCH 00/22] rust: split qemu-api
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 27, 2025 at 12:42=E2=80=AFPM <marcandre.lureau@redhat.com> wrot=
e:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Hi,
>
> qemu-api is providing bindings for various internal libraries. Instead, t=
he
> bindings requirements should match the various libraries and use the mini=
mal set
> of dependencies.
>
> An initial Rust-only "common" crate is introduced, then "util" (for libqe=
muutil,
> without bql), "migration" (so it doesn't depend on bql), "bql", "qom" (ar=
guably,
> bql shouldn't be required?), and "chardev", "system", "hwcore". Finally t=
he
> qemu-api crates are renamed and repurposed.

The only question I have is about having bindings in each crate rather
than in a single common crate. I'm okay with doing this on top,
especially given that I spent too much time rebasing on top of all the
pending patches. :)

Right now I'm stuck with doctests failures with the patches that use
Meson's new support for mixed C and Rust targets. I'll probably drop
that, but (as a heads up) I"m probably not going to send out a pull
request until after KVM Forum.

Paolo



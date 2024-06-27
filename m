Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30924C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 08:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMkof-0004gV-E5; Thu, 27 Jun 2024 04:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMkod-0004gC-N1
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 04:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMkoc-0004kd-79
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 04:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719478153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MoDU1w4EyNzMnOvWSDy27Zipe8MUxj0nCacMBhMW7g=;
 b=NHxUzNq63iceHM4QuiiM1lyFh64fUrMe21rdd4qRNJ6t4xfatr4qfRHiFFuQtxMZJam61y
 eecjYjNdqInA1lBh0bzMKajkFAZNLMDl1yhsJVMxSJ6g8S8ddUOr78L7nlYF/2lLXvMlQf
 WlbTFBdZUodjXOz2TiEcYyllxF5RCPc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Nte2ubWnM3ObB4EiGTC4Nw-1; Thu, 27 Jun 2024 04:49:11 -0400
X-MC-Unique: Nte2ubWnM3ObB4EiGTC4Nw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42561ad2db9so8371915e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 01:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719478150; x=1720082950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MoDU1w4EyNzMnOvWSDy27Zipe8MUxj0nCacMBhMW7g=;
 b=BbqOhFW/U4a1kZQmh6pvtp2eYGmXxvFSRl3Dqig8XPSiRJEKE/A+ABMyOPhb2Rk1TT
 GN46jgDZMBRXftwiw8RCGh9zfpiFrnkNGPX5PnO0fDCQugBUPePL4JWWNL9RfMhwg+Sp
 yKYd0ZVCKvJTsCBpnVncJj6mY+8Dolv3P0TnWsPV2gMDej3A8OeGRyezsL1UuCTSq/Ol
 zfp67spYxQ71bXJcgyXQVWgq5yNqPRchMyqtIzRrPicUXYQzzR6xXYM5Y6TKKZocfQ13
 YtJ6UfnLOaeFWZ4NXWHUo4EhE8RXTASwvIIjQ8y0Qx5Gyc81cfAUTkYS5za2HsUukD/X
 cAMg==
X-Gm-Message-State: AOJu0YxFZkMezIKthFDLxSyzTSsNjQ9UJxmhKscVLOyF3o0IWWPdSzAr
 MXsBPo+3+HP6zJDDIBcVpF4c7eSCjcCsUeoM77CT+kUo2OeCZM2BmS6ikDbYhOLo3jDPLKhl6Es
 qo6DoNPtAVaHUdTD53YlNe2p/2zAn81CyONcYEfv9SA+XpPRjR/+ry2irtMi/6A9ZIg5iA/Nls/
 dwH7juhBj2eNXyu8s5Sq/9ewof+z8=
X-Received: by 2002:a05:600c:21c4:b0:424:ad85:2004 with SMTP id
 5b1f17b1804b1-424ad852267mr28775895e9.14.1719478150190; 
 Thu, 27 Jun 2024 01:49:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm6+6r0V2puMLE4f23mW/UNsFcgbEwsmFRtlOHh9KjEl1MydWm6616t4INviELj248LtAKm9gCPjrSJqKH04I=
X-Received: by 2002:a05:600c:21c4:b0:424:ad85:2004 with SMTP id
 5b1f17b1804b1-424ad852267mr28775345e9.14.1719478148281; Thu, 27 Jun 2024
 01:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240625111848.709176-1-pbonzini@redhat.com>
 <fnhkw.xyx5xkm2lgb@linaro.org>
 <CABgObfaK+CQTni9MQjTADY-Fode9Fg3hTqSfm+2K8R9DCRJ5cw@mail.gmail.com>
 <fqdc2.8zr6z4s9qcnm@linaro.org>
In-Reply-To: <fqdc2.8zr6z4s9qcnm@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Jun 2024 10:48:55 +0200
Message-ID: <CABgObfYuf3Bbu_VZt+6Me6HpPhMo04hm_dyFvQwTCKdm3uEuAw@mail.gmail.com>
Subject: Re: [PATCH] include: move typeof_strip_qual to compiler.h,
 use it in QAPI_LIST_LENGTH()
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, flwu@google.com, berrange@redhat.com, 
 peter.maydell@linaro.org, rkir@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 27, 2024 at 10:38=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Thu, 27 Jun 2024 00:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >On Tue, Jun 25, 2024 at 9:17=E2=80=AFPM Manos Pitsidianakis
> ><manos.pitsidianakis@linaro.org> wrote:
> >> >Move the macro to compiler.h and, while at it, move it under #ifndef
> >> >__cplusplus to emphasize that it uses C-only constructs.  A C++ versi=
on
> >> >of typeof_strip_qual() using type traits is possible[1], but beyond t=
he
> >> >scope of this patch because the little C++ code that is in QEMU does =
not
> >> >use QAPI.
> >>
> >> Should we add an #else to provide a fallback for cplusplus until the
> >> alternative is merged?
> >
> >As the commit message says, I don't think we need to include the C++
> >code in QEMU since it would be essentially dead.
>
> The #ifndef __cplusplus part stood out for me, if it's not required for
> the qemu build then it's similarly unnecessary. Thinking out loud here.

Yeah, the patch had actually two purposes, only one of which is
explicit in the commit message because the other is more relevant to
Google than to the upstream project:

1) Google wants some help making QEMU headers compilable with C++,
which is generally not a goal of the project but not something we want
to hinder. And if that brings to our attention things that could be
improved in C as well, why not.

2) it is true that typeof_strip_qual() is useful in other places than
qemu/atomic.h

Since qemu/compiler.h already has #ifdef __cplusplus in various
places, and could reasonably be included in the few C++ files that
QEMU has, it makes sense to have a #ifndef __cplusplus in
qemu/compiler.h (unlike in qemu/atomic.h).  Personally I prefer to
have a little more cognitive load in common headers such as
qemu/osdep.h and qemu/compiler.h, than to have different styles (e.g.
no qemu/osdep.h inclusion) in C++ sources, even though most likely
I'll never touch those C++ sources.

The #ifndef is not absolutely necessary---if we removed it, Google
could work around that with "#ifdef __cplusplus / #undef
typeof_strip_qual". It is mostly for documentation purposes to point
out the C-only compiler builtins, and because if anyone ended up using
typeof_strip_qual in C++ code the error message would be very very
long.

Paolo



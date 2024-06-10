Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64362C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGibw-0005ie-VR; Mon, 10 Jun 2024 13:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sGibu-0005R4-5m
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sGibs-0001FR-FX
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718039706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjXAJieQan5jruhFQX6j+mTHP+pcuv9sD86jPllSpaE=;
 b=W1UBdxFtBDjZUhoL9vwo6JpbzfIwaxaajdG1You+6fzVvJ6NiTTWMJI9E7CIJyJcx60r4N
 RrqWaxiZgprIXeI3qHNoIGkSzsPZ1dnbnCivm0etKWI1DIpSHbg5lG8NuQRyrdHndMtnMP
 6LESEVMb9EfYQVfgPo9uc60B0hXuF7E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-58mYxn9yO_aH9gKcGBDu8w-1; Mon, 10 Jun 2024 13:15:05 -0400
X-MC-Unique: 58mYxn9yO_aH9gKcGBDu8w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35f18355552so1207129f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 10:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718039704; x=1718644504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjXAJieQan5jruhFQX6j+mTHP+pcuv9sD86jPllSpaE=;
 b=BgTN2zvPGIFnxYgyyzzzWqmcFyWI7zIHdsOnpBoEP8blsyYUQW+nqxnh8EMmvdcYmS
 lAC6TS2xUttC4pVKzbOMYD1CbKHFxSr8qqAYwoNl9uxO7inIXBqisXjF62gkpkMrjtVt
 Nm8UhLmIZQ/bfJ3g6XjyzAtDSLg69n0smpDxqbWqTy8iT4UdQ5AQVDwHUk2R2pBthvaJ
 qRwi5NnLE6jLw3LWsrPVfSi1Iiwj+AxOVlwdeVar13c/nn77NEEAtdKR8jtUG25UtqJT
 ayW7IY32PBEsT6s/nDjVJiKtIGkqULp+Kmg8GjHDYBujHLyQDAisydApGDCRO2Ws5ia6
 aXfg==
X-Gm-Message-State: AOJu0Yw3k9yRyPrCt1AYfKU0xz+L+JrF0XSL2Mq57jUnpN1+JWI11SfP
 ad4+CUq5mGKZuUbREhvygdvyFA3ytuL9JKiFV6TJilNIjWYFVQVtlb4lu0EW1QThNaQzXcW28Rm
 lzGxEaqB8S/04DdBBkjJm+Np1TMWY6vh0GMfVeR6CmJ7KlHQz5WlI0BOb44A1uaWnhGqGpJYUnO
 dBCg01qwm7ilAP8e0g8yFNBxEEdKE=
X-Received: by 2002:a5d:5f41:0:b0:354:f92f:fd00 with SMTP id
 ffacd0b85a97d-35efee0367fmr9207335f8f.52.1718039704113; 
 Mon, 10 Jun 2024 10:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH91drIeqNoIHI5x7VFUlH8H+gV67cpleEGnF+R3U6Nqm2U+VVEWQ+HaW/oVGOf90rSmNNJoKEe05dI+gKesQ8=
X-Received: by 2002:a5d:5f41:0:b0:354:f92f:fd00 with SMTP id
 ffacd0b85a97d-35efee0367fmr9207324f8f.52.1718039703811; Mon, 10 Jun 2024
 10:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-12-pbonzini@redhat.com>
 <f78d28b3-6f4a-4db9-8dfa-1a3a2add4e0a@linaro.org>
In-Reply-To: <f78d28b3-6f4a-4db9-8dfa-1a3a2add4e0a@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Jun 2024 19:14:52 +0200
Message-ID: <CABgObfaGEHG6ipFs7ZMFtxh61ZJkLJ3A6WiW__Cr1r6DP1fKcw@mail.gmail.com>
Subject: Re: [PATCH 11/25] target/i386: replace read_crN helper with read_cr8
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Jun 8, 2024 at 8:46=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/8/24 01:40, Paolo Bonzini wrote:
> > All other control registers are stored plainly in CPUX86State.
>
> s/stored/read/

I mean the CPUX86State is their storage and it's plain. :)


Paolo
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA57C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 16:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujKUV-0006WM-2Q; Tue, 05 Aug 2025 12:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujKUL-0006SZ-W6
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:26:11 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujKUK-0004ZY-CQ
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 12:26:09 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-615622ed677so7945764a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754411167; x=1755015967; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctDD4ojVMW3xLQbxQJExtkZU5MhZUig20HBQ012Ftbc=;
 b=hRXPqPIKQyJ7s6tC6Rw0zpaOrNgVscctjBdb459TF7up2l5V6NrC6o5yu5rizDEeBa
 /9xplrn6CnqWDO5tk+XToqJpp5Kfa7SAuvDZCxPoaYjTDdex6DWnkrFpO/msSQIhXABD
 cRbRn4JgbqzE4ku4IWUsASIL3yNErJI2otHlcBYZmBgNr3HEGcD7RGyb6SVu2ut115NP
 yu700KQTqMdxqbsuIojeSd9weVtPpx7JoxlILFgolLlFvLW2jZaB+27cgtzYbIzmfHO+
 Rrq7eFe9oFh5jDAB8fZbiVGGZu5ZAwRXfQD58pSIHXCnv9izlWWDuJPE4elP3Kg1boUg
 nj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754411167; x=1755015967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctDD4ojVMW3xLQbxQJExtkZU5MhZUig20HBQ012Ftbc=;
 b=LCViSU5G7uliENltcTxTgVd9JoDRjngbjQAZ+VIXQFZXjuzNe6y1nHzwaxTzf+kKji
 le3NfYAifjoPoqfFedeqwbBt6edrVUU79Dde6iJf5YC10ncgpVtmAnNR7XBryrk62v+j
 j4yJghLd1TJ1wlamM21PvBczxeHgzpcRWCdPFZVKObC0jckbTdC0BgNdzU1Mg93jm+se
 c2jj7HmEJvppy1gdUnaL/56pahVs77ZPArLp+t/TkpmCAJ9W5JUUuH56RGvtHDH9rY9W
 sHRLPAVACya9WQkXsw1mXoM5fqdvg1F3WTLiromjs57encWv7uDdnI1vYfQZN2sRuGpo
 akeg==
X-Gm-Message-State: AOJu0YzB+pdCOoZkqxm9DFjWGGScX3ggzHVBW/8pv3uzN+dpc1AXJaxN
 ojsrCypGWu/+R8Qwyd9To8B8+GfownkmWI8BQ/XZfxI7L/VULUWRIUDzzN1HqksfoCP+iMU8TqY
 +KZKVb5895fpAPAg8PZRUg0Za12c46x+CtwA8GB2kPlWCGcI6IyD1LVo=
X-Gm-Gg: ASbGncsOBfUYLZPEcPW0cyv89u5gAohYWxK4dVNER/26rtuWcDR1HtZae5NTz/K2Fi6
 dau3UN7lChQdwoOXkyKE1O8QD/KDmlYxfjfi/z+h9N+gQu8vKfY/6bhJoNuProLMy64x/F9QTEp
 fP5mHcYvhoFUJuFucZd9jf3vQLmuxlm9wdozb2rXQ7/VGq9Xf7CUptt72eCV0TP+KH/pTHjKbrT
 VBrE7tI
X-Google-Smtp-Source: AGHT+IH34Xz+fR1TGDGWy5pZIgdFMck3gAUoadnLBvlwrVMYdNBeZ0JjOGaCkivCWqyfkahbZBOslvqPmoUooGTPdQc=
X-Received: by 2002:a05:6402:2790:b0:615:cc03:e6a2 with SMTP id
 4fb4d7f45d1cf-615e6ebec77mr11865486a12.1.1754411166572; Tue, 05 Aug 2025
 09:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
 <aJIrpoEhrl7aLBMg@redhat.com>
In-Reply-To: <aJIrpoEhrl7aLBMg@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 5 Aug 2025 19:25:39 +0300
X-Gm-Features: Ac12FXx8E0gmSgkarH0Hjtyobz0jylMHi8y9z6WEMl66GS6SogknlrgbBxBH2BY
Message-ID: <CAAjaMXa6ManykYJJk--vNZT7oeBW9UR2v6WixaaQ8LUCSjy9Ug@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] rust: implement tracing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Aug 5, 2025 at 7:05=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Mon, Aug 04, 2025 at 04:47:13PM +0300, Manos Pitsidianakis wrote:
> > This RFC series contains some simple patches I've been sitting on for
> > some months to allow tracing in rust devices in a similar matter to C,
> > only it's done via a proc-macro codegen instead of using tracetool
> > script or equivalent.
>
> IIUC, this series is only emitting the traces events via the
> qemu_log function, and so feels like it is missing the benefit
> of tracing, vs the traditional logging framework.
>
> In our RHEL & Fedora distro builds we disable the log backend
> and enable dtrace, so that we have fully dynamic tracing and
> observability across the kernel, qemu, libvirt and other
> components with dtrace integration.

Hi Daniel,

Thanks for the insight! Do you have any points where I should look at
the trace implementation for how the different backends are supported?

So I think there's already work in progress to support proper tracing
for Rust, I only sent this as a temporary fixup to provide some kind
of parity between C and Rust implementations until a proper, better
solution is available that can replace it.


--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd


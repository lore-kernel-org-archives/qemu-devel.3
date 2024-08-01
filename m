Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D88C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 03:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZMfT-0007Rw-Ug; Wed, 31 Jul 2024 23:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZMfR-0007Or-8I
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 23:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZMfP-0001RP-4c
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 23:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722483589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9W2VRIIGErciPW7gZomIT9/wCLlvJpDwZh2b3ecZfw=;
 b=Zh3uhhOd9/s5i20Prnd+UkjoqOTjCNpj//kECTRFyhVPjn95NkigSnhH70uc5abPA6z5OC
 iihXlLCgxpZ07dQq9QMf/PJj1tcZEsgt7Knnn5qnmDPis5HyyrKfKL8D9lDCFaaMo4dQQl
 L7ZovpjOrpyTQEG5Fac8mfJHYhptDaU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-y04cw0dMMvei4KFET2u2JQ-1; Wed, 31 Jul 2024 23:39:48 -0400
X-MC-Unique: y04cw0dMMvei4KFET2u2JQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-668e964ffd9so135296777b3.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 20:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722483588; x=1723088388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9W2VRIIGErciPW7gZomIT9/wCLlvJpDwZh2b3ecZfw=;
 b=hKRhPmBk23d11F2YCYb7ADlliicp+WNgMXCj8XjdHZ+vph1TxLulI1AAr1zUdqLj16
 r+AC+jsthtjgHtiBDHACYD+cntB3ql/KrWxHrpYN9DG/2bBpRqmKxWXwyN7qP+gcdVs9
 vMWBMPcSbozVmFlqMHxJ37ZHLSfoDh/mPLPFJKUEuf2PhOyS+3I3PI1N7dZl0GRI8Wn+
 fjsw980n9Ao5vz4IsM3YFltmnXbgk78OU7NPJbGN6aopATRzjrWnLuGNZ3QWapCaT9Nz
 3naDos3B5i6eIxRDEunm2lmZQFj2DA3dKxT5NcrCRaQio7/LxN9+L8vFtAy1hHAdNo5c
 CqoA==
X-Gm-Message-State: AOJu0Yz1tX6snXQj7xjkwPSGIVoN35rG8kNHeyqpE66FF9WOVJ4DInes
 CpUyqRQ1hVYEsmViBms1CSvqB8245e/hvq07lpYkB5c/DHTTmF+nuHSXGfg0tXHu8tdBUw2/hUd
 FkpkTwyzUxLz61MqShMrBAMthdN7yFkds8AKIo3+nl/ePuUDZpfnZ1ovukwLtQcGzMUM3bO91Ir
 ny1uxwzC4FBpKhKPmw+Li3XGzU7Ts=
X-Received: by 2002:a0d:dc81:0:b0:65f:8218:8b2f with SMTP id
 00721157ae682-6874f605a38mr12027987b3.43.1722483587796; 
 Wed, 31 Jul 2024 20:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLNXMjkzKFeq0Hkwcz0rr8sBTxEfS/YnzcIywxu4UXEdTXHUdyXidwbCMQ4MFl7YAW13Q/2xD4unAf0lbN7CQ=
X-Received: by 2002:a0d:dc81:0:b0:65f:8218:8b2f with SMTP id
 00721157ae682-6874f605a38mr12027747b3.43.1722483587507; Wed, 31 Jul 2024
 20:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-11-crosa@redhat.com>
 <a7f2d78a-4de6-4bc6-9d54-ee646a9001fe@linaro.org>
In-Reply-To: <a7f2d78a-4de6-4bc6-9d54-ee646a9001fe@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 31 Jul 2024 23:39:36 -0400
Message-ID: <CA+bd_6L7o05mENKVuLLfMFK9OF6ckU23ue0xmxiWO5oiT4ZEbw@mail.gmail.com>
Subject: Re: [PATCH 10/13] tests/avocado/tuxrun_baselines.py: use Avocado's
 zstd support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Mon, Jul 29, 2024 at 10:39=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 26/7/24 15:44, Cleber Rosa wrote:
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   tests/avocado/tuxrun_baselines.py | 16 ++++++----------
> >   1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_b=
aselines.py
> > index 736e4aa289..bd02e88ed6 100644
> > --- a/tests/avocado/tuxrun_baselines.py
> > +++ b/tests/avocado/tuxrun_baselines.py
> > @@ -17,6 +17,7 @@
> >   from avocado_qemu import QemuSystemTest
> >   from avocado_qemu import exec_command, exec_command_and_wait_for_patt=
ern
> >   from avocado_qemu import wait_for_console_pattern
> > +from avocado.utils import archive
> >   from avocado.utils import process
> >   from avocado.utils.path import find_command
> >
> > @@ -40,17 +41,12 @@ def get_tag(self, tagname, default=3DNone):
> >
> >           return default
> >
> > +    @skipUnless(archive._probe_zstd_cmd(),
>
> _probe_zstd_cmd() isn't public AFAICT, but more importantly
> this doesn't work because this method has been added in v101.0.
>

While it's not the best practice to use private functions, I just
couldn't accept rewriting that for the skip condition.  I can make
sure future  versions (including 103.1) make it public.

Also, these patches count on the bump to 103.0 indeed.



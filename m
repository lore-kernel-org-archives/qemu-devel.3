Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE791C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 10:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuqVO-00070Z-Ud; Wed, 19 Mar 2025 06:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuqVF-0006wI-13
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 06:18:25 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuqVD-0003PP-1J
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 06:18:24 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e64165ae78cso2754187276.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742379500; x=1742984300; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NCh+MqeE19DqyiZ5qyOGqsIvmjuez28QeAt6LJMyB5w=;
 b=OeNJVLx9Ql3xVL4FIrzQUCfmcLGRF9AeZyopMsA8ZUbGCV1Rj3bvI3mfHoSHnJSlZx
 435J8owWdgC/UEuqpDe8FluScLSIRM+AsWrLVjwFqIez/lzBW5ZLqx4w6MWGcSLoTpk/
 9Q2TrhUeZ6uRm6QY/49mbxrx+H1P3kTZco0eJRRnKUIF9HaoferaPNA2UZP/1wCqBNok
 mlhyx3rBiICJeURckZPHWJk0Y9PhPJNiIOoll1upZqB1v85sUwrPxCGW191M6oKp1Do2
 jQLqrsMtxe0tai7pi3YOtx1aLQGa+j5Ey6eAGbtFtoba8dY6snMUYiqyQ7ggIC/pgXme
 ef4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742379500; x=1742984300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NCh+MqeE19DqyiZ5qyOGqsIvmjuez28QeAt6LJMyB5w=;
 b=EHmUZ45QrbqWpF+6SJQyRPpmKiZoZpegdBYYV5cBU10rJsziucifgn7G81bFwEmd4k
 P0QenBdE7HCmH8Yay06VntH2fIxyRpojI+Ri1Ovc1kpvyf1v3tZSMM8sgBnWmgb3PAlc
 FyECHzzPRs8Iw0YbBK0gzxlPOADnVuwUEuuMBbiEeNd9ju1R6IIqnDUKeB+OVcU15ODZ
 j1d9GJBcKqAvOoDRI9cDZyGEUbjcG+1/m7633sJowYINFiJL3AAWzxZ+kXVeb+RjwZgv
 CgyY04nGwPNOkr+n1DYLGLezhqbvORYmYXF72yblk4mYi00+9MaF/DllJApXnC0q2xPn
 uFRA==
X-Gm-Message-State: AOJu0YxDN7/fiYZt0O8guOdphnykC4LjNExLg/y6tZkMTfZ+fSi3RTz+
 0GLTiM7unFEUbgcRsTHPvf9oo86gde+1gpdCarn69Hz8wYROUjrgJztIJdyXz7ZfF2l/Wu98RtA
 Dj4pck4d6v11FZ+y2ZwVdElCk6kIYDJ8WiqPdQg==
X-Gm-Gg: ASbGncvSCM8DxWwLe4J1sU9qQpMjn+0Q5hHhJMZsrVWT0vi50V7F0H8NygzZddf7bIg
 tf8f3BIP3YBtGjyq0twcoXY1k7RcusVetiQt2z907d6vMZl714B4fRIxjGE+ZCxpEs4KM3t/1k8
 MMUOB0L9ZRYpAxkmJsKGi/i2/dSuw=
X-Google-Smtp-Source: AGHT+IGEd6J21z2VN2ehqnK6oP7Qz06HjzaKd+QpBgVcktTSfdWo9VttSUvVsnvZ48HEbz5diQZx7oQ6KxEaZdG3jUo=
X-Received: by 2002:a05:6902:18d0:b0:e60:8e25:f0fb with SMTP id
 3f1490d57ef6-e667b3c7ce2mr2552162276.16.1742379499752; Wed, 19 Mar 2025
 03:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250304124815.591749-1-kraxel@redhat.com>
 <20250304124815.591749-15-kraxel@redhat.com>
 <CAFEAcA9_rb321OBOfv9v84ZLO7aw_8t8pTDMUYxj2SNnSBfRmg@mail.gmail.com>
 <wcpg5idrxwq6fntknc4vubnzaeqqqgqbpo5rdiqhumk745hsu5@tofolnd6v4dt>
In-Reply-To: <wcpg5idrxwq6fntknc4vubnzaeqqqgqbpo5rdiqhumk745hsu5@tofolnd6v4dt>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Mar 2025 10:18:08 +0000
X-Gm-Features: AQ5f1JpUf1mnXqZZWg_nCoV1yenUNRYWCpbIRe3JApjYoLdY-gZVJsE_lKV6JmM
Message-ID: <CAFEAcA_MbaZjv9R0YjfHNuAqqMsHBm3-AeqnVp7w8hTHFMpz5w@mail.gmail.com>
Subject: Re: [PULL 14/24] hw/uefi: add var-service-json.c + qapi for NV vars.
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Wed, 19 Mar 2025 at 08:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > Hi; Coverity points out some problems in this code
> > (CID 1593154, 1593157):
>
> I'll send fixes later today.
>
> > Do we absolutely need to be operating on a continuously open
> > filedescriptor here rather than a filename? If we could make
> > these functions use uv->jsonfile each time then we could use
> > the glib functions g_file_get_contents() and
> > g_file_set_contents(), which get all the pesky details of the
> > error handling right for you.
>
> qemu_create() works only once in case libvirt hands us a
> file handle instead of a filename.

If we have to work on a filehandle, we have the problem
that if the host crashes after the ftruncate() and
before the write() of the new data then we just lost
the contents of the var store. Working on filenames
would let us do "write new file and then rename in to
position". If you need to try to operate on a filehandle
in a "don't lose the data for crashes mid-write" that
gets tricky. Do we care ?

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7C3C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 15:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYoRq-00067q-F7; Tue, 30 Jul 2024 11:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYoRp-00066F-3F
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYoRn-0004Dz-LD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722352051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZulzjvliajaJvQY0QOgMdaE6tn7nQLBTBWWFMXD/eY=;
 b=gIgMuaJfggVGceeQFlPp7w851sHa2tQP4JIAk//zwUiPvb5dQLBnbwlLsW9pEq6L+6gPF7
 R2ympbVKMkaOnBYK3GLQ+rnNFLevax5kRqz5R/XP0jSVjZRmAeFxIWSlSql6Uu5yIG7aoM
 +2ZMyRI45D0F+W0yueQDZHOYO1LGsB0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-cNdGd_vEOzCpmnp7Q7RcJw-1; Tue, 30 Jul 2024 11:07:27 -0400
X-MC-Unique: cNdGd_vEOzCpmnp7Q7RcJw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4280291f739so28434485e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 08:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722352046; x=1722956846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KZulzjvliajaJvQY0QOgMdaE6tn7nQLBTBWWFMXD/eY=;
 b=ZrKG/Ej1xgUr/O3LUT6v/nW+k/moHD/RrB538PtSCvgZc1vtM0mnBNPAdPQsHdJrzg
 WYefbJF2SeDN4URj6f69g5HtPcRTWmTAkMokZBlfMhuvGibgLBQHx04yaoBucpqSNFv3
 t0w3VtUnnVCzlKrb+XXn18cGorQUkikei/5siIYSWQfGMqJosVVloZsd1GIIYiKU5k0Z
 RpLOI8DY9j2EreUobdc15nWXrPhg049nUqFeMBlnArwN0r6beITZH9HaqqBx90xnjCuM
 IJhcXoadeDxSNWVVSPkiucWljxiYran7BTVNu8miC3PZVpw8LmsQu58TJ8XeWpCFEcbx
 n4zQ==
X-Gm-Message-State: AOJu0YzI7RWt+3y//dBJ3G6zrq6cKz2xGiCVn9LbjEa6JDWrNQduGsBe
 nOfqvbjgql0G25HHECCYb2uIly+cwPhUdBqlicKM5lkcHIokMZxsZHAdZsDDcRCDxGXkDWS/vOA
 R4zz7QSH9bs160SNLwgQicm1hMucq7DyE/rLRE0gGwszdsvQbFev9EtA3m4CD85QhtNploUw0Fi
 2GCGXvUeaLl4LZ/V6aA6AuRsA6ONk=
X-Received: by 2002:a05:600c:4513:b0:421:7bed:5274 with SMTP id
 5b1f17b1804b1-42811d8c5cbmr79815815e9.10.1722352046429; 
 Tue, 30 Jul 2024 08:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVmEEkETlWvDqx+n62pFbXRAdYZHV0B2UuAIdKw0vgXsgOcxllygCHmYXH9MvvW5jzyswJpp/c6mZH3n2UG14=
X-Received: by 2002:a05:600c:4513:b0:421:7bed:5274 with SMTP id
 5b1f17b1804b1-42811d8c5cbmr79815655e9.10.1722352046010; Tue, 30 Jul 2024
 08:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240729122553.2501133-1-peter.maydell@linaro.org>
 <CABgObfbBQsQjfktUmdECiC8mtrLdVK4R=3=bJTjZhqNh7EXvxw@mail.gmail.com>
 <CAFEAcA_0FuP6Fh52=v9je858VHdgr5uN11Dn71hYFJW=o-OQ4w@mail.gmail.com>
In-Reply-To: <CAFEAcA_0FuP6Fh52=v9je858VHdgr5uN11Dn71hYFJW=o-OQ4w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Jul 2024 17:07:12 +0200
Message-ID: <CABgObfaU5RHAMpybW8DSVcoBr1UQ9a6D3PXr+v5W+5-_F6rvUw@mail.gmail.com>
Subject: Re: [RFC] pythondeps: Split sphinx_rtd_theme into its own group
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

> > The reason why your patch works is weird, and it's apparent when you
> > run the "pip install" commands one by one:
> >
> > =========
> > $ pip install 'sphinx_rtd_theme==2.1.0rc1'
> > Defaulting to user installation because normal site-packages is not writeable
> > Collecting sphinx_rtd_theme==2.1.0rc1
> >   Using cached sphinx_rtd_theme-2.1.0rc1-py2.py3-none-any.whl.metadata (4.4 kB)
> > Collecting sphinx<8,>=5 (from sphinx_rtd_theme==2.1.0rc1)
> >   Downloading sphinx-7.4.7-py3-none-any.whl.metadata (6.1 kB)
> > Requirement already satisfied: docutils<0.21 in
> > /usr/lib/python3.12/site-packages (from sphinx_rtd_theme==2.1.0rc1)
> > (0.20.1)
> > [more "requirement already satisfied" lines...]
> > Downloading sphinx_rtd_theme-2.1.0rc1-py2.py3-none-any.whl (7.7 MB)
> > Downloading sphinx-7.4.7-py3-none-any.whl (3.4 MB)
> > Installing collected packages: sphinx, sphinx_rtd_theme
> >   Attempting uninstall: sphinx
> >     Found existing installation: Sphinx 8.0.0rc1
> >     Uninstalling Sphinx-8.0.0rc1:
> >       Successfully uninstalled Sphinx-8.0.0rc1
> > Successfully installed sphinx-7.4.7 sphinx_rtd_theme-2.1.0rc1
> > =========
> >
> > It doesn't install 8.0.0rc1 at all... :)
>
> Aha. Is it possible to get mkvenv to produce these full
> error messages rather than the truncated version?

Heh, the idea of pythondeps.toml was that they wouldn't be necessary -
hence the messages that are slightly more tailored to the
QEMU-specific issue. It's certainly a good idea to at least place them
in a venv-pip.log file or something like that.

Paolo



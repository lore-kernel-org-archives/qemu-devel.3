Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9134DC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 09:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdS7T-0000W8-UX; Fri, 23 Feb 2024 04:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdS7K-0000OS-U4
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 04:45:22 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdS7J-0001nd-7Q
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 04:45:18 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56454c695e6so1212730a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 01:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708681516; x=1709286316; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtfuCc0DI3uOmH36JZ7TOlj8fPqrFAA3zUxE7rng8Ho=;
 b=MbVz8n6DrnE/7wqXVYdinLeEm+8h/uQEdOqF5NsvAHmZTt5q031Zwlb11EayJXilKH
 0gNZbyvPdvMoPTfSre41zt1BTPLJKgQIBMO9AcRMecMkyHj3hMLOCuYvN80e90qriDgN
 GlLtFAlSRtBPYXbXQ9pPLue/xPenxkNPJP8rQ9eFvjUXZuAiXcs0leGPcokc0empMkQs
 jbAMUIknrOSFfU4KXIl8yGe0HQfW0H2183Vmxq0cpGUK4j3dmH9EgeYJQ1fAHyW4Iz4t
 yVIq9Mo2If+9XJJYJG9I3js6BU61vWMbj6zA74JUf9+84TEwg/WxN6bwAvu9YVLTS0h9
 12hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708681516; x=1709286316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtfuCc0DI3uOmH36JZ7TOlj8fPqrFAA3zUxE7rng8Ho=;
 b=TeocIUsi+07AtktD3Yl1dYqbP1Hf4tkslxGdkpWGXWdXODN6zjqGAtJOMofNopGdNh
 YJ+SdLNFAa1vJg4YzFV61wDnk49LbiNYlpcINC0jOben4LZ2VoQ93r0ECopeJZSMFbTG
 fRd+ceR6G0FrU0ju3gHGesy6SkecdA9gPOCNlr/n0/J26CyvOgSRtITWqibWZKVMcoPM
 hxLfh2MGKT9IFDhHLOvl4TghXCBLvLTPxzD8vhyo6gOWTxsuf0242EAa49kLhxGPkLkC
 4pOAeZECtDWikurMqJmfxqADRbwiubDn9qTG2ZQf+KpNV2hVD7eefh50/MSqwIkzzEon
 C1Fw==
X-Gm-Message-State: AOJu0YyJ18pbVZoR+Qvxoe//qci1bV/otO/mKA4KZO2I33B1KCD9gctw
 LvO8MB+V1qCYzJnCJOHYLNRsDnTGYl0dAC0kE0KIlW2N84cW0nrGz8TQExvfUsljyHcum/gU+Lv
 kGAeKnd5WN1AP+MF+NronqxOxshQ0dolHH3MUlA==
X-Google-Smtp-Source: AGHT+IGsYErOulHiTUIPXzw67Sf/v1WgIhCRzb7WWHt/wyjvsW15WWE/tbqisK+e5SWkqhYpoXWXp1q9zF3ww81PfWw=
X-Received: by 2002:a05:6402:336:b0:561:33dd:621c with SMTP id
 q22-20020a056402033600b0056133dd621cmr1222524edw.7.1708681515913; Fri, 23 Feb
 2024 01:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20240222114038.2348718-1-berrange@redhat.com>
In-Reply-To: <20240222114038.2348718-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 09:45:05 +0000
Message-ID: <CAFEAcA_UhVcayevMZBiwgNgO_1rFaetS5ztNA1Z=h5Q119=Vrw@mail.gmail.com>
Subject: Re: [PATCH] gitlab: force allow use of pip in Cirrus jobs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 22 Feb 2024 at 11:41, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Python is transitioning to a world where you're not allowed to use 'pip
> install' outside of a virutal env by default. The rationale is to stop
> use of pip clashing with distro provided python packages, which creates
> a major headache on distro upgrades.
>
> All our CI environments, however, are 100% disposable so the upgrade
> headaches don't exist. Thus we can undo the python defaults to allow
> pip to work.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitlab-ci.d/cirrus/build.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> FYI lcitool recently added logic that purges the EXTERNALLY-MANAGED
> marker in all the dockerfiles. QEMU will pick that up on the next
> refresh, so Linux containers won't have trouble in future.
>
> The macos/FreeBSD build env isn't fully managed by lcitool though,
> so we need this manual addition to purge the marker that prevents
> use of 'pip'.
>
> This fixes the CI regression that just started hitting on Cirrus
> CI macOS images, likely from homebrew python updates.

I've applied this directly to get the CI back to green; thanks.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6378C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtvY-0006Om-3V; Tue, 25 Feb 2025 07:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tmtvW-0006Ob-JT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:20:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tmtvU-0000Po-4g
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740486037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Exvhnn8n+JhJFSpa6jgzay+CJ7qRhCotkWKCtZjgrE=;
 b=fxMxPetRu3rTQuQVB9tQTzfxvUZpTDN++62tu1HPpR6GhgaNfJuf19saAkxKFS4RjDyLdV
 BQ5f4SM4ByzW9G2L2KXNoEWsBRLcNn860vJvKenmRjEWbuCGYfFUCRv46922NFaDr88Z5e
 +OwFULLAFXHFqw1tNNxT+dr/vGnScNw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-eiEiwvixPIOCh8Hhg4CNHQ-1; Tue, 25 Feb 2025 07:20:34 -0500
X-MC-Unique: eiEiwvixPIOCh8Hhg4CNHQ-1
X-Mimecast-MFC-AGG-ID: eiEiwvixPIOCh8Hhg4CNHQ_1740486033
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f62a0ec3fso3933540f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 04:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740486033; x=1741090833;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Exvhnn8n+JhJFSpa6jgzay+CJ7qRhCotkWKCtZjgrE=;
 b=na5Uuy4llxfoG1weGvz53ksEjTJgnqAryJHBH/gW7a/bRBgqvme9mg9BlLZKknYjli
 ghXeeT2P3oMATeNX2cBuRVz5k6hvD945MNgOkEAjfrxiJSszm02135Vv5JyC/yyA03/4
 V6zI//4nLg+pZLnxGSm/MXwphSFEtYd+6se4OoK0GWrNf68E8Ke/62/ybei58mv0+KCN
 gqjIUQg36SjdGnll9zidsrMcrf0LEgyGRfZa/6zoh2Y5ynvdfU433Ci8rkRBZWg406r1
 OQNGl5Me119J7Vqnyz96A+IneN0AbbBSt1rdDbYwISP0vLW3Cwmh8L21DVN+J16TOm5l
 fDvw==
X-Gm-Message-State: AOJu0YwCF9pV1pGE+rZjuAsdWBAUuk1Szg9KaYD1MpyZs6vACkVsQGQ+
 sGFomrWW7lkWkiXabCftHjNXLOwhXQqQg8iExji3jtcUZQtbFLa50/3eFW567dsPdug/uRSzWkQ
 htYLo98JuotZXaUqxet3K6cztMw3FMXun3KPhioRvSLh2YxjuVQaA
X-Gm-Gg: ASbGncsZIoizvYp7MDEoFo1nZDFbI9fNeAaOi31yNCx/LL+TCjtvQ0mn1OZmhkitWOz
 vIdgT/aRkrjqZVuH0SIAQ/vz3wOK7erHDXADNJ5eVwvzaVTXcsBdZ/ECBKKAaVaZbPqycX5qG5n
 k+RmUIK5HOMBQtC5NZhFxCRtFsECXXISaTPbE8VW0wkBIKBMipuOGJvOQh+jnsSNqXK6Vxauynn
 nFnDXgzWsOSZs6+xjSngYmcO97mu6ZoZyMne9pmyi/qRg00GddHa0icXPWiGp8h5IOUttLg8WDH
X-Received: by 2002:a05:6000:1789:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-38f7079aa1bmr13354342f8f.19.1740486032907; 
 Tue, 25 Feb 2025 04:20:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFumJ8YAeQ8XoumUwDmJhbQCv/IBVVk43zUvyzNmOgQ+REhctMnVzus5V2JhOKzlT3X9clpBA==
X-Received: by 2002:a05:6000:1789:b0:38f:28dc:ec23 with SMTP id
 ffacd0b85a97d-38f7079aa1bmr13354321f8f.19.1740486032577; 
 Tue, 25 Feb 2025 04:20:32 -0800 (PST)
Received: from redhat.com ([2.52.7.97]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8667e0sm2152875f8f.10.2025.02.25.04.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 04:20:31 -0800 (PST)
Date: Tue, 25 Feb 2025 07:20:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] gitlab: use --refetch in check-patch/check-dco jobs
Message-ID: <20250225072011-mutt-send-email-mst@kernel.org>
References: <20250225110525.2209854-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225110525.2209854-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Feb 25, 2025 at 11:05:25AM +0000, Daniel P. Berrangé wrote:
> When gitlab initializes the repo checkout for a CI job, it will have
> done a shallow clone with only partial history. Periodically the objects
> that are omitted cause trouble with the check-patch/check-dco jobs. This
> is exhibited as reporting strange errors being unable to fetch certain
> objects that are known to exist.
> 
> Passing the --refetch flag to 'git fetch' causes it to not assume the
> local checkout has all common objects and thus re-fetch everything that
> is needed. This appears to solve the check-patch/check-dco job failures.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks!

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  .gitlab-ci.d/check-dco.py   | 2 +-
>  .gitlab-ci.d/check-patch.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/check-dco.py b/.gitlab-ci.d/check-dco.py
> index 70dec7d6ee..2fd56683dc 100755
> --- a/.gitlab-ci.d/check-dco.py
> +++ b/.gitlab-ci.d/check-dco.py
> @@ -21,7 +21,7 @@
>  
>  print(f"adding upstream git repo @ {repourl}")
>  subprocess.check_call(["git", "remote", "add", "check-dco", repourl])
> -subprocess.check_call(["git", "fetch", "check-dco", "master"])
> +subprocess.check_call(["git", "fetch", "--refetch", "check-dco", "master"])
>  
>  ancestor = subprocess.check_output(["git", "merge-base",
>                                      "check-dco/master", "HEAD"],
> diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
> index 68c549a146..be13e6f77d 100755
> --- a/.gitlab-ci.d/check-patch.py
> +++ b/.gitlab-ci.d/check-patch.py
> @@ -24,7 +24,7 @@
>  # base for the user's branch. We thus need to figure out a common
>  # ancestor between the user's branch and current git master.
>  subprocess.check_call(["git", "remote", "add", "check-patch", repourl])
> -subprocess.check_call(["git", "fetch", "check-patch", "master"])
> +subprocess.check_call(["git", "fetch", "--refetch", "check-patch", "master"])
>  
>  ancestor = subprocess.check_output(["git", "merge-base",
>                                      "check-patch/master", "HEAD"],
> -- 
> 2.47.1



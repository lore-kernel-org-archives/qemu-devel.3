Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A185C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8So-0007vp-80; Thu, 22 Feb 2024 07:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rd8Sk-0007vZ-H4
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rd8Sg-0003ZS-WD
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708605961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lJ3Uu3rijV0kvUk7vwzc9iApVw6hY2fEiV6yPi3WV4c=;
 b=eoS2L0n3wRl5hWZX6W00MiJa+ZN1cwGPBv+qRlE68FKQ40TyAw2kPGY4TRyL+tTadFshkj
 0U9cHhzKFlhL9SQBTs3MhIyy2H7iJbaseOCBVzAMMFyzMhbfgTlE7p7yEU6rDgs3qfG/tF
 Opv0/y21u5NBHKvwAiyaNl1xJMDnGPA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-94KuVU5CMQyp3NncO2eiQg-1; Thu, 22 Feb 2024 07:46:00 -0500
X-MC-Unique: 94KuVU5CMQyp3NncO2eiQg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3fa99aa548so773566b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708605959; x=1709210759;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lJ3Uu3rijV0kvUk7vwzc9iApVw6hY2fEiV6yPi3WV4c=;
 b=Wc0O03ZgzjQSsKi2+cx/ShydokxLoxCss4Z33z8mApfLtfq1z8y08l59QXJMfSzRpk
 UfZ+67fM/ZWCoRIUG5mM++ctAd50uH4ecYQUiaCwUvqXYFAB50Qa0ycjLtNPEjcZBj4P
 3920gd3GnzY+CLBZ8Ijq/IkHE4IoJW+x9TP8sQVM7wv2xbKR1oQW2kJuXnENPGWyKgdN
 9cet3AE3tdGwx05amMXJZLv2CAaWug+WVHUJt84u40B8roUvH0HvYLq4U7HkBTsuadpB
 j+MxluxcwfekXB4IYw3OfC0B8FLRG7YyZaqlWvSHBaep5kH5dvrpEMhOku7CQxjmfR5z
 1ryQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK0n6o6Eaf6aaVbdUqJfhAxF2AoSdL88jvlm8+8KS1NEVJsVpqVroOu8jgxYzF5pe3zj9naSvhJkvYI16mzZU+Z6S7TIE=
X-Gm-Message-State: AOJu0YxiXFXIWQIfX7BGR3Rv1U7JbOpKDUwQvLVUxz5H+8PD1H7ieQL4
 J7fEvvPSZzxkNKMizsDeSSoN8EAP6tAHzFQZDOnHWSR5u8ZISOY1GTzIruUjGLNJ3aKnMZPqYPm
 pcuhIMTkJ16TxxDWo7mzhio2SDaeC5xa67WvFNRsmij+y8oOlHZuJ
X-Received: by 2002:a17:906:2bc6:b0:a3f:4f15:49d9 with SMTP id
 n6-20020a1709062bc600b00a3f4f1549d9mr2898664ejg.18.1708605959193; 
 Thu, 22 Feb 2024 04:45:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNIykHIptdn0CTBmaV9aSDMeTxxP/+AZRH+xsUX43HHONnQyA+ul5nUO0njnw2TwveJ9HAgw==
X-Received: by 2002:a17:906:2bc6:b0:a3f:4f15:49d9 with SMTP id
 n6-20020a1709062bc600b00a3f4f1549d9mr2898643ejg.18.1708605958859; 
 Thu, 22 Feb 2024 04:45:58 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 pv14-20020a170907208e00b00a3f45b80559sm1444845ejb.139.2024.02.22.04.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 04:45:58 -0800 (PST)
Message-ID: <ce362ea6-b583-4c37-bc13-5a9fc664ce6f@redhat.com>
Date: Thu, 22 Feb 2024 13:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab: force allow use of pip in Cirrus jobs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240222114038.2348718-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240222114038.2348718-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22/02/2024 12.40, Daniel P. Berrangé wrote:
> Python is transitioning to a world where you're not allowed to use 'pip
> install' outside of a virutal env by default. The rationale is to stop
> use of pip clashing with distro provided python packages, which creates
> a major headache on distro upgrades.
> 
> All our CI environments, however, are 100% disposable so the upgrade
> headaches don't exist. Thus we can undo the python defaults to allow
> pip to work.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/cirrus/build.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
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
> 
> diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
> index 29d55c4aa3..43dd52dd19 100644
> --- a/.gitlab-ci.d/cirrus/build.yml
> +++ b/.gitlab-ci.d/cirrus/build.yml
> @@ -21,7 +21,7 @@ build_task:
>     install_script:
>       - @UPDATE_COMMAND@
>       - @INSTALL_COMMAND@ @PKGS@
> -    - if test -n "@PYPI_PKGS@" ; then @PIP3@ install @PYPI_PKGS@ ; fi
> +    - if test -n "@PYPI_PKGS@" ; then PYLIB=$(@PYTHON@ -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; @PIP3@ install @PYPI_PKGS@ ; fi
>     clone_script:
>       - git clone --depth 100 "$CI_REPOSITORY_URL" .
>       - git fetch origin "$CI_COMMIT_REF_NAME"

Thanks, that works for me:

  https://gitlab.com/thuth/qemu/-/jobs/6233183719

Tested-by: Thomas Huth <thuth@redhat.com>



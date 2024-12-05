Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEDFE77171
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 08:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ7hP-0000jJ-Nc; Thu, 05 Dec 2024 03:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJ7hP-0000jA-0B
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJ7hN-0004Wk-E9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 03:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733389139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PbVydDpwg6Y/RR0kBtOA/t+QNCllm4biWnMTK1Sk5WM=;
 b=J0slUVWimtXTrxz0ScUDpJ1sWcKr8+TTl7FKpiEg/kqxunr9YIjUe+vANzWxTH9S6dPj49
 ltKbhsvc9Yi2G6Vitq3baYuEz3nV+V7+0PAKnSaITbckGAfenCfec1aKUqfzpPKTKAwHe/
 035zBRTfdzIoqd1pV00IZ+KPOKA1flo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-g-Cgexo9NSi2w-GELmcDCw-1; Thu, 05 Dec 2024 03:58:57 -0500
X-MC-Unique: g-Cgexo9NSi2w-GELmcDCw-1
X-Mimecast-MFC-AGG-ID: g-Cgexo9NSi2w-GELmcDCw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e0f3873cso425938f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 00:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733389136; x=1733993936;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbVydDpwg6Y/RR0kBtOA/t+QNCllm4biWnMTK1Sk5WM=;
 b=i+2fBnjlIAvFqsCpK5UrfSitNlJjmOkAmadR7TtMN0R2DAlp2+OIIfZfHP5rjU50OX
 1ZEM4BQJ/ID4uis3Bdqo4pNSltTjdhZhOQ8zTBaIB3hDKrjMvH8iTkKXZLSNjcQ1F13a
 Q2y7KQ0BmQRK0aEIizjhzOGajE9eWHWaaNPIzdt3HiZeYmCl+Yy59swdQnHPnAZIpnNU
 UEvxuUI2WE47VdjEvQYbXR9EJaYQ+lk117TfXF/tZJPnGGGEGlb32pNpmCg8GuSmA5JL
 VWu7XxNB24DKs6Pwc2NCqRnSMqP8TrEk7R+FFBSVZ2tP/cyUbag+wnBpwsDGwRgjpRu9
 z1IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDoNmlV/uNuu1+gZegMDlzGwsKmExsTwZw3/8PsM9ybSgu19GBfn2b99IadOgR82Cgjy7AYhgn4uTB@nongnu.org
X-Gm-Message-State: AOJu0YwC7glhVkVzeTlo9RueMkagYaqrr3Tt5ib6+x+wVcobm+qF/XpS
 9E/53SaOMZsZIkDPIcIDMjSqcOYXGowHd+HFPrWEnSZQpiI/tnFgCQt/DFLt6w8z2jXuXZmjRtE
 s1WF/bxtmqkbGB9sBP0ESsv6L92V8MDMTxq5V43brP3+aqp0TB9Ao
X-Gm-Gg: ASbGnct1csSulF80thMhmWIF5q+Wjf4BXbY3onk5fJ4Zq7wRjTbp5DZOHEKcK63TSuN
 uDi3DBhZur5q/UvaRzQotrW4QqKnUYkAKskdyexYLpNJL83Be6bhRfXk7zxC96ZTlTM+wxGzHzV
 NHbB9Z23lJwj1pDcsmPzFBoditjcyfcXhVtWz3qUaRXaCurxOxvCDQPQ8m3VOhELftvX7yQ0Omd
 tlPyLU6nNu8InoQ1HmUKBTKSKVVUXo+l4lHlNPOXWnIeqtfKQlNLaMMzk0QksNMyKtfOQDoymMs
 WR+91Q==
X-Received: by 2002:a5d:5987:0:b0:386:1228:9d33 with SMTP id
 ffacd0b85a97d-38612289d67mr3094600f8f.44.1733389136265; 
 Thu, 05 Dec 2024 00:58:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8/LXxtCgrUlqAJ/zxszhh9zGMl1bbxS3HUpBTiCoRvDnr7R3iXYd3Y5BH4z5Yje8JA7igvw==
X-Received: by 2002:a5d:5987:0:b0:386:1228:9d33 with SMTP id
 ffacd0b85a97d-38612289d67mr3094584f8f.44.1733389135910; 
 Thu, 05 Dec 2024 00:58:55 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-244.web.vodafone.de.
 [109.42.48.244]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da0da4a1sm16615275e9.19.2024.12.05.00.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 00:58:55 -0800 (PST)
Message-ID: <c632357b-bfd0-483d-8f80-6310a0ffee13@redhat.com>
Date: Thu, 5 Dec 2024 09:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] gitlab: clean packages in cirrus tasks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241204194807.1472261-1-berrange@redhat.com>
 <20241204194807.1472261-4-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241204194807.1472261-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 04/12/2024 20.48, Daniel P. Berrangé wrote:
> The FreeBSD VM is somewhat low on disk space after all QEMU build deps
> are installed and a full QEMU build performed. Purging the package
> manager cache is a simple thing that reclaims about 1 GB of space.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/cirrus.yml       | 2 ++
>   .gitlab-ci.d/cirrus/build.yml | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> index 16411f3d2b..2bd3cb35c9 100644
> --- a/.gitlab-ci.d/cirrus.yml
> +++ b/.gitlab-ci.d/cirrus.yml
> @@ -42,6 +42,7 @@ x64-freebsd-14-build:
>       CIRRUS_VM_RAM: 8G
>       UPDATE_COMMAND: pkg update; pkg upgrade -y
>       INSTALL_COMMAND: pkg install -y
> +    CLEAN_COMMAND: pkg clean -y --all
>       CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblaze-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu
>       TEST_TARGETS: check
>   
> @@ -54,6 +55,7 @@ aarch64-macos-build:
>       CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-runner:sonoma
>       UPDATE_COMMAND: brew update
>       INSTALL_COMMAND: brew install
> +    CLEAN_COMMAND: brew cleanup --prune=all

Are we also short on disk space in the macOS jobs? Otherwise, I wonder 
whether we should rather skip the step here to save some seconds of run time?

  Thomas


>       PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
>       PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
>       CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
> diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
> index 41abd0b31a..9983ab0690 100644
> --- a/.gitlab-ci.d/cirrus/build.yml
> +++ b/.gitlab-ci.d/cirrus/build.yml
> @@ -21,6 +21,7 @@ build_task:
>     install_script:
>       - @UPDATE_COMMAND@
>       - @INSTALL_COMMAND@ @PKGS@
> +    - @CLEAN_COMMAND@
>       - if test -n "@PYPI_PKGS@" ; then PYLIB=$(@PYTHON@ -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; @PIP3@ install @PYPI_PKGS@ ; fi
>     clone_script:
>       - git clone --depth 100 "$CI_REPOSITORY_URL" .



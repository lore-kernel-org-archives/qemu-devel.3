Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9324DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 10:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjdGd-0008Qt-Cg; Mon, 11 Mar 2024 06:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjdGa-0008Qh-S1
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjdGZ-0006QH-0u
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710154341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ieJQOyR1PvjQcFlXEfu4jdHG+bxrhJkvdTkgV6smMgo=;
 b=U2p32eQ8V9e6W0585gnfJVGsEj8wK93PiTBl3xrVknwAmuC7GscDXvd1qgCZk89z6mDHP0
 QGDPVNvtF802rvEfNiLEjB2C5IBrF9pY4fHcbfvOoHSUo2b78DFB3Btn2OqFrBXHmetzz9
 Hxv1jQGRgQRXDkROudBxYiEs+bgRLWY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-oqWeru8mNi-tELNhif2LSw-1; Mon, 11 Mar 2024 06:52:20 -0400
X-MC-Unique: oqWeru8mNi-tELNhif2LSw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-41312565bd4so19296355e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 03:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710154339; x=1710759139;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ieJQOyR1PvjQcFlXEfu4jdHG+bxrhJkvdTkgV6smMgo=;
 b=lD0yPnI5gpEnLbnOaO8cL/w4RykFHZa9yrR8vtLpnVDd0SAf5oQPIXA5SkIKGKAyik
 Jh5z7HO8nvpyjK+UHgFhZhNTnsO+3DNU3YVrGixWX9gmgAp3fAlE8cKgN9HXBIAuPllH
 lpf8oFQ6wBhrHBeW0ge+Hlrvm7U68lgejnSeT+LwlYl908PwMUoT+R3okgVNRxuZmMrV
 iiT80Ztot/uwke932N20Ed9m4GxokCFzUu1dlclUNZ67dkTQVln0U/wgNs1FtGRCVBh6
 xgRDgFkCA/qfikR4/nyFOU2BXvVgWxE9rcH8aJoT56KLs1tiiON4KbDlP/R/gGjeXEhU
 fsSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLgLMpGtS1WZ4dOHjADSf2yXtuYFUTo6+xRsZJwQsZCZIxjy8Kg5gKSsWyCai2xw1CFOCAxBOcztbTAy6B4FO4igABso8=
X-Gm-Message-State: AOJu0YxaC1TtZM75CZXNRsGMtCkCAeAq3g1oYjnjXT4Et11A0R88tWml
 NHxoQzd3ggB4kSfD3XyAHUUse5nTvCKLPyVlefCX7wu8n4647yy3/1NA7dGSV+CuvFfWZPwAIP9
 EZFb29IX3h2LNVWqnTm70rnnG/ne0Uj4uu9iNSZ/1K5aCIuPGndYd
X-Received: by 2002:a05:600c:5253:b0:412:ea32:e7b0 with SMTP id
 fc19-20020a05600c525300b00412ea32e7b0mr2128wmb.40.1710154339082; 
 Mon, 11 Mar 2024 03:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuKfrON+N8lLy46p/UuA8sK7l+gCxFodh7QXyGlaIMV5gnfWQ+Vn3vks53HtERE9KJgl6bsA==
X-Received: by 2002:a05:600c:5253:b0:412:ea32:e7b0 with SMTP id
 fc19-20020a05600c525300b00412ea32e7b0mr2117wmb.40.1710154338691; 
 Mon, 11 Mar 2024 03:52:18 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 l18-20020a05600c1d1200b004132f3ace5csm543297wms.37.2024.03.11.03.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 03:52:17 -0700 (PDT)
Message-ID: <600bae74-e8b9-4455-95b0-3166da233c8f@redhat.com>
Date: Mon, 11 Mar 2024 11:52:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] tests/vm: avoid re-building the VM images all the
 time
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240226195003.467135-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240226195003.467135-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 26/02/2024 20.50, Alex Bennée wrote:
> The main problem is that "check-venv" is a .PHONY target will always
> evaluate and trigger a full re-build of the VM images. While its
> tempting to drop it from the dependencies that does introduce a
> breakage on freshly configured builds.
> 
> Fortunately we do have the otherwise redundant --force flag for the
> script which up until now was always on. If we make the usage of
> --force conditional on dependencies other than check-venv triggering
> the update we can avoid the costly rebuild and still run cleanly on a
> fresh checkout.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2118
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/vm/Makefile.include | 2 +-
>   tests/vm/basevm.py        | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index bf12e0fa3c5..ac56824a87d 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -102,7 +102,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>   		$(if $(LOG_CONSOLE),--log-console) \
>   		--source-path $(SRC_PATH) \
>   		--image "$@" \
> -		--force \
> +		$(if $(filter-out check-venv, $?), --force) \
>   		--build-image $@, \
>   		"  VM-IMAGE $*")
>   
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index c0d62c08031..f8fd751eb14 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -646,9 +646,9 @@ def main(vmcls, config=None):
>           vm = vmcls(args, config=config)
>           if args.build_image:
>               if os.path.exists(args.image) and not args.force:
> -                sys.stderr.writelines(["Image file exists: %s\n" % args.image,
> +                sys.stderr.writelines(["Image file exists, skipping build: %s\n" % args.image,
>                                         "Use --force option to overwrite\n"])
> -                return 1
> +                return 0
>               return vm.build_image(args.image)
>           if args.build_qemu:
>               vm.add_source_dir(args.build_qemu)

Reviewed-by: Thomas Huth <thuth@redhat.com>



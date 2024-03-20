Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A386C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrjV-0004j4-4i; Wed, 20 Mar 2024 04:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmrjT-0004ha-KJ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmrjM-0001yl-Ce
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710924917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jT0WMqvhzo7oE0EGNsiQoQcxm6uetUBEz6/cnlj+r9g=;
 b=TaHaqitBehJilpwC5IXPOyc0cCK8IOkN9gEg67bdzFam4AAyRESAjXIUrgRIpSVGZ9RG1M
 Mu+fdONhKpTWyV5z4HSIOaoq4MHlQtIvrXoqTt16vtorapRC8WpKY6WzVP8yfxDJwOgYHK
 YEGEi3eBdPP28yRxEyCK8Q3j4ywdC4U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-kxq1oKYlPhiyQQ2K18D0Vg-1; Wed, 20 Mar 2024 04:55:15 -0400
X-MC-Unique: kxq1oKYlPhiyQQ2K18D0Vg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a46ba1a19fdso231083866b.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 01:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710924913; x=1711529713;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jT0WMqvhzo7oE0EGNsiQoQcxm6uetUBEz6/cnlj+r9g=;
 b=nTuffhbTZa2KmPe2jJKwkSJzdTVTmtlFLYFiTjidX2XullbOoB1xZjYNONKvnUjxcy
 x7QwgRODvSmB+yLvF6XSMTLqHCSAcJbHcZUr8zmNEchMsCyPag5GyCgTGfoDr/rHO6rX
 TNo3VvobcHTXd8RT8i2X7JPUu7DgDYK61kP9VbYblHy/TLxJ3lmw8woR/y6bqcumkdWb
 rCFIJ9laaGYGJFuuB1W8cv47zbUSo2YDGDzRxDz3F1PXKs7hwNjbjYqPLfVM0YSvqcK3
 4wKngl2inyDlNKXR6puXcpA8IzoW9XFqaaYtLcSyXqK/VQn5aUUBr8Idr3HKsg4LTwfm
 fpjg==
X-Gm-Message-State: AOJu0Ywvm2Uh8KvSUq82czvHrJTAFJzEDwYc4bCI0SylsGitUdrTeuuB
 F6UlmZydENc+zhOAjpCCK9JQYEbEe/MxsoyZqlxo6AY7ULP0D4/wd99xmzxvKEdj7yo42T9meVz
 nc9Wuck3x0pvKJbO4qArRzyAktS8z3fwnO3rTk6DI4YWDybIQuHz+
X-Received: by 2002:a17:906:39c9:b0:a46:cea6:a7f1 with SMTP id
 i9-20020a17090639c900b00a46cea6a7f1mr3079992eje.51.1710924912975; 
 Wed, 20 Mar 2024 01:55:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzKct3DfQPqOHFQkj3BBhLlJFsFmhcT2gTNoUKvfTPzk8YuCMrlLh5dppu24SDkCS3e/ehHQ==
X-Received: by 2002:a17:906:39c9:b0:a46:cea6:a7f1 with SMTP id
 i9-20020a17090639c900b00a46cea6a7f1mr3079971eje.51.1710924912618; 
 Wed, 20 Mar 2024 01:55:12 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-50.web.vodafone.de.
 [109.43.177.50]) by smtp.gmail.com with ESMTPSA id
 hz13-20020a1709072ced00b00a46a9cdcfa5sm4710252ejc.162.2024.03.20.01.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 01:55:12 -0700 (PDT)
Message-ID: <a7e38ec4-641f-409b-86d7-ea09d9ac1b18@redhat.com>
Date: Wed, 20 Mar 2024 09:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] configure: add --enable-qpl build option
Content-Language: en-US
To: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com, farosas@suse.de
Cc: qemu-devel@nongnu.org, hao.xiang@bytedance.com,
 bryan.zhang@bytedance.com, nanhai.zou@intel.com
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-4-yuan1.liu@intel.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240319164527.1873891-4-yuan1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 19/03/2024 17.45, Yuan Liu wrote:
> add --enable-qpl and --disable-qpl options to enable and disable
> the QPL compression method for multifd migration.
> 
> the Query Processing Library (QPL) is an open-source library
> that supports data compression and decompression features.
> 
> The QPL compression is based on the deflate compression algorithm
> and use Intel In-Memory Analytics Accelerator(IAA) hardware for
> compression and decompression acceleration.
> 
> Please refer to the following for more information about QPL
> https://intel.github.io/qpl/documentation/introduction_docs/introduction.html
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> ---
>   meson.build                   | 16 ++++++++++++++++
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index b375248a76..bee7dcd53b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1200,6 +1200,20 @@ if not get_option('zstd').auto() or have_block
>                       required: get_option('zstd'),
>                       method: 'pkg-config')
>   endif
> +qpl = not_found
> +if not get_option('qpl').auto()

Do you really only want to enable this if the user explicitly specified 
"--enable-qpl" ? Otherwise, I think this should be:

  if not get_option('qpl').auto() or have_system

?

  Thomas




> +  libqpl = cc.find_library('qpl', required: false)
> +  if not libqpl.found()
> +    error('libqpl not found, please install it from ' +
> +    'https://intel.github.io/qpl/documentation/get_started_docs/installation.html')
> +  endif
> +  libaccel = dependency('libaccel-config', version: '>=4.0.0',
> +                        required: true,
> +                        method: 'pkg-config')
> +  qpl = declare_dependency(dependencies: [libqpl, libaccel,
> +        cc.find_library('dl', required: get_option('qpl'))],
> +        link_args: ['-lstdc++'])
> +endif
>   virgl = not_found



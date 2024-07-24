Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E28EC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 06:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWVBF-0008H2-5d; Wed, 24 Jul 2024 02:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWVB9-00087n-Rw
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWVB6-0005H0-Av
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721801322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FfmaqmkTiNZ6Hrx7YQ+IG99gX7JtwLxhs1UlQizmayc=;
 b=MuWKiCfSWuCrnV4e0f4mpEWIqnTdFACq4lsbN4utDqDjLe3vUza1axp3r9AhBRXWhTvBCC
 GM8Wig1gEBAyi9cj5hmnohYxksUv9yilQDQVKJqhncDxyi+qPM+pK8XMFPnqjXOoAaPexn
 U7bQuiQcUJ9YFSGfE6APvwsJUPqVLi4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-SOY6GnEWO92za3zWmtcSDA-1; Wed, 24 Jul 2024 02:08:38 -0400
X-MC-Unique: SOY6GnEWO92za3zWmtcSDA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a2c84a3bbaso5400404a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 23:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721801317; x=1722406117;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FfmaqmkTiNZ6Hrx7YQ+IG99gX7JtwLxhs1UlQizmayc=;
 b=jnM62od+azNsZhIshIX7sYHFIb3Zy/sU4+xxWuMvDr8hAg6itO8QZQn0x47p6l4b2h
 Vqu/tpb9rK5pWNeCkPFBiszYT+SwgavLzK4c6rohqOsCebUAsSAyjrCLApdlXXXFcUvK
 MPL1zT2xL3SCqg13xzfMsiswiJCVVfCCiL8Z2gJKlwcNQgCgQ9bWVIoL0Cgpl/oUbpEe
 Tqwgzwa/JTV5Yxu2pSN2IYRE5j3VBLTURw0wccx8/dsb4Ur66XkFgqNvIs4QalTJquBw
 Oea0lIsH5PdJV7b8bYz4Bqcpk7WT6jwqv3GwUZ7Ba/W919/FesgfvzA7QZFKOGAPlcDk
 Virg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPSUBjenWoB5U8bMJXwOFDC790vqQGw6o25TdcY0rYufyl51XbffDSyLedYvw8O2U5osx7nNCn9T8OQEQJ1nGP0e82EGg=
X-Gm-Message-State: AOJu0YxNdTqXgas2QDy8w+a2EHPupD8PXM865XWMNljnWn2Kmt3rJhH4
 6i78NdqVQ6NQAJo8lw+JVFscerzGxdncWv67Qgq1QTkaKGhcQkQORfiAQsLBnYxrEjEo8NBeZiT
 6nFZfY+DAnztfy6v+CRjPPx/o+aVYnPea/PaACVvuJU+rvJjOPTV7
X-Received: by 2002:a50:cc97:0:b0:58e:e2a:1b58 with SMTP id
 4fb4d7f45d1cf-5aaec175316mr696777a12.2.1721801317171; 
 Tue, 23 Jul 2024 23:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKlsSyoHNQANcgMUxEgz4ACu9l0kgUL+nkZprtvSNcULhkbYK0//Du7bf6ZYekVi+VdeyK9g==
X-Received: by 2002:a50:cc97:0:b0:58e:e2a:1b58 with SMTP id
 4fb4d7f45d1cf-5aaec175316mr696762a12.2.1721801316750; 
 Tue, 23 Jul 2024 23:08:36 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-36.web.vodafone.de.
 [109.43.178.36]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30af84673sm8596355a12.50.2024.07.23.23.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 23:08:36 -0700 (PDT)
Message-ID: <76357626-9714-49f7-9ca5-d2a42cd56ab6@redhat.com>
Date: Wed, 24 Jul 2024 08:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Use -fno-sanitize=function in the clang-user
 job
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, alex.bennee@linaro.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240723232543.18093-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240723232543.18093-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/07/2024 01.25, Richard Henderson wrote:
> With -fsanitize=undefined, which implies -fsanitize=function,
> clang will add a "type signature" before functions.
> It accesses funcptr-8 and funcptr-4 to do so.
> 
> The generated TCG prologue is directly on a page boundary,
> so these accesses segfault.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

What happend to Akihiko Odaki's more generic patch:

 
https://lore.kernel.org/qemu-devel/20240714-function-v1-1-cc2acb4171ba@daynix.com/

?

Paolo, you mentioned that you'd queue it, did this patch fell through the 
cracks?

> Does anyone know why we're using --extra-cflags for the clang-user
> and clang-system jobs, as opposed to --enable-sanitizers?

I don't remember, but it was likely the -fno-sanitize-recover=undefined I guess.

>  It
> certainly seems like regular users who use the normal configure
> flag are going to run into this as well.

Yes, we should merge Akihiko Odaki's patch for this reason.

  Thomas





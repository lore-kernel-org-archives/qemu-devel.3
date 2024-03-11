Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F03AC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjdvE-0007E4-Tw; Mon, 11 Mar 2024 07:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjdvB-0007DK-RR
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjdvA-0008Hn-AF
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710156859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=K+bdi9hJxOcf9pQU7ESn1m8NsFhPiSlqAjfEoajhX8s=;
 b=Fum+M7M692b6nbEt1mi1BvmEZR59DdyDKAaWI0EZ2HzNJX6ylE8ofy+TDLLZeHVWZ6btCF
 vYF2twUxS6EcdK0QDmALI5zq7TmzOm34R6KxMJpVPJ9Qx1BTTB9ARABksnBkN4VRfAcIHD
 9x+mYy1oj2s9mqp2Meb9Z3gst7YIUSk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-lplnB3u6PcySeh3ZLRv_iw-1; Mon, 11 Mar 2024 07:34:17 -0400
X-MC-Unique: lplnB3u6PcySeh3ZLRv_iw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42f07cd400cso45066391cf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 04:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710156857; x=1710761657;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K+bdi9hJxOcf9pQU7ESn1m8NsFhPiSlqAjfEoajhX8s=;
 b=pj1dpeKlR/S50McgD0yU3gFNPLe+3Y0y97vwclUkR/JCKZdTADZoacmg0Qx94X07e6
 FnydtpX4IM8J9mDzpiyw0kuiAorynBBOoaf0rPM2xprPI/nPKXTtGXByjybFUp2nggeq
 gYWh1ysuAU1Zk65bvo0OeqwdwnOiI9ZIVUT3caHjplsw2TyQsOVtqMr2Lriqb96OBKmD
 Y6By0riceIi5Z/38aoG3rWMr2k7Usb4jCZL007WBK7ZO1QvBN8eAQdokFfYD28Q5lUjc
 mJbGJttpMw2m6P7oUqd5pvXvryu01PyQ/Do2kDg/03+AczfUwJczstP4Dj2JMiiecBj7
 Cx4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy+P9PhZLvwwzt4Pn8VVcEVjWNp6lK7Netv6FEwTjM1KNhxwVq8+F514Q0tgIucV/14NNKzj/mEbubchRXhHfnRlhkZkU=
X-Gm-Message-State: AOJu0Yzb82OBwfmf54dIbQt+nb2HeynFHzxVSijmV5nUfLegiuv1++S9
 YJcYCNCzHi6FmbZjCj3SO1DeU/gy/9bJGyO/h9NgdhIT2Rd3lbEPzbYYITi1Ir/XbzGQ7qDU8Zr
 Of1g9cNBY21CL2/vNR8t0TLxR6NKeyaVJr/1KiEoSIvqow6lAW/TQ
X-Received: by 2002:a05:622a:1496:b0:42e:ce6d:bef1 with SMTP id
 t22-20020a05622a149600b0042ece6dbef1mr8236069qtx.13.1710156857394; 
 Mon, 11 Mar 2024 04:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEyEbv9nth01P6rVhehalB0Swc8X2fehK+qqdeRy33hCjWQZwOcZVrrDURNFfo8FBV761gXw==
X-Received: by 2002:a05:622a:1496:b0:42e:ce6d:bef1 with SMTP id
 t22-20020a05622a149600b0042ece6dbef1mr8236049qtx.13.1710156857096; 
 Mon, 11 Mar 2024 04:34:17 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 g20-20020ac85814000000b0042f3830ef2csm2410785qtg.33.2024.03.11.04.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 04:34:16 -0700 (PDT)
Message-ID: <51d46af0-d58b-474c-99a4-c231318beeef@redhat.com>
Date: Mon, 11 Mar 2024 12:34:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] gitlab: aggressively avoid extra GIT data
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20240308150748.894699-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240308150748.894699-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 08/03/2024 16.07, Alex Bennée wrote:
> This avoids fetching blobs and tree references for branches we are not
> going to worry about. Also skip tag references which are similarly not
> useful and keep the default --prune. This keeps the .git data to
> around 100M rather than the ~400M even a shallow clone takes.
> 
> So we can check the savings we also run a quick du while setting up
> the build.
> 
> We also have to have special settings of GIT_FETCH_EXTRA_FLAGS for the
> Windows build (git too old?) and the migration legacy test where we
> build an older QEMU alongside the main one.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/base.yml               | 4 ++++
>   .gitlab-ci.d/buildtest-template.yml | 1 +
>   .gitlab-ci.d/buildtest.yml          | 2 ++
>   .gitlab-ci.d/windows.yml            | 2 ++
>   4 files changed, 9 insertions(+)
> 
> diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> index ef173a34e6..7cb800fc3b 100644
> --- a/.gitlab-ci.d/base.yml
> +++ b/.gitlab-ci.d/base.yml
> @@ -24,6 +24,10 @@ variables:
>       # Each script line from will be in a collapsible section in the job output
>       # and show the duration of each line.
>       FF_SCRIPT_SECTIONS: 1
> +    # The project has a fairly fat GIT repo so we try and avoid bringing in things
> +    # we don't need. The --filter options avoid blobs and tree references we aren't going to use
> +    # and we also avoid fetching tags.
> +    GIT_FETCH_EXTRA_FLAGS: --filter=blob:none --filter=tree:0 --no-tags --prune

The original settings included --quiet according to the docs:

 
https://docs.gitlab.com/ee/ci/runners/configure_runners.html#git-fetch-extra-flags

Should we include --quite here, too?

  Thomas




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672BCC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBiB-00037K-8R; Wed, 28 May 2025 04:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKBi9-00036v-Hl
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKBi8-0003A6-0K
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748419223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iUiUwbq6ZxK2de1LJG+3LmO5+yFZGwcD4FXl1GJA/vE=;
 b=AOC5++ObntO4RYKejo4xKWxcC5Od4sj56UUnN4nZp3X/ubbVH2xKmYhUflNqrnQnBWLO1l
 WNyckZ/QM3L6Pa8a1KsfZ7/1Ju+h84I7TDpQjGyzqA0WhPuudJMFMyTKkCkv3vP6vYb+EW
 j85sHEx40IJc++o3A9vppPVfOQ9dNEo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-8md6HNHrN4-IxVhyaYjiTw-1; Wed, 28 May 2025 04:00:21 -0400
X-MC-Unique: 8md6HNHrN4-IxVhyaYjiTw-1
X-Mimecast-MFC-AGG-ID: 8md6HNHrN4-IxVhyaYjiTw_1748419220
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-601ed3871a1so641392a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748419220; x=1749024020;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iUiUwbq6ZxK2de1LJG+3LmO5+yFZGwcD4FXl1GJA/vE=;
 b=FC/Hy4SVKnDS2zLEY03//cuV9qNDM60vYYM81YPqjRbxUPYyjnpeUXEykZxmEGpch/
 XhNBBLoUaJ8C3b1rn93Q0c8wo2elJTngsgJVoQpAJC5c3IXbzboP+uicZ/QeQ3o7NV1u
 ziQHFbLhcmZ9BSyZ4KS8J3kiYQZGYYxI91GTh3fK6GNJjn0Hn8oUHwGKMnyYf3EVo3VL
 RiQujNb5I5p9Ar+dpagn5KHFbJ/70XjDFC0bcqliDx9p9JQGKW32fIl7LD5atCklZNH5
 A1R82enCZ5fULpzbxRZ9ylYs4IU/BjCCfhs3CkfjLlr1BBtv3poMcgI5BEbo9p5Fr2Zo
 dgmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMPNWFamqBKebPs1HqzqggQWnD750dKF/aCRTcG9N+Pu9mnXRMbTqxYnrEFauL374PhRAP36D7LXBi@nongnu.org
X-Gm-Message-State: AOJu0YxGBmfd0bAN1ZjsgWbeNHT9OOXfko/OehvbMElHMG0GTXwQmkEk
 ONVPVe4M5CDS7RhyL7rONyT1krfI0CmREYM0KI0hFlamzhgplBjDc+PcQMlCjudsVvDJT0bUQVm
 ANC5thic0ts5eJXQyhV1DtpQWog5pqdQm1V9ke16oItWhDW2NhtaB2xeM
X-Gm-Gg: ASbGnctDh+hT2HZe8NkhkpYPtQC6ALIli4jJ0CzrNMNpoPnzZjRXvqCHBHPWSBNnU64
 tdWcx9ewU8AD63T5Pn/lFqxKQEi4LwjFTj3QfLxG4/f6klIG5V74VyibpL9CQNrYVWpTW1bXzMU
 nNeN2P3OW8l/jrKVjUWtghi2K/6Q4L/lbgb1qOWaMMhh3LNP4oucuXwLneeoXM/vO+a1i33ft0q
 qovXQ+RGhE9+vnQP4JA63y1xcC1CA8nsT9aN7DZgqEr1rMIQMA40G1ID0ZI0mVXo6W1XVfN20yH
 GdRIM42zJNukklb8FpoEp+G838Ko7IL1h1oTvMFLVR4+vFKed2Ej
X-Received: by 2002:a05:6402:2707:b0:601:a921:baa with SMTP id
 4fb4d7f45d1cf-6050e57a484mr2834333a12.11.1748419220250; 
 Wed, 28 May 2025 01:00:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtta7IfaKGH4wklHmBMN5v96cMFDcHOK5QYTZHHt3XWM34lYlY5aYOUDEuZBzhnd61Z+VWig==
X-Received: by 2002:a05:6402:2707:b0:601:a921:baa with SMTP id
 4fb4d7f45d1cf-6050e57a484mr2834305a12.11.1748419219845; 
 Wed, 28 May 2025 01:00:19 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-237.pools.arcor-ip.net.
 [47.64.112.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6051d7a0013sm414152a12.80.2025.05.28.01.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 01:00:19 -0700 (PDT)
Message-ID: <6fe9e4f1-9a91-474f-b398-91abd2cbdf51@redhat.com>
Date: Wed, 28 May 2025 10:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-10.0.2] Revert "Drop support for Python 3.8"
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <qemu-stable-10.0.2-20250528105127@cover.tls.msk.ru>
 <20250528075408.34066-1-mjt@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250528075408.34066-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/05/2025 09.53, Michael Tokarev wrote:
> This reverts commit 3d5b2f81fbc6b96b70271af1820674731a441ff7.
> 
> It should not be in 10.0.x branch, since we do support python 3.8
> in 10.0.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
...
> diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
> index 59e70a0248..8f0af9ef25 100644
> --- a/tests/docker/dockerfiles/python.docker
> +++ b/tests/docker/dockerfiles/python.docker
> @@ -15,6 +15,7 @@ ENV PACKAGES \
>       python3.11 \
>       python3.12 \
>       python3.13 \
> +    python3.8 \
>       python3.9
>   
>   RUN dnf install -y $PACKAGES

Reviewed-by: Thomas Huth <thuth@redhat.com>

... but you might want to add another patch instead that pins the 
python.docker to Fedora 41, otherwise the job will fail.



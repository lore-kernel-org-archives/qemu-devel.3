Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9705BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBu-0007fU-JS; Sat, 30 Aug 2025 11:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uruqP-00020N-IX
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:52:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uruqM-0002QT-Tm
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756457540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/uzEyrp8K0TacJb3YSFM+4SzIIYw46pc5V7foBNNsV0=;
 b=gO/bT84XKf3Aulos4m8Tb947fFF3A0M8rxhe1ITNXXwJBIhdDJJqC7nIM6wXrmZkEJlwOU
 Jt7bzvI4vrLm/VltzhbyTjbSXJfyqQsnwC4aexXV1xy1HhdWKUbyyUM7/ew/zqEhCnO1kL
 KcvHSdi9OR7RX542Teu1XLMmB6/BqY4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-C-To_Qs3PZ6S9HhZBAr6NA-1; Fri, 29 Aug 2025 04:52:16 -0400
X-MC-Unique: C-To_Qs3PZ6S9HhZBAr6NA-1
X-Mimecast-MFC-AGG-ID: C-To_Qs3PZ6S9HhZBAr6NA_1756457536
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b05b15eso11896095e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756457535; x=1757062335;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/uzEyrp8K0TacJb3YSFM+4SzIIYw46pc5V7foBNNsV0=;
 b=XeTEBWYq+2CjU6idjbEeCU/Wpoj8Jb8+EyTahr1dAZUiIcdNZvIbbhNpHw7Vd0+YEn
 Gc3Bn3WrliHLNY39erywBx4xaeUhD+f5nrCz7lkQfblQJmKogm2iVE6t2SZdZBaCMFaA
 9ETPTNwy2RCbYlbq1/l68kC/mUuQ9oAHBuO/hO4cCBRKPyfn10zSuSFhiqGUpRG+wldM
 1/QhtoI8Al+q+Xi773e7l5UUCDsmAs6jeGJ+PVfo1xhJvdQrQRdjDZHdBic82VUsn5bT
 tr4QHsIqRW4Bs1OJEXrJRUDw+tlwYvwhwUa17RJcQhORSsLX44J2K84nZgnogNwV6erB
 cAug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4R+UagYhBNt7WjPYWFzBOcImtmZ+xYPOzw+23AKt3es9Fx12wxXoRGQT1F+EdoLD2JriIUmfL27mu@nongnu.org
X-Gm-Message-State: AOJu0YzK34kre7sxo5EFbqxlgeJZeb74/gCCm508q0yilQdEPQTqQVIb
 Vj6byjAFNKB9qQUaig1JTolLpOCChRMxGT7Mo34gLnXaHb4RKgGVk/pESV0N5QpCf154V1bFlez
 9jv/eRQWUTG92AEsTA+TNHDdEpVewmvBuBwkHUja+Q8wgxU+JYJ6w0jRr
X-Gm-Gg: ASbGncvowMIxdsG4aSSMjNaPqyz/tNuCtaE1xsfZ23EjvvhqScJ3v1UeoO9MFjoDJvu
 wu77vUuhPSCSvBxvbTqZzNOq9OCxFnOl6qPUOf1Dpg/iTlL7qZuAlYeGj1cgwRH9hIIIw49bWh0
 MwN1+NNADeLODOg348lN22ZV5yKKDtmqTnCfOzh5O+mauCK7kJsdAkgYpRxTxxeDw9XKHVtb7wx
 Bh9IC5bJi/Hfv6Ei3Ok8F+YLxxIXsmCXeRqX5Mhs4RA6TcWL7ktKjHMfB378x29W010MfGHCV7z
 7Qx16GgtonnKKWvGX6TbiaBcGW9/YNpPkCjhwh3FmpYrupLrzvDVqRZNHUwuIT+H4ZWN
X-Received: by 2002:a05:600c:1c25:b0:45b:7608:3ca1 with SMTP id
 5b1f17b1804b1-45b76212044mr55310775e9.23.1756457535682; 
 Fri, 29 Aug 2025 01:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGErU3Hfwc/cDsPvrsH+zyxQbz/d3of1/vz/qZVy9QNTKbn9DUOji1PZFFvBXiDVn38l4aTOg==
X-Received: by 2002:a05:600c:1c25:b0:45b:7608:3ca1 with SMTP id
 5b1f17b1804b1-45b76212044mr55310565e9.23.1756457535271; 
 Fri, 29 Aug 2025 01:52:15 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-48-43.web.vodafone.de. [109.42.48.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276ccc13sm2482515f8f.22.2025.08.29.01.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 01:52:14 -0700 (PDT)
Message-ID: <d0195bfe-2a17-4020-8176-8f2219f1951b@redhat.com>
Date: Fri, 29 Aug 2025 10:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/functional: fix formatting of exception args
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250829083156.2570137-1-berrange@redhat.com>
 <20250829083156.2570137-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250829083156.2570137-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/08/2025 10.31, Daniel P. Berrangé wrote:
> On HTTP 404 errors, we failed to include the URL in the exception
> that was raised, while for the catch-all exception we failed to
> include the URL and forgot the placeholder for the exception
> details too.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index b5a6136d36..ae2bec3ea5 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -168,12 +168,13 @@ def fetch(self):
>                   # indicate a broken test rather than a transient
>                   # server or networking problem
>                   if e.code == 404:
> -                    raise AssetError(self, "Unable to download: "
> -                                     "HTTP error %d" % e.code)
> +                    raise AssetError(self, "Unable to download %s: "
> +                                     "HTTP error %d" % (self.url, e.code))
>                   continue
>               except Exception as e:
>                   tmp_cache_file.unlink()
> -                raise AssetError(self, "Unable to download: " % e)
> +                raise AssetError(self, "Unable to download %s: %s" % (
> +                    self.url, e))
>   
>           if not os.path.exists(tmp_cache_file):
>               raise AssetError(self, "Download retries exceeded", transient=True)

Reviewed-by: Thomas Huth <thuth@redhat.com>



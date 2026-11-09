Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35CE606AADF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eyrBU3Rz;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rXhLmSCM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSPO-0007ZD-AZ; Mon, 09 Nov 2026 11:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xQSPN-0007XX-7U
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xQSPL-0008Vc-Cs
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/WnN2DUPfHITkpf6bJjNf2Zh6bLVZmTm2LqB7feul8I=;
 b=eyrBU3Rz9c5/XclxNOA6d5X5QRQC3PY3F4gYQWcYr/pKqwh83aviFB9JOEetXBSQlV7Jdt
 ZouwCrAw+ZSZP1+ioeZN88Q9BNnk70UVgdjS46GaMEyyD4dhRNyHLGS7W8l9rob4j/vFBG
 Jp/WSJ2z9MhQYEw6Lm/PX85Y0IP9ZnE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-oj6GbTaFPtm74fNDcOivXg-1; Mon, 09 Nov 2026 11:39:43 -0500
X-MC-Unique: oj6GbTaFPtm74fNDcOivXg-1
X-Mimecast-MFC-AGG-ID: oj6GbTaFPtm74fNDcOivXg_1794242383
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a20e41008cso7384785e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 08:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794242382; x=1794847182; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/WnN2DUPfHITkpf6bJjNf2Zh6bLVZmTm2LqB7feul8I=;
 b=rXhLmSCMOR8++o+E0S20nb6hBOQ7DNLdGbnsO/puFZw2NAzyksqoL2zg0f9VlYei1s
 +sXz25ewfgJZamDfha8nohcsnMX4XrBbGOK61jmJGfgCJ1/zmsW6/suDsFpWm3IrQM65
 TsV24aXSzcSxgHxUxiXmMilNRTWzlMmiJGs79Y6t18qD5gmtoICFU5l9SAiEOqEuOP0e
 W3xlarS/LtX2e1xKyr0o4jVfBpYe43EJox1v5eFoHZM6kLDuZt2+kxDYEFEpvRx8ERoa
 IcI1/lj55s3XWeC7utZsX/vxUfCIUmQR2DaQ6ynM/F/9SubHFr/sugoYqld6URXDajbB
 forg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794242382; x=1794847182;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/WnN2DUPfHITkpf6bJjNf2Zh6bLVZmTm2LqB7feul8I=;
 b=wKHb6n1y74ej88IBavQm1EudClLh2oQ2GOnIoBGE8ZlF5yg6xPrx9x2kl7z6f/UaBk
 c0dLywxFc2cXjCu9OaeHCQ+1nQTap4zpmkAweExblrUK/oTFpnT24zrl6b6lMZ5xOYaX
 BrSJlk0ZTtOcI4gNADI/SnKG7qzO9CAWL+edRFu3P43OEmRl4G1KPWR8VUB4jFKHIyVc
 9+X2CqB1Nk/CoPJ7vTpqJor+XGTDr2+FCWGIGO5pxCG1oCY8r+sATFGQ7+evYRScBzYh
 xgmUFBzeZ+9huFvvFSjLKRJbaak79fbAo5/YgbEyYYLvxwV99lKgYV74y6390AWxXZZb
 lUfg==
X-Forwarded-Encrypted: i=1;
 AL+hErFbUxwZj/m+NoPvGHlKs20fvDKW2+omV3JntMfEffToQljv16c8U/1cGy2tNirfA4alGqoN0W3PmnbK@nongnu.org
X-Gm-Message-State: APuU4Z/2UfqnW5ssFklldd6VjX35Yjq8t0R6QttmvQ9xp966RcbSbfD/
 ky2BZqXFYtFSI3iXt3pr/Rc7bXQ89hOI8AbDU1PjaCTjgUsuvhfRKpLC65dTPO2FvEJniMNrzkl
 0wdP7Kx+4NO2rTpwXZmuQ1dPYID4SmlubS4HKHTiccdd2k0xW3togZU90
X-Gm-Gg: AYBFou1BbL5qiK57xFTTjX3vpiuVx+Ji7+TlwUnnFkp+WwoEbpCVdEWRuq4mdH/Ppsx
 kuNR9FgMS6FGF5Xq7E0qLg0yvwlTLRKny9/ErgxMa6xLAMc602nl5v4P4CTuCRAHH9mh3H06SX+
 oY1blCduBmFG6pm7tCQMiYtkGoxAWjKgdcRE0zla2YoyDzo82sPgj5u1SxqBRQJbYAzKTRBM59n
 XOqMTGMS3UUw0x37SUW8RaLFjwt2i2IQY6ei6oLdZzXaDDcCPYeAPgsTG/EjpBR73+Sl3ur9n1q
 ivDjVmJfe47JSvRjoOfnS5REsZSqPYmWTaFAnXgyVUVoluf77Q43eg5Ot+ZzSsrXihrExUcQ56W
 KCbEWblomgYr5vWvikpwisiRPU0s+Y9fZTsQqdNR/glk=
X-Received: by 2002:a05:600c:4e87:b0:4a1:fe55:88ef with SMTP id
 5b1f17b1804b1-4b963c8dad3mr82753555e9.20.1794242382668; 
 Mon, 09 Nov 2026 08:39:42 -0800 (PST)
X-Received: by 2002:a05:600c:4e87:b0:4a1:fe55:88ef with SMTP id
 5b1f17b1804b1-4b963c8dad3mr82753065e9.20.1794242382286; 
 Mon, 09 Nov 2026 08:39:42 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.75]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e32ad610sm568551415e9.3.2026.11.09.08.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 08:39:39 -0800 (PST)
Message-ID: <83f64026-b00c-4764-abf3-17fb7d259c9a@redhat.com>
Date: Mon, 9 Nov 2026 17:39:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Allow Asset() to work with non-HTTP URLs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20261109161443.724122-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261109161443.724122-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 09.11.26 um 17:14 schrieb Peter Maydell:
> The Asset() implementation only works with HTTP URLs because it
> assumes that the object it gets back from urllib.request.urlopen()
> has a getheader() method.  This is only true for the HTTPResponse
> object that HTTP URLs produce, not for the urllib.request.addinfourl
> object that file, data and FTP URLs produce.
> 
> File URLs are obviously not useful for public QEMU tests, but they
> can be helpful for iterating locally on the asset to be used by a
> test before putting the final asset image up somewhere public.
> 
> Get the Content-Length header with resp.headers.get(), which works on
> both object types, and matches how the urllib documentation suggests
> getting headers.
> 
> Fixes: 7524e1b33679dc13 ("tests/functional/asset: Verify downloaded size")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/qemu_test/asset.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index 0abd89e0a38..780b995b703 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -139,7 +139,7 @@ def _try_to_fetch(self, tmp_cache_file):
>                   with tmp_cache_file.open("xb") as dst:
>                       with urllib.request.urlopen(self.url) as resp:
>                           copyfileobj(resp, dst)
> -                        length_hdr = resp.getheader("Content-Length")
> +                        length_hdr = resp.headers.get("Content-Length")
>   
>                   # Verify downloaded file size against length metadata, if
>                   # available.

Reviewed-by: Thomas Huth <thuth@redhat.com>



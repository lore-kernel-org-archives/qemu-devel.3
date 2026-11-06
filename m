Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39D606D80C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S/rfBFbh;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ehtzbu8y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIVV-0007wA-LL; Fri, 06 Nov 2026 06:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIVI-0007v8-7o
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:53:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIVF-0003q3-HX
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793965984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jMfKGNZpmF05jF3tvaPQH8aRSow/ou3OFsHhPpxpTfU=;
 b=S/rfBFbhF4Bl8L+K3PEck8X8zqE86pg6qXmuJzmc1f9S0IpBdpNKTBsHk/2Y9kL2kiQH+Z
 4l/zos9zopCBcBNTJsFOonix3LDvy5FHxRtr+/YJXKWpswvNMchSGC5goDoyZwcD4bgjxU
 VvV0o9Dv7dTYYb7tJoKhtwFfG+CeUXo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-ncJjfzcMOaSMVQQoshOgrw-1; Fri, 06 Nov 2026 06:53:02 -0500
X-MC-Unique: ncJjfzcMOaSMVQQoshOgrw-1
X-Mimecast-MFC-AGG-ID: ncJjfzcMOaSMVQQoshOgrw_1793965982
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4b64722b5e6so6083845e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 03:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793965981; x=1794570781; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jMfKGNZpmF05jF3tvaPQH8aRSow/ou3OFsHhPpxpTfU=;
 b=Ehtzbu8yYHYLXMxavS/BePiCw6WlHxQuqStZZcf+vffoey1Mx57v8PqZvXMhueNKlT
 kI3gT5D19vvYBCZyE2k1FoibzwseLaQi8oNB712btKh0l0PyN7Pe31ylcnjFGbnnMFHv
 Hdn6qbNzC7oYEevuNcqTo9PGWg9bJsuelfN+AEEg04zP3z0vmZMIDhhj4R9I06cp/TqN
 AotHhqWAQqAFhvP6D7tzVhHTacSkaJQWCEE/Pkov2XHegMnt6rqkwfeyXeiEjKxn4v05
 a+XJEHxXYKMP8m6z1HpY3wlwRDx5lST4fobxVxN3gtFFbi5iUiSLgKD8EWPAXiVqpjje
 O71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793965981; x=1794570781;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jMfKGNZpmF05jF3tvaPQH8aRSow/ou3OFsHhPpxpTfU=;
 b=T94WUFGo6sY5dpUbYWq+U7nDv8WSrrTeJDpRPzKGFs+2uBxxjh7/+8+WUQdainC652
 buZSd0yTlR/L5hUuPKsZ5UduHbtuWZaYHJhLGPGcBLB7YY+yDTcXrnI7HPNechYRKDsd
 MHAnhe1b1UxyetfT6KvTusoRGUfcVv6T8PR8AxVgqqU+ttki3zTdOKPNyGQ4bt17YZu6
 GeHGYKPXRZ7h/hq7CNXWuIuwJmfgCYHhzf7k2S2J04hpvMRnUO92CbkvoUfOPY5byCDZ
 dmcCuJCy37qlyqLfbNcYGnUSmURiTxxqkzWD6T246NAOE2chfq4pf6bhVN23y8Xv8C33
 JsGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRJ07cnrzS7GDTEjYbiYzYnZeUfhoFccSXv2RVSrKjwPaeLtFGpfjAS0YrqQzYPVSs5dcDuchqEzmN@nongnu.org
X-Gm-Message-State: APuU4Z+9UJmD+FTaF/krTcihjChx6ydcfgNCatwYEljD+iq74CuHsCkQ
 iAqPE5NoaSqDEFwO5Liv+jWGEVGsAraNF1eFdfDreApfR7/0BhF5Ie6vVKQTs6DenFeKKjQoClp
 sMpacZXsULLb/SzhP7eaPe6u4xGocsCo9o/q/y7Hh6espc+vGRnIip/tw
X-Gm-Gg: AYBFou37mzfsN2gdY5zVYPCWz1fYu3tLGQ4otBrpayrC83ibAgp+X0xkk4lfIgdpXCA
 sTPcVMlGxyI7pm3yPLOp/E0gVCkcKSwEeyqYXyONqtXAjeUBTBZfvFD6yxxUmCxF5JUS9NYXFZw
 QdhiowL1U+NiJ/9Lm7wj33tWFvX32zbCUDxBLTmuMNnjttpz7u15KEXizLBo124OpgSznFkp87Q
 YDkRWLmmEboiA0h1LwAbApXR2vKO23YT6co5aAOhw2dgo/5E1aO7cF5Euevq/M0RbVipt8L4qXP
 Fe/rcbpBs5HmLFNIKWE9NypZvQ/bf77fnwDgx+On6aQMO0S0elR4JofCxu78tpsNXwu09C1CkZZ
 gcLD6V9UszlQ9tZI2u5z2s88d0Yk458kGkYL3bR3vpT6TL6Y/xoC57K/sERu8b5856k7qTONnUK
 BJ6TYk5R5eww==
X-Received: by 2002:a05:600c:5295:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4b6de973c5fmr36487555e9.6.1793965981743; 
 Fri, 06 Nov 2026 03:53:01 -0800 (PST)
X-Received: by 2002:a05:600c:5295:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4b6de973c5fmr36487215e9.6.1793965981338; 
 Fri, 06 Nov 2026 03:53:01 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e2028d9bsm105807565e9.9.2026.11.06.03.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 03:53:00 -0800 (PST)
Message-ID: <fe7f7d29-8ca3-4ced-afcc-c768b84c4888@redhat.com>
Date: Fri, 6 Nov 2026 12:52:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/28] hw: mark all remaining virtio object types as
 secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-5-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> These are all intended for use in a virtualization scenario and must
> provide a security boundary.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
Reviewed-by: Thomas Huth <thuth@redhat.com>



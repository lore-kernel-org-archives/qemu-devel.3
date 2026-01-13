Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76015D29DDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYef-0006T8-79; Tue, 13 Jan 2026 02:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfYec-0006Q0-JA
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:17:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfYeb-0005Lq-6w
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768288643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4rC9S1lj6jie3DQXcT8G5TlZtQX56LnouDUTCFOOtLc=;
 b=IWuaXPtP384qUMLc4GNcpg5audoPRFvLOtzkp5cx684GEDR06XiFHbgUJZK7AiFbuUVXOa
 fD611EPKi8lE3UqPr3SD2Enf0wSS/kRbDzhPxmt4/ZF2jXRam5qLKfTCc2erKgVlb7cpwf
 GInBci/7kz9RsxJumG3rQpBE0UCgRUk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-BKw9uraeNiOBTDuxMVcWLQ-1; Tue, 13 Jan 2026 02:17:22 -0500
X-MC-Unique: BKw9uraeNiOBTDuxMVcWLQ-1
X-Mimecast-MFC-AGG-ID: BKw9uraeNiOBTDuxMVcWLQ_1768288641
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b8715782415so19415666b.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768288641; x=1768893441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4rC9S1lj6jie3DQXcT8G5TlZtQX56LnouDUTCFOOtLc=;
 b=Eyo4bbHutz2NF7kLF7glbQ0OtcMdpSjeJjp657gdfN5hPatKzNpzVkUbLmJxHUdgvO
 GI9hvw0e1WxQTNefHkqcqUWjzVlxGxyDermWDgcnfcaBK/M9lPYZ+ayMIz9XrQ8MxGlT
 tMU5nFx/QMUGVpbNs0g0LkP7MNMbCH43jcB5x3qS+TBgJhRP7NIlIs20o44RLueK6JaD
 jkrmLGSVyFF79hHOkCu3LJrceB4ezX/EiDWpAFULC60K7aoZIGQd6H2kWV70WWOIlYEz
 EETHt1S7eQOR1ahmoqOqQMlwobS48MHYInGlsSiugCnL0EOfF7S/VHCLs0OHgyp/xK/p
 SXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768288641; x=1768893441;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rC9S1lj6jie3DQXcT8G5TlZtQX56LnouDUTCFOOtLc=;
 b=NALgqiwuh8eW3RuwCU0qKkNMaHgmdfCSzc07wzSPgWTdHixQnIv2lpW4MQV8zsMy1R
 v9SFirh+r9K1Nrf8gFWUmEM7GQXcMt2gJ7+jQs/j2wSgJk3EKFIvmYPk46GIPVgkhfAV
 ra9K7gbGgIag08N4Y8ZHCCsmCxYlVHLDGGPFxzJEu/2382cWqvrxCeBmF7O24dVjdNX/
 191BEWbwR6vWlJD5ZDsU2fzam3J47XDZIpDV5TG9SPKTpvywViDkNeaJblbd1bWp1SOf
 fR4ZS/ItR01ilU2dRjdWysI6y7MtCa3hCfQ8TZAaSA7giGD+UHwbP535yk81eGwgSxy5
 8HgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhB2Zk3ZEHfM9dEBY3oZfZefCnyWrucmdh50aHQVrAaTMSNnmGUlfiAyJ9pkWwPB7F5w3Wikyxd4NB@nongnu.org
X-Gm-Message-State: AOJu0Yw27MmCprf/WzWj0L5/xQMSqhtri6E0wKvqqb8LkNfTR/Ozrplv
 L3fBi47eDjVIsi980A709n682Y7nOB1AJCiIR5fs1HasFNDZs9jE0yuZxndMSUHUXKB7fWO5l5k
 0z5CBFuJEH7tHwIFSjxEOSifIPwMTLYCbD01rhQc59/me/5o1qnrzDzsu
X-Gm-Gg: AY/fxX456exyzPyah2rwfBDMoaIq1urulxtsafOn+0u+OS8pX5hfc8QWPmxcdBfOx5q
 U3bWGpNCqS288yaRaImnggfgNPf4Zul3rLpHLeTIFY912GNSGuSbspYTgoHkGRwhWYpdJVM+oNH
 DjV9UV+vsQLSWNK5JwX5x67bQtOr4v7FzoKz49WdLQQ8UDmXLDlyIfGxB2Ut9veVmkRq8fktwj3
 pCMuaI6v+uDba4DsGfG1CY8AtAq2kxLO5xsIxTLivGDZCUYmTf+t8escthtz40q2mFZUIBFv9yd
 POwmn2wKPRh3/ZuINbmCqTTAqGfUiqGpJrLqvBhRue7+flEK+194naaLxYLLS+er32hLLGiUazL
 ALDiaE5A=
X-Received: by 2002:a17:907:724b:b0:b87:3395:7f05 with SMTP id
 a640c23a62f3a-b8733957f76mr226681066b.62.1768288640710; 
 Mon, 12 Jan 2026 23:17:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOOLf4dN4sGaU19mT3wsmB//7epwE1PFLykKrpHJnLf6N9A+fNJw2XGM6XL80qOpjssfPpWA==
X-Received: by 2002:a17:907:724b:b0:b87:3395:7f05 with SMTP id
 a640c23a62f3a-b8733957f76mr226679466b.62.1768288640223; 
 Mon, 12 Jan 2026 23:17:20 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8715952fc3sm566070266b.50.2026.01.12.23.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:17:19 -0800 (PST)
Message-ID: <750a94b8-2209-4c3e-bf69-761f33b0498c@redhat.com>
Date: Tue, 13 Jan 2026 08:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] Revert "python/aqmp: fix send_fd_scm for python
 3.6.x"
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-2-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112204026.710659-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/01/2026 21.40, Daniel P. Berrangé wrote:
> This reverts commit a57cb3e23d5ac918a69d0aab918470ff0b429ff9.
> 
> The current code now only requires compatibility with Python
> 3.8 or later.
> 
> The conditional usage of 'sendmsg' on the async IO socket
> wrapper will generate a deprecation warning on stderr
> every time send_fd_scm is used with older Python versions.
> 
> This has the effect of breaking the QEMU I/O tests when run
> on Python versions before the 'sendmsg' wrapper was removed.
> 
> Unconditionally accessing 'sock._sock' ensures we never use
> the asyncio socket wrapper, and thus never risk triggering
> deprecation warnings on any Python version
> 
> Most notably this fixes the QEMU block I/O tests on CentOS
> Stream9 that use "sendmsg" for FD passing, which otherwise
> generate deprecation messages breaking the expected output
> comparison.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   python/qemu/qmp/qmp_client.py | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



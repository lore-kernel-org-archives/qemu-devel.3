Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F09EEE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZXq-00019v-Et; Thu, 12 Feb 2026 11:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqZXn-000168-EM
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:27:55 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqZXl-0007hs-46
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:27:54 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8230d228372so15359b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770913671; x=1771518471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HoCE04pH203c5uvwmShJ485nGZfPiLxCy7n2Kg6MyXY=;
 b=OVsfFenivpVBlwJmpRssM8awKN7HUE8xye+fKiiJ82w2KGiXeslCvatdiFvoTjNbow
 6pOA8O9BTlAKM6m2c9nX07iMOJ+Mv8EtpiZJ3chSzS0qdPep8uYJFitCDtiQGRG1IIGu
 KezZjJv3nEp0wrFW9RwhBGz2u5Mt7yzYPnz90Cuvr5BEZkz5diy6tAGUhnjf7kLpzZpp
 fEKD7Y0qUw/+86GiEarzrxV5F7hY8M0F/lhyfrobU2TuAEtndpopuHy5w2+jzijmN5eB
 qb51kKXrE3hc+10jBziYRej3zsosQNSl6pqIvlgkSn11c2A0NwmnmmS6o/UOcf43TPar
 62ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770913671; x=1771518471;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HoCE04pH203c5uvwmShJ485nGZfPiLxCy7n2Kg6MyXY=;
 b=ROWjih3jP/7Pc6qj/FAPx8DrhpSNkb9GhA+0Wcd2bCBw3H+LV1OxBFxqN0x8tq8hg2
 3ljduCCWVA4iUAejFK+xn2gWABqlQfl+/emHJdC17KuHrbp2RPTT2Tjn2+wolMQc6YgQ
 e5gkhV+7a6YLmu8mvHuRWKAtkDFpXtlbomveVqFlrj+9np6XdX8QV2k0MsO3U5R6tG4v
 WOk3lewK0nJR8DLK2l1o3M+OUdkCP5/HCjwymhDZqHLsAJhrgqPkTujqFmWPNo7fpmWa
 +5F8Z+bdJgXuEwijxhJjAjTCtmHNP5s9JjLYQmTEuYHFhQhLjoQTxINACz8bLY5QDjIr
 NfNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfrDPTFjlyxf+vU5zD8p1mlgEIj76MXhurtMZCqDSU2qWdMQGn1rz5O3D8mjNms6cT0omzVBQzjAqo@nongnu.org
X-Gm-Message-State: AOJu0YxgoLXsSW48Xtqd9HvLEAkH35w+gq2bhkhca16JAEP39n235mC2
 qRsj7prQ3J9kF8wxEso13IkQmPJxg+8PJnf3nqvd5nJNPMTxZQ4lpLCEpa46pM+dpFo=
X-Gm-Gg: AZuq6aK2zxWWVO6XmybWAg5qfEqgNNA1HwCbDKk7xs/OwjvaOOCgXVK68CS85vQlxyB
 MfzRX5jNgMx94Rhge65ElXu4i0X3shvUfAHGGSJMR0V8fcxYKkpwEbipEfxtd4lnC9afjXelfE8
 KkKcJzqrOIdY0hh5eeJ0r1LlgSS19O5UKk2KFfzjdm3HcVCNEE2HeEk9zY3wJjSILF7oGuk8PXm
 i1/CgW6GAaMmSlwkVaeZb0fMrgGPcKb9J3Ipnah7fDx/LblvER27zVjak+HjQh3BhW56ZaToS9h
 jGprxXUqJLwyk6HCcz+guXeH9O1wY9rCgYvIdmTB6dS6/1oEZoI8RuUPMZe3h2kBmXIAZ5dv6gO
 47+jpGEbGVajWAWsoDW8ix710OLUlfOWGHkdekeuoulP4tndvfv0yz8SM02hBuWa4BHoXBxLrrt
 QfhsYDw36iV2XBu2eIwCF3clS/dHqmxZif/6Vcf6bOcqWUZfoM74eevO5U3Cys2Ut/x5DM
X-Received: by 2002:a05:6a00:2d22:b0:81f:4943:b853 with SMTP id
 d2e1a72fcca58-824b04f2571mr3471112b3a.38.1770913669698; 
 Thu, 12 Feb 2026 08:27:49 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8249e367be5sm5617793b3a.9.2026.02.12.08.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 08:27:49 -0800 (PST)
Message-ID: <b552f0ac-80d9-4f28-8ec8-b873c8d45b06@linaro.org>
Date: Thu, 12 Feb 2026 08:27:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: fix bash-ism warning for configure
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260114101525.4039244-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260114101525.4039244-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/14/26 2:15 AM, Alex Bennée wrote:
> Hopefully this makes the meaning clearer.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/build-system.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

This was merged into master (216264cb519a6b8d8dc6962110c0035192e90d3e).
Thank you for your contribution!

Regards,
Pierrick


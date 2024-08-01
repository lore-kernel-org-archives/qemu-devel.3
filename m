Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58395C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 21:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZdhn-0006gh-T9; Thu, 01 Aug 2024 17:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZdhk-0006YL-Ts
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 17:51:25 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZdhj-0004ca-Dl
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 17:51:24 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-76cb5b6b3e4so4762931a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722549082; x=1723153882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yR7nhLWc084f5H9t931s76BPucZOKn8R7h591iFRyyQ=;
 b=n7wIUTZbwnEArXDr/Plp51OuqjSjM6KI4uMedazIQfSBZzp95w5rrPXApB03hRoKX3
 skYvVrPuFKJxZ6Cv9j/kBr+bJTjN3zASaNj8NQkjnj37b4L6ejX/Iv3mowXKwgHuUBqa
 5mHo7iuaHf3Xg3niu7z4t7uRIa8Z6il8YW3i3I77KpESLe6e6i2OJYxXExx8TuHmIlbl
 XjXjuzTOg0ZDVpkpB8na8yvVzGH4k0rlaSca4BsT39unXjwNFdHeKK9dFNfvX3KSTv3f
 NaMj0+QbJnWTSdFgTEHAmAzxwf2B09Ea+sx1cLZ6o88YXCnR1Hbfw6mZKTPNfc5ap7tk
 2lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722549082; x=1723153882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yR7nhLWc084f5H9t931s76BPucZOKn8R7h591iFRyyQ=;
 b=TdbpHG93CP4B48rYz7D5OzxJDBdOeUF7hD9xCjIuIKBxaOCn3z6d/rbdqVadeJX8SZ
 wWThfT85dr1STnBqhJcV43eB+FZTVIdhfOuShtSmusvrm1WviNlDhYSkZJyJiVNsVQcj
 mad41piBl6qiW7a7V/SULj7EqO6q8qdtiUXDsb3p1JX1VVKkwA7AwVEBRp3QOs1F4hul
 iJbNHOMCYlgOfPF4GbP9G1oURbE76Tc5zfHIFs0MmpnQd8osJktDBAtKwxieDTVGGhJr
 8r722NcwaFMZJLjxGaty7mJ3wsDSo4uQYQLfSz4xMTu6MIqI53X689rZllpeaJg4W5Zx
 NZDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkkkF/5bqPtwffqvTdLw50J/QZ9/7MzMNwvk/0eEj30DY3x1A84gR1S4UL2R2j1gCnH8LsN5tX9f09LCjNzNH8IGnwdNc=
X-Gm-Message-State: AOJu0Yz8YC+EeXQHn1bQzwIB7WuOxZ+Q8rmf6T9bwJCiYNh53Ug/QeQ/
 3OKSRmsPJNeEKzQU/tyZ6PfUZHGl5PARhyjJxEdyS1SQHi/g6Rf+ge+mbXpw0gg=
X-Google-Smtp-Source: AGHT+IFHCQf5Qu1uIHdBXWFrof7FYDo6Cd1n6u1+Zy/oVpkxeE8Mf35g6B4koNZblYU6Lty1Ip8fsg==
X-Received: by 2002:a05:6a21:3944:b0:1c0:f33e:aaec with SMTP id
 adf61e73a8af0-1c69964b680mr1838722637.49.1722549081713; 
 Thu, 01 Aug 2024 14:51:21 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec410d1sm286680b3a.66.2024.08.01.14.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 14:51:21 -0700 (PDT)
Message-ID: <89351e00-607d-4453-9d44-8901868cacb3@linaro.org>
Date: Fri, 2 Aug 2024 07:51:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/24] tests/functional: add a module for handling
 asset download & caching
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-9-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730170347.4103919-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 7/31/24 03:03, Daniel P. Berrangé wrote:
> +    def __init__(self, url, hash):
> +        self.url = url
> +        self.hash = hash
> +        self.cache_dir = Path(Path("~").expanduser(),
> +                              ".cache", "qemu", "download")
> +        self.cache_file = Path(self.cache_dir,
> +                               hashlib.sha256(url.encode("utf-8")).hexdigest())

Out of curiosity, why are we hashing the url from which we downloaded?
Why not use the known hash of the contents?

If a url goes stale, and we adjust the url to a new host, we shouldn't need to re-download 
just because the url changed.


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E18FCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 08:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9JS3-0005TP-Sc; Thu, 16 Oct 2025 04:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9JS0-0005Sx-PY
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:35:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9JRt-00037w-60
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 04:35:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so8257945e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760603697; x=1761208497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hLQliNshlhnCP7OA0SCoa8BXG6GIjeRK6YuuEzNaWms=;
 b=sEWxSMpp1x6BRWIiAR+obXNqtApf1IKweA1Md7Jzw5aQVlNt41Ge45Gy9VaakResXZ
 7GRFKcWPZRN+f/hHCl+jrE68g6/+O18ArGO77aJQPYEF00RdO1YXEPXwirjnzDK8E35a
 L+bsHclOwxBWFuCWiRuREmp1ShPguJJJ0yvt/kuCHAgsdXMqWKHLA+H5EHPBdaaDvCGD
 fA60uG098o5GgMy4Hr5vPSFDsY2n8yXqrYIdH5+0SUaEf5r070G1t6v4MOAtQ/S5Cy+9
 SUwmhvP6Q1wiMLOaR3FUuwFvoBFcOey8uSTR6ttwQMgoJP7YLqUCxd3xFeXChQHfanu1
 4LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760603697; x=1761208497;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hLQliNshlhnCP7OA0SCoa8BXG6GIjeRK6YuuEzNaWms=;
 b=d2hKpNi0ORVUuz8YtOBv6iWDWNraLzeG8tfDeaNR1thU3sLP2RRrv3JMGg9sEl8qaL
 3YDaaGXEWNzPNwEuaidmeX11/oU8YnZ1Rgck7Wki3D+Pxekq3XAB806Qot/QWe3PwN3Z
 UHzQcpKzRJFEEsJR/Z/BnQJDprGW5TkZwfLFkIMhCpZgOK7hTyn5wJORyscm1gaeATSe
 Zc+Y+YJAv9AfELk+Gaj/z3wRBvlRwy5HwU6u11E8Auo1vsAW7f/QUHOyMrC8qr17Bl12
 P7N+12JCE0RBSDmzc4WucA/+0hkee9n2SWnYmvW1wFcsAK7GAI+Yb/ak5n/iBRU6nHB9
 Gu4w==
X-Gm-Message-State: AOJu0YxCdUi/A+ZqVjTRT2ilKgAkmwsp7csCxoidl0Dg3LcQWUcITzNz
 /7vgwpriQckwRzZX5fbzIzY9nFienT4tGC+wxFPHQSTNMiWrCWlooRjjistlZ89aSt78T/kHGxD
 C/X7q7Ao=
X-Gm-Gg: ASbGnctjXX6MABfDoV30aHJEVcMJc52PyMV+62QFlqGai9Qif+4AJ1QCIpsabMOCbZx
 k5jw0SFzUlb7yJQz/l0u/TcVwqd/3NfUA6zp+clNsbKyM5oDhrn0UVVRiYQxv+bTjfvBURdya05
 XZSBEdlsNM3OzpL4iY90YlHpK+ipNlG+HcIotODqNda3U2elWr5VpM3a7mW+YRYnNr6eYsxqAAz
 ocVfvYILQuwFU8yGXlw0lEuGv+tMsbxw2Ungm5UhBnWJiFE/nxK6WbqN/u3HQXUNspnioxAEC55
 AYOqp48M9mi07j5I9eVmB8pzvit2bjCnDhsGVPqTckjR6imyqaCVA1u49f9VSYpgkRyRjxeeSNs
 9x8wy6ehPSzvc505WfDeKT23ylJXRz+ZAINYihLyPyzuY5CVHYxpNXjy9g9MlHElBVoiA0J5L1T
 hsNv7AGdoAsJlb0wVPoHd8nDyj3WiG9vGcd2t4Ld8UOuLDS8E=
X-Google-Smtp-Source: AGHT+IEqsA6g70ZAp3ZuzD5PIUKiDBUvFYykaWXH80At92TyjT70bsboB7PGtnWK2zWpZBx6O7YEMw==
X-Received: by 2002:a05:6000:2086:b0:426:fff3:5d1d with SMTP id
 ffacd0b85a97d-426fff3607emr810241f8f.28.1760603697364; 
 Thu, 16 Oct 2025 01:34:57 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0006sm33464001f8f.34.2025.10.16.01.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 01:34:56 -0700 (PDT)
Message-ID: <89edbc29-8f85-4b39-ad48-d78c8358541b@linaro.org>
Date: Thu, 16 Oct 2025 10:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/microblaze: Fix little-endianness binary
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251006173350.17455-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251006173350.17455-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/10/25 19:33, Philippe Mathieu-Daudé wrote:
> MicroBlaze CPU model has a "little-endian" property, pointing to
> the @endi internal field. Commit c36ec3a9655 ("hw/microblaze:
> Explicit CPU endianness") took care of having all MicroBlaze
> boards with an explicit default endianness, so later commit
> 415aae543ed ("target/microblaze: Consider endianness while
> translating code") could infer the endianness at runtime from
> the @endi field, and not a compile time via the TARGET_BIG_ENDIAN
> definition. Doing so, we forgot to make the endianness explicit
> on user emulation, so there all CPUs are started with the default
> "little-endian=off" value, leading to breaking support for little
> endian binaries:
> 
>    $ readelf -h ./hello-world-mbel
>    ELF Header:
>      Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
>      Class:                             ELF32
>      Data:                              2's complement, little endian
> 
>    $ qemu-microblazeel ./hello-world-mbel
>    qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>    Segmentation fault (core dumped)
> 
> Fix by restoring the previous behavior of starting with the
> builtin endianness of the binary:
> 
>    $ qemu-microblazeel ./hello-world-mbel
>    Hello World
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 415aae543ed ("target/microblaze: Consider endianness while translating code")
> Reported-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   linux-user/microblaze/elfload.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Patch queued.


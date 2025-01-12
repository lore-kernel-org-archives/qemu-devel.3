Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C85BE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 17:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX28G-0002U3-8c; Sun, 12 Jan 2025 12:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tX28D-0002TI-Go
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:52:13 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tX28B-0002EW-4c
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 12:52:12 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2165cb60719so61528625ad.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 09:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736704328; x=1737309128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nrj9LdmClEjvzcWeexh+VwC/9/Q4bvfAYui3iYSCF4o=;
 b=vneU5k0hIVDFT5jv6mAMiCq27z4bV0+AngV/3Jf0Sgn5nABcfpW6FjP6dYom5S1A3d
 cDQY1lnOwVlWQ3HvZbpYoujHND926TzdV+qTSrIzhfbAz4/YEkD31f3nuPk6yjQ2XW3m
 Ts+lzsvmOEDwasvgQ4Wb3/1fpK9jLcZk0qROl9wr1kwwqh3TeAj+Ue6hcbIC7PEyvqjL
 l3BcuPcoHDVO0L1p9P4RQA6nu2snRkGt8hnQr7gPYZd6XPzuAS3Z9up17Q8jaXOiaour
 NVFTj6FjdJnBf0UWZLbfBkKaz5t1raIo7TyOc+IGBpqEeIfsv7VMBo8qy4ZObHyMNrz8
 VHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736704328; x=1737309128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nrj9LdmClEjvzcWeexh+VwC/9/Q4bvfAYui3iYSCF4o=;
 b=Yy+xpgOb6xzRYq9gYLsG8rNYostAPLKlv3hasYqYWJ4oNdNkQBxbzmPjLP9yWfG5ku
 Dn7LVCsYaSkTGXIevJsC53vk1ZWDsAg8ZWH+/p9ueFe4qK19PImJfzduAkvrLF+DKghF
 rRFaeP6w/KfLFI6cVZe7OEJdkS6JNLL75Hbj3GwfEUiQPrY205T969WTUv2epZD0GSf4
 ug64P6Ihj5pwT1wJslyFTDJJgiVP8+PEy9wdoAj6euwxS6uClfddtMG+oDjM08dOdQrz
 2ShrNUqIR7z8c0mU0iVgWuafZ9aDDYuxBfr4OTTJ/JL3rKq67imOgwkBaxNoUAW7nkip
 3vkg==
X-Gm-Message-State: AOJu0YzCYDYDDCm+4xHK0GQztWTMh4iNxQO8X4rE0lJE+rkrgT1xMjW2
 YRBhe7pEpHLdhxaGKZbhNTAyJSAI13+ARrboQdW9V64qlgJcvACwz8Sf22ae7gE=
X-Gm-Gg: ASbGnctBuJHPhi7de2usI2Nd9VoUzoy5eyPP5mCEyPg3Bc5NKd2VyVC4gFj0C7VRes9
 HSFa0oP9s78ZAOpSqAUjU3PJvsyMK9OW5yNNs0lH9ANqFX7j5Kh5vL/k2Bg/V+85qAZY04oWNFJ
 UudgPzZQolCl8m90fQME/XwnBjJBYyO91lJ4r25S2sBYzqpm1D9r8nnvWIcxF6fsvuV54hM/F1o
 qkEuoY1S1T4qTd0RaQlDDyLXLaPjsdUoovmV7sxXPXF/byoDFYRwC3cTkXNcQCvDoNj+Q==
X-Google-Smtp-Source: AGHT+IHbNTMW66CqkXtH2NxMJRDQ4cUUjOCrMBFWT88wMNiO7QQHsWgRE+stvlkJeDYYcbCBXNldfw==
X-Received: by 2002:a05:6a00:bd2:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-72d3b2f00f1mr13987974b3a.20.1736704328402; 
 Sun, 12 Jan 2025 09:52:08 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d405485c2sm4533004b3a.5.2025.01.12.09.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 09:52:07 -0800 (PST)
Message-ID: <21dedb00-a958-4a57-98a2-922328133947@linaro.org>
Date: Sun, 12 Jan 2025 09:52:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/nsis.py: Run dependency check for each DLL file
 only once
To: Stefan Weil <sw@weilnetz.de>, Bin Meng <bin.meng@windriver.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20250111215244.1680931-1-sw@weilnetz.de>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250111215244.1680931-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/11/25 13:52, Stefan Weil via wrote:
> Each DLL should only be checked once for dependencies, but
> several hundred (781 in my test) unneeded checks were done.
> 
> Now the script is significantly faster (16 s in my build).
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>   scripts/nsis.py | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/nsis.py b/scripts/nsis.py
> index d0914c88a7..d0ac61f6ab 100644
> --- a/scripts/nsis.py
> +++ b/scripts/nsis.py
> @@ -37,10 +37,10 @@ def find_deps(exe_or_dll, search_path, analyzed_deps):
>   
>           analyzed_deps.add(dep)
>           # locate the dll dependencies recursively
> -        rdeps = find_deps(dll, search_path, analyzed_deps)
> +        analyzed_deps, rdeps = find_deps(dll, search_path, analyzed_deps)
>           deps.extend(rdeps)
>   
> -    return deps
> +    return analyzed_deps, deps
>   
>   def main():
>       parser = argparse.ArgumentParser(description="QEMU NSIS build helper.")
> @@ -92,18 +92,18 @@ def main():
>           dlldir = os.path.join(destdir + prefix, "dll")
>           os.mkdir(dlldir)
>   
> +        analyzed_deps = set()
>           for exe in glob.glob(os.path.join(destdir + prefix, "*.exe")):
>               signcode(exe)
>   
>               # find all dll dependencies
> -            deps = set(find_deps(exe, search_path, set()))
> +            analyzed_deps, deps = find_deps(exe, search_path, analyzed_deps)
> +            deps = set(deps)
>               deps.remove(exe)
>   
>               # copy all dlls to the DLLDIR
>               for dep in deps:
>                   dllfile = os.path.join(dlldir, os.path.basename(dep))
> -                if (os.path.exists(dllfile)):
> -                    continue
>                   print("Copying '%s' to '%s'" % (dep, dllfile))
>                   shutil.copy(dep, dllfile)
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



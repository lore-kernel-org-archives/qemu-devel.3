Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D0110A88EE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 17:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ofW-0003mu-TN; Thu, 26 Mar 2026 13:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5ofU-0003m7-2k
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 13:38:52 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5ofS-0008Qp-6J
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 13:38:51 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3590042fa8eso871872a91.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774546728; x=1775151528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nQ+KnLeQEIFPouyqPqOu5PJQGuofsoRARxG2gqPBdTQ=;
 b=xuuk3USuyM8XB2EDiVqsDZSyVaN6kNAnIcy3l+2Z68n3vNyiCDD3QF3YScbZ61ftUf
 WiYbCA3li7ols5qK3GV31BINNw2ub87jIcvdMOv1zjQlqmBOofXZ99XvCVS/ZAmf0r1V
 bKmzdpxAxYPvdHI01rV5Mx1XQr6Eux2C3JONl4yfFgpkCnddsK2PUGZEUcp0AjcPeNC9
 9jMk19O7LWZbmKxMtHI8qXbC50phlx6uSqU64s3gsIpoAHGy/eA6i1aOLw+vR6pQ6zY0
 UElzPXa802CrPI6nZgrvIUTQn7XGq/q4Pmb+tS7uatTr38vnEJuAA+DGAopk6BmuFcJx
 XHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774546728; x=1775151528;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQ+KnLeQEIFPouyqPqOu5PJQGuofsoRARxG2gqPBdTQ=;
 b=MnGbkUGO4buAm0T9b0pipAY14Bl/sDy0vlxXfwDwou3z3aBp9n0/jBYC9656FGZ3mT
 S/uPn6cZBK6eiS6EOs2nLTlTofHIvRply20K7JCswEZoGB65Icvhm0NjV9BPOFKWR2JE
 5qFt0/NjcvphVAkO04zl2rDRAnAmp41lXYqwTSO1uIjXz3TZCp+5onL+QNVjfzNrnLBo
 XrFh7J/ZBaR7x1k9Q7E5AdNIDMuyXnD8857fkUqRhC5x5pjrukeF4L9eqe8LrlUlFVqb
 CyB9ZSg+vWVNQScwmEdXyWjzbWtLFbsOAShLGGeWfti+OigaK83kXXbgmAtt9VPT8UbV
 Zvig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhQUrZPpGsmE89910nAAG8x877HaHbKCIrq7ulBbLraGsArQxQx1gbAVQ6wwWhB8K0HqHYCKvsHyUv@nongnu.org
X-Gm-Message-State: AOJu0YyfxbCl9XxVhx7k2XQVcszW54XHRwlfctQz20CiW7v5SilrN5a+
 OdA1js0JPg3KLWait3aA7WxkZX/dvZKUi+XwWnSDfseVfeHE2NBaAt6yYTPVsqmtgxQ=
X-Gm-Gg: ATEYQzwS58Yb0hKLlcY7CFP4oGFkQrC2wzjAjoGWkZJ57cYu2z8TqSEuTpLCUnb/JTp
 n0JIUJP7aavrUqg492Q5HoaGyvl2ffvaNI2PfMB1hcW6N/XJLqckuNoT6uAF8EiYg0ZSmxH6un/
 DR5ierolrpk/BEoJZjcI6DXqvhY4fD+q5OQu5qgzmUfhePbEe+yS3E+B785FqqaeCj5u8201JWg
 fRDdm8sDdGZz5fU610Wmxc2vSc7I/VsSal4xWkMN1tNHMgT3wjh9pmpDJXQv1kc5WRlBIywe6Ab
 5X9IadPooISoCnqVWAxAJJxlz8uifRDk1RLWNvMWc4Rq+DzSvuUGF2ERY5wuYrPwmBr7gFMxsBc
 UCjisf75fDKjE0LDx1Vxyy4YtH1uHUnp74+eCrlz9wjo3DElQZfgK6nBX6Dm79YbEmCTVQqb/3W
 guvrSrZoBsJJaBIyWUSxDS+JWjtHEabHBgDMPZ5rDqV6gfBDL4pn8MzzNpRCCWgPk2MoFL
X-Received: by 2002:a17:90a:fc45:b0:35b:e51b:1936 with SMTP id
 98e67ed59e1d1-35c0ddb20cfmr7686386a91.16.1774546728460; 
 Thu, 26 Mar 2026 10:38:48 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22ba5700sm2387613a91.8.2026.03.26.10.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 10:38:47 -0700 (PDT)
Message-ID: <1760bba7-04e6-441c-aec2-96bf722c93c1@linaro.org>
Date: Thu, 26 Mar 2026 10:38:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Misc changes to allow building with Windows Clang
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
 <CAPMcbCoPfE+c1851esnnWRgxFcgm1CRr9CGtOmBNWphX5kt1tA@mail.gmail.com>
 <09297e78-b1bd-4281-919d-99de0a5a33ab@linaro.org>
 <CAPMcbCrwv-Q=iP04iYHi5QTfE9RjWjJwEnLmH-9W2vghfOHEpw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAPMcbCrwv-Q=iP04iYHi5QTfE9RjWjJwEnLmH-9W2vghfOHEpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

On 3/26/26 10:11 AM, Kostiantyn Kostiuk wrote:
> 
> 
> On Thu, Mar 26, 2026 at 6:48 PM Pierrick Bouvier 
> <pierrick.bouvier@linaro.org <mailto:pierrick.bouvier@linaro.org>> wrote:
> 
>     On 3/26/26 9:43 AM, Kostiantyn Kostiuk wrote:
>      >
>      >
>      >
>      > On Thu, Mar 26, 2026 at 6:35 PM Mohamed Mediouni
>      > <mohamed@unpredictable.fr <mailto:mohamed@unpredictable.fr>
>     <mailto:mohamed@unpredictable.fr <mailto:mohamed@unpredictable.fr>>>
>     wrote:
>      >
>      >
>      >      > On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk
>      >     <kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>
>     <mailto:kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>>> wrote:
>      >      >
>      >      > This is the first set of changes to allow building qemu-ga
>     with
>      >     Microsoft Windows Clang.
>      >      > It includes some cleanups and fixes that also make the
>     code more
>      >     portable.
>      >      > The main goal is to be able to build qemu-ga with the MSVC
>     toolchain
>      >      > because MinGW-w64 is not available for ARM64 Windows.
>      >      >
>      >     Hello,
>      >
>      >     MinGW-w64 is available for arm64 Windows, although it’s more
>      >
>      >     mature with Clang as a compiler instead of of MSVC.
>      >
>      >
>      > I expect to use clang from the MSVC environment, not the MSVC
>     compiler
>      >
> 
>     Is the difference that this clang does not come with mingw
>     preinstalled,
>     and thus require using msvc headers/libraries instead?
> 
> 
> Yes, the difference is that MSVC Clang comes with MSVC headers/ 
> libraries, not a Linux/MinGW one
>

I'm surprised you don't run into other issues than the one this series 
fixes, that's great!

> 
>     In all cases, it's just better to use msys2 environment. What is your
>     limitation with it?
> 
> 
> This requires additional maintenance of the MSYS2 environment.
> Also, MSYS2 is a rolling release distribution, while we definitely
> need to know the version of dependencies and control them.
>

The maintenance is quite low in my experience, but I understand the 
concern with the rolling release aspect of it.
By curiosity, for dependencies in MSVC environment, do you use a package 
manager (vcpkg, winget, other) or build them from source?

> 
>      >
>      >     Is it more of a packaging issue with distributions?
>      >
>      >     Thank you,
>      >     -Mohamed
>      >
>      >
> 



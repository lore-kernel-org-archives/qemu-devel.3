Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B669C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 06:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS9aD-00060m-Qk; Fri, 12 Jul 2024 02:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sS9aC-0005zR-J3
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 02:16:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sS9aA-0000OL-Q5
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 02:16:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so9859615e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720764996; x=1721369796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Rg5lylgW8QIhWu0jFbscaGBfdTExw2kzZu6jdb/6Nl4=;
 b=u1tQxPyeUUIpuJKTFpDtoCk60L9N0m5g0d/vQqKAV4jRET0CGwEnZ6/jA4J8nZbmVT
 44XGGDyQ0wK02GKCfcb+lr899taWsjXWoRe6bQazeyMyOLZwSo3xMEQUIgGUs04QJJO6
 QrW/D6mIC7Dvn/53BLQPcF3SKsRm2pm9RgPgnlitLUHcVdFw+o/OtS90EV+jn25WnYJo
 Lfj51Hj2/NT/E/Oim5C8nw8lU2Z7U6LyvxmOtEnv64O+PFjmbBs4UhpE/W7Cx4Sy8/Im
 nsG8OtFY+btyIAFOMGYFiskrJKLRyI3eGrbEdFSN9NPQN8Ww4tylNoSMQeZdtMDNqB3A
 8C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720764996; x=1721369796;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rg5lylgW8QIhWu0jFbscaGBfdTExw2kzZu6jdb/6Nl4=;
 b=v+ccgaBE6Ux+PDJfB4OZIlX6PfkK71o3CQXzpEwIghlS3MJR2VGK1lvXQpJDpmoncX
 ZQUNDlUpDyQ+hRID8dIEFpENP09kilNs9ro0FUga7ZsY4gg/UpnDJE0WBOTddPs1VqMq
 XkGQWNgT/RcP7ewZsoCvDkLu/U/SG0o1liMNn08mdTNOWCbi264J5/vEgyRDCufCHSep
 W+TvoXedcmK8dQFlXLULPPbE660IEnhvLw4P1Fw5Q33n9aBqMCgAUskquMmB7ZeyY18L
 WSrcm6KusvpCHyQr9s/4a7X+gsFHpkBu/blkItnCLSoC4LpwfxKnhW2DGTSl3EExJZtG
 SKJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjVKecJISKxyziWci+z42c1gJjwGxeTRsPYTNueOZdfX+fx47t/N7blJoP4jQvyhPDCEkswWA/RrtJN5W8yeHRnLrKPN8=
X-Gm-Message-State: AOJu0Yzmnazcb28FdO0S7PdL4NMGBLj7sm8srwwxf5trNYYMjKI53x8r
 jwXbXmQlf128KjV4hmXbiPSj9Id3apVaobF3kLFmEnIvhB0UYd9dvjKltXYGml4=
X-Google-Smtp-Source: AGHT+IHoRX74k6rMq6XYIuFgJSmEUmvPQO180s/2F4bicGdIMFl23pFxAJmBLlSC2uxv3+pjJhhHcQ==
X-Received: by 2002:a05:600c:19cc:b0:426:706c:a55a with SMTP id
 5b1f17b1804b1-4279d9f287amr15252215e9.2.1720764996084; 
 Thu, 11 Jul 2024 23:16:36 -0700 (PDT)
Received: from meli-email.org (adsl-255.109.242.224.tellas.gr.
 [109.242.224.255]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7e1dcsm9298158f8f.12.2024.07.11.23.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 23:16:35 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:14:29 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 rowan.hart@intel.com, Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 <87msmqsunu.fsf@draig.linaro.org>
 <CAFEAcA9X0564R7V=EsN2qxj51FNNkot3Pfev6mMgUbr35WYFZw@mail.gmail.com>
 <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
 <Zo00iKKtRRDTTslY@redhat.com>
 <641f264e-81ff-40fa-880d-bda18339ac57@linaro.org>
In-Reply-To: <641f264e-81ff-40fa-880d-bda18339ac57@linaro.org>
Message-ID: <ghyrm.h5hupsa1jwz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Fri, 12 Jul 2024 00:23, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>On 7/9/24 06:00, Daniel P. Berrangé wrote:
>> On Tue, Jul 09, 2024 at 02:28:38PM +0200, Paolo Bonzini wrote:
>>> On Tue, Jul 9, 2024 at 2:09 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>   * what is the actual baseline requirement? We definitely want
>>>>     to support "using rustup on an older system" (should be no
>>>>     problem) and "current distro building QEMU using the distro's
>>>>     rust", I assume. It would certainly be nice to have "building
>>>>     QEMU on the older-but-still-in-our-support-list distro releases
>>>>     with that distro's rust", but this probably implies not just
>>>>     a minimum rust version but also a limited set of crates.
>>>
>>> I don't think limiting ourselves to the set of crates in the distro is
>>> feasible. It's not the way the language works, for example I tried
>>> checking if the "cstr" crate exists and I didn't find it in Debian.
>> 
>> Yep, Rust is new enough that it is highly likely that crates will be
>> missing in multiple distros.
>> 
>> For ordinary users, cargo will happily download the missing pieces
>> so its not an issue.
>> 
>> For distro packagers, they'll just have to either package up the crates,
>> or bundle them in their QEMU build. Cargo makes the latter easy at
>> least. If distros don't want bundling, they'll need to go the more
>> involved route of packaging deps.
>> 
>> IOW, from a distro POV, IMHO, we should focus on the Rust toolchain
>> versions we need as the minimum bar.
>> 
>> With regards,
>> Daniel
>
>I would like to add that, contrary to pip packages for python, it can be 
>*trusted* that Rust crates.io will keep packages and their different 
>versions, as it was designed to be an immutable registry.
>
>Indeed, users can't remove their package, except for strong security 
>issues, to the opposite of pip.
>
>Besides offline compilation scenario, are there any other reason for 
>wanting to use distro packages instead of letting cargo do the work?

Only distribution packaging is the concern here, where packaged build 
dependencies may be required.


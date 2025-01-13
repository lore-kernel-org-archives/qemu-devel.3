Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61131C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 20:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXRLd-000875-Pd; Mon, 13 Jan 2025 15:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXRLV-00082h-3O
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 15:47:39 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXRLT-0000Tn-CF
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 15:47:36 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2166f1e589cso99351505ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 12:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736801253; x=1737406053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iSpRzJS58+XCV/UTHd9T6bQL6dIENzuXvmusP38uUC4=;
 b=ItaS0uhB2UpnSMZqUsuo30k9QjMDG5+hYl7Xvs8aLN1BeenzU05ktHVXzRF59Qzpaa
 0YSMtd6O2cJtESyic+mBH68a2E1qVvtd7wPNG4RrUN52hgmNwU2U95L3P1F6Xi6/wK0Q
 8YKatttKUCMW9ndYG6Tepr78e0CbCNy5ozX763JrG+8zfYUCwdSVYj+MU6xM3/YpqyEl
 2m65CdB6wUeT+bj0LhoZriNWUXLIbLrHnercblXC+leXts7M+xVzdJczOdJ4EyzDGpk9
 UsQLS6GAT3LAWimhvtFlZkT2P5P0V3JsSIyxpTEPYHkLjTsf2bUNTtqTv2WwZWfDp4xU
 Q6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736801253; x=1737406053;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iSpRzJS58+XCV/UTHd9T6bQL6dIENzuXvmusP38uUC4=;
 b=EXoDogeNFGw4dXJeKrJ7akNe6g8EWZktTODJKXwuVyMWgzw4YujUpirC4e3K7uzXG3
 s//lIcezb3saYPmB9U3fzEj8Xa75W4Mq3ku/m20hBzKN35ICETwFF3Oy744HhmSGYcVq
 HFaMQQluCmE8i9SfeFyOcVOM6Uk8DfD9Silq5ldjwYBfoCPajKofDXRaPGAbc02SRDAZ
 JnKW/VqzCwgePA/+NAy1VwLNNhUQ6ng1rNx1rns9DFw3J+b+YRJvnvkjcLH3JKaxlWKu
 SopyHMoka5zPtFCbclYS05DeVmGFPs0atVYTHyfIR+Pwge3GltMdacHb5mGtr9DMf2Fm
 zRQg==
X-Gm-Message-State: AOJu0YxxdvqY8W4NsRaFlcKuSB2/H0f7TNun4FV6IPZmi9vlsYK3cgu2
 QlCxXoDwL/LqLLhAbTeyy23Hl7kCWCHHf7R/urxjTqTdEfH4P1lEXUyU6ev3GxnOW/f+/MXaYH6
 vwb6LDg==
X-Gm-Gg: ASbGncvgIK18Aoo0oqf8Vu3S6zcy2YzfYi8++lTgzAVgHSpFVCJIg5W+apXk6HfttYy
 VOlSh5KyoFsgvZiXDAFZypUtuxwkFK9wzeLWkyFsCziyfq1TR/zZDU9rofNu3xjRZ7AX6o0tLm7
 +E3Waf+CBPab11nCqmDPtyzFDiZBsUKfa0zyjDYZs/snAwvksXODT2qSMHRwmGkWPtjW+UacJVb
 S3NX1CqtO0k/VpkNOV0rCZoHn+hSkRx1n9Y1y+LrldSzEVAFulKEvlAF+Jpdh3+eSfOnQ==
X-Google-Smtp-Source: AGHT+IGbC+ClgfWQHiGFak830382rHucPPraHeqFoOc5HTzidWB8BL/bKsXX+OJhRoN7VoFroz/OvA==
X-Received: by 2002:a05:6a00:1152:b0:725:f282:1f04 with SMTP id
 d2e1a72fcca58-72d21fcf2d9mr31928642b3a.18.1736801253336; 
 Mon, 13 Jan 2025 12:47:33 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d406a9433sm6371563b3a.176.2025.01.13.12.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 12:47:32 -0800 (PST)
Message-ID: <55932eae-bc2d-4c22-abc4-5c9c04612281@linaro.org>
Date: Mon, 13 Jan 2025 12:47:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Enhance documentation for new developers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, Andrew Melnychenko <andrew@daynix.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Kevin Wolf
 <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 Fabiano Rosas <farosas@suse.de>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, gustavo.romero@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241209183104.365796-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241209183104.365796-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 12/9/24 10:30, Pierrick Bouvier wrote:
> This series extends our documentation with new pages to help developers
> onboarding on QEMU. It focuses on providing a big picture of QEMU (to a
> modest extend).
> 
> As such, it was written to be simple, short, easy to understand, and pointing to
> more details. It provides another way to dive into details instead of simply
> hitting the "search" box.
> 
> The first patches enhance the existing developer section. They provide
> information about b4 and git-publish, two important tools that I learnt from my
> coworkers, and were not presented anywhere, and were really missing IMHO.
> 
> Then, we introduce a new Codebase page, presenting (succintly) the various parts
> of QEMU, and what every folder of the codebase contains.
> We then add a glossary with the most recurrent acronyms we hear in our daily
> conversations on the mailing list.
> Finally, we add an "How-to" page which present how to build and test qemu, and
> how to contribute a patch. It's definitely a repetition of existing information,
> but the goal was to have a self contained page with all the commands I run
> daily personally, and that someone would be interested to have.
> 
> When reviewing, please keep in mind this is targeting someone who discovers
> QEMU, and not someone who contributed to the project for several years. What is
> obvious for you will not be obvious for a random young developer.
> 
> That said, please free to point if something is "false", or "really incomplete".
> It can be hard to summarize in one or two sentences complex parts, but that's
> the intent here.
> 
> Your feedback on content or organization is very welcome!
> 
> Thanks,
> Pierrick
> 
> v2:
> - removed how-to section
> - integrated all suggestions from Daniel and Peter (thanks for all your comments)
> - Note: build environment keeps mentioning windows-arm64 because we solved the
>    issue with gcc_struct attribute. The related series will be merged before this
>    documentation.
> 
> v3:
> - added a comment about git-publish asked by Daniel.
> 
> v4:
> - add suggestion from Thomas for codebase and message-id.
> 
> Pierrick Bouvier (6):
>    docs/devel: remove dead video link for sourcehut submit process
>    docs/devel: add git-publish for patch submitting
>    docs/devel: add b4 for patch retrieval
>    docs/devel: add information on how to setup build environments
>    docs: add a codebase section
>    docs: add a glossary
> 
>   docs/about/build-platforms.rst         |   4 +-
>   docs/about/emulation.rst               |   2 +
>   docs/devel/build-environment.rst       | 118 +++++++++++
>   docs/devel/codebase.rst                | 220 +++++++++++++++++++
>   docs/devel/control-flow-integrity.rst  |   2 +
>   docs/devel/decodetree.rst              |   2 +
>   docs/devel/ebpf_rss.rst                |   2 +
>   docs/devel/index-build.rst             |   1 +
>   docs/devel/index-internals.rst         |   2 +
>   docs/devel/index.rst                   |   1 +
>   docs/devel/migration/main.rst          |   2 +
>   docs/devel/multi-thread-tcg.rst        |   2 +
>   docs/devel/qapi-code-gen.rst           |   1 +
>   docs/devel/submitting-a-patch.rst      |  44 +++-
>   docs/devel/testing/main.rst            |   9 +-
>   docs/devel/testing/qtest.rst           |   2 +
>   docs/glossary.rst                      | 280 +++++++++++++++++++++++++
>   docs/index.rst                         |   3 +
>   docs/interop/qemu-ga.rst               |   2 +
>   docs/system/arm/virt.rst               |   2 +
>   docs/system/images.rst                 |   2 +
>   docs/system/qemu-block-drivers.rst.inc |   2 +
>   docs/tools/qemu-nbd.rst                |   2 +
>   docs/tools/qemu-storage-daemon.rst     |   2 +
>   docs/user/main.rst                     |   6 +
>   25 files changed, 709 insertions(+), 6 deletions(-)
>   create mode 100644 docs/devel/build-environment.rst
>   create mode 100644 docs/devel/codebase.rst
>   create mode 100644 docs/glossary.rst
> 

Gentle ping on this series.

It was reviewed and it's currently waiting to be pulled by a maintainer.

Regards,
Pierrick


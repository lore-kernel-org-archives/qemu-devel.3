Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230ABC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 11:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSb5l-00020J-Qx; Wed, 24 Jan 2024 06:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSb5k-0001zc-1c
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 06:06:48 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSb5e-0004kx-OO
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 06:06:47 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-337d05b8942so6058846f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 03:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706094401; x=1706699201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Iy/OKjpiO5yoeXxY83xqvHL6o7nHTDd39y/0xcYG3qM=;
 b=hlmgl4rPJKhE908qaoUiGFGZPyL8H6Xn77AmdNMjqxaTYk+VIXFagKHvzQ2ZIfsluE
 /S5Vw1rrBiWEG1IAVFo24kFafMSgFOqx7PNjUWD45SpPdjcHP+IlZ6603p4iqkpYyzFB
 yP+b+s7CFJSr9FM/JYQWghn7MgL5gZ6QD3wIQ9TgoKl3FgerV/aXXEFqfI3Jk+ASj2UA
 BKRiD0vVRbH3ZCt8To7aWNm4dQCL8kKflJhY+ts0xOPtu1OFJsiOalN4VplDwcQxv6Kn
 MZ82+Nwhokd7Rndm7tr2Swi6OP+HmieYLGZy4IQg+lGvNcRxsNQBWNjpiOO3saEpduF7
 a/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706094401; x=1706699201;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Iy/OKjpiO5yoeXxY83xqvHL6o7nHTDd39y/0xcYG3qM=;
 b=T45sneuKVwi3EOxV8hEGEgwFSuvG5g5T4ESxarcNmsaNRivrvEdPPHzEqGH2AIVMK0
 Jcr9YJTDTsV9gDnlLqTt0tBSEEpP6SXBaj7XgmskGmOhczxxJr8q2j8UIQOi4IOAqvBp
 t5Kz62LlLCqMBq8PxAAopolgAJNKl8RsO2IO1e2hBaxzs4JHUthEKgxzqIDaUXqnveaD
 yqPGj4m/vHIsro3ec1rDC3aLfQV16D6eKFp3ONAof/H8cfOVvJsEa+M9oqJDe1a+LlMF
 wlgAwW7XwfvF09hJVdvw3rMpYSUmHuzFtdAASEUV9u8F2uH4WR+DQwnMe+rItliA0foa
 ZfdA==
X-Gm-Message-State: AOJu0Yy90p5Gwo99sz7hTeNuGi8UDkx/TZKzcRYnIvCZtv964jzPzE9y
 Jveri0XF8K+uPcTfNCnnbl36IH3NKddLxRXPCfMqdQC08xLPsLY7S8uYvhRTbPE=
X-Google-Smtp-Source: AGHT+IH/SauWLJ1xOlrVqSMxVFexDKwt7XPZ6S6pWBnjez+xHwFpHdDkwUvpg8Qby7kwDeLsfRpNeA==
X-Received: by 2002:a5d:618b:0:b0:339:372e:770f with SMTP id
 j11-20020a5d618b000000b00339372e770fmr502198wru.46.1706094400988; 
 Wed, 24 Jan 2024 03:06:40 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 d10-20020adfa40a000000b0033953f87085sm414725wra.35.2024.01.24.03.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 03:06:40 -0800 (PST)
Message-ID: <5a1cb4ae-b43c-4ef5-9572-6636a2d787e7@linaro.org>
Date: Wed, 24 Jan 2024 12:06:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/31] docs: mark CRIS support as deprecated
Content-Language: en-US
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Nicholas Piggin <npiggin@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Rabin Vincent <rabinv@axis.com>
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
 <20230925144854.1872513-5-alex.bennee@linaro.org>
 <ZRG1g/2hWi8+AzNn@redhat.com> <878r8urxxc.fsf@linaro.org>
 <CAJy5ezoucKM=VvYsHeFep7r0i1PV_JUCgq6gs4JJQVHqq3Yz3Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJy5ezoucKM=VvYsHeFep7r0i1PV_JUCgq6gs4JJQVHqq3Yz3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 25/9/23 19:17, Edgar E. Iglesias wrote:
> 
> On Mon, Sep 25, 2023 at 7:00 PM Alex Bennée <alex.bennee@linaro.org 
> <mailto:alex.bennee@linaro.org>> wrote:
> 
> 
>     Daniel P. Berrangé <berrange@redhat.com
>     <mailto:berrange@redhat.com>> writes:
> 
>      > On Mon, Sep 25, 2023 at 03:48:27PM +0100, Alex Bennée wrote:
>      >> This might be premature but while streamling the avocado tests I
>      >> realised the only tests we have are "check-tcg" ones. The aging
>      >> fedora-criss-cross image works well enough for developers but
>     can't be
>      >> used in CI as we need supported build platforms to build QEMU.
>      >>
>      >> Does this mean the writing is on the wall for this architecture?
>      >>
>      >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org
>     <mailto:alex.bennee@linaro.org>>
>      >> Cc: Rabin Vincent <rabinv@axis.com <mailto:rabinv@axis.com>>
>      >> Cc: Edgar E. Iglesias <edgar.iglesias@xilinx.com
>     <mailto:edgar.iglesias@xilinx.com>>
>      >> ---
>      >>  docs/about/deprecated.rst | 11 +++++++++++
>      >>  1 file changed, 11 insertions(+)
>      >>
>      >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>      >> index dc4da95329..7cfe313aa6 100644
>      >> --- a/docs/about/deprecated.rst
>      >> +++ b/docs/about/deprecated.rst
>      >> @@ -399,6 +399,17 @@ Specifying the iSCSI password in plain text
>     on the command line using the
>      >>  used instead, to refer to a ``--object secret...`` instance
>     that provides
>      >>  a password via a file, or encrypted.
>      >>
>      >> +TCG CPUs
>      >> +--------
>      >> +
>      >> +CRIS CPU architecture (since 8.1)
>      >> +'''''''''''''''''''''''''''''''''
>      >> +
>      >> +The CRIS architecture was pulled from Linux in 4.17 and the
>     compiler
>      >> +is no longer packaged in any distro making it harder to run the
>      >> +``check-tcg`` tests. Unless we can improve the testing
>     situation there
>      >> +is a chance the code will bitrot without anyone noticing.
>      >
>      > Deprecated is generally a warning that we intend to delete the
>      > feature.   If we're just going to relegate it to untested
>      > status (what I'd call "tier 3" quality), then we should document
>      > that elsewhere.  I don't mind which way we go.
> 
>     We do have reasonably good coverage with tests/tcg/cris but of course
>     without a compiler we can't build them.
> 
>     Both nios2 and microblaze have build-toolchain scripts which can be used
>     to re-create containers. However my preference is having pre-built
>     toolchains hosted by others like we do for loongarch, hexagon, xtensa
>     and tricore. Then the docker image can simply curl them into an image.
> 
> 
> Yeah, I guess it's time to deprecate it...

Is that an informal Acked-by? (:

> 
> Cheers,
> Edgar



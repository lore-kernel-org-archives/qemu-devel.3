Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC64ECA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNvc-0004RE-Lu; Tue, 19 Aug 2025 11:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoNvT-0004PX-DL
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:07:03 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoNvQ-0003ue-0r
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:07:02 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e934c8f9751so2553723276.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755616018; x=1756220818; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lGjB2DDXN91rgRPxeWknxQ33rBHPgYOM1OJPngJJmUI=;
 b=gfgJkUaKPyFbJ3Bxmm2RRijkKHC+50Hz2+2++ek3csaIj0givjGREfrrhzczLnYAyk
 Mhdx+oUwcRozrPLIK2qcXyfslEJhWBXk4xyzhziu+o6WuNA0Re1tgu91f9VIAiUjxMrF
 FwhQQdVkKMwCVCuWztFUy9sS0RE/xtl2DN/wwkSYh9Sedtm3QAQxwPIM9eb2erPrwGop
 uYkQqcWXzC4zwf4fmOQFVU6YqK9AcNl/goFryyxe/EkKwdNMc0gV15jrUvs73CQEWzRc
 ru9TUbqC+qKS9qNA+llIJjB4B53oQua+JnxDa2UDrfDeevEik1xiqvBd3kzqNN5U3TNP
 sfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755616018; x=1756220818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lGjB2DDXN91rgRPxeWknxQ33rBHPgYOM1OJPngJJmUI=;
 b=Cjibl6lCux6RO7IFbXQLJvf4bEw4f6B2LZQjamU4XsNSvw61q948tm9UpjhucNxup/
 EBtkFuZX4edk4B6JeDvlPYkYHfwWesPCL3Y1SHmPwG442/EgapRiFPZU68EcM/HLQny4
 gLRSRSKswK+AvHzro7dyrHMRLneMsfQl8caafkBxRMXs9FoM2PZjG6falc0vqCe68HMA
 NMfCQ5wchp4RRiGyK1fjI4cnQusPhGyw+TMzHbD4uTfNvGxcpgzLFR7dhNCl9OUzVB5A
 gfvWBmKGwffcC9cEASdo8UxdQ5Y1NcCuH28UrW/Sy1H+4xxX0Gc1/h74N3zpuvJeZSYW
 axZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnj8QuydWKb/ZL74gxguYoTKrE7/XQgtdOy/sAygRcpz7R9vKj/807NStzN/CrAV5viMyMfSZ85eMR@nongnu.org
X-Gm-Message-State: AOJu0YwIxycHlvpQTq1gwIphjIHszSYWLCgpDUPSfKsnslwuJ05CR7B6
 fOJ6/MiHSGMYQgjENfm2pdCFqDZRcd4h8V8yIO2+Sus7t1zOmd7NO8yp2SepwFgc4y35R+Nzq0z
 rcyqCpGEAWqV1UtDASt/vzKCj9jnZVdfoi184HossEQ==
X-Gm-Gg: ASbGncsmAe30LjAg1GO0v+1SI+SDkSxSpXq6LxtPZ1hEVGu8yN6VzEwtzWQv8EMsSGJ
 Jb7A0eyltUeIO17tteqq1J2YnHazkj08JFvJe28a+O8rfcyvU0aa5sLUpN19piNXnLMykDaEOuw
 J1qqYiDbmv6hymZoKi47Pd4jaHmDIe1uysq/ywq4Mg2tCI2ZVp0jSr8vqRIwNvG1nYhEZq93hZ3
 T+9U3Eq
X-Google-Smtp-Source: AGHT+IFEacLfEpsLPwL8RpIQaBKhz9WKuYQrybbHLgsUXEGDBbIpJ6uSC03YG2N60vf9y/Ix/KB5hHQFI6/31aN1lA4=
X-Received: by 2002:a05:6902:4308:b0:e93:480b:5356 with SMTP id
 3f1490d57ef6-e94e632528fmr2971984276.47.1755616017889; Tue, 19 Aug 2025
 08:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-16-mohamed@unpredictable.fr>
 <CAFEAcA9iQnrKWXPXw2wG3c6gmevOMFQtt48HsJdx8GZz2sd+4Q@mail.gmail.com>
 <8e64fd77-9969-42b3-bbcd-1ed8de910ff9@linaro.org>
In-Reply-To: <8e64fd77-9969-42b3-bbcd-1ed8de910ff9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 16:06:45 +0100
X-Gm-Features: Ac12FXy5JRRiJ81OjIWr7z9p2uyQ9l0Cz-RNNmpcll_HRaXOsoA8AhnGYU96-BU
Message-ID: <CAFEAcA9OXu3=HuA9n+Oo0C5K5hTG+kLr9xsM=geBJ_UtCi4_-w@mail.gmail.com>
Subject: Re: [PATCH v5 15/18] whpx: arm64: implement -cpu host
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, 
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 19 Aug 2025 at 16:04, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 8/19/25 6:24 AM, Peter Maydell wrote:
> > On Fri, 8 Aug 2025 at 07:55, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> > Can you follow the QEMU coding style, please (here and elsewhere)?
> > Variables and function names should be all lower case,
> > and variable declarations go at the start of a C code
> > block, not in the middle of one.
> >
>
> In some cases, including in this function, I feel that the rule to
> declare variables at the start of a block is not really helpful, and is
> more related to legacy C than a real point nowadays.
> As well, it sometimes forces to reuse some variables between various sub
> blocks, which definitely can create bugs.
>
> Anyway, I'm not discussing the existing QEMU coding style, but just
> asking if for the current context, is it really a problem to declare
> variable here?

The point of a coding style is to aim for consistency. QEMU
is pretty terrible at being consistent, but we should try.
The rule about variables at start of block is not because
some compilers fail to compile it, but because we think
it's overall more readable that way.

thanks
-- PMM


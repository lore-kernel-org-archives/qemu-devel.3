Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88215D58D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 17:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFcWd-0005nh-K4; Mon, 25 Nov 2024 12:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFcWc-0005nF-BK
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:05:26 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFcWa-0001Vu-R6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 12:05:26 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb388e64b0so51696011fa.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 09:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732554323; x=1733159123; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Hmw44pw3/Vp/cuis3JSLF6c/m41LswAYGjx2Tpj8ys=;
 b=Cwq7P86OWuaCMwRx5WKkwqO2/K49bK2Ba4rCS+vFTl0+1qdpa72VlyquLRb1ITo5SI
 0XH+bjK253hgkc9FXEOQUS3BYWLDxJek6KL9lQ2w62Mgz8TzmBUWIKljhuIHtqThJItR
 cbN4bBuDquR4tHx+GJQ2I7il+ZCjduXWOJ3iT2MH09ewf7IynNn170enPr2e19QAbXGo
 VVwoTpzqR9ofjh2oFPMTD+fW1uuhtmdDL52TO4KhZaV0AP21PxLD7QoCybUbS4oYYuLD
 QBbhMD16tOLamPNjwSDAK2SxogzLfDliHAGeHLEZM49Ej7oA/Jp7+mnmc8qJvkjgdu8c
 LWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732554323; x=1733159123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Hmw44pw3/Vp/cuis3JSLF6c/m41LswAYGjx2Tpj8ys=;
 b=WPFz9+eMKJTCDvxvOwLU8hbnqbRfJ2mfaRTnYfRStQwp5l/ROGQl3f2gPK5/XyrRs3
 8Kq1pLAes1PeOOp/h2cDogOoDm4Hld5ZKfea3qOtYPCgK0rqFMb7ltCynbS1ktD8w8e7
 uPW7grpim24785cB58z4/7iICaMUfInEDMY76DrmrzSapZJ84jo2QuQSxhiSuLf8dLy8
 XWNUEAOv5IEVaXZLxamD1YjUzebiYu4PrypecWI5GGPrGIFb2T6OzBC4gOBCQ5eZU1gl
 CC+X833DHr0SAfzt2tkGtFegivEOtqmo92GZJYcsMnzJLqsuXKRPLMI/Nl5QY9nzQikR
 fESA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9NTZYamDRXQeyNhN7ubkPc0bjx5M2j4F5JiJ460SVFYY72CPmwvYJIA3eeeyjXIj7csuT0O0DUatd@nongnu.org
X-Gm-Message-State: AOJu0Yy1FrrqUjTDpvnfLajJio4/41eYxRXi39AfixpuMnCHdphpUULF
 euS0NG8Ag7eVsgf7DwsEcOJRwrwBRN9kmjaNL0//z1JE0vUe6twG/6gJ8MNxGnbuTQCvr9QuIzS
 cL6i0ErJgM30z47VsvuxtA5oN16phNfq+3YR9Rw==
X-Gm-Gg: ASbGncuAhT5PR4QzQ9Ij/JHVDCZt+73J1rb2hiyMBsmeCQqPbVl9rVXcycBxxQbxVpJ
 Dzoj3Ol404Cm1lo4SvJfHY9aAtDHkXsJk
X-Google-Smtp-Source: AGHT+IFqbcKLOT3IIhmCTqNt7SEN32m8otN0YzTPHPZH4+XT3F8HJOslxDp0E/WEDl1QQpijCZnzprhSYLCkeUwmkkE=
X-Received: by 2002:a2e:bc09:0:b0:2ff:caf8:2ff7 with SMTP id
 38308e7fff4ca-2ffcaf83659mr6572981fa.15.1732554322659; Mon, 25 Nov 2024
 09:05:22 -0800 (PST)
MIME-Version: 1.0
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
 <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
 <Z0REl6xtaYuvP876@redhat.com>
 <CABgObfYeNW2WYVkPVGmaPKXHLC6bfHm8fFO+wuoQzZiOB5DPyA@mail.gmail.com>
 <05108195-009e-4d06-bc79-065b1e3432ed@redhat.com>
 <d02f2221-ffa6-4232-bfcf-a19deee6d1ac@linaro.org>
In-Reply-To: <d02f2221-ffa6-4232-bfcf-a19deee6d1ac@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2024 17:05:11 +0000
Message-ID: <CAFEAcA9vPC40B1cJpuzhN2-mfQG4sY6Sth8jhB+9RwC7aVvDsw@mail.gmail.com>
Subject: Re: Supporting clang on windows
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Mon, 25 Nov 2024 at 16:48, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> Before sending the a series removing gcc_struct and editing the
> documentation, do we all agree here it's the right move forward?
> If yes, should we apply this to 9.2 release?

I would prefer not to put it into the 9.2 release -- it's one
of those "small change with global effects" which it's hard to be
sure don't have unexpected consequences[*], this isn't a
regression, and we're already some way into the freeze-and-rc
process.

[*] though in this case the stuff you've done with comparing
binaries is great and very reassuring

thanks
-- PMM


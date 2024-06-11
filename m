Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6444C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxhe-00027U-Pa; Tue, 11 Jun 2024 05:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sGxhd-00027G-Fd
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:22:05 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sGxhY-0005wl-SO
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:22:05 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ebeefb9b56so10053761fa.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718097719; x=1718702519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HJ8ZB0M6228iVYGDBJHTxKD5uJyM/zEz2/HvUMQDVpA=;
 b=PLLjggz30C4zx8Q48p7NccSFw0w7BG6VS9ohuvbiJJj7u9cilbkxib0NZRCVFUh6y4
 n8GDM2dv2F8dU4T/0Jo4N+CY97WptKAwpAc9M2lbLdn8cFXIC9/OXpLOREO91JG/5utv
 89mXfWPVreIbZUXRTawxFUJ6yO6qWXLgBjmCcg9qnufhir/i9jUHQdN898d//qJtMieu
 04okOfYa5eaCpgkqP26FTkSdPvrjmI/2JDSrSSNOVuujAGqKppGEuViN12QkO7dA+Ctk
 n5Wt0lQqw7R2S+1JrQlqmDANwbdRQhvqT97RuSTq6T7nOOvW4fUPbq/xpuHu0P5QN8kb
 gFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718097719; x=1718702519;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJ8ZB0M6228iVYGDBJHTxKD5uJyM/zEz2/HvUMQDVpA=;
 b=DMx15kH6nNPL1vXM1Ls0lz2tav8n2OpHDRL+wMdm7DLxFpa/yynlc+aCX3bl94hI5H
 9rug/p9ksR6bKv6wbkK6kEPcqE3TnXXA4KaH1/gs3rGVE6/kqOT+oxtYK8+VspPLPmUO
 kZs6NrTL5X1l1GBdAiJLXF9ZwgqsVoV1F4ZNwpXl2S+H8fXJO5rJQXL8DrORtRIea1t/
 THrg17PlRU/MyABso1xIMb5O+/LjwrLmjKLpwnZhO7Pf11n8PqWBsgabkcrroPnQrRfu
 UMFF7deBYjSQSteGNycq/DJ+FMXOfuGoYnAbk8ESgqVqzJSzLqXU4m5pxKsbcgnLuRgZ
 ZUpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhApc7Ws/JjZOI2JUMsG0f1xdazLOBEpYgq66xYYkG7bcH2ncUA2sJrK7P4Owh68ZgyxUqkltK5SCRX9zCUphsOsa15dw=
X-Gm-Message-State: AOJu0YxnPSbHyMhKuM8dzV4TYVWTkcE6qyWEMc+K4b5pFQDguO4qD/JQ
 wK+B/9vsXlNDfBNcVJ1qsyUq1t6hOO1MApmUWy9mmhrnKwSEBUpYxq+24Ql47LPisUqKWMhJVah
 u
X-Google-Smtp-Source: AGHT+IESE0SNnm6QlbKLvxm8UQlt9x1evHZ6KoLPbBvXbUFedfo0Mb0yF54ksH0cNW6hpwE6Or2xEw==
X-Received: by 2002:a5d:6da8:0:b0:35f:22e3:1e0c with SMTP id
 ffacd0b85a97d-35f22e31ef8mr5836655f8f.69.1718097698392; 
 Tue, 11 Jun 2024 02:21:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f24d67093sm4830172f8f.96.2024.06.11.02.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:21:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0EFB65F898;
 Tue, 11 Jun 2024 10:21:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Marc-Andr =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
In-Reply-To: <6e7a14a1-8727-4ce5-ae67-797323704464@linaro.org> (Pierrick
 Bouvier's message of "Mon, 10 Jun 2024 14:38:18 -0700")
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org>
 <6e7a14a1-8727-4ce5-ae67-797323704464@linaro.org>
Date: Tue, 11 Jun 2024 10:21:37 +0100
Message-ID: <87o787zvfi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 6/10/24 13:29, Manos Pitsidianakis wrote:
>> On Mon, 10 Jun 2024 22:37, Pierrick Bouvier <pierrick.bouvier@linaro.org=
> wrote:
>>> Hello Manos,
>>>
<snip>
>>> Excellent work, and thanks for posting this RFC!
>>>
>>> IMHO, having patches 2 and 5 splitted is a bit confusing, and exposing
>>> (temporarily) the generated.rs file in patches is not a good move.
>>> Any reason you kept it this way?
>> That was my first approach, I will rework it on the second version.
>> The
>> generated code should not exist in committed code at all.
>> It was initally tricky setting up the dependency orders correctly,
>> so I
>> first committed it and then made it a dependency.
>>=20
>>>
>>> Maybe it could be better if build.rs file was *not* needed for new
>>> devices/folders, and could be abstracted as a detail of the python
>>> wrapper script instead of something that should be committed.
>> That'd mean you cannot work on the rust files with a LanguageServer,
>> you
>> cannot run cargo build or cargo check or cargo clippy, etc. That's why I
>> left the alternative choice of including a manually generated bindings
>> file (generated.rs.inc)
>>=20
>
> Maybe I missed something, but it seems like it just checks/copies the
> generated.rs file where it's expected. Definitely something that could
> be done as part of the rust build.
>
> Having to run the build before getting completion does not seem to be
> a huge compromise.
>
<snip>

As long as the Language Server can kick in after a first build. Rust
definitely leans in to the concept of the tooling helping you out while
coding.

I think for the C LSPs compile_commands.json is generated during the
configure step but I could be wrong.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


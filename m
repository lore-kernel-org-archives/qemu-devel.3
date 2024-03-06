Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29740C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnZX-0004fy-PJ; Wed, 06 Mar 2024 04:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhnZT-0004fk-Ce
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:28:19 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhnZR-0006VS-MH
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:28:19 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412e96284b9so13566295e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 01:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709717295; x=1710322095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PALZpD1wSov9R2F+mK8z5OozCmJTapsp7hCZ6MNQsgo=;
 b=c7to5+IK/uDPN5mLl/P1A+uW6c3lTc31q4i8X4XnRstJsdoymegpyIXsoMIQv9nDSv
 LBkm4q8Rej1/dlHda1H0JJl/U6kbcsCAQsjdsG2ksTJsEwauL60tPqT5qpICzccPsgJk
 VUHnDJGWaC/BN2xVbAILAQjXPUHqcWRmn0/59hrqWdie7l7HoxOm1DhBKvGL1vTj/F5x
 m6M0XFm2l2sUgyjLnXMw1BOlYNj7KFPqiqDVEQLjboPKmzzF3WKBvp2JzsZ+5t5KhT0s
 bmopaRX5WzdBeCh7Uskv3bzrggzoE5NJ+eGaqiHKX7HFo9PqNJEYtrhssFXcq+zymPWF
 UQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709717295; x=1710322095;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PALZpD1wSov9R2F+mK8z5OozCmJTapsp7hCZ6MNQsgo=;
 b=U87o7KyflKoD8yHIE06X0OCYytNhUW+LcPsZ5NiDAuTqlSmo+MoXOUyM5EDvaiQDPJ
 VOuH+UNPmY0S7/F+hHlB91N4S6y5s0xamm7KVJNeCSDn/D5td6NfEDn8z5bbVoTFOXS4
 /ezQHpZmpldfWdFr2Jm+N1Q4uhQMzvCTmgZC/93jHR27I/MF9YUC5fr8M8tyErnMnlmN
 F9PO1fyilNTlcUjL+IrbQLcc1ih0CV+fuL61ipH36nziq4sgn+JZrgoU2lG9FhN4IwL5
 4zmMDYBA4VNsZDid3c9U4m5JArq7Heuw1IpUunwhIDSAqkQXS9CAbYyjZ02cgJRXqmLK
 xGsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO7/zneehqxKd5fGRmPrGGpOz1mwQnu0BnxoNZ40KqTK1HfDCsV7404DZq04Ud+bC1agUWbS4V+u7lmOS6R6dRPOCnK1c=
X-Gm-Message-State: AOJu0YzvEFT/prunaZLgf2p81c2BE1xAPm/iuEc4oCGiXR8j8j+j3tOi
 pz+T5E+D+3r6Y8KVo/+tABF+BKmXQ8+arHGSbqrIAxba7Ec2PXnACpQ+gSmatDA=
X-Google-Smtp-Source: AGHT+IGHTFqeMrUmdPw5CTzB4sjFzIdc0ZnFYmEcyrnmkqrtUQbEufYIKmFU/ySH3gxgdq3XTG9Xhg==
X-Received: by 2002:a05:600c:1e11:b0:412:f668:a86 with SMTP id
 ay17-20020a05600c1e1100b00412f6680a86mr654594wmb.31.1709717295347; 
 Wed, 06 Mar 2024 01:28:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w13-20020a05600c474d00b00412c1d51a0dsm18840983wmo.45.2024.03.06.01.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 01:28:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B4F755F873;
 Wed,  6 Mar 2024 09:28:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paz Offer <poffer@nvidia.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: What is the correct way to add linker dependency to QEMU build
 system?
In-Reply-To: <MW4PR12MB69978FF0504C5B108E409656A0212@MW4PR12MB6997.namprd12.prod.outlook.com>
 (Paz Offer's message of "Wed, 6 Mar 2024 06:05:10 +0000")
References: <MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
 <CAFEAcA8S-uONJyR5nKh=HGQwKNUtT4VB+VYBh_dp3_3bjZfmfg@mail.gmail.com>
 <MW4PR12MB69978FF0504C5B108E409656A0212@MW4PR12MB6997.namprd12.prod.outlook.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Wed, 06 Mar 2024 09:28:14 +0000
Message-ID: <87r0gnvhe9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Paz Offer <poffer@nvidia.com> writes:

> ...after some testing...
> [Trying to add 'libdl' to be linked with QEMU]
>
> I did try to use 'g_module_open/close/symbol', but what I noticed is that=
 'g_module_close' did not really unload my library.
> So if I would do:
>
> 1 g_module_open(my-lib)
> 2 Load symbols, use my library...
> 3 g_module_close(my-lib)
> 4 Make modifications to my library and reload it:
> 5 g_module_open(my-lib)
>
> Then the library was not really reloaded, and the old instance would
> still be used.

Glib does do reference counting so it won't unload the module until all
references have been dropped. Did you check the return value from the
g_module_close()?


> This did not happen when I used dlopen/dlclose.
> Do we have a way to force 'g_module_close' to unload the library?

On POSIX the underlying mechanism is dlclose() anyway. You can also
check g_module_error() to see if there was an error unloading.

>
> Thanks, Paz
>
> -------------------------------------------------------------------------=
------------------------------------------------
> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Thursday, February 29, 2024 7:34 PM
> To: Paz Offer <poffer@nvidia.com>
> Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
> Subject: Re: What is the correct way to add linker dependency to QEMU bui=
ld system?=20
>=20=20
> External email: Use caution opening links or attachments
>
> On Thu, 29 Feb 2024 at 16:10, Paz Offer <poffer@nvidia.com> wrote:
>> I want to add library 'libdl' to be linked with QEMU build for a particu=
lar target (e.g. - qemu-system-arm).
>> Using meson I would typically do 'compiler.find_library(...)', and later=
 add the returned dependency to the binary
> dependencies list.
>> However, in QEMU I understand that these configurations are done in the =
'./configure' file?
>>
>> What would be the correct way to do this?
>
> If you can do the job using the glib g_module_open()/
> g_module_symbol() functions (which is how QEMU itself does
> loading of plugin and module DLLs, and which on Unix hosts
> are pretty much wrappers around dlopen/dlsym) then you
> don't need to link against libdl at all.
>
> If this is for something you're planning to upstream
> then it might be worth talking at a higher level about
> what you're aiming to do. (If it's for something downstream
> that you don't plan to ever upstream then you can do
> whatever's easiest for you, of course.)
>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


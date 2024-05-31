Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08511C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 14:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD3fc-0004AP-O0; Fri, 31 May 2024 10:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD3fa-0004A5-I3
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:55:50 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD3fY-0002yP-PL
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:55:50 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5785f7347cdso2260712a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717167347; x=1717772147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7qTkrlyFqLsZIKWsqI1/S8BIvT4I3VkGvQ3R78rmHvA=;
 b=iqznSeJqREBnPpvkFVlRb97XpveI6hZhWL+WHuX2Sjd2V/2zchRlRGoL8iQ8V8B3Hp
 kn1M1bmmE7BausSMrNNGNd1NCVgQko2h7ZjskIEEC+P1g6wkOGTO9VMymWWKcSW/98Ta
 tAPdGiLAaR5lRqwo1RIqRcNqMsm5jOgoRYsXD+ldSRDDhtIrsgyjSg1te88lyC4P2nGG
 hiMM95pc4yfs3ULJzH/MVBEurHqXuB9b3i4ul4+U6G7IuDEZPTG+aPouA5rbJSv2+tZj
 dX61hX5OJWk8Q+tRs6NWZBko0LeHTHEAOtH8tgKtgIsQJ1kkZ0dODY1+y3Zsu7LNnVDw
 N0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717167347; x=1717772147;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qTkrlyFqLsZIKWsqI1/S8BIvT4I3VkGvQ3R78rmHvA=;
 b=wuoS7ATJ5unYb+EXk7fUVmaDQyEavnvi9j3NXzdoA7XZU/4tytNEJlr8orLvFrJFQj
 O3gIKQs8c3+EX3hlwlpvgnlQwsIdpA9qP0zKYE8n+GUQliYyjT9mY+NaUrg8iTUvD/Xa
 kUf8Ixm/c2vxp4cPr5u+ponHp0gQ7dTii+5S22PCiGYG3T/hyMNZhv+n+uHNP+OEKiMB
 MkxGXD1oGcvRn9ybji3rY/OWsoXqX607UavWTUTKSEdL6zplDG5lngKmHjbYunRUNNQF
 KYaf4OHF5a1G7NpBqeZ/FC9ENNmdX9CUpEoNdzN/dsQd9U8bUmTF2xEPtX4sHNEEI0y2
 Ed8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOr7IlVi42uWjnEFszXk4yDXK8k4QSd6NJureBZSi8ECVS5hmIzse4b9EHks5W0VwHUDKB8wOwnn/Mae4AsfW0iRwMObc=
X-Gm-Message-State: AOJu0YwEuFxx7xNKda7J9oSDclrg0yX37Xb5vaV7Z+HRs6vKizILNVds
 1MtzfXVBJYdxJPY5Gda0SfX5MoVWJYxggWb1ZvOvZPJOXZ4jpvWAwjgsAOzSQ/U=
X-Google-Smtp-Source: AGHT+IESNbrNaY9B9DpN39wWrSG6I/br+BvKKrqWW85OttPvY2OJA19q5M9PiIc4AK4JKUDSCqUJdg==
X-Received: by 2002:a50:d74f:0:b0:578:5aef:23e3 with SMTP id
 4fb4d7f45d1cf-57a3643e755mr1567851a12.21.1717167346729; 
 Fri, 31 May 2024 07:55:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bb841fsm1111855a12.34.2024.05.31.07.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:55:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AD375F8A3;
 Fri, 31 May 2024 15:55:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,  Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
In-Reply-To: <ZlnCOrvpc2XGcxsh@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 31 May 2024 13:27:38 +0100")
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <ZlnCOrvpc2XGcxsh@redhat.com>
Date: Fri, 31 May 2024 15:55:45 +0100
Message-ID: <87sexyav4e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, May 27, 2024 at 04:14:15PM +0800, Zhao Liu wrote:
>> Hi maintainers and list,
>>=20
>> This RFC series attempts to re-implement simpletrace.py with Rust, which
>> is the 1st task of Paolo's GSoC 2024 proposal.
>>=20
>> There are two motivations for this work:
>> 1. This is an open chance to discuss how to integrate Rust into QEMU.
>
> I don't think this proposal really triggers that discussion to any
> great extent, because 'simpletrace.py' is not a part of the QEMU
> codebase in any meaningul way. It is a standalone python script
> that just happens to live in the qemu.git repository.
>
> The difficult questions around Rust integration will arise when we
> want to have Rust used to /replace/ some existing non-optional
> functionality. IOW, if Rust were to become a mandatory dep of QEMU
> that could not be avoided.

We hope to post some PoC device models in Rust soon with exactly that
debate in mind.

> In fact I kinda wonder whether this Rust simpletrace code could
> simply be its own git repo under gitlab.com/qemu-project/....,
> rather than put into the monolithic QEMU repo ? That just makes
> it a "normal" Rust project and no questions around integration
> with QEMU's traditional build system would arise.

Do we export the necessary bits for external projects to use? I don't
think we've had the equivalent of a qemu-devel package yet and doing so
start implying externally visible versioning and deprecation policies
for QEMU APIs and data formats.

TCG plugins have a header based API but currently everyone builds
against their local checkout and we are fairly liberal about bumping the
API versions.


>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


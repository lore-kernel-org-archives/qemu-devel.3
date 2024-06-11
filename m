Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1800DC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxec-0000yW-MB; Tue, 11 Jun 2024 05:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sGxea-0000xw-8l
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:18:56 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sGxeY-0005JW-E0
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:18:56 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52bbdc237f0so1122499e87.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 02:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718097531; x=1718702331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZN5KdxGdLRhcfzsdA/LZseSyqvlb2OAa3EGi3ttYIA4=;
 b=UKtgRjEVdGsEIOcnmaJQAYNy01eD/leKVA+sOwHu8Z/ELkcjiIbOiEA6h7vaSZwvXP
 1qPRpkdP80bwVwiPjvadsgHYmRpgds6Iee9KL1SgJnUFc0/Xl1iku47nC4tNjRpHCqCt
 2ZlkFyc+wIptiMuGqJPrQ/lF0acZ/0eyDQJ3WUIIb3BC3jg7L8h2sCjYpQNbrQMCrzeJ
 8C8dDQdIGR+DWOI1FguP6rBfcfi5uowj5NC8YfhO7wRqH+SkWvnab5nJwJMXQFyfH2kK
 1PfhbpGS23r/ePJoSUwXCAZ5LoplfJOYU51hU+7ZwFbdZp25hUrC74Ns70sSMTAynH6s
 7aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718097531; x=1718702331;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZN5KdxGdLRhcfzsdA/LZseSyqvlb2OAa3EGi3ttYIA4=;
 b=f0GVfxTtVOUfgLVSbjusD7Enq+ZeTUWbV+Bmd4H+n7qk9jj9BtPLWFqIEk4DHykHCg
 8YqmMRfx+Gj5zvJCPURN9ggRRgGOr6NWePgrf3xeeA8ydIbzPJPGVIbwH+9iVgs9VqeB
 UbFOr+2idzryn391UvTHH8rdkCH98kssT47kNdGAEhanYTrcJ2FxmgkRZxIe0uQzDmAz
 Ecvd/6Ta8UupEa4k+Cck5skWM9HoMh5YmY5VSiEFL4bpyCLFcAzt9s3H98zUSGoCp/Zr
 TukRnVHl2AWPRUj3F8//9mpFJm51u1ynhm1SPoNWToO7HwQcFDegfdbN+T2EQ1y9zBlA
 Lgzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSGVN6gWQ+wXN9CR1sNGY9uPWVr1LBicc8UMZFhqNYs5Jf6zfwSFQxzcRcp1g7hzosXPcIgX9c+YWjQaMYqEC2BTMfcbQ=
X-Gm-Message-State: AOJu0YzojTNflhpX/rcgLxGX162yi+R37iZbjxJV5uxEZIwbv55eJk53
 Ce7bHk8VUyqOfM45B6MzSMviME7bn4N+58OdkSaMW5XhCABEOaDkPqDHXNtnQuQ=
X-Google-Smtp-Source: AGHT+IGmfr7CrXyDOQ4a3d6UkcLM2bhFb1Biqe5OOH8+NsFa2o8SUOAfvSGIt6Ri/SG7GjKnUdhPFw==
X-Received: by 2002:a05:6512:104a:b0:52c:84a7:f9d5 with SMTP id
 2adb3069b0e04-52c84a7faaamr7234707e87.69.1718097530711; 
 Tue, 11 Jun 2024 02:18:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2c7396sm169963905e9.33.2024.06.11.02.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:18:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3524C5F898;
 Tue, 11 Jun 2024 10:18:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
In-Reply-To: <ZmgEiiyLbxVgjitc@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 11 Jun 2024 09:02:18 +0100")
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org> <ZmgEiiyLbxVgjitc@redhat.com>
Date: Tue, 11 Jun 2024 10:18:49 +0100
Message-ID: <87sexjzvk6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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

> On Mon, Jun 10, 2024 at 11:29:36PM +0300, Manos Pitsidianakis wrote:
>> On Mon, 10 Jun 2024 22:37, Pierrick Bouvier <pierrick.bouvier@linaro.org=
> wrote:
>> > > The staticlib artifact contains a bunch of mangled .o objects?
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > [staticlibmangledobjects] Back to [TOC]
>> > >=20
>> > > Yes, until we compile without the `std` module library or we compile=
 it
>> > > manually instead of linking it, we will have some junk in it.
>> > >=20
>> >=20
>> > Besides the size aspect, which potential advantage would there be to
>> > switch to no_std?
>> > We don't build a bare metal or kernel binary here, so why introduce th=
is
>> > restriction willingly?
>>=20
>> We'll see that as we progress. Might enable more platform support, for
>> example. I have no definite answers here. Also, I know binary bloat is a=
 big
>> complaint from people with dislike of Rust, so I pre-emptively addressed=
 it.
>
> Requiring 'no_std' would significantly limit what 3rd party crates QEMU
> can make use of, and thus would put more burden on QEMU maintainers.
> I don't find "binary bloat" a credible technical argument on its own
> either, so certainly not sufficient justification to take on the pain
> of 'no_std'.

no_std is great for OS's and micro controllers but I don't think its
something we have to worry about for QEMU. One potential area of
co-operation would be the rust-vmm libraries and they definitely take
advantage of the stdlibs.

>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


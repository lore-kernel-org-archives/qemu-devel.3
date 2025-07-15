Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ECEC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiiN-0003gR-FX; Tue, 15 Jul 2025 12:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.nzdo93pfqcqfkd6=h9pahmoofkg0=g5ixvt3c6anda0@em483429.getutm.app>)
 id 1ubiCk-0004to-6M
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:08:30 -0400
Received: from a3i638.smtp2go.com ([203.31.38.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.nzdo93pfqcqfkd6=h9pahmoofkg0=g5ixvt3c6anda0@em483429.getutm.app>)
 id 1ubiCh-0002eP-Lm
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752594799; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=HN4AOMwg99rrNE4j5uAvRZY/J+MS1iO7572Vei2UTh8=;
 b=Auo45qvsMJewnXwvKta6ZWRks8lwINyflBIzBbxVgDqXherz1itkYvN8TxVdiAdxggwKu
 mMQfYbRETcytmd5rcAabG5rgIxbifao6Zr9r6cmRmMLnRV0gdqJ6g+yUKy5OylldtePAIIj
 /4waSXgj8210MvzCBXCIyUUPvyaYXReo/s+2zHzRmTk6xrjOAN6n0OQBKkv83JNiJ9u+zBy
 1YFFzPU5557+OJvZamZoH1s8FMry1uH3jwXFbObpbUQ0FSxknTXZrhKIBel65CJngpC0reQ
 oZ3NLj1IuTGN+gvIUD/Ybz37RPLMFDPQmG68sqT2gNyxOvefW8APr35BYFDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1752594799; h=from : subject :
 to : message-id : date;
 bh=HN4AOMwg99rrNE4j5uAvRZY/J+MS1iO7572Vei2UTh8=;
 b=dwR+U3/9MwDso8e+lsL0/7CVfHn0k0A9gJ6vcGXikcdgV20LiAjt27ZOZQHECWWW8JKfZ
 GW2qsQL3MJhD4LtWyXv/wT3+gA/BAnnO6iS+oaBe6NymtPfB5nvlrSv+QElV6tFoG22P/Nv
 u0f/rM6aIvqDaxe5NMkVFS9nysIeekPqHCHQMR6lI9MUEaJkXD5glYiwst5oN63GCke+sz9
 zFRtAtlMX2rvMHAFp11xmqcuBCSqofg7+wH7UTYY92vgoipY+FDTsjMgGvsfvF3k0Ll/Iii
 4Y2pccSc49z/97CaKnDkBUdk5ohQsnusiX7sULgDImlDoyns9N4PeiQBRayw==
Received: from [10.159.238.187] (helo=mail-ej1-f49.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1ubhy1-4o5NDgrgsRZ-uqVC for qemu-devel@nongnu.org;
 Tue, 15 Jul 2025 15:53:17 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-ae0d758c3a2so883747166b.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 08:53:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVA8ZZouZ33WGm3UtnnO+lS/wHNtTiyDZmSdzCAITBw4e9pltVS8Ojy++cH90uBGJXVbHGxM2vc/kGd@nongnu.org
X-Gm-Message-State: AOJu0Yz/D7FgoQGuuDWROdimGqBQXB8s3JFtvOhLOiYJxUA7xo7NMp0+
 z25bHJJ/pIcp79ql3BA6h9EjnQAtURBuQGSgVbe+J47P1S0ikyMT4+XbMCNuv9hgOMsmlpR6m80
 tg1QE6zsJbG1PLG8xKWd2s9b+HAwLOJI=
X-Google-Smtp-Source: AGHT+IHNNB4Sny3KHEdKkluwGwlW9Ttf6YK8G2IasdsnikL8APN3BRv6jfKm+9sftw1RO43v6LAzhnvWxis7+0iaCEU=
X-Received: by 2002:a17:907:7287:b0:ae3:f2a0:459f with SMTP id
 a640c23a62f3a-ae7012f1b48mr1712186666b.54.1752594796124; Tue, 15 Jul 2025
 08:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <87zfd5zouv.fsf@draig.linaro.org> <86wm898yf4.wl-maz@kernel.org>
In-Reply-To: <86wm898yf4.wl-maz@kernel.org>
From: Joelle van Dyne <j@getutm.app>
Date: Tue, 15 Jul 2025 08:53:03 -0700
X-Gmail-Original-Message-ID: <CA+E+eSASz9Tx76-8PxMNF30f3L9DfPNYf_Zgf=ENozXapc3gyw@mail.gmail.com>
X-Gm-Features: Ac12FXwMc4dV-yiQMMCGZ-YNKyxAfTFfwiOdHWlz-hJ1uZAjHvRv-AlgyTBf0Mc
Message-ID: <CA+E+eSASz9Tx76-8PxMNF30f3L9DfPNYf_Zgf=ENozXapc3gyw@mail.gmail.com>
Subject: Re: HVF EL2 support in QEMU (aka FEAT_NV/FEAT_NV2) for MacOS
To: Marc Zyngier <maz@kernel.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@csgraf.de>,
 Ynddal <mads@ynddal.dk>, 
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Burton <mburton@qti.qualcomm.com>, Joelle van Dyne <j@getutm.app>, 
 Danny Canter <danny_canter@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429spy4xxNeMg
X-smtpcorp-track: iKQJTVH7fqHA.j5_mAIxECu0p.uW5r1g9YpfC
Received-SPF: pass client-ip=203.31.38.126;
 envelope-from=bounce.nzdo93pfqcqfkd6=h9pahmoofkg0=g5ixvt3c6anda0@em483429.getutm.app;
 helo=a3i638.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

UTM currently supports NV only with the Apple Virtualization backend,
not QEMU HVF. While M2 supports NV, it is not enabled by XNU kernel
and `hv_vm_config_get_el2_supported` returns false. I heard there was
some compatibility issue in the hardware. M3 and newer generations
fully support NV in hardware and by XNU.

On Tue, Jul 15, 2025 at 4:51=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Tue, 15 Jul 2025 12:15:52 +0100,
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> >   - do we know which Apple silicon supports FEAT_NV2?
>
> M2 and latter definitely support FEAT_NV2. That's how KVM NV support
> has been developed for two years until I was given better HW.
>
> Whether Apple supports NV on M2 in HVF, I have no idea. The rumour
> mill says "no", but I don't have a way to check. The M3 I use at $WORK
> is definitely able to give me EL2 without VHE with UTM. I haven't
> played with M4, but I have it on the record that it behaves like M3
> with UTM.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.


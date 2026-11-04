Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB1606A32D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=StO2NSPF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zw307Uqr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOUoC-00014y-G1; Wed, 04 Nov 2026 01:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xOUoA-00014G-Lq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 01:49:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xOUo9-0002rO-AD
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 01:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793774955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwJzUsJ3QPjsEzmyy1ZgS7781kS5066RCde09YWteg4=;
 b=StO2NSPF9JfjBwbvAxy+HlMgwrDJZxxrnCW8K8xf02ri3t6O1XdcRc1vn/vQnylOyb0imi
 /4m7A2tO1GUWqbk85HkF6qpSkobdd/I5Vm+PKYa+NImx4Bg8TRWNgJJlL3sy01HlGRHJLC
 XrPDXckxdOdUA7A4g0x1CpDW2VwwU+4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-tiottUChOHSc5aYws2VbDQ-1; Wed, 04 Nov 2026 01:49:14 -0500
X-MC-Unique: tiottUChOHSc5aYws2VbDQ-1
X-Mimecast-MFC-AGG-ID: tiottUChOHSc5aYws2VbDQ_1793774953
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ae6fda7a00so484920a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 22:49:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793774953; cv=none;
 d=google.com; s=arc-20260327;
 b=DFW0YSHf2+xvpX6Dd4tgkLaqcbADqaAqiPpe7g6ABDgHUZaJAwYTgAPhQfE9+jZRbi
 UaG9LcEs3R/CI6nu63/l/OySNZ9xU9g4phjHWyxZPAK6c77pkzH3mLCCrUzg7IgwtCzB
 skiMuaEcbntnNtE3dLpM6Ra/3gdENAo6pn0zLITuhDh58MWi6Lv/vvrC1I6tnebS8PWL
 4BV9UTJXShW62tr7qY/DnOthBPUcPIOCfS+QjPlpYHNxrBMB8F1C9YSUrC8CmmVL6HtI
 IWIkrcUGDILODHI0BUBw8GoyDbqiGgdBFHDk4xLedmGlU2XOblSYxkc+yYtN9uWG9hDk
 7Vkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gwJzUsJ3QPjsEzmyy1ZgS7781kS5066RCde09YWteg4=;
 fh=sA4msBGIAz1y+AMJdFM17Tv1Fcna27mA5MaHipB6nh0=;
 b=oTNmFFN7yNiYI859UFu13iAbx34M2UDIunZ9G4bfQ41voqG0QYZNMs1FblRrRgLF4s
 xVXQVVaHY78ogvRriKogiUMchAL4wCOYqtvQYgRUrkaUYQrpB3dUP8pO3a0/0G1Pthab
 Jri2Lkg6Fce3PPpYF9IaepPUiBe3BdA0X3CwiwtSYlxxLUw6ihwpn83CcLgxwjlF4h1u
 0VwO3sFZbn6FahL6JJ+Wd+zatllPaA4JYXuEB0Akx16b4ROKIVBeXuf0lqj1RQIMQdbb
 NQ0WiFhkC3wJ+wPs1F8IG6VQBJWb4SJvlrE23m/9yRzPH7xiIVt7sA6cQ/4xCLgAk1Mm
 RZGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793774953; x=1794379753; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gwJzUsJ3QPjsEzmyy1ZgS7781kS5066RCde09YWteg4=;
 b=Zw307Uqr29AXPNYyfZnT2j8968ewqTSoe+qNQ+DPM5zNnxkbzYjXTLOcqwCyx9jtaF
 JRmhR5cyYsrSQDMlb80tJrLQvV/HkvKDSpbB27cYoGEe/KpZ7o7N0Y9RAMDSx+dBJItM
 qMRwoKV5rHalC4UbCEBNomQn3CBd3BuWucEFAwlCghPZZD1T7chUcI9otGuBolp9L6Ng
 mbXxS6LWg3oX+TbZ3Ex3O/t4tScMpSlkEQuLA/nRMqk8C2AwUjzdiAwO3cZH6dtnwr40
 nElsbrmwF67qyfvEE4b+3gJQbqnd1+C7QVD0db6Z9KNi53zWn7FVbGpomXT4QALQ8gaq
 ypBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793774953; x=1794379753;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gwJzUsJ3QPjsEzmyy1ZgS7781kS5066RCde09YWteg4=;
 b=oVmtspVysCeuvns1ZrOXxemHNItcaDs1KS1z2Qpm2OrYOLxWZM82vCE93D4cL0PX25
 Ne88V/6bPCRIJEbBJRCVvxw7BU7ntErrt5AOzmUNDrOuuAX0LGNxz6US9fTfq4A23DeN
 wfySA2HqfuSxyS44YlUodBksrDc5NaFaLG+ADCtSyKM0f8Y0Sh/ODWoYIVcMfAZZd8EC
 ixmA44tC2UhYRxkbcPsU/0lpIIsogGy7yFKz+n018uUEJi8w4SDpn20sRg2fsQcy9Pnt
 vUjLslDI6aDnyRRg2VneLjnrtJaWpaSLiPqX4jcS9CmEbsEDmgS7ZOO5LoTSzrZCRw8u
 XjxQ==
X-Gm-Message-State: APuU4Z+dN6j6xv8O+40M8oosJAr4jGyiZZrhZOAfHSxfglCiqyMi+BFm
 p9xC0pYgQzOpXQRc6TLZ9IG5JfZzX1BwjR04z8tL5sFfQRl0oGRANpXG+5cAUUQaIs4SidsBTgH
 W/rSumnNGjOdRvoWG5BxP+PsCYrS3bkYsev3nRFLBevJgqkeMNr8Ix4cxuP095jDsQOh95KblLM
 bn74YuD1a8w/Y1K5GGeYjpwXX2reuZoss=
X-Gm-Gg: AYBFou2Rv3xz7S2JsTycsFtkokx4TW9ppGioGlmAofhqUp0gesQvS6hDlG8xOXrjM5k
 4xF5i90SnGV/UZBZTTx8XKzT+5Wh5Awy2snQAn/8gBXE7v0HymkKdR30uNPdA5ujKWp30mCBz1X
 P7OnpR2r0nQjGvD8FOQhjw7L0+T4RcuXSJe6cRkc1c/kA/rq/nIYohHixu0wW0E4uRyIezkzn8F
 Im+9P7h3Lns06SlH407COBmyjAQ/PS57VQx4+mqi79yiBEbM703/6nQnEz29bJdN8UH1ZS50ibH
 bg==
X-Received: by 2002:a17:90b:1c87:b0:3a8:195f:186 with SMTP id
 98e67ed59e1d1-3ae897ee656mr11491917a91.42.1793774953253; 
 Tue, 03 Nov 2026 22:49:13 -0800 (PST)
X-Received: by 2002:a17:90b:1c87:b0:3a8:195f:186 with SMTP id
 98e67ed59e1d1-3ae897ee656mr11491900a91.42.1793774952714; Tue, 03 Nov 2026
 22:49:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104064552.959862-1-armbru@redhat.com>
In-Reply-To: <20261104064552.959862-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Nov 2026 10:49:00 +0400
X-Gm-Features: AclHuK9EVAJpRvnsMFITX85Qwp0kaeJKLiP1vOhhg6X9NUdidUcCWW2YlzDSWx4
Message-ID: <CAMxuvazeBBja=n5htpB7kRn0QtMjjLhTLnAwbt+L4Xa2M7-AbA@mail.gmail.com>
Subject: Re: [PATCH 0/4] qom/qdev: associate properties with QAPI types fixups
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, 
 milesg@linux.ibm.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 10:46=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 missed one property, I lost two in my butchering of his
> work, and we both missed alias class properties.  Not too bad for such
> a big series, I think.
>
> Markus Armbruster (4):
>   target/riscv: Fix up PropertyInfo to set @qapi_type
>   hw/gpio/pca9552: Fix @type of pca9552 property led<N>
>   hw: Fix up PropertyInfo to set @qapi_type
>   qom: Convert alias properties to QAPI-aware registration

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
>  hw/gpio/pca9552.c  | 5 +++--
>  hw/gpio/pca9554.c  | 5 +++--
>  qom/object.c       | 7 ++++---
>  target/riscv/cpu.c | 1 +
>  4 files changed, 11 insertions(+), 7 deletions(-)
>
> --
> 2.55.0
>



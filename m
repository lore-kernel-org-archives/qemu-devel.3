Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51519C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJJa-000552-KM; Thu, 20 Jun 2024 11:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKJJY-00050r-80
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKJJW-0004ba-Nn
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718895781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFN4XwyER/PGFhtd2vEfPDpnGz5x3/GkLmQ/mVcfgJU=;
 b=Jd50b9fG58aS2meEqvr0ZImhT5uYM8jhNZV/Pmg2MaDsa6SOCRQxkSASfkP26hWlOkUbDV
 5ppcf5A/3e+QojMQtEI43oSe38oIAT4DP9LRgiLc8XPnD1ZT8V6D/PtjtM7Gia5+Ctdk3L
 KcXsDyQGlMCjMGLR8++kK2aCz5e4iTE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-BVk3SocbPbaRdyNjAIWknw-1; Thu, 20 Jun 2024 11:02:57 -0400
X-MC-Unique: BVk3SocbPbaRdyNjAIWknw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-363740a6f5fso463721f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718895776; x=1719500576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFN4XwyER/PGFhtd2vEfPDpnGz5x3/GkLmQ/mVcfgJU=;
 b=f3Q4NaBFsiw5QEJcbbgTO3WSs0e3bjvomvFRVsvMTuirJzebj8zKD0QfkRqjokt0k9
 fHM3WXUWR90yFKmolkt47aIYOzbQ6RACN8PoaID88e3nFmxoMrb1kKLt6zg7BQGFC3Ur
 BCMEscpnNwuGRUBZ0c6ouuOpSGpFUEblceiehRwVcdNsugRIaMxBT7bM9K1nhlxTYbHS
 ZTA1gnFu4sO/HzUBdM4j6EB87dSO6G2G5BOr3zM01a48CNEgB2HmmtkRhGV3+iicbruS
 sleOS+MBcNwLGyFMU7D07NgI8oiqPyc/e3LBEYUSyOXVVok8GB2XQFSCCkyk+G+UisQh
 jRzQ==
X-Gm-Message-State: AOJu0YyCCWLPqYinR25z+PICzol5hvb/vvAiDy13DLUtO3FGe/l04QMM
 8zZZXmgGSk50plvQdm6qbHomDZ+a9f8vxvwysQ31xNcXJZMyjJU/hP5P4eQltSxbK4IPy61z6Js
 kQ3+TnQJkn4Vb3tdr9FAOKiczuBriYwBV9nMGqAdR3u8V2tcVvzfbBt5B5LJZew4iGYPxbGvVVR
 nl2DICtEcsRKsRMeLo6TdM277YSFg=
X-Received: by 2002:a5d:58f5:0:b0:360:7dbf:d3f with SMTP id
 ffacd0b85a97d-363193c4f41mr3988641f8f.56.1718895776478; 
 Thu, 20 Jun 2024 08:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbeoN8Ia/3C7bJinjFFJ9HEjY/TkLSt4DKoBjkL6CJarOyw5gCoiRwDQ1nn96wxrN4ybl2/hHDoXVlWKAn85c=
X-Received: by 2002:a5d:58f5:0:b0:360:7dbf:d3f with SMTP id
 ffacd0b85a97d-363193c4f41mr3988621f8f.56.1718895776111; Thu, 20 Jun 2024
 08:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240620130254.415699-1-pbonzini@redhat.com>
 <20240620130254.415699-5-pbonzini@redhat.com>
 <ZnRC2cVcDSlKs72d@redhat.com>
In-Reply-To: <ZnRC2cVcDSlKs72d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Jun 2024 17:02:40 +0200
Message-ID: <CABgObfZ4sdXkC9Bf6jj5vwraE2_Nd_kfg6WVoiTGs4qnTdJppg@mail.gmail.com>
Subject: Re: [PATCH 4/6] meson: allow configuring the x86-64 baseline
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, amonakov@ispras.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 20, 2024 at 4:55=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> Any particular reason you chose to list various instructions individually
> rather than just ask GCC for the full ABI ? I'd think all of the above
> condences down to just

To avoid that the default ('1') forces a lower level than the compiler defa=
ult.

Something like what you propose below could work by adding a 'default'
value to the x86_version option, that leaves the flags entirely alone
apart from -mcx16.

However, doing so would prevent QEMU from changing the default to
x86-64-v2 in meson_options.txt, because then even a compiler that
defaults to x86-64-v3 would build a QEMU with AVX2 disabled.

For AVX2 specifically this is not a huge deal because the decision to
use AVX2 code is mostly done at runtime; but it would be a problem for
future integer instruction set extensions---for example if the distro
compiler uses APX you don't want to disable it.

>   # add flags for individual instruction set extensions
>   if get_option('x86_version') >=3D '1'
>     if host_arch =3D=3D 'i386'
>       qemu_common_flags =3D ['-mfpmath=3Dsse'] + qemu_common_flags

Also -msse2 here, but yes.

Paolo



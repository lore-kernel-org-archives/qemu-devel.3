Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AB8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 18:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzKXj-0001GM-Kl; Tue, 23 Apr 2024 14:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzKXi-0001Fj-Pp
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzKXg-0001Ou-Dd
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713895615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5y8/YDz6yRy8nFqwkSlU52z1dwsEprXhj78RPn6+MB0=;
 b=UxPmm0u3DzoM+rN+isa2l9p3yj1CFlmRPpNbI32H1Y863RAVD8MN5509tp0UbRlTo38pmH
 sfymh/d5pftIyBi7kt3KjqvNftwvXQZ0ExU8F6Oy4w04RFTnqXfHF8y/ZFrzjC7/lrlllX
 elhC0vld1oXil2EBKTGUSoZ/54sRft8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-2wF-ZVyLO1GVzV4fhgjsSg-1; Tue, 23 Apr 2024 14:06:52 -0400
X-MC-Unique: 2wF-ZVyLO1GVzV4fhgjsSg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343c6bb1f21so3739016f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 11:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713895611; x=1714500411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5y8/YDz6yRy8nFqwkSlU52z1dwsEprXhj78RPn6+MB0=;
 b=TjDuIVOhS2kGSphWepluQ2APRGE4JydTKqkFYU7XOmRRn1gMDjV8b+5ABsiVZY6Ec0
 APjE0YP4Do0Dq+EjgOzOrRubPfF21LFjS/GfbaCbRHHXf15UHGlLacCcok+2qJSvCswe
 z0fK6zJiFf5G9T/+AnktDBlacmVasxhExm9HYQukk0qcZ3vZE9Jxvl6SuJSRR8diaH/5
 hDMEV77khHT9t7XEu2vgHJr88qwTeuQMCY26IeDVVg+5QBtG/L/Q98Cg83+mJErLihm2
 /tUAL9rTuMm7LyJo8neW98//JMVWwGJ/jXS2U3Zj4/tGHsHZB7ghLLvreh2SRWLEe+b1
 PIyg==
X-Gm-Message-State: AOJu0YxhyWHylBIgz3WfBUcXP/JlRvtErSIIDneDeqJVEMgD/MKkr44L
 +oITXX3Zc0hAkEbQdYrjk2VPD0/M+knP0v+i3mKBfyFoKjjbCNACEZaPeJqR2qY76cPlIacteyD
 bggY5Taf81oqEp1866vMfcMs6yI2PiWPVOAIcIMYAvksgN/TtPK8eCIB3rmhG2dkgHksk1g8pOJ
 L6a7vu+bgrBuLbs/ZJdUj5neAh9yI=
X-Received: by 2002:a5d:60c8:0:b0:347:d352:d5c2 with SMTP id
 x8-20020a5d60c8000000b00347d352d5c2mr4651wrt.13.1713895611311; 
 Tue, 23 Apr 2024 11:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWK6u0ATo1xlqWU2VypwUxZAn8DWYiP0/V8FTI10M7rFLZCfFopPWQnQs66xG3coLX6QQnrTVKi/KhzhP4LN4=
X-Received: by 2002:a5d:60c8:0:b0:347:d352:d5c2 with SMTP id
 x8-20020a5d60c8000000b00347d352d5c2mr4631wrt.13.1713895610860; Tue, 23 Apr
 2024 11:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <87o7a0hshr.fsf@suse.de>
In-Reply-To: <87o7a0hshr.fsf@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 Apr 2024 20:06:39 +0200
Message-ID: <CABgObfZ7puQEo5pbf3YXTsxQyhcgjLa-A-x85XLfWdY01+FBaQ@mail.gmail.com>
Subject: Re: [PATCH 00/22] configs: switch boards to "default y"
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001164030616c76bcb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000001164030616c76bcb
Content-Type: text/plain; charset="UTF-8"

Il mar 23 apr 2024, 19:57 Fabiano Rosas <farosas@suse.de> ha scritto:

> > There is an important difference in that Kconfig symbols for boards
> > have to be enabled in a --without-default-devices build, similar to
> > devices.
>
> And how do we make that happen?
>

Before building you edit configs/devices/ to set e.g. CONFIG_ARM_VIRT=y,
just like you did in order to enable devices.

Paolo


> >
> > Paolo
> >
> > Paolo Bonzini (22):
> >   configs: list "implied" device groups in the default configs
> >   alpha: switch boards to "default y"
> >   arm: switch boards to "default y"
> >   avr: switch boards to "default y"
> >   cris: switch boards to "default y"
> >   hppa: switch boards to "default y"
> >   i386: switch boards to "default y"
> >   loongarch: switch boards to "default y"
> >   m68k: switch boards to "default y"
> >   microblaze: switch boards to "default y"
> >   meson: make target endianneess available to Kconfig
> >   mips: switch boards to "default y"
> >   nios2: switch boards to "default y"
> >   openrisc: switch boards to "default y"
> >   ppc: switch boards to "default y"
> >   riscv: switch boards to "default y"
> >   rx: switch boards to "default y"
> >   s390x: switch boards to "default y"
> >   sh4: switch boards to "default y"
> >   sparc: switch boards to "default y"
> >   tricore: switch boards to "default y"
> >   xtensa: switch boards to "default y"
> >
> >  configs/devices/alpha-softmmu/default.mak     |  5 ++--
> >  configs/devices/arm-softmmu/default.mak       |  5 +++-
> >  configs/devices/avr-softmmu/default.mak       |  5 ++--
> >  configs/devices/cris-softmmu/default.mak      |  5 ++--
> >  configs/devices/hppa-softmmu/default.mak      |  5 ++--
> >  configs/devices/i386-softmmu/default.mak      | 11 ++++---
> >  .../devices/loongarch64-softmmu/default.mak   |  6 +++-
> >  configs/devices/m68k-softmmu/default.mak      | 13 ++++----
> >  .../devices/microblaze-softmmu/default.mak    |  9 +++---
> >  configs/devices/mips-softmmu/common.mak       |  5 ++--
> >  configs/devices/mips64-softmmu/default.mak    |  4 ++-
> >  configs/devices/mips64el-softmmu/default.mak  | 10 ++++---
> >  configs/devices/nios2-softmmu/default.mak     |  7 ++---
> >  configs/devices/or1k-softmmu/default.mak      |  9 ++++--
> >  configs/devices/ppc-softmmu/default.mak       | 30 +++++++++++--------
> >  configs/devices/ppc64-softmmu/default.mak     |  8 ++---
> >  configs/devices/riscv32-softmmu/default.mak   | 17 +++++------
> >  configs/devices/riscv64-softmmu/default.mak   | 19 ++++++------
> >  configs/devices/rx-softmmu/default.mak        |  3 +-
> >  configs/devices/s390x-softmmu/default.mak     |  5 ++--
> >  configs/devices/sh4-softmmu/default.mak       |  7 ++---
> >  configs/devices/sparc-softmmu/default.mak     |  7 ++---
> >  configs/devices/sparc64-softmmu/default.mak   |  7 ++---
> >  configs/devices/tricore-softmmu/default.mak   |  7 +++--
> >  configs/devices/xtensa-softmmu/default.mak    | 11 ++++---
> >  meson.build                                   | 12 ++++----
> >  hw/alpha/Kconfig                              |  2 ++
> >  hw/arm/Kconfig                                |  2 ++
> >  hw/avr/Kconfig                                |  3 ++
> >  hw/cris/Kconfig                               |  2 ++
> >  hw/hppa/Kconfig                               |  2 ++
> >  hw/i386/Kconfig                               | 10 ++++++-
> >  hw/loongarch/Kconfig                          |  2 ++
> >  hw/m68k/Kconfig                               | 10 +++++++
> >  hw/microblaze/Kconfig                         |  6 ++++
> >  hw/mips/Kconfig                               | 12 ++++++++
> >  hw/nios2/Kconfig                              |  9 +++---
> >  hw/openrisc/Kconfig                           |  4 +++
> >  hw/ppc/Kconfig                                | 26 ++++++++++++++++
> >  hw/riscv/Kconfig                              | 14 +++++++++
> >  hw/rx/Kconfig                                 |  2 ++
> >  hw/s390x/Kconfig                              |  2 ++
> >  hw/sh4/Kconfig                                |  4 +++
> >  hw/sparc/Kconfig                              |  4 +++
> >  hw/sparc64/Kconfig                            |  4 +++
> >  hw/tricore/Kconfig                            |  4 +++
> >  hw/xtensa/Kconfig                             |  6 ++++
> >  target/Kconfig                                |  3 ++
> >  target/i386/Kconfig                           |  1 +
> >  target/ppc/Kconfig                            |  1 +
> >  50 files changed, 252 insertions(+), 115 deletions(-)
>
>

--0000000000001164030616c76bcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRp
diBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPklsIG1hciAyMyBhcHIgMjAyNCwgMTk6NTcg
RmFiaWFubyBSb3NhcyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmZhcm9zYXNAc3VzZS5kZSI+ZmFyb3Nh
c0BzdXNlLmRlPC9hPiZndDsgaGEgc2NyaXR0bzo8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBz
b2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCiZndDsgVGhlcmUgaXMgYW4gaW1wb3J0YW50IGRpZmZl
cmVuY2UgaW4gdGhhdCBLY29uZmlnIHN5bWJvbHMgZm9yIGJvYXJkczxicj4NCiZndDsgaGF2ZSB0
byBiZSBlbmFibGVkIGluIGEgLS13aXRob3V0LWRlZmF1bHQtZGV2aWNlcyBidWlsZCwgc2ltaWxh
ciB0bzxicj4NCiZndDsgZGV2aWNlcy48YnI+DQo8YnI+DQpBbmQgaG93IGRvIHdlIG1ha2UgdGhh
dCBoYXBwZW4/PGJyPjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+PGJy
PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5CZWZvcmUgYnVpbGRpbmcgeW91IGVkaXQgY29uZmlncy9k
ZXZpY2VzLyB0byBzZXQgZS5nLiBDT05GSUdfQVJNX1ZJUlQ9eSwganVzdCBsaWtlIHlvdSBkaWQg
aW4gb3JkZXIgdG8gZW5hYmxlIGRldmljZXMuPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rp
dj48ZGl2IGRpcj0iYXV0byI+UGFvbG/CoDwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+
PGRpdiBkaXI9ImF1dG8iPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHgg
I2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4NCjxicj4NCiZndDs8YnI+DQomZ3Q7IFBhb2xv
PGJyPg0KJmd0Ozxicj4NCiZndDsgUGFvbG8gQm9uemluaSAoMjIpOjxicj4NCiZndDvCoCDCoGNv
bmZpZ3M6IGxpc3QgJnF1b3Q7aW1wbGllZCZxdW90OyBkZXZpY2UgZ3JvdXBzIGluIHRoZSBkZWZh
dWx0IGNvbmZpZ3M8YnI+DQomZ3Q7wqAgwqBhbHBoYTogc3dpdGNoIGJvYXJkcyB0byAmcXVvdDtk
ZWZhdWx0IHkmcXVvdDs8YnI+DQomZ3Q7wqAgwqBhcm06IHN3aXRjaCBib2FyZHMgdG8gJnF1b3Q7
ZGVmYXVsdCB5JnF1b3Q7PGJyPg0KJmd0O8KgIMKgYXZyOiBzd2l0Y2ggYm9hcmRzIHRvICZxdW90
O2RlZmF1bHQgeSZxdW90Ozxicj4NCiZndDvCoCDCoGNyaXM6IHN3aXRjaCBib2FyZHMgdG8gJnF1
b3Q7ZGVmYXVsdCB5JnF1b3Q7PGJyPg0KJmd0O8KgIMKgaHBwYTogc3dpdGNoIGJvYXJkcyB0byAm
cXVvdDtkZWZhdWx0IHkmcXVvdDs8YnI+DQomZ3Q7wqAgwqBpMzg2OiBzd2l0Y2ggYm9hcmRzIHRv
ICZxdW90O2RlZmF1bHQgeSZxdW90Ozxicj4NCiZndDvCoCDCoGxvb25nYXJjaDogc3dpdGNoIGJv
YXJkcyB0byAmcXVvdDtkZWZhdWx0IHkmcXVvdDs8YnI+DQomZ3Q7wqAgwqBtNjhrOiBzd2l0Y2gg
Ym9hcmRzIHRvICZxdW90O2RlZmF1bHQgeSZxdW90Ozxicj4NCiZndDvCoCDCoG1pY3JvYmxhemU6
IHN3aXRjaCBib2FyZHMgdG8gJnF1b3Q7ZGVmYXVsdCB5JnF1b3Q7PGJyPg0KJmd0O8KgIMKgbWVz
b246IG1ha2UgdGFyZ2V0IGVuZGlhbm5lZXNzIGF2YWlsYWJsZSB0byBLY29uZmlnPGJyPg0KJmd0
O8KgIMKgbWlwczogc3dpdGNoIGJvYXJkcyB0byAmcXVvdDtkZWZhdWx0IHkmcXVvdDs8YnI+DQom
Z3Q7wqAgwqBuaW9zMjogc3dpdGNoIGJvYXJkcyB0byAmcXVvdDtkZWZhdWx0IHkmcXVvdDs8YnI+
DQomZ3Q7wqAgwqBvcGVucmlzYzogc3dpdGNoIGJvYXJkcyB0byAmcXVvdDtkZWZhdWx0IHkmcXVv
dDs8YnI+DQomZ3Q7wqAgwqBwcGM6IHN3aXRjaCBib2FyZHMgdG8gJnF1b3Q7ZGVmYXVsdCB5JnF1
b3Q7PGJyPg0KJmd0O8KgIMKgcmlzY3Y6IHN3aXRjaCBib2FyZHMgdG8gJnF1b3Q7ZGVmYXVsdCB5
JnF1b3Q7PGJyPg0KJmd0O8KgIMKgcng6IHN3aXRjaCBib2FyZHMgdG8gJnF1b3Q7ZGVmYXVsdCB5
JnF1b3Q7PGJyPg0KJmd0O8KgIMKgczM5MHg6IHN3aXRjaCBib2FyZHMgdG8gJnF1b3Q7ZGVmYXVs
dCB5JnF1b3Q7PGJyPg0KJmd0O8KgIMKgc2g0OiBzd2l0Y2ggYm9hcmRzIHRvICZxdW90O2RlZmF1
bHQgeSZxdW90Ozxicj4NCiZndDvCoCDCoHNwYXJjOiBzd2l0Y2ggYm9hcmRzIHRvICZxdW90O2Rl
ZmF1bHQgeSZxdW90Ozxicj4NCiZndDvCoCDCoHRyaWNvcmU6IHN3aXRjaCBib2FyZHMgdG8gJnF1
b3Q7ZGVmYXVsdCB5JnF1b3Q7PGJyPg0KJmd0O8KgIMKgeHRlbnNhOiBzd2l0Y2ggYm9hcmRzIHRv
ICZxdW90O2RlZmF1bHQgeSZxdW90Ozxicj4NCiZndDs8YnI+DQomZ3Q7wqAgY29uZmlncy9kZXZp
Y2VzL2FscGhhLXNvZnRtbXUvZGVmYXVsdC5tYWvCoCDCoCDCoHzCoCA1ICsrLS08YnI+DQomZ3Q7
wqAgY29uZmlncy9kZXZpY2VzL2FybS1zb2Z0bW11L2RlZmF1bHQubWFrwqAgwqAgwqAgwqB8wqAg
NSArKystPGJyPg0KJmd0O8KgIGNvbmZpZ3MvZGV2aWNlcy9hdnItc29mdG1tdS9kZWZhdWx0Lm1h
a8KgIMKgIMKgIMKgfMKgIDUgKystLTxicj4NCiZndDvCoCBjb25maWdzL2RldmljZXMvY3Jpcy1z
b2Z0bW11L2RlZmF1bHQubWFrwqAgwqAgwqAgfMKgIDUgKystLTxicj4NCiZndDvCoCBjb25maWdz
L2RldmljZXMvaHBwYS1zb2Z0bW11L2RlZmF1bHQubWFrwqAgwqAgwqAgfMKgIDUgKystLTxicj4N
CiZndDvCoCBjb25maWdzL2RldmljZXMvaTM4Ni1zb2Z0bW11L2RlZmF1bHQubWFrwqAgwqAgwqAg
fCAxMSArKysrLS0tPGJyPg0KJmd0O8KgIC4uLi9kZXZpY2VzL2xvb25nYXJjaDY0LXNvZnRtbXUv
ZGVmYXVsdC5tYWvCoCDCoHzCoCA2ICsrKy08YnI+DQomZ3Q7wqAgY29uZmlncy9kZXZpY2VzL202
OGstc29mdG1tdS9kZWZhdWx0Lm1ha8KgIMKgIMKgIHwgMTMgKysrKy0tLS08YnI+DQomZ3Q7wqAg
Li4uL2RldmljZXMvbWljcm9ibGF6ZS1zb2Z0bW11L2RlZmF1bHQubWFrwqAgwqAgfMKgIDkgKysr
LS0tPGJyPg0KJmd0O8KgIGNvbmZpZ3MvZGV2aWNlcy9taXBzLXNvZnRtbXUvY29tbW9uLm1ha8Kg
IMKgIMKgIMKgfMKgIDUgKystLTxicj4NCiZndDvCoCBjb25maWdzL2RldmljZXMvbWlwczY0LXNv
ZnRtbXUvZGVmYXVsdC5tYWvCoCDCoCB8wqAgNCArKy08YnI+DQomZ3Q7wqAgY29uZmlncy9kZXZp
Y2VzL21pcHM2NGVsLXNvZnRtbXUvZGVmYXVsdC5tYWvCoCB8IDEwICsrKystLS08YnI+DQomZ3Q7
wqAgY29uZmlncy9kZXZpY2VzL25pb3MyLXNvZnRtbXUvZGVmYXVsdC5tYWvCoCDCoCDCoHzCoCA3
ICsrLS0tPGJyPg0KJmd0O8KgIGNvbmZpZ3MvZGV2aWNlcy9vcjFrLXNvZnRtbXUvZGVmYXVsdC5t
YWvCoCDCoCDCoCB8wqAgOSArKysrLS08YnI+DQomZ3Q7wqAgY29uZmlncy9kZXZpY2VzL3BwYy1z
b2Z0bW11L2RlZmF1bHQubWFrwqAgwqAgwqAgwqB8IDMwICsrKysrKysrKysrLS0tLS0tLS08YnI+
DQomZ3Q7wqAgY29uZmlncy9kZXZpY2VzL3BwYzY0LXNvZnRtbXUvZGVmYXVsdC5tYWvCoCDCoCDC
oHzCoCA4ICsrLS0tPGJyPg0KJmd0O8KgIGNvbmZpZ3MvZGV2aWNlcy9yaXNjdjMyLXNvZnRtbXUv
ZGVmYXVsdC5tYWvCoCDCoHwgMTcgKysrKystLS0tLS08YnI+DQomZ3Q7wqAgY29uZmlncy9kZXZp
Y2VzL3Jpc2N2NjQtc29mdG1tdS9kZWZhdWx0Lm1ha8KgIMKgfCAxOSArKysrKystLS0tLS08YnI+
DQomZ3Q7wqAgY29uZmlncy9kZXZpY2VzL3J4LXNvZnRtbXUvZGVmYXVsdC5tYWvCoCDCoCDCoCDC
oCB8wqAgMyArLTxicj4NCiZndDvCoCBjb25maWdzL2RldmljZXMvczM5MHgtc29mdG1tdS9kZWZh
dWx0Lm1ha8KgIMKgIMKgfMKgIDUgKystLTxicj4NCiZndDvCoCBjb25maWdzL2RldmljZXMvc2g0
LXNvZnRtbXUvZGVmYXVsdC5tYWvCoCDCoCDCoCDCoHzCoCA3ICsrLS0tPGJyPg0KJmd0O8KgIGNv
bmZpZ3MvZGV2aWNlcy9zcGFyYy1zb2Z0bW11L2RlZmF1bHQubWFrwqAgwqAgwqB8wqAgNyArKy0t
LTxicj4NCiZndDvCoCBjb25maWdzL2RldmljZXMvc3BhcmM2NC1zb2Z0bW11L2RlZmF1bHQubWFr
wqAgwqB8wqAgNyArKy0tLTxicj4NCiZndDvCoCBjb25maWdzL2RldmljZXMvdHJpY29yZS1zb2Z0
bW11L2RlZmF1bHQubWFrwqAgwqB8wqAgNyArKystLTxicj4NCiZndDvCoCBjb25maWdzL2Rldmlj
ZXMveHRlbnNhLXNvZnRtbXUvZGVmYXVsdC5tYWvCoCDCoCB8IDExICsrKystLS08YnI+DQomZ3Q7
wqAgbWVzb24uYnVpbGTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHwgMTIgKysrKy0tLS08YnI+DQomZ3Q7wqAgaHcvYWxwaGEvS2NvbmZpZ8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICsrPGJyPg0KJmd0
O8KgIGh3L2FybS9LY29uZmlnwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfMKgIDIgKys8YnI+DQomZ3Q7wqAgaHcvYXZyL0tjb25maWfCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMyArKzxicj4NCiZndDvCoCBo
dy9jcmlzL0tjb25maWfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHzCoCAyICsrPGJyPg0KJmd0O8KgIGh3L2hwcGEvS2NvbmZpZ8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKys8YnI+DQomZ3Q7wqAgaHcvaTM4
Ni9LY29uZmlnwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8
IDEwICsrKysrKy08YnI+DQomZ3Q7wqAgaHcvbG9vbmdhcmNoL0tjb25maWfCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArKzxicj4NCiZndDvCoCBody9tNjhrL0tj
b25maWfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgMTAg
KysrKysrKzxicj4NCiZndDvCoCBody9taWNyb2JsYXplL0tjb25maWfCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA2ICsrKys8YnI+DQomZ3Q7wqAgaHcvbWlwcy9LY29u
ZmlnwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDEyICsr
KysrKysrPGJyPg0KJmd0O8KgIGh3L25pb3MyL0tjb25maWfCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgOSArKystLS08YnI+DQomZ3Q7wqAgaHcvb3BlbnJp
c2MvS2NvbmZpZ8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDQg
KysrPGJyPg0KJmd0O8KgIGh3L3BwYy9LY29uZmlnwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgfCAyNiArKysrKysrKysrKysrKysrPGJyPg0KJmd0O8KgIGh3
L3Jpc2N2L0tjb25maWfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB8IDE0ICsrKysrKysrKzxicj4NCiZndDvCoCBody9yeC9LY29uZmlnwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArKzxicj4NCiZndDvCoCBo
dy9zMzkweC9LY29uZmlnwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfMKgIDIgKys8YnI+DQomZ3Q7wqAgaHcvc2g0L0tjb25maWfCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNCArKys8YnI+DQomZ3Q7wqAgaHcvc3Bh
cmMvS2NvbmZpZ8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzC
oCA0ICsrKzxicj4NCiZndDvCoCBody9zcGFyYzY0L0tjb25maWfCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNCArKys8YnI+DQomZ3Q7wqAgaHcvdHJpY29yZS9L
Y29uZmlnwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDQgKysr
PGJyPg0KJmd0O8KgIGh3L3h0ZW5zYS9LY29uZmlnwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB8wqAgNiArKysrPGJyPg0KJmd0O8KgIHRhcmdldC9LY29uZmlnwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDMgKys8YnI+
DQomZ3Q7wqAgdGFyZ2V0L2kzODYvS2NvbmZpZ8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgfMKgIDEgKzxicj4NCiZndDvCoCB0YXJnZXQvcHBjL0tjb25maWfCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMSArPGJyPg0KJmd0O8KgIDUw
IGZpbGVzIGNoYW5nZWQsIDI1MiBpbnNlcnRpb25zKCspLCAxMTUgZGVsZXRpb25zKC0pPGJyPg0K
PGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjwvZGl2Pg0K
--0000000000001164030616c76bcb--



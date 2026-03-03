Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AC9EC047D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM5x-0005NF-Jk; Tue, 03 Mar 2026 04:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vxM5r-0005J5-7r
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:31:08 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vxM5p-0005af-HM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772530257; x=1773135057; i=deller@gmx.de;
 bh=WMTY0ICAlnYEfRtB+boU1bOPj4m9fDZlR80QSilnE+o=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XREBFb+umO1D8Cn04m49gJU37hhHYlnTzixBxFOxHNxhSSO0HtLri/E60LE2rUcZ
 Z9AjrDOTU3/TTmpgwt4xneISEHqnSawmS+rf2s9JBwn2sxYAyWpNQdIBPF2/8GwbK
 QFTcSykrZYPmTXJfT5eVM/Az6JL9l4xD8vLRRf0HGuk9rbKo5dXli3l1ZExZjaR2+
 AFQov39Ej2hQUbdFSfSCu5EiUqNqSbACIfnZS7IcFjh1ZzdzJnIL6b8sUDYA7K5QL
 xshnbNO8fZ2odhNDbCl768xpe2TsNfui7oq60jO//ZUD9ye7tEPwPnxZUwyIkk10d
 6/9EsVLEZ7xr35dxeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXhK-1wIt510YBW-00T01w; Tue, 03
 Mar 2026 10:30:57 +0100
Message-ID: <a61583f6-7be3-4c7f-94f7-a21a69eba5d7@gmx.de>
Date: Tue, 3 Mar 2026 10:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] hppa: Use 44 bit physical addresses for PA-8700
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
 <20260302-hppa-c3600-v4-4-447a800da8cc@rev.ng>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260302-hppa-c3600-v4-4-447a800da8cc@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3IC0YztkeLUAra1BRAHT9ppTLVTsGal+hJHeQ8axl5av0vshiZN
 yDhu+ffB2C7FW10rbUzLDIXKcpt3i9M91EVWzFJDZExIu10spwQ0utk9rmtMMFMbpdlPPQ/
 n9LjYNqW5pWmOWb/Z+RbAKbO9icZNUQ+PLh+eLKwAzM/QNjfiLtYJBImit91Xr/FKrUqf1t
 lywHcmcfAy3RLLfzv8Pew==
UI-OutboundReport: notjunk:1;M01:P0:gW19o2Vp/Q0=;Nki9O5XgLJsSs3T+oD7ETXPIS9x
 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
 gVvEikUCzKeMEVe833K8CiqLa2xL6t/QTUvcue
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/2/26 12:56, Anton Johansson via qemu development wrote:
> This is in line with the PA-8700 specification.
>=20
> As the SeaBIOS functional tests requires a 40 bit physical address space

44 bit physical address space?

Other than that:
Reviewed-by: Helge Deller <deller@gmx.de>

> and now support the A400 machine, update tests to run that instead.
>=20
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hppa/cpu.c                     | 2 +-
>   tests/functional/hppa/test_seabios.py | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index cc755da8be..5ba1045f1f 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -344,7 +344,7 @@ static const TypeInfo hppa_cpu_type_infos[] =3D {
>           .name =3D TYPE_HPPA_CPU_PA_8700,
>           .parent =3D TYPE_HPPA_CPU,
>           .class_data =3D &(const HPPACPUDef) {
> -            .phys_addr_bits =3D 40,
> +            .phys_addr_bits =3D 44,
>               .is_pa20 =3D true,
>           },
>       },
> diff --git a/tests/functional/hppa/test_seabios.py b/tests/functional/hp=
pa/test_seabios.py
> index 661b2464e1..bdb9d534ef 100755
> --- a/tests/functional/hppa/test_seabios.py
> +++ b/tests/functional/hppa/test_seabios.py
> @@ -12,7 +12,7 @@
>   class HppaSeabios(QemuSystemTest):
>  =20
>       timeout =3D 5
> -    MACH_BITS =3D {'B160L': 32, 'C3700': 64}
> +    MACH_BITS =3D {'B160L': 32, 'A400': 64}
>  =20
>       def boot_seabios(self):
>           mach =3D self.machine
> @@ -28,7 +28,7 @@ def test_hppa_32(self):
>           self.boot_seabios()
>  =20
>       def test_hppa_64(self):
> -        self.set_machine('C3700')
> +        self.set_machine('A400')
>           self.boot_seabios()
>  =20
>   if __name__ =3D=3D '__main__':
>=20



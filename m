Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037E8C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwcfU-0005eL-Th; Wed, 19 Aug 2026 05:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwcfT-0005dq-20
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:33:07 -0400
Received: from st-2004f-snip6-1.eps.apple.com ([2a01:b747:3001:201::36]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwcfR-0003Og-6g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:33:06 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id
 40BD118002FA; Wed, 19 Aug 2026 09:33:01 +0000 (UTC)
X-ICL-RepId: 01a0195d-ed27-7611-8de3-9cdf81caa56b
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBIHVoORQNGCVYLWhcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0IQRMFUgddTVYNRw9YHlwUFwtHQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0x7SQNYBVl0QhQ5AikERgYxfEweLw8vd10ASgdfA1MFRgBJBF53HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787131983; x=1789723983;
 bh=mVDNReVc35x1eqbv6+N14m72Bc6G+qbTRasBFHOj06A=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=uwqyhUYY2TXJRMAbnOddGtUexGmSyxUUIg+QUT0unl3Bk95GWDkA8IVbQ1VOZS8mvW0FSk1PdXXkvNQVvqXYJ/48t6luaSQABmeL8klfXdtO5kFhfWMu8aeVya2A1pNj/ZPtMsPZwB9ceOV0nI6fUzagiH60NjxVUA5oHoqCdnZbieUAPaKfg16GJoJSt0QSB5s3NPGQfoGiKhpv578znviSIJwfz3YfInkCyPBLViWGwc6zH7KwV+HP8ToX+ehIuD5zHUfaHNVZIGN3D95fCz6PonLQGMjT4OSF3s9LMPCVrU4Urid9ZnLSzx+0KigIu7OZGaF0GuMjK7cY6OhaHQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id
 CF3BF18002F0; Wed, 19 Aug 2026 09:32:57 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 6/6] docs: deprecate virtio-crypto
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260819-fixes-for-11-2-v1-6-b7981c2cc371@linaro.org>
Date: Wed, 19 Aug 2026 11:32:44 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, devel@lists.libvirt.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B10522F2-A1D3-4AE4-B8DE-924248769173@unpredictable.fr>
References: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
 <20260819-fixes-for-11-2-v1-6-b7981c2cc371@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX2ZOLTGm8fjPT
 zrOpoJbF30Uq7Trl/DNRylgWjjj7L/XNxWuYvXyYWyHg2siQQotoiwKx9xZUQGi29Kz9TyVqjvx
 BcfjXvLZ0EAJFBJKuwH3jFt+qWS/eKe7kd58+O/Gk8L+o/VXV8OvWnGFQQ+65Ip+OZGMZ0Da25m
 uk8+P3zP94Jzsqi9CqX5dk/AecliQJ3qWxPX1kmnr03hhl05eFFX85uZye3PwCCTblgJZv57CNJ
 EFpDB3rLKG+qC/3UfineUUav2l2O9njZx0DFbeS8N9mI4gkmJg32hus/241WTS0VTTwePlKp2I8
 baNJYazsh0kRZ/eTIMU7WoMi208FjoDinaYsyaB6qMrsKXr1V7gWrCe0OPpJJk=
X-Authority-Info-Out: v=2.4 cv=dfeNHHXe c=1 sm=1 tr=0 ts=6a85784e
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=i0EeH86SAAAA:8
 a=6BZSfjg5s5QjvaG9htEA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 41mi7VTA_DLJFsyrRlc7FfoN3iCxlHv_
X-Proofpoint-GUID: 41mi7VTA_DLJFsyrRlc7FfoN3iCxlHv_
X-JNJ: AAAAAAABPWPGskN1e1H8sC1ZoNCHk+muZCCaS4lAJSSYmDh8Br7SUktCAV3DytOwRkKZWDUBELvRbyvNDYFZHsvIHQgQsPNEVBWUua0NviT6kO13u2dWGGn0n9OKGWWgzTxbqJCyHgDI3AADJCYeEmPImqRBc0pzzOtstvUmEG5umjcFzh/NZ3NgpnLTQJ7h6kqW3iQMAC+gjgIUEolJ/NDtmyH7lEHGKtiOtsJz2cOI+LzoPXu2Y09nweHWdID0l3iNHP9dMABwmGaXlbiJUK7DP5fbqBG5W5A0XA8lKwdNYyG7RRznWo30te7mEGQ+j3uXa7Izu4LvL5bsC/KjXvyvgykJTt6+n4LYexjko0YbvJBRsIOBEHFvt3jCWoPFhMWWh2mqi6px5YOBonct3Qc9bByEC7R1KCMM6tN27A+PJZt1+SInXtT3iAxWSif8ur+2qnWcmdNU8M6fM43dG+mWfxfPNbP3nPHLWO5SEmhmuim7ZxQOHRrT7s2kL8jrbxJYPlkJXV/+hAN+BzUG8fBUlf01Gsr/p/56AtGFI1T44fkOxaaP5OHY28Wrvg1IoLcu8gyff2lC47Qpxo3ABSg1qTRea+EZcFKbL+Ld7hbB4NA84oPGrGBAQllCgUrCE0qyDqjfkWjohhT9r5jhYq+3LMzXr/WsUGOcmy7rOL4QUq6ezqxOzqmKp3bO6kNOoZ59T5JFfSH/RKL8sYaIzCBM3fbsOOVCySjzuPYwtGLv1r9OVu9tuErdx1UnjXYe5K5CgfS0xbeeeMcdtVLFo/f/s/RjxHlj2g/eAnybczAhJ99lFmq5G46azMKrPhgCOk0Md4RGyjI5joES6IJVUzdtjJxy0JtXd8ChG9qJSmPHBupfv8RfFK8HkiC54IxHH6C8gSMXfO5HqK5YoTclCJqVXe8i4SrUyv360Ej5I7DR8mfaQPd/sMvmPm12AIi/DRIq2K6ALk7zn4hJ/UniGY3v8ViYzcJ
 7o1b++obotJRfve5r5XcI8Vzzubwgojy1orM1UYx3i2UyamNqRj3xm+QQWNHXr11LGh0li1ajDhdNK0P0KwvWmn0mIx7W/vGtMOOzBCaDgDGjiDDzIpJATxD2livVdTFuJ49sZkuwouh2uF2e7qAXCverv9RRB7zAogMFNOhidG5eZZVNoN8/AzFPW6lOJmG0edcrDeDBcFkmlxniqyaM9aTa9WC5/IXVdIwGBH8aTqS5qB5rlE0FKGaUNbToIbb0JFToi+sExarkMtA7+geGOzLpXNRTTJuYdyVQ9lcqGPh59krv+pGjLM8JW3/2Tk3ShM5c7ZENKf+tMpiEE7QKC/H0Y2YG78DA7SxDIgTPPJY3VkFt7gjOOpVIV0RtHDfiE/sNKBYxUXwY8bvAEYHL3ZABS9ZHBZ+Cz6fDGO32Xew7QcNxeuoFwrCNKSs1mrb+i2oDCLgFzD5lMj9G8O3YFme7BxZjJG2SIpJ4fQ2MKyKtibNtu39i/qW0zfdheBDt10WoyRCx/hg7ti+Ny/pOcdM+8wj7eR4fSHmMvwDHZsUVZVlldZqZhSJHqS5NPf6b/PqB8ePXHLRPrxSEJZBfvnY4T9WOuchzDIVW+EbX++uWnS8ypCLoal5nl9DqJJ4=
Received-SPF: pass client-ip=2a01:b747:3001:201::36;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 19. Aug 2026, at 11:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> We have outstanding guest exploitable bugs in the code which is fairly
> complex and needs some serious love to clean it up. As off-CPU
> cryptography acceleration seems to be waning in popularity lets just
> deprecate the sub-system with a view to removing it in a couple of
> cycles.

Hi,

Still quite powerful compared to on-core acceleration, the kernel=20
isn=E2=80=99t a great example on how to use them well unfortunately.

Far better experience in production with DPDK and directly passing
through the crypto accelerator to the process that uses it directly.

virtio-crypto with its overhead makes things even worse on that front =
so=E2=80=A6

In practice, the vmexits did cost so much that it was quicker to do it
in software...

>=20
>=20
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3625
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Gonglei <arei.gonglei@huawei.com>

Unfortunate but it wasn=E2=80=99t useful as is, so,

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> docs/about/deprecated.rst | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0c656a968fc..3c22981fc8a 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -276,6 +276,20 @@ future release. Where no 'dh-params.pem' file is =
provided, the DH
> parameters will be automatically negotiated in accordance with
> RFC7919.
>=20
> +Devices
> +-------
> +
> +``virtio-crypto`` (since 11.2)
> +''''''''''''''''''''''''''''''
> +
> +The ``virtio-crypto`` device emulation is quite complex code with a
> +number of known flaws. It has never been migratable so is unlikely to
> +be used in any serious virtualization setting. With most modern
> +systems supporting on-CPU cryptography acceleration via their
> +ISAs sets the need for off-CPU acceleration is also reduced. Add to
> +that the kernel has recently removed the ability to use off-CPU
> +acceleration suggests the time for this sort of off-load has passed.
> +
> Device options
> --------------
>=20
>=20
> --=20
> 2.47.3
>=20
>=20



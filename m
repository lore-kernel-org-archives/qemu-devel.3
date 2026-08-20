Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90544C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwqYb-0008Ur-LB; Wed, 19 Aug 2026 20:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwqYa-0008UI-8o
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:22:56 -0400
Received: from pv-2004j-snip6-11.eps.apple.com ([2a01:b747:3003:206::5b]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwqYY-00062g-1N
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:22:56 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-7 (Postfix) with ESMTPS id
 D8475180015F; Thu, 20 Aug 2026 00:22:47 +0000 (UTC)
X-ICL-RepId: 01a01c8c-8a2c-7d17-8493-62be02cabdda
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBIHVoORQNGCVYLWhcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0IQRMFUgddTVYNRw9YHlwUFwhFQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLQQIvBFsDNhRJBS8PRgZDf0weVQUqAF0IPABfAFxxNn9OAVp3HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787185369; x=1789777369;
 bh=nRsiVASnIE6axGpYU1WFnv/6RF4jHUrs3h5+oecRwqI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Q6b+3v0CyRGpSU2JEEhwSw+vE7+hp/V1gtmEa9uKsPEbBrs3MyF+jMROXjPC2bFt58J7i2R2kR5Kn5j3kCEQ8M9MbYxNasJb7Z6BvEuHEfJb+W4xwYAGateA+27Hc7yGa51aPtKLeeI5whjAiclIh2Th8XLq8M4kmS/adNkfnmKba7VwMb+6ik3TDNKaJPtMTRY/4RGaIT1dTY2DXvhNnLZEiQycc3Bfkq+QyFqkJ+q+T9+GrZp3RS/pu6sgj3iojIwTq/FC60+2cgj6gFcfDxT8jIvY2CEqLPaZhPLyWhkJKoKOk3zIVFCgVS3uv7NhLBJpAX0vLRXhf0wz4meuQQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-7 (Postfix) with ESMTPSA id
 197111800118; Thu, 20 Aug 2026 00:22:43 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 6/6] docs: deprecate virtio-crypto
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260819175408-mutt-send-email-mst@kernel.org>
Date: Thu, 20 Aug 2026 02:22:31 +0200
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, devel@lists.libvirt.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <291B301F-16B8-43F4-82A2-1D3277CFF627@unpredictable.fr>
References: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
 <20260819-fixes-for-11-2-v1-6-b7981c2cc371@linaro.org>
 <20260819175408-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-GUID: -hbTtXPsdRGRs6fsKcRQzMXMO6AafeHu
X-Authority-Info-Out: v=2.4 cv=B5O0EetM c=1 sm=1 tr=0 ts=6a8648d8
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=i0EeH86SAAAA:8 a=xjJexcDer7hkonfWDUsA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAwMSBTYWx0ZWRfXyyZ48aOQKh2F
 KvtagmC0zLs0gc8QbDmWctFhlrzIq6IJkiMpCSjPygRbR80sgmfbRUVBQEolNf9eU7soE9HgxaZ
 RjajXHh+tYHaI1dhG5LrqecvP8nRiMYtRsuPqVxdtixYoRhYU5la1Q2Bka+lnmjUuGbM94w2qqa
 JAaWo4Z8NLJScdAiK5hG9vwgmZFus+1D8te4z73jimGjyqakMBUOSpQEFGrAHh13C9eYqYb/tZR
 MrdV84cQkIgNIB8hDZ/A1LEEJMJUyAXMJ2l++R/BwCIFWh1nzo4ohy06of6ATDML2iI6/O48eYL
 WHu2AfAL2f1zvo/aP9wWcLCBlOrPMXSwWTRGWPdqv0KBVXak+V5RPEK1gZvJV4=
X-Proofpoint-ORIG-GUID: -hbTtXPsdRGRs6fsKcRQzMXMO6AafeHu
X-JNJ: AAAAAAABqG9LusaMwZhZVPwJ3u+kAF0UucgQiCq/2T0cB4G20JdRBPvdR9PiVSxE1eyvdcIFJadz9/ZsuT1UwGQLbHKu0uHDFzYpy7cBaUCqAn9351iIuowIyYwYSkVRv4dILh7YX+dndCjfVmgWdaI62ftaYE+Kz1ohXY/+XSnuOUn/LR1/7vY+H4Mf9er/cTRtkEijdajj6/WImk75bFzBtdt7DQ0aCAr213Zqc6rdGri8lznnW7z9f3SEAfrKEmb1D7eMy+eAgaHE8heXU1DlC8fhxGp5TyrSSos+i1vclryMDTkl2gHBKANp9wgyC1eKSE1h4Osidl2RmPBCple+DcWLxGjCuOYKqatQ2Kz463euKybMNBYtq9hm2YQ7t1EhfGFc6YDgcoy5NaC7VZ0XyoEsBhGk+cLJRjHyyLO99ZYPooWaOiT99NLx2ajBrqG/Ajy4+nAHk8PqJ3y21i3cG0fcRXNXcFkkThHEZ0F4fcLmg9yO8zl+LXUQwDb9rlQ5tD83NVNU2zxcdeuLqlPPjWA743meYweq2k2S13I5gZF/BFrtxoGnRtT7c7i+NVEPC4Apjecyrh093Oq7LADAChDdnMQmJPi8ttEpwRxCnB1OKzVhZhlGxdvy7+WMaGt4QfIhz/9JG6PKh5W1k7cmd4qNfEziweF3APdUYzOS9Pmib5TC7aMC0A32Ogm3uqn4ioZTgBwS82/b3yagRBwbyz+ChyXjzxU2G9WDhLt8lbrF3Md0Lvp8btxXmxYb0JlTgHz701knre78E1iTN4aP/gE/QGFL9P355M7fhQDKZAXf+1G0uaDRHdRLH6+8DWEZd0NCTI4GmZkFXMM8vG2sfte5oKK2wy4/6UBoyEpvRGaxpy6ErrdXwesgedCp8PWBKY2gojpArcArIVLjpSxSL6aElrmuK2JmxM1rsMAqPZX/7AG3cQRT9x+YvySkmxBlKuGiI8+mUDPhFBH88vGxBNvTFFx
 F9zrM2FYc3L4zSrOrRHYtIS8Vvr8ZV/bB9i1vLyR8vVzsqGG20vKn7ePxatQGpDqWMsPqFuDEhCoTuEH5G+KjSUELT32qBbntXk270dUtZ6kTcLvwYiCUaNpRlekgdC08kK3bdMgoVN0Vi1g2sQKEvybc/MRVLlBnkzAMU0siZkoQdjqZBqKs/OcpJQ0sQ3KR8jeIAc3J/LcU6OWrFdrG8LPfh0kjB/nUHYFYHrLF7kXANP9ePfr10/8ZqNMaAbaFYXMxrGBeGDKFTl5VkzzsAhEQRIeDV+1rnAsdFSEYzmc3Ge9NHR2quRwSmU+duaIakJdBiYeD5QdMD89uV0LLzAHN5wdNiUqT32uT/qsypITBkBNu3BQBkJCG6Sxy/5qKWKyupoluXHE80B3MdugX2VSirderN4OiK/wvRnUGX6HTm+XoZgEskSDkDJKX1tW2FmraOt0YjON8H16HaMKUOAc84HWc2PxJqJqNVdek2Hcpfqdksj9zFrn3lpD0x6oITFLgvbvl/S3B9ZxD7F9T85C2NpeJwB7HagZVjji7sKbbRQyvKY8PzWVB2W8JzVuKGiJJ39SDwVSUSU7qotFplTs7exffuVqzA1aTqVeje65z3aC0Xp++hd/gHWuLA/Pd/gpJgsjeq5WvFQ==
Received-SPF: pass client-ip=2a01:b747:3003:206::5b;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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



> On 19. Aug 2026, at 23:56, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Aug 19, 2026 at 10:22:06AM +0100, Alex Benn=C3=A9e wrote:
>> We have outstanding guest exploitable bugs in the code which is =
fairly
>> complex and needs some serious love to clean it up. As off-CPU
>> cryptography acceleration seems to be waning in popularity lets just
>> deprecate the sub-system with a view to removing it in a couple of
>> cycles.
>>=20
>> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3625
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Gonglei <arei.gonglei@huawei.com>
>=20
> Let's see what Gonglei thinks.
>=20
>> ---
>> docs/about/deprecated.rst | 14 ++++++++++++++
>> 1 file changed, 14 insertions(+)
>>=20
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 0c656a968fc..3c22981fc8a 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -276,6 +276,20 @@ future release. Where no 'dh-params.pem' file is =
provided, the DH
>> parameters will be automatically negotiated in accordance with
>> RFC7919.
>>=20
>> +Devices
>> +-------
>> +
>> +``virtio-crypto`` (since 11.2)
>> +''''''''''''''''''''''''''''''
>> +
>> +The ``virtio-crypto`` device emulation is quite complex code with a
>> +number of known flaws. It has never been migratable so is unlikely =
to
>> +be used in any serious virtualization setting. With most modern
>> +systems supporting on-CPU cryptography acceleration via their
>> +ISAs sets
>=20
> ISA sets?

Architecturally exposed instead of via PCIe/platform devices

>=20
>> the need for off-CPU acceleration is also reduced. Add to
>> +that the kernel has recently removed the ability to use off-CPU
>> +acceleration
>=20
> did it really? I thought it's just for af_alg?

The kernel=E2=80=99s own use cases - for disk encryption and co - =
aren=E2=80=99t
supported anymore using offloading - and AF_ALG is deprecated.

Drivers exposing a channel directly between hardware and the driver
(ConnectX NICs, Intel QAT for ex) remain, and userspace can
continue to use hardware crypto offloads through these or kTLS offload
which also remains.

For the former case though this means using a vendor-specific
library in userspace (qatlib for intel)
>=20
> and putting "recently" into cde will not age well.
>=20
>> suggests the time for this sort of off-load has passed.
>> +
>> Device options
>> --------------
>>=20
>>=20
>> --=20
>> 2.47.3
>=20
>=20



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2399C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmyRP-0005Hl-5C; Thu, 23 Jul 2026 14:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wmyQm-0005Df-Qt
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:46:20 -0400
Received: from p-east2-cluster5-host12-snip4-10.eps.apple.com ([57.103.79.83]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wmyQi-0006ix-4U
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:46:03 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id
 8933F1800CB2; Thu, 23 Jul 2026 18:45:48 +0000 (UTC)
X-ICL-RepId: 019f904c-50a1-7ba6-8c43-67d131986391
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ITRMFUgddTVYNRw9YHlwUFwtHQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wBSwouDi8BRBQ+AFkORgZIeEEeLAJdcF0JPnFeB15wQg1BASh3HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1784832352; x=1787424352;
 bh=3PYAbALTtlcIHjAU5FubM1hwxyqzTlhOxy4/wOk8L3c=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=iIXj6CkD1pW0Tt4vVgdjjfCOjQ874+elT/LhD6hpylAf6FRhP4IxGU2KCrkQzu49EroEFmvO4WbPJ/8pnopiyUpvbb/PDswrVN26+WzGk9PvR5U4JgoFVIs73Ukt0XE9ojvD/fIMXC40WRp+ty/9SdlMAq3E2Qx2zJh0yiLAnqPHl+hB10bknLFUaPs1x63rwiZTAo941Su23x2VPrsqLTOt25W/RStQrWVIzWe27ybb3V5cujagW7lj9nWoUBGBG250Rp2Hg2Z3zIoTUtaxKRt1dZjf4Y9nS09YgSeJxg06nwgMwsxHBamVPcWbql0OM9ZZUgvM+C55ZXPuJLt8xQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id
 65AF218003E5; Thu, 23 Jul 2026 18:45:41 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3897.100.8.1.1\))
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 20:45:29 +0200
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?=22Daniel_P_=2E_Berrang=C3=A9=22?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <839C9D34-F349-48A9-A56B-0FB305B2492E@unpredictable.fr>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3897.100.8.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE4MyBTYWx0ZWRfXxoyKJnN4oajV
 7oC9zsOLaAaaJD2bv0GEnwXOomzWiHjiHxHpRYQe6bbWe9TGJ3a3JVtWppQExCiLEUlE+2ZUtpT
 POmJRP1dIFVW/IHDG1IEMpf+bstod5diNyTJDKQ8gWxpo4muJJ+Sk0j0jmHusOksd8tI9qdcVjI
 ciC3nS1qtkIsfLW3TvoGtWmKW9UHB16JA0WzSVc9Kes62rNakonqU3X8vPO2BD7Umy8pPsbZqu2
 8M1bBamJ3bb0vYASQlHy42fCUqYS10piJaNC2kj1vayxtAt482C+luoVnz8I76iEnXee9Eil6Ln
 SWieT8R68G31j3Cp8eiGLFCdl0U/839QskLn05kH1RKfLQXnoNEVwolaLKZIj4=
X-Proofpoint-GUID: ZYeXdQ1AHVjYhghpZ4ekUrgrODoCskn6
X-Proofpoint-ORIG-GUID: ZYeXdQ1AHVjYhghpZ4ekUrgrODoCskn6
X-Authority-Info-Out: v=2.4 cv=Sbn6t/Ru c=1 sm=1 tr=0 ts=6a62615d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=UZ311UNltKGXArjXTUIA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
Received-SPF: pass client-ip=57.103.79.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 10. Jul 2026, at 23:43, Pierrick Bouvier =
<pierrick.bouvier@oss.qualcomm.com> wrote:
>=20
> Those options were useful a few years ago, before containers were
> available as an alternative for missing cross compilers. Simplify the
> workflow by removing those options and maintaining only the container
> based approach.
>=20
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
> configure | 473 ------------------------------------------------------
> 1 file changed, 473 deletions(-)
>=20
Hi,

It=E2=80=99s nowhere near an upstream state, but we might want to =
consider some
architectures where Linux is not supported.

An extreme example (which not remotely anywhere near going in tree yet):
there=E2=80=99s a working IA-64 system emulation tree around (on top of =
QEMU 11.0)
that can boot Windows and Linux guests. Linux and glibc do not have =
upstream
support anymore for that architecture.

aarch64_be might also be going that route in the not-too-far-away =
future...

And there=E2=80=99s also macOS hosts and others, so while containers as =
a default
are very nice, there should still be an option to opt-out I think.




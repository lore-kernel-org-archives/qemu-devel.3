Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0F9C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nJm-00076W-Ty; Wed, 16 Sep 2026 06:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6nJf-00076B-8e
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:56:40 -0400
Received: from qs-2003k-snip6-5.eps.apple.com ([2a01:b747:3006:204::6c]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6nJc-0004Hw-2t
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:56:38 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 27318180011E; Wed, 16 Sep 2026 10:56:30 +0000 (UTC)
X-ICL-RepId: 01a0a9dc-6f31-7658-a5db-28a513b0c8b2
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ISRMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLOQRaBy4DSBRPBV9zRgYyAD4eVAMvc10KOgJcc10GNA9Bdyl3HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789556194; x=1792148194;
 bh=JUwTT68j3UcAH6MCbpfkt9vK/B55x3ooVzVinIvdoNk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=LI/y26zHGbjPEEexWT8ZdgThxakqpMaxLUWfAY798Q1Tc1MxjTYAE4tIbec2OIC9DEth45tYH+oXY9QsmQMeEq2se3594DonNhLfP4GVQnU2B7a095sBo2rfx6uHNozw11MzdXL7+HSckptpPoDrC71BsnTmO3Q232GOOyjikfDRIY8HU4kAlZWZqlXA5K4i9torB6gX5ibo+mT+12CqBPjVa9vO7GWcstSprr5Vt0uWX9qYWJzUqEQTQ+8QFIv95fAc9/iLbVWAM9VGyx7yg5dhI6P2KOFuMVHpxoz4qnfn4E7Wk6GpqWQ94O4nSFjp11RfnXQow1Z6gmcqchTC8A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 CFE7C180057A; Wed, 16 Sep 2026 10:56:28 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [RFC PATCH v8 09/10] vmapple, gicv2m: add macOS compat quirk
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA9eKwvOr+jQ2NLSx1mnp4aZ9pbv3RKs74La17juHK_=LQ@mail.gmail.com>
Date: Wed, 16 Sep 2026 12:56:16 +0200
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A770E18-762D-4B9F-94DA-3B11D64D69DD@unpredictable.fr>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
 <20260916100021.73825-10-mohamed@unpredictable.fr>
 <CAFEAcA9eKwvOr+jQ2NLSx1mnp4aZ9pbv3RKs74La17juHK_=LQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0NCBTYWx0ZWRfX4SHR75aciv5l
 17I5jl4ElTzeTd1Lu6KZP9jaZ6DohZbPV4a5i1+JmFINZtsTQonU1VBiQtVsLY5ew4NheOgryvk
 lotfhXDTWeLoxyYaMkzMXdPw2Rvfzxk/0lLkOTu8UJV+etjuAOr59kXlxvy0yHB4vL/naxYYlHn
 YlshQtwak8z1+xit6D9ID8PYCFD0QBuzZTRAYjODm+0+NllGy6cQEEuPdtPHh7TOhhucpJ8NXTX
 nIpCiy9VBwjuj59Iam64UV019uyxC4yY/bnGNy392JW8t3OmlB/0zRc72jbJksC4xRvevcRNbDE
 ncN56bhm62qltu/6VMp/WR8DglyExH3A43Asfk3TCT3WH98MbYd3sHyvRtGvAQ=
X-Proofpoint-ORIG-GUID: jWlq69sEYpRu18gE83FcYWdjWTErIQ2V
X-Authority-Info-Out: v=2.4 cv=MOBtWcZl c=1 sm=1 tr=0 ts=6aaa75e0
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VzozP6VNtaWpH0haZrwA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: jWlq69sEYpRu18gE83FcYWdjWTErIQ2V
X-JNJ: AAAAAAAB0GrgMR3QXcAgm/dovGmDHW5PV5f8aNGtRr946BbGE63J1gG57qWOHa3Z0Co1EKSLtrfpQ+flLWGnXrcgip+25Q5WLjvGY9BvfjJKuakCt7DLdPJ51uDJOCTMjDoHbVBvFCfFxMex7u9hfKwsX4nfSlrnbTdrA3j4P4WBvZQ+99qqI8QgWnulZsYGs61kxNai+EeZadITPuwEYcA7XskCwf6foWhqKnu9LGOsPgQJiCI5GeKgmETqlp15AcZZsW0H9PVfoYwy7+Vmq/DMXcqaHILuUNPR0Cam7yJhcPfQ+fC7nv/i0psKTa0xE1a2Y7qNOBq5XRjXIipXc7bOesgXAmFvtfXC2M5R0Rc/BeSqdbj+owmAg7qWqEDmmMO95Yp1UXcojGRVSgtFkWTXX/BLqsNhe4gI4GgqUbu3ET+X1k2TDkZlDzdpzjK9BkWoAEkqZgZh3w24TS5nMHL0W4oAXv64DUDOO9QX6qelkAPFN8rqUHnF1/ZqSMeC9Pp0vJbqrdlfeyYAyDm0Gfhsm8CX+wzWHnLvyF+EtDx6gjA+hASLL3NqZN3cv/xiiZAMUUwNO5q6mlmoNEPWgaDbV3UTaNgHY7ALRt7zXyHsq9R4QHGNMpWl2SEq/W/szRWfNJ9IwDqbzgwxt5sRH1NCSilSjpU+G+LqnjUNrmqro6bFB+Vc2QgBILcoJ6QtNwpuSLVQkfSCB/mYwwu0L8A+4pQoVF5EXcKsTBqcEfgSOAvp8vcfdkHlYDYxIWHhi+hdeVJdHK5cVay5bsRQNhjAyUJyLZaS5gwhgmPx+QNCXhK9b6/9hzxJA2AfDjUc3EYyDZ/BrVoMLLFigDraUKmhBYlh2+i4S9fkBJS6zWQzmcwTIfGhBgVYL9mdYPe0++uil0kTYgda2qeLnNVT6uDSn3qrqrb6zC36yHGSgNpYjcrb8S8EK3QnVnNTM05OMHqYyE9mi3mCat9N9axnRKfplLb+chA
 97jLwtg19ES2qaMJBcPcAKJrECFgn0NWsqPzx/JAQwhtmiK1hpLIPH6YX0rx9AL28jARiWuRE7RkokDvi5COuXMaEn4VMq/j44EmIb4dYTbiRwwhz6TdqhAikGxWgkq15vENWgkmY5T9UvqCuNVY7nbgNmZD/W+tPfKEh0ErMrwNhl0WAMMAKqN72pJ46iMCtfiYGjnt0egGchFlfyMhKigOpJNpBPvgNQHssfi3forK02FNMtyeW/kwsyQ6T9X1GzDYkXcQ8vaP+TVsGpFz0DsyQkqBaFCu/Az7zC4pbZ6c9unW4wtU6s39uKj2CiCaVKXXRhh2385SW8DoXLjHXqQMuD05EsJeBmmh2KStjJZqoPWCt3Px8o1OSubcEdcbZYe/txsJmkGF0s6x5Hl1d6xrAH/b2RTQhFuY9MMSsRMlyeTs9oPAXNhdELBzbrxBwECxRBW/RSJJMeqFyIrdbaO+t+qsXRG4XBHXq6ve+fDbSIVtkbnGsLh0n14Fxkav/kEAo5X+h95XEDGdyziabeKX76axG9rLx+ETXoIMgptatAQ==
Received-SPF: pass client-ip=2a01:b747:3006:204::6c;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 16. Sep 2026, at 12:51, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Wed, 16 Sept 2026 at 11:00, Mohamed Mediouni
> <mohamed@unpredictable.fr> wrote:
>>=20
>> macOS expects bit 31 of MSI_TYPER to be set.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>=20
> This is a macos bug -- the Arm Base System Architecture
> spec which defines what the GICv2M registers are is clear
> that MSI_TYPER bits [31:26] are RES0. I'm not keen on working
> around guest bugs here, especially of the "random proprietary
> guest has mysterious undocumented requirement" kind: insisting
> on bit 31 being set would presumably break on a real hardware
> GICv2M as well.
>=20
> If there's some documented "Apple GICv2m" variant of this
> hardware, then we could potentially model it, but I'd
> rather do that as a "here's the spec we're modelling,
> implement it" than a one-off point hack.
>=20
> =E2=80=94 PMM

Hi,

vmapple as a whole is a reverse-engineered target without a public =
specification of any kind=E2=80=A6

other than this patch the system is happy, but without it, there=E2=80=99s=
 a kernel panic really
early on during boot=E2=80=A6

There are no specific Apple GICv2m registers.




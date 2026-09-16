Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCFDC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6xsK-00014u-Cr; Wed, 16 Sep 2026 18:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6xsH-00014f-TY
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:13:05 -0400
Received: from ms-2003f-snip6-6.eps.apple.com ([2a01:b747:3002:201::2f]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6xsF-0004Vk-9b
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:13:05 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id
 637F1180011A; Wed, 16 Sep 2026 22:12:58 +0000 (UTC)
X-ICL-RepId: 01a0ac47-be4f-7e33-b554-07dee0e0ab9f
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkJ7PgosAVIDXQxJcCwaXwBEfVULWXFfHzF9TgErdVsKRwtJdS1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789596780; x=1792188780;
 bh=rGG0RctTdyYTtxnzHW6pEsgUFw67RrG2UyVUQFdKR9I=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=brhYTuOKtAlVxSoIgJ3GubNqXfAdcFSDWaMPrpeg1laxNUGAzxXRHT0izDwlXCpj4SRdWAuHkvuhgkAgcbnUI+z9sqfjXlpMkqc/tdHDfijgimaJYwhfWAi3Zdgy+Bnh7JXtUJ5fD0cS44MiF6Za3n4o87ClLoibY6xJrExewxFvkaZB8ipod1jKn/zjmGecBZ8N6UrPYE9z/4GabFZHtheqeXTG4wEArVUFPMYQ0J96h7MVJlMCSuNt+28crQudN5VvisJVK6pl0F5aSSBzS6XJIYJs7Yt/yJDUVe/c9FxRsLfEWgtTrlOSBBH4Fo2ssY3eHRIX72KNtFalNU1k4g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id
 085B918007C2; Wed, 16 Sep 2026 22:12:56 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH] target/arm/whpx: fix uninitialized PhysicalAddressWidth
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <LVXPR21MB7009F3FB78275620435BEEC6ADB92@LVXPR21MB7009.namprd21.prod.outlook.com>
Date: Thu, 17 Sep 2026 00:12:44 +0200
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2BF9A691-51CA-424D-84F4-AD62FB08721F@unpredictable.fr>
References: <LVXPR21MB7009F3FB78275620435BEEC6ADB92@LVXPR21MB7009.namprd21.prod.outlook.com>
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-GUID: faZwThJGdnlATeHWnbV-u8OVvw3nmjHY
X-Proofpoint-ORIG-GUID: faZwThJGdnlATeHWnbV-u8OVvw3nmjHY
X-Authority-Info-Out: v=2.4 cv=UrFu9uwB c=1 sm=1 tr=0 ts=6aab146a
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=MJSrpaO5NUvuYd39e24A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMxMCBTYWx0ZWRfX0lWg/qzWmK5f
 W3rRI8tk5ByyGSNggMT6uilvE0Xuhc51VmPV559rv+ySi42AKQ6L1IHCLEcaOXn0ZB0RnvcJB5j
 EN0YDjFAc8CLuQodbtxs/xpMwQZ8DRWE6BCvem+OMRY/9calRhai+nPW1JKq4zP8IFyKbzC2172
 LIG4RheY+qrQY0Aan1kQLB7+QVFbj894oP1ZPntjoGiDPcExV6s29QXbT1lAOENjCKBcQq3Lkfq
 cTloSv8n6VZYqX+izu5CcEXwQYkXQT72dMn3PnA36hQBhl3tk4x+hZ8SSmPeuT9lFyTAHxpSC5o
 HwEdWsIgdTidvzzwupzp9DwnXDopDjbphKLmoqYTUbH1OvMSqAQNUDSFJfNXp8=
X-JNJ: AAAAAAABaoA0eLQoxOTkzg7VfkE7kikPBrjE0kz795EdQ08JTwzDdi8Be6BRChCztmH5BZhfIA65lNSKUrqDpjs/NH5s97JxWPQWS1xlOyDSiojuUF6dL4b1RuOQKIjUYT9Vqam8p/RFfeIWBWguYjHDqaYm91HLvfM7oGQpg3s0RiupHxR8ARzHvVssFQiW8ThXu82sf1+OW1SUaP0MacKaGJ6A83bVu8Dj2ixn10oDr4ojTj9X4SnPjD32Egi1fUxagwzojqDvR/y8gosb8I9XVeJ0R4MQ1h0/4TBptDzLdRkC9HWurVGx+fWE5mA6qlwoC9FOrvWTNOrX46rJw0qjINHf0RTAjIrkelHjJEMpWggNi8gIkUqpBtdGiRfAMvN7xhRSJEGuq8I686i1ginAvyaUZ+sPljM9viiUYAoroqEPG4IFobw9gjbrSgtgTpaIeKj4aHxMNCu2HeLabkfC20RQpS8efuvI52VA2AvpV6Z5wLzKN7allpIRtmbMB2TCbs35Y1YmcpwLbJYjSZLCYheScV4qnjfkwoxvhnvSEcuZSrTh5WTVviataL9OLwyxA3PmtcLS84yWxMgeZJoenFH2xCCT4PexRPt9dp/9b7nhU6/qaYEvyvwKneJaGr0yEMCLOwqRNC6nfgeXpVtmnCM2DWjtTSaSoptjzDwM4nmkeOPx/tfNzF/PmzDs8Ip7ORPfSN5g28zrryuI5kIT5f0YQJx9pfSgnt0c1hZD5/PrEpGWsuHmAHp28INdEzSMDeGGzPORUOqmh6XPUSi932F1ni9UHo5nUDZnU5Wg1EOF8Ajy1Y5OdFhtTL3Bp5ef3g3KzwMdeoYzvJnzC43vBxXByicz9D2rjSzMqVWKdd2B2NZJ9UQjje4ozHPotVbYOvVorlIL07k7XwfSZ9paEvKMJgfiXcGqedh++NLusLU2lNGE9R2C0LczLx7c+d1fDDiWxPeQG9KmADrX/1sGcQeoWLs
 5Mgw71NiRHGWesrQsb8NxO5QYNLxQP9Fy/L5STYQAVQP7Ufr/6A46XFz2nCCBHOV6rrFXISGOImqhce6/8M2U1VNokldFN5cH2DagNM0f4NhYTeIcK9gGYloVU6bNRpUtFIuAsfnfpNcbyLanYAIpDXDWsy7QBJU+Zf7Qb6aWwtCRGDLJqbaxEfVqUT8ggEmEkHJpiaOe/32SBFgbhmfl8Ch7aiydjZQBfVFmoPpDGA4qLWkGmxbcYLC9DRI14Yi6hIzC0vm+YgxeEbVBx62xVV1pqA2X0PUpL8Jsbn3mXqD1JNNjD9BxqMvxdM1Cddoc
Received-SPF: pass client-ip=2a01:b747:3002:201::2f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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



> On 16. Sep 2026, at 23:49, Doug Cook (WINDOWS) <dcook@microsoft.com> =
wrote:
>=20
> whpx_arm_get_ipa_bit_size() declares WHV_CAPABILITY whpx_cap on the
> stack and initializes it only via WHvGetCapability(). If that fails, =
the
> error is reported but execution falls through to
> round_down_to_parange_bit_size(whpx_cap.PhysicalAddressWidth), reading
> an uninitialized value.

Hi,

We have default values on the stack as initialised as 0 in QEMU.

>=20
> round_down_to_parange_index() searches pamax_map[] for the largest =
entry
> that is <=3D the requested size and ends in g_assert_not_reached(). =
The
> smallest valid PARange is 32, so any smaller value aborts QEMU.
>=20
> Fix by setting PhysicalAddressWidth to 32, the smallest
> architecturally valid PARange.

Where are you getting this condition? Is a certain Windows release =
broken
there that I=E2=80=99m not aware of?

Or is the hypervisor present check not happening early enough?
> Behaviour then becomes defined, and
> where the guest memory map fits within that range initialization
> continues on to the accelerator capability checks and their more
> specific error messages.
>=20
> Fixes: ea475a5ebb00 ("whpx: arm64: clamp down IPA size")
>=20
> Signed-off-by: Doug Cook <dcook@microsoft.com>
> ---
> target/arm/whpx/whpx-all.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index d106400686..dc70b33bc0 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -663,6 +663,7 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
>     if (FAILED(hr)) {
>         error_report("WHPX: failed to get supported "
>              "physical address width, hr=3D%08lx", hr);
> +        whpx_cap.PhysicalAddressWidth =3D 32;
>     }
>=20
>     /*
> --=20
> 2.55.0.vfs.0.8



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E52CD3423
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 06:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJnHF-0005hq-OY; Mon, 04 May 2026 02:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wJnHD-0005h5-Gm
 for qemu-devel@nongnu.org; Mon, 04 May 2026 02:59:35 -0400
Received: from p-east2-cluster5-host12-snip4-2.eps.apple.com ([57.103.79.75]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wJnHB-00053Y-Md
 for qemu-devel@nongnu.org; Mon, 04 May 2026 02:59:35 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-4 (Postfix) with ESMTPS id
 3635D180012D; Mon, 04 May 2026 06:59:29 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRPEwVSB11NVg1HD1geXBQXC0dDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTH1ABywDXHBIFEkGWAJGBjV9Th5UdSgHXXpMcFkEWHZFfU9yKXceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777877970; x=1780469970;
 bh=SZZ4bD46fodlVuPnhZ5AQeC05oNsIViTKO4hoZMC2ug=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=dNbwqt5yQUmR0I4DBiGNPL9EK4uhtaFRXcpH3xxUk6iQYWn34itE7U3z6p1mHbekbeJwGEW4M6S5bwQQ3IpJOUVzIkrJz/8vxuycqYGeK+/cI/9agvqM4sibfIBEIuX56ZAVxvY5pAQ0JFTe223Aq09mwm829hN4nV3FgIcd15AzZuoiEyvvgNWrlNjcycW0p84xAxEkcTGh0v0sscPQQvXoXbGBe9L2fVtOjeC3JxosGe8ClrkkHGONA2fBenSu8lZxRoongBP/BoPlZXZhfcrMnvlG3S9D/I6wIqnovKxSArUOlWHK0BPZpw0owMdppwx+qjjHqnRhGtpl7CmowA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-4 (Postfix) with ESMTPSA id
 C56BD1800096; Mon, 04 May 2026 06:59:27 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] hvf: arm: override HV_SYS_REG_MDCR_EL2
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <e36f1d1b-89db-443b-aa48-6247831a8247@linaro.org>
Date: Mon, 4 May 2026 08:59:15 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D84A47B8-1555-4ED6-9BC5-C4C433D5D7AD@unpredictable.fr>
References: <20260501231353.63184-1-mohamed@unpredictable.fr>
 <e36f1d1b-89db-443b-aa48-6247831a8247@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA3NCBTYWx0ZWRfX50j64LuHqecN
 YIcHpO62soAvTBq8MJHwgegjcVYubLFuCqJ4ZFTjNh8NwD4lXF/cijuKtzzXs3mpPBqMu6kXbTV
 +EF2CdZ2NRr3HcMgylD0/u8QU4b+BECIsi6y54Zv/DFLjeKVTZQ/A4WzJaJyUjsQbKU1WtxkU3Q
 LAHjxPNYwRT9CpYAsitmqbdjUvUc2DTsi5wTjgnqIQ8BGNV84+3XYpXgpAuiaFtrJYzwZ5D0o67
 rYoRHym1B8cjWNfuFA14nNuuVV/fAy1OAUUxC+a47urud0Nm82rXwrNC9fiAYd1nsFV4wjfGxt7
 bMD268nM8RTJF//wd7en+oaih4Kqodn3tFwKwgOI7gX/mfBUiPJenlKI9CHE8k=
X-Proofpoint-ORIG-GUID: 977kQRD9JuIrGFmTpOjcIDt4MIWGO4Ch
X-Authority-Info-Out: v=2.4 cv=GbcaXAXL c=1 sm=1 tr=0 ts=69f843d1
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=t-IPkPogAAAA:8 a=KKAkSRfTAAAA:8
 a=uypWpLIWIABjCLFm2_QA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 977kQRD9JuIrGFmTpOjcIDt4MIWGO4Ch
Received-SPF: pass client-ip=57.103.79.75;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



> On 4. May 2026, at 08:49, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 2/5/26 01:13, Mohamed Mediouni wrote:
>> In older SDKs, MDCR_EL2 was defined incorrectly.
>> As such, override it with a #define if compiling with an older macOS
>> SDK.
>> This is a workaround because the macOS CI setup we currently rely on
>> has not been kept up to date, to be able to land nested =
virtualization
>> support.
>> Once CI is updated, the SME stubs can be removed and this
>> commit can be reverted.
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  target/arm/hvf/hvf.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 4f0f7ffba1..79209bc8e9 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -468,6 +468,15 @@ static const struct hvf_reg_match =
hvf_sme2_preg_match[] =3D {
>>  #define HVF_TO_KVMID(HVF)  \
>>      (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
>>  +/*
>> + * In older SDKs, MDCR_EL2 was defined incorrectly.
>> + * As such, override it with a #define if compiling with an older =
macOS SDK.
>> + * =
https://lore.kernel.org/qemu-devel/BCCED674-EAEF-4755-9BE1-116FB36FB5C9@ap=
ple.com/
>> + */
>> +#if !defined(MAC_OS_VERSION_26_0)
>=20
> Not sure about this check, i.e. wouldn't it clash with 26.1 release?
> I'd expect a check such:
>=20
>   #if MAC_OS_X_VERSION_MAX_ALLOWED < 260000

Hi,

MAC_OS_VERSION_26_0 will be defined in all future SDKs.

See AvailabilityVersions.h in the macOS SDK, has all of them since 10.0
>=20
>> +#define HV_SYS_REG_MDCR_EL2 0xe089
>> +#endif
>> +
>>  /*
>>   * Verify this at compile-time.
>>   *
>=20
>=20



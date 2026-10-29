Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E5606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=AsGH6zl1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTWw-0002Ps-8S; Thu, 29 Oct 2026 13:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xMTWo-0002O0-OM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:03:02 -0400
Received: from mr-2005i-snip6-11.eps.apple.com ([2a01:b747:3000:206::5b]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xMTWl-0006wp-EA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:03:02 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPS id
 2C2E818014D1; Thu, 29 Oct 2026 17:02:53 +0000 (UTC)
X-ICL-RepId: 01a1889d-5218-75e4-b6ad-8723dba82650
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0NWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkEJSQUuAFt3XQE6Ai4aX3RDf1VyXA4uH0UAPAQsBy4ERnhLAC1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793293375; x=1824829375;
 bh=Td8hiwhed6UN72QWwL0iSGXMtTdqAbmPDmAVAaqwzVs=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=AsGH6zl1A8yBgOiatNtPRBLokad18dM0fK3x4LlnKKisYC7fcXhWSohGupaPrOLrmYZynjO4C56FTowbR10gPiy6oso5CIiQcGorC7SuMpBYumSKmypygz5MZbfgDbIJIj9qX91o5CM5wbYeqB5DV0AB3a/4mSH9PiE0eY8tz+zW8/IvYS2nM4yocjitjvAF3IdxzV23R2NB4c4MM6n5o8LlHn57t8bVajdvrd/zidaz+a8IyvdbuzfQ9vcvh+RRg8Gy/Vc6OpA2+VmLJZ/25ll9KkD845IsZLco7zbh4pRozh9E3mMz2PQ6J2Z6pOivAHoEXaHoSaY9dBRjlhaRfQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-9 (Postfix) with ESMTPSA id
 D0FC31800EE2; Thu, 29 Oct 2026 17:02:52 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v2 0/6] hvf: arm: fixes for QEMU 11.2
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA-=bOxmonNOYC2_1MHDrdof6eciYrehJRDfWx_7kYsJmA@mail.gmail.com>
Date: Thu, 29 Oct 2026 18:02:40 +0100
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1016C70E-8B1C-4F3F-A19E-59D7A0E66A33@unpredictable.fr>
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
 <CAFEAcA-=bOxmonNOYC2_1MHDrdof6eciYrehJRDfWx_7kYsJmA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Authority-Info-Out: v=2.4 cv=S6fUAYsP c=1 sm=1 tr=0 ts=6ae37c3e
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=m0ZDXWi2_AsMy-86mYIA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gyCz0kwM__JjVtKiQ5uatGBki5H8UnJx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX7eqryMMh8eJt
 FUuUP/Hpd+KtmewW4T87XxdlIUj6QVmQx79lGoj6eZHhFw2ZpiPTDQRhsnvC7yvAqgp5tGBvmoZ
 p4EECAVNts1Y7qNBKo/T3um7WiQEHju5HfhqhXQXGgLOBGKSYlaFbASCKuUs7EXwMkKZRyVtDo3
 pB+fccwYbCtpo/sY0ZHAhHNZMVI4rC/V60FU0kdQblvG07Sjl7Th0TaJJLVWyKDL2Y3H0oaNtIL
 tOfLC60HvAwOI7POKDRpJZ/24OYHAyrq74tAy++2uGlT7cgA7RpjE6AvdraRUWPmM4Ovnf2GX5y
 gv6Ln8hjH1pqo+I9inNWPVSx/y0r/lc1FHb1Z+/NOfAQu3s9mB0wzTkPY8O8ec=
X-Proofpoint-GUID: gyCz0kwM__JjVtKiQ5uatGBki5H8UnJx
X-JNJ: AAAAAAABT+tEZRhFDE3YxcXBZVSug2kqagxuFQiJYMcwORfS6czaZ244ApajtQepV/Y/+o
 MAlMPcGaFaor7rdAxEMoSNUfIvSco5SGPfP/g5Du+M4o0VePzr+6GQTUzKYjs4FlSFDa2g
 knJkC0km2K99b4brWDyjDrTHU161VhYu8rZWFOKFe7cw4k0Q0GJ00tkLflltzQisf5w/EI
 rK3b9yaW1VayzsCf5ICKLkuZ4lL56T9EBju6SSODfKg8pjgBl5r2E1khctym+j83t7Lxuk
 Vxo8Ti9z/R0rWBTTcbBk2+wCOr41dnZVs7jgMCuaa8KD3moZiRp8y6wN0gEXRLnB8kG9oD
 OxvVO8mXUnac8Za/3D41XwPVNN8pUtDsEnosnUhcYfHJfoaaPKqzvgJWRlw1eKIJ6ym3F2
 QCb6BS9MwL4evC39/xvBiHqMiMZV7H3VvgtpdZtygVkxbt2UwlfUc1Pbyul/OVz3td3AeR
 0l0ovIGzWqQI7hD3FHUWbj7OjBpf75sJk8Xdq36da83rPu1vlREO7vSW7WB1JmY5hnfqQ0
 e1f/XDCr0n452tiq74rwUl4ZGthu2onWra0k03/cWa7go+jQenXHNuPogrmdmLmrwQL4oy
 aFXV8v5zDUbYh3Nf47aL45yA5Jg69tPFazREWVHqTjcF4JNkp+SuvWwhaCuaKviLVDaYVw
 0B6vL6SAmfD/3EUe/E6RJ0toSueTtDiBnlPIHH/ezF7jYJMr2yMfeSnhye4rIiYQcRmrx0
 y+MHRoAumiGNjh4NlIjWaK6saEOeLDqZ9Ejc6gfBs4ErCLOVoXW8IVRqbtuWJ4hmkCvSLk
 XNm+5S0kZ3cT4PchgOSkJYPurd6GKXT1tn0cQTABKS9v1M2T+kZ464N6uQB+6aW769Sj6y
 GrWctcyi5G8EAT0qfoRYu7cineb5m8Npr/z+k66VEY1Z4QsAnn6M781xPk61qdkAjGH1ks
 /TVqf4zPwANaRDJrlUSf6SDgj50gZ80Mv2XH+k8zYF3Ypb4bY/odiBG+uCGt0UCFOxDn1U
 QFBBqV3vkpHUeBZP74/xi95nCCESv6y6iYnYFAhjF5Ut0kLadqY/rsDc+imABCbTnv8+Za
 aeY0IRGHRFxpb6oiSIu+qkKTSCMsLIxzrwCaKTIsfXUyU604/l9k0z0gb9b+bGBAeU3cCS
 r2WG0/7plI3/5X4Lk4Wy/aXBOJWwXBnpgcLvdnOvHXvsGO6YDmuoc9d+iiL3TGHstnLyWM
 MQp6ZBqnkCvP+qDon9ylyU89yjYX9EGFWtf/XEIS5zn2XVERbQXBYuIea+WurWnQ5jsvzm
 f+wtkxe4ShHo3yU37VjzXyXoOyRH8td5QTcJTTzJqLsgJH8j6CnkudCzqV3fS7XOKQqR3Y
 IYtC59xZ8maGX9OsjuO5L27HIRx6nJ16ND+t4bXm5FowG23BsUj1eAGG
Received-SPF: pass client-ip=2a01:b747:3000:206::5b;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 29. Oct 2026, at 15:27, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Tue, 27 Oct 2026 at 12:03, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> v2:
>> - remove GIC_ISPENDR workaround: currently under further =
investigation
>> - simplify SME save/restore patch
>> - rework the CPU reset strategy, with also taking care of the GIC CPU =
interface registers.
>>=20
>> v1:
>>=20
>> - workaround for presumed Hypervisor.framework issue
>> - save/restore SME state only when SME is on for the CPU
>> - add ID_AA64PFR0_EL1.GIC sync to advertise the system register =
interface
>=20
> I've applied patches 1-4 to target-arm.next; 5 and 6 I left comments =
on.
>=20
> What's the status with the apple-gfx compile failures on macos 27?
> (issue #4486)

Hi,

I think we should just disable building apple-gfx by default for now.=20

It=E2=80=99s private API as of macOS 27, and as long as a decision on =
whether
to keep that reverse-engineered device model isn=E2=80=99t made yet...
>=20
> thanks
> -- PMM



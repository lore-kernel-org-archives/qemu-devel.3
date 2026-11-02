Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7AB606AEA9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=U5ufy/c/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNvYY-0007rR-6V; Mon, 02 Nov 2026 12:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xNvYT-0007qS-KE
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:10:45 -0500
Received: from ms-2004e-snip6-11.eps.apple.com ([2a01:b747:3002:205::33]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xNvYR-0006T9-Lt
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:10:45 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id
 3841B18001DB; Mon, 02 Nov 2026 17:10:39 +0000 (UTC)
X-ICL-RepId: 01a19d3d-de1e-7af4-ba2f-3264c0b4a1b0
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0NWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjIOOQMpcykLXQ9OdSkaX3cxfVVyXwEpHzINTndddF8HSAhBdi1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793639441; x=1825175441;
 bh=o4Pt1QCgsqB5Kjn2ruHTCmf0+yuQZD2Ht6pw3UGJMMk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=U5ufy/c/NCNekIKzOOAKnBDbyTRH+zkptLhxWT6YnswPBwHDHy2lVCf4fzOMAs7FTLwS0Cco96n7EPWBcETZ870UkZcjY/R1dV4avxhlePq/06eVs/qEU6csFmuj6WHyfDB9DoV7P8QQgNpAU+6p5b62bI83Yq6lqsQkUZFXVZohjTmCDfRhnEis5bZXmlZ2ldIp/7UnjNzH5BGrYdZM2wylKw8BkgfNTKWz/C6UHqT9zq3HJqJqG5DH9xL4eYofVjoq+Xb0V1SRbMrXSTHtkYuVTXwkVl1ApU0NmHuTHkjuOMKX/TWLfcTnEC/m09wSrt2lCycYeG6OOh8aVFSk3g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id
 A883618001D2; Mon, 02 Nov 2026 17:10:38 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v2 4/6] hvf: arm: fetch more features
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA8YN2+YuU94W=+6Z-YBaG54Db4E1hkYdzn4DrSW0J8dkw@mail.gmail.com>
Date: Mon, 2 Nov 2026 18:10:26 +0100
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B7A0DDB9-66FD-4EAD-A26B-B46D0C45819E@unpredictable.fr>
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
 <20261027120135.53048-5-mohamed@unpredictable.fr>
 <CAFEAcA8YN2+YuU94W=+6Z-YBaG54Db4E1hkYdzn4DrSW0J8dkw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-ORIG-GUID: bo9bSOrlcV5vcUWKg1d2pO8O0g-7qS1P
X-Proofpoint-GUID: bo9bSOrlcV5vcUWKg1d2pO8O0g-7qS1P
X-Authority-Info-Out: v=2.4 cv=DMmCIiNb c=1 sm=1 tr=0 ts=6ae8c410
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8
 a=0mXhovE3T8ghJ8cGMUsA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2OCBTYWx0ZWRfX71HVW9GTPnxi
 NWvTYUI8hWuioVP0mrFJ2Ur9lPZfayLHH7eBV46nTYyOB5bhiwJrds8bT1TLeFTQyRXjUm+0jF/
 8mhEzirUDrgiimMxj3TEh118BlxmYIxp7ofCibIHaOsPUWgXuwCea71NahuKeOHfHAPvet7fh9l
 PgqiAItSVaVNPCajDv5HQtIHZfqiAmh2HZddNBq07sWTRVLmaD5Gl3WNfjwqCpTAJ8XJNcMSHC1
 ud45ubYYfZIeRuaHEh6KY+VofIuaEzQnsId+s5huzLib9cYlV1qaZaKd54NTmkSt6bR/2eIa6bA
 A2sxfW73rDJcdg5vuwGrYg9ulHM7bTETdEr+e8mSs/pAzWmkHfeU0ym77/+Rn8=
X-JNJ: AAAAAAABw3fyT60KwIyAW2x53+ytUUlBrZMlCSUDRrTdFArDCejIlxFBp3npvkIW691NpB
 7pUdXjiP6c/YUIvAkBZEYfNwYdF7y6zDhQhQSZvteuDYySTHGPOD9+eEqsGasEcpZXX1+6
 MV5Kdo5lVsoPLMEz+S/v7DBRZi+YGi6QUzvLES3azxc1514Amgn//WKbjGXjZPLXtWO+vW
 a9PvwOpKto5Hkbb5B5qdM2BIy3RKSdSeBaflfoQnNgq+D0rlsGYVGTttf2+etqS/GOnji/
 y9rIUc1V5g0Yfd4FVod/NY5S9pYPZ9etz3hMn6vUGAQZKPza5Dw1HycW9XwogKi8qDaBj3
 +QXjkMCaiybQatzPCva9xE3TVUhoPisFAbBI44UKbPr1aiNakWB5t17DjxwAU6QWOLLgqH
 f9Ns1D7p0csJclhpbFLKkgBevNaJUY2kdCmfEcD2O7gvj6hUiKpG8IZemMwsOJuSJnUJSx
 pUevlylcU0V+4gr/YfdbazJOrHdoO93nJ1F7fx0lVLjle5AwCuf3qdPYV8SSM4AeTRh8hn
 7w2YhM1KUcPm/rPhdLGrQbdIduCJgbIxBdJcpzuUHQA2st0aT+zDTCCQvEob7BSxkJvF5W
 1sYPfEK2K8kBE89voPlvZmTikvxQbUOVRBv/QvxbBnaTcbSK7b5cBj7JjgZCB+deVDB2Ze
 HW48M+BY8sd0RVtS5SOf2K2eq1zytUgly+4JKIhYOO5I3hap9KrAH4DD6RtmuSQmgLf6qN
 Qzxau+FwMrEqF1CJS6jhugf/K/Jzbf4Fyu/uWmqbn5d46wMGRbtR8rIxnFPvq1M4PdWn4I
 A5dNMYLQkRHF+6YvO7FnPAiqO9USMrw413i+aCvRgyEvXnMt7h6Kb/WT2DbR9r0IwuIQ3J
 A6vbCgxHorV64ILFhQw5gTGOqwa2SaYbi+Pz9XFtqO7VQgJVeV/8GqP9fQ4yMBefno7qgX
 tjon2NHOk2EWOYB6dlpUiT/HTZeim26ilT4rnkY6WNL6+8J4tug72/N0pixR8NszDfM2SH
 Yr2mKEU3V3xQP7dy9X8q06xvMJJBE4BMIYIWVqKQcFPmA/Z4YaqyYdFQkjF5ywaA4106hI
 wuDViPRmiANodi+IvTxz1LLgcNlG9GX4VUJ4IpGWkN0dCiSmyy2R2a2Yx/311G5Sl2MiBS
 ZpM/3xj7Zkp49+sLh42rtYhV1lGLBJDsmGUgTRTHvf6os+ns+qFmZn7PWE3M3DcZ/mypxZ
 SHVwn6cL6TnZ5OYBvW0pP3jMyd2iqX9DZjbCBS5t4f47q381v1K7LT9kjHZp0xro+AThfW
 FnveRFWomNd/EbTzVPoY/A5cgT7od+WawG+QgS+rV/I7KvfWf+VGN/XdfOoexhZg5GTVXS
 +1NjKEbmnsIAxauDAT73dJY=
Received-SPF: pass client-ip=2a01:b747:3002:205::33;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 2. Nov 2026, at 18:07, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Tue, 27 Oct 2026 at 12:01, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> macOS 27.0 has some more feature registers available. Fetch them (but =
not using the values yet).
>>=20
>> Also fetch DCZID_EL0 at the same time.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> This patch failed on the macos CI jobs, so I've dropped it from =
target-arm:
>=20
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/17671032296#L4708
> https://gitlab.com/qemu-project/qemu/-/jobs/17671063089#L4702

Hi,

Thank you, sounds like an SDK versioning issue again=E2=80=A6

Will look more at how to decouple the SDK situation (or we=E2=80=99ll =
have to have
#ifdef everywhere for everything new)...

The latest SDK provided by the CLTs can back-deploy to older macOS =
versions
all the way back to macOS 11. But that still supposes having the newer =
SDK
available in the first place.

=46rom the CI logs, looks like they are at macOS 15.0 SDK which is =
pretty old by now...

>=20
>> ../target/arm/hvf/hvf.c:1197:11: error: use of undeclared identifier =
'HV_FEATURE_REG_ID_AA64ISAR2_EL1'
>> 1197 |         { HV_FEATURE_REG_ID_AA64ISAR2_EL1, =
ID_AA64ISAR2_EL1_IDX },
>>      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../target/arm/hvf/hvf.c:1198:11: error: use of undeclared identifier =
'HV_FEATURE_REG_ID_AA64PFR2_EL1'
>> 1198 |         { HV_FEATURE_REG_ID_AA64PFR2_EL1, ID_AA64PFR2_EL1_IDX =
},
>>      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../target/arm/hvf/hvf.c:1199:11: error: use of undeclared identifier =
'HV_FEATURE_REG_ID_AA64MMFR3_EL1'
>> 1199 |         { HV_FEATURE_REG_ID_AA64MMFR3_EL1, =
ID_AA64MMFR3_EL1_IDX },
>>      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../target/arm/hvf/hvf.c:1200:11: error: use of undeclared identifier =
'HV_FEATURE_REG_ID_AA64MMFR4_EL1'
>> 1200 |         { HV_FEATURE_REG_ID_AA64MMFR4_EL1, =
ID_AA64MMFR4_EL1_IDX },
>>      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../target/arm/hvf/hvf.c:1202:25: error: invalid application of =
'sizeof' to an incomplete type 'const struct isar_regs[]'
>> 1202 |         for (i =3D 0; i < ARRAY_SIZE(new_regs); i++) {
>>      |                         ^~~~~~~~~~~~~~~~~~~~
>> /Users/gitlab/builds/qemu-project/qemu/include/qemu/osdep.h:541:31: =
note: expanded from macro 'ARRAY_SIZE'
>>  541 | #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
>>      |                               ^~~
>> 5 errors generated.
>=20
> thanks
> -- PMM



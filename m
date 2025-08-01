Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1678AC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 20:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhwmM-0001xp-4j; Fri, 01 Aug 2025 16:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhvt4-0007IG-1F
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:57:57 -0400
Received: from p-east3-cluster7-host3-snip4-6.eps.apple.com ([57.103.84.157]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uhvsy-0006bL-4y
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:57:51 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 A330D1800178; Fri,  1 Aug 2025 19:57:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=uhjuJh0geqkd1wPTBbXxDgtEX4zXBmg8NbgbVxyc5v4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=f3qh8Q+BB39JQ8d/3GYWSRnTdIynRpSpoNlWPljwd4oy6dt7q3PUiiDnTDT8YJlVU2l/mDBftoR0MGVEY2539q5g/PWccthludoEZ5epalF4+cY1fRhlH4BG4nznO+OnvMvdJCa1xpY8JTsEt6L4OEuLyXkl3PW6OemB7XZPcGzUzUbPHpa3K3D2/5sB3lqAKRSMu7L1gbefu4spNIpWv8YBe8Lov8mqTpCV+yvfS9e9y/0RmX/Ivkrfxr5LA/do52C4j+To+tFuFLRXZqoNFfrizu6u/4ubzrwGeMg58XX9bDIC9dVkXMPe2LXY7U4SdSJw4MKNzbS7EZivUNGlIg==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 863941800224; Fri,  1 Aug 2025 19:57:40 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [RFC 0/9] WHPX support for Arm
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <b613245f-dfba-4f9b-8914-7c1e73c9dba5@linaro.org>
Date: Fri, 1 Aug 2025 21:57:28 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5133CBA1-A4FA-4789-AA7D-2FDBBFDF2470@unpredictable.fr>
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <8af5e691-da19-4141-8874-51ca685288ac@linaro.org>
 <864AC97D-2C45-402A-92AF-D0FDDB72C40E@unpredictable.fr>
 <21266cf2-887d-4bf3-8c9a-7633bffd8cd2@linaro.org>
 <17413DE3-C53B-4DA6-9777-3E772D2C2C2D@unpredictable.fr>
 <d495bae3-d252-4b79-883a-3f5f815c5feb@linaro.org>
 <5A71E199-4C6E-467D-9E9B-04DE9EF1A9CC@unpredictable.fr>
 <b613245f-dfba-4f9b-8914-7c1e73c9dba5@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE1OCBTYWx0ZWRfX/xQC3TMGV5Kk
 0KI/tuxpOO5q7AkRyBMSDWC7rX7/fCSMIkBLSOu+uY+fTHbCZBVwTjKoNXhGpp7BlEHQasugxVu
 tlf6HuF263dHuAs3GkLCvu5NVK1nEA2CPn6gq/TechnRss4vX3M26yRUCm6zXvl83WHGXNo/5Qx
 IOI8LDJ7xu81j+tAdlm9WK6jdpzka2XlAjt2WbiVIfDTnF7OcmEDmaeUj+m676bNNDh4PL5af50
 +oLTC2UeLIMktPsK7+3VVgWUaqdhOCR0mvl8HxYehs/DJ9Ip5b9KB+2p9PmDj197Ce/eRDNpM=
X-Proofpoint-GUID: HNQf5xq8yGwcu9E8I_S6oiGkpE2A4UIn
X-Proofpoint-ORIG-GUID: HNQf5xq8yGwcu9E8I_S6oiGkpE2A4UIn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 clxscore=1030 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508010158
Received-SPF: pass client-ip=57.103.84.157;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 1. Aug 2025, at 21:42, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 8/1/25 12:31 PM, Mohamed Mediouni wrote:
>>>> I didn=E2=80=99t test anything on the stable branch for now but =
only on Canary so far.
>>>> Just cursorily tested (EDK2 only) an X Elite device on prod =
(26100.4652) and this issue doesn=E2=80=99t appear.
>>>> I have 8cx Gen 3 and 8cx Gen 1 (SQ1) devices around, will test on =
those older SoCs later and see.
>>>> Random idea for testing: what if you put -M highmem=3Doff, does =
that change anything?
>>>>=20
>>>=20
>>> Good guess, it solves the problem with edk2, and direct boots linux =
kernel successfully now.
>>>=20
>> If you don=E2=80=99t mind, could you please test the latest commit I =
just put on the Git repo (whpx branch)? It should address this properly.
>=20
> Sure.
> Without highmem=3Doff, I get a new error:
> Physical address width: 36
> C:\msys64\home\tcwg\qemu\build\qemu-system-aarch64.exe: VCPU supports =
less PA bits (36) than requested by the memory map (40)
>=20
Oh this confirms what I thought, just pushed a new commit which should =
be a complete fix. :)

And accessorily is also a good thing for Snapdragon X too, as 40 VA bits =
were used there despite the hardware having 39.

Thank you,
-Mohamed=


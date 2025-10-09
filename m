Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169E0CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 02:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6gW3-0002jF-8r; Wed, 08 Oct 2025 22:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6gVz-0002Vr-8S
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:36:25 -0400
Received: from p-east3-cluster5-host2-snip4-8.eps.apple.com ([57.103.86.149]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6gVs-000812-V9
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:36:22 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-10 (Postfix) with ESMTPS id
 12A39184ACD6; Thu,  9 Oct 2025 02:36:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=DrEI+kQ5A2j0E2bb2LGyhrbbxJk1fkRV/0em6w8QAHI=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=f8yixT8v6xMARGv3K/X0zOUAXGRF1G0RzKx6DpZRceFTF5Nur7LrzGuXbcE8hfzsLBSkBMTWCL6odih41atshSKvKg5y5ft51fCQvBPBIYbYjKhjYfHiW2xQdUCJRMJu2EkWoiieqp/eCOA/T6Q2U7zmLAzSQQVeLyXWD/AqROIwxYrzvBsy0EarzZRaD8G80cWMrlQ/7jtJQhVaF9tf2k1SSe7xHAl+fg+IsMug5rapgW+JdGAw0Kypj26ce+6FVi6q0LnRNc5/Eea1S08R3sBi1lcpeZtqRxA4Qsmvk2OHPVeIZlkdE5Wy/xayAqq3ErojKQSACQIADM6Zf47xWQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-10 (Postfix) with ESMTPSA id
 07A271800D2F; Thu,  9 Oct 2025 02:36:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <774802D2-E1B7-40B7-A189-82B4CE18B152@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_3211F23C-F7D3-4C26-9AE8-DB4552D22EEF"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [RFC v2 2/4] hvf: arm64: add workaround for Apple M4 to run older
 macOS versions
Date: Thu, 9 Oct 2025 04:35:54 +0200
In-Reply-To: <19C5D37A-55BC-438D-951B-72A36FF67948@csgraf.de>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>,
 Maydell Peter <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
To: Alexander Graf <agraf@csgraf.de>
References: <2399E8DA-E73F-4B59-8E06-F989BA2B462E@unpredictable.fr>
 <19C5D37A-55BC-438D-951B-72A36FF67948@csgraf.de>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDAxMyBTYWx0ZWRfX2bacyqn6wuvS
 YqbP6hRx9EmUSCctY082aS9EfN/18eSeTgakeT7BZDhb+kX/YhcFauWEQXAbh/vVuzjBF4lAfeA
 Cfjco0htha4qymxAnJIZkQFZk00Fhh5yW/Dmg+sHlNjmE5K/hKZiGexygQKPKiKdZbckc5YIg9f
 zFyiyN42F2HPwfYXbINLHyl3R3/Ng80dokIE6cZ5hmYhmNYHyFqc0GfigRr8Ivuj0iUclySfKRY
 3D4bbFTpKy/3Zq2ntmgxll0rBgloQuKSoFdKLjr72CAsz99hkWQQhniK2dVrCpa4cqug2EERo=
X-Proofpoint-GUID: 75QYtl4f4kOwtMILkFQDLSaKQXVYbTC4
X-Proofpoint-ORIG-GUID: 75QYtl4f4kOwtMILkFQDLSaKQXVYbTC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 clxscore=1030
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510090013
X-JNJ: AAAAAAAB+qQGj7+xUchlN4i30Ynxr7iiTe2M4G7jjvpRZUKr/zLKRHKeQagnPrUZ41/L789exHRQCNLd6xe3eOCMJC5uIHfi342TC5n0dOWZR+kS78sfpbSHPlaEMv5bxviXPEhNZc+r/38s8Ea7N8PtuZZ1bVljcirUopp1U99FnO10UsJZpw7JUgsMhAIdr0utSOqOifpXQ/7NyfOuhEh8ZeeiBmTXTY4Tr3UYIT0Vcpepg+DqJ+8ysCqN9UBWpKcAWlWqxiS6RdqYmDqsazA9CHcOkovCuZxc8j+DwEepxdz7Wm1mz5tGCItkGdJnpUCdv2cc+/PqRseb8mk5LVuUpwDvH573BzZLdNWNaG/PHrzP3gZpusWLZ0smh7IrEBDF8S8z4W1JzeAEfXGpI4rnzIPJ0eXdP3WDB2ASDB4FBWEYjHlXnKLIRhh5CDWpavd4k+Ar6CJFZfu6m4iTqDvt5is+9hZXJcOcTBMMga++J61w06k4GIfFn47MCOw7E+u/+2xWUV0SXoVBCuGw00ufPvClOP3ORih3dzKrW0nWN9jX1J1sAj43pkjDV/gLRMymKokY6PVDcBWA6WHE3l6uQP1n3FMhPOFyO+w7UUSC2fLoj19KYZKGgHrqE93blqxNpIBH6Z/FFpUTc3Z/qgpmHXNIFBzpjwypmjfSdDeJsZvlukKDs3wgdfkGWYWCQc0w05MKEouZAa1gRRqFowllb/Uy2NmBt37hslKdw3UzJ+pxLagRvYBRQK50j3bXWFioSO42n0g=
Received-SPF: pass client-ip=57.103.86.149;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_3211F23C-F7D3-4C26-9AE8-DB4552D22EEF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 8. Oct 2025, at 22:00, Alexander Graf <agraf@csgraf.de> wrote:
>=20
>=20
>=20
>> Am 08.10.2025 um 13:36 schrieb Mohamed Mediouni =
<mohamed@unpredictable.fr>:
>>=20
>> =EF=BB=BF
>>=20
>>> On 7. Oct 2025, at 23:12, Alexander Graf <agraf@csgraf.de> wrote:
>>>=20
>>>=20
>>>> On 07.10.25 22:31, Mohamed Mediouni wrote:
>>>> Apple M4 removes FEAT_SSBS. However, older macOS releases
>>>> do misbehave in such a configuration and do not boot.
>>>>=20
>>>> Use private API to trap SCTLR_EL1 accesses through FGT.
>>>>=20
>>>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>>=20
>>>=20
>>> These old macOS versions did not include M4 support, correct? So =
wouldn't it make more sense to make more recent macOS work instead?
>>>=20
>>> Alex
>>>=20
>> Apple ships such a workaround in Virtualization.framework to allow =
older macOS VMs to work
>=20
> Fair, but we don't have to implement the same hacks :). I think from a =
user's point of view, running macOS 26 is more important than 12 :)
>=20
> Alex

There are at least two mean things that newer macOS releases do on =
vmapples, but I=E2=80=99m pretty sure I=E2=80=99m missing some more:

- an HVC #0 with x0 set to 0xc1000000 - this is not trapped all the way =
to the VMM but handled by the virtualisation stack.

The value returned is zero if the VM is running with a private ISA =
level. The guest then checks it straight away and goes in an infinite =
loop if the value isn=E2=80=99t 0.

Fine, let=E2=80=99s run with private ISA and see what happens, well...

- An access to the GIC memory ranges that doesn=E2=80=99t meet ISV =
requirements - using pre-indexing with SP as the base register.

That said I got pretty far with handling those two but I=E2=80=99m not =
sure that any of this is upstreamable really=E2=80=A6

-Mohamed


--Apple-Mail=_3211F23C-F7D3-4C26-9AE8-DB4552D22EEF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 8. Oct 2025, at 22:00, Alexander Graf =
&lt;agraf@csgraf.de&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div><br><br><blockquote =
type=3D"cite">Am 08.10.2025 um 13:36 schrieb Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;:<br><br>=EF=BB=BF<br><br><blockquote =
type=3D"cite">On 7. Oct 2025, at 23:12, Alexander Graf =
&lt;agraf@csgraf.de&gt; wrote:<br><br><br><blockquote type=3D"cite">On =
07.10.25 22:31, Mohamed Mediouni wrote:<br>Apple M4 removes FEAT_SSBS. =
However, older macOS releases<br>do misbehave in such a configuration =
and do not boot.<br><br>Use private API to trap SCTLR_EL1 accesses =
through FGT.<br><br>Signed-off-by: Mohamed Mediouni =
&lt;mohamed@unpredictable.fr&gt;<br></blockquote><br><br>These old macOS =
versions did not include M4 support, correct? So wouldn't it make more =
sense to make more recent macOS work =
instead?<br><br>Alex<br><br></blockquote>Apple ships such a workaround =
in Virtualization.framework to allow older macOS VMs to =
work<br></blockquote><br>Fair, but we don't have to implement the same =
hacks :). I think from a user's point of view, running macOS 26 is more =
important than 12 =
:)<br><br>Alex</div></div></blockquote><br></div><div>There are <i>at =
least </i>two mean things that newer macOS releases do on vmapples, but =
I=E2=80=99m pretty sure I=E2=80=99m missing some =
more:</div><div><br></div><div>- an HVC #0 with x0 set =
to&nbsp;0xc1000000 - this is not trapped all the way to the VMM but =
handled by the virtualisation stack.</div><div><br></div><div>The value =
returned is zero if the VM is running with a private ISA level. The =
guest then checks it straight away and goes in an infinite loop if the =
value isn=E2=80=99t 0.</div><div><br></div><div>Fine, let=E2=80=99s run =
with private ISA and see what happens, =
well...</div><div><br></div><div>- An access to the GIC memory ranges =
that doesn=E2=80=99t meet ISV requirements - using pre-indexing with SP =
as the base register.</div><div><br></div><div>That said I got pretty =
far with handling those two but I=E2=80=99m not sure that any of this is =
upstreamable =
really=E2=80=A6</div><div><br></div><div>-Mohamed</div><br></body></html>=

--Apple-Mail=_3211F23C-F7D3-4C26-9AE8-DB4552D22EEF--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CDDC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97Cm-0004aK-HA; Tue, 22 Sep 2026 16:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <louis.naude@icloud.com>)
 id 1x95jh-0002oV-QA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:01:03 -0400
Received: from pv-2006h-snip6-3.eps.apple.com ([2a01:b747:3003:204::53]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <louis.naude@icloud.com>)
 id 1x95jd-0008Uw-Mp
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:01:01 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-9 (Postfix) with ESMTPS id
 791491800CAE; Tue, 22 Sep 2026 19:00:51 +0000 (UTC)
X-ICL-RepId: 01a0ca7e-0444-7d74-bb2e-5941963ca10c
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhIAUMFWgpeD08dXwNTEhVdRV8CQgJBXlcZRglSK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUBTV8OXh8EF0YZVQRHHl1WQxsZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD1sOLwBADUkHQAYuATIUTHVUAEZzRA0+Hi9zLQNJCE8EWwFYBjBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1790103652; x=1792695652; bh=+7bQJw3QRot5/5bMsWUTDHkvt5IzkZ3N5wuNDP6+1mA=;
 h=Date:Subject:From:To:Message-ID:Mime-version:Content-type:x-icloud-hme;
 b=IabhFDIY6VC1VPsWpe20HZfRlMOw8WOOiSSkT9Xd4nF0GVuEEQ+h2ys0n28oPdcY1c9synoLO8ZGlgmqbq/LA1PNOYioW1lFbJdxZCLMUufSjavysNu8rok0ckk8vzvPHwdpfFul+pjragCV39xYSJBl52LM2qzg9gOrRCgDjgNPcXB3/Rz2ayIlMxj9zSsjdLs6EYzzB7w+zpdCV7sa9pJKtzuFcm+6+BVBQmvRUdozukXCxNi82TPrgX0FXFwTb3q5H/7UAkzPN8C1CZJTtclqcgzlz4T4n+Vj8LXtOmM+QFGjzQF2wul1b5Hw2ofnnrLds+9pDSV7Q3CITYjudg==
Received: from [192.168.0.116] (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-9 (Postfix) with ESMTPSA id
 64CB518001C4; Tue, 22 Sep 2026 19:00:49 +0000 (UTC)
User-Agent: Microsoft-MacOutlook/16.113.26091740
Date: Tue, 22 Sep 2026 21:00:35 +0200
Subject: QEMU 11.1.1 release-signing key expiry =?UTF-8?B?4oCU?= request for
 authoritative updated key
From: LOUIS NAUDE <louis.naude@icloud.com>
To: <qemu-devel@nongnu.org>
CC: "michael.roth@amd.com" <michael.roth@amd.com>
Message-ID: <69D20414-1E3B-4F97-A44F-BDF191776634@icloud.com>
Thread-Topic: QEMU 11.1.1 release-signing key expiry =?UTF-8?B?4oCU?= request
 for authoritative updated key
X-Priority: 2
Mime-version: 1.0
X-Priority: 2
Content-type: multipart/alternative;
	boundary="B_3872955649_2435728390"
X-Proofpoint-ORIG-GUID: Js2xamOZumyNPNZf6lj4jINE_6CJniG8
X-Proofpoint-GUID: Js2xamOZumyNPNZf6lj4jINE_6CJniG8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3OSBTYWx0ZWRfXwTGcrWTkJjxx
 NBVhIKEs9x4RR6gdfhWzmHpxYzAgd1Mw+knpqxpp5La/JJ7QnlexCHqPPJ4LIW7tgXasA1VECUU
 TiRiyM7Kx4y+0ubroMwm7GLURFSap7IGZIrwog2JjNZ3m5FqRZASxqebDVHoKpCLY9ktOzT3hm2
 IZKM8TwkeBCrIw3qevXvA8Zxb12lsiW8luWPJBoKEanLGWCJOIGf2BAmjFobCW894YIsl0nGXrd
 V20UDhjW4LGz43gxIIuBCWDYSsvM4NQx85JNe6KKkd5jEDZOicsGLWCFVVmFt4ZBROF/tDERKyY
 xUuNki1BRr5awTKwUhdi+amUwYGe0aaF0d2jbfgYQWQYvD9YQFX4q7joX9ItZ8=
X-Authority-Info-Out: v=2.4 cv=ZOzaWH7b c=1 sm=1 tr=0 ts=6ab2d063
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=VdqzKS8jKosA:10 a=5KLPUuaC_9wA:10
 a=x7bEGLp0ZPQA:10 a=yyb_qwCxGnIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PeFO9FbFhS32YxYntvkA:9 a=MhXkjPSaMg3pM3CBmcsA:9 a=QEXdDO2ut3YA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=usO9gNg61Tdg9hO6Tg8A:9
 a=8Sl-nX0hNBCWTOgm:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
X-JNJ: AAAAAAABCL0/WaK8ravRSMGofZZT4OQ11bHJageDKP3UPu0k5qbYQZCPtHxceE4ni9LNXzr/klD6i7BSadxP2l4ujYRLUrnj3v38ywm+pMGjE41nvOgCwvcgQdCWfU8HDjtzA8wOra5AM2e5ludbTxvbIHA6vYZkoy5xfyMchHFbObkZo1vp7VySf/u7MNalghuEccodD/i7rtxDmW6TRhqRYrqnqmXrvoaWIYemYqvuctbcqMm2ZjLWoZXUATcJ8qVD6sCqhIckU7HwRZ/i/cZSvEMehOv05eRuu6dY56ac+Qa/d8kSi/vCKBVG2hpSiIkHSHrUe07LurK4qkhIgc9Ywq/74Dq10RRD7vUiSh1VZYWitJ7ksR562Qk2Fyi1J28GcWsLbG/Yj0Ux+htWpK/75J1U0ikJVeWsm7v2NsGOAwq6KmoZUPU7t3KTeCDF0Wcehrs4qWmErMNlj0tJDiGp7hljCnzU56UEydEvnj1TU8qPLE0ObHeXlbjyTV49a34Ah0uGc30mLPFSBq9koO8C7uwMHubJWWTboAW01HDXs6sbZCyoVVQekQDGQrIsmcgJkue1EQRftxF2muwmkZPyJEUKdcGRIsWGJj43L6bJjuDrfBcNAVgeBMVB0ENDeGS+5qiL/hrW6XXkFKFEE7cUsRVYutOWLDqYU8sths0xVKLtez3fNjQrsA64Y8lV/id4w8pYbjdIEK3qOkaX+PjU6wIjCm5uXi6NL7bfAoHCssedy3F7t0QOouufsli2KHpQkVUfksCtBPsam2sKctMNZTJBgcUj45/urPziQ9vKDDcjZ1Koei5tYJA+kOvRCFtxZ2l/2JiOVIiAh3fTxbJahtYbY1UTmh1KraWUtxuaV7SKAAOCirrDMwX+g97HEuuLjPDowCHEBdG2ADndJe1iZp/58BT/+vuUA1ICui7uV4zkl4TU36HVErJHYZb3XS3fV6AGLMZSNN8hpSlCfDbXnX9hf+n
 JBmoNPgtmN1m91odXbfsQqIorQ1VyB64zu2Fw84sB87VtCk9MNpCbSBjBCO1G3BqgUzMgxfYGc7lLJRuX2REfW9IWTASWuAa2h59PQj7NtDBsTId2LC4fUE6tTQ3NgU/Y3wxiEI0OsdLt2jMxrRV4cXXl4c5sMZTIOlejZ+gLiGkREeEVXogIELt7S+i14YgXE300aYxQXrGKR8cqNLtu4YF39yRGmscLYSwYBMilJrk=
Received-SPF: pass client-ip=2a01:b747:3003:204::53;
 envelope-from=louis.naude@icloud.com; helo=outbound.pv.icloud.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, MIME_QP_LONG_LINE=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, TRACKER_ID=0.1 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Sep 2026 16:34:51 -0400
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

> This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--B_3872955649_2435728390
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: 7bit

Hello QEMU maintainers,

I contacted Michael directly yesterday and am widening this question to the project list in case another maintainer can help.

We are preparing to verify qemu-11.1.1.tar.xz before using it. The QEMU download page identifies this release-signing fingerprint:

CEACC9E15534EBABB82D3FA03353C9CEF108B584

The keyserver copy retrieved on 21 September 2026 reports expiry on 11 May 2026 at 15:13:07 UTC.

The detached signature qemu-11.1.1.tar.xz.sig records a creation time of 27 August 2026 at 14:16:47 UTC. We have inspected that packet metadata but have not yet verified the signature against the source archive, so we are not treating the timestamp as authenticated.

Could you please confirm:
Is an updated copy of the same signing key, containing an authenticated expiry extension, available from an authoritative location?
If not, what is the intended verification procedure for this release?
Is another release maintainer available to help resolve this?
This is blocking our verification step. We are not seeking to bypass signature checks; we need the correct verification material and procedure.

Thank you for your assistance.

Kind regards,
Louis Naude

 


--B_3872955649_2435728390
Content-type: text/html;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:schema=
s-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/office/20=
04/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta http-equiv=3DC=
ontent-Type content=3D"text/html; charset=3Dutf-8"><meta name=3DGenerator content=3D=
"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1265842886;
	mso-list-template-ids:289558804;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style></head><body lang=3DEN-ZA link=3D"#467886" vlink=3D"#96607D" style=3D'wo=
rd-wrap:break-word'><div class=3DWordSection1><p>Hello QEMU maintainers,<o:p><=
/o:p></p><p>I contacted Michael directly yesterday and am widening this ques=
tion to the project list in case another maintainer can help.<o:p></o:p></p>=
<p>We are preparing to verify qemu-11.1.1.tar.xz before using it. The QEMU d=
ownload page identifies this release-signing fingerprint:<o:p></o:p></p><p>C=
EACC9E15534EBABB82D3FA03353C9CEF108B584<o:p></o:p></p><p>The keyserver copy =
retrieved on 21 September 2026 reports expiry on 11 May 2026 at 15:13:07 UTC=
.<o:p></o:p></p><p>The detached signature qemu-11.1.1.tar.xz.sig records a c=
reation time of 27 August 2026 at 14:16:47 UTC. We have inspected that packe=
t metadata but have not yet verified the signature against the source archiv=
e, so we are not treating the timestamp as authenticated.<o:p></o:p></p><p>C=
ould you please confirm:<o:p></o:p></p><ol start=3D1 type=3D1><li style=3D'mso-lis=
t:l0 level1 lfo1'>Is an updated copy of the same signing key, containing an =
authenticated expiry extension, available from an authoritative location?<o:=
p></o:p></li><li style=3D'mso-list:l0 level1 lfo1'>If not, what is the intende=
d verification procedure for this release?<o:p></o:p></li><li style=3D'mso-lis=
t:l0 level1 lfo1'>Is another release maintainer available to help resolve th=
is?<o:p></o:p></li></ol><p>This is blocking our verification step. We are no=
t seeking to bypass signature checks; we need the correct verification mater=
ial and procedure.<o:p></o:p></p><p>Thank you for your assistance.<o:p></o:p=
></p><p>Kind regards,<br>Louis Naude<o:p></o:p></p><p class=3DMsoNormal><o:p>&=
nbsp;</o:p></p></div></body></html>

--B_3872955649_2435728390--




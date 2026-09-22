Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E05C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97Ce-0004ZW-Ug; Tue, 22 Sep 2026 16:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <louis.naude@icloud.com>)
 id 1x96hH-0006Os-04
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:02:35 -0400
Received: from qs-2006e-snip6-4.eps.apple.com ([2a01:b747:3006:202::2f]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <louis.naude@icloud.com>)
 id 1x96hE-0006N1-SE
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:02:34 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 EF7FB1801661; Tue, 22 Sep 2026 20:02:28 +0000 (UTC)
X-ICL-RepId: 01a0cab6-6f79-7e4d-b152-c29e1d43f51d
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhIAUMFWgpeD08dXwNTEhVdRV8CQgJBXlcZRglSK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUBTV8OXh8EF0YZVQRHHl1WQh4ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD10GKQs2CDkFQA8tC0YUTAcodUYKQAxLHikPKgpHC0wELAdaBDBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1790107351; x=1792699351; bh=Spwo8nvSI2ujy+ZCyWejX0gh1D156UU37cSnrs8OlcQ=;
 h=Date:Subject:From:To:Message-ID:Mime-version:Content-type:x-icloud-hme;
 b=fVH9lx5Ek44a2sIb0X4wayIRrZ32dQRIDKjitzB+gkfuvHZOmod/V4t3C0HspGvCWjkIKAHFJIqpCKTnnFzHw3kOSUcWouF1HVc7+xazUMGsmWg6aYyONi4uahaSI/NzDvEMqXUgIKUZ4OArifcnQksD4yXrxsjx6OIqtG1P0Hcpr8AloVHt1M4n9Wro5/cFBviQl8vle/5krMJdv/wqPg9VyzHXPjGZFgs3qKUGILWQowxwbT3Q/qdWIgds+4QNfVeQCsoRUkZ4JO4mYbI6z2uU+9P/Ulsc0HaAKAWmH2N/7tzDl1JeGEReMuQbze1QREWfCQ94gywWUERAJlYv6Q==
Received: from [192.168.0.116] (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 D79E61800632; Tue, 22 Sep 2026 20:02:26 +0000 (UTC)
User-Agent: Microsoft-MacOutlook/16.113.26091740
Date: Tue, 22 Sep 2026 22:02:18 +0200
Subject: Re: QEMU 11.1.1 release-signing key expiry =?UTF-8?B?4oCU?= request
 for authoritative updated key
From: LOUIS NAUDE <louis.naude@icloud.com>
To: "Roth, Michael" <Michael.Roth@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <01B9F1A6-8F96-44EB-8053-D8A87247A016@icloud.com>
Thread-Topic: QEMU 11.1.1 release-signing key expiry =?UTF-8?B?4oCU?= request
 for authoritative updated key
References: <69D20414-1E3B-4F97-A44F-BDF191776634@icloud.com>
 <DS0PR12MB8504190E4DF11888AD01C50095832@DS0PR12MB8504.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB8504190E4DF11888AD01C50095832@DS0PR12MB8504.namprd12.prod.outlook.com>
Mime-version: 1.0
Content-type: multipart/alternative;
	boundary="B_3872959347_4095888511"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MiBTYWx0ZWRfXwfbhOYCdfQI6
 UoUvp3V6kQJyMRpvM/gv4h8vVVc0VpqoJELFuPNujGohxOAXXPAHDvI2hQ+h0G9xu7Qfxfu9frs
 CPpJVTJ7l/jtqe/XwBFsFUexejxdgl2w+GIwxSfkDW7z20XYGm/r3/F10fkNmqE7zbudXuYcdKJ
 npkyQxvZaDTVYBsQ1EWGvWG8JRrgtEyTxtAedohKcP4oJxNyuPLC3fYawd8vawu/Ink9oJqFpgC
 8JJzNMtaUxcmLV4GVzOH0wllKcc9zs2k7tQxrf72nM5K4lQusUQW6HA/nHQb3MMSCZsKX/EyOye
 ie0Tjm6voROpbTvz0L6nWWSUY35i8e+rpl02036oJLkqF5rBjTvy0lAAREqz4A=
X-Authority-Info-Out: v=2.4 cv=Sd76t/Ru c=1 sm=1 tr=0 ts=6ab2ded5
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=VdqzKS8jKosA:10 a=5KLPUuaC_9wA:10
 a=x7bEGLp0ZPQA:10 a=yyb_qwCxGnIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PeFO9FbFhS32YxYntvkA:9 a=zd2uoN0lAAAA:8 a=v3ZZPjhaAAAA:8 a=69wJf7TsAAAA:8
 a=BYsOST66NA2s4xJccZMA:9 a=QEXdDO2ut3YA:10 a=_EeEMxcBAAAA:8 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=wN0ERh9RpN4_xXxRlp4A:9 a=mDZFzHyhQtuJ3NKf:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=lqcHg5cX4UMA:10 a=czjwGCTIUPoA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: soeTr8OEtgC3eFRjmuL-CZ5MetjzQDFc
X-Proofpoint-GUID: soeTr8OEtgC3eFRjmuL-CZ5MetjzQDFc
X-JNJ: AAAAAAABizfilLFjOIEDWNE9xqb8Rbivkn75tuq4YZTNq3vmg8FI+LBWVH32+z+WQ11+wj1F77nCV8nbfYZgHCRrH6S2RoTeL4R5aQVsfN6MUOBPtTZMRhxRUVupM3BslpjM0EoQiJBJ6SO+YUcIc5pbj1zxjvO5ZE4v6OV8ecdpLvOoDG/VUyg+r534Q+xxdpR4FUSg5H1SR6/0PC/MwNQ1Z3bvhpSa+fN5oh8EPbJqgMLfyMyn8BcKDNkR7H5Rp5CZcLhaXGDPxColyUNnPPTbDV7oCzLV/Bbq+HQb6fYUapYOwuo79RGPICHAaQVzQ93xrHwlVAwj7mDS2I2aUvb8B2RH+kqXqXE9HuFLYMYfJwLfKnBhypcTwL54V+l6VhltiVv39N5uvHfyQO69tXEI+VwvU5hQYh9wPebCqSvU3Ueg0GH5/ajOEcyfqKM6kZExIM5lYOxhqKquHFbSwdvDlQ1VAnW9JzFXZaen4IUrkJqaGQNs9cMV5sooSse+k8bZxED9vCeEAxiKJ8TTLTl4nZlp1Ko9Dj4yoiLSXZ93LYe9lx7ePCFwqMLwWe+J18OM0vFNQ97mIi9rXp6x7kd9KhGadUcKgMjScr1kUIyMZtNKz43yeyZ8PUc6y/E8lONWJFRuEvnZk4dhq2lmP9mcQW/PTk6ivyetKgn/iywuLGoGP97sbyQcSyRXbK0v+JR4dt4QRTMhFiPbkQt0n4pgEQcawnC8Y/eZB/Lv8RfJteEHSHN0fXkZ3IjHpYmSmhCsxhe6cRCW2DTf25DadR85QySOc6yqH1itkC6XwzeWycNYcC7IX7rzQiLtaAQyPjqKWgHiG82XTawuiCjl1HsVI37RSWh82ri4HMV0I1aYYGkkuLyv06sthKHIWpl5tO2FMo8+AiBZw5cwgy58O92oPRUq5wOh8NsH/CPglnt4Cvcecxm6fYKNvYFvZ4XNZG4/u1E7hPrtuZocA/V8Bg/NQaRwYQ8
 WcyJzgeLPXvXCGQb0ZOojyz8UqeZMEOEOPeax4U0rtfSKGON9h7/MOp59glvTq1M0Mk33zf2zX3BQqrvWZYpghyrAv4MZHBnKDY6Bilhdv6Di/BbIkYlg1LOxnJPzRDr4n9Ecqh8B7hyMPfyyUp0oaU8iF9Fjx0qgFimnzM9vIWOXinyu6gChsKvYElU9oW8NuSqTQpI4NmcX01vnhbuBl4Vp3eX6XTQ/XOxgr6Jji1J9/v2byXm/xN0ooDZgOY1+8k5bAVjPHmFLv6Uere2Kl73oeTsUlhRv
Received-SPF: pass client-ip=2a01:b747:3006:202::2f;
 envelope-from=louis.naude@icloud.com; helo=outbound.qs.icloud.com
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

--B_3872959347_4095888511
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

Hi Mike,

Thank you for confirming=E2=80=94that=E2=80=99s very helpful.

Could you please let us know once the updated public key is available, and =
where we should retrieve it? We=E2=80=99ll then refresh our copy, confirm the fing=
erprint and updated expiry information, and complete verification of the rel=
ease archive.

Thanks again for your help.

Kind regards,
Louis Naude

=20

=20

From: "Roth, Michael" <Michael.Roth@amd.com>
Date: Tuesday, 22 September 2026 at 21:48
To: LOUIS NAUDE <louis.naude@icloud.com>, "qemu-devel@nongnu.org" <qemu-dev=
el@nongnu.org>
Subject: RE: QEMU 11.1.1 release-signing key expiry =E2=80=94 request for authori=
tative updated key

=20

AMD General

=20

You are doing everything right, I was not aware my key had expired.

=20

I=E2=80=99ll get this updated, but for the current releases on the site the key o=
n the website is the key used for the signing.

=20

Thanks,

=20

Mike

=20

From: LOUIS NAUDE <louis.naude@icloud.com>=20
Sent: Tuesday, September 22, 2026 2:01 PM
To: qemu-devel@nongnu.org
Cc: Roth, Michael <Michael.Roth@amd.com>
Subject: QEMU 11.1.1 release-signing key expiry =E2=80=94 request for authoritati=
ve updated key
Importance: High

=20

You don't often get email from louis.naude@icloud.com. Learn why this is im=
portant=20

Hello QEMU maintainers,

I contacted Michael directly yesterday and am widening this question to the=
 project list in case another maintainer can help.

We are preparing to verify qemu-11.1.1.tar.xz before using it. The QEMU dow=
nload page identifies this release-signing fingerprint:

CEACC9E15534EBABB82D3FA03353C9CEF108B584

The keyserver copy retrieved on 21 September 2026 reports expiry on 11 May =
2026 at 15:13:07 UTC.

The detached signature qemu-11.1.1.tar.xz.sig records a creation time of 27=
 August 2026 at 14:16:47 UTC. We have inspected that packet metadata but hav=
e not yet verified the signature against the source archive, so we are not t=
reating the timestamp as authenticated.

Could you please confirm:
Is an updated copy of the same signing key, containing an authenticated exp=
iry extension, available from an authoritative location?
If not, what is the intended verification procedure for this release?
Is another release maintainer available to help resolve this?
This is blocking our verification step. We are not seeking to bypass signat=
ure checks; we need the correct verification material and procedure.

Thank you for your assistance.

Kind regards,
Louis Naude

=20


--B_3872959347_4095888511
Content-type: text/html;
	charset="UTF-8"
Content-transfer-encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-microsof=
t-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" xmlns:m=
=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org=
/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=3D"text/html; char=
set=3Dutf-8"><meta name=3DGenerator content=3D"Microsoft Word 15 (filtered medium)=
"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1265842886;
	mso-list-template-ids:289558804;}
@list l0:level1
	{mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level4
	{mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level7
	{mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1
	{mso-list-id:1486511075;
	mso-list-template-ids:-1429561780;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-ZA link=3D"#467886" vl=
ink=3D"#96607D" style=3D'word-wrap:break-word'><div class=3DWordSection1><p class=3D=
MsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><span s=
tyle=3D'font-size:12.0pt;mso-ligatures:none'>Hi Mike,<o:p></o:p></span></p><p =
class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><=
span style=3D'font-size:12.0pt;mso-ligatures:none'>Thank you for confirming=E2=80=94=
that=E2=80=99s very helpful.<o:p></o:p></span></p><p class=3DMsoNormal style=3D'mso-ma=
rgin-top-alt:auto;mso-margin-bottom-alt:auto'><span style=3D'font-size:12.0pt;=
mso-ligatures:none'>Could you please let us know once the updated public key=
 is available, and where we should retrieve it? We=E2=80=99ll then refresh our cop=
y, confirm the fingerprint and updated expiry information, and complete veri=
fication of the release archive.<o:p></o:p></span></p><p class=3DMsoNormal sty=
le=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:auto'><span style=3D'font-si=
ze:12.0pt;mso-ligatures:none'>Thanks again for your help.<o:p></o:p></span><=
/p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom-alt:a=
uto'><span style=3D'font-size:12.0pt;mso-ligatures:none'>Kind regards,<br>Loui=
s Naude<o:p></o:p></span></p><p class=3DMsoNormal><span style=3D'mso-fareast-lan=
guage:EN-US'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span style=3D'mso=
-fareast-language:EN-US'><o:p>&nbsp;</o:p></span></p><div style=3D'border:none=
;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNorma=
l><b><span lang=3DEN-US style=3D'font-size:12.0pt;font-family:"Calibri",sans-ser=
if;color:black;mso-ligatures:none'>From: </span></b><span lang=3DEN-US style=3D'=
font-size:12.0pt;font-family:"Calibri",sans-serif;color:black;mso-ligatures:=
none'>&quot;Roth, Michael&quot; &lt;Michael.Roth@amd.com&gt;<br><b>Date: </b=
>Tuesday, 22 September 2026 at 21:48<br><b>To: </b>LOUIS NAUDE &lt;louis.nau=
de@icloud.com&gt;, &quot;qemu-devel@nongnu.org&quot; &lt;qemu-devel@nongnu.o=
rg&gt;<br><b>Subject: </b>RE: QEMU 11.1.1 release-signing key expiry =E2=80=94 req=
uest for authoritative updated key<o:p></o:p></span></p></div><p class=3DMsoNo=
rmal><span lang=3DEN-US style=3D'font-size:12.0pt;mso-ligatures:none'><o:p>&nbsp=
;</o:p></span></p><p style=3D'margin:5.0pt'><span lang=3DEN-US style=3D'font-size:=
10.0pt;font-family:"Calibri",sans-serif;color:blue'>AMD General<o:p></o:p></=
span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt;mso-lig=
atures:none'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US=
 style=3D'font-size:12.0pt'>You are doing everything right, I was not aware my=
 key had expired.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US s=
tyle=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span=
 lang=3DEN-US style=3D'font-size:12.0pt'>I=E2=80=99ll get this updated, but for the cu=
rrent releases on the site the key on the website is the key used for the si=
gning.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-=
size:12.0pt'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US=
 style=3D'font-size:12.0pt'>Thanks,<o:p></o:p></span></p><p class=3DMsoNormal><s=
pan lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></p><p class=
=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'>Mike<o:p></o:p></span><=
/p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:12.0pt'><o:p>&nbsp;<=
/o:p></span></p><div style=3D'border:none;border-left:solid blue 1.5pt;padding=
:0cm 0cm 0cm 4.0pt'><div style=3D'border:none;border-top:solid #E1E1E1 1.0pt;p=
adding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><span lang=3DEN-US style=3D'font=
-family:"Calibri",sans-serif;mso-ligatures:none'>From:</span></b><span lang=3D=
EN-US style=3D'font-family:"Calibri",sans-serif;mso-ligatures:none'> LOUIS NAU=
DE &lt;louis.naude@icloud.com&gt; <br><b>Sent:</b> Tuesday, September 22, 20=
26 2:01 PM<br><b>To:</b> qemu-devel@nongnu.org<br><b>Cc:</b> Roth, Michael &=
lt;Michael.Roth@amd.com&gt;<br><b>Subject:</b> QEMU 11.1.1 release-signing k=
ey expiry =E2=80=94 request for authoritative updated key<br><b>Importance:</b> Hi=
gh<o:p></o:p></span></p></div><p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp=
;</o:p></span></p><table class=3DMsoNormalTable border=3D0 cellspacing=3D0 cellpad=
ding=3D0 align=3Dleft width=3D"100%" style=3D'width:100.0%'><tr><td width=3D0 style=3D'w=
idth:.3pt;background:#A6A6A6;padding:5.25pt 1.5pt 5.25pt 1.5pt'></td><td wid=
th=3D"100%" style=3D'width:100.0%;background:#EAEAEA;padding:5.25pt 3.75pt 5.25p=
t 11.25pt;aspect-ratio: revert !important;background:revert !important;block=
-size: revert !important;border:revert !important;bottom: revert !important;=
color:revert !important;color-scheme: revert !important;content-visibility: =
revert !important;cursor:revert !important;direction:revert !important;displ=
ay:revert !important;font-size:revert !important;height:revert !important;hy=
phens: revert !important;letter-spacing:revert !important;line-height:revert=
 !important;margin:revert !important;opacity: revert !important;order: rever=
t !important;outline: revert !important;overflow:revert !important;padding:r=
evert !important;position:revert !important;resize: revert !important;rotate=
: revert !important;scale: revert !important;tab-size: revert !important;tab=
le-layout:revert !important;text-align:revert !important;text-indent:revert =
!important;text-orientation: revert !important;text-overflow: revert !import=
ant;text-shadow:revert !important;text-transform:revert !important;text-wrap=
: revert !important;top:revert !important;transition: revert !important;user=
-select: revert !important;vertical-align:revert !important;visibility:rever=
t !important;white-space:revert !important;width:revert !important;word-brea=
k:revert !important;word-spacing:revert !important;writing-mode:revert !impo=
rtant;zoom: revert !important'><p class=3DMsoNormal style=3D'mso-element:frame;m=
so-element-frame-hspace:2.25pt;mso-element-wrap:around;mso-element-anchor-ve=
rtical:paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactl=
y'><span style=3D'font-size:9.0pt;font-family:"Segoe UI",sans-serif;color:#212=
121;mso-ligatures:none'>You don't often get email from <a href=3D"mailto:louis=
.naude@icloud.com">louis.naude@icloud.com</a>. <a href=3D"https://aka.ms/Learn=
AboutSenderIdentification">Learn why this is important</a> <o:p></o:p></span=
></p></td><td width=3D75 style=3D'width:56.25pt;background:#EAEAEA;padding:5.25p=
t 3.75pt 5.25pt 3.75pt;aspect-ratio: revert !important;background:revert !im=
portant;block-size: revert !important;border:revert !important;bottom: rever=
t !important;color:revert !important;color-scheme: revert !important;content=
-visibility: revert !important;cursor:revert !important;direction:revert !im=
portant;display:revert !important;font-size:revert !important;height:revert =
!important;hyphens: revert !important;letter-spacing:revert !important;line-=
height:revert !important;margin:revert !important;opacity: revert !important=
;order: revert !important;outline: revert !important;overflow:revert !import=
ant;padding:revert !important;position:revert !important;resize: revert !imp=
ortant;rotate: revert !important;scale: revert !important;tab-size: revert !=
important;table-layout:revert !important;text-align:revert !important;text-i=
ndent:revert !important;text-orientation: revert !important;text-overflow: r=
evert !important;text-shadow:revert !important;text-transform:revert !import=
ant;text-wrap: revert !important;top:revert !important;transition: revert !i=
mportant;user-select: revert !important;vertical-align:revert !important;vis=
ibility:revert !important;white-space:revert !important;width:revert !import=
ant;word-break:revert !important;word-spacing:revert !important;writing-mode=
:revert !important;zoom: revert !important;align: left !important'></td></tr=
></table><p>Hello QEMU maintainers,<o:p></o:p></p><p>I contacted Michael dir=
ectly yesterday and am widening this question to the project list in case an=
other maintainer can help.<o:p></o:p></p><p>We are preparing to verify qemu-=
11.1.1.tar.xz before using it. The QEMU download page identifies this releas=
e-signing fingerprint:<o:p></o:p></p><p>CEACC9E15534EBABB82D3FA03353C9CEF108=
B584<o:p></o:p></p><p>The keyserver copy retrieved on 21 September 2026 repo=
rts expiry on 11 May 2026 at 15:13:07 UTC.<o:p></o:p></p><p>The detached sig=
nature qemu-11.1.1.tar.xz.sig records a creation time of 27 August 2026 at 1=
4:16:47 UTC. We have inspected that packet metadata but have not yet verifie=
d the signature against the source archive, so we are not treating the times=
tamp as authenticated.<o:p></o:p></p><p>Could you please confirm:<o:p></o:p>=
</p><ol start=3D1 type=3D1><li class=3DMsoNormal style=3D'mso-margin-top-alt:auto;ms=
o-margin-bottom-alt:auto;mso-list:l0 level1 lfo3'><span style=3D'font-size:12.=
0pt;mso-ligatures:none'>Is an updated copy of the same signing key, containi=
ng an authenticated expiry extension, available from an authoritative locati=
on?<o:p></o:p></span></li><li class=3DMsoNormal style=3D'mso-margin-top-alt:auto=
;mso-margin-bottom-alt:auto;mso-list:l0 level1 lfo3'><span style=3D'font-size:=
12.0pt;mso-ligatures:none'>If not, what is the intended verification procedu=
re for this release?<o:p></o:p></span></li><li class=3DMsoNormal style=3D'mso-ma=
rgin-top-alt:auto;mso-margin-bottom-alt:auto;mso-list:l0 level1 lfo3'><span =
style=3D'font-size:12.0pt;mso-ligatures:none'>Is another release maintainer av=
ailable to help resolve this?<o:p></o:p></span></li></ol><p>This is blocking=
 our verification step. We are not seeking to bypass signature checks; we ne=
ed the correct verification material and procedure.<o:p></o:p></p><p>Thank y=
ou for your assistance.<o:p></o:p></p><p>Kind regards,<br>Louis Naude<o:p></=
o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></div></body></html>

--B_3872959347_4095888511--




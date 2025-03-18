Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEF7C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWM1-0003dR-CF; Tue, 18 Mar 2025 08:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Prashant.Gamepatil@veritas.com>)
 id 1tuSmR-0005E6-PQ
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 04:58:36 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com
 ([40.107.92.45] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Prashant.Gamepatil@veritas.com>)
 id 1tuSmP-00007i-R9
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 04:58:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+UJEXNIeeujPfFIBsbiq45ux8M1SvhZzRzBYK+vFUkSu2tJQuyR0ymaJdN05MwUGaAPpnAVp3FuDsNpWpi/SvqJq00WNEVuecgNt2TCiGdMAyZ6O9086Wy9Omxr5KKKNukj+vXDRpNRNcGBCWa2X1GE5+d1YlVCqY1yccPGGdKRcZ20vTuAMk0LeSxfydDRC00TqngpngRFfIx6eunua/uA4micyJCsjhVZfyQua6jBya3tsp0Vkfv9XqOFQ+XbeM+A0VR7yZI1rTMku6IfJTNUNRiaZx05QWBClinkWoXXxGpE8jbKp2vvAjC8rJWh/vTYCI+xThEAK9P1g7M3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0r3RWax8W+awEIQttARYjshomKxhfnLMytNu8S1SYY=;
 b=H6k5SNWvxHs+LX6Iqaaph3o/TptSVgVnWkxk5Vi2Z8vanZScgQt/ed4ZzGyhA6J9Gxniw0vjc5U6aW5+GBrrszxDzvrXWTNEUAUqOOm+r61Az2f3fB/FWzw2GPJJUlkmblzIhrzOVi2iRITCNzCpY1yhKGOEySDVpy+dkOevy+RpWMRq7QdAIdyZTgyb1BCd/f4X1lZgph2fQn8qhGTlu6nZEffJeetpHcgje+UgjreXxhlBMYbPAyJDmBpq0oQFm/eg/OddSl2VsE30BkVLjafAMCF4toA457RgYmfBKQnFrjyinlshcaGInR8TT51iXbwv+nmUR9AMXMmLmgU4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=veritas.com; dmarc=pass action=none header.from=veritas.com;
 dkim=pass header.d=veritas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veritas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0r3RWax8W+awEIQttARYjshomKxhfnLMytNu8S1SYY=;
 b=kQxOkCvj/4c90SsZH8fPpcZgdXebakiCZ2UfPvEHDHVUiz+81CtCm19HpRWwtmWfzCUqYBpsTQfCP7frbNeJDiVZ0hiZAMFDAmZxU5RzhNR4xjWlCHhiV2gZLEg9wTT8yXcXTVGK6+QnPCEYyovixljqWTvi0+u9LoVUkGzSi2T2genlvj7cIXrDRJ5nicNvPc7XpLAkKrCSJhWohfnsLPDjcniwUT7aPiQp/DVxPCSL5UxL6Kz3YRyL4Y0ePe1Un7CN/XO8NSZDamP5IIvVwcOO5Ko4bB36V4wceZJZxy3dUySShQOrfrzU/HJ1MdVa1dOfAEMFOzWXZdpvvExv8w==
Received: from PH0PR20MB4520.namprd20.prod.outlook.com (2603:10b6:510:14a::5)
 by DS7PR20MB6234.namprd20.prod.outlook.com (2603:10b6:8:e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:53:25 +0000
Received: from PH0PR20MB4520.namprd20.prod.outlook.com
 ([fe80::f625:b503:6985:7d33]) by PH0PR20MB4520.namprd20.prod.outlook.com
 ([fe80::f625:b503:6985:7d33%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:53:25 +0000
From: Prashant Patil <Prashant.Gamepatil@veritas.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Issue with copy-before-write snapshot
Thread-Topic: Issue with copy-before-write snapshot
Thread-Index: AduX4uOzoFq7kH9KS6+z3JvraixLSA==
Date: Tue, 18 Mar 2025 08:53:25 +0000
Message-ID: <PH0PR20MB45202D1E91F3A0CE402C936798DE2@PH0PR20MB4520.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=veritas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR20MB4520:EE_|DS7PR20MB6234:EE_
x-ms-office365-filtering-correlation-id: cea31a81-b04f-4d49-5ba3-08dd65fa587a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vxnfCGyB8r7NTudYIbJeJAGT1q22mhmX9Apu1YslBpMjE8Y03ZhR6Qtnu+sr?=
 =?us-ascii?Q?kTDVpi5T5PDKOGnz6U4XG3DR6dTsOHDx/lW6uNtlDknq9ITLYn49SL9FThvx?=
 =?us-ascii?Q?eOM20lWt9tBMv9BTPt0EyV7jdar6ppHX4wzeEzx75oNJeQLY3oowGP4oBYYC?=
 =?us-ascii?Q?EptEVG5RZ4dAhSAbjA4ukA6rUnA2+fkNuqE+7lYl1CM4ADC9YRC64KWNfyzP?=
 =?us-ascii?Q?11p47finGdQgVUG6YW0l8WR8p+cNdBy8eMQuqkIGBDj/TeYsO4VFWOYHAstJ?=
 =?us-ascii?Q?w40qiafg6nMhCN+8yCDMPJssP2Py5/XDBTmS22JwmNEblA2aQAlOhkRFp9bF?=
 =?us-ascii?Q?pYgxvsDUSaogsRpjCELBkorOLDOWZxqGtyPiHgGhADK4qSvLvHBRXmq4ZA3m?=
 =?us-ascii?Q?HntMSp7QNN9wVi8TUHlYo8D2gjtzw08iv7OD5UVUQbPd1IguozUekRiU5aAI?=
 =?us-ascii?Q?4FwAAdqvl3QCddYJgKM+VEdQ4TTkZ/Vp0JjiJhTXp8xST9hgKp5MkwJ6Uo7k?=
 =?us-ascii?Q?TpfDp4JGA9XGIs1saRHKsJruHr/sLFBNHyU5ZdscsoVolbxkDJHrEtT1HIUO?=
 =?us-ascii?Q?XSNwMzeO3WLzXwGhaLee2EaGfo+7uAAGIOOF2+UhwvlJUo4+PpZkGvXqlmlm?=
 =?us-ascii?Q?BpdTY4A9pcBvYlQsHGshzfuSIht2IqPCBzPVnsqxOWMIrdweQ36y/BnFQ6S8?=
 =?us-ascii?Q?gH7f3yPqE2AKnA1hExSfJ4eoIW6AD44s07o7MUWVsNBW5HI/3o5g6nYrfISf?=
 =?us-ascii?Q?wpjdxkOfSrEVy+4wP8z7IVUX+6mQ+lxOsBv7Cg6xgr8OisXoXGxLzwGvQXy1?=
 =?us-ascii?Q?asmYArpCsZ/1jOxLMJ7uyFomQCf5PHbuUDIg47ISRfLTSpXU4xqsG7FHzv+j?=
 =?us-ascii?Q?SAE2v6+c6z2WCYFWAZYMRn5LuT6guXT0Mgu1bLaJEYh3pSxhqHnNTKfs1TNp?=
 =?us-ascii?Q?nbEFqhhcrWGWluXhIKFmvGMKkBuWJiUkKZycGOFU5JpU0Xk6WhWsKOLONbNh?=
 =?us-ascii?Q?OLCh7VMiJtgp8ghjYqpQWvPv61lr2l3G/PBR4gJP5UFBl3IeLFBcvzzr2w09?=
 =?us-ascii?Q?sdhoXLZ9+LxSU++obqUNpKFt06xK167gYu7CpyaJPnmk2YsgclHZSZ7sxfDU?=
 =?us-ascii?Q?9v8rujbAp2ONMlxJXotzFEX5jtM2ympuVpVnop+qSbaeZdx5lcQ5db3SJw5J?=
 =?us-ascii?Q?xA8+v4i0nygTi//hI0kIHmMdodCwPO/P3U4G08d3STT+TsWBHb9FO5bUbMAZ?=
 =?us-ascii?Q?LcVNE++1ttOWrLKmorn/OwKrxNReVX0W7QYUJcfcf/AWC478kaPwZDOb8Aep?=
 =?us-ascii?Q?XHMwN0jAjqqCZhfFGm1xaBmB6xF0BXBKrhWtOD35jfNEteHgE96tYZiXmkcF?=
 =?us-ascii?Q?6v4zg/1rxuKFT9970j3mAvjrbw7CqIc8m+nJE5Kwz72sMThS4A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR20MB4520.namprd20.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(13003099007)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1bh0KmcwDzacQ4e0WMiejuU7aOgnGy/knfE1Qi21hyLVLFP9/x6u6R0fMciv?=
 =?us-ascii?Q?+REZGKSg48zLKjeCogEUVb8tDZlKW04aZOWVlVX2DVSoUpM1VHPG8jNIluug?=
 =?us-ascii?Q?Nx1vcnks9AojetKB5Dw7ewSCONGWRSjf1Hsrt6EuigsQk/bvGo2zPmhE31y4?=
 =?us-ascii?Q?izN/cuS1h5mZxhc7OIW4aQfQaZUpVAm7yvHmsUkLKuVIa1Y/5CCNj8mWEVH7?=
 =?us-ascii?Q?DuzuJkRy5ppEWLs5bO/z4PSl+xrDtkkKEvcFfdZv+GC9xS2tnUb3hFvQHxgl?=
 =?us-ascii?Q?A/kAd5WmaB/EIawxQK3nugjubBZ0Lp/RQYQSdGPJWWRTbZMHNrlxc/XghaSz?=
 =?us-ascii?Q?Y9WwsuXWBsuQNHjlPydJ/oLIO1JunMGQif4yRbz7L0S3/kjtoI6CJw2Kkzfd?=
 =?us-ascii?Q?5qK4QIQMtXhN1nrp0UHk7ckkVSfgtkBNbMknVCs1hGyGBHUVdQvihLhK3jig?=
 =?us-ascii?Q?uTfY/8sH3mbuqLrHbRtvK9p30EaR1AyKSHCL8sULfZXw8R1hX63GUO1qMcU6?=
 =?us-ascii?Q?uNLSUKjRp0dFSuxVIMSuPA1Yn8PQllbaZLrs5+hUEQvq8hr8TTcWsAPDcdhF?=
 =?us-ascii?Q?rdCOsgZT8qNTfxcFabOVQw03VvEWvB/YD+K/lad1Q/Qc+ePNzE0oBzmeiQ9d?=
 =?us-ascii?Q?OEm+UCwuUlzrsvCXSioUgFLJ9NvnO/45HVDYqBLaKkOGS8Xu8LVTiVH8aWFA?=
 =?us-ascii?Q?PW/x3CG+obGPSwgbkf87mS88dqmQyTDuzqDeJSXVpJP5JnaeNAXj1ZsxtCho?=
 =?us-ascii?Q?2fc0gitFGnjAkrZR1hGy88o0gknIe6HHwIKWcP2RFEXMMgNC2kNAxJWhNKyM?=
 =?us-ascii?Q?J9e+UG89PayyEdCo3VQRn/iwEsTL0hglqEZB89n/RTUtPs/D+h50/kTbQS+S?=
 =?us-ascii?Q?9TB+UjL8TeY0EgmNMXOZ3wU6YtjRis9gQOQJwfrTzm3yYB8E7YuWQmjcnChk?=
 =?us-ascii?Q?SJxQMelPAnc0fyI1jJrIatQluwbn7lVYq9JmY7ZshNm+OGlfzBVPFJS+olVx?=
 =?us-ascii?Q?47SJNtTeL6ybcNwxBMOLntwokLqfiLAQaicf6Tq++YBsYrnkOAAyugqrEjYX?=
 =?us-ascii?Q?2JpvVcXM55N96vSi3s12hLVOH2p/iEZ6kaCICkEbvLw1aLcJkKIEkOkqgaFh?=
 =?us-ascii?Q?vHmVKTtzTGolKgU4fR1/YhOnXuu/ej87/a4UJ/uTf+KVFMNCFM4ZRd2zTnRR?=
 =?us-ascii?Q?mCbztonGUMrxFAAD+94gIwlNcBl0qbPpejqEz6o1yuCWN88YbdjZ40u5C66b?=
 =?us-ascii?Q?nhpsNPsrSV6WdN/oICkAI8zLDK0R/TUzNgPmXhmfIoRUBmhhsRjIIGNpmZON?=
 =?us-ascii?Q?Ghx8I9hC8l0fgwYNEPZcIrIAGH2/n9PtHblIqDjbOgpVS9jvA52n1rhpUlsS?=
 =?us-ascii?Q?ThSnp1GbxdLfW2m/G4iNTuxod/42oVe7WFBC3FRpqzV8PzHy3hHPqketO7I4?=
 =?us-ascii?Q?KS8Bbsgh78l7f5MD+GBcPDIKlXFo5yorkAOL4zo9xYmELSCzE6jNnFLb0tNc?=
 =?us-ascii?Q?cDpEajw+lup4pjgFi5PQZFu649+Jyt7zjW2Jzu1/GGWBgegl1RbIrXYIuTYr?=
 =?us-ascii?Q?ja9uvpt3BVpe2HTx+H9l87Tmr7u5fnH6TfkERv31RR9Z7rU3/sgIpX4jNsAE?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR20MB45202D1E91F3A0CE402C936798DE2PH0PR20MB4520namp_"
MIME-Version: 1.0
X-OriginatorOrg: veritas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR20MB4520.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea31a81-b04f-4d49-5ba3-08dd65fa587a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 08:53:25.7081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fc8e13c0-422c-4c55-b3ea-ca318e6cac32
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKZehc8w+jVDsOsQVyZzAtsGCMFsEtDFZ2lm4bJc+Q+Br4ZXjgSAdStQmLu5VcPO8aaKGeT9pxFtAFkqxAeLi8ehhlodJ5dJKsTITDA1bOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB6234
Received-SPF: pass client-ip=40.107.92.45;
 envelope-from=Prashant.Gamepatil@veritas.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Mar 2025 08:45:04 -0400
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

--_000_PH0PR20MB45202D1E91F3A0CE402C936798DE2PH0PR20MB4520namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello All,
Hope this email finds you well.

We are currently exploring the copy-before-write snapshot operation through=
 series of steps mentioned here - https://www.mail-archive.com/qemu-devel@n=
ongnu.org/msg876056.html

We are not able to run 'blockdev-replace' command, it fails with below erro=
r:
{"error": {"class": "CommandNotFound", "desc": "The command blockdev-replac=
e has not been found"}}

How to fix this error? Is the command available in any specific qemu versio=
n?

qemu version:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
root@be-proxmox1:/dev/pve# /usr/bin/qemu-system-x86_64 --version
QEMU emulator version 9.0.2 (pve-qemu-kvm_9.0.2-4)

Best regards,
Prashant



This message was sent by an employee of Arctera.

--_000_PH0PR20MB45202D1E91F3A0CE402C936798DE2PH0PR20MB4520namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
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
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello All,<o:p></o:p></p>
<p class=3D"MsoNormal">Hope this email finds you well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are currently exploring the copy-before-write sna=
pshot operation through series of steps mentioned here -&nbsp;<a href=3D"ht=
tps://www.mail-archive.com/qemu-devel@nongnu.org/msg876056.html">https://ww=
w.mail-archive.com/qemu-devel@nongnu.org/msg876056.html</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are not able to run 'blockdev-replace' command, i=
t fails with below error:<o:p></o:p></p>
<p class=3D"MsoNormal">{&quot;error&quot;: {&quot;class&quot;: &quot;Comman=
dNotFound&quot;, &quot;desc&quot;: &quot;The command blockdev-replace has n=
ot been found&quot;}}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">How to fix this error? Is the command available in a=
ny specific qemu version?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">qemu version:<o:p></o:p></p>
<p class=3D"MsoNormal">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal">root@be-proxmox1:/dev/pve# /usr/bin/qemu-system-x86_=
64 --version<br>
QEMU emulator version 9.0.2 (pve-qemu-kvm_9.0.2-4)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best&nbsp;regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Prashant<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<!DOCTYPE html>
<title></title>
<p style=3D"margin-top:0in;margin-center:0in;margin-bottom:8.0pt;margin-lef=
t:0in;line-height:115%;font-size:16px;font-family:&quot;Aptos&quot;,sans-se=
rif;">
<br>
</p>
<p style=3D"margin-top: 0in; margin-bottom: 8pt; margin-left: 0in; line-hei=
ght: 115%; font-size: 16px; font-family: Aptos, sans-serif; text-align: cen=
ter;">
<span style=3D"font-size: 12px;"><em>This message was sent by an employee o=
f <strong>
Arctera</strong>.</em></span></p>
</body>
</html>

--_000_PH0PR20MB45202D1E91F3A0CE402C936798DE2PH0PR20MB4520namp_--


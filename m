Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B29BC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 19:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfleO-0000Xo-D6; Thu, 29 Feb 2024 14:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rfleN-0000Xe-Ia
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:00:59 -0500
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2409::600]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rfleL-0004Xe-DQ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:00:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfpxn5PgPMvf1t1rT8PvJp3GIONqJ6ONLR0A5bshOxY4/4rMXeaTz1RrVHLHqy3snCnaOQPlSXxPagYt9Ehsn784JnftY9W9r2N7c4g4kAv/IvZEQ1A1EKoUpB9Haa1s/K3ZcrNhM6497hPkS8KdKWtxjyuEacklcrDbZd5+496kwyO0af+gapW7zZAEzDNazd3QhJLNYofGZTiy7uqIwvn3hEkp4NIETQNhW4bJUxzGdAgogBumMj32Hv/kZO2195Bz6oYjGUrZyqHN8Ur1PHL3o3/5szqbDcVevZHNbjssO8VbTzZ/TXBV5K2MhHM3oqWYU3BDc0nYsTR70KMPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkP+x2m1VeJz5lNOW90JHs00sGto8nYQ4ivqC+S0twU=;
 b=P9uATSGL52g6tyiPul8tUpoffqV81JzzeFNzcXHOimaQhdEwmb1PGnjB8B/RiGeAASPxPEUJ5sjwCaF/lGXOgfT1xvuGLgaaTXDEN1qdwuKsN9o5oMuDhtz50y/7PtleXe963Zld9WUGLg1d1eHU9ldiHYUennMY/eHzcUl9kFeY5AXdyCVm3u4HRV518KF9GHTKUdGJGGkIKp5tTgxuFplX3e6YL9V3sgRYc0I9bAf2cQwvgj7r0vISX7upnEiriBkBraCYICWn2L3t1ut+29gu34qRcrm5LMkd0RK1cnSDUb8/GNTLUdkpecogYCWs2iAIhljNMKNTZHN5QUfpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkP+x2m1VeJz5lNOW90JHs00sGto8nYQ4ivqC+S0twU=;
 b=i0NnWZTcXED8oP8qyN3pp2R1awjFnWgAisLjssgK/2/eaumI57odC2vomPzev8wwUPvz2RSxgLjAyqaH7QogcrDVkfWvNCHRiU/xRyxde5zr/mzMSbxMaWAQQkL5jN33CyUnJ6ETrLubOdYu1fFP57yfkjEaedYN3ttpgQ29kiA5l1V4NS6BdlsIm71EVwjTgGm1dYbtsr39Q4R38RBH+JSFwkmvwlhUkq2lmvUgSO6l/3RRjZVhG7BTU+Bpe7LnawUY6n0MBnywjFniaC3hYPepJKIxm7KibRTnZJ8Mfj0VdrPfP7W2pHqKd0qqPgPzQhlD9M2ZmQfd21zwrWFR1Q==
Received: from MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 19:00:48 +0000
Received: from MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4]) by MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4%7]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 19:00:48 +0000
From: Paz Offer <poffer@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: What is the correct way to add linker dependency to QEMU build
 system?
Thread-Topic: What is the correct way to add linker dependency to QEMU build
 system?
Thread-Index: AQHaaye7zzXXB0UUjEeHX6OPGX7Hq7EhlMAAgAAX2rc=
Date: Thu, 29 Feb 2024 19:00:48 +0000
Message-ID: <MW4PR12MB6997651503155E2AEE2148D7A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
References: <MW4PR12MB69979E8A2E0F9B62D6C2A703A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
 <CAFEAcA8S-uONJyR5nKh=HGQwKNUtT4VB+VYBh_dp3_3bjZfmfg@mail.gmail.com>
In-Reply-To: <CAFEAcA8S-uONJyR5nKh=HGQwKNUtT4VB+VYBh_dp3_3bjZfmfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6997:EE_|MW4PR12MB7264:EE_
x-ms-office365-filtering-correlation-id: a86ce106-c268-4d1b-7e14-08dc3958bd92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oBrTleIr5vda4W5sRcZYpvBQfFmUzEekZ1Y4Q2Jwqb5DAOs8jd6WoaiicdQBB8yCzVfnvoQpnkPm45z9LyH+honaSZBBJz02q5ANgQWtjTfVBvbeETF8aFdr4rnbT3tNQGxEkSRfmGkSs8jYvrikW4NvHEp27zqmyJ4+azP2KiQyjFUYXbRy3/RBbDUNmtEE7m+FcTo9JzMgebtJHX/IZN0CyYmQ30c7I+3dR818FtJSrA2gawxO0IxoioxTIJEEsErND198JsNqhQRdP22vsPqpXZcKWC7p40t3D3VzAE9Cyl6TL6kK6T86yxBnnpwbgjcbmIQnrQgtIojEmQxyhZVMKSyxbYXpfhNiK5grES4fcR+AmgRzBO74JRFP6MZS4bC3Bpi8WKjboqEm0625h1fi9JI3yeoo4/xE+DeUiMHDhITl2kHBydEhqPuGvQC9Rtskq8+AYlFwEF8nQuem3VtCeNX080hU0p/1gzmhlAh/O/RINEe4dOfRPz2ivtPgqEf8M2HNoPGgN6X8LvNAeP37ONqqgu2pB03pzmOwd0q/I4Qb7D8hnzHjz5mp0EviqcIzidF6kuoKKOy4eeaZVRzpAPdoIttNco6h4kxDNzBeTYm47LcPtKIOVlg5lh6p789tvJxibWlnEmq67KbE9MGb7K5hHkBGO7Ni46EmIeca9OVR5+hu7o7Skq6H0ZCVQzbyiA4RrO6YpbEk9m1gC3YxRotKz3EEkhpCC3bvxkw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bzGSDopLx3ZA72nI5YMAiNzhPHtVAfLcH7hHxCPWV+8CuaHsTGs7pyEyey2M?=
 =?us-ascii?Q?cAGePcPbjdza0IB217bdJwX7gblFXtKz8KCC+shKgKqN88PPa6lIe8SWs1/R?=
 =?us-ascii?Q?Jnjh1vIPjB8xhDh+OBYypa1UL/JxU0Ew2bGW4SyudC2hRGA67/ieUtaVG4Xp?=
 =?us-ascii?Q?KyY6QbxNDn+VXZAWF83mA0AaU+nO/hdSF1faeZuWBNi4atnt9wzn+mqzDvk8?=
 =?us-ascii?Q?Ak0e0ar5bd/DEfQzlg/bXGVQH4FMMustDL0YvSZkauFEVbDgv+eEA/ooVawi?=
 =?us-ascii?Q?i7eEDsXc6X0zZG/6TprraWJWzxDVnZIbk3frmlXycXOKF4fycaOiSmOeo7o4?=
 =?us-ascii?Q?dC0Ixx2wq2IIKebJGYhYo+TQ5qXteY9PEXePzM0doPl+Wn0cQwYVryUgWsDY?=
 =?us-ascii?Q?R3Wg1NeDeFj97++/KiWdgLAofV8vly2TX45yqEBe0bD8SVyxVvyQZEgtdasC?=
 =?us-ascii?Q?JgjGtzprEuj/MctH5ugcBu0DMB2QjzJo5D48AbDglTXhvUap1d68tFgoWDBM?=
 =?us-ascii?Q?Kncm1PpkbAteVhd+NRMalNI4uFnMcJWI7nbtGIyvtQzhKDGNLTmsD3ghtU/K?=
 =?us-ascii?Q?Ku177eRtO4+0DeNcrWhtzo7OB/Im3vAHq7RNvc7ESuyifTVpOf2VIOlBaC3T?=
 =?us-ascii?Q?FvjrkAVitVcXqMHHie9YGhyxdp3OujAdG0tN+bOpKLV1Mu/3DejcpEIJ3gUE?=
 =?us-ascii?Q?H+r8gaZE/ShC4xAZmaWC8E42aGvsTszUtIS0M01zPke9zFWbpA+33DcJrSJd?=
 =?us-ascii?Q?XLtO8yYaDvKP111FRmkfb2uump2FQQJmsNI0bn4tw/yt+X2+U2zC3nkCZ+Nb?=
 =?us-ascii?Q?M+phJreu7BmZSPTUAZMqdNJWv+DPnEQW8udOkdhQf+2QsaxwpsfuP4NJal0x?=
 =?us-ascii?Q?TZwxj7Qv9tm9aFtVl3XknQw3swA1odENOT9qCffDA68GgoeL1sIoFOfKqSLs?=
 =?us-ascii?Q?sUkdqUxgcx9z7LzANjh6aXKn5Sk2M1ZsdzL+EOEiObjwzBLVArobJ72gUUId?=
 =?us-ascii?Q?wn1dopTfv9II5hZEpENOkDU8mvI92SBZGa4yI0sMZx9FbJZn6vHr4gqTeLSM?=
 =?us-ascii?Q?dfXKjYSRwD6SJgVhQYn7q3wwsz6QgA9nEJ3CGvsT0UH+w9bv5qjjqeF9GkzM?=
 =?us-ascii?Q?efx/lQ4aJiY3ic/572szbjTIuNAE5RiM/Q8PKRTV1dB8Qig+ysjn84/K/Air?=
 =?us-ascii?Q?z8L4oYp4DgF6roayaYRj7ZXid3N3/n4N1iCntYhdKa2JSbTgKn5gaAUXn0/e?=
 =?us-ascii?Q?XYexBc5EFnm7hphSP3w6dcn95NVT4uI46myozwgup9tYUtvrp22+iQi/+80H?=
 =?us-ascii?Q?muxJL9SX6ACLHVM4zVT9FD4qpexXv3e2MdiIvEBu8UHuBfFS9o9v0HTUB614?=
 =?us-ascii?Q?plk2D8ysrRDHzZbzI5Glrwh4Ebrja09+oXABkzX3rsp9GzQZKp5CWiN762Jz?=
 =?us-ascii?Q?O26XHQUdj9DNfwKKo2BTyqtXWoAq3cjACySTQQW35brMag4M4mBPiaEGA/bs?=
 =?us-ascii?Q?QbWjhYQkfRnivQ2zlOEcJWZd6htiYkEAUc9NpNXEHoHNy54yBv9a8PdLwBh/?=
 =?us-ascii?Q?c5G613/E4FcfA005A6w=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB6997651503155E2AEE2148D7A05F2MW4PR12MB6997namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86ce106-c268-4d1b-7e14-08dc3958bd92
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 19:00:48.0082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNtkVwVUtFHl1LpOsSBcnfPT6VHkFHuquphsn967jzC2hlWQdXokxd62CPRWJenNLAq3mJ4TZO9sx6UWHn3XwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264
Received-SPF: softfail client-ip=2a01:111:f403:2409::600;
 envelope-from=poffer@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_MW4PR12MB6997651503155E2AEE2148D7A05F2MW4PR12MB6997namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks a lot Peter,
This is working.
Paz
________________________________
From: Peter Maydell <peter.maydell@linaro.org>
Sent: Thursday, February 29, 2024 7:34 PM
To: Paz Offer <poffer@nvidia.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: Re: What is the correct way to add linker dependency to QEMU build=
 system?

External email: Use caution opening links or attachments


On Thu, 29 Feb 2024 at 16:10, Paz Offer <poffer@nvidia.com> wrote:
> I want to add library 'libdl' to be linked with QEMU build for a particul=
ar target (e.g. - qemu-system-arm).
> Using meson I would typically do 'compiler.find_library(...)', and later =
add the returned dependency to the binary dependencies list.
> However, in QEMU I understand that these configurations are done in the '=
./configure' file?
>
> What would be the correct way to do this?

If you can do the job using the glib g_module_open()/
g_module_symbol() functions (which is how QEMU itself does
loading of plugin and module DLLs, and which on Unix hosts
are pretty much wrappers around dlopen/dlsym) then you
don't need to link against libdl at all.

If this is for something you're planning to upstream
then it might be worth talking at a higher level about
what you're aiming to do. (If it's for something downstream
that you don't plan to ever upstream then you can do
whatever's easiest for you, of course.)

-- PMM

--_000_MW4PR12MB6997651503155E2AEE2148D7A05F2MW4PR12MB6997namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks a lot Peter,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This is working.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Paz</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Peter Maydell &lt;pet=
er.maydell@linaro.org&gt;<br>
<b>Sent:</b> Thursday, February 29, 2024 7:34 PM<br>
<b>To:</b> Paz Offer &lt;poffer@nvidia.com&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> Re: What is the correct way to add linker dependency to QEM=
U build system?</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">External email: Use caution opening links or attac=
hments<br>
<br>
<br>
On Thu, 29 Feb 2024 at 16:10, Paz Offer &lt;poffer@nvidia.com&gt; wrote:<br=
>
&gt; I want to add library 'libdl' to be linked with QEMU build for a parti=
cular target (e.g. - qemu-system-arm).<br>
&gt; Using meson I would typically do 'compiler.find_library(...)', and lat=
er add the returned dependency to the binary dependencies list.<br>
&gt; However, in QEMU I understand that these configurations are done in th=
e './configure' file?<br>
&gt;<br>
&gt; What would be the correct way to do this?<br>
<br>
If you can do the job using the glib g_module_open()/<br>
g_module_symbol() functions (which is how QEMU itself does<br>
loading of plugin and module DLLs, and which on Unix hosts<br>
are pretty much wrappers around dlopen/dlsym) then you<br>
don't need to link against libdl at all.<br>
<br>
If this is for something you're planning to upstream<br>
then it might be worth talking at a higher level about<br>
what you're aiming to do. (If it's for something downstream<br>
that you don't plan to ever upstream then you can do<br>
whatever's easiest for you, of course.)<br>
<br>
-- PMM<br>
</div>
</span></font></div>
</body>
</html>

--_000_MW4PR12MB6997651503155E2AEE2148D7A05F2MW4PR12MB6997namp_--


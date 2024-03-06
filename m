Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276F0C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 23:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri0x6-0005aJ-3W; Wed, 06 Mar 2024 18:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wucf@cn.ibm.com>) id 1ri0x3-0005Zw-PD
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 18:45:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wucf@cn.ibm.com>) id 1ri0wf-0005o2-Hy
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 18:45:33 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 426NWa95003018
 for <qemu-devel@nongnu.org>; Wed, 6 Mar 2024 23:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : date :
 message-id : references : in-reply-to : content-type : mime-version :
 subject; s=pp1; bh=M3YB9zysDRfPorp3blfNJsAw/z+9uDbNsaRfhb5sBoo=;
 b=bxtEyfN13X9jfkiX0ajDWQ6lMPPsglzbHf9d6I8uzHSGPa/2vnTDDeXNDVZROlrH0dBN
 FFostTt1GwPsSSc35/vtM1oo/4i27qxf1zMIIrs3iVRQbD/FSyoHtbADtaU/UlMEddBb
 F70duMihJQPxuQqjJGlvYcweDIidtnBpTlFR1SmJMobZHJr121YneTB7MtybQ53MtGyn
 B6qH1Y0ObPXjr5OoGLFTbn2aZ1hb6nQ4KgsSK1hkI9g6aEFdBgpZu8KLS9Wz/AA3Xk3W
 i0Al3Lbw5vEuBMhwtvhMa1SECg/8hAc3l4XQShQAm7u5Q+ZmKeFcg6tX1L+1N3GXpdUm Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq28h88hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 23:45:07 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426NWhvi003173
 for <qemu-devel@nongnu.org>; Wed, 6 Mar 2024 23:45:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wq28h88h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 23:45:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxMtTIIP5tvUmiAdIHSL2g6enLN5465T/DCT3bzI7hu93604coEX73pSK7RIiNvOPeV97Cpf/fpAE6iP9QAom72WK/daNz/iO7EtCJUuaaHROyfAqu8fYs3j5x5sEOajxp9JeGNMaq0CendwU/RF7SwG88ZJdj6esqdudpFFKFRD2bhBwkFu6cuopCWJjlzjo8STxX+pFCRdmmrC3ckGit5RuFhSaAst8uHpPwwQG4R5rTruIyC6Z4g26oB7gTK996TT9OEI5ZlraJMw4nRGbdofFF5R02EnxxhNdiqvRq8KD/QwHqLi9T9js3ECEdDEIyxzJW5tZ2gbnxLBy47veQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiwonNdEKy+9lj6/Acc95Xb+NU3hZGtwcsz9/MkfJNQ=;
 b=DdjnSvxf46kvQabAqjzabpFVRuMC0XG2mV8zmDzrn1UUGDjQpZPgGEqM+4JqhcVUF+3HCpL2VwLzZCmYr8jc3koYpodQllfcgTPkYAwcBJDthGdAF6bAV7Qr6pjvpeOxAroVT5/m7eaHkfePteLx8bAw8GY7c79FW9u9Ikp4LJmKlPlSyN2ReRIQZKNzbA7+2BZoepFMiVH37jrbZWwpPlErBZGrBoOLm+d6N5RFVhsGlE/58L7M7dHmSmu4qNsZPvElSlJGK48rLOkqE1whFNM7nPv+DoOkuKpem4RFKShg93nR6mekyG7jxXqPUSxc2gIWj4sS5acToJfm6/Qoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.ibm.com; dmarc=pass action=none header.from=cn.ibm.com;
 dkim=pass header.d=cn.ibm.com; arc=none
Received: from PH7PR15MB6503.namprd15.prod.outlook.com (2603:10b6:510:304::5)
 by PH0PR15MB4216.namprd15.prod.outlook.com (2603:10b6:510::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Wed, 6 Mar 2024 23:45:05 +0000
Received: from PH7PR15MB6503.namprd15.prod.outlook.com
 ([fe80::f3d3:ce2a:4ed3:3ea9]) by PH7PR15MB6503.namprd15.prod.outlook.com
 ([fe80::f3d3:ce2a:4ed3:3ea9%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 23:45:05 +0000
From: Chun Feng Wu <wucf@cn.ibm.com>
To: Daniel Berrange <berrange@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL] Re: Does "-object" support structured options now?
Thread-Index: AQHabf2hpXTetJLRaU+zSXGLjQwKCbEnObmAgAOP2F6AAAG0AIAAAdKAgACXQQ0=
Date: Wed, 6 Mar 2024 23:45:05 +0000
Message-ID: <PH7PR15MB65033141AC68A2A0278B4C80F7212@PH7PR15MB6503.namprd15.prod.outlook.com>
References: <PH7PR15MB6503236A69BD173E62FC6791F7232@PH7PR15MB6503.namprd15.prod.outlook.com>
 <ZeWA8VrzgjKjETXh@redhat.com>
 <PH7PR15MB6503A217E33561AB9E193FA5F7212@PH7PR15MB6503.namprd15.prod.outlook.com>
 <Zeh_WFMQU3eehD0N@redhat.com> <ZeiA3zC6XxbCphti@redhat.com>
In-Reply-To: <ZeiA3zC6XxbCphti@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR15MB6503:EE_|PH0PR15MB4216:EE_
x-ms-office365-filtering-correlation-id: 09699055-d5c1-4115-6566-08dc3e3772ed
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8vsIw4O/YIfrzd5u/6a0JN8M5odWNHroaVYgrKnxbZVNCmzJ3cwfJDqC+12omuftJXyUwm+Wr4ZoxCVuf0idgcbfnuu0o+bq4cqwg1PcxcWrrGEVL9mlBxcKYJxu9bCO/C/vxrOac9leMv2fiTvsJciZN3P9pMO74M08UQwIFgM3MrIAuQ+nFAmriMkm9aTt9uMWm6Br34I7xnQ2qnAPKaptoL3m1uBKwJIi8iFwQMegxtaNx8dR/rkxPhPNgoz78e39tPu/+ETRCtfLjfM21mrjeTQQ2Rb9a7XTzpIuHpzhZ1dptB1iIc9bbFgChScnrJ50Yk6lS+QBSPdWiwlptMg6ch5kQcftDFuBCWbzGw/1ED8wyUnlzWqXwH6ogD7UF0l2mSYo97Nl9c7tN4X5XcufOdsouyubZ0AzrCarmtG2pqe4s+oj/lasglOEr6G65YFh2s4/fYZoJpK76kV9Cd70v3leL8Q1CCN32F9i1sQXxn/WEvvP7vkUL3Z79sv8112AJlGHiXVAYGLKJ+a5wPlGhIEMBZZb1V1qJqL9ptfVxzUa6tALMxYEKKSTRPMlEozqU2ummYS9KRXgvrB52fRr4hV0apJXkh3471Ro+xt+IhCUZDZE4SYk2M6aT0wnmWSIUUtfbzkr97kuUzY/4y3373i/9aokhCW+MwN3bo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR15MB6503.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?6r4JnDiwL04lXbxa0VoGwBnB9ERKJyWETS2kbjvaaKtyHWlRunlR9pHH?=
 =?Windows-1252?Q?cMPBspdiduPkg4vs/Snu14DlTSYGTU46kC3i2SfNC85+mMyBQHUS7Q1B?=
 =?Windows-1252?Q?RRlDSwHyJ/9uqI3p5apCj7GLH4HK+7NrIMFwEou1sZRg5EdwB5NOZ8GM?=
 =?Windows-1252?Q?lxuqcDfazoih1kD16qiQvfbvCYox51Y5PT/XpFdEk/JI3AW0OMI5A9f7?=
 =?Windows-1252?Q?wsHzQWdOJYaU6aHR7bcffpjKkQ4Ug/atVK8ygvAQ+vXnvZmniETwsKJl?=
 =?Windows-1252?Q?tOUtB6aubkKF8oy1O7vGPDj0GL1olWecJfzsQ647jaWhbt2tAeiJ98Ow?=
 =?Windows-1252?Q?/wHdYu2tGohBp657Enphm1cKid6MsuCUwWXRgSrgCgNVj2z7NVCc43Dl?=
 =?Windows-1252?Q?F4dFsPGG1XbV8fF/6AVk6st5jJ/yGdpDZCAbu72DuBf9HBQZ6wlzbTma?=
 =?Windows-1252?Q?9Chc446A+Ckg5lgbD9JJfWg/8FMi7Max+Scvg5ebN3iXqY/7/9uhAvo7?=
 =?Windows-1252?Q?scs/RDNHzguJ2UX/9msFcPz26GUJCa8JYuG3QJ/p+8O/TEDmRMgeaT9y?=
 =?Windows-1252?Q?JGbRbuwfPUkjbgBlxD5N3CXssIGqo5vT9V5iFZdnYJpDXBBV6BqWt5mV?=
 =?Windows-1252?Q?UtKSnVHCpvGjN+UkMpqXauHZ8rB8OPqnv+a9Qgg1H7LSgSt4sV4fn2T4?=
 =?Windows-1252?Q?TckS+Z858ShV74HKcCnjFWF/FMWWHugG6tR95sOM8HtGNrn3xCTuhWxi?=
 =?Windows-1252?Q?tOtHU8QV8RSEaoYCFizcHKgWGGlTVe0DRAtnJUgbELow9nGc+K/VP6fJ?=
 =?Windows-1252?Q?GNqlZTZqGR7PBakrcm7EqSMQZzrAic4kdKR50naYsubGq0hOUkpF2n7P?=
 =?Windows-1252?Q?Jmpm8CQ/6dulM8EGSQDH+sdRwzCZPmtftKlzv9p24o2M6gdHaR0DmGhK?=
 =?Windows-1252?Q?6/dXBjspBrRjFjUo0iIWhluqcGbNdbc3iWv3pvbDZAYrSmwVCUkYoJR3?=
 =?Windows-1252?Q?tpl04AllUWW0wqjnUm7YlepaUDdEPrdPJBTQHEQFPDvZ/QpLafhGbgyQ?=
 =?Windows-1252?Q?5Ie9esLv9ow7ro6py0GGRwNbg0MWwfELxzIzWi5WseX92sv3/jEXG9VT?=
 =?Windows-1252?Q?i15cJhWF2QH1F2tPSXHlBy2fX+kbvgXYwgYpil8ByfuY1ifrV9Y+wqBR?=
 =?Windows-1252?Q?wRIONKKhmBkhnvUCyiWDjWPFBniBV3nkgn3uzJ9+oX0+sWnaAe9VsXQ8?=
 =?Windows-1252?Q?4D1FrJXIKVxKubozTufW7dCm2JKXedhQOcH8uu8wimMttuoEZHkb7ZHz?=
 =?Windows-1252?Q?Tp09GBXtcS7fEAPK/k7V+JKaHsQlvwPrKeew7fMpsjMw9viMB0yBoD1w?=
 =?Windows-1252?Q?us0TvrdB1L24tnVdwVAy35Uq+X85xfV+MolIc4Nz39vFuttiTQNsk4ba?=
 =?Windows-1252?Q?x4QPTW9damgfdx9xfAn0ueTYlVymJQVHpEIxVTeKfkJwLWNrjm19XxC1?=
 =?Windows-1252?Q?2gNBnrsVBKyuqIFXY2LEOxvyz+o8e5ynuvg0oeZctJSsQvpiBlnZFs08?=
 =?Windows-1252?Q?KINtJfLcdR1QQHRxZd2z2vJDpo63hw/H72jzMUZBbxgmAjNUzBEv7F3T?=
 =?Windows-1252?Q?UODok9m27Stziucv8LwNNcLVy+taeelGWoSHE6Vq7b4zaK5Fdz+hU/hF?=
 =?Windows-1252?Q?t89/qcUMhfvNK+pVRdGGseVMqkUp+VzfnlS40SIX86q3v18SFVL2qQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR15MB65033141AC68A2A0278B4C80F7212PH7PR15MB6503namp_"
X-OriginatorOrg: CN.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR15MB6503.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09699055-d5c1-4115-6566-08dc3e3772ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 23:45:05.1724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5hsVXZpI9JISTq1XgxKe+dwdk1n3DCwMqx7BT9UaFqclKpuXzAXwJ9VldDuXMJfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4216
X-Proofpoint-GUID: 1niL4KgQrx-eBrlKBP-9fE1tCKAim4rO
X-Proofpoint-ORIG-GUID: qZJXK-6sZeQ64sNRN-09IgOaXPYUBunc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
Subject: RE: Does "-object" support structured options now?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060191
Received-SPF: pass client-ip=148.163.158.5; envelope-from=wucf@cn.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--_000_PH7PR15MB65033141AC68A2A0278B4C80F7212PH7PR15MB6503namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Yes, you=92re right, QEMU >=3D6.0.0 works well, I failed test because I did=
 it on QEMU 4.2.1

From: Daniel P. Berrang=E9 <berrange@redhat.com>
Date: Wednesday, March 6, 2024 at 22:43
To: Chun Feng Wu <wucf@cn.ibm.com>, qemu-devel@nongnu.org <qemu-devel@nongn=
u.org>
Subject: [EXTERNAL] Re: Does "-object" support structured options now?
On Wed, Mar 06, 2024 at 02:36:08PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Mar 06, 2024 at 02:33:05PM +0000, Chun Feng Wu wrote:
> > Thanks Daniel for your response!
> >
> > I tried it with the following cmd
> >
> > qemu-system-x86_64 [other options...] \
> >   -object '{"qom-type":"throttle-group","id":"limits0","limits":{"iops-=
total":200}}'
> >
> > And I got error:
> > qemu-system-x86_64: -object {"qom-type":"throttle-group","id":"limits0"=
,"limits":{"iops-total":200}}: Parameter 'id' is missing
> >
> > Do you know why such error happens?
>
> You have made a mistake somewhere in invoking it ?

Or perhaps you are using a much older QEMU release which lacks JSON
support ?  You need QEMU >=3D 6.0.0

With regards,
Daniel
--
|: https://berrange.com       -o-    https://www.flickr.com/photos/dberrang=
e  :|
|: https://libvirt.org          -o-            https://fstop138.berrange.co=
m  :|
|: https://entangle-photo.org     -o-    https://www.instagram.com/dberrang=
e  :|

--_000_PH7PR15MB65033141AC68A2A0278B4C80F7212PH7PR15MB6503namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
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
--></style>
</head>
<body lang=3D"en-CN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Yes, you=92re right=
, QEMU &gt;=3D6.0.0 works well, I failed test because I did it on QEMU 4.2.=
1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Daniel P. Berrang=
=E9 &lt;berrange@redhat.com&gt;<br>
<b>Date: </b>Wednesday, March 6, 2024 at 22:43<br>
<b>To: </b>Chun Feng Wu &lt;wucf@cn.ibm.com&gt;, qemu-devel@nongnu.org &lt;=
qemu-devel@nongnu.org&gt;<br>
<b>Subject: </b>[EXTERNAL] Re: Does &quot;-object&quot; support structured =
options now?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">On Wed, Mar 06, 2024 at 02:36:08PM +0000, Daniel P. Berrang=E9 =
wrote:<br>
&gt; On Wed, Mar 06, 2024 at 02:33:05PM +0000, Chun Feng Wu wrote:<br>
&gt; &gt; Thanks Daniel for your response!<br>
&gt; &gt; <br>
&gt; &gt; I tried it with the following cmd<br>
&gt; &gt; <br>
&gt; &gt; qemu-system-x86_64 [other options...] \<br>
&gt; &gt;&nbsp;&nbsp; -object '{&quot;qom-type&quot;:&quot;throttle-group&q=
uot;,&quot;id&quot;:&quot;limits0&quot;,&quot;limits&quot;:{&quot;iops-tota=
l&quot;:200}}'<br>
&gt; &gt; <br>
&gt; &gt; And I got error:<br>
&gt; &gt; qemu-system-x86_64: -object {&quot;qom-type&quot;:&quot;throttle-=
group&quot;,&quot;id&quot;:&quot;limits0&quot;,&quot;limits&quot;:{&quot;io=
ps-total&quot;:200}}: Parameter 'id' is missing<br>
&gt; &gt; <br>
&gt; &gt; Do you know why such error happens?<br>
&gt; <br>
&gt; You have made a mistake somewhere in invoking it ?<br>
<br>
Or perhaps you are using a much older QEMU release which lacks JSON<br>
support ?&nbsp; You need QEMU &gt;=3D 6.0.0<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com">https://berrange.com</a>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; -o-&nbsp;&nbsp;&nbsp;
<a href=3D"https://www.flickr.com/photos/dberrange">https://www.flickr.com/=
photos/dberrange</a>&nbsp;
 :|<br>
|: <a href=3D"https://libvirt.org">https://libvirt.org</a>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -o-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href=3D"https://fstop138.berrange.com">https://fstop138.berrange.com</a>=
&nbsp; :|<br>
|: <a href=3D"https://entangle-photo.org">https://entangle-photo.org</a>&nb=
sp;&nbsp;&nbsp;&nbsp;
 -o-&nbsp;&nbsp;&nbsp; <a href=3D"https://www.instagram.com/dberrange">http=
s://www.instagram.com/dberrange</a>&nbsp;
 :|<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH7PR15MB65033141AC68A2A0278B4C80F7212PH7PR15MB6503namp_--


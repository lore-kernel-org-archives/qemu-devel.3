Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4B6C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsKe-0001uh-FX; Wed, 06 Mar 2024 09:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wucf@cn.ibm.com>) id 1rhsKZ-0001nu-HW
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:33:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wucf@cn.ibm.com>) id 1rhsKX-0006Rj-0J
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:33:14 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 426EITEl004035
 for <qemu-devel@nongnu.org>; Wed, 6 Mar 2024 14:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : date :
 message-id : references : in-reply-to : content-type : mime-version :
 subject; s=pp1; bh=f3JFlfVqVCDe34HlXGMQjTvAva0inmsDI3LZHXkPTXw=;
 b=api3uZoc38EKt9fFrBiDImxEhhGiJ80DdxAOcY2NX0urBOPLWOtub/Yud06Y8Rb5jhWM
 abx7MmOeK2Le93fCjYV3qt2b5XClaqM8q8i/qqBNidGGoUmGgV2BcIKdVFg1LKCxR7C+
 lbAj4qCTFDi4ZAnwBCdv56uWLH2AjEMaaXO/EEakPa/YdV6X9k5ziWnsJLPS9xMY0Er8
 0A2Rpnk0Jjz1BHlblakuKqmaa+EOjpKCH8mbBC0pQqTtitxN0pmJGsaRg4RhktIwSlDZ
 6sv1YLW6izbDgEdI8UV8RLECyfhtgWoNf7PStIO5yfHw/tQR+KCGTYcYhU22L2m8M60/ iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpt4m8g8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 14:33:09 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426EJhgX008158
 for <qemu-devel@nongnu.org>; Wed, 6 Mar 2024 14:33:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpt4m8g7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 14:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYgGG715hQdSsRxaDR8a8FMHGHOWLf9aNqRkveKk0HmhF9zhbOq4mbbjiMaxKV3puP3hppgTid/hkhATogJ/2HiZz2NFTDEq0aACKBI8LRrc48SKJ2pKU6EXAt3yE3+sK8TgCo/uROEtUoNtXwyHlUbrPPOMUTrJKoCIlTWTmgbn6srnp8X4GVMEpyijTSWP6/tqOPyMO1AbPJ4ZHQit6WK30X4izGLl7l9/ZTUo18vxksgGyJDEyteCTFCACYcrvJJB2GfemLJ4PyHiL4CLT0khslLaguh0YWnyBb/JQ6Nkv1m6E6GJ2Af8a92aWw2MhRkI82pjh7oK7+As/E5rHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9Zx9cBbBHzZuMWc87ftQ1nCkpqqjQ+AT4m+ctK8lHw=;
 b=T3ZgsvghFttsgNvlAGhaEl1RgNFyvxT7OLyL4PTKrSwycoE16zHfhX/sCaprHdZIZTRDXpMAYR7huUtnr9avaMufH+T+VMjGLnwaERsDHZc3shOqCEQkXi+TW2KuTPxxQS7hOsJ16p5C2CDwqJItGjJe3+01cDKdQGSVu9zXFZuYZRB+MicEMwdfX+uCTzfgwHIMOm7B5j6XmuuPxErD5RagWL5AaNkbwQ3jE43iM8KePOQ24PK19gGXCu2HYDEzX5l6XNm8GpLDKrtqFBtL5STEBdGYx+ZyRTXynwFt7l9cYVXXF0QNohzGjrgqSI9iu75F+xfEixKfR4+U7Z/Bfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.ibm.com; dmarc=pass action=none header.from=cn.ibm.com;
 dkim=pass header.d=cn.ibm.com; arc=none
Received: from PH7PR15MB6503.namprd15.prod.outlook.com (2603:10b6:510:304::5)
 by SA1PR15MB6420.namprd15.prod.outlook.com (2603:10b6:806:3ad::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 6 Mar
 2024 14:33:06 +0000
Received: from PH7PR15MB6503.namprd15.prod.outlook.com
 ([fe80::f3d3:ce2a:4ed3:3ea9]) by PH7PR15MB6503.namprd15.prod.outlook.com
 ([fe80::f3d3:ce2a:4ed3:3ea9%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 14:33:05 +0000
From: Chun Feng Wu <wucf@cn.ibm.com>
To: Daniel Berrange <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL] Re: Does "-object" support structured options now?
Thread-Index: AQHabf2hpXTetJLRaU+zSXGLjQwKCbEnObmAgAOP2F4=
Date: Wed, 6 Mar 2024 14:33:05 +0000
Message-ID: <PH7PR15MB6503A217E33561AB9E193FA5F7212@PH7PR15MB6503.namprd15.prod.outlook.com>
References: <PH7PR15MB6503236A69BD173E62FC6791F7232@PH7PR15MB6503.namprd15.prod.outlook.com>
 <ZeWA8VrzgjKjETXh@redhat.com>
In-Reply-To: <ZeWA8VrzgjKjETXh@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR15MB6503:EE_|SA1PR15MB6420:EE_
x-ms-office365-filtering-correlation-id: 61544571-5538-436a-48a0-08dc3dea564a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xoxTtBB9RZoJpoVSgCnLSUis+P0WpGGNlYo/5jG2v3/kXgx8ZG7oXlgVbxaLqsGDmIO1Hnw/9zlXTKCw5lwpnFakp4YHp69JIlV89fd+I9S19HclmAE+9AKjDz4zvqX8m7/IcdyKOEDdwkoMOwMjyexlzljZEoDhdwS7RlFKwP+Fpn77VxLfQLjpcdL2oEbphYPZYVXRIhaCTTDoecUbENNSK/XKcNXkisGOh9d9FeQX1lGXn45oZ8rEq9Z6YEDnFtOTKUZrA9RwdarRGIJuas0bZoFzDu/PwBsUi2okoybAemf9rITjAIxra6mHESiUSu1efe1LqR6qvrUVOfwTDJmE8n71Gocp0O+IluWeC2+9rpvwqrk0WQZO5AWyDY5WfwsjbciLrxhUBggQHsL7vAeun5Wl28pgSTZl2mqX+SgOAbxfQ9KKcUg6SJG5dgjAQx0HBlI++jrulgJje0wUpFSjaH9a6nC1vCJdgvRVpzv6xgx6t3k5i+kdfPkoTXQzEEOxzlpR3HSlD9Nssk3RL3b/i8wMkYh9OI0LGS5ofrnYB446PEyEpTv+jq6vwmg4zFhghFMdqStPRQDeKTxcBfIK9TQ1IcQXOlSrtpwddrIhZPNKsyJBVesYlX/ITDn/2429A+8EP7EW5Shuim8uG6NhaN6EUXPm5pgDMQHiyqE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR15MB6503.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?yONQONG75JEZIH0rhRHsaWclKZjemATkTiTty2wX33aN3FSlfsiaTGaS?=
 =?Windows-1252?Q?FfmKUuipe6xxwAwJvZJSOHEyV876UN7WinE5IPJ4+Sg4H0MJ9EnIsTzp?=
 =?Windows-1252?Q?u4Qj90AJPi96eCZpoGlRdUGGgPake+AP5QPqpIDSeaIijMWyvrEWlZZ/?=
 =?Windows-1252?Q?lpHZwrmDP1ETj7VGGrQ3nZ/+geKFIkPKn59hWTr4FqdXME5T/tUu8Ciu?=
 =?Windows-1252?Q?1gdBnPQrWNO61vJS8XsbEH1N0fMqycrx5BitU9ZKOCIiWo8QC9UKD8/q?=
 =?Windows-1252?Q?jQhqPF82YO+pNPY8iRU0/GCX3/VziZxUF2BiF9EmL74v0qP6+tyMNOYM?=
 =?Windows-1252?Q?x7HCjyKyUUM6ELaMYV4omjVYZ/LrG+JSU8SgHU/JPbwZ6puD7ybjXGwn?=
 =?Windows-1252?Q?oK3kqFUvbJAOptHuLx0C5wClshrE/qCU4aKPw6xhvf4AIsmcCkh0utH9?=
 =?Windows-1252?Q?+0U9SL161tzV4cZWaAj8QjuL3YKpBy35rOaK0Ir3xC48ncG5SloSSqCA?=
 =?Windows-1252?Q?NfsAeH+OZza4odTyXMPStMwoDK3bH+Qyuc82zbje7Vz8ei9tHNN6/xXq?=
 =?Windows-1252?Q?R3Q1HnLXdCc+fTLVXP5FtZuW/POsHly/89fjq3KMyvXJRWXUPcp/1OSv?=
 =?Windows-1252?Q?J0fQWdq/ldHmFvzn27lL7auJ6EpbVlyzQwyKJy+HIWzmz5s0zEGkaUxA?=
 =?Windows-1252?Q?kWRs3LC92UeyZXI6mreK/d+M9fmcTEqdVv1tJSPdWuMbrwq54IL7dcpM?=
 =?Windows-1252?Q?aB3ThjeaWkHqmLkzs3iqZlmdy5sgRm5ik7kUMhFIV0jYaqEC6+39bmnK?=
 =?Windows-1252?Q?bx0dgsh8YkTVVSG3EiMtN2bhLu4/GziJytcEJbyyBv6rNAVtDm2vRkge?=
 =?Windows-1252?Q?89kkQAnk0HYo3iakhYXDoHeEL95y3JTxmKD739YiZ++WtTzbyLeFh0qE?=
 =?Windows-1252?Q?WnBxotGeBJp8UZEKvuY0TjR6qDMvDHYT3MQD2ah3FJb/ewLgVeNjzKHB?=
 =?Windows-1252?Q?jJAAtRp3QJiwMDAzDgiI2Ro8wA6h6luS2ds2tXI6196rvvsIlxlLRDIl?=
 =?Windows-1252?Q?P8d5koWtOh81p4pjNEARq8pgBnjKFsJkLgfQUh/aa27TveGHTlLIUt+s?=
 =?Windows-1252?Q?05KrAg6Vzw4bDBTstZ9IP1dITnpG5UynsfF7hB8pLw7N/B5Hof5kbELF?=
 =?Windows-1252?Q?UpUr7pVgYAvU+w0zCxUIiMDK+LwkOhODsQV7wfeXXAN0nXHcSrrtoVpN?=
 =?Windows-1252?Q?6iNdIMvtE/twXBskMQpaREbXwR3E39YEGt/yaEHrDKpcQk5P4y1tLp0a?=
 =?Windows-1252?Q?rBoi3sVOQU5Ki5Hc06RHZfJs+DmJrFg3OkMxsST/cjCHFJqWEEou2+E/?=
 =?Windows-1252?Q?Tf/rVwE7XDkYOy7O94TZqEjFNQuF8TXk43UhpLc88r3BjE3bOAAxkE9F?=
 =?Windows-1252?Q?0cy2lRgL8rm2h/NPMUfdImpilKjRnoJ1Y/qm/Qmzgf1gDJALt37snGVs?=
 =?Windows-1252?Q?sWhEd9Kxa4KwOHWaCbYEbPzuyR/3qxohkaWyGK5zaTpqLNTh58LSTetr?=
 =?Windows-1252?Q?9V0U7sshuqY+5jbMCmgKkAWCmLeO4Xvyv0vNldvietb4H7ef0c1hESYB?=
 =?Windows-1252?Q?X/9kXmOIzRVnlR8pTixqsx/IhKHrdJKUB6IO78qHd9l6pi0HnS48wvNs?=
 =?Windows-1252?Q?FZb4HKo26n7Tf+feB+fjPNbFbiKnZawY?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR15MB6503A217E33561AB9E193FA5F7212PH7PR15MB6503namp_"
X-OriginatorOrg: CN.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR15MB6503.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61544571-5538-436a-48a0-08dc3dea564a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 14:33:05.8751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0X2cz8NF3ZXw/7Zi2yaO6EOOawV9SnW/bNzcw3WpyBFO6mtlJhXyORn8xa8hz4x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6420
X-Proofpoint-ORIG-GUID: 1BlgJ9ONZg3LR63ylxii24477eMTPaPx
X-Proofpoint-GUID: rMtnqUhEAWm_AjkoSQ3qf4pMzPnD_Qw0
X-Proofpoint-UnRewURL: 52 URL's were un-rewritten
MIME-Version: 1.0
Subject: RE: Does "-object" support structured options now?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060115
Received-SPF: pass client-ip=148.163.158.5; envelope-from=wucf@cn.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--_000_PH7PR15MB6503A217E33561AB9E193FA5F7212PH7PR15MB6503namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Thanks Daniel for your response!

I tried it with the following cmd

qemu-system-x86_64 [other options...] \
  -object '{"qom-type":"throttle-group","id":"limits0","limits":{"iops-tota=
l":200}}'

And I got error:
qemu-system-x86_64: -object {"qom-type":"throttle-group","id":"limits0","li=
mits":{"iops-total":200}}: Parameter 'id' is missing

Do you know why such error happens?


--
Thanks and Regards,

Wu


From: Daniel P. Berrang=E9 <berrange@redhat.com>
Date: Monday, March 4, 2024 at 16:06
To: Chun Feng Wu <wucf@cn.ibm.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: [EXTERNAL] Re: Does "-object" support structured options now?
On Mon, Mar 04, 2024 at 06:43:19AM +0000, Chun Feng Wu wrote:
> Hi,
>
> I noticed that throttle-group can be created with =93-object=94, however,=
 per qemu doc(https://github.com/qemu/qemu/blob/master/docs/throttle.txt ),=
 =93-object=94 doesn=92t support structured options at that moment:
>
> =93
> A throttle-group can also be created with the -object command line
> option but at the moment there is no way to pass a 'limits' parameter
> that contains a ThrottleLimits structure. The solution is to set the
> individual values directly, like in this example:
>
>    -object throttle-group,id=3Dgroup0,x-iops-total=3D1000,x-bps-write=3D2=
097152
>
> Note however that this is not a stable API (hence the 'x-' prefixes) and
> will disappear when -object gains support for structured options and
> enables use of 'limits'.
> =93
>
> Does anybody know if the latest qemu code still lacks of such
> support(structured options for -object)? If so, is there any
> plan to support it(instead of non-stable API)?

-object supports JSON syntax these days so any QAPI structure can be
expressed no matter how complex.


With regards,
Daniel
--
|: https://berrange.com       -o-    https://www.flickr.com/photos/dberrang=
e  :|
|: https://libvirt.org          -o-            https://fstop138.berrange.co=
m  :|
|: https://entangle-photo.org     -o-    https://www.instagram.com/dberrang=
e  :|

--_000_PH7PR15MB6503A217E33561AB9E193FA5F7212PH7PR15MB6503namp_
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
	{font-family:Helv;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thanks Daniel for y=
our response!<br>
<br>
I tried it with the following cmd<br>
<br>
qemu-system-x86_64 [other options...] \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp; -object '{&q=
uot;qom-type&quot;:&quot;throttle-group&quot;,&quot;id&quot;:&quot;limits0&=
quot;,&quot;limits&quot;:{&quot;iops-total&quot;:200}}'<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">And I got error: <b=
r>
qemu-system-x86_64: -object {&quot;qom-type&quot;:&quot;throttle-group&quot=
;,&quot;id&quot;:&quot;limits0&quot;,&quot;limits&quot;:{&quot;iops-total&q=
uot;:200}}: Parameter 'id' is missing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Do you know why suc=
h error happens?<br>
<br>
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">--&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">Thanks and Regards,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US" s=
tyle=3D"font-family:Helv;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:Helv;color:black">Wu</spa=
n><span style=3D"font-size:11.0pt"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
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
<b>Date: </b>Monday, March 4, 2024 at 16:06<br>
<b>To: </b>Chun Feng Wu &lt;wucf@cn.ibm.com&gt;<br>
<b>Cc: </b>qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject: </b>[EXTERNAL] Re: Does &quot;-object&quot; support structured =
options now?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">On Mon, Mar 04, 2024 at 06:43:19AM +0000, Chun Feng Wu wrote:<b=
r>
&gt; Hi,<br>
&gt; <br>
&gt; I noticed that throttle-group can be created with =93-object=94, howev=
er, per qemu doc(https://github.com/qemu/qemu/blob/master/docs/throttle.txt
 ), =93-object=94 doesn=92t support structured options at that moment:<br>
&gt; <br>
&gt; =93<br>
&gt; A throttle-group can also be created with the -object command line<br>
&gt; option but at the moment there is no way to pass a 'limits' parameter<=
br>
&gt; that contains a ThrottleLimits structure. The solution is to set the<b=
r>
&gt; individual values directly, like in this example:<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp; -object throttle-group,id=3Dgroup0,x-iops-total=3D10=
00,x-bps-write=3D2097152<br>
&gt; <br>
&gt; Note however that this is not a stable API (hence the 'x-' prefixes) a=
nd<br>
&gt; will disappear when -object gains support for structured options and<b=
r>
&gt; enables use of 'limits'.<br>
&gt; =93<br>
&gt; <br>
&gt; Does anybody know if the latest qemu code still lacks of such<br>
&gt; support(structured options for -object)? If so, is there any<br>
&gt; plan to support it(instead of non-stable API)?<br>
<br>
-object supports JSON syntax these days so any QAPI structure can be<br>
expressed no matter how complex.<br>
<br>
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

--_000_PH7PR15MB6503A217E33561AB9E193FA5F7212PH7PR15MB6503namp_--


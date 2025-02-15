Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F790C021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 13:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjIGX-0008OE-30; Sat, 15 Feb 2025 08:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deniz.eren@icloud.com>)
 id 1tjIGV-0008Nv-7I
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 08:31:27 -0500
Received: from mr85p00im-hyfv06021301.me.com ([17.58.23.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deniz.eren@icloud.com>)
 id 1tjIGT-0001R5-73
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 08:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; bh=Y+ImUibxXZBEHCKRTzvnIDHlX9xlCTF8Kj/d7ujCD1k=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fUcgUvHgN40X7ok1mkfWebIzeojuUqUMfM7EtgDxuKCrLCSIPCsIy7jdeeMVSa173
 WxJuFeAaFOA92n0ax99UjopfNao9CQvryDKAuyX3NKn68nyvgioly4B+WEicpVbUYr
 qwe0b1v+qHBjfb5ojP/OKcQ/efwv/Le2J2t0Jg1FkFEjCFViHiXTxUhtsBdNkSzvV0
 hgqqEBWkGYe9Qcab2YajodFUsaqT9oogReujZR6rjEjoxal3SIxiWJKNLqi16d8cJe
 XCKjWNnjC9kgw8ZSZiwaeVXnBiwY7zpvG6hWcadYJauF8S0f+NOZkbojx3WpQqQuZW
 fEi6N6GkXFKwQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id 45A982150B17;
 Sat, 15 Feb 2025 13:31:14 +0000 (UTC)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-9E098B3B-9F35-42DB-9EAF-97F1CC0EBFD8
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 7/7] hw/net/can: Correct Kconfig dependencies after
 switch to meson build.
From: Deniz Eren <deniz.eren@icloud.com>
In-Reply-To: <202009232013.52889.pisa@cmp.felk.cvut.cz>
Date: Sun, 16 Feb 2025 00:30:58 +1100
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marek Vasut <marex@denx.de>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Frederic Konrad <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Ondrej Ille <ondrej.ille@gmail.com>
Message-Id: <3A8C14E4-3709-4866-B547-7AC621F5C368@icloud.com>
References: <202009232013.52889.pisa@cmp.felk.cvut.cz>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
X-Mailer: iPhone Mail (22D72)
X-Proofpoint-ORIG-GUID: kS8KJIzi110gv5DJf_eKqf8-xDyGyOEk
X-Proofpoint-GUID: kS8KJIzi110gv5DJf_eKqf8-xDyGyOEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-15_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502150120
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8
Received-SPF: pass client-ip=17.58.23.188; envelope-from=deniz.eren@icloud.com;
 helo=mr85p00im-hyfv06021301.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, MIME_QP_LONG_LINE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail-9E098B3B-9F35-42DB-9EAF-97F1CC0EBFD8
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I have implemented support for PCI MSI capability CANbus card support; fully=
 tested using QNX operating system guest image. How can I go about contribut=
ing this to the main repo:

https://github.com/Deniz-Eren/qemu/blob/feature/can-sja100-pci-msi-support/h=
w/net/can/can_pcm26d2ca_pci.c



Sent from my iPhone

Deniz Eren
+61 405 194 317

> On 24 Sep 2020, at 4:15=E2=80=AFam, Pavel Pisa <pisa@cmp.felk.cvut.cz> wro=
te:
>=20
> =EF=BB=BFHello Paolo,
>=20
>> On Wednesday 23 of September 2020 20:11:08 Paolo Bonzini wrote:
>>> On 23/09/20 19:44, Pavel Pisa wrote:
>>> If you have not pushed code to the mainline yet,
>>> consider v3 which should follow better actual
>>> mainline state. The list of updates to v3 follows.
>>=20
>> I actually queued v3 (I just use patchew to queue patches).
>=20
> That is great.
>=20
> Thanks,
>=20
> Pavel
>=20
> --
>                Pavel Pisa
>    e-mail:     pisa@cmp.felk.cvut.cz
>    Department of Control Engineering FEE CVUT
>    Karlovo namesti 13, 121 35, Prague 2
>    university: http://dce.fel.cvut.cz/
>    personal:   http://cmp.felk.cvut.cz/~pisa
>    projects:   https://www.openhub.net/accounts/ppisa
>    CAN related:http://canbus.pages.fel.cvut.cz/
>=20

--Apple-Mail-9E098B3B-9F35-42DB-9EAF-97F1CC0EBFD8
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto">Hello,<div><br></div><div>I have implemente=
d support for PCI MSI capability CANbus card support; fully tested using QNX=
 operating system guest image. How can I go about contributing this to the m=
ain repo:</div><div><br></div><div><div><a href=3D"https://github.com/Deniz-=
Eren/qemu/blob/feature/can-sja100-pci-msi-support/hw/net/can/can_pcm26d2ca_p=
ci.c">https://github.com/Deniz-Eren/qemu/blob/feature/can-sja100-pci-msi-sup=
port/hw/net/can/can_pcm26d2ca_pci.c</a></div><div><br></div><div><br></div><=
div><br id=3D"lineBreakAtBeginningOfSignature"><div dir=3D"ltr">Sent from my=
 iPhone<div><br></div><div>Deniz Eren</div><div>+61 405 194 317</div></div><=
div dir=3D"ltr"><br><blockquote type=3D"cite">On 24 Sep 2020, at 4:15=E2=80=AF=
am, Pavel Pisa &lt;pisa@cmp.felk.cvut.cz&gt; wrote:<br><br></blockquote></di=
v><blockquote type=3D"cite"><div dir=3D"ltr">=EF=BB=BF<span>Hello Paolo,</sp=
an><br><span></span><br><span>On Wednesday 23 of September 2020 20:11:08 Pao=
lo Bonzini wrote:</span><br><blockquote type=3D"cite"><span>On 23/09/20 19:4=
4, Pavel Pisa wrote:</span><br></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><span>If you have not pushed code to the mainline yet,</=
span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote typ=
e=3D"cite"><span>consider v3 which should follow better actual</span><br></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><=
span>mainline state. The list of updates to v3 follows.</span><br></blockquo=
te></blockquote><blockquote type=3D"cite"><span></span><br></blockquote><blo=
ckquote type=3D"cite"><span>I actually queued v3 (I just use patchew to queu=
e patches).</span><br></blockquote><span></span><br><span>That is great.</sp=
an><br><span></span><br><span>Thanks,</span><br><span></span><br><span>Pavel=
</span><br><span></span><br><span>-- </span><br><span> &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pavel P=
isa</span><br><span> &nbsp;&nbsp;&nbsp;e-mail: &nbsp;&nbsp;&nbsp;&nbsp;pisa@=
cmp.felk.cvut.cz</span><br><span> &nbsp;&nbsp;&nbsp;Department of Control En=
gineering FEE CVUT</span><br><span> &nbsp;&nbsp;&nbsp;Karlovo namesti 13, 12=
1 35, Prague 2</span><br><span> &nbsp;&nbsp;&nbsp;university: http://dce.fel=
.cvut.cz/</span><br><span> &nbsp;&nbsp;&nbsp;personal: &nbsp;&nbsp;http://cm=
p.felk.cvut.cz/~pisa</span><br><span> &nbsp;&nbsp;&nbsp;projects: &nbsp;&nbs=
p;https://www.openhub.net/accounts/ppisa</span><br><span> &nbsp;&nbsp;&nbsp;=
CAN related:http://canbus.pages.fel.cvut.cz/</span><br><span></span><br></di=
v></blockquote></div></div></body></html>=

--Apple-Mail-9E098B3B-9F35-42DB-9EAF-97F1CC0EBFD8--


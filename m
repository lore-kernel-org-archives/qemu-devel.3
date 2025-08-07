Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB32C87FD3
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 02:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujpz6-0006Df-RE; Wed, 06 Aug 2025 22:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ujpz4-0006Cm-Oa
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 22:03:59 -0400
Received: from p-east3-cluster7-host11-snip4-7.eps.apple.com ([57.103.84.238]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ujpz2-0001cY-Sh
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 22:03:58 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 EE2B618000AC; Thu,  7 Aug 2025 02:03:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=e/mO29Vn1/6qZpVxxklJ5nPaP1FzzlSf1Oy41vIuyzA=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=eCuCWesqRa4C56pptd9dqPlBvlIiCZP+ScabfwX0fXb3OjDd5eqrh6JnVw5edG8RvelC7+Tot1mlYvn8juHZZLfvnbeCYj1d0H0E0CTfcuCSqagAR0s//KODZFB2mih/UbWgU5HH1mOTT3LpGQYFEr81KYIvQqeSoaSN3i2ailrQxEwHWfpSFQu4fMwVmWUHeEf+jOX2y8ZrNP2tx5in0N9oyhahio1HFVLoKoFK5Ctymt64XrzlOv/hnwEKFEd+3KWrObEVPmhe1h+Eoo8o7FJ/oBh83OANt9o+MIr5BWK735sTWRI0J7LQXROYYXOtF+TY0kd6oxDso3wXSs0m8Q==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 6DB4218000A0; Thu,  7 Aug 2025 02:03:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <C4D5D2CF-64BF-400A-831C-903F4730BC9B@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_A7450463-3FF0-435C-9A6E-EE6B63A5FCFA"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3863.100.1\))
Subject: Re: [PATCH v5 02/13] accel, hw/arm, include/system/hvf:
 infrastructure changes for HVF vGIC
Date: Thu, 7 Aug 2025 04:03:35 +0200
In-Reply-To: <32928301-9db8-4003-84fc-82f3129bb8c3@linaro.org>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
 <20250728134114.77545-3-mohamed@unpredictable.fr>
 <32928301-9db8-4003-84fc-82f3129bb8c3@linaro.org>
X-Mailer: Apple Mail (2.3863.100.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDAxNCBTYWx0ZWRfX4LBNJvbztwnD
 WuOb7hZ6lpuTebPjKB7HUbdePTZ7qUpzWMmOxHlKpD9X03AJ1hXeEX+vCcaCaeda6jbAqW6ZQtx
 N3TTuLJla8CoU027R4Y8tjI9d1ptutJzHtK0DUf9cBlGnXmxvVjrBxT41FO8t7IPxobfS3N7Icp
 woTJ4Zx1vgm5i/OGUnbdYcI2D0WNsJlwX7P2GcfbdIAOhWBisZu2dlsLqeG0nvsrkUWwPFXCapg
 1dLW+ftfmbDuWcZdFoOOTFZrA4l00Q7T7CUiMrvNPZXay4j5HB0mso8fVRY+aIBr16SyVQqEw=
X-Proofpoint-ORIG-GUID: j6AoxJ-ODZ_aYJe1eBDZUHvNsdllyqhb
X-Proofpoint-GUID: j6AoxJ-ODZ_aYJe1eBDZUHvNsdllyqhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508070014
Received-SPF: pass client-ip=57.103.84.238;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Apple-Mail=_A7450463-3FF0-435C-9A6E-EE6B63A5FCFA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 6. Aug 2025, at 13:32, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> ... better add hvf_arch_register_class_properties(), empty stub
> on x86 and filled in aarch64.
Would it be fine to have the setting still without it doing anything =
right now?

(For reference, Apple added APIC APIs in macOS 12 on x86 - which we =
might possibly want to add later or not=E2=80=A6)

Or might as well implement support for the HVF APIC in the same series =
(?)=

--Apple-Mail=_A7450463-3FF0-435C-9A6E-EE6B63A5FCFA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 6. Aug 2025, at 13:32, Philippe Mathieu-Daud=C3=A9 =
&lt;philmd@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">... =
better add hvf_arch_register_class_properties(), empty stub</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">on x86 and filled in aarch64.</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: =
none;"></div></blockquote></div>Would it be fine to have the setting =
still without it doing anything right now?<div><br></div><div>(For =
reference, Apple added APIC APIs in macOS 12 on x86 - which we might =
possibly want to add later or not=E2=80=A6)</div><div><br></div><div>Or =
might as well implement support for the HVF APIC in the same series =
(?)</div></body></html>=

--Apple-Mail=_A7450463-3FF0-435C-9A6E-EE6B63A5FCFA--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A31AF55106
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 05:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzTct-00067N-TI; Mon, 09 Mar 2026 01:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzTcr-00066y-03
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:57:57 -0400
Received: from ci-2004f-snip4-6.eps.apple.com ([57.103.89.59]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzTco-0005KW-Fz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 01:57:55 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-2 (Postfix) with ESMTPS id
 5175E18000B9; Mon,  9 Mar 2026 05:57:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773035872; x=1775627872;
 bh=iIiveCfyDTZD3b7CBoeUSs/JWaTE/QuglIZEMhSQEJI=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=DcQT4pPPX8f44F/xEdFMeS3hVqBQ8Z/Z78IT2d/GvidNkW0wEz73RprCq0yYg25VACRHtef6cNrrV8hZXi2ICqRJLpfEmGlu5W+IX6SNgmC2HMb82/EpRfcth51LVl09XRog373xNZpoUxr0fTh6ZiSUpZTEZaRnRfswUW8Ody6vxPT1jztlC7WZD1RUD6x8de5nwX4MbsOAgLkytrGHdgD+aJChChsSk7w2GmCy2RHsQf5tmppCCWZmuYtj680EuCuMxH/upSreyQE+cuW0qd+UquNFvehWFnvJ+jsoigEc/kejbrq1O3fjHyACZ/WL0MZc+kEYDWHjBpS2CEusZQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-2 (Postfix) with ESMTPSA id
 1588A1800095; Mon,  9 Mar 2026 05:57:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <6A894B95-03A6-49EE-91A2-D3BCB09AAFCD@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_3428DE1F-8EA6-493C-8EE0-F5CC81F79B09"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [RFC PATCH v2 0/1] target/i386/kvm: Configure proper KVM SEOIB
 behavior
Date: Mon, 9 Mar 2026 06:57:38 +0100
In-Reply-To: <20260309054243.440453-1-khushit.shah@nutanix.com>
Cc: qemu-devel@nongnu.org, shaju.abraham@nutanix.com, jon@nutanix.com,
 mark.caveayland@nutanix.com, kvm@vger.kernel.org
To: Khushit Shah <khushit.shah@nutanix.com>
References: <20260309054243.440453-1-khushit.shah@nutanix.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: 5pNNHF9ThkRUJprcjwFwaOXW4KbjVQYC
X-Authority-Info-Out: v=2.4 cv=OsVCCi/t c=1 sm=1 tr=0 ts=69ae615f
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=64Cc0HZtAAAA:8 a=ebM0bOMmiKBTFg0fHpwA:9 a=CjuIK1q_8ugA:10
 a=4RsP3C8MxSXKoMckyAUA:9 a=uE1VpXKgi7NLAj7Y:21 a=_W_S_7VecoQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA1MyBTYWx0ZWRfX4YQDg29Oq50z
 vN1Xim83vSAWTUwdjnoYmkDNXA9ci2awHlXmi+1L55mvaZSMeJ1QN8Euoo5o+fYm4ovt3H5Zpdj
 5wulSN090MCk2567V1KImYKC9Dlba+hKZr/+oxxOJOdjOFZkP9hoCAAlgxjPd7QkX8zX1u2n1FA
 jUSvYSUtCITdlq6YMUBsXCXVplKlJL5q84JbSvmNMuUcXJzjl5VEFyIRaCTrQ2H57Dd7JVDGq7X
 sKC1aHlJcR+qiQwqQq4sN+9OfdpRZxQ7ngjuypTmCLkKCz7w/gSpqQP6oo4YSd2ShQhUonjCZ1/
 xhXxfYMEe58cf8M8lfbjZG5YFkM/+lzEKYMrkQnvnQH/wfdIA6YTaYE/6xELWs=
X-Proofpoint-ORIG-GUID: 5pNNHF9ThkRUJprcjwFwaOXW4KbjVQYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=725 clxscore=1030 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603090053
X-JNJ: AAAAAAABlc+yNPTgdQcr1JxgtO8dhH5Lpzqo7b9C02eQO/vm5ng0C4WimlUwBLEk5zerIZxzlkpIc5akTJdqlqeJqqSE5Kcge7SMX+sUYdz65TAhPleHHpW+ZxdoJVRusOYalCevdHVp4tdW5ioqfvJ4ECIMFqxuzOc9ueoahFWKx4RjoYGaF/Fd28AD5eAnz6Ocu9A7WqTYaTgVD/H8fbBipIM0+562fZ6thiH8vPnCIyHKJLHWgahYbnmBIXCa5TwL5poKa+B49czViZdqmcRP1O28RgnFWozxHOQ9AqShzmcK6XEgUG/LVG02Ro84GjiTgJ38c9Ad9mNuz94YI/ewMl6GUa+/72Cc7GwZPRxZAfqIUXiQBEKk4pBM/u2cqlIdj1bD+F+G7mfg+Bl+Q+++eMGMNmLJc+xC0cE+QMNvK6eBCzpK50qQQdo/u/NfMMPPn1BDMNQ9pa8RADh5FNi7EjmaoAQTt+XPoQkPZNrmff5iUPaVVLbK+4dnSVCdcI65I7emxdCPyrmuR2j2c342u5TvCD6r7wF4f08BcDTnaEReO2PB3CgeQbK3FgCLNIk17U2tmtTvQQbC/dQHDuL+1Nzo0+q7TV+b5C8x7DW26/hRMBnQrpn6czwixvbEd+H3jTTsG03EpKJcdNHP1igRQX8WNWAXDkx5n4PjA2FLP9KphdsoPRdsa2S/JPDgdSk8ylU=
Received-SPF: pass client-ip=57.103.89.59;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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


--Apple-Mail=_3428DE1F-8EA6-493C-8EE0-F5CC81F79B09
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 9. Mar 2026, at 06:42, Khushit Shah <khushit.shah@nutanix.com> =
wrote:
>=20
>  - Machine-type gating (restrict to 10.2+) helps with older machine =
types,
>    but still breaks migration to a destination with an older kernel =
that
>    lacks the SEOIB API, again without user opt-in.
Hi,

Ugh about this one, but am still convinced that a machine model version
is _the_ right way to deal with this. Will this be backported to Linux =
LTSes on the KVM side?

Or alternatively, what are the odds of having it fit as a CPU flag?
For example -cpu host,x2apic-suppress-eoi-broadcast=3Don.
=20=

--Apple-Mail=_3428DE1F-8EA6-493C-8EE0-F5CC81F79B09
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dus-ascii"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 9. Mar 2026, at 06:42, Khushit Shah =
&lt;khushit.shah@nutanix.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&nbsp;- Machine-type gating (restrict to =
10.2+) helps with older machine types,</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&nbsp;&nbsp;&nbsp;but still breaks =
migration to a destination with an older kernel that</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&nbsp;&nbsp;&nbsp;lacks the SEOIB API, =
again without user opt-in.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote></div>Hi,<div><br><div>Ugh about this one, =
but am still convinced that a machine model version</div><div>is _the_ =
right way to deal with this. Will this be backported to Linux LTSes on =
the KVM side?</div><div><br></div><div>Or alternatively, what are the =
odds of having it fit as a CPU flag?</div><div>For example -cpu =
host,x2apic-suppress-eoi-broadcast=3Don.</div><div>&nbsp;</div></div></bod=
y></html>=

--Apple-Mail=_3428DE1F-8EA6-493C-8EE0-F5CC81F79B09--


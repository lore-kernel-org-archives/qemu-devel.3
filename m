Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF58C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulShd-0006dY-Gr; Mon, 11 Aug 2025 09:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ulShD-0006QB-NM
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:36:21 -0400
Received: from p-east3-cluster4-host2-snip4-10.eps.apple.com ([57.103.84.23]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ulSh4-0005Ns-95
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:36:12 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id
 D50FC1800148; Mon, 11 Aug 2025 13:35:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Tmxh2a1UvT9pUKUz6YotIOx3TGB6BcCzkBuqlIy3F1Q=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=djNKSiVm5/YpVKYzrPXZBFeoomjdo/gpWKq8vKQmX4AUytRjXgSOSx01RTXS5QU1x2/AcwzPz50DwSWKQbuS9lp4pm6/xJXUM5C3aV4A26qYfStw1GsuXpoS3Il9z2xISK6s8CiiVw9nA68+HIC8j6/O6tF0DX2ZFAlyjRcmrHu186fHC2Sg9gLzOrYdPxQkiobrtyo553pPDCRj/iJXVAXdyRpHVlRtq83ZCpvhNnQQtQp6TIFKjMmw8nEHQZcofBF9mYVf0HQT0Rp2TptKRY+bvU88qB8Iv5T5NYunfqMmI20LyWBjeS9qz+2AXEm/GtJwfMWBfqs77gSJmVYmTQ==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id
 BB74418001B9; Mon, 11 Aug 2025 13:35:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <4F5DE89E-D3D5-4675-AE4F-45E2BB855252@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_B4E3596E-836D-49A6-B121-A8835A728BFA"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3863.100.1\))
Subject: Re: [PATCH v6 05/13] hw/arm, target/arm: nested virtualisation on HVF
Date: Mon, 11 Aug 2025 15:35:42 +0200
In-Reply-To: <7e1c5165-0395-43f5-9d53-25794cc7a4d7@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
 <20250808070137.48716-6-mohamed@unpredictable.fr>
 <7e1c5165-0395-43f5-9d53-25794cc7a4d7@linaro.org>
X-Mailer: Apple Mail (2.3863.100.1)
X-Proofpoint-ORIG-GUID: KN9YckLuzA6rVTaJHTCTI4GcMPFPQaOX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4NiBTYWx0ZWRfX7korOgBdWUs8
 xS4rir5Ma4wt3n/aygY6Mn3hop2MtlWI8VOJeJs4qg8i5nmD/zPkaMJC+FHGXOhgzaj2cn1TjHn
 H3iYc0VcE/7wFblGiGvPPJQSRDt5zdRQy63dIOmxhz0ElxqRRQNTSbw8nPm4eQc6H3QO/4p/PL+
 UuQzUxfkqoHNhMeB2JhIO9jge0gsX+yv4yRlTJiTQAfzGuBAF+Flh77O8czBQLIVmrCGYE6S8bC
 O79Rvn+2uqIumEgc9AUwIbIxGGLHKKTIcEiDznTOCbrqKz9K+yezkNlrlMGPPbuv+ROaXtyZ4=
X-Proofpoint-GUID: KN9YckLuzA6rVTaJHTCTI4GcMPFPQaOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1030 bulkscore=0 mlxscore=0 mlxlogscore=663
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508110086
Received-SPF: pass client-ip=57.103.84.23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Apple-Mail=_B4E3596E-836D-49A6-B121-A8835A728BFA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 11. Aug 2025, at 14:47, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> I'm getting HV_UNSUPPORTED on Silicon M1, I suppose because this
> method is not being called in this series (is there a patch missing?):
Nested virt is only supported by macOS on Apple M3 and later


--Apple-Mail=_B4E3596E-836D-49A6-B121-A8835A728BFA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On 11. Aug 2025, at 14:47, Philippe Mathieu-Daud=C3=A9 =
&lt;philmd@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;">I'm =
getting HV_UNSUPPORTED on Silicon M1, I suppose because this</span><br =
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
display: inline !important;">method is not being called in this series =
(is there a patch missing?):</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none;"></div></blockquote></div>Nested virt is only =
supported by macOS on Apple M3 and later<div><br></div></body></html>=

--Apple-Mail=_B4E3596E-836D-49A6-B121-A8835A728BFA--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA4BC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 21:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj323-0003uW-KK; Mon, 04 Aug 2025 17:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj320-0003qo-Oq
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:47:44 -0400
Received: from p-east3-cluster5-host8-snip4-8.eps.apple.com ([57.103.86.209]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj31y-0006Ny-NM
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:47:44 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 BAD6E180011C; Mon,  4 Aug 2025 21:47:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=6sh0gyG/2lQ4d7QeIjZul6w3yHgln86SfwZ0trUubTw=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=D7Y3wAqqLoUsCpiT1r9/Em3ax5K8WXbAUsG8akd1TuXFiDL1v38CHCT9A2nnaY6NM1mvDOfUfQr2hYsdggzlPoLES9efB8j6wF9/h1/Xvxf5BblICzNAjgiUTJGhokqE5SuJT7j8+SmGK4IUttJ96SovT0nX2B+dt52mVqoq9z0xRY5oLswSRhZ0CD87fW/PsoSqRN0zvUEWbgroW95choRRK9kKzq7PnCHcygWGMmlfsZDFnB8Pf7NWflEYDDbcYhk+aMNmSfHDH1GgBvxEwEEelOfV8TdjVtreqIJXc+gi2YXnre+6PqH/KRRx30qKyz3ATS8b4Kp6LMX6V1Mzag==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 DBFD91800128; Mon,  4 Aug 2025 21:47:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <4E0E2520-3812-451B-876F-5EA54ED23FD2@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_9B6CB5D8-5AD8-4C0C-A5D2-78EBBFB7A1B1"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v4 08/17] whpx: interrupt controller support
Date: Mon, 4 Aug 2025 23:47:25 +0200
In-Reply-To: <f8bb5277-bb6b-44be-a5ea-93e7dd55ca18@linaro.org>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-9-mohamed@unpredictable.fr>
 <f8bb5277-bb6b-44be-a5ea-93e7dd55ca18@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEzMiBTYWx0ZWRfX/J75KFQmMwDJ
 rmJF/GBlwA5KBhv7TYlP0dT+jIsQpp9/6BRs8IEusrY6NRvlLytR97v2lX8JTpuMMbjUn4Ur/lr
 DmGU+5O/yxm6oKlJnTD/3QLIxWNUeoN+BPNU012e/vM1Vrm2vhwyzbNDErNxJB0xMu8klKDJpQh
 V3Z/YHGqmCk1rEGbE6khG8Sh+CmU5uZt+Q1MjS5bNYj95rdqiu5ycqMcPwP3gAqNdWFUK+WQfYo
 DC2t3qGY6rcWPg2yBHEEfUGb3IvI3Mg7njIhBH8bpKvy4FYtqFiv4h4UdKxrYGdGmdSnW9RGk=
X-Proofpoint-GUID: XSb1V7R0lN6XLV521St65KoZfUltsFeh
X-Proofpoint-ORIG-GUID: XSb1V7R0lN6XLV521St65KoZfUltsFeh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_09,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=955
 suspectscore=0 bulkscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508040132
Received-SPF: pass client-ip=57.103.86.209;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--Apple-Mail=_9B6CB5D8-5AD8-4C0C-A5D2-78EBBFB7A1B1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 4. Aug 2025, at 23:39, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> Probably a stupid question, but since check, get_cpu and put_cpu are =
empty functions, why define them and the logic associated?

They are empty today but won=E2=80=99t be once save/restore is =
implemented for the GICv3 state, which is still incomplete so that I =
carved it out of this patch series.

That=E2=80=99s one of the last remaining blockers before VM save/restore

-m=

--Apple-Mail=_9B6CB5D8-5AD8-4C0C-A5D2-78EBBFB7A1B1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br><div><blockquote type=3D"cite"><div>On=
 4. Aug 2025, at 23:39, Pierrick Bouvier =
&lt;pierrick.bouvier@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline =
!important;">Probably a stupid question, but since check, get_cpu and =
put_cpu are empty functions, why define them and the logic =
associated?</span></div></blockquote><br></div><div>They are empty today =
but won=E2=80=99t be once save/restore is implemented for the GICv3 =
state, which is still incomplete so that I carved it out of this patch =
series.</div><div><br></div><div>That=E2=80=99s one of the last =
remaining blockers before VM =
save/restore</div><div><br></div><div>-m</div></body></html>=

--Apple-Mail=_9B6CB5D8-5AD8-4C0C-A5D2-78EBBFB7A1B1--


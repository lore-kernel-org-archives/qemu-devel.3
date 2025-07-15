Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EAAC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubdMX-0006eZ-PB; Tue, 15 Jul 2025 06:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ubdLo-0006Ax-35
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:57:34 -0400
Received: from p-east1-cluster4-host9-snip4-1.eps.apple.com ([57.103.89.84]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ubdLl-0001rw-9E
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:57:31 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by outbound.ci.icloud.com (Postfix) with ESMTPS id 4E57B18002FB;
 Tue, 15 Jul 2025 10:57:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=/XSqs04KMBeC6V+WtaGt4lw+I3GvWTQzHNMiRoBi3kc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=frhbNzzk5cQ2oyEw3G8qdFzk4/q/e1TXeIXJBt/26MCKRWV23YquxPIfmZ/yuVkN9PnbKnD0B2oCS/LD7pu+DIPNFvx58jxwdpnOedUkfdOqSHEUdK6P9H7S3X2MZAwvtNcXrwqxgXOigKP1I19vYjwk3BPf3BlBc86eQo895107ETjAwR+HO+oXORlP3fB0xOOXhCSeoCjA10xXNHYonpXUb7U8mx9zs9WrqPfTEE+PwPDKEuVhQfSMzpmM0kXXzR1GwuWLEsT/joZpfkqiOC3Q/eOA1eWsNRLBVq2VkzH8V1h4Qo+IlH5+5sOhSenj0Qli8gh5biAwCeElh/fumQ==
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by outbound.ci.icloud.com (Postfix) with ESMTPSA id 3046D18002C7;
 Tue, 15 Jul 2025 10:57:21 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH-for-10.1 v5 7/7] accel/hvf: Implement get_vcpu_stats()
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250715104015.72663-8-philmd@linaro.org>
Date: Tue, 15 Jul 2025 12:57:09 +0200
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <120F1DC1-AEDE-429E-BBB8-6D67082BE5D7@ynddal.dk>
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-8-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5OSBTYWx0ZWRfX6G2UdThxFmhA
 1Pya7EX9YlTyxD4QOOBnDf28YWjr/2mL9bo02RHebFTkHo+/Asrd1Sh/HFsB5olrfqaYpZDUv5W
 8DBf0Zgemgg01XHjb/Gu8bdUC9JW0dBJwD+vtjNAujRY6WwHjBpXfYNRUujFxjbh/XDH0sMCE9A
 niibfJgnQeQnd67FX9uiwedO8KXSkq04wLWF25wR1l/dyU4mZjgaTFW7fh6rpRYvN+5GKLaK3gM
 NKXaTDfwOZPnI6RglZUGDS4E+FDnApg+dfuilHyLW7okjAcEUN7NqefNa29W+CqRnMkg/yIHg=
X-Proofpoint-GUID: vpBqm3wPdK6pJTqmcAElL9UbqicwL1My
X-Proofpoint-ORIG-GUID: vpBqm3wPdK6pJTqmcAElL9UbqicwL1My
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=784
 mlxscore=0 clxscore=1030 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507150099
Received-SPF: pass client-ip=57.103.89.84; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


> On 15 Jul 2025, at 12.40, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Co-developed-by: Mads Ynddal <mads@ynddal.dk>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Mads, I welcome your Signed-off-by tag on top :)
> ---
> accel/hvf/hvf-accel-ops.c | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)
>=20


Looks great :)

Signed-off-by: Mads Ynddal <mads@ynddal.dk>=


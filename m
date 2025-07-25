Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA471C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 21:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufPeh-0003uC-C4; Fri, 25 Jul 2025 17:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chefkiss@icloud.com>)
 id 1ufNbi-00032c-N5
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 14:57:26 -0400
Received: from p-east1-cluster3-host6-snip4-8.eps.apple.com ([57.103.91.189]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chefkiss@icloud.com>)
 id 1ufNbg-0005tO-G1
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 14:57:25 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-1 (Postfix) with ESMTPS id
 19608180029F
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:57:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 bh=7Quw/78iJSaoYXFcOSt88FpPCtI4SOYR/Tt4K9/K0cA=;
 h=From:Content-Type:Mime-Version:Subject:Date:To:Message-Id:x-icloud-hme;
 b=Y1zQoN+UZ3q4Tmt/WWcPpVd9xhXNU679ekfVkhhoF32i2LTcWyT/ng0CqGsKV/JWGYqhC65oHwNdRKk6fefPeljAazOCdJ8AUhq4SwSWYWv3AaDCLUftmHAgRpmH7UDUA7hc0rmuq//N18KXntK6TTSb/UXt/iE2XRLhxWf9ugTZlFCLV+cXWrfaBdc4TrWbgNx/3j98wqoz7hCvsRQ9xwYWnQx8z2xELTaSuetqe2/X/lfnXq8wyzrns5Tix90Z8wvSvCBpf6zzicoyQkaHtbAGuDYEn2Orqi0CsrWZUJ9ZtBWTHW23gDd3dGvBlmwGRJlKn7uStUrDFbs65AKtFw==
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-1 (Postfix) with ESMTPSA id
 D51A3180014D
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 18:57:17 +0000 (UTC)
From: chefkiss@icloud.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: NVMe VMStateDescription
Date: Fri, 25 Jul 2025 21:57:05 +0300
References: <56AD2339-3C68-4466-86EE-CAF931987CB3@icloud.com>
To: qemu-devel@nongnu.org
In-Reply-To: <56AD2339-3C68-4466-86EE-CAF931987CB3@icloud.com>
Message-Id: <A48BB1DD-2E71-4F23-A86C-E64E318A707A@icloud.com>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-ORIG-GUID: 3n7z_vD6gTSVXAb24r4pQrpyu185cT5X
X-Proofpoint-GUID: 3n7z_vD6gTSVXAb24r4pQrpyu185cT5X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE2MiBTYWx0ZWRfX53ax/TIXSdx/
 PjqAax2FrPwi2ERrrParK2vF7OJW/gx/TYGFpURjeODu7l/5CK3JBqSajlAp0ZtZEAjFhOEnkos
 A6cptogsA8gv/6KL/7uu+L+q7RtBnSZwNLK8cTJzejiajyOisg94VxgtZfP8fquBe9MRX56FpeF
 t5LnHyzRwC7EDWWs3oKV0Oa5Qj4igMweRUo2/G3SePhVnrMhifzpy0cwLov3vn6SwuRS8DuGw11
 1XwpPevkdXgnKX1tsvUeCyKnkB2erf0XMSw3Q5gsnlB8OxWkrYZlT6VrXkRuoGri69fdvpBTo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507250162
Received-SPF: pass client-ip=57.103.91.189; envelope-from=chefkiss@icloud.com;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Jul 2025 17:08:33 -0400
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

Hello,

I have received no response about this. If I could please get an answer =
on this, it would help a lot.

Regards,
Visual.

Cc: Klaus Jensen <k.jen...@samsung.com>

> On 9 Jul 2025, at 21:26, chefkiss@icloud.com wrote:
>=20
> Hello,
>=20
> I am working with an SoC that only supports NVMe, and would like to be =
able to savevm/loadvm, and maybe also record/replay.
> The NVMe has a VMStateDescription with just unmigratable =3D 1 ever =
since it was first added in 2013.
> Is there a technical or other limitation/reason for why this is the =
case?
>=20
> Regards,
> Visual.
>=20
> Cc: Klaus Jensen <its@irrelevant.dk>



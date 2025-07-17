Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CBEC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLYf-0003KS-4O; Thu, 17 Jul 2025 06:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ucLYc-0003Gl-5T
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:09:42 -0400
Received: from p-west2-cluster2-host10-snip4-5.eps.apple.com ([57.103.68.178]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ucLYa-0006EM-Eo
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:09:41 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPS id
 84A5D1801F20; Thu, 17 Jul 2025 10:09:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=S3CGaxO0rpahQnGxJrjwVy5/K3jSNBZdKR/d735hBwc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=EKe2cUHEe0hmak5FpHocZz051MuOkaVg36h41vBmzyT0uMN7hhxiF6zWyhuHfPrODLFphHFkyXATVt4MFcKfGkieYpSLW05kj7Av9o/GW1y9VBsgoq9xRKQR9R6U4KmUnrJVTu1kyQnEluT/nga0VvG6FSoUgXPhMtI1YU/KdhuBkK1M9t00i/ZbNnfVajv9Zm71JpBJi+pyUKHxuDkmBRab+5yuhZ7Z7CJlIe62JPt5YJxMsmfQyiAgxFAdGRKwsBYmaLSxeW/tFVuKZ2DI5s9JnBpKVlKuFC+Ev5Hcf39UFpH/fKbApMTea9+s67cybWZjnjmXiDrHwJWaJWy6Fg==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com
 [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPSA id
 A634A18001F7; Thu, 17 Jul 2025 10:09:35 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH-for-10.1 1/3] accel/hvf: Display executable bit as 'X'
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250716172813.73405-2-philmd@linaro.org>
Date: Thu, 17 Jul 2025 12:09:23 +0200
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <95A43574-DB5F-4611-930B-4B598B2FE098@ynddal.dk>
References: <20250716172813.73405-1-philmd@linaro.org>
 <20250716172813.73405-2-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-GUID: uIw84HxnNttHqCbJtbHrenGbiP5Pv9j4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA4OSBTYWx0ZWRfX463gdIRFmrn/
 wREdAa3iFMd5WwCSBJOPsMuX1w5rzgG4R6pfjdKUp6mcyVGoEj0+pYkXPsaXtg3kop6cytJXH5z
 ZxsjqI9C9xB/L/+wvsiBgMGD6A5Ay/TDpUuL1Sq7CgpcVanvzkUH/3pec3qE3vYIInehxHsbz2v
 WkzF7emcfa0QP+78Nl9siBNoEdlIP5GI4bmGvetj5lHvqWqSjcMCP6TZ+WwEvNZgkDO9h+33n1H
 MgkAB/AL9Fzri9Sxs3znUOU5K5Lg2axLoYYAoPCXSxA5FmhXOF/v2Y6BAtdukH7tRy4hdnXVw=
X-Proofpoint-ORIG-GUID: uIw84HxnNttHqCbJtbHrenGbiP5Pv9j4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=983
 clxscore=1030 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507170089
Received-SPF: pass client-ip=57.103.68.178; envelope-from=mads@ynddal.dk;
 helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


> On 16 Jul 2025, at 19.28, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Developers are custom to read RWX, not RWE.
> Replace E -> X.
>=20
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> accel/hvf/hvf-all.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=


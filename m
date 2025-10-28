Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C21ACCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtTd-0005pX-DN; Tue, 28 Oct 2025 19:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtTb-0005ma-7J
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:51:43 -0400
Received: from p-east1-cluster5-host1-snip4-10.eps.apple.com ([57.103.89.141]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtTV-0005Nw-VU
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:51:42 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 707561802338; Tue, 28 Oct 2025 23:51:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=jzT04wkLoCg55N5pzsCS91/ign/79y0ila6uC8IJ+cM=;
 h=From:Content-Type:Mime-Version:Subject:Date:To:Message-Id:x-icloud-hme;
 b=G2w+Xxx6vEY8uVEkSOZuwek3vbvIoWHR6iln8zZvR+I08hGfe5FWII6oL6Ql+uedFQPLUyQok1JkQk+qV26uDaFIaokUxYMLGfB/XF3qvbfyWEuNbvJy9Inkp+wv2f5MgnVrEdh2I4OShx37F1YP0FPzZt+s0R+kPbc8Trtmb1WReQ8jncCR9sWjuJPm6Klh8Sj9e6X1grP/yXWoL1GPoI3Ei/U/t3f0ZCyAS4117qJC21Nr/XZDi5byqMopySi+JJFxiRHI8Go5L1Ns7qysfjP7Xl5kqIExami7vgekIRqfVG1/KsdqVRv+AjMm85/bPLWMYhdZKmDJD2Jwt08/Fg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 C834118027D3; Tue, 28 Oct 2025 23:51:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v9 00/27] WHPX support for Arm
Date: Wed, 29 Oct 2025 00:51:19 +0100
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
 qemu-devel@nongnu.org
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
Message-Id: <54FB4642-767D-406B-BB40-51D9E886645C@unpredictable.fr>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-ORIG-GUID: R6kaZU4v9ezIFmpUP37YdiBJcJ9oUnjq
X-Proofpoint-GUID: R6kaZU4v9ezIFmpUP37YdiBJcJ9oUnjq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX3LSf9yczvGcq
 +iaXHuUMbXIqDm+cOve6TElnYj/9eQ9yxV1qk2yOs0EwXpQYWKL4lPEtkgokju74wQRHORXbL9e
 omjq5Xk6nerFK018Srf37zmKMinEmA9gWaV8xTdr7W2cKhjgK4wCDwWgS3/Wqomb4EP7aLxEtsv
 x+2RWlxb7dWW3vh1qotG7zjOtoozZ9IgJk6TuGN1g2hg9IDJZP+Yj7Xdr4v716WNoq4Tj/E1BUu
 XeAKh2skK8mcJR8BaNVwQ/nT+VKEV0VGwj4wPo4nZ7uYs4p5X1EPmeMXmxG4GLAlAFakRM1is=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 clxscore=1030 malwarescore=0
 bulkscore=0 mlxlogscore=841 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABpq2r7Z36Eiy+7d/kSO6HFhQF1WTBxZXOn0VMYua8VTxYmjhIimq9j/AVr8t9zRnVSyQ1+pBpiCzwbokYw7G5650EkOOfsq5QPrjxuuJ31lRyi05wPSJZFXbw/JsGqkFcBmjOJfVGSioy5Cqm9C2ezWgKLt5XxmbyC/eWxipzsVr3IMerasd1QsjKCfT4Vq7vhGhlTErG/Hiehfjg9PD43Ipk4jcF86/6GGgAQ6vUuAknCl/V6LqFtavIDBRmcBEJGfx0K2XYn0Bnfu/QFerxG1RPb7ux/IlFPee5hyxtuXrGX/kPXzvyd8XtwsLWcTVIAqih+5eAxWTSQuY7WfuvVQeo9uj9vn+AnG0FSmYUCpeIiokLSKE42wLStYaBCP7ZSp5Y97K3AbcRgY6oZKGfV3j73m2U+Z7OsEtHWK0Xc4oEcNG9uVxDrJLQElZ8In95ZNw2ZEU9/vp1tc7JYTeogoKqo8OTI6AUpOsuuwwYcaGVYkKxnSnPM6q720W15h+4shfK6CpBgsUWFJDZBMxXiC8/Bu00fJ9Om2eKrMLIl1SyJhfbYQK7/pEsC4vFLYK2JVHg6YOG0Kpv/j4Xj4CnlU69mHC+lAxFWqiUDbXt9qepFtUWfd0gvOIrxdqNGZVoxS9cWg==
Received-SPF: pass client-ip=57.103.89.141;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 29. Oct 2025, at 00:47, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this =
submission: whpx-v10)
>=20
Erratum: the tag (and the patchset) is whpx-v9, not v10



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A5AC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 12:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucNrl-0007yr-61; Thu, 17 Jul 2025 08:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ucNWw-00040K-An
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:16:10 -0400
Received: from p-west2-cluster2-host6-snip4-10.eps.apple.com ([57.103.68.243]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ucNWq-0004G2-Qy
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:16:06 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 8A65A1800232; Thu, 17 Jul 2025 12:15:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=GoCqrUJ20t8UW/NDZR25ROY5aeBc3bfpe10YHonk8dk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=L14vz6+zApjNG/D1a00umBWJc0NdlZ7IyyAzblVQlHyR58zZBY/0h7HNLtIQOhT6L5PduncmMmaJ3sLs1GgXvXyvdqgHqvpvkYjkI+7Ne8NQP5flqc4EA/p5LU6hASrRU0Mz6Kx9KC1T4qMYAMBdCkpvAom4R9PB4eYNWDjV/27Qrrrha6Et8ea8r/DHrsyw8xa/0jdVNwUSVo07nBfExaNp0tBdJA9JCKibsq8tGyYg9AjuGlCEnpQidfeaP8uTs/SqIe0vKazOn3DGCtg+KaP1CFCseb19CR+nROUO/bbGwMQw6X2jhKlf1v3eV5+W8HapCwkQe+IErEbFDEfkBA==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com
 [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 69B0E1800B30; Thu, 17 Jul 2025 12:15:50 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH-for-10.1 3/3] hw/arm/virt: Warn when HVF doesn't report
 IPA bit length
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <e941efaa-e856-40b9-8ed7-0b4053f25498@linaro.org>
Date: Thu, 17 Jul 2025 14:15:38 +0200
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: 7bit
Message-Id: <7B5A2CF2-2EF8-4D0C-A15A-635581697BAC@ynddal.dk>
References: <20250716172813.73405-1-philmd@linaro.org>
 <20250716172813.73405-4-philmd@linaro.org>
 <84250F37-CCCF-49A2-8CB1-5B5CD1839004@ynddal.dk>
 <e941efaa-e856-40b9-8ed7-0b4053f25498@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-ORIG-GUID: oTWYLINkctg7JI-FCBYroh7uCMYWE0Rm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEwOCBTYWx0ZWRfX3/Gpl8ma183v
 MjsJomz2+QgQP5y5HymMpV7WEomeAyDeneHSOvFJUc/64eggaXixXon3nKzu/o+GZvGzu038mpa
 eYX3G15urQkT0AIeAgkYF4V+ATI7/T0q7oZYHd/kV6N3wc84q5OyD+S5wys38P8+3g+aA2j2nk4
 DXbAsrM/cb3aavnlrqkpWJVpWdu7u6B9KhdGjLLZiakp4S9jN/lOdU3ECmPwdAAl/X1HipPoh77
 0jy0Ahxjo+Jsh8ckqiOlGqIdBcRWKhQfTmIDlnajV9SNxBsnoancScORJxh6HcUV7/6NBjROU=
X-Proofpoint-GUID: oTWYLINkctg7JI-FCBYroh7uCMYWE0Rm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 clxscore=1030
 mlxlogscore=867 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507170108
Received-SPF: pass client-ip=57.103.68.243; envelope-from=mads@ynddal.dk;
 helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> This happens with nested macOS guest.

I took another look at the stack trace in the issue. Everything should
be fine then.

> Maybe we are missing an earlier check whether HVF is usable or not, but
> we shouldn't brutally abort().

I agree. I think with this patchset you're doing it practically as early
as possible with accel_init_machine.


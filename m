Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5431EC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLVi-00080X-QV; Thu, 17 Jul 2025 06:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ucLVY-0007sY-GR
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:06:32 -0400
Received: from p-west2-cluster2-host7-snip4-3.eps.apple.com ([57.103.68.246]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ucLVW-00063F-JR
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:06:32 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPS id
 D1CC41800AD4; Thu, 17 Jul 2025 10:06:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=NvkVRYw+9JQ5Dip45pP1SH6/XWJC7Z+fEn9XKPPG7+4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=On167NBvUuMmDZkpNPqKAeuAowhJY664WvzMM7AMEh1bJQu2VLTkgSOR9zWp+muXSQqY/nW1eRuJAc9kFqbaCAbZPcNov3tMVMeVevr8C0g18F15f6dZVXkLDsLW4+nqHcvC4tvZTMzjzpbmW47S91kuQLf9eowY7pRTZ9UhDnRjHjcp9Vk1g5Ph1DdpeYwFB52RUra4wjNx4Pedl3/od2UFBbn8fWq9kKVMihiv/Me0/EXBwIRJgA32me4Y9eko41P7IrDkPrC3qy1aCKVv6oFzhbwwhc5cMEuE7G3rZDQXgWjCds2k8FynPzbYK1qU4VxnpJTRCylGzZ9V8icQyg==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com
 [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPSA id
 C57651800ADF; Thu, 17 Jul 2025 10:06:23 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH-for-10.1 3/3] hw/arm/virt: Warn when HVF doesn't report
 IPA bit length
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250716172813.73405-4-philmd@linaro.org>
Date: Thu, 17 Jul 2025 12:06:11 +0200
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <84250F37-CCCF-49A2-8CB1-5B5CD1839004@ynddal.dk>
References: <20250716172813.73405-1-philmd@linaro.org>
 <20250716172813.73405-4-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA4OCBTYWx0ZWRfX7pauudNrRfIo
 +LYNHtiZn8LN7xLmxmndohRg816N6EIai1VeiEFcHetZEGGnSUj9blaLikrzwttXNBVduymET3M
 9JGiANrfNg5I87EOKriTJodB8+QKNTCQCr/vTLC7Dr1s2Z77B5jurOyRHhuJftyqAInVu+4scuJ
 K12aP07OofkYlS4HhekPbAu+boD5ZVCFuu1oUfS6yinm7q4JqzDnAJqy+aRzYOyxcTPEG3CCjyF
 WcmGXH3wnWjQqnhQv9eJhgXBqqTFFuOLizVnP7/FZRvp4wD/wWBzzYY2VPSy9VP/tsYaFP5xs=
X-Proofpoint-ORIG-GUID: CVrqlXMvFzqYLTsNyRg7n5WNniQGwaRI
X-Proofpoint-GUID: CVrqlXMvFzqYLTsNyRg7n5WNniQGwaRI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507170088
Received-SPF: pass client-ip=57.103.68.246; envelope-from=mads@ynddal.dk;
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
> Emit a warning when HVF doesn't return the IPA bit length
> and return -1 as "this accelerator is not usable", allowing
> QEMU to try with the next one (when using '-accel hvf:tcg').
>=20
> Reported-by: Ivan Krasilnikov
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2981
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> hw/arm/virt.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)

I haven't been able to verify that hv_vm_config_get_max_ipa_size and
hv_vm_config_get_default_ipa_size fail if HVF is not available, but
assuming so, it looks fine to me.

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=


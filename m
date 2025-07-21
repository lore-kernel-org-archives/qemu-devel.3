Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AF0C87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 09:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udmgL-00032j-VC; Mon, 21 Jul 2025 05:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udmgD-0002kz-3W
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 05:19:31 -0400
Received: from p-east3-cluster6-host1-snip4-2.eps.apple.com ([57.103.85.133]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1udmg8-0004LM-Jx
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 05:19:28 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPS id
 3BBCF18005D5; Mon, 21 Jul 2025 09:19:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=rNBRVyIFq1cls9Fv2ZropXi7/scmfUZp0UV2ALZZxBs=;
 h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
 b=N6LDmT9QhcME70+KsCMdnk03Itpca+P0mpy4eGVJS+069NZ38uqaj0XU/k/bZ3WJwFf3GKCsEq6O7VfNfMT0M0GLXTj+EXpi+hiTtOOzo1T5UEDAtCqERg32mXh6bpHkrtaxf/s9BnsX+5QErkxUaJnYNOTsnYOBUuJsSC4ccgu02+ROu28wQPA5qdg1VidcUm4r0ilzZvJ1QdVLsohpqTY542zKSd6qBTWvuebLLeL4HMMyPjSPDUT5iU5vJMWhZheaaoiMxOl/ILmddK5bjKFyE/ug9kQZU2urkmv/WQDjIL041hEUz+8xk3O+XErImarXabD9pc9ZP8mxshB46Q==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPSA id
 D681B18005C7; Mon, 21 Jul 2025 09:19:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3858.100.10\))
Subject: GICv3 + GICv2m configuration for -M virt
Message-Id: <E71D61BE-3A9E-4549-ABEF-2A713D23DDEC@unpredictable.fr>
Date: Mon, 21 Jul 2025 11:19:14 +0200
To: qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
X-Mailer: Apple Mail (2.3858.100.10)
X-Proofpoint-ORIG-GUID: mioiYLOdCSyfiozUOcqHnkqW1DmglTGE
X-Proofpoint-GUID: mioiYLOdCSyfiozUOcqHnkqW1DmglTGE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA4MiBTYWx0ZWRfX9erGP+RcwY9R
 10T3VEhMLLvITxDgFaSdR1TB4QSmdQ3dcUZcK9VGMlSfrsxIV4Z5XfO7DEYat71X+K8sDE6lom8
 2DSKr5CkbuGKgQ0NN60XG45Zhx+9ZkazmCrhVvWf9Bpa0QSysWeed4ZcovJgSncM6q3mz8vrlfy
 ZOHRYjsPkufJ8MTLK6/tINTiRjqfv9zCQw3cSt2q+3GOvggBZ450ibaN7k9OC7Ifl3Kw5qOXB3L
 D5spQkCztSkK1TMQ4MVwb8EZ6qMM2xtaIISgDpIc8BPj38wnsNETVk90vKHTCYNvDeN4h3Bww=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=813 bulkscore=0 suspectscore=0
 clxscore=1030 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507210082
Received-SPF: pass client-ip=57.103.85.133;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

On arm64 the platform GICs exposed in Hypervisor.framework on macOS and =
WHPX on Windows* do not provide an ITS but do come with an expectation =
that a GICv2m will be used for MSIs.

Would it be a good idea to shift Qemu over to exposing a GICv3 + GICv2m =
configuration in those cases by default on the -M virt target instead of =
the current state of things where MSIs become unavailable in that =
scenario? Or should an additional gicv2m flag be added?

* patches upcoming=20

Thank you,
-Mohamed=


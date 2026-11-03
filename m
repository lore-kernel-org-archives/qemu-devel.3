Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A1606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=GbQyWinG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xODyc-00047p-VI; Tue, 03 Nov 2026 07:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xODyY-00047V-Ko
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:50:55 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xODyW-00087i-30
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:50:54 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A3Cod5U012817
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Nov 2026 21:50:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jzXAAENAv11KQgslBcziOzK0rj/JmBEo3LHyn28MYdo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1793710239; v=1;
 b=GbQyWinGbzLkEWiGX4wRATBMg8f+xWBsmfkj2WMnAnnkCgQYELJGiBMjmY7kmKEv
 3cey3QMlqlRCGx8EGvBICX6cgepHMQU/HTRy6mcttvWdr5F1Clt34mGR34eRn3I4
 1CBxzMxZV+J7EFfVu6YAW72nIfszH8xW/vyum4LyjHWM8ZnmzJdDCknFA091SLhl
 qCGwdd+Lis7s+ZAWlQmiPabUgP+KA4Wqd9LKM/xoSZO/ELr4VgZNe9/tCPJjrl6I
 LOUGFLF0NEY/z9jq+Vi3UuqiHMJBPUQSWvHls29H5znPoxHRn0M/qZGIdl7MGRKO
 nsytZjXz7UaxtR2SRrnuOQ==
Message-ID: <029bf16d-0733-47db-8e3d-4b544a0ab2f6@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Nov 2026 21:50:38 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pcie_sriov: Rework the assert statements checking
 region numbers
To: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>
References: <20261028144539.691098-1-clement.mathieu--drif@bull.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261028144539.691098-1-clement.mathieu--drif@bull.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/10/28 23:46, Clément MATHIEU--DRIF wrote:
> pcie_sriov_pf_init_vf_bar: PCI_ROM_SLOT is already out of the SR-IOV
> regions.
> 
> pcie_sriov_pf_init_from_user_created_vfs: ROM region must never have a
> non-zero size.
> 
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


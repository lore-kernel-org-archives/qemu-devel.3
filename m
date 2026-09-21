Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4717DC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Xva-0008JB-Cv; Mon, 21 Sep 2026 02:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x8XvW-0008Ip-Cc
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 02:54:58 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x8XvU-0000sc-5o
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 02:54:58 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68L6sh6k078652
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 21 Sep 2026 15:54:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=CMWibwiqLcahIZH7jxkqWhMI5NEeFJhq9b6664KEgBk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1789973683; v=1;
 b=d5KqtC7V89Ukwcmm7FaaZLR1V3szR3QLGLmr+fNJAqE3kfxCuJDiNve5dnNapdgN
 4+ZSr/8gchK6/A+BjFl7o+lbe9Vt20LMjsPz2o9B0acxDGTd7WoRSxoyCLDs23zT
 5m3ZZQKuClfQkXy8ZCU4I4mOnLDPCVS93uWQMLS21MLZKquClsMU7nGraqjZKGWq
 V3cui5nZFjIeHG7WZK93qk2aNdU4X1IKVompKZKvhzyphPAkOLBNFoTSm9vj3/Cw
 IJXysC5hXP8WYMQIMgMKTZkXtFwTKi/WFlyXBESpKfc7dVbK2M9fkn+ZiewoCm6m
 wpVPVwHSDi/LJt6yrvqkMg==
Message-ID: <63b75f88-a771-4c7f-be16-0d174bf9bedb@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 21 Sep 2026 15:54:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pcie_sriov: Avoid capability structure overflow in PF
 reset
To: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>
References: <20260921055917.715685-1-clement.mathieu--drif@bull.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260921055917.715685-1-clement.mathieu--drif@bull.com>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/09/21 14:59, Clément MATHIEU--DRIF wrote:
> The SR-IOV PCIe capability exposes 6 regions (no ROM), each with a
> dedicated 32-bit configuration field. Fix the reset loop to write
> 32 bits instead of 64 bits and stop after PCI_SRIOV_NUM_BARS iterations.
> 
> As a side effect of this change, update PCIESriovPF::vf_bar_type
> to match the number of regions exposed by SR-IOV and rework the
> associated assert statements.
> 
> Fixes: c8bc4db403e1 ("pcie_sriov: Reset SR-IOV extended capability")
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


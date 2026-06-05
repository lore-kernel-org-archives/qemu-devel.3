Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C001CCD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 11:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVSL3-0007U7-Qq; Fri, 05 Jun 2026 07:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVSL1-0007To-Tt
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 07:03:43 -0400
Received: from msg-4.mailo.com ([213.182.54.15] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVSL0-0004Vw-4U
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 07:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780657417; bh=HIUXZ23cJoL7z6YuNj8R5oW/YZPd37UXSmbGQ6EZYyE=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=mqoX92qb7tb3HxMmIooarUHGmKh1LDiCvXfjWurOhF654grUS2vu6ot1vYueSVyBL
 0T9vCIEgq9oIiZ0IrVdFXcfuJvhtjk7yDlU2BCuVF7Of7t1kpc6COc61v2LScuBlVV
 6ecn9Vxgf5IduKa5h4ciItILVCRZXpnZwlrHRyeY=
Received: by be1-7.in.mailobj.net [192.168.91.17] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Fri,  5 Jun 2026 13:03:37 +0200 (CEST)
X-EA-Auth: 68YR+Nm7X3M+6/3G/mtPrTlMNBwrIzPzchj5pq9i1xdplMCPNoa472hdhApk6LXd+k1WA2w791bwPi9m5bZIw42N6lffw9f7
Message-ID: <31f00a8d-87ca-4dfb-bd18-de2e2a6806a8@mailo.com>
Date: Fri, 5 Jun 2026 13:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] hw/mem: add spm-memory device for Specific Purpose
 Memory
Content-Language: en-US
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, gourry@gourry.net, Zhigang.Luo@amd.com,
 Lianjie.Shi@amd.com, Igor Mammedov <imammedo@redhat.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
 <39411489-1473-44ad-ad56-392aa27990ab@kernel.org>
 <5ff45049-d96e-428c-915d-fc14cbcb5e58@amd.com>
 <d4297ad2-4695-4634-a12e-80d65a34e79f@kernel.org>
 <c9707c49-59ee-458c-8469-12943bab90c2@mailo.com>
 <20260603151443.612d0e61@imammedo>
 <c7c8e578-86eb-4b74-b63b-6b81a76c4329@amd.com>
 <1d2381a2-7101-4039-b41a-d4cccbade4aa@mailo.com>
 <6f6559c8-f3c2-4d10-be9e-75985bcc934e@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <6f6559c8-f3c2-4d10-be9e-75985bcc934e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.15; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 5/6/26 12:40, Huang, FangSheng (Jerry) wrote:

> Three items deviate from your suggestion:
> 
>    - DEVICE_CATEGORY_MEMORY: the enum doesn't currently exist in
>      include/hw/core/qdev.h, and pc-dimm / nvdimm don't set any
>      device category here. v10 follows the pc-dimm precedent.

Yes, this was a question for Thomas / Igor, do we want to categorize
memory devices out of misc ones?

> 
>    - QAPI base refactor (id / memaddr / size at TYPE_MEMORY_DEVICE):
>      acknowledged as a pre-existing pattern across PCDIMM / NVDIMM /
>      VirtioMEM / SgxEPC / HvBalloon; out of scope for this series.

Agreed.

Regards,

Phil.




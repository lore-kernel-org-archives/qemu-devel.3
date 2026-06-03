Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C41ACD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgua-0008Cz-W0; Wed, 03 Jun 2026 04:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUguX-0008CT-Fm
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:13 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUguU-00031o-Ql
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780473789; bh=fmKvSiVSFPzMcQN1rhOX2zs5IVFrjtsEw2ZSX1dVx7o=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=lu92GLB/PCxc8iUcSN5u3Sk5goMfBR8anUMKLKiyWOalt8Vee9CLpfpdMzKlQMRxw
 TNCWIkWpQ5zH7imYYIo3NIc7ISMp57qcylSikCvnHhWpfVTXQfoDlWUQMwKHW1Pdxc
 hCER4H8TX5RmFVW5k5nikULmNOEZAcGJX+y9dUEc=
Received: by be1-3.in.mailobj.net [192.168.91.13] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 10:02:42 +0200 (CEST)
X-EA-Auth: RiZFUR40nHyeugpWIh8E7ZWawg6/9NazkfWV4++RD9zObt619MW4RqOFtA7oxJpZT3SumwHZhXIbqk8sRoqPSEe56uJ6r3/V
Message-ID: <2936e19f-cf25-4e2f-ab53-37a379a78b2f@mailo.com>
Date: Wed, 3 Jun 2026 10:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] MAINTAINERS: cover spm-memory under Memory devices
Content-Language: en-US
To: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 imammedo@redhat.com, david@kernel.org, gourry@gourry.net
Cc: Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
 <20260602084447.1100554-5-FangSheng.Huang@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260602084447.1100554-5-FangSheng.Huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=213.182.54.12; envelope-from=philmd@mailo.com;
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

On 2/6/26 10:44, fanhuang wrote:
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7752917d8c..876744b29b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3365,9 +3365,11 @@ S: Supported

Add yourself as R: ?

>   F: hw/mem/memory-device*.c
>   F: hw/mem/nvdimm.c
>   F: hw/mem/pc-dimm.c
> +F: hw/mem/spm-memory.c
>   F: include/hw/mem/memory-device.h
>   F: include/hw/mem/nvdimm.h
>   F: include/hw/mem/pc-dimm.h
> +F: include/hw/mem/spm-memory.h
>   F: docs/nvdimm.txt

Squash with patch #1?



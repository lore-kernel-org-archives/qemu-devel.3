Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7C0CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 00:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6IJy-0001bo-3l; Tue, 07 Oct 2025 20:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>)
 id 1v6F0J-0004yr-2y; Tue, 07 Oct 2025 17:13:51 -0400
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>)
 id 1v6F0H-0005zv-Fz; Tue, 07 Oct 2025 17:13:50 -0400
Received: from [0.0.0.0] (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com
 [3.122.114.9]) by csgraf.de (Postfix) with ESMTPSA id 4AC526080403;
 Tue,  7 Oct 2025 23:13:47 +0200 (CEST)
Message-ID: <2b6c0bf1-3451-4f95-8316-90041da30a43@csgraf.de>
Date: Tue, 7 Oct 2025 23:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 4/4] Revert "hw/arm: Do not build VMapple machine by
 default"
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Peter Maydell
 <peter.maydell@linaro.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20251007203153.30136-1-mohamed@unpredictable.fr>
 <20251007203153.30136-5-mohamed@unpredictable.fr>
Content-Language: en-US
From: Alexander Graf <agraf@csgraf.de>
In-Reply-To: <20251007203153.30136-5-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Oct 2025 20:46:19 -0400
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


On 07.10.25 22:31, Mohamed Mediouni wrote:
> This reverts commit 49551752e860f5e403cdacac11ee1d218141fd3d.


The commit was there for a reason. What is the rationale to revert? Is 
it safe to do so now?

Alex


>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   configs/devices/aarch64-softmmu/default.mak | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/configs/devices/aarch64-softmmu/default.mak b/configs/devices/aarch64-softmmu/default.mak
> index ad8028cfd4..93f4022ad6 100644
> --- a/configs/devices/aarch64-softmmu/default.mak
> +++ b/configs/devices/aarch64-softmmu/default.mak
> @@ -9,4 +9,3 @@ include ../arm-softmmu/default.mak
>   # CONFIG_XLNX_VERSAL=n
>   # CONFIG_SBSA_REF=n
>   # CONFIG_NPCM8XX=n
> -CONFIG_VMAPPLE=n


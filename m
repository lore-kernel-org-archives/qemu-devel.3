Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B909C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 15:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8XS-0002eM-Va; Wed, 30 Jul 2025 11:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1uh7GI-0008GH-2V
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 09:54:38 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1uh7GC-00048m-5M
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 09:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
 In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PHPTLVc9jWF+u2VQoJcoCYjj4jhSC7bxGRxZ6DybSJg=; b=STyaMq1cRcVF5fJe3rVFM58Z/A
 /9vxx9pHm1QXJr6kf2hsD+0pGJ0M2m6YANcOecWUPrSy6LEkDVrGh0cppjfq3ZJDe1J5sazIEbIbW
 /mNKG9zL2AgDCIdxAyKqjd8oVIclnNw/C6n5NKeYJCJGYKkXDTrq1y+to9z5zswqOVCA6NCwbJ060
 IGLaOy7QgQLZL06q/4tE7lDQF7Vz5Zj4s6G97cavPC0l4NDXYaFciePuDXfRrZRdGMEKZn1/VsDGS
 L+NMSpZ/E+c87DiXTylitaFfB/cr5b4oyXpDToHNuRQ3F8MgwxsiVjI65hOjlnMqmwShhYEvfDGs2
 lQ+5crig==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uh7G3-005yPi-13; Wed, 30 Jul 2025 15:54:15 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
 by mail.igalia.com with esmtp (Exim)
 id 1uh7G0-0054J0-KY; Wed, 30 Jul 2025 15:54:14 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
 by webmail with esmtp (Exim 4.96) (envelope-from <asb@igalia.com>)
 id 1uh7G0-000Hgk-0B; Wed, 30 Jul 2025 15:54:12 +0200
MIME-Version: 1.0
Date: Wed, 30 Jul 2025 14:54:12 +0100
From: Alex Bradbury <asb@igalia.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Subject: Re: [PATCH 0/5] contrib/plugins/hotblocks: Minor bug fixes and add
 limit argument
In-Reply-To: <CAAjaMXbxpauL8V2FVbQ6-8TNVbG7ATRjm0Gn+J_cb=aiK_cG4A@mail.gmail.com>
References: <cover.1753857212.git.asb@igalia.com>
 <CAAjaMXbxpauL8V2FVbQ6-8TNVbG7ATRjm0Gn+J_cb=aiK_cG4A@mail.gmail.com>
Message-ID: <dc58a4f592f0a77bc60044ce7f5d27f6@igalia.com>
X-Sender: asb@igalia.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=asb@igalia.com;
 helo=fanzine2.igalia.com
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

On 2025-07-30 14:48, Manos Pitsidianakis wrote:
> Hi Alex,
> 
> On Wed, Jul 30, 2025 at 4:19 PM Alex Bradbury <asb@igalia.com> wrote:
>>
>> This series contains one minor feature addition and a series of small
>> bugfixes/improvements. The addition that motivates the submission is to add a
>> limit argument for the hotblocks plugin, allowing you to control how many
>> blocks are printed rather than being hardcoded to the 20 most executed.
>> Setting limit=0 and dumping information about all executed blocks is
>> incredibly helpful for an analysis script I have downstream.
>>
>> This is my first contribution to QEMU. I've attempted to follow all of the
>> guidance in the "Submitting a Patch" guide, but apologies if I missed
>> anything.
>>
>> Alex Bradbury (5):
>>   contrib/plugins/hotblocks: Correctly free sorted counts list
>>   contrib/plugins/hotblocks: Fix off by one error in iteration of sorted
>>     blocks
>>   contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than
>>     PRId64
>>   docs/about/emulation: Add documentation for hotblocks plugin arguments
>>   contrib/plugins/hotblocks: Allow limit to be set as a command line
>>     argument
>>
>>  contrib/plugins/hotblocks.c | 20 ++++++++++++++------
>>  docs/about/emulation.rst    | 12 ++++++++++++
>>  2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> --
>> 2.50.1
>>
>>
> 
> I think the mailing list ate up your first patch. Not your fault
> though. I did not receive it in my inbox and it's not on
> lore.kernel.org either:

Thanks for taking a look - it seems like it's made it through now
https://lore.kernel.org/qemu-devel/cf5a00136738b981a12270b76572e8d502daf208.1753857212.git.asb@igalia.com/

Best,

Alex


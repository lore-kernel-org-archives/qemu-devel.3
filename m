Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E166D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 10:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV5tK-0001FJ-Qh; Mon, 15 Dec 2025 05:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vV5tI-0001DO-9x
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 05:33:20 -0500
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vV5tG-0001xz-2U
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 05:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
 In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lh8KbqM1veuw2jX8g8VR/xMKoAFXa9DGblfdO/xJDlQ=; b=Jryavea6HJfhtuYkwKXehLlyDo
 h6zsN/cBbsBLyrACLTMdcXOq6eiRiiLYyzlx+TmMjPlTanc1wmxS3wImg7q75e7ZvxDIA2pECSehn
 nuSmmbv16I22QSv52uduIY2xauKGciDNqSQPvTGzYOEojvzl8RvluEeQfcRiWNLZy/TbhRye8GWCc
 PFyCZ6k5ZmGMt9YaPiWlcLdOwA/8rWpRgVF3kENyJXQp642Di4jUZu5tb2+MtW4dq1cKNk3ZAKztI
 6JsFXLnGzRaRoslSUNiv+YN7wlQCVAVP2mr7fpOe3pK0b9E5B/iWXzDkPQv59ymHNJHNXUGyK3iHx
 r8Yb8mng==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vV5t8-00CtX6-EN; Mon, 15 Dec 2025 11:33:10 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
 by mail.igalia.com with esmtp (Exim)
 id 1vV5t6-000kEh-4k; Mon, 15 Dec 2025 11:33:10 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
 by webmail with esmtp (Exim 4.96) (envelope-from <asb@igalia.com>)
 id 1vV5t5-006etf-2A; Mon, 15 Dec 2025 11:33:07 +0100
MIME-Version: 1.0
Date: Mon, 15 Dec 2025 10:33:07 +0000
From: Alex Bradbury <asb@igalia.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 0/5] contrib/plugins/hotblocks: Minor bug fixes and add
 limit argument
In-Reply-To: <874ipzwrvp.fsf@draig.linaro.org>
References: <cover.1764716538.git.asb@igalia.com>
 <6955a4f0a032b68a2b9fb1d1b6a7b620@igalia.com>
 <874ipzwrvp.fsf@draig.linaro.org>
Message-ID: <20ad92ad1052fea35017cfb332818e4c@igalia.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2025-12-09 16:18, Alex Bennée wrote:
> Alex Bradbury <asb@igalia.com> writes:
> <snip>
>> Sending a ping as per the guidance at
>> <https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-your-patch-seems-to-have-been-ignored>,
>> and also linking to the patch on lore.kernel.org as that page suggests
>> <https://lore.kernel.org/qemu-devel/cover.1764716538.git.asb@igalia.com/>
> 
> Sorry I missed this in v1. As we are getting very close to 10.2 getting
> out of the door I'll punt this until the tree re-opens. I have it on my
> backlog now.
> 
> If you want I can also cc qemu-stable if you think its worth having the
> cleanups in 10.2.1

Thanks for applying to your plugins/next tree. If it's possible to line
up for 10.2.1 and it's in line with your policy (the only intentional
functional change is adding the limit= command line argument, which is
ultimately trivial) then that would be appreciated.

Best,

Alex


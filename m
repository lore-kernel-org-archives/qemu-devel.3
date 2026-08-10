Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FCAC5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtO7P-0003LF-5o; Mon, 10 Aug 2026 07:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wtO7O-0003Kz-19; Mon, 10 Aug 2026 07:24:34 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wtO7I-0007oL-1E; Mon, 10 Aug 2026 07:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=3RZGRfP3RVVARhk3tr5taGK8vLGQcoNNxQVrn88ra2I=; b=IpqLidzXZJZooKk
 ydj7Dc4nng6S2/ahUq45/3qxKO9yRUbHjK5CVV5seOm6QXafpjChNFu7c3ZQFqMrrpgpHWdg0aSOh
 VSSIcyAjHDgBHgw/EH6GeDfh3aMOhhgzmNTEFTLm3L+/6Y4bgrorteJh01Wnkit09Gjzd3Li+cUWq
 T4=;
Date: Mon, 10 Aug 2026 13:29:41 +0200
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, git@xen0n.name, 
 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 philmd@mailo.com
Subject: Re: [PATCH 06/11] target/mips: Expand octeon reflections inline
Message-ID: <anm0gOYowSj-3PdO@hive.localdomain>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731000503.170446-7-richard.henderson@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 31/07/26, Richard Henderson wrote:
> Use tcg_gen_revbit64_i64 instead of out-of-line helpers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/mips/helper.h               |  7 -----
>  target/mips/tcg/octeon_crypto.c    | 35 ---------------------
>  target/mips/tcg/octeon_translate.c | 49 ++++++++++++++++++++++++++----
>  3 files changed, 43 insertions(+), 48 deletions(-)

Reviewed-by: Anton Johansson <anjo@rev.ng>


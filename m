Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE391D6ED08
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 11:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE52a-0000Aw-8f; Thu, 21 Nov 2024 06:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tE52Y-0000AQ-2r
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 06:08:02 -0500
Received: from 4.mo552.mail-out.ovh.net ([178.33.43.201])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tE52W-0002G9-0i
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 06:08:01 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.176.7])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4XvFnW0Q73z1PNM;
 Thu, 21 Nov 2024 11:07:43 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 12:07:42 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0030e79cc76-9273-494e-8d8c-ea7885503c3c,
 FF192833FC087472966912589AD63751DC8D0292) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Thu, 21 Nov 2024 12:07:39 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, Linus Heckemann <git@sphalerite.org>
Subject: Re: [PATCH] 9pfs: cleanup V9fsFidState
Message-ID: <20241121120739.5f2a8c1d@bahia>
In-Reply-To: <E1tE4v2-0051EH-Ni@kylie.crudebyte.com>
References: <E1tE4v2-0051EH-Ni@kylie.crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 0b539284-9ed7-41b6-94da-0da0420be5fb
X-Ovh-Tracer-Id: 1476617730153290205
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeigddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeekjedtveegkeeileffvdetvddvgedtudduiefghffhgfdvhfegjeetkeehfeeknecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddtpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehgihhtsehsphhhrghlvghrihhtvgdrohhrghdpoffvtefjohhsthepmhhoheehvdgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=Bd+gBqoNJ0k9U4pyQqcz4XB4liIozqJKIWhrIWEwU6M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1732187263; v=1;
 b=dj3yKfxRwZnmA8Xk1fcanoJPTazf9A3YKWvYva/kgE00jF23m8u+1oQfvlt2gft0RWPkrvEW
 cZt5+QkCIpvdEr5Jb1RbFHesaDrwkTEamkb+7JiLqfG8UDntowq+3+G49kiLOixF49fqlHY0Uef
 zMpMihGJUs7zb51hwI91ia/n6YLP5vdbyJ20ARQuoWHuo6IY6Mn2ONtfImS4QLV9m25MwSY+4Lj
 kXdLDY3ViZgvtqVZaOJOd9mDUGlHz7mKOEbPEN/iyfXARugSAq6e/3TTpihlEoSU4iNlJu77sYV
 Q8zLdjS+rJTNPbAzpMXhvfcQvdrWnTPU1KwA5xIech8KQ==
Received-SPF: pass client-ip=178.33.43.201; envelope-from=groug@kaod.org;
 helo=4.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 21 Nov 2024 11:52:48 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Drop V9fsFidState's 'next' member, which is no longer used since:
> 
>   f5265c8f917e ('9pfs: use GHashTable for fid table')
> 

Good catch !

Fixes: f5265c8f917e ('9pfs: use GHashTable for fid table')
Reviewed-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index a6f59abccb..5e041e1f60 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -280,7 +280,6 @@ struct V9fsFidState {
>      uid_t uid;
>      int ref;
>      bool clunked;
> -    QSIMPLEQ_ENTRY(V9fsFidState) next;
>      QSLIST_ENTRY(V9fsFidState) reclaim_next;
>  };
>  



-- 
Greg


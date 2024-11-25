Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBF4D3B7F1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFUrr-0002v1-Sp; Mon, 25 Nov 2024 03:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFUrV-0002lX-9r
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:54:29 -0500
Received: from 5.mo548.mail-out.ovh.net ([188.165.49.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFUrT-0006ED-Lr
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:54:29 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.140.134])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4Xxfdr4Pqbz11Mf;
 Mon, 25 Nov 2024 08:54:24 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 09:54:24 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0026221e93c-d75e-46aa-b93c-a72a114f466b,
 9B13B6726B83599ED9C5792380F23B2D0625FF83) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 25 Nov 2024 09:54:17 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 4/6] 9pfs: remove obsolete comment in v9fs_getattr()
Message-ID: <20241125095417.438e2f32@bahia>
In-Reply-To: <fb364d12045217a4c6ccd0dd6368103ddb80698b.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <fb364d12045217a4c6ccd0dd6368103ddb80698b.1732465720.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: f70c898c-5aff-483f-a8e0-5302ed17b2e8
X-Ovh-Tracer-Id: 4269412447911713245
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleekpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=NGVyXouLZIxnWQuYJqJx2bPNpUY9eXVs2OulvpjQ9lA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1732524864; v=1;
 b=XEHxJmkBSAAgbnvZ3UOQuvQM3n8CCzNu3wcu1wUnrnNUdfoDv1Ocj7VgPAci52HFLum+eF3C
 8dtl4yNWA9qNgK2py1tOnLfe/UrAWWzzQtXa34Qsd9NWLWabK49agpVgpzQ5M8yNlrHlA7D8E+s
 SA9iRWrLW4f46zPya/U3I2OCOgB/ApQwT7xiFleyVBZ0zL1dFIZJqtVhxYd+IM0aNiLgEUQCGev
 5SlGN/hJ2vIBuriq2jhsYOSOdSJN7UZ+fWeR6NLhJazzRFGc4pGqXjZdxMtPhNELjjoL45zt9od
 XryczlPQyGSoZd4BYE/KxVMG1DaX+ddlTJHoRXPMWrSOw==
Received-SPF: pass client-ip=188.165.49.213; envelope-from=groug@kaod.org;
 helo=5.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 24 Nov 2024 16:06:40 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> The comment claims that we'd only support basic Tgetattr fields. This is
> no longer true, so remove this comment.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Heh another very long standing nit :-)

Good catch !

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 9a291d1b51..851e36b9a1 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1596,10 +1596,6 @@ static void coroutine_fn v9fs_getattr(void *opaque)
>          retval = -ENOENT;
>          goto out_nofid;
>      }
> -    /*
> -     * Currently we only support BASIC fields in stat, so there is no
> -     * need to look at request_mask.
> -     */
>      retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
>      if (retval < 0) {
>          goto out;



-- 
Greg


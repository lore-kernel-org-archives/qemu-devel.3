Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A582D3B7F1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFUla-0000n9-FJ; Mon, 25 Nov 2024 03:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFUlZ-0000mg-NK
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:48:21 -0500
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFUlY-0005RC-46
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:48:21 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.25.112])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4XxfVn57mwz10Ms;
 Mon, 25 Nov 2024 08:48:17 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 09:48:17 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00679406e19-4716-4bea-83a9-98cbfa6ce69d,
 9B13B6726B83599ED9C5792380F23B2D0625FF83) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 25 Nov 2024 09:48:09 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 2/6] tests/9p: fix Rreaddir response name
Message-ID: <20241125094809.1e7d2bcd@bahia>
In-Reply-To: <daad7af58b403aaa2487c566032beca36664b30e.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <daad7af58b403aaa2487c566032beca36664b30e.1732465720.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: cac344ee-de2b-4577-9c5e-2dce7e9b0c03
X-Ovh-Tracer-Id: 4166111131521358301
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtiedpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehgeekmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=WrK2D5viesXupmPj6r6mRsv1uMqHflvmZGnHzDBHDRQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1732524497; v=1;
 b=jtBCk4EqYhfOBrCp3+yPYZ/9oefHPTGnWS+V8E/wdqAHUZxL7FE2y/pbY5qqUKafwT1jxQwF
 U12sByQ1wTuMY/yXFjtb+2Jv+y9L9lSvbgFXuUCc5mwzssHRdi8PdD/KuH/iz+n+6Dj4wqfXems
 UT+d/3UZxOBr5RABPXYXVUs8Vozstg6P8Lw10P4Yh5WYi+qBdDyYp3dGQRO+sLO1ym/UvIat7Tj
 ScUSf4wypqLCQT2flvs9PG34vgk8fvoEz4FoWdeLovtvliF5b8hMdhA1OQb5JDB7NXzzQSGOw65
 Y/opzi171VInOxYX8jSY6PSqkpWdNeJbUgpLW6zvQStjQ==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=groug@kaod.org;
 helo=3.mo548.mail-out.ovh.net
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

On Sun, 24 Nov 2024 14:34:31 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> All 9p response types are prefixed with an "R", therefore fix
> "READDIR" -> "RREADDIR" in function rmessage_name().
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/libqos/virtio-9p-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
> index b8adc8d4b9..c61632fcd3 100644
> --- a/tests/qtest/libqos/virtio-9p-client.c
> +++ b/tests/qtest/libqos/virtio-9p-client.c
> @@ -238,7 +238,7 @@ static const char *rmessage_name(uint8_t id)
>          id == P9_RLINK ? "RLINK" :
>          id == P9_RUNLINKAT ? "RUNLINKAT" :
>          id == P9_RFLUSH ? "RFLUSH" :
> -        id == P9_RREADDIR ? "READDIR" :
> +        id == P9_RREADDIR ? "RREADDIR" :
>          "<unknown>";
>  }
>  



-- 
Greg


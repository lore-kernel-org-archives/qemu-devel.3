Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194DAD3B7F3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 08:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFUoh-0001j6-Im; Mon, 25 Nov 2024 03:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFUob-0001hz-HT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:51:29 -0500
Received: from 2.mo552.mail-out.ovh.net ([178.33.105.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFUoZ-0005nc-ND
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 03:51:29 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.140.168])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4XxfZN6W9mz1Qw4;
 Mon, 25 Nov 2024 08:51:24 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 09:51:24 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0033b2de842-5e7e-4c56-8860-63f1d210d7cd,
 9B13B6726B83599ED9C5792380F23B2D0625FF83) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Mon, 25 Nov 2024 09:51:23 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 3/6] tests/9p: add missing Rgetattr response name
Message-ID: <20241125095123.05c4457b@bahia>
In-Reply-To: <e183da80d390cfd7d55bdbce92f0ff6e3e5cdced.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <e183da80d390cfd7d55bdbce92f0ff6e3e5cdced.1732465720.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: a9e1eb72-ddbe-437d-b205-d45ea75a2ad0
X-Ovh-Tracer-Id: 4218746953838598621
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddttddpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehhedvmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=VQVehl+GxkQ1OSzl0FMfMWMD5M/e2f8DBlyMc95S30Q=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1732524685; v=1;
 b=iQ9k5NCdORtyBm4XMR+nWz90daV+h+1P2+X/nveViz8CsLXEM4/GRBghFzEC/ODSo8g87HYr
 kbPuxM/UP2QjMvjBZPYI9WWltcYxkqJ/YZITc13klo4LmSX+nFpVM5daDPULXD7bWg27dmbxz38
 YlkGWJSIBFfJQRdE0j3jCFP9m+5gjiqm3eagpJ/vbIxYUu/LWatv8jXQCfAqORVd0tQFDFTt01V
 z29bZRsXYHx8gQgs5gKNLgezIq5HwqBbf5EsPjcD1Xb1n4CD0s4rQ1zy6dmXZFZKZMRGWAON+WA
 DcxQBwdk8/S8dVj2P4ZUDqWpfnT3DM+Q0htlgmOK5hwPQ==
Received-SPF: pass client-ip=178.33.105.233; envelope-from=groug@kaod.org;
 helo=2.mo552.mail-out.ovh.net
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On Sun, 24 Nov 2024 15:49:55 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> 'Tgetattr' 9p request and its 'Rgetattr' response types are already used
> by test client, however this response type is yet missing in function
> rmessage_name(), so add it.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/libqos/virtio-9p-client.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
> index c61632fcd3..98b77db51d 100644
> --- a/tests/qtest/libqos/virtio-9p-client.c
> +++ b/tests/qtest/libqos/virtio-9p-client.c
> @@ -235,6 +235,7 @@ static const char *rmessage_name(uint8_t id)
>          id == P9_RMKDIR ? "RMKDIR" :
>          id == P9_RLCREATE ? "RLCREATE" :
>          id == P9_RSYMLINK ? "RSYMLINK" :
> +        id == P9_RGETATTR ? "RGETATTR" :
>          id == P9_RLINK ? "RLINK" :
>          id == P9_RUNLINKAT ? "RUNLINKAT" :
>          id == P9_RFLUSH ? "RFLUSH" :



-- 
Greg


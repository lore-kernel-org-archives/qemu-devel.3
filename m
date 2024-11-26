Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA21CD6552D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxL-0007Bq-Rn; Tue, 26 Nov 2024 12:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFyxD-00075k-Oi
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:25 -0500
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tFyxB-0001xq-Kg
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:23 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.17.25])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4XyTQK5zlRz1XVN;
 Tue, 26 Nov 2024 17:02:17 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 18:02:17 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S0079c07db02-204e-46ce-ae7c-77ddec5ee49e,
 FCC27489C1BA5BDC89FB1F76958C936B1C45CC5D) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 26 Nov 2024 18:02:16 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 6/6] tests/9p: also check 'Tgetattr' in
 'use-after-unlink' test
Message-ID: <20241126180216.0638d10e@bahia>
In-Reply-To: <7017658155c517b9665b75333a97c79aa2d4f3df.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
 <7017658155c517b9665b75333a97c79aa2d4f3df.1732465720.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 787cb7a0-f735-425c-91f6-a3d2ec21ac26
X-Ovh-Tracer-Id: 18381723358036007389
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeekjedtveegkeeileffvdetvddvgedtudduiefghffhgfdvhfegjeetkeehfeeknecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdduudefpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheehvdgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=WyctVfbWJzr83NlvSlm6t2iwr/06Iy8jkXoLnLqLsa4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1732640538; v=1;
 b=KVuyfBRIzz97SVhWeiXH6A0iLMQP38Ss29mlggTStFSyI8M8YARbHk7qH1mUor4+7bVDIjSl
 HvvxNOi04Y/5IwKnr5XIOi7MYCMs74QYmmDgveqRjqM+TcDlF1ZyRsg6Zp+rmctzqflcqg4JHW6
 89Q1FZiUh05ZxYFs2Eht/YoGa8fsa43rJyBgb6/FitaPz5SLrjfdErduY1Tq90hCi7tSwVllgKA
 ScSyqLxPQQ6s5yC6Gop1/4qiBh6mLPALxs/roORynm0y+1imI8P72nkqF2ZY03ivboia65D8MFd
 aoyXMSYs7JN292zyj0/10kq2IzPNGsvTgWyNZPmiUVyQg==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=groug@kaod.org;
 helo=10.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sun, 24 Nov 2024 17:05:32 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This verifies expected behaviour of previous bug fix patch.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/virtio-9p-test.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index f6d7400a87..ab3a12c816 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -702,6 +702,7 @@ static void fs_use_after_unlink(void *obj, void *data,
>      g_autofree char *real_file = virtio_9p_test_path("09/doa_file");
>      g_autofree char *buf = g_malloc0(write_count);
>      struct stat st_file;
> +    struct v9fs_attr attr;
>      uint32_t fid_file;
>      uint32_t count;
>  
> @@ -725,6 +726,10 @@ static void fs_use_after_unlink(void *obj, void *data,
>      tunlinkat({ .client = v9p, .atPath = "09", .name = "doa_file" });
>  
>      /* file is removed, but we still have it open, so this should succeed */
> +    tgetattr({
> +        .client = v9p, .fid = fid_file, .request_mask = P9_GETATTR_BASIC,
> +        .rgetattr.attr = &attr
> +    });
>      count = twrite({
>          .client = v9p, .fid = fid_file, .offset = 0, .count = write_count,
>          .data = buf



-- 
Greg


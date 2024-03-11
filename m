Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A64C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjgvL-00042L-49; Mon, 11 Mar 2024 10:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjgvI-000416-Sm
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjgv7-0004BL-NC
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710168388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gntGZFjrEHIiHf8LL6fJ2sPS4CXW2PTFRnbVIV6xkA=;
 b=Aj7MMlJRvb3ADmxBYGZavmk7X9nZgMTqiQHoJuBBRx0chmHb5kB2q6mcq3yL7gR4Qp4OJK
 UuZpZpp5O0o05G9HthUeeBBsTyXG+YF5v/pJrpBr+OBcfXtH8Y6oCYCh/Pvbhd+kkyDJtk
 pe8bcxWhD0lq/Icaq+e1J8Mef0x/Y50=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-AtTlN8-NMc2WgqxCH8mgpA-1; Mon, 11 Mar 2024 10:46:21 -0400
X-MC-Unique: AtTlN8-NMc2WgqxCH8mgpA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42ed8fb8ce0so2718981cf.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 07:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710168381; x=1710773181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gntGZFjrEHIiHf8LL6fJ2sPS4CXW2PTFRnbVIV6xkA=;
 b=lVlGQsnQep2qBfFzcc2QSZhP+dlizn0bXINttPSAS2VYk++3iik7ECaczReuxorSiu
 L1LF9fnUNMdSqGDGb8dOLLQonn1VWai3QEiW5JV+l/ICa/m76lcO2K5Y1uQCwcNTk97w
 h4KjTlx9e4ddp+9uIctT3otbntIKLHze4nwJ+W3GvhCgUSKIc4SylcD1SVSvk7TXIJxQ
 2wCOfUen9kUztloh5WhfTiMr4eBFYfAJxTyctMVOKu+8WHi6iRWIXKEOaAj6Fr9Ui0Xj
 BKK3HGD/1gHDHOv1X32CfNxWbQEj703mLdi7SO3UEkShlWsFqyAPPMwcXY4NseD0/l5L
 kVEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXECwutMEu6YdM0HgbZAowflKHRdtmH9M4arx0PPjTC0E2LRBP69FaY6YSHTikQIjU7+0u55OooJp6qNMNfbgm9EClYzxg=
X-Gm-Message-State: AOJu0YxEPCmlQnCc0A67MbXb1IpvZyHQBR5Iaa08vaBpnH+KDVUB5NxO
 x6PBS3RMlITLWiPybCjum7GN8sYmpVZiJwlsRbuZ/yF7FfeJhMjW99uIeXsFroCx5/qT0RTg8Ru
 9MS5GewoK11g5JWsTg3mqCd3Zvc/G/x6rz1o47R8WdOITKw0/9Ttx
X-Received: by 2002:a05:622a:15d4:b0:42e:e05d:7ebd with SMTP id
 d20-20020a05622a15d400b0042ee05d7ebdmr9167562qty.3.1710168381265; 
 Mon, 11 Mar 2024 07:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkF4mjlIe7zCLYeRR36Dae81/ChRJOZnWGXtJn30qu0XgUbEsJmsMgfD/UZ0P7PLaxVMtrfw==
X-Received: by 2002:a05:622a:15d4:b0:42e:e05d:7ebd with SMTP id
 d20-20020a05622a15d400b0042ee05d7ebdmr9167546qty.3.1710168380864; 
 Mon, 11 Mar 2024 07:46:20 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 s9-20020ac85ec9000000b0042ef4b5f4fbsm2778809qtx.38.2024.03.11.07.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 07:46:20 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:46:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel <qemu-devel@nongnu.org>,
 Jinpu Wang <jinpu.wang@ionos.com>,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>
Subject: Re: Problem with migration/rdma
Message-ID: <Ze8ZOnWad7_otUX-@x1n>
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
 <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com>
 <Zek2UFoAyVrC7yh6@x1n>
 <CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com>
 <CAOQbQt0+UbfZNPrticjLD4X+S2KR4r+yWPATnhEhTRuxbwvGiQ@mail.gmail.com>
 <CAHEcVy78iCXVGmwr-2snpFwOyCxv3wxYrYJonK6nZF9UfbX_bw@mail.gmail.com>
 <CAHEcVy7kun92b8drEdDZndcWBBT7uvjOpHfqvVbqP0MqvJO01w@mail.gmail.com>
 <a5d4b5fb-e3fa-44c9-b7fb-37c3d1ab2bb3@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5d4b5fb-e3fa-44c9-b7fb-37c3d1ab2bb3@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 11, 2024 at 08:00:06PM +0530, Het Gala wrote:
> Let me send a proper patch to qemu devel mailing list and cc all the people
> involved.
> 
> I have reviewed and tested the change. Have tweaked the commit message
> accordingly.
> I hope that's okay with you Yu Zhang :)

Het - don't worry, I've had it in my queue.  Thanks,

=====
From 694451b89b21b3b67c404cbcfa2b84e3afae0c5d Mon Sep 17 00:00:00 2001
From: Yu Zhang <yu.zhang@ionos.com>
Date: Wed, 6 Mar 2024 09:06:54 +0100
Subject: [PATCH] migration/rdma: Fix a memory issue for migration

In commit 3fa9642ff7 change was made to convert the RDMA backend to
accept MigrateAddress struct. However, the assignment of "host" leads
to data corruption on the target host and the failure of migration.

    isock->host = rdma->host;

By allocating the memory explicitly for it with g_strdup_printf(), the
issue is fixed and the migration doesn't fail any more.

Fixes: 3fa9642ff7 ("migration: convert rdma backend to accept MigrateAddress")
Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/r/CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com
Signed-off-by: Yu Zhang <yu.zhang@ionos.com>
[peterx: use g_strdup() instead of g_strdup_printf(), per Zhijian]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index a355dcea89..855753c671 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3357,7 +3357,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         goto err_rdma_dest_wait;
     }
 
-    isock->host = rdma->host;
+    isock->host = g_strdup(rdma->host);
     isock->port = g_strdup_printf("%d", rdma->port);
 
     /*
-- 
2.44.0


-- 
Peter Xu



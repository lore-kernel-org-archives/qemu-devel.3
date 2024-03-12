Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE9AC54E6A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAeG-0006V3-Kb; Tue, 12 Mar 2024 18:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcY-0002vM-11
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcQ-0004dy-EU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvskLJuZlte5MbngUkjQAr+sRrlvuUkQnWRcVHGQVPU=;
 b=AzGHL/aYotVQvf8ighfu5dA/ctgH5TJQq58OJy15Y+6ALwUBVo4jdNwK2dQ2ZUEbHZLFjS
 R0ckPMtstiDQZVtdzTFluZ677cyAWzEpyRzCZRfevOD6mHcLd9gfxrMqfnKKRHqtreYN9o
 MDu2P3zvBHim0u7sX3ImbArtX7UX8EM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-2HO4ty4EOLCbl8J6ocvs3w-1; Tue, 12 Mar 2024 18:29:06 -0400
X-MC-Unique: 2HO4ty4EOLCbl8J6ocvs3w-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d2ecf61dd7so46311801fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282545; x=1710887345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvskLJuZlte5MbngUkjQAr+sRrlvuUkQnWRcVHGQVPU=;
 b=OxoEJ5+gfKKaI5ftaTJYSakzAiiwlPR6+8DMcdAygryghxHWtlxd7CjmKcQimyM6ET
 8KF04ifdxNuu8GK4Ea6U5zHwt+jpDRi3RYAMnF9QjuAZPeZr6zoKTAHvAGlIk1Ub3NA1
 83aaOgaTgzkUfMkfNGbexiRqx7drVtMjHnPfC35cOZ1AsgT8HJ5/iTT1RDLBCUGO3Mjl
 4o+qiJH/oDIu/rqVrIEhiawxIGnjo4o0Z1a/I+m0914/ixYtOcrUfVoxz9rQYUhDAhA8
 soWdTAcBIVeh/9EjWDrbDGvEdEimLUMQ6riWPJ+fCkULtrG6j3/hNZndZMMGFKLhi1vh
 R1cQ==
X-Gm-Message-State: AOJu0YxyfnSfxkp8Nhk0vYFUKINkplJtA8R3pvtuz/u61lg+i61P6hXQ
 N/XEENdZFLYn8DyOEytn44cBbckQTFP/kQs8qmW0mOtfls12VxV+JV1G3+Pgy76/4Xc5LNqIv4C
 VtDP9x15+OfuLrlmDuxCxD3UfF+oz5ZY1I0nNKb+1hKnKl0JaXlqSSd9E93dQt+kZxHHu9D+IEB
 Rr2ukj9lwQSvfa1WWeMyFJ+Pg/bMFWePGP
X-Received: by 2002:a05:6512:3188:b0:513:28b3:bd5d with SMTP id
 i8-20020a056512318800b0051328b3bd5dmr2803327lfe.54.1710282544864; 
 Tue, 12 Mar 2024 15:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK4BRn7zVVB48QoZ/7Q+Gso3634VHGiSN2BO+yMn2ZaShP9d57VPeNClenceHNgUtOnE+d6Q==
X-Received: by 2002:a05:6512:3188:b0:513:28b3:bd5d with SMTP id
 i8-20020a056512318800b0051328b3bd5dmr2803306lfe.54.1710282544327; 
 Tue, 12 Mar 2024 15:29:04 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 jo11-20020a170906f6cb00b00a46522c38c4sm201218ejb.207.2024.03.12.15.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:29:03 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:29:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 65/68] hmat acpi: Do not add Memory Proximity Domain
 Attributes Structure targetting non existent memory.
Message-ID: <2eb6672cfdaea7dacd8e9bb0523887f13b9f85ce.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If qemu is started with a proximity node containing CPUs alone,
it will provide one of these structures to say memory in this
node is directly connected to itself.

This description is arguably pointless even if there is memory
in the node.  If there is no memory present, and hence no SRAT
entry it breaks Linux HMAT passing and the table is rejected.

https://elixir.bootlin.com/linux/v6.7/source/drivers/acpi/numa/hmat.c#L444

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240307160326.31570-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/hmat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 2242981e18..8ea240878a 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -204,6 +204,13 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
     for (i = 0; i < numa_state->num_nodes; i++) {
+        /*
+         * Linux rejects whole HMAT table if a node with no memory
+         * has one of these structures listing it as a target.
+         */
+        if (!numa_state->nodes[i].node_mem) {
+            continue;
+        }
         flags = 0;
 
         if (numa_state->nodes[i].initiator < MAX_NODES) {
-- 
MST



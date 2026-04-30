Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F3ACCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOlM-0005b3-F2; Thu, 30 Apr 2026 06:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIOlK-0005XS-Us
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIOlI-0003nK-9j
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777545411;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9NpKpy1RFZXSbC6WpGj6qRqO3uGV/5aYuhgPXXiN/c=;
 b=c6YC0kqyQ3j0N2J/jEAgrmLD4mUYsF9GcHCnMKMXjVOv1AHqt0uBg3PYcLWeh58aIKJr4d
 nlgPbuiWJgjcxMabpkkRM+aJO+Pbflz3uoa3DzI6eOYLZ9UAPH19E4zRN0uJJSO7daIyPJ
 KWQdFO7cbF2yxlC1DwwHPPjaQWaPhlU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-acD8eVcROpqGeMZb8icAtw-1; Thu,
 30 Apr 2026 06:36:45 -0400
X-MC-Unique: acD8eVcROpqGeMZb8icAtw-1
X-Mimecast-MFC-AGG-ID: acD8eVcROpqGeMZb8icAtw_1777545404
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B145A195608F; Thu, 30 Apr 2026 10:36:43 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.62])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17476300019F; Thu, 30 Apr 2026 10:36:38 +0000 (UTC)
Date: Thu, 30 Apr 2026 11:36:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
Cc: Samuel Zhang <guoqing.zhang@amd.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 eblake@redhat.com, armbru@redhat.com, Emily.Deng@amd.com,
 Victor.Zhao@amd.com, PengJu.Zhou@amd.com, Qing.Ma@amd.com,
 Guoqing Zhang <simpzan@gmail.com>
Subject: Re: [PATCH v6] migration/rdma: add x-rdma-chunk-size parameter
Message-ID: <afMwszhgeMN8Mtl2@redhat.com>
References: <20260427031401.3895523-1-guoqing.zhang@amd.com>
 <ae8NhTr69D7Wzejz@redhat.com>
 <5481c478-1957-4a6a-9732-806b81100e1d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5481c478-1957-4a6a-9732-806b81100e1d@amd.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 30, 2026 at 05:46:43PM +0800, Zhang, GuoQing (Sam) wrote:
> 
> On 2026/4/27 15:17, Daniel P. Berrangé wrote:
> > [You don't often get email from berrange@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Mon, Apr 27, 2026 at 11:14:01AM +0800, Samuel Zhang wrote:
> > > The default 1MB RDMA chunk size causes slow live migration because
> > > each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
> > > 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
> > > 
> > > Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
> > > faster migration.
> > > Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
> > > 
> > > Performance with RDMA live migration of 8GB RAM VM:
> > > 
> > > | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
> > > |-----------------------|----------|-------------------|
> > > | 1M (default)          | 37.915   |  1,007            |
> > > | 32M                   | 17.880   |  2,260            |
> > > | 1024M                 |  4.368   | 17,529            |
> > What is the downside of setting a larger chunk size ?
> > 
> > IOW, why should we keep 1M as the default when it gives
> > such terrible relative performance ?  Why not make 1G
> > be the default instead of creating this flag and requiring
> > people to know about setting it ?
> > 
> Hi Daniel,
> 
> Thank you for the very good question.
> I dug into the git history. The 1M chunk size dates back to the original
> RDMA implementation by Michael R. Hines in 2013 (commit 2da776db48).
> I agree 1M is too conservative for modern hardware. However, I found that 1G
> is not necessarily the optimal chunk size either.
> 
> I collected the following performance data on my server:
> 
> NIC: Mellanox Technologies MT43244 BlueField-3 integrated ConnectX-7 network
> controller
> qemu version: v11.0.0-rc2-139-g25fcd86805
> qemu config: pin-all off (default setting)
> VM system RAM size: 8GB
> guest workload: `stress-ng --vm 4 --vm-bytes 1G --vm-method rand-set
> --timeout 0`
> ```
> chunk_size  total(ms) setup(ms)   down(ms)  Throughput(Mbps) total_size 
> transferred
> 1m            45,156       864      1,166         1,252.50  8.02 GiB   
>  6.46 GiB
> 2m            41,848       853      1,161         1,354.11  8.02 GiB   
>  6.46 GiB
> 4m            37,836       861      1,435         1,523.33  8.02 GiB   
>  6.56 GiB
> 8m            37,684       852      1,176         1,537.98  8.02 GiB   
>  6.59 GiB
> 16m           37,620       852      1,173         1,538.96  8.02 GiB   
>  6.59 GiB
> 32m           15,034       963      1,864         3,401.26  8.02 GiB   
>  5.57 GiB
> 64m            4,492       868      1,554        13,637.46  8.02 GiB   
>  5.75 GiB
> 128m           3,940       851      1,662        16,860.59  8.02 GiB   
>  6.06 GiB
> 256m           3,640       852      2,206        19,390.99  8.02 GiB   
>  6.29 GiB
> 512m           3,645       852      2,179        23,200.67  8.02 GiB   
>  7.54 GiB
> 1024m          3,665       865      2,238        24,676.59  8.02 GiB   
>  8.04 GiB
> ```
> 
> The downside of a larger chunk size:
> A larger chunk causes more data to be transferred per dirty region. For
> example, a single dirty page (4K) will cause a full 1G
> chunk to be transferred when chunk size is 1G. As a result, the total
> migration time may not be the shortest with the largest chunk
> size. See 256m row and 1024m row in the table as an example.
> 
> Based on my data, 128m appears to be the sweet spot for my hardware and
> workload, but different configurations may have different
> optimal values. I think increasing the default (e.g., to 64m or 128m) while
> keeping this parameter for user tuning would be a good
> approach.

Yep, that sounds reasonable.  Also I think it possibly justifies
adding this tunable without the 'x-' prefix.

With regards,
Daniel



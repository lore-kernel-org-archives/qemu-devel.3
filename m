Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994EDC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 15:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUT5q-0003sx-1f; Thu, 18 Jul 2024 11:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUT5N-0003r1-UV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUT5K-0001Cj-A9
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 11:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721316620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NUq3gMiXhEIDTFsyG9vU1HCksth0vtW1t12yWRL/cYM=;
 b=C5f7hatHlq+KVRFwaTH60LARblGTaS3jcBnu9bwGfgFPVmO50kHZ7aKMoPwwXNRiRj+MME
 +CvJv0nT6gopfz6WIoOFixUV/wRjc/6f6zz3GVV0zuGBfeKyW66Lmtr9qhjPqsYHvNpbdT
 teh5b+4YoR5Dv8NVJSm91/jtPdLH5+g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-oOChC6XxOoWnYgAAiYAVHg-1; Thu,
 18 Jul 2024 11:30:17 -0400
X-MC-Unique: oOChC6XxOoWnYgAAiYAVHg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEBF21954229; Thu, 18 Jul 2024 15:30:15 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.0])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6472B19560AA; Thu, 18 Jul 2024 15:30:13 +0000 (UTC)
Date: Thu, 18 Jul 2024 17:30:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 5/5] iotests: Add `vvfat` tests
Message-ID: <Zpk1AilffKAdSgGt@redhat.com>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
 <0aa2f5704890e20e3dcb4f33ce68a8fb7393e2f2.1718195956.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa2f5704890e20e3dcb4f33ce68a8fb7393e2f2.1718195956.git.amjadsharafi10@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 12.06.2024 um 14:43 hat Amjad Alsharafi geschrieben:
> Added several tests to verify the implementation of the vvfat driver.
> 
> We needed a way to interact with it, so created a basic `fat16.py` driver
> that handled writing correct sectors for us.
> 
> Added `vvfat` to the non-generic formats, as its not a normal image format.
> 
> Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>

> +    def truncate_file(
> +        self,
> +        entry: FatDirectoryEntry,
> +        new_size: int,
> +        allocate_non_continuous: bool = False,
> +    ):
> +        """
> +        Truncate the file at the given path to the new size.
> +        """
> +        if entry is None:
> +            return Exception("entry is None")
> +        if entry.attributes & 0x10 != 0:
> +            raise Exception(f"{entry.whole_name()} is a directory")
> +
> +        def clusters_from_size(size: int):
> +            return (
> +                size + self.boot_sector.cluster_bytes() - 1
> +            ) // self.boot_sector.cluster_bytes()
> +
> +        # First, allocate new FATs if we need to
> +        required_clusters = clusters_from_size(new_size)
> +        current_clusters = clusters_from_size(entry.size_bytes)
> +
> +        affected_clusters = set()
> +
> +        # Keep at least one cluster, easier to manage this way
> +        if required_clusters == 0:
> +            required_clusters = 1
> +        if current_clusters == 0:
> +            current_clusters = 1
> +
> +        if required_clusters > current_clusters:
> +            # Allocate new clusters
> +            cluster = entry.cluster
> +            to_add = required_clusters
> +            for _ in range(current_clusters - 1):
> +                to_add -= 1
> +                cluster = self.next_cluster(cluster)
> +            assert required_clusters > 0, "No new clusters to allocate"
> +            assert cluster is not None, "Cluster is None"
> +            assert (
> +                self.next_cluster(cluster) is None
> +            ), "Cluster is not the last cluster"
> +
> +            # Allocate new clusters
> +            for _ in range(to_add - 1):
> +                new_cluster = self.next_free_cluster()
> +                if allocate_non_continuous:
> +                    new_cluster = self.next_free_cluster_non_continuous()

The normal self.next_free_cluster() could be in an else branch. No
reason to search for a free cluster when you immediately overwrite it
anyway.

> +                self.write_fat_entry(cluster, new_cluster)
> +                self.write_fat_entry(new_cluster, 0xFFFF)
> +                cluster = new_cluster
> +
> +        elif required_clusters < current_clusters:
> +            # Truncate the file
> +            cluster = entry.cluster
> +            for _ in range(required_clusters - 1):
> +                cluster = self.next_cluster(cluster)
> +            assert cluster is not None, "Cluster is None"
> +
> +            next_cluster = self.next_cluster(cluster)
> +            # mark last as EOF
> +            self.write_fat_entry(cluster, 0xFFFF)
> +            # free the rest
> +            while next_cluster is not None:
> +                cluster = next_cluster
> +                next_cluster = self.next_cluster(next_cluster)
> +                self.write_fat_entry(cluster, 0)
> +
> +        self.flush_fats()
> +
> +        # verify number of clusters
> +        cluster = entry.cluster
> +        count = 0
> +        while cluster is not None:
> +            count += 1
> +            affected_clusters.add(cluster)
> +            cluster = self.next_cluster(cluster)
> +        assert (
> +            count == required_clusters
> +        ), f"Expected {required_clusters} clusters, got {count}"
> +
> +        # update the size
> +        entry.size_bytes = new_size
> +        self.update_direntry(entry)
> +
> +        # trigger every affected cluster
> +        for cluster in affected_clusters:
> +            first_sector = self.boot_sector.first_sector_of_cluster(cluster)
> +            first_sector_data = self.read_sectors(first_sector, 1)
> +            self.write_sectors(first_sector, first_sector_data)

Other than this, the patch looks good to me and we seem to test all the
cases that are fixed by the previous patches.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>

Kevin



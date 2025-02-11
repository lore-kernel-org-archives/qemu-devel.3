Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40FAC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 09:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thmoR-0004Ax-AV; Tue, 11 Feb 2025 04:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1thmoJ-0004AP-Bm
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:44:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1thmoB-0002tt-Nl
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 04:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739267035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lUIVWfwCgxYpe5SnNUogusMe6+DGls/H/8iwoLgmp2A=;
 b=V3GwgweQwNKTE/g5Qd8i3kH8HkXfdKToVENWxW9x58f9Ve0XaFnQtfppwO2gXwM5wq27Kj
 mvTkaGXVJ3eRExF5/8iyYJX0+bzbPwxZLJyWKc27HMxqaLC+8Y4ibAymLK1CkcphUCjCak
 EEVISHvu61gwoL2QJ2RstdheHEnFs8A=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-nOF_-rpqPoeWKIPFp8DX-A-1; Tue, 11 Feb 2025 04:43:52 -0500
X-MC-Unique: nOF_-rpqPoeWKIPFp8DX-A-1
X-Mimecast-MFC-AGG-ID: nOF_-rpqPoeWKIPFp8DX-A
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e5b48736dcfso5583455276.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 01:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739267032; x=1739871832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lUIVWfwCgxYpe5SnNUogusMe6+DGls/H/8iwoLgmp2A=;
 b=TxdjbQKJ4AOMvHaQfrEdfwtrYWuT0D3H2VLxak8SJFwDkhBKQ9PnNYYg4v8l+ZqrlJ
 7fY3SHSUfuKU5FUKm3knPJiCAkK48On0OsW/30kpa6Qd/RZqs6SwSqRlb6VgPTV5jHuo
 QdkizmG+0wXv0B9Sa2bDrc6LLaD34sEX8wueNeQDyUmFw98PRMTBJGMNGiId//l/Iiuf
 W89tcqZiiW7NeVTumUXMSM0DYzvAza8XWUa6VR97r51CQ5Ixx13XdTGcpZe6kzoLhb0F
 4tmb1J2bVK3uRUKj5bQNoxdz1h3KNpATjodRR5jYsyHRhfLxUYRkHhpqIet91l/IVijn
 TOMQ==
X-Gm-Message-State: AOJu0YwkQyrTilPlsPqA5hul+IMM0cFwXl2Kghzr7k+HGCyvNMarC/BJ
 E+dCmEbW0+nE4pMWjw75jDJUXN/JlP3YCX8a/OTIMq+8E+2pMuUtwIFhx+/u0HrKqId44Z7wVVw
 WDLRMHaZ1Q5KijsPiDlKGngwhT74J/a9yKOHY42kiT/z26iO+i6JFhNsa5O6MX4VPkbO8sLwq7T
 AT5OWw5O9Fc8LlAWYNoTGpMEOgiSw=
X-Gm-Gg: ASbGncumqRKcr7AsG6uyMXlbK7EJQiiqNQoLpekMKidas7Qr+T3NAjxT9O0VPrZsONf
 v/ZP4hNyWy5AOevJ/roLWYgBJ11b2tG0ux+CiDkFaYfzQ0mPDrQMAne27YgX+
X-Received: by 2002:a05:6902:2510:b0:e5b:3af0:d4a1 with SMTP id
 3f1490d57ef6-e5b46292777mr13911540276.40.1739267032258; 
 Tue, 11 Feb 2025 01:43:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXkbeqXuDLJoCSNeGAkY6qVgfb5wtul3KoUA2AH50NfVjVqmq3LtgudKvjkRwY9p/kUiRlhwzwYsARPvns3Fo=
X-Received: by 2002:a05:6902:2510:b0:e5b:3af0:d4a1 with SMTP id
 3f1490d57ef6-e5b46292777mr13911526276.40.1739267031900; Tue, 11 Feb 2025
 01:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20250205145813.394915-1-jonah.palmer@oracle.com>
 <20250205145813.394915-5-jonah.palmer@oracle.com>
In-Reply-To: <20250205145813.394915-5-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 11 Feb 2025 10:43:15 +0100
X-Gm-Features: AWEUYZky5nccyiLv-Wc7lKiQK3vm6SQma9FJD5FF7dO_6qu9QFd2kkgQk8k3ij8
Message-ID: <CAJaqyWc1FFS76CFknaxjcWbECzUNopNxUY7SVkufVR=nHBvkfg@mail.gmail.com>
Subject: Re: [PATCH 4/4] vhost-iova-tree: Update documentation
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com, 
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 5, 2025 at 3:58=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  hw/virtio/vhost-iova-tree.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
> index 9d2d6a7af2..fa4147b773 100644
> --- a/hw/virtio/vhost-iova-tree.c
> +++ b/hw/virtio/vhost-iova-tree.c
> @@ -37,9 +37,9 @@ struct VhostIOVATree {
>  };
>
>  /**
> - * Create a new IOVA tree
> + * Create a new VhostIOVATree
>   *
> - * Returns the new IOVA tree
> + * Returns the new VhostIOVATree.
>   */
>  VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>  {
> @@ -56,7 +56,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, h=
waddr iova_last)
>  }
>
>  /**
> - * Delete an iova tree
> + * Delete a VhostIOVATree
>   */
>  void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>  {
> @@ -69,10 +69,10 @@ void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>  /**
>   * Find the IOVA address stored from a memory address
>   *
> - * @tree: The iova tree
> + * @tree: The VhostIOVATree
>   * @map: The map with the memory address
>   *
> - * Return the stored mapping, or NULL if not found.
> + * Returns the stored IOVA->HVA mapping, or NULL if not found.
>   */
>  const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
>                                          const DMAMap *map)
> @@ -81,10 +81,10 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIO=
VATree *tree,
>  }
>
>  /**
> - * Allocate a new mapping
> + * Allocate a new IOVA range and add the mapping to the IOVA->HVA tree
>   *
> - * @tree: The iova tree
> - * @map: The iova map
> + * @tree: The VhostIOVATree
> + * @map: The IOVA mapping
>   * @taddr: The translated address (HVA)
>   *
>   * Returns:
> @@ -92,7 +92,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVA=
Tree *tree,
>   * - IOVA_ERR_INVALID if the map does not make sense (like size overflow=
)
>   * - IOVA_ERR_NOMEM if tree cannot allocate more space.
>   *
> - * It returns assignated iova in map->iova if return value is VHOST_DMA_=
MAP_OK.
> + * It returns an assigned IOVA in map->iova if the return value is IOVA_=
OK.
>   */
>  int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map, hwaddr t=
addr)
>  {
> @@ -117,9 +117,9 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DM=
AMap *map, hwaddr taddr)
>  }
>
>  /**
> - * Remove existing mappings from iova tree
> + * Remove existing mappings from the IOVA-only and IOVA->HVA trees
>   *
> - * @iova_tree: The vhost iova tree
> + * @iova_tree: The VhostIOVATree
>   * @map: The map to remove
>   */
>  void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
> --
> 2.43.5
>



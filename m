Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D09C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiysX-00040x-7f; Fri, 14 Feb 2025 11:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiysV-00040h-Hv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:49:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiysU-0004yO-1f
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739551761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lP62UzwsOEehw0OUMf7oKY2kIRtLSJvyU2NsQ2A6NwM=;
 b=AlPbwyFFVZra/cMtgltShCDjRU3pvBPpT98F1vqN2hs8x8WiPfvFuDFkh/pvRR2r9clZ48
 vgXWFRrOPydQ1se5LZaWSvUFF3mI5KFhPD82f6xYJ0YMjg9vDtn6BBjJ9paBK9zSffuqr5
 SJrb/DuY1qM9GA14L/MZiYAKfTrqMW0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-hDkyIXSlOgmSZaethHkHWw-1; Fri, 14 Feb 2025 11:49:19 -0500
X-MC-Unique: hDkyIXSlOgmSZaethHkHWw-1
X-Mimecast-MFC-AGG-ID: hDkyIXSlOgmSZaethHkHWw_1739551758
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c07249127bso394948985a.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 08:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739551758; x=1740156558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lP62UzwsOEehw0OUMf7oKY2kIRtLSJvyU2NsQ2A6NwM=;
 b=RusZ5ghpbxzTFRM9cfRqfCO/SZDpGiu9+6wnw82BG9eLFT6B74zY/J/+gLnZkoOwiN
 fv5ypFFy94ZBH1sWI5nkAhzfV58dl7RCyRrKbPmY/Zd7hAJB3NmmW7GSgJYkFLhAfMx7
 bf3ObtDJOMREB3Nui6o69ytS341rOFxFzY9Z0WfVnSSdIQi/o8ZvoBf6obH/l1MEVVaO
 cr4iHZDlU+DWwR4N5I4MkiIQ7CBaxWK8m8S7miGbOTORa2/vbwfBJna+diGmJll4c/0a
 ZsiseAAGpRfSjbfupIMGShPlLZe68Uxzgu72NaCfkFSlwA2Ub1ddoL5lAwlvdn9eowO2
 e+iQ==
X-Gm-Message-State: AOJu0Yz2MYecW1H7Sb0v+iOJrRd/z8u9M+HvhGx6chpkQsXUsh9MJ21S
 siUK7IhyDhGxphMUT8GYD3deBwZsFHRrWIz1lPDBrFEaGUkioZeKOTQfioWXxqklV4TZcUJzCOR
 Az/WIvr1UGGS4VgVoueSWxunCRlLe9fesN4JtTHLbBHb0BsELrFVk
X-Gm-Gg: ASbGncsTK/akx9ufbCJrVN/hhK4YYfNS5GQTPdBC4SCgSr5inIXBrjmnbvvGz6Nqwvo
 FbBhITLdlJ4pbgZfS5L7gvt78YCfjFlC0AoxQrrjt+BNvxYG2etsMIvltepLHsxfhb9wZV8lhJi
 a1Zc9+uLjNLWa194WYr9tIqcLViQK+xRrYAkKpIdNLcqKfgYsTAfrfR40YK9iYYFTHNkcnMJYiR
 RFgiQJkIDP+rP9l1JaegMhYUA+n4WgUbLK3+Gb3q/FLxmMXYp7hLiihtus=
X-Received: by 2002:a05:620a:1a9e:b0:7b6:7850:21d4 with SMTP id
 af79cd13be357-7c08aa9fcd7mr4618385a.52.1739551758394; 
 Fri, 14 Feb 2025 08:49:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+FbKVHqWc9SZ0jd56ooQ480DuI4pfomb3aQLTK9bZrkAeHgDYDDR3vD5XbOCrADjKyxHLkw==
X-Received: by 2002:a05:620a:1a9e:b0:7b6:7850:21d4 with SMTP id
 af79cd13be357-7c08aa9fcd7mr4616285a.52.1739551758174; 
 Fri, 14 Feb 2025 08:49:18 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c07c61748esm222279885a.60.2025.02.14.08.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 08:49:17 -0800 (PST)
Date: Fri, 14 Feb 2025 11:49:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2 32/45] physmem: qemu_ram_get_fd_offset
Message-ID: <Z690Clvqwoq50Dxl@x1.local>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-33-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1739542467-226739-33-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 14, 2025 at 06:14:14AM -0800, Steve Sistare wrote:
> Define qemu_ram_get_fd_offset, so CPR can map a memory region using
> IOMMU_IOAS_MAP_FILE in a subsequent patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



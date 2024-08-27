Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36748C54736
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 20:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj2bk-0001O6-8T; Tue, 27 Aug 2024 16:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj2bi-0001Mm-MM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 16:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj2bX-0007cL-Sn
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 16:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724789749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkTEnSk5gZsoaeIIhhfIjqpUQpx+Ss4nHPGthUsVQ2s=;
 b=fLzb12JQQxW74Pq9oj63QOQWALnKvkL5/9UPU8EpnFXP6HxpWxabEVuPD+aV5al68BUoBs
 dNGZBWAjq1ePNdRbBluLnJ1SttZmWXv2d6b/GfVqy2cIvMXxCHXWFxFOHyvVL8ddtPm9vI
 uzaJaV/sghk5nHHHY06SAejiQ1akuHw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Glbs2oRBPyyUl6gImKOd9w-1; Tue, 27 Aug 2024 16:15:47 -0400
X-MC-Unique: Glbs2oRBPyyUl6gImKOd9w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6c17f1a7011so37850936d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 13:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724789746; x=1725394546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkTEnSk5gZsoaeIIhhfIjqpUQpx+Ss4nHPGthUsVQ2s=;
 b=InkzKyED2qlnu3VkHc9OYMiTjAt9Jp64+iqBVHAgzBikzOfUM/gHSw9AugQr72g8zT
 DciKFJuxcpZfBXjcZIFRlDIzh/pHb5mcBoZ76cB6aSzEkoM6XRXzgnCCsI1OFJ9wwvO1
 dLZZ72JX+7in9GK8o4y+sNqcfvhQHLffYO4r3n6+YVjT52gotu7msR1SFmQTnSadqqk/
 +gzeOYNuxvO/1PK99fj6nDiDDB1hRxGKRGINkEqlesdtT/xL6HGsScSIT2HLIgju1afB
 DCQtkhR/1BbbUlizRJ2Hq/iDhI7IbdXgrSBCbDEQpApL8WvrFrLE1QWuh156xubLu8m5
 CsuQ==
X-Gm-Message-State: AOJu0YzNeZS8Yhnsw/TLOzv8ixrc0RZFaUuAQ06TFpZA7NMEw2AlXKGw
 ih21Ft1k09WVTqGnwb+OZRMS6DAGBKmubWFaJpIBTZx0ph21mxlgBauskyT3Qb91SkClfgTC/+P
 YNuEE/Ko7MrG6NCjcFXLtC+CaG0osJICQ7XbVX82o/A1G/j3HshVM
X-Received: by 2002:a05:6214:43c2:b0:6bf:888f:847 with SMTP id
 6a1803df08f44-6c32b9295b3mr33720896d6.56.1724789746587; 
 Tue, 27 Aug 2024 13:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8DZYWJvJrfdcJOorv+lq6yqV0CgJjtznYB7d4lBivv9t/a/sX/1JskI5MVpECD5nZlh4FXQ==
X-Received: by 2002:a05:6214:43c2:b0:6bf:888f:847 with SMTP id
 6a1803df08f44-6c32b9295b3mr33720516d6.56.1724789746130; 
 Tue, 27 Aug 2024 13:15:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dcddadsm59545846d6.121.2024.08.27.13.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 13:15:45 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:15:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, yu.zhang@ionos.com, mgalaxy@akamai.com,
 elmar.gerdes@ionos.com, zhengchuan@huawei.com, berrange@redhat.com,
 armbru@redhat.com, lizhijian@fujitsu.com, pbonzini@redhat.com,
 mst@redhat.com, xiexiangyou@huawei.com, linux-rdma@vger.kernel.org,
 lixiao91@huawei.com, jinpu.wang@ionos.com,
 Jialin Wang <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <Zs4z7tKWif6K4EbT@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> From: Jialin Wang <wangjialin23@huawei.com>
> 
> Hi,
> 
> This patch series attempts to refactor RDMA live migration by
> introducing a new QIOChannelRDMA class based on the rsocket API.
> 
> The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> that is a 1-1 match of the normal kernel 'sockets' API, which hides the
> detail of rdma protocol into rsocket and allows us to add support for
> some modern features like multifd more easily.
> 
> Here is the previous discussion on refactoring RDMA live migration using
> the rsocket API:
> 
> https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/
> 
> We have encountered some bugs when using rsocket and plan to submit them to
> the rdma-core community.
> 
> In addition, the use of rsocket makes our programming more convenient,
> but it must be noted that this method introduces multiple memory copies,
> which can be imagined that there will be a certain performance degradation,
> hoping that friends with RDMA network cards can help verify, thank you!
> 
> Jialin Wang (6):
>   migration: remove RDMA live migration temporarily
>   io: add QIOChannelRDMA class
>   io/channel-rdma: support working in coroutine
>   tests/unit: add test-io-channel-rdma.c
>   migration: introduce new RDMA live migration
>   migration/rdma: support multifd for RDMA migration

This series has been idle for a while; we still need to know how to move
forward.  I guess I lost the latest status quo..

Any update (from anyone..) on what stage are we in?

Thanks,

-- 
Peter Xu



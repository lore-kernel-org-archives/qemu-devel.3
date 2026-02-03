Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD46E87828
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnG5I-0003VX-Et; Tue, 03 Feb 2026 08:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnG5D-0003Ts-AW
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:04:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnG5B-0005We-Pr
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770123872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVMKLrJt0PoPcZex42j1vQ7nEYGLDZzudJtI+fOKH/4=;
 b=Z1O6lty8Q1fPWkHrMzwgMdILD5e+tuhFQ04gRrP6PWS6bqgWDPlUqIOruMM4KsXpbQzuIy
 BfhSxvXFPkCntQzSyIzCrKm9iusdWVicCBflUhSr9gFLZPkPJJzCLe2pfzdfT06ys94aBi
 hugnxl3Cw8YAnEYbxLMM5PL8wsK1URo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-81FPZR4ZOnWP20lsk1BVig-1; Tue, 03 Feb 2026 08:04:31 -0500
X-MC-Unique: 81FPZR4ZOnWP20lsk1BVig-1
X-Mimecast-MFC-AGG-ID: 81FPZR4ZOnWP20lsk1BVig_1770123870
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso89556545e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 05:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770123869; x=1770728669; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cVMKLrJt0PoPcZex42j1vQ7nEYGLDZzudJtI+fOKH/4=;
 b=BaaIcy77WQ3bxgTsDM0O1YMLOP+1MCd8DpmFU0ktOWPG51fRGedYC4pzKw2+ws1Rq/
 lGNfxTD7xYlTP3sffhQWFjVyzgYevH88nioZ9eHTulK10YpO6U1HpwN09MsB3ZSTC1C2
 E9ehLQwDGPBqFL9y+enUC08r4s5QEWSbCyQk5pCeukJnQocBoj2TNGfzTJoumUPbe4Yj
 Pddl5ljn9ES6eS/GV+HJK2ZP8/aBVx0yDJRYR+Ua97Eh8ZKBFmvH96ooa242RFt0dcZP
 RuoviIsdPoOxSJjJWe+XXoRLeLPtf4IJXZyyvJKu8AjXkfdptcaqKpwDK49uepMEuirb
 Iziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770123869; x=1770728669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cVMKLrJt0PoPcZex42j1vQ7nEYGLDZzudJtI+fOKH/4=;
 b=cFviNuTlS/4YVR42gVO/AZxefnwKtb1mwpFjeQWHHBp5uuE3UBch4o18bSxFwxWsLQ
 bTRbjvBPjiy+7iHf2tJjmh3o2dIRt8F9OFaNQRp0Be2pYrwEfAXm19mq76njVQcuYBsN
 y2YQecrBTolgy2Ou75803BXY8s7f2Yh2Tsi+5Fq8jrWnBFnVTNvrNoInTMG6khWxOu/S
 Vo85cfpDZRYw5oAFfvkJJhTtSKkyi4alvDOT5IwcWPFvi1USZZlu7a3Ws8twx9lrjCJI
 Ev3LOJnSqFvqEkQC102osRf6F750TNGm9XHxxyAKq9K3X65Mtx61vZTfYpvdE0UgL9Gp
 TMFg==
X-Gm-Message-State: AOJu0YwESRQNKfOEPqaaHY0/j3zyfJ7eoRBSN6t8+smxBqGUhf/yeOUJ
 mOrp33tdv1/34CE1rE0QGxSVlZn+x1reBqbgbGnnv8IEWOL/uqBxY2rLqDRhmnlyzHXD0PgZ96Q
 VdbX4ky9RtylfIMsBLFwpDJpFECKzZUq457xuVbbcKcpKgPK6PtZTJDnC
X-Gm-Gg: AZuq6aKjJWkaacs8NNOGjEakOrB2MdZ+5SgML2EY1G0MBhXF6NWNUuhFyJmW8sZCijc
 gpH1QqDfgr1XG9YJPsFcmmLBkR0fMjRy66/HHu4KmQBWHZEEoTXYiA8762X+Ii9H1fJsOwvR1O1
 mbfW77gYtNHQ+bYZzkKkmD3p1DuT2tre8mz+qW/3plw3cMJzK2+YxwkJE7uBVdowXPtu/KguLGJ
 ZMq63CesSf4jtq/ZMhdCnKIzlsjxxvwdriTjnDWm6eLvsy4h+82jpr+GgtzkuWquD6XGeP/JpSc
 6FmUM/xJEMIYtHtCqgLh3eNJNxBc66xwy9VrGrIv9lJ9v8TSzpYzcnpxixnV7cOrtl5db5wu1eV
 0Ncr3qNJT6mNUBRcpkt+Sd9C9f0n9xzzJDQ==
X-Received: by 2002:a05:600c:8b12:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-482db4956a2mr209923815e9.29.1770123869530; 
 Tue, 03 Feb 2026 05:04:29 -0800 (PST)
X-Received: by 2002:a05:600c:8b12:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-482db4956a2mr209923365e9.29.1770123869006; 
 Tue, 03 Feb 2026 05:04:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830512ddd0sm63338855e9.9.2026.02.03.05.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 05:04:28 -0800 (PST)
Date: Tue, 3 Feb 2026 08:04:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Zhaoxin <lizhaoxin04@baidu.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Gao Shiyuan <gaoshiyuan@baidu.com>
Subject: Re: [PATCH] vhost: Do not actively send a config interrupt
Message-ID: <20260203080139-mutt-send-email-mst@kernel.org>
References: <19ac5fa24777515f9f0878e6874dc9f6edec45a3.1758552835.git.lizhaoxin04@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ac5fa24777515f9f0878e6874dc9f6edec45a3.1758552835.git.lizhaoxin04@baidu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 22, 2025 at 11:19:32PM +0800, Li Zhaoxin wrote:
> From: lizhaoxin <lizhaoxin04@baidu.com>
> 
> After the VM is suspended/resumed or live-migrated,
> we do not want the guest to output information such as
> the capacity of the block device, as this is noticeable to the tenant.
> Also, there is no need to immediately send a config notifier
> for the virtio device after vhost_dev_start.
> 
> Co-developed-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>

Just to close the circle and complete the picture for you here, the reason we do it
is because with vhost
source could have queued an interrupt and the state is
not migrated.

if you want to optimize this, you need to check on source and
migrate the extra state.



> ---
>  hw/virtio/vhost.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6557c58d12..1f8a495ef8 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1847,15 +1847,10 @@ static void vhost_stop_config_intr(struct vhost_dev *dev)
>  
>  static void vhost_start_config_intr(struct vhost_dev *dev)
>  {
> -    int r;
> -
>      assert(dev->vhost_ops);
>      int fd = event_notifier_get_fd(&dev->vdev->config_notifier);
>      if (dev->vhost_ops->vhost_set_config_call) {
> -        r = dev->vhost_ops->vhost_set_config_call(dev, fd);
> -        if (!r) {
> -            event_notifier_set(&dev->vdev->config_notifier);
> -        }
> +        dev->vhost_ops->vhost_set_config_call(dev, fd);
>      }
>  }
>  
> -- 
> 2.34.1



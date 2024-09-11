Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E71AEE4983
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJvW-0005Xb-RB; Wed, 11 Sep 2024 05:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soJvV-0005X5-Bx
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soJvT-0006wY-U7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726047972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KP3f3z91gW2KDz9jXqd0G810bp1NRLVL3dq4cehO0y4=;
 b=TGPUhLqgfbpwwevrtLnFVkZx7+XZEzF8ONqtoIM5RMfyYtR96C1l18bckdESXq0lnxzXRb
 T77JBPZxCV4+3jCkbnoEvhRje7RPE+2UQ+GZdJELQ45hcjdt6se72zDyVtevq3dydPInnG
 2NVGuYrRDPc74bdOLy6nPwrYPKsTC38=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-kxt9CeCUNWuqjmD8jEvDlg-1; Wed, 11 Sep 2024 05:46:11 -0400
X-MC-Unique: kxt9CeCUNWuqjmD8jEvDlg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5356cc7d148so5426741e87.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 02:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726047970; x=1726652770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KP3f3z91gW2KDz9jXqd0G810bp1NRLVL3dq4cehO0y4=;
 b=NqTDY/aRmvBZfNOT10b8SpS7fwN7oyNCfObaoEqJfDmugw1hx/YD/HDRAIH0JpkQqU
 6Jm55BPXMyDfac7O0gsbOjG1N6JInvCfFcM1GIPjaOYpWj2++4yyTWru8vXNc22BNFP5
 guOi/XnwxQkWUkPilG3uyb3QG1+VzchXsz2fHEhJChQbR18DVW3JsPRyfQ5lF+SAganG
 cHUMIKI0AZ9MN7Jlb5DypLvIbDwwksuPgSxmFO38aC498OtUDxgAalk+Oe0umjmk2IbW
 H/ki0FVuQeXBwOM7JUp+g2SdAcawoEUNDNeA50ixRH2mk6bqkQ+KZq7afXeL7wVRrWZj
 w6EQ==
X-Gm-Message-State: AOJu0YwgWXmjD1mSEM0Wr1EQl3PMwDewk1U8ZLXf+xatSKvuJkY0G4Rs
 1IbdqqE/N4YJNqKFz027aHLbniVw7XsIy53OOyazqErULE9q6TFxRCK2vzhNk7WgZ4AfsIo7XDd
 IR4cgdzZsbb8jP+ljQspXOl0eBFFi9PipnGzT+sP0RcSFqdTUQywF
X-Received: by 2002:a05:6512:2202:b0:535:6aa9:9868 with SMTP id
 2adb3069b0e04-536587aadbemr11035082e87.19.1726047970169; 
 Wed, 11 Sep 2024 02:46:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHhA1K7Hn8JTD8JJgeJCdlSLTOjxsbtFdV8z50hZ8o7GnG7Q+HZChl+a5hd2Hu0mHgnUNUnA==
X-Received: by 2002:a05:6512:2202:b0:535:6aa9:9868 with SMTP id
 2adb3069b0e04-536587aadbemr11035032e87.19.1726047968835; 
 Wed, 11 Sep 2024 02:46:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd467f5sm5210632a12.36.2024.09.11.02.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:46:08 -0700 (PDT)
Date: Wed, 11 Sep 2024 05:46:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jasowang@redhat.com,
 mcoqueli@redhat.com, peterx@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2 0/2] Postcopy migration and vhost-user errors
Message-ID: <20240911054259-mutt-send-email-mst@kernel.org>
References: <20240828100914.105728-1-ppandit@redhat.com>
 <20240910131008-mutt-send-email-mst@kernel.org>
 <CAE8KmOypfY1695Z5EgWeU2gCc=aF6qQESeiosgfkzZ7E6EEzqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOypfY1695Z5EgWeU2gCc=aF6qQESeiosgfkzZ7E6EEzqA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 11, 2024 at 12:44:59PM +0530, Prasad Pandit wrote:
> Hello Michael,
> 
> On Tue, 10 Sept 2024 at 22:40, Michael S. Tsirkin <mst@redhat.com> wrote:
> > So are we going to see a version with BQL?
> 
> ===
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cdf9af4a4b..96ac0ed93b 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2079,6 +2079,7 @@ static int vhost_user_postcopy_end(struct
> vhost_dev *dev, Error **errp)
> 
>      trace_vhost_user_postcopy_end_entry();
> 
> +    BQL_LOCK_GUARD();
>      ret = vhost_user_write(dev, &msg, NULL, 0);
>      if (ret < 0) {
>          error_setg(errp, "Failed to send postcopy_end to vhost");
> -- 
> 2.43.5
> ===
> 
> * We ran the test with the above BQL patch, but it did not help to fix
> race errors. I'm continuing to debug it, will update here soon.
> 
> Thank you.
> ---
>   - Prasad


Thanks! I have a suspicion there's a path where we wait for the
migration thread until BQL.

-- 
MST



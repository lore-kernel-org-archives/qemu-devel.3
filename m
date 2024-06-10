Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B58C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 16:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGi04-0003dX-DQ; Mon, 10 Jun 2024 12:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sGhzx-0003cf-KG
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sGhzw-0000RZ-0g
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718037355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=90CpXrcFOHQ2T3P1la+HMSUn9j93HTiSwrAvcliDO2A=;
 b=OmFFsP7zWGaVmfu8/dcqnVtuGTzukio4dQ2aI82hAkYylFg0OrhFsq6Mc/IRSDQzHMM2SV
 Ggob9PiV69xAQ/iRNYHTImUz6+8AWllpPemBN1iZCsBsH9/E/9hQ7JoQ0rex/UXw2lQbRo
 QAN23yiFQMIjOr+oPUFStpoMlZc13d0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-oQL1s3dyN1-upzuJzfgJ4A-1; Mon, 10 Jun 2024 12:35:52 -0400
X-MC-Unique: oQL1s3dyN1-upzuJzfgJ4A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-440aedca77cso332111cf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 09:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718037352; x=1718642152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90CpXrcFOHQ2T3P1la+HMSUn9j93HTiSwrAvcliDO2A=;
 b=KFAdfSGAdwZJ40FgUvqpseViJaujIxP1Qiodwg2raSFOmTZLYes2pb0UZmZk+FVKrj
 tJ0Be0uuOjCHKM2j2qOjwYz3jOtScSg5hblXk3IW4a7zK6Fxp52ic12oWG5FiEe0FdD2
 S7Sko16ENJlzGHccg6taWGthW/RCnLh399k8UasvnI+EbF9IN4cX042fWvl8g+AdftJc
 +Mn/XfGASiyODYOw3o3HjQ4MwptUBVNy3j4JXIMmmPlFv1oeauWznB6kbG09buOg1pzK
 Yi1d0j8FsWAW80mYa6bGXvFH+eFvOmDKeJTH4GQc/j9qVCLWYYd83aPhnk26m4o9hC+R
 hO/g==
X-Gm-Message-State: AOJu0Yy1BZeaxKkSF4QRKFnUXPBZWtxPhFBxb6MOT3IqQcTfZh7r1sbX
 ATIY9ZuS+/8FWD597ACfd6naeWasLTTAocM3i+EtTQczb0khbDFIMXHeqXqS1chWfOxIpRH0zPm
 VK4Kpl6P9MXhuRzySQ3hsZLntZA/9JV2aqNpjJftVBr0/+dLT5TIs
X-Received: by 2002:a05:622a:188c:b0:440:61ce:2bf4 with SMTP id
 d75a77b69052e-44061ce2cf7mr55313461cf.2.1718037352104; 
 Mon, 10 Jun 2024 09:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBNCinA8eWbXcP6zE75EpF5ME5ru6j0vfSllNpMsbSPtYzt/VcJ3ClLfL9Mx/KUTWync4Zdg==
X-Received: by 2002:a05:622a:188c:b0:440:61ce:2bf4 with SMTP id
 d75a77b69052e-44061ce2cf7mr55312841cf.2.1718037351277; 
 Mon, 10 Jun 2024 09:35:51 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44038a80209sm37683341cf.36.2024.06.10.09.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:35:50 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:35:48 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
 "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
 "elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Xiexiangyou <xiexiangyou@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 Wangjialin <wangjialin23@huawei.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <ZmcrZCe8juVOHzja@x1n>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zl9rw3Q9Z9A0iMYV@x1n>
 <de950e0e2cda4f8dacd15892a6328861@huawei.com>
 <ZmBzusHyxLYqMeQg@x1n>
 <2fa61f902c244211af7d1316b67fe0a1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fa61f902c244211af7d1316b67fe0a1@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 07, 2024 at 08:49:01AM +0000, Gonglei (Arei) wrote:
> Actually we tried this solution, but it didn't work. Pls see patch 3/6
> 
> Known limitations: 
>   For a blocking rsocket fd, if we use io_create_watch to wait for
>   POLLIN or POLLOUT events, since the rsocket fd is blocking, we
>   cannot determine when it is not ready to read/write as we can with
>   non-blocking fds. Therefore, when an event occurs, it will occurs
>   always, potentially leave the qemu hanging. So we need be cautious
>   to avoid hanging when using io_create_watch .

I'm not sure I fully get that part, though.  In:

https://lore.kernel.org/all/ZldY21xVExtiMddB@x1n/

I was thinking of iochannel implements its own poll with the _POLL flag, so
in that case it'll call qio_channel_poll() which should call rpoll()
directly. So I didn't expect using qio_channel_create_watch().  I thought
the context was gmainloop won't work with rsocket fds in general, but maybe
I missed something.

Thanks,

-- 
Peter Xu



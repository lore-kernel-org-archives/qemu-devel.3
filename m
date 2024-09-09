Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A82ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfoM-00067Q-Sw; Mon, 09 Sep 2024 10:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfoC-0005LV-UP
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfoB-0007JB-Ii
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725893762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jZIYevxV+tb1TR90gcBjUz9AFzt7m9SZOK+3LxVqnE=;
 b=KqmF/Tq1in/Np100iU8x6wPQ1A5bPAxCzK6neJLKAvflopdJcfR8YKqZ4TcPnrXEem9F7E
 ucwM0GtvOS9RLZbmS0lqZWkw878fqblnSIl8DZKxmIWukhFE1UBJmAJHSUbiKbAAFCBuvh
 QBN+8TfQPM8SttjY+6eY22E1SKLQEfM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-hkKrq716OtCpq1EHOHvpCQ-1; Mon, 09 Sep 2024 10:55:59 -0400
X-MC-Unique: hkKrq716OtCpq1EHOHvpCQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6bf6d3e210eso50610326d6.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725893759; x=1726498559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jZIYevxV+tb1TR90gcBjUz9AFzt7m9SZOK+3LxVqnE=;
 b=fLbgjidmub9lrkEPlEqmGO9B7B4gAHfjJbh0IwOCAjb8IS28rgjR6nO6GU/u7DbMz4
 tj3XkHp1Iqvf0ox/SmKf3qWn2JXa+tNVgUPrf0X8VIQ27ZxxyXCl2Z2kt16ig2YNVu6Z
 TA/pzLuK0hk0zRqAiF0kd2m2cCsKREo6VZGxQQZtqqw2iqTH2Yc9tnkT2hyAiXv2cAJc
 BG8NYHzYYmgSxoQiLP4lhOjIkpahK49IEuI/KlfkTXap51PWbN7Jg8IzWxXCF0ufrStz
 fxBClqsJnclCNzTc0a3ZCqOmmgwhCyrfJNtOEE4ZWgAa2NErAe/GkruCFESgVtEn9eIE
 Ke2g==
X-Gm-Message-State: AOJu0YxzKNNwChLj8+rWklHkpIgwHjIU4QHtq247ghxHwZYPSof9qAIB
 fOOJBh9Xa71AxjOqXquix7dGNGtljoybAf/2kzupP9R1j+bEOyuDXHvVux8X5K/2pj76i6ziyng
 /O1dKmg3kEo4VUGsV7oF3gcKMoILDLAGRuhW/+oAgtQrk3cioybjC
X-Received: by 2002:a05:6214:5887:b0:6c5:50ed:ac3d with SMTP id
 6a1803df08f44-6c550edac9cmr22613236d6.16.1725893758861; 
 Mon, 09 Sep 2024 07:55:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtipRWU2Kn192Lu3XNS1OHe1kg/dtqBrswmgcSM1XE91pRvMV6DL9g77PJhU18JP+XfC1V8A==
X-Received: by 2002:a05:6214:5887:b0:6c5:50ed:ac3d with SMTP id
 6a1803df08f44-6c550edac9cmr22612996d6.16.1725893758492; 
 Mon, 09 Sep 2024 07:55:58 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53477416esm21288646d6.107.2024.09.09.07.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:55:57 -0700 (PDT)
Date: Mon, 9 Sep 2024 10:55:52 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/1] system: improve migration debug
Message-ID: <Zt8MeHIUCdu3LqLE@x1n>
References: <20240905191941.310592-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905191941.310592-1-den@openvz.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Thu, Sep 05, 2024 at 09:19:41PM +0200, Denis V. Lunev wrote:
> Right now migration_throttle() tracepoint lacks very important
> important information, i.e. no one could easily say how much the guest
> is throttled. This makes difficult to debug guest quality of service
> during migration.
> 
> This patch adds one more tracepoint into cpu_throttle_set() which is
> actually doing this job.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Peter Xu <peterx@redhat.com>
> CC: Fabiano Rosas <farosas@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> ---
> Changes from v1:
> - adding tracepoint directly to cpu_throttle_set() as suggested by Peter

queued, thanks.

-- 
Peter Xu



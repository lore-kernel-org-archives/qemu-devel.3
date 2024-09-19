Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757BACE8D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 12:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srFov-0001VN-TA; Thu, 19 Sep 2024 07:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srFot-0001Uo-TP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 07:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srFor-0007tD-BA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 07:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726747170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jrovS4Ndt47lGshu+qkfuJIckI/qfyBGhKzrMttNLBE=;
 b=BwIMG+2XKWiawjldvNO/jwUDVLtqd0EkSJKJ7tPzqg5ewnv83B2VlkDRVm/auxrSloHpw3
 ll28gGXydcIUWx4ui88bXR1lbXqiakjRo18lVBqiyOpxlEjuXeIRJENzIZQxHYSdkkH8jt
 qg839COJmWtLHG22TiU+x2Joz8AhPBM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-bndR3oBjN7eFdj5Gd_pwrA-1; Thu, 19 Sep 2024 07:59:28 -0400
X-MC-Unique: bndR3oBjN7eFdj5Gd_pwrA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c353a05885so13107986d6.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 04:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726747168; x=1727351968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrovS4Ndt47lGshu+qkfuJIckI/qfyBGhKzrMttNLBE=;
 b=SmbOQhEO5mh/4vg5uyb8IU4zLgo/Y6dptS15CU8DCvikce71AfMiP74LrSywavSnBK
 +ozb+nLJIIzZicBWm9zpLnSM+1Sw5KCjxWlrMNdJcF5xfpbtCcM6qsGkg+6pgO+RYJLn
 B3yqrmMQ770/I3uIpH+uOpfFaX6QCs4IQZIL9cJG7noGSbs3834tMdD9hIvzq1ylvsoa
 3HqFdSj4TBAZs81vpLJKeTArX5XE75oK3PrQmoeXswqFoLC+7ncyUo6MF4mYvQTE2GXp
 xWYennMVa1D9cyJlKZmcjqKn80IoR5m8sAZyQkyHyWU4hhI8zmmmO98BShjEkr1Lwpwz
 vmrg==
X-Gm-Message-State: AOJu0Yy+7/E/tEDcKcCQ36vhC1UgtYEh0yZ9GpsQHTdDJvvrVy/xSaUO
 K5LO/M966/IE2LVf+LYXSER04OugTEa9MeSEQEXcfFGa1ABisVUr7S9tmXgLXI1BPMkX4Kj9Jlc
 UlblWQ//Yv5l7tKFVeK0p8iq8XAqJvb810xL5qAU5M350SodSyG/i
X-Received: by 2002:a05:6214:3c9c:b0:6c5:dc7:577c with SMTP id
 6a1803df08f44-6c57350b8f6mr409212416d6.2.1726747168058; 
 Thu, 19 Sep 2024 04:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+UysI3Z1bw0SHdTIeRDZe4dOfMXEkXbbd6u5W98iOIkg/cj+vHrM6KX54msQ6sIlWZFyygQ==
X-Received: by 2002:a05:6214:3c9c:b0:6c5:dc7:577c with SMTP id
 6a1803df08f44-6c57350b8f6mr409210136d6.2.1726747164492; 
 Thu, 19 Sep 2024 04:59:24 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e495e0csm6938376d6.74.2024.09.19.04.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 04:59:23 -0700 (PDT)
Date: Thu, 19 Sep 2024 07:59:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL v2 0/6] Migration 20240917 patches
Message-ID: <ZuwSGJODsyj_bA4P@x1n>
References: <20240918183151.6413-1-peterx@redhat.com>
 <CAFEAcA9MsybcOa9pGeU7EHuqvRqfBk4TSwYR_tkHF2Xbc19Yuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9MsybcOa9pGeU7EHuqvRqfBk4TSwYR_tkHF2Xbc19Yuw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 19, 2024 at 10:08:25AM +0100, Peter Maydell wrote:
> Thanks for looking at the issues with the migration tests.
> This run went through first time without my needing to retry any
> jobs, so fingers crossed that we have at least improved the reliability.
> (I have a feeling there's still something funny with the k8s runners,
> but that's not migration-test specific, it's just that test tends
> to be the longest running and so most likely to be affected.)

Kudos all go to Fabiano for debugging the hard problem.

And yes, please let either of us know if it fails again, we can either keep
looking, or still can disable it when necessary (if it takes long to debug).

Thanks,

-- 
Peter Xu



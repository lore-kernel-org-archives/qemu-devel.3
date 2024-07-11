Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F75C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 15:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRvyi-0002DT-5u; Thu, 11 Jul 2024 11:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRvyg-00024L-H6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRvya-00087d-Qj
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720712696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HZJgjwMs31OzHuKcbTEmd5JRedADpeQ0YkayAGnxpfM=;
 b=GSTSBXLnw07RnFRM2FPXOrEYTzsGKIJaQG533K7n1WjFRVRP8SDKNspWpRpxd8Z5B27C1w
 s4nIOgDrxrw4d5UpkF0RLppHujGola1z11NHCFPAV1qCMc4mmmjqe3PqjZXaKlSEIIsIte
 eDguToMRuF5knmff7m3YZQbjraqslAY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-WBOVAC5wNM612oMf9Jdd5w-1; Thu, 11 Jul 2024 11:44:54 -0400
X-MC-Unique: WBOVAC5wNM612oMf9Jdd5w-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-25e40fa42ddso301508fac.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 08:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720712694; x=1721317494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZJgjwMs31OzHuKcbTEmd5JRedADpeQ0YkayAGnxpfM=;
 b=HCRRbrDf8CG6b0MnOzJXqPf8QHjfAh9NgS+G0nHaoNmBjrEds4ezaZ/bJZi8KaYrh2
 8K4T9LczCclL0Gfqp9suds8l3ElXDOE+gD7hMZt+2pxRp41VDFpPuzbpdNga2ZoSYRfd
 6UN7XSuaTKBxlK6K11k6sa1Xd8JtHyLKytpoufbyxmwmfac9HuX6Xzm9B+f/GqI6b3dW
 nRZhIEEvAv+Ecqz7uppDhgopRcQq0ZJ/QYzrsRjxH5j4AQVDDrsem88UTP2VeSgr0Gfy
 37ssYhsNR0CQyPNX29hYZ1ueWH/rH4pGYbiiHM/l6DMQOURA1QzNUL1aNr+Pe/MR/c8q
 9Npg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWk1zgCoIPONYxjbz/qiLuKrAb7K5uQm/d+P6X/e4iGc5EbQVv1klbO9Ly7PBjBwTLmqYo9JR+wlDJ16o2jePxK+IUm78=
X-Gm-Message-State: AOJu0Yy7m3pfLB16LG7OVR4zgmeYtgymn8rK+77C+sMpiTHBd8TU3Wxn
 qV908ROuwm5vxmhJnCRrS4fWon7YDzXjQ6qtJ42imhe2MZG2RNlVbk5upGIO9bUXzyEIpZbhbhQ
 HAl4lnN8jbqdfolDCZNszEy37Tyf8UTliF3fWNlUzC3GoHpFKCSAg
X-Received: by 2002:a05:6870:b48b:b0:25e:dce:491b with SMTP id
 586e51a60fabf-2603a6b1846mr3088951fac.1.1720712694030; 
 Thu, 11 Jul 2024 08:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYCbsRIY2U2vIhZFH7GNGwdxOzbuvLzlf8Bi8C6ZJGHysnX6mt3ewHVohjaK8q7sgdov1Q6A==
X-Received: by 2002:a05:6870:b48b:b0:25e:dce:491b with SMTP id
 586e51a60fabf-2603a6b1846mr3088931fac.1.1720712693650; 
 Thu, 11 Jul 2024 08:44:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f1909ab81sm304702385a.99.2024.07.11.08.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 08:44:53 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:44:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v5 0/5] Implement QATzip compression method
Message-ID: <Zo_98z3zmbDM1H40@x1n>
References: <20240711025229.66260-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711025229.66260-1-yichen.wang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 10, 2024 at 07:52:24PM -0700, Yichen Wang wrote:
> v5:
> - Rebase changes on top of 59084feb256c617063e0dbe7e64821ae8852d7cf
> - Add documentations about migration with qatzip accerlation
> - Remove multifd-qatzip-sw-fallback option

I think Yuan provided quite a few meaningful comments, did you address all
of them?

You didn't reply in the previous version, and you didn't add anything in
the changelog.  I suggest you at least do one of them in the future so that
reviewers can understand what happen.

Thanks,

-- 
Peter Xu



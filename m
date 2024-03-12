Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88DFC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7k5-0001gf-5j; Tue, 12 Mar 2024 15:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk7k4-0001bK-1V
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk7k2-0000ma-Nr
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710271489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCi8zvQ7+92NEms2y9kI7J0uUoM7H4IO1SuqBJEi9vM=;
 b=QTQzIijpfs4YXFubW0+Od2RBuP45fLe3gv6pK0whneT8B8Id95zmVj5+aU294Sla537uxV
 zDr7uhknNrVwex1Wpl/XAebFG4JjXQY1LYUbLSPDYTPEVqaE4Mvgg8Mglt3be9eycEc7sn
 n1YsEyCzLQ1CuGTRs7DnXWN27A59Gps=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-zyUmr5R9NP6KfLnABDv09A-1; Tue, 12 Mar 2024 15:24:48 -0400
X-MC-Unique: zyUmr5R9NP6KfLnABDv09A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6818b8cb840so18452036d6.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 12:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710271488; x=1710876288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCi8zvQ7+92NEms2y9kI7J0uUoM7H4IO1SuqBJEi9vM=;
 b=nbNGtkRCujF4UTrU0zHOj1NQEMBkdGHuaAM2+ghYwKA66bhgWnrlAtr2iqWoQQwtDe
 LEBewy6VvU/L3Yxwvr5RgEtJa7YlMPVCjoanHyKF1ozAtr444W4mfZRMLJNcTzVLkx5A
 cUFJzgyHe390Rbv26eWDb//stnFiHNe02X4hSEx8cifd6/XB83vfMdS+GogHcX6h9OVe
 50BVVu8j3JZtWsLfP+ZughXds8a4bVklaANSNQeuCTyExHZpJbLtVNQjCSgPxNAezZNj
 KiTKJnCIt/EOsxeToqCMCy7isylhyJDj10k9L0dl0uS27hpZwg8CvIk7hFUn8j14nZL3
 soOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIPWWuizpXpXzB3ynYiJMdTBdJ3GehsUzkPuCqztAn2x7QgdwMKsU6w/jSJIDs1E1qZIlD2IuXfQNBdod2l9CUnfrfL8A=
X-Gm-Message-State: AOJu0Yz9Y9rbwhmdsPjxPkos8vKmuSnzK85+OUiIDG6nQx0Vwif7krMv
 NKPqZuuZF17ReDNYDL4/Q4Fnz5SOzsbGYa52zeJQLzSVwH+q8tefcYpUUC5IR2nNXtj2yotft02
 skFxicK+nBEPO1qA6dT83vz72pr/3aAIKkiHSibZdCQVGYkpYkDKa
X-Received: by 2002:ad4:5bec:0:b0:690:e47c:9bee with SMTP id
 k12-20020ad45bec000000b00690e47c9beemr3087018qvc.4.1710271488049; 
 Tue, 12 Mar 2024 12:24:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2l2DZPyVjX69Bp4i7FzbagzE+uvZeC0bN1PiWqsLtAb9YegmipOlmnda53EViAMpbjq1p6w==
X-Received: by 2002:ad4:5bec:0:b0:690:e47c:9bee with SMTP id
 k12-20020ad45bec000000b00690e47c9beemr3087002qvc.4.1710271487710; 
 Tue, 12 Mar 2024 12:24:47 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 el18-20020ad459d2000000b0069044802760sm3919138qvb.120.2024.03.12.12.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 12:24:47 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:24:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] system/physmem: Fix migration dirty bitmap coherency
 with TCG memory access
Message-ID: <ZfCr_Y4Xfhfy5KXQ@x1n>
References: <20240219061731.232570-1-npiggin@gmail.com>
 <0fef1275-836f-496a-8a96-3e46c09cb232@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fef1275-836f-496a-8a96-3e46c09cb232@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 12, 2024 at 06:38:13PM +0100, Thomas Huth wrote:
> 
>  Hi Peter, Paolo, David,
> 
> this patch fixes a problem with the kvm-unit-tests ... could we get it
> included in QEMU 9.0 ?

Yes I think so.  Apologies for a long delay, I queued it for the next rc
pull.

Thanks,

-- 
Peter Xu



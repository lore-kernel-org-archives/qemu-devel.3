Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12A3C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsEI-0005GM-2I; Fri, 02 Aug 2024 09:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZsEC-0004wc-RS
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZsEB-0002s5-6Z
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722604910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ygo9Zxm7XJbNXR2NlBRzxSVXU6sKWIafqoynLfwiPLQ=;
 b=ECAOK6Kh619n115jzs9p5tGkBfHxcoyoIFSi64o3wp4/tGO7SUu7xlT5Zp0QnTPmocqaAQ
 mSPzLFr6EQAzkj4OXhW0PoI84EiPoOtd/mNu0QFb6Ub+cUrslxN65T7xhN/13ce+DJztVa
 BG4yHb1iw7g0nsAOnWsdyvmj70bGO4E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-RLPPo_CvN1mM0uXVAQWRqg-1; Fri, 02 Aug 2024 09:21:47 -0400
X-MC-Unique: RLPPo_CvN1mM0uXVAQWRqg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4280a39ecebso16256315e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604906; x=1723209706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ygo9Zxm7XJbNXR2NlBRzxSVXU6sKWIafqoynLfwiPLQ=;
 b=XVN8EhKf1wHemJvP/ttYbL5R7EjeJf3d9jaq/wvN3NkgrzECrYG8CJ8auQYq+p6z7L
 0keau1dKChUGZIUa8tFcWIio73A/N2oJ+oBU5tK+maM+iZvqb39HcSMPZ5mbaVuH9IaH
 xvVAfnK7+oYSFAR8CBFbbTd2+HMddTJa2wVAQ/uWD0+zG+J4fx/8T+cWyE+sdTiPeTi+
 bqvDxSw0ZB/O1ew8+hoMDWo2XWVmI4IZEStEW5Rg5ddHVLpvshRnGmXocs06dHb1323I
 SzVeJVQiAUvkWmNO4jjldrV6A45vL4eMmWDfkBrwHXWXSZPgbsdyy5HbuAybsfgpAdAD
 tQvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7ZHzXtH61CFbQrjhuz4/ugZTtvqKTYCInAiSRZsx2UR5tlukP+flojDCmx+/9NAo2vLOBRGEgIoimqSN9ZH6HBUox0Io=
X-Gm-Message-State: AOJu0YxFiwn4/DV+mQ4wcIxtx/YM6JdemEDqV4dCj2kjBpz7dJo6H9yT
 Iy9dZIXkn97Qnpmlp/p5IBw2hrl6QWU/z17DfA787j4Kti9I188+Hr7ov3CTJyGPDpGUz24oRWu
 lm+5NBvGObnJSZ16sKMNZ4/y9WR7OE0ZBn6YXWC1+Q9H8y/Ah4iWI
X-Received: by 2002:a05:600c:190e:b0:426:6327:5a16 with SMTP id
 5b1f17b1804b1-428e69f6157mr23619905e9.18.1722604906099; 
 Fri, 02 Aug 2024 06:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4kSORYtIKW9c+e1lMe0GvV5AoqUFQSvZcmpg9k9il2WVmwzr+eghaGlxJN5rxMq57aCMaDg==
X-Received: by 2002:a05:600c:190e:b0:426:6327:5a16 with SMTP id
 5b1f17b1804b1-428e69f6157mr23619675e9.18.1722604905357; 
 Fri, 02 Aug 2024 06:21:45 -0700 (PDT)
Received: from redhat.com ([2.55.39.123]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b8ada7esm95736325e9.15.2024.08.02.06.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:21:43 -0700 (PDT)
Date: Fri, 2 Aug 2024 09:21:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240802091927-mutt-send-email-mst@kernel.org>
References: <ZqQLbGxEW3XT7qL-@x1n> <Zqe8C9AfaojKHM8A@redhat.com>
 <ZqfKrtQSSRVnEOGt@x1n> <ZqfQ0cGf8t2trEdl@redhat.com>
 <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 02, 2024 at 01:30:51PM +0900, Akihiko Odaki wrote:
> 4) is the second easiest to implement, but the design of 4) will depend on
> whether we will satisfy 2) or 3). In the email I cited earlier, I suggested
> an option -use-platform to specify the expectation on the platform. If it is
> ever to be implemented, that option can take a special value, "host" to tell
> QEMU that it can use any features it finds on the current host.

In practice, lots of people would benefit from ability to migrate
using host features (checking that hosts are compatibile,
as they often are).
If we are going to go to great lengths adding new interfaces,
I think that would be a really useful thing to address.




-- 
MST



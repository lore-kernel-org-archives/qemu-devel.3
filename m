Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52670C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfX4r-0005Dz-7E; Wed, 28 Feb 2024 22:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfX4o-0005CC-8M
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:27:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfX4m-0006ra-Ow
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 22:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709177235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HZ8cZzNdQmunsiV0Tq+yDlSMGPa2bF+l8lkDu5lqZU4=;
 b=AFsg0hNzNSIpoHtH656Ga72+ar9LKRAzcUY2DTmklZsSLbnifyZeh8Q82U2VjobWwniRdD
 vmrlN7l7ZZHa1MJLVNI9+6a9RfawczpJtG5fQeIukaS3mogp+zg+CnmBS5YzP5yUV7ClOP
 Oxszl7CuwUvcnGFDIxo27BSBtxmNu3A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-2O-TwDFzN963dVopcnHxOg-1; Wed, 28 Feb 2024 22:27:13 -0500
X-MC-Unique: 2O-TwDFzN963dVopcnHxOg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1dc2d4c7310so540615ad.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 19:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709177232; x=1709782032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZ8cZzNdQmunsiV0Tq+yDlSMGPa2bF+l8lkDu5lqZU4=;
 b=d5PXOZK3kUBMA/SIwV3ShJ4AqqOVjNIvMv/EfwrIC4EViv85DIgSlG+D5kF0TL50/J
 CB1yRI53FAm4VAHARBdzxAwbnY4bheX/xUYpVIcDO9GDGeilHLrOawpx0xN3UqYg8EjN
 L8jfw8+Hdae4RoQky6rM0iZ7Pp5ZG5Vf0epQdXYLagRgkDWSv20Uzlat+es/Sb8P33aD
 mFuZ7cN4iNl5ZV7gOMgAdUVIumH+kz1bnYFdIDvfLzJmf6qyd+B1lXEc8XttwPhGY1w7
 R5kRA0/AzLZ7dXInJHByEWY2p5Y0dFi7RBBh99B2SY0rM7+khcDoDwgQI8Yyco4aLAz5
 WnuA==
X-Gm-Message-State: AOJu0YyT4kZtwR7XfVbirQnzJtAIFEXwAxpV/RUSYXSamw4aZrMbIFi9
 8Pel1pQEI5cuj5S+VpXtZgjWS9bII9UJr10jTh8yL9NlHAneS42Bn+iOdxXcTXm6F/cJvNGO6IK
 3cQ5dsbDcYHSbFd7/MzYI7W1yTDlRz4zA11ivFBxSOPPXmIij2Aih
X-Received: by 2002:a17:902:ee0c:b0:1dc:96c9:a122 with SMTP id
 z12-20020a170902ee0c00b001dc96c9a122mr852013plb.5.1709177232759; 
 Wed, 28 Feb 2024 19:27:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVCPuFASsxl7U9GS0HBRFa16ym9hp0OtfX4GnlikLO0W2LQgTmVVpLG6XtWYm89mevDpKf9A==
X-Received: by 2002:a17:902:ee0c:b0:1dc:96c9:a122 with SMTP id
 z12-20020a170902ee0c00b001dc96c9a122mr852000plb.5.1709177232456; 
 Wed, 28 Feb 2024 19:27:12 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w7-20020a170902e88700b001dba739d15bsm211103plg.76.2024.02.28.19.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 19:27:12 -0800 (PST)
Date: Thu, 29 Feb 2024 11:27:03 +0800
From: Peter Xu <peterx@redhat.com>
To: "Bryan Zhang ." <bryan.zhang@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, marcandre.lureau@redhat.com,
 quintela@redhat.com, peter.maydell@linaro.org, hao.xiang@bytedance.com
Subject: Re: [External] Re: [PATCH 5/5] migration: Add integration test for
 'qatzip' compression method
Message-ID: <Zd_5h-j5-sW-owRs@x1n>
References: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
 <20231231205804.2366509-6-bryan.zhang@bytedance.com>
 <ZbdmJ3CnBft_g9qI@x1n>
 <CAF4wfVMzdCjwxYNYwQyYOJxeEcQP3yzRPLqyTaKFw1FVM-26qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF4wfVMzdCjwxYNYwQyYOJxeEcQP3yzRPLqyTaKFw1FVM-26qA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 06:55:37PM -0800, Bryan Zhang . wrote:
> We can enable software fallback in the live migration path, which will also
> enable using software to run the QATzip tests (and will conveniently allow
> us to remove the awkward `qzInit` check in the test code). It also might be
> a good idea since it would also avoid failure in case of, e.g., a transient
> hardware problem?
> 
> Performance: The software fallback seems prohibitively slow. QATzip
> fallback uses the built-in zlib implementation, but I ran a migration test
> that normally takes zlib about 150 seconds and the QATzip fallback took
> about 30 minutes before my SSH session disconnected :P

When preparing the qatzip documentataion file, please mention this.  This
is definitely not expected by myself, we should suggest mostly never use
qatzip compatible (software) mode unless the admin is sure to have the
hardware support.

It should then only be used in qtest to cover the qatzip paths only.

> 
> Also, a note: When enabling software fallback, QATzip and the QAT driver
> will both repeatedly print a complaint to the QEMU monitor when trying to
> compress without hardware. Is it bad form to introduce
> seemingly-unsuppressable prints from dependencies, or is this acceptable?

It is definitely bad to keep printing the same message, no matter from
where.

Why it repeatedly do so?  Do you know why the library cannot make it
print_once()?

-- 
Peter Xu



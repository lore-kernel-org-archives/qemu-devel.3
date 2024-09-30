Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F447CEB2C1
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svNIe-0000zP-5R; Mon, 30 Sep 2024 16:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svNIX-0000yM-Lh
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 16:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svNIT-0001mv-SV
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 16:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727729226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOAlxlFb55ImG89Mibpo8um+vIPHQdW5aMbuED7vrTM=;
 b=ABb2oINgmTJCaYRib+5yI09A0nQsUxYv3YKBPML14gNpQfMCFhPrL4t3LcQQHZEnRdT1Fl
 GCDwtbCpvRxFI95/oKc9Y08o1tK1xWXdnS/FlCzZsw+GPrW2rpR8JGvoU4bxbi10cRPLNX
 B989gmSh4gzN53AigX00xXP/LNLd6Hk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-7g3IJyTbNrmPwWCNyKhvoQ-1; Mon, 30 Sep 2024 16:47:05 -0400
X-MC-Unique: 7g3IJyTbNrmPwWCNyKhvoQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c513582b05so84150896d6.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 13:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727729225; x=1728334025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOAlxlFb55ImG89Mibpo8um+vIPHQdW5aMbuED7vrTM=;
 b=fy6WgfQO42qIgaQ4otamUakFnThWciIkScbxMDGgVyM78uZWVTXSWh/eespUmSTn9/
 YYgUPJt5HrfLbZfbiuyPxd6K5f1JJJNnX6DQmk1TVU1oBGvq3kKKGnSdbADH7iht9Rpw
 2Sz4QnizOaFhNtIn8RDuS4Z+EI9MTaPJ2weP+J7hInzvKykPbNgoSord267b1iRiWsME
 hNs8whKh3JKrJdGK9iNEMKtFlnE/JXOv3DZfN7dtBMJ9zb85wJ3Q7qWj2C2QvD6E1XoN
 acyW6XUVqquUSwffhBZVXTMTwegwn3rvIalfbJbOfIa/1PDa70+lSLkCxWUk+Iat84l9
 HCmg==
X-Gm-Message-State: AOJu0Yxs1aEVl+rwkX7IzOkY86hN/rG7LWI+Rc25fD/EFjRc7Gg483jQ
 0zEzwq3jHO82Y1TKV4K847EXlpubPxJjbXdF6Fexf162XlT12a+32oTDQPZ/5AexGuv1KRM8JU2
 9ewXYOVO+9K6f947pEJn4bnygUCMInCa5qPUJ2XgNriRg1b24QhQiBshB5OSs
X-Received: by 2002:a05:6214:5a08:b0:6cb:1006:e9de with SMTP id
 6a1803df08f44-6cb3b63f25bmr213725806d6.41.1727729224828; 
 Mon, 30 Sep 2024 13:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKErLfbpJPipxLj8daovVjEWWd/VOo3W4Crk7Z2d0xZbhj5HcvttNF+zERk+v9NPb3RSbT6Q==
X-Received: by 2002:a05:6214:5a08:b0:6cb:1006:e9de with SMTP id
 6a1803df08f44-6cb3b63f25bmr213725526d6.41.1727729224424; 
 Mon, 30 Sep 2024 13:47:04 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b62da07sm42480496d6.68.2024.09.30.13.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 13:47:03 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:47:01 -0400
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/3] migration: Support responsive CPU throttle
Message-ID: <ZvsORXZDZodSrzO-@x1n>
References: <cover.1727630000.git.yong.huang@smartx.com>
 <3a383e563cc57c77320af805c8b8ece4e68eebea.1727630000.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a383e563cc57c77320af805c8b8ece4e68eebea.1727630000.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Mon, Sep 30, 2024 at 01:14:28AM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> Currently, the convergence algorithm determines that the migration
> cannot converge according to the following principle:
> The dirty pages generated in current iteration exceed a specific
> percentage (throttle-trigger-threshold, 50 by default) of the number
> of transmissions. Let's refer to this criteria as the "dirty rate".
> If this criteria is met more than or equal to twice
> (dirty_rate_high_cnt >= 2), the throttle percentage increased.
> 
> In most cases, above implementation is appropriate. However, for a
> VM with high memory overload, each iteration is time-consuming.
> The VM's computing performance may be throttled at a high percentage
> and last for a long time due to the repeated confirmation behavior.
> Which may be intolerable for some computationally sensitive software
> in the VM.
> 
> As the comment mentioned in the migration_trigger_throttle function,
> in order to avoid erroneous detection, the original algorithm confirms
> the criteria repeatedly. Put differently, the criteria does not need
> to be validated again once the detection is more reliable.
> 
> In the refinement, in order to make the detection more accurate, we
> introduce another criteria, called the "dirty ratio" to determine
> the migration convergence. The "dirty ratio" is the ratio of
> bytes_xfer_period and bytes_dirty_period. When the algorithm
> repeatedly detects that the "dirty ratio" of current sync is lower
> than the previous, the algorithm determines that the migration cannot
> converge. For the "dirty rate" and "dirty ratio", if one of the two
> criteria is met, the penalty percentage would be increased. This
> makes CPU throttle more responsively and therefor saves the time of
> the entire iteration and therefore reduces the time of VM performance
> degradation.
> 
> In conclusion, this refinement significantly reduces the processing
> time required for the throttle percentage step to its maximum while
> the VM is under a high memory load.

I'm a bit lost on why this patch 2-3 is still needed if patch 1 works.
Wouldn't that greatly increase the chance of throttle code being inovked
already?  Why we still need this?

Thanks,

-- 
Peter Xu



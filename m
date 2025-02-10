Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575FDC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thXKd-0000CR-8m; Mon, 10 Feb 2025 12:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thXKc-0000C0-6o
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thXKa-0005CH-Ki
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 12:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739207543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FoDyK+sAgsFaOYhAkjabFpVpKgy0DbDw2pCi/kNWifE=;
 b=iRlObmXIKmxL9gj+kUXDorcV4ITMhJ9VWRPgLWnw7zNhI00quqzqg6uNzzwfrz61yu4OYU
 B4raZ5ixLcmz9QmiC7OhYcwmJQmY2H16d4EPXDdjuyRoy5DMt+ntf5EVGmYx6wnS5ZOL/o
 aH6hcaGnUt0U+CJrnjC0a55ZgwlWuQY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-hIm9xcRCO1aBaYHMq72xqw-1; Mon, 10 Feb 2025 12:12:21 -0500
X-MC-Unique: hIm9xcRCO1aBaYHMq72xqw-1
X-Mimecast-MFC-AGG-ID: hIm9xcRCO1aBaYHMq72xqw
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3f3a66c4f26so2185298b6e.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 09:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739207541; x=1739812341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoDyK+sAgsFaOYhAkjabFpVpKgy0DbDw2pCi/kNWifE=;
 b=UMGRXDjaPTsx3ZG58pIFtGGjTjxdUOMQou8Dxhm0pXzLlL0uTDgy8SyVX0lCD0H88a
 GI8WeV/dXdAHUAp9DbKin0XiQoJoz6/UjDAlsk2KE+QX4zbEyAw97SJ/N7HQrEymJKxB
 YqaVhxsSMGZlciFBtGtG692FKwlA7b0VOeyKprsawqu6EmlEeWNlKSBU6i/VkpzWLCP7
 mPSX+3/iquqq1uC6EqzBF8cn69nIIIF1BUR5SJbAGjr1Ia6Wv8WXqDmsN/UWJcK2MlTH
 5U/lOU82CyF4QZyjaVCZ31Nh1vFaOEWcGl71qSjRQkET9mBBlBoPLvKOCTkjYMOFrwz7
 Pccg==
X-Gm-Message-State: AOJu0YysEOth5G3XG5CxUiKRZpbj8PgJu6xnfD4XW0YK/akhzJbq48hH
 4LHCd15/NMBDR4EOSgSavmcK6kOzxzpQGOW+uippaUxt40089UMlroVNp7wRrrh3JY/bBZglYSp
 WtZUC9WLMPPLBirUilaSg16FMUDA0LiSrBod/BnbC8sgdAO4IWjh6
X-Gm-Gg: ASbGncv7FlxWlhI9ay3DG6cTAvqqLk0P/Xg0eYybQbfufOt4RXtSoUhCsPQ1FwjhnJP
 3kWbHZPJCG4Cs6u1nR9xufZHRtR7h3oj9ImEQcVrQDVaqQavQPB1IePsSftpOSiiYs92mLUHO+j
 2b36iSXyDgJXAGH2yiMbIC62nidZqVx1iUWGYCWd18vIfzN58u+lgTZMHrt9PXXEYGVtclAvnZ2
 e/lGpVcK3BpZXe/MPgnyklUVd8ZPQOkKH2jOm2boKp2IrztFRN5aAuN7XU=
X-Received: by 2002:a05:6808:1687:b0:3ea:f791:3caf with SMTP id
 5614622812f47-3f39225dd54mr10046122b6e.17.1739207540720; 
 Mon, 10 Feb 2025 09:12:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1u+q5Jh54T4/CqsT3voJ9FCldWKUKxieJHATaVWvQSD7tIHUMwfv0vtc2+K9+in7M94gZ9Q==
X-Received: by 2002:a05:6808:1687:b0:3ea:f791:3caf with SMTP id
 5614622812f47-3f39225dd54mr10046103b6e.17.1739207540390; 
 Mon, 10 Feb 2025 09:12:20 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f389d8a90dsm2336451b6e.0.2025.02.10.09.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 09:12:19 -0800 (PST)
Date: Mon, 10 Feb 2025 12:12:16 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH v3 8/8] migration: Check migration error after loadvm
Message-ID: <Z6ozcMJu05KR-Hov@x1.local>
References: <20250207195359.17443-1-farosas@suse.de>
 <20250207195359.17443-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250207195359.17443-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Feb 07, 2025 at 04:53:59PM -0300, Fabiano Rosas wrote:
> We're currently only checking the QEMUFile error after
> qemu_loadvm_state(). This was causing a TLS termination error from
> multifd recv threads to be ignored.
> 
> Start checking the migration error as well to avoid missing further
> errors.
> 
> Regarding compatibility concerning the TLS termination error that was
> being ignored, for QEMUs <= 9.2 - if the old QEMU is being used as
> migration source - the recently added migration property
> multifd-tls-clean-termination needs to be set to OFF in the
> *destination* machine.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



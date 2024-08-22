Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EF2C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAI7-0001ln-99; Thu, 22 Aug 2024 12:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shAI5-0001lF-PX
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1shAHz-0004l3-MB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724342633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zRQRH/E1xoycDeAA2YOZt8EgpqvqabybRPLVl3D/QmU=;
 b=gW+O6vzj7rJV7R3h7fOifkF0qkva/N+J1EBrb7c/vK+g9MF0uKwive2qlgOaR5OPgOgZH9
 LfIV5QGoFrrqD3LosrrQ8a0KZQ+rHF7+94yltKmY8AZs58o0wBLC2RPN+ZCUfXYns2kBel
 YVsKpY7nW7ObAa99YReNeifRteMGDwc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-WWfnDKL3M9CUVNhd437s5g-1; Thu, 22 Aug 2024 12:03:52 -0400
X-MC-Unique: WWfnDKL3M9CUVNhd437s5g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a2028bae15so123503285a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724342631; x=1724947431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRQRH/E1xoycDeAA2YOZt8EgpqvqabybRPLVl3D/QmU=;
 b=Ob6zP9cu9f+biOkGplwmqnjxpKfbJ5QSeu5nhGmz9Tv3obosfCyZ41BUQJ7evu2x90
 3oBuor1UOqTuYhmBm9Jcsqi+Min6kGnWc5myRdazCDrEJqhQAiA4dJXt94folr8RZfZR
 Uz3ZOG3/hfV7OGnn8i2KYxEMWvySezxqaJKMz/J039hDg1C1pL2fs1AA/mz2N8k2n3Fk
 s8oBsIUJ9gjodeCJp1n9Qf7Br80dsemN3CKIAjVNaYur0qegx3M5TCg3V8OPISErlDPM
 jlaVGgeMvM7vj9lFxTxBGKEWLlIIqideOKoTwkGzaJosBR1c2w78B48IQ/M7urMwNTy6
 7tTA==
X-Gm-Message-State: AOJu0YyGddgUK6bl6u8nN2IUIie3SvNFu/ofHE1+cVeEz0U5jVlGqzeL
 zHWMno0o3oabjnxGDNySoIqH/u7wE1StR5NxS5YlUFhIBZzJJ/fwU+U8WqXPbNzheyzon+QQW4Z
 EsvC6JxMx5ThD4d6Dj47qnVrd2n8cCGdy8ToRmoOZI6UR7cMjwrge
X-Received: by 2002:a05:620a:1a8a:b0:7a2:a50:53cd with SMTP id
 af79cd13be357-7a6748cdd6cmr834857885a.14.1724342631567; 
 Thu, 22 Aug 2024 09:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrWnhN62uTSpmtQKrfP6l7shUaH5JMOX0UbR+VdQ4YVf1cccXLcWJ7rmuXrYY4H4Wa1TudLg==
X-Received: by 2002:a05:620a:1a8a:b0:7a2:a50:53cd with SMTP id
 af79cd13be357-7a6748cdd6cmr834852385a.14.1724342630962; 
 Thu, 22 Aug 2024 09:03:50 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3cf6c0sm83074885a.73.2024.08.22.09.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:03:49 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:03:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 12/14] migration/multifd: Allow multifd sync without
 flush
Message-ID: <ZsdhY2ijx9nhSdLz@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801123516.4498-13-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Aug 01, 2024 at 09:35:14AM -0300, Fabiano Rosas wrote:
> Separate the multifd sync from flushing the client data to the
> channels. These two operations are closely related but not strictly
> necessary to be executed together.
> 
> The multifd sync is intrinsic to how multifd works. The multiple
> channels operate independently and may finish IO out of order in
> relation to each other. This applies also between the source and
> destination QEMU.
> 
> Flushing the data that is left in the client-owned data structures
> (e.g. MultiFDPages_t) prior to sync is usually the right thing to do,
> but that is particular to how the ram migration is implemented with
> several passes over dirty data.
> 
> Make these two routines separate, allowing future code to call the
> sync by itself if needed. This also allows the usage of
> multifd_ram_send to be isolated to ram code.

What's the usage of sync but not flush here?

-- 
Peter Xu



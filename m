Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4EBC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYqu1-0001fI-OQ; Fri, 17 Jan 2025 13:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tYqtz-0001f9-JJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tYqtx-0006yS-9u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737137819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m4CBx7BGRpkJ+EjWH/tO5vK5zoMwmn7fyCQJ7q5ILfM=;
 b=dPnu2tdVv/z0zy/W9Zdc3pm1XhlXUmsL7l3PkL0Kfh6B97X7JCwOTVV6r4pSABL6fWJraT
 olbBDZ6JmsYvkixiH7MMCvNEd5r70S9ifLdl1kkOJKRkvSHrs1JuMrpKYLLTJk8iGRT8r7
 sgn/MuuEJr9IIn9ire122c/B335rWpc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-dY0sciXQNAGbcnwVov-1xQ-1; Fri, 17 Jan 2025 13:16:55 -0500
X-MC-Unique: dY0sciXQNAGbcnwVov-1xQ-1
X-Mimecast-MFC-AGG-ID: dY0sciXQNAGbcnwVov-1xQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d88c987fc7so41411896d6.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737137815; x=1737742615;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4CBx7BGRpkJ+EjWH/tO5vK5zoMwmn7fyCQJ7q5ILfM=;
 b=N1rBz/1tlodiDhoEjxYxXz9/qCNKe65ocu2KB4Eo4C3TzHe//9sshxCR2PPaNHJoKc
 m3xhNVvEC9aWe7OyMW9AhEk2tVx51hIbBHEuggGxplvNsIrO8M2ua63Mic9XnjGT6SGF
 0/TowXlwI4vw8Kfzukn53ZmlMTeQ6JYTJtbTZTRdWGAoGsN/sE6pSOxyN2pXDVxmzDZ7
 sdApm+zP2AhZbAM71Na46kVGbPD/G45Hp+6G8/0t8hYsW3KmHU4iTm0pFx/yk2qKmX9d
 mPAhLsmVMRZics2Ili1+9X0PH1+eQk02V6ZG5BspN4it+b+7NBot4otnA3idpcVOG20A
 C+Ow==
X-Gm-Message-State: AOJu0YyqpRBMXlItQMIrL8bNqccasuUjwY5oQiikd9mPPwwPLsmup+tl
 A9Wuahd0f1QbijePr9gt1vnDWZyliCPhwrO+WWoIQQGQ6ZCtp4siWcRBt9Kf1kGYxhfyzWo6rOF
 /42e0EGvsnPlAwdx1A1JibSswfL2Otm1MUUqiSfQT1Eq3zxFU/n1Q
X-Gm-Gg: ASbGnctUgfelrkWLzBE9g3VHrcEhBE9peRn5t5VgiOcJlDh1ba7KsCwV5qr5uO0RruS
 QYu6sjfbZdx9qlMNzUNr0QDwApmqQkXf2C+fkhnkdqDgmvVyuZtcnfD/ApNCW5QLcdlhfDGdTl3
 KfR79QCNsyuIiASYtwgZch/YVSFd/yqrmVS1vlf9G0FFKGtaLqiC/vFJZ0texYHN1/AKC9cqiA+
 +9Gyrj5+PSVVCPxr/aOGCqs6Ovov23HkeB9CASltt0N9OnZ49h8g3iCjGXAOQKDMBaERJ5Fy5cv
 Flm6qQmI5hlmYzQKsA==
X-Received: by 2002:a05:6214:d67:b0:6d3:b936:60d1 with SMTP id
 6a1803df08f44-6e1b222f30dmr56956316d6.33.1737137815151; 
 Fri, 17 Jan 2025 10:16:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx7f60r1SJpj4Fi+D4kMEZhBe8mK62s7c7tDXpwgLA+sxgqvxqQ4+BKuYq7EvgjVPj7FEeYA==
X-Received: by 2002:a05:6214:d67:b0:6d3:b936:60d1 with SMTP id
 6a1803df08f44-6e1b222f30dmr56956076d6.33.1737137814896; 
 Fri, 17 Jan 2025 10:16:54 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf35bcsm14182226d6.23.2025.01.17.10.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:16:54 -0800 (PST)
Date: Fri, 17 Jan 2025 13:16:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] migration: ram block cpr blockers
Message-ID: <Z4qelNxnBcgO87go@x1n>
References: <1737135971-132839-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1737135971-132839-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

On Fri, Jan 17, 2025 at 09:46:11AM -0800, Steve Sistare wrote:
> +/*
> + * Return true if ram contents would be lost during CPR.
> + * Return false for ram_device because it is remapped in new QEMU.  Do not
> + * exclude rom, even though it is readonly, because the rom file could change
> + * in new QEMU.  Return false for non-migratable blocks.  They are either
> + * re-created in new QEMU, or are handled specially, or are covered by a
> + * device-level CPR blocker.  Return false for an fd, because it is visible and
> + * can be remapped in new QEMU.
> + */
> +static bool ram_is_volatile(RAMBlock *rb)
> +{
> +    MemoryRegion *mr = rb->mr;
> +
> +    return mr &&
> +        memory_region_is_ram(mr) &&
> +        !memory_region_is_ram_device(mr) &&
> +        (!qemu_ram_is_shared(rb) || !qemu_ram_is_named_file(rb)) &&
> +        qemu_ram_is_migratable(rb) &&
> +        rb->fd < 0;
> +}

Blocking guest_memfd looks ok, but comparing to add one more block
notifier, can we check all ramblocks once in migrate_prepare(), and fail
that command directly if it fails the check?

OTOH, is there any simpler way to simplify the check conditions?  It'll be
at least nice to break these checks into smaller if conditions for
readability..

I wonder if we could stick with looping over all ramblocks, then make sure
each of them is on the cpr saved fd list.  It may need to make
cpr_save_fd() always register with the name of ramblock to do such lookup,
or maybe we could also cache the ramblock pointer in CprFd, then the lookup
will be a pointer match check.

-- 
Peter Xu



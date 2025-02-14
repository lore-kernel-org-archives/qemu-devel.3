Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CDBC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiyDS-00089V-Np; Fri, 14 Feb 2025 11:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiyDM-000894-VO
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:06:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiyDH-0007ER-HC
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739549205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B/3GjV8gkdhZxYfknDE8IVTtvzindxk/3Lnu1au8XBc=;
 b=QsKiMdL0reTei+KE3B2CkQioUAj9e2uNbTRc/01jEvSYKdR6CHLDAa+gk/1l5v46r5XftZ
 KE1qW41nKZSsSZtRfJlh4SOboENgQbIoovmYKn7xPtUY2uMUhCY5BWhzNHDpV4l517JB5K
 RUVTJoyJCqOZsx8EbXsiQyNjF2vAR2Q=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352--TwPH7UKOkqGSbKwYfnS3w-1; Fri, 14 Feb 2025 11:06:43 -0500
X-MC-Unique: -TwPH7UKOkqGSbKwYfnS3w-1
X-Mimecast-MFC-AGG-ID: -TwPH7UKOkqGSbKwYfnS3w_1739549203
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-726ea4aa505so1861296a34.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 08:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739549203; x=1740154003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/3GjV8gkdhZxYfknDE8IVTtvzindxk/3Lnu1au8XBc=;
 b=IwJtfa9swCScJAOsscvI5DYoB2u5b9ImYXLu5thRnlHj1/HzknhsQuCQMt7QF8/tSh
 2GplV6BoK9ArlWH/EMTrrDuyHBFPKOvlt1wf2canLyHjqnDM6MxkpAorPAY3WcZpWF1v
 0StdgmkjDQ/o7GyGmK6+egrktp3NS3OQd9o0Bek8MHy4etAyn4vA5VbMoGbeXA4law0E
 Qt4XJkF0vn53dyHxHj8Jh6JcnXOsKCTQmCjjeYB1r63gnZu0tnU67FrJhMtMOGbFUSmO
 ObyNna0ZV97pCewtkJVeWGAGBi2tjVp4GWRoJm1Vin1vg0hAf+cmukdguxzblQ6LtjeV
 Zw9w==
X-Gm-Message-State: AOJu0YxaGYKEoGQhCDD8JAkjRpwmds3tq41Q3cPX/4Lm6npvLJuTezYG
 CTn3sNeHNv6JLy17CFi7PkcW7RtxB7tuKZIfK0B4t5j8D8SUOxlewHQxv+kvtxeizL9B9/2jBN4
 dHjKuuTJ0H+obdhI+56msLm7K3vUOtxBWlxREN39IZO9lbQsco6aR
X-Gm-Gg: ASbGncvaLgzECuXqKHE+Raaq+ty2N4ESn1+mE/QlovCtSwGsb3AIOaPxy90N9f/VY7d
 +8BGBGtodFEJZsnTM54XddlxG5F4cR6TxlkCbo1by6JtuHkq03t6bS12eD4MkF6fl24ShuCnZPS
 JuCV+lycr2eG0Kuoyz8WLH3wEn1SWR6sLFgIMi+U8W9/zNXkp40MVUXwE2Lq6Cme5X9tKimZbv1
 7a3jHYNXqzfcJCGG/MoYjy+2MoCqnhf6/EKluHgs+XAC2e8CT8IdXT3NEg=
X-Received: by 2002:a05:6830:6e9b:b0:726:ff32:3b6a with SMTP id
 46e09a7af769-726ff324167mr5317112a34.0.1739549203138; 
 Fri, 14 Feb 2025 08:06:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzlP+zJDG4qRPlLJQe8p7ZzuvUUP9x7/3nNjgmZ16m7vPyw18hn1gk4bbqXfqFMmogZiRbNQ==
X-Received: by 2002:a05:6830:6e9b:b0:726:ff32:3b6a with SMTP id
 46e09a7af769-726ff324167mr5317080a34.0.1739549202804; 
 Fri, 14 Feb 2025 08:06:42 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72700263af2sm1365934a34.57.2025.02.14.08.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 08:06:42 -0800 (PST)
Date: Fri, 14 Feb 2025 11:06:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2 00/45] Live update: vfio and iommufd
Message-ID: <Z69qDWTaNCQobUiq@x1.local>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <45420461-ead5-4b72-8f84-cddf53e2b95b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45420461-ead5-4b72-8f84-cddf53e2b95b@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 14, 2025 at 10:56:02AM -0500, Steven Sistare wrote:
> Hi all, it would be nice to get this into qemu 10.0.  Without it, the
> basic support for cpr-transfer already in 10.0 is much less interesting.

True..

> Soft feature freeze is 2024-03-12.

Said that, targeting 10.0 for such a huge series across multiple modules,
and especially during the time VFIO review is on heavy load.. may not be
easily achievable.  It might be more practical, IMHO, to target this 10.1.
Review can still happen during / after soft-freeze.

Thanks,

-- 
Peter Xu



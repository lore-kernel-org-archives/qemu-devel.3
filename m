Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F8CC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 13:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQKU-0001v8-Q4; Wed, 25 Jun 2025 09:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uUQKS-0001nl-Rc
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uUQKQ-0000TB-V2
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750858697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q5yR1c9+E9NTIZWZFC5WnWiCO1Mr4P9T/HZRarIgju8=;
 b=TtKW6ya3J6Im4ghvjK2AFH4kSOCYhPtqFymWZHIge0mZxEec0raNQxAQZ1SMwGh3tHTM87
 i5CEqjKAO3MM5mi8lK5wMKelsdHyinlogI+swQO+ZxnLrGHSwaVZvZ7dobR7WgsieMfR5M
 1ExAuYsESsfB+AEf5Qd5/hFO+++72F8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-bPxTi0y_MmOX8JuszuG6Qw-1; Wed, 25 Jun 2025 09:38:13 -0400
X-MC-Unique: bPxTi0y_MmOX8JuszuG6Qw-1
X-Mimecast-MFC-AGG-ID: bPxTi0y_MmOX8JuszuG6Qw_1750858692
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7377139d8b1so4882645b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 06:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750858692; x=1751463492;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5yR1c9+E9NTIZWZFC5WnWiCO1Mr4P9T/HZRarIgju8=;
 b=Q2rMiB6qm+XerGnQj3Y6cko/f00dObvEqFlTnPmoc4sgwmIHCmX0dZ3n7FMHSJsduA
 DQoHZogyApfnaUEZm4QXbcUitOIlYjTIKhk9L6Yd+WdbOWa0VNkgdCaM0bImrFlfhnYe
 FJ45wxxHjdZ08CqStnxMZJHL8hLa2TL1nMAriFiRRPa7XnxsTiQJTtZEqW/n5JAs5qO+
 GpB3MrfIKCj2bUhBogroWM1nza3iTFtLZQGMM7ZHxww+RCl7Cqx94E3NPQHhtKwd1jJd
 GraaPv96tA0ZujDCLtUh4t5URo3Tyjs4AFoV2dpfj8zSEw9nLHntiiRixNYBGwyKc4nc
 Cadg==
X-Gm-Message-State: AOJu0Yx3qFWvqvFEcaVyACLjhmtSyDIBPvAhz1Otn0TkjwkFMh76HtQ0
 5xhYL9ixIC6bLby0UOmDuLLDPFwPk/FY/0XAauamk7m26BlkjgAkkaax/msTgoKViCVZsRjjjxo
 GzT7sNfG0yJKYqPxhTHgqX5+eDhrWx5f6zEZ3s9Ek6WCDLLX/f4JhcMn4
X-Gm-Gg: ASbGnct//LtD93KFrLQeeErXJTqwD5M2ajk06xoTUKkMO9DVkNAhzcrNlbZFP6KUzHl
 A3RMlLZ01OKi5PcheZI/9UuULfsg5suItrNVnk4zPdTNW/g2nM+KE03v0damMCNA70t2TLc2xeE
 CutK0CZl4PvI7k3QEzmsRYCm2Uge+2PecNJDPf7hK/jhdsMSRGmGqrxD6cM2D0UoOfskZaUqaKA
 aPxKQ/4AQnJYaIR5GoYap82nDxqMtzbliNQ6ZEnqWXN6S5gGCQXcQT4zf1U6xELazcqeL20CmRN
 t1nSynZRgGHeLQ==
X-Received: by 2002:a05:6a20:438e:b0:21e:f2c4:7743 with SMTP id
 adf61e73a8af0-2207f1e5a52mr5260110637.7.1750858692223; 
 Wed, 25 Jun 2025 06:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVSAxQBXLPujqMBycA77Lg9+i+dU1YVJcCZlVqyMFiZ9LZlIWtLuMiJejCOJWhJbYYq/3XHQ==
X-Received: by 2002:a05:6a20:438e:b0:21e:f2c4:7743 with SMTP id
 adf61e73a8af0-2207f1e5a52mr5260071637.7.1750858691887; 
 Wed, 25 Jun 2025 06:38:11 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f1242bfasm10660017a12.46.2025.06.25.06.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:38:11 -0700 (PDT)
Date: Wed, 25 Jun 2025 09:38:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Mario Casquero <mcasquer@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 06/11] migration: Rename save_live_complete_precopy to
 save_complete
Message-ID: <aFv7vrfnOhtYDE0R@x1.local>
References: <20250613140801.474264-1-peterx@redhat.com>
 <20250613140801.474264-7-peterx@redhat.com>
 <oo4t2s5rz4uaivfm3vejlum5c7efsjiysbavtt24rinoefs2tk@ihtornpsiz5q>
 <aFrHF4hKTdAgRpfs@x1.local>
 <5wyhdft4ucul4wehkq76im56jkixfmyxrfrhezzjnf7qnkmu7i@e73pvqathnom>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5wyhdft4ucul4wehkq76im56jkixfmyxrfrhezzjnf7qnkmu7i@e73pvqathnom>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 25, 2025 at 01:13:48PM +0200, Juraj Marcin wrote:
> Sure, I will send it today.

Thanks. In case it helps, can fetch head here:

https://gitlab.com/peterx/qemu/-/tree/migration-staging

-- 
Peter Xu



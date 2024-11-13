Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDDFD637BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBKOh-00025N-Cz; Wed, 13 Nov 2024 15:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBKOf-00024s-RA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBKOe-0002FC-Et
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731531327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R3Cca2A8tG9Uu/q12UKX19kSvjMYc/S6mbkE+xzz6M4=;
 b=gNSbcl72Dbwx2BMEuSqwJmkToJQsoDsEXmN6sFZtxZ3/gM1x0BTJwUyxfToZxhQFkMja74
 vFZAOytk7aeLUvsgQUs+3GgDfPXRr0v1i2uxySsT/+g5zQTr9udNyUOO7JsosN7FvKESKP
 8HxCgNya8xOs7rYGjALw0c5UV5E2a3c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-UgEhF7VLM3-fdWdmO-WywA-1; Wed, 13 Nov 2024 15:55:25 -0500
X-MC-Unique: UgEhF7VLM3-fdWdmO-WywA-1
X-Mimecast-MFC-AGG-ID: UgEhF7VLM3-fdWdmO-WywA
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ce242668ebso105421196d6.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731531324; x=1732136124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3Cca2A8tG9Uu/q12UKX19kSvjMYc/S6mbkE+xzz6M4=;
 b=Rg91O4ip7iNYsaNbCYKkG6+JlAdCI/3oque4uLxuOHPZwHInUKxFkvRY9j05YPggOM
 txs7UB7w3f/Roj4mBJiU6A9A8a9UL1u7hVp+pFhLIbPGsNiQyRxiUMTKf9VYRRgXa4Is
 KGExJ4Id82rptSQsLZ18eOAvWzWBIaCyEZi+eW4fu2oE2FPkOsKoVJOKVdZV+3cKvUKa
 sBPbM/Vw0WUf9vuNSZPvGE4lwadMzFXWwJ6kq/pRAJPqPBCF1ZvqMayG31coJ8HZ6uYc
 0I/8rvxxXI7s7SVpXvpACuAmXVKZ4U+xdk8RUgzrB64VWRLxi7PqUez0MYj106rfvfF+
 gdPg==
X-Gm-Message-State: AOJu0YzOBj+6Tl+KGf6FoXQeNIzEAe4H4rGDy3Yk8tzO4ij9WyoyzZNg
 bqPPEx3ozu0739BdslAMIXTgfKxkfHv1+oar6L4Gcemeq86d1T8hBPMjUwErDceqAsDKKajKuIr
 HNlU0Hk3UN5ujdXMvNbvjTfrwiDBAh1YAbmIU1wSdKDr6I0xi2r0H
X-Received: by 2002:a05:6214:3bc7:b0:6d1:8261:174f with SMTP id
 6a1803df08f44-6d3dd06b6f3mr59338956d6.36.1731531324169; 
 Wed, 13 Nov 2024 12:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvMMTkXr/SCTIzL8XDqkl1IPKN/Qz1uugs5l7a/Y21SzVeTUol+ntnBoGud3O7QLAxu8N/0g==
X-Received: by 2002:a05:6214:3bc7:b0:6d1:8261:174f with SMTP id
 6a1803df08f44-6d3dd06b6f3mr59338716d6.36.1731531323878; 
 Wed, 13 Nov 2024 12:55:23 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3961df2d2sm89137746d6.25.2024.11.13.12.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 12:55:23 -0800 (PST)
Date: Wed, 13 Nov 2024 15:55:21 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 06/16] migration: VMSTATE_FD
Message-ID: <ZzUSOeB9xD3tEt0G@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-7-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1730468875-249970-7-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

On Fri, Nov 01, 2024 at 06:47:45AM -0700, Steve Sistare wrote:
> Define VMSTATE_FD for declaring a file descriptor field in a
> VMStateDescription.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



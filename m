Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3389CC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPj4W-0002Wx-JJ; Thu, 12 Jun 2025 10:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPj4S-0002RK-Ae
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPj4N-0000cX-4u
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749739094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JQxWPEpKf8tY+EwqIeQ0blqXJfj8AQEEa/Xjt2pJuFs=;
 b=XEX1rc2KQ6Cw01B7XphK3t0INV7DVQev8HSh3NpAicg47koU5fcXTBd9QdsVmHdDHeNM2I
 LGlfQjlB6G7sl58DuhtO848H0I5uH7VYrZHyGccSNAg8GAkQVjXhILpetOaEOjhCjgKCim
 5C6qooahenPZhvICgIwdHLEgk8qRIOY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-qqtYbJSZOQWEt-DpfEhmIA-1; Thu, 12 Jun 2025 10:38:13 -0400
X-MC-Unique: qqtYbJSZOQWEt-DpfEhmIA-1
X-Mimecast-MFC-AGG-ID: qqtYbJSZOQWEt-DpfEhmIA_1749739093
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5f876bfe0so206871885a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 07:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749739093; x=1750343893;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JQxWPEpKf8tY+EwqIeQ0blqXJfj8AQEEa/Xjt2pJuFs=;
 b=PYboV09h7Qb7CYTHetS5Ul9IFdK4KhvTTstRdSUT1mHlF3NUjA2lshoWF/4Ojn1xWQ
 h5onqEDkDTtT8lvC04MxKDn6zLw3t5/YkB5GCPafGuDh6iURNhvIyBbWg2w0EU06WeTP
 p8gcqZQXCswoPvxl7inxTwDCmQYBBMgWIUDKSC8RdFTq2wIp+oZvB9WV3E/DjXpV5k+N
 7DaR1isUHFeIk7N2ZE/Dt+Tc7g7u3sDf+9vzVH3d8EG4EkXMtj6/by9QxtWXEKCJuzXY
 DbMk7oNlv6ZAJldOrBSRBdao9+zQe2NK+WojvbxbDrXDh48xiu7mifHZz9YH4pbCAqin
 a4VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7EAvLmelyf8/INe0zwYYEoCWmrYoSgj+BYrZACOciQG6/qFDRmdJtBvoeRaKIzlLLz7DeNv2pX6NH@nongnu.org
X-Gm-Message-State: AOJu0YysFnbKXUR1YgUdkkIQiy2bdzlpPl7CcQ05VKGzMMndsyH7agHf
 OUGvNIFGhshaj0hDxxD8MaOdw0OkB0jOrZXrDG1/S7yhTAa9bwOzusOKKSCu3fawbfsEUyOtDV4
 eWda9CuAsTeqbsG4DSE+ezOjvXaZ0EpiDkjV+49oitnZxei4XDC5L7pilF9Nf9i/z
X-Gm-Gg: ASbGncuUUbzMCGz8FF8NXjTC1N/rp1Cky8GhH6mqEIE94Ys+ncAjPBJjYJOr6Haz5u4
 IUR0PsaFSPlVEl/vLAgCAFgB3DQNSXjG8fHjCYrHzBUQZD9Wpd4gDjrkYXcum3OQ2bJaStEAp17
 JtOeysK/x43HPKMKGDInWzZ3yUCVUGJsMfgwVfwoHqo3ChnvNVouzdW0+X0LfDhooMQHZ/2rwi4
 rjj+o+cp/+6xFAjtYreVKSlouQs/1gbTR6yr5ayazGtMSMtIewWEBxQ7Ar2cPNW7QPOZms/IKcm
 tsYsKbYYQVGkAw==
X-Received: by 2002:a05:6214:c21:b0:6fa:bedb:f61d with SMTP id
 6a1803df08f44-6fb2c32ab76mr129921856d6.14.1749739092915; 
 Thu, 12 Jun 2025 07:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfmWSpOZoqMrgyEhsrja2oKLcCMHsDsN7+RhD+jS3DvNZ+2Djp/Np5t2bdq6r6Lgusn4B39g==
X-Received: by 2002:a05:620a:170b:b0:7d1:fc53:c6b2 with SMTP id
 af79cd13be357-7d3a8930070mr1100870085a.41.1749739080769; 
 Thu, 12 Jun 2025 07:38:00 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b8ed0113sm46313785a.81.2025.06.12.07.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:38:00 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:37:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 jjherne@linux.ibm.com, steven.sistare@oracle.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v4 2/2] migration: Support fd-based socket address in
 cpr_transfer_input
Message-ID: <aErmRDco1cXWZGyB@x1.local>
References: <20250611205610.147008-1-jhkim@linux.ibm.com>
 <20250611205610.147008-3-jhkim@linux.ibm.com>
 <aErY-yZy9qbVpdcU@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aErY-yZy9qbVpdcU@redhat.com>
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

On Thu, Jun 12, 2025 at 02:41:15PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 11, 2025 at 03:56:10PM -0500, Jaehoon Kim wrote:
> > Extend cpr_transfer_input to handle SOCKET_ADDRESS_TYPE_FD alongside
> > SOCKET_ADDRESS_TYPE_UNIX. This change supports the use of pre-listened
> > socket file descriptors for cpr migration channels.
> > 
> > This change is particularly useful in qtest environments, where the
> > socket may be created externally and passed via fd.
> > 
> > Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> > Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> > Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> > ---
> >  migration/cpr-transfer.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> This patch *MUST* be first in the series, otherwise 'git bisect'
> will hit test failures on the former patch.

Yes. I fixed both issues and queued the series, thanks all.  For the other
patch I did null-initialize for the var.

https://gitlab.com/peterx/qemu/-/commits/migration-staging

-- 
Peter Xu



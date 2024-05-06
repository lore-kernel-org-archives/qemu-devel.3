Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29A1C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40SK-0004Pq-OI; Mon, 06 May 2024 11:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s40SG-0004PY-H9
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s40SE-0005as-Q7
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715010036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sLhtVBk+L+nRe4APINJuogWqWhOUM8z/N1qLONzwNy0=;
 b=J0y4+F/eDecDGDGxHZdxR6qES4+dAC0otTSoAyrAD8UyLuS7uLwzk7ngVgcFuKk1FjytOK
 sxhofx4ZrkBtjzrdOIGVhiYT6pDbwg/exBMB1PKp8yNUnpEc05JIYueBi1qqCtj7mtyCoP
 klhJyXPRJnDaraHolGbapGe9aQlAMpE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-pTu3XsXwOyy7UUSOQZp25g-1; Mon, 06 May 2024 11:40:35 -0400
X-MC-Unique: pTu3XsXwOyy7UUSOQZp25g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2b2bc9bc0a9so827842a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 08:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715010034; x=1715614834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLhtVBk+L+nRe4APINJuogWqWhOUM8z/N1qLONzwNy0=;
 b=EXHw24UKf4k5bd7Wf4xqD58/+DnjMiDsc5fmAJM+vKVqSxB10Ab7IHPyyZhng2YJj/
 VVnuI6EmBiKYGH51uT99RvVoiML7l6ojgoW7RhN/ld5rdckXvTI9vF7SaESY4+iqnAuD
 HohiiSf5VLer3/NDRfUcF9IcDoyadBaMvweYfn7N09Kq9l5DMj6ercWUXvUx/wzaiv9S
 v04SmRIZHrqdXHEWVn8Fj1gBddJ2QWBvw3m8Z0IXRuQKMa8z9rWkpynsdSOhY0sK4U9C
 01t8MSQG7s8h+8Bognk4QoV7oSY/lDX4UvvvVijtqRHpVx0IXqRN6yD+gIKj10lJibzG
 6crw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtM6dl04LXF386zLehogMXKrBwJn4f1dJe7jq0VlZhV1H7TJB+hafoMgXYin9NLFqxtjkKBdb2g1MzeeazcGz92nHfSDE=
X-Gm-Message-State: AOJu0Yw7xxxVNCmxuL8FPLOpw9eOuTUOyFlcPMDIH4RHCNA5hCH0cgTw
 jaXHjQj40ELsukGbH4frG8l9k022Mw3DEfYQWRYQGZC0Pjh8/N+Jr26rG8D6p6JIikSxPbUiVt9
 AeHrUpIuusuksM3W04MYC9mb4Dhhbth6tkdgBzdR4R+irFnmMfjLY
X-Received: by 2002:aa7:8812:0:b0:6ed:6944:b170 with SMTP id
 c18-20020aa78812000000b006ed6944b170mr11021390pfo.1.1715010033668; 
 Mon, 06 May 2024 08:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE051saDseNP0Xevcw1y6PXEs0cG3b1vWuykDREps0iWdHasQmMRTnkzgBK+v9K3OVp5r4LHA==
X-Received: by 2002:aa7:8812:0:b0:6ed:6944:b170 with SMTP id
 c18-20020aa78812000000b006ed6944b170mr11021364pfo.1.1715010032935; 
 Mon, 06 May 2024 08:40:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 s17-20020a62e711000000b006f3ee8d5723sm7471674pfh.26.2024.05.06.08.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 08:40:32 -0700 (PDT)
Date: Mon, 6 May 2024 11:40:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Het Gala <het.gala@nutanix.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Het Gala <het.gala@nutanix.com>
Subject: Re: More doc updates needed for new migrate argument @channels
Message-ID: <Zjj57JdLfXxT7R6G@x1n>
References: <87ttjf1jk8.fsf@pond.sub.org> <87fruznjqf.fsf@suse.de>
 <31a8bb06-5270-4fbb-b8f1-39cd06687c34@oracle.com>
 <ZjU26faJBrt9Gb-G@x1n> <87le4nsfjb.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87le4nsfjb.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 06, 2024 at 06:58:00AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> [...]
> 
> > I also copied qemu-devel starting from now.
> 
> My bad, I messed that up!

Het, do you want to send a patch?

Thanks,

-- 
Peter Xu



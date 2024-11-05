Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF96D2B921
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JBz-0008PP-62; Tue, 05 Nov 2024 08:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8JBi-0008IA-B1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:01:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t8JBf-0001iq-OO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730811693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/dZFqy+Y3imw7XwX2olT4bGQnqMk3urIEBUKM7NhlOc=;
 b=ABDiOpi4aq0QpTPgzP6PM8ULsMHFlIuzY4hF8dWRlp8Q0LcHmiA83BNjyDzxJLDtXNIvuM
 8aevKWAj43uopG/QvIh+CjdFmiA5LOM/HxivqEWdqR4qPVe/5gesZ1eYZbXvIyH/JNTNSp
 RmzgGq0EYMLgp8S3SCRGzdCIeQ8Mek4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191--J9p2gJcMa-eLh5pMrtprw-1; Tue, 05 Nov 2024 08:01:30 -0500
X-MC-Unique: -J9p2gJcMa-eLh5pMrtprw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5ec5e0abff0so4905184eaf.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811689; x=1731416489;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/dZFqy+Y3imw7XwX2olT4bGQnqMk3urIEBUKM7NhlOc=;
 b=l9fbYNBdAeokyS46mN86cvKjOFOYHvkQ//63LgQP6GUEz6rqQtSrVgtpZtXfHF8Kxs
 eJUJ6h7kM1OhX/VEEu7LKaW91fVySbpae1Uy1bQujGpdac4hZtR6ZaFxDcQbGH1oLt4v
 RN+ZKUkvD6PrKZUvCJB5d+fYAeR/TEyhHRSgGU89rjA59ek+rShs6wSKZd14eyx2suJg
 lCuONqGLckwDpZGITH+T8NPJE1uqKohSqEmGn1UoJTsJrNo2WIHHjO93wEMhmBpTVfvR
 GFeLK+qJEbM7AGU7+jZHGQuJAQTQ7D9XxoCV04/PXM2Q8qDN0uRky9kf6C9Hsjc8Avwy
 9bKA==
X-Gm-Message-State: AOJu0YyzcdJX38gRwy473aPSEEoaK8jmUNiLZeW1wYYSMLDhU55ezCMA
 ase6oO3KurpHi9MKu208ZrXuCI9OhuYkdYmV+h0LQSyaJ7zK9MvcBTt6vgU3RP67AlTqDZcM1UZ
 ksOz4RyZUKLILRdPGU7dEeVfVb0L8EcrtkTFQaL0EKTqilRhM/rafTeLZrOI9
X-Received: by 2002:a05:6870:5489:b0:294:8712:9d70 with SMTP id
 586e51a60fabf-2948882a1a7mr10887347fac.17.1730811689496; 
 Tue, 05 Nov 2024 05:01:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwysLC8MJ6WmlsvBjp7n5Yaongq+Eo9oe6EGpOzshJSUuXk283if4XCV5aIWGSJx3fA8MY+Q==
X-Received: by 2002:a05:6870:5489:b0:294:8712:9d70 with SMTP id
 586e51a60fabf-2948882a1a7mr10887320fac.17.1730811688992; 
 Tue, 05 Nov 2024 05:01:28 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2948771a4fesm3603559fac.37.2024.11.05.05.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 05:01:28 -0800 (PST)
Date: Tue, 5 Nov 2024 08:01:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 4/5] migration: refactor ram_save_target_page functions
Message-ID: <ZyoXJRzg3N1ca16N@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-5-ppandit@redhat.com>
 <ZyToBbvfWkIZ_40W@x1n>
 <CAE8KmOyi+_U2H1r=MyQmppNj6v3mMqpjMyMo=q9zm0=-49+B3g@mail.gmail.com>
 <Zyj9rz6eD-gAm4fa@x1n>
 <CAE8KmOy-up_gi8t0qGwtM04QmFvaEK7VmL=1JxEFR-ksHLiQ1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOy-up_gi8t0qGwtM04QmFvaEK7VmL=1JxEFR-ksHLiQ1w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Nov 05, 2024 at 03:31:19PM +0530, Prasad Pandit wrote:
> On Mon, 4 Nov 2024 at 22:30, Peter Xu <peterx@redhat.com> wrote:
> > Yes, IMHO it's better when merged.
> >
> > One more note here, that even with ZERO_PAGE_DETECTION_MULTIFD, qemu will
> > fallback to use LEGACY in reality when !multifd before.  We need to keep
> > that behavior.
> 
> * Where does this fallback happen? in ram_save_target_page()?

When ZERO_PAGE_DETECTION_MULTIFD is used but when !multifd cap, it'll use
legacy even if it's MULTIFD.  We don't yet change the value, the fallback
will still happen.

-- 
Peter Xu



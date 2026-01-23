Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E5BD74EED
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJHV-000205-OB; Fri, 23 Jan 2026 10:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vjJHN-0001va-GC
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:40:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vjJHL-0001Of-Nu
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769182853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nyiivhnze1AKHpgX5a+tKmF9lOlgQcEhAbYshAvQ6Ew=;
 b=V3HHkjSDngg7WHtqf23ANUJjuVBSfabidNdGYmx4jtVl/gcwe44Tm3nEG45gUXOpwlDDUJ
 U3KFt1Pa1rCpuWqueW0RnAWIt4hi3gC6GZTRyBu0w1Djct4ra/FC8YI0ai0NmG37fnODog
 HQnE7WC1UQQzjQZene5Z8cryjvv2wZM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-vBjF-ZIuO0KylnxkA9Y_Dg-1; Fri, 23 Jan 2026 10:40:51 -0500
X-MC-Unique: vBjF-ZIuO0KylnxkA9Y_Dg-1
X-Mimecast-MFC-AGG-ID: vBjF-ZIuO0KylnxkA9Y_Dg_1769182850
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a360b8096so83460646d6.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769182850; x=1769787650; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nyiivhnze1AKHpgX5a+tKmF9lOlgQcEhAbYshAvQ6Ew=;
 b=QCLzM4Uh5hbUlcogSD1i605csvYgF1IFLOv0i0hzz0eZrC6ivwocv6aI8rlUhI7z3G
 iu7++eD4FnS2g1HNE/t6PCohwzgEUOGUhyC9wtcFzYdvaxeeqEmSjx47uUTIRLa92WBM
 ge5JR+mMwVdWi9rJEWqsvviLluEK6ZWVZbU0QLA+uAV1tXNfNyoPM2h1692h6Opl37As
 VhJ/1uVWQ+dTyGQZp10rXsl2lh+TlrT2wNm4B75qYJ2r/ZZwVZbpC8ParHAJDvTcDDNS
 kU2/0ZAwiqI+4v76WIgNHr11UzRqBCr5yEXkY1Eye8K7ZMC6LMvHCchiOyVWfGzDXOau
 kfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769182850; x=1769787650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nyiivhnze1AKHpgX5a+tKmF9lOlgQcEhAbYshAvQ6Ew=;
 b=hq/SPjV9PQCWwLcJxZwyzJC+uxYfJ7hngPTwzKzgI+szflVubUKl4S+OU7rtYCbJt9
 nkfFaqx28g7W25E/JFRpvzju48BRWKQDYG5hAyjMFwmOS5S6t0RhQ5ZbUE18mlhjEjVe
 RLNrfDp1viRi+nEzJ9PDhTzlGGt0kL1WZfNMfr8mkqGftjyLq3yFw/Y52NXjs0omrHew
 LfNzG9zM41pmIb18yJJ/v67HD+oWybYRJ/iaU2KkKAfRri9ckTCsHGQHgW8fULL4z8nJ
 6ITrjWkz81TznU4915ygA1oMMb/Z0K37Ku7bodcH6wfUsLsIm3KvvfDXUIQ4VvBotXfw
 HyDg==
X-Gm-Message-State: AOJu0Yx06P970fAdxmvHlaD9xyWt+y9FsfEV6AXgHMtC8PdTtwz/icjp
 RtwLV64/gWptlzKa7vQ4Zcqf54s1mTG4ywc9qX40/yGt9R8Dtcxiv8Mg9Kx8rRdeIYmsCMLYYuo
 ijL18BQyiJ7Bu4XK5A3EjuEbSjC31K5d8MWqUOzsqK33PJQDuWhYCVkKJ
X-Gm-Gg: AZuq6aLAETgUBVwa7tRn068AGdM3BLqUkPZAwt0BDBNjsIMp7xqbY89ndopkknmeV2B
 pQ/Z4/DLMP58D8OM8So2ajp8DFFdxk+GDsdrtWMRr2i0o4yM5Z5GMVnM9kp2+hZuBdLaiXpT0aS
 2kf6h4wCN+3qpDdezSHA1kHLkub8AWmwFOnhlupU/U+R2nELFjx+VGNMUe3YHOdpmSTOavoUjRY
 G+d+VZohvQG4cJ/sCIvIS/l4MbK9FLsbEQivp3os0661wg5dF6SEppV6JKaLXe7YOz9ik4fEJ64
 I2YarsFJj0SJHMPfCOAs2xsxit+7tBpGwpajgf4nTLC0yKS2f3em91uSs7Rw5/FcUnijxeIYtlN
 8Tj4=
X-Received: by 2002:a05:6214:21a9:b0:88f:caaa:fdb8 with SMTP id
 6a1803df08f44-8949022443fmr45868326d6.42.1769182850394; 
 Fri, 23 Jan 2026 07:40:50 -0800 (PST)
X-Received: by 2002:a05:6214:21a9:b0:88f:caaa:fdb8 with SMTP id
 6a1803df08f44-8949022443fmr45868006d6.42.1769182849921; 
 Fri, 23 Jan 2026 07:40:49 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8949196e497sm18966176d6.55.2026.01.23.07.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:40:49 -0800 (PST)
Date: Fri, 23 Jan 2026 10:40:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 3/5] migration: Notify migration FAILED before starting VM
Message-ID: <aXOWgOAWqjy7rHV7@x1.local>
References: <20260122230331.3543312-1-peterx@redhat.com>
 <20260122230331.3543312-4-peterx@redhat.com>
 <874iocjxhk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874iocjxhk.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 23, 2026 at 09:59:35AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Devices may opt-in migration FAILED notifiers to be invoked when migration
> > fails.  Currently, the notifications happen in migration_cleanup().  It is
> > normally fine, but maybe not ideal if there's dependency of the fallback
> > v.s. VM starts.
> >
> > This patch moves the FAILED notification earlier, so that if the failure
> > happened during switchover, it'll notify before VM restart.
> >
> 
> The change to FAILED in patch 2 should come to this patch to avoid
> having a window where the notification only happens at the end.

Hmm.. Isn't that expected?  Even after patch 2, we still notify FAILED at
the end for precopy.  It's the same for postcopy.

For a failed postcopy we have following behavior:

Before patch 2
==============

  - notify FAILED (during switchover)
  - vm_start()
  - notify FAILED (during migration_cleanup)

After patch 2 
=============

  - vm_start()
  - notify FAILED (during migration_cleanup)

So patch 2 fixes the duplicate issue, and only fixes that.

After patch 3
=============

  - notify FAILED (during migration_iteration_finish)
  - vm_start()

Patch 3 changes the place of FAILED notification so that it happens always
before vm_start(), for both precopy and postcopy.

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF08C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 16:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnL9p-0001Ck-F0; Thu, 21 Mar 2024 12:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnL9n-0001CS-E6
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rnL9l-0001zF-SL
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711038040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W+JlQ6GrwEpMoPHi/OUwFEE4Ar+wR4dPchh5xV951M4=;
 b=MRXYhfkrRO+OGl1sPN6m4x+JLaH6yUAxEMRUd8Rp0Z8TGy09qX3F2CRF1Zvwg5eN3mEhB6
 Bp/8CI3wYrnLUXrsHdQBd1Hi5biKE5SCTazzKr1wuseCovjwJEFhSO/xpci369m6exPnrx
 JGLj9eR0zEyogHLDybMvm2DlzwCi0VI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-7Up2Ho_5PWWl_Nrrg_7NUQ-1; Thu, 21 Mar 2024 12:20:37 -0400
X-MC-Unique: 7Up2Ho_5PWWl_Nrrg_7NUQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4311d908f3cso4980821cf.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 09:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711038036; x=1711642836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+JlQ6GrwEpMoPHi/OUwFEE4Ar+wR4dPchh5xV951M4=;
 b=Y01tRTyXvHL8SKR3lFzMjfiTuiiijoBqZ3ZwSs3ItjKVp+VyPp7duMJeOAhMqMmMJC
 ddf41z9IgTifXSv6hZfPfTVgCama7inFeE7AMHCrjlVVgT1TTz5M73wGJvlWGipv10g4
 xkqPYyNSNt2V86PamnvbT1s461vGbsYgqsu4WJoW8rqJWRMfYZyR8HLXJJFAOs8ldO8y
 cm2kGHyZgxTSZ3zUqnmVX+CnQ5/geWeisbkWe9vXvKDT464JNvjKyX1ZoU/5zCsl5OIR
 jCsFweNhaVFyoZ6meKU29u6T7tdm5UVZjVJpKpfeMmWDB14P2SGiIgOuTPPHRNBV6Qn+
 dITg==
X-Gm-Message-State: AOJu0YzkWcexJBao5DQWXvIO4RecKs2aTHFMbVLtPGK/hwSvhvw9QvDI
 eiQJUUoK2J75liUwYgfaYPtFx5IK+oiipKAbFW6Fs9ZETrUJXxS9PsRjvMKPHYnI3YS6x5QvbXH
 1YnExx7eROb1QNiWle8S2ZXPdWdpbQvxfr+nIscLswQGVrC+vim6dI7I1vFFS/7ShhSjBCRIA4L
 F9tHdtAQsJBOuRarCnsBn3IF2zJDxkOKkPpA==
X-Received: by 2002:a05:6214:3907:b0:696:5961:e213 with SMTP id
 nh7-20020a056214390700b006965961e213mr1740589qvb.4.1711038035937; 
 Thu, 21 Mar 2024 09:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJII0RxeJZPeREnYBe1Urn9VvzybUZlp/Xbw4RMl0FxOJPLFm5Epl5XwrsJZC9rveYwkfy+Q==
X-Received: by 2002:a05:6214:3907:b0:696:5961:e213 with SMTP id
 nh7-20020a056214390700b006965961e213mr1740541qvb.4.1711038035231; 
 Thu, 21 Mar 2024 09:20:35 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 3-20020a0562140cc300b0069154e0670asm39615qvx.90.2024.03.21.09.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 09:20:34 -0700 (PDT)
Date: Thu, 21 Mar 2024 12:20:32 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH] migration/postcopy: Fix high frequency sync
Message-ID: <ZfxeUDcS8OswQht_@x1n>
References: <20240320214453.584374-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320214453.584374-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 20, 2024 at 05:44:53PM -0400, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> On current code base I can observe extremely high sync count during
> precopy, as long as one enables postcopy-ram=on before switchover to
> postcopy.
> 
> To provide some context of when we decide to do a full sync: we check
> must_precopy (which implies "data must be sent during precopy phase"), and
> as long as it is lower than the threshold size we calculated (out of
> bandwidth and expected downtime) we will kick off the slow sync.
> 
> However, when postcopy is enabled (even if still during precopy phase), RAM
> only reports all pages as can_postcopy, and report must_precopy==0.  Then
> "must_precopy <= threshold_size" mostly always triggers and enforces a slow
> sync for every call to migration_iteration_run() when postcopy is enabled
> even if not used.  That is insane.
> 
> It turns out it was a regress bug introduced in the previous refactoring in
> QEMU 8.0 in late 2022. Fix this by checking the whole RAM size rather than
> must_precopy, like before.  Not copy stable yet as many things changed, and
> even if this should be a major performance regression, no functional change
> has observed (and that's also probably why nobody found it).  I only notice
> this when looking for another bug reported by Nina.
> 
> When at it, cleanup a little bit on the lines around.
> 
> Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Fixes: c8df4a7aef ("migration: Split save_live_pending() into state_pending_*")
> Signed-off-by: Peter Xu <peterx@redhat.com>

queued for 9.0-rc1.

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A142AFDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFz3L-0000OA-Vv; Thu, 23 Apr 2026 14:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFz2y-0000Ad-Tz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFz2c-0005YT-Cs
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776969882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwoZNNTL5329w5yaw9Bt+INVcYE01TamiRtKB1mMfd8=;
 b=fCFfHrdtFaGP+ef7ptSF08KTNvzSXxEcHug8FvYadyfqmj+FBUTZr1XrjOw19WctfUOLfW
 PI7Kz69/RYK+8xfeseFKgynPVrxx3VoNBlI6b9oD6nHTFzp3BbkiINX9yzDeAuZ+xo+ECu
 2XPSokrJDZnveBu69kP9o6/WpvWTJ9A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-9N3YqMsDMJywpj5CKRfd1g-1; Thu, 23 Apr 2026 14:44:36 -0400
X-MC-Unique: 9N3YqMsDMJywpj5CKRfd1g-1
X-Mimecast-MFC-AGG-ID: 9N3YqMsDMJywpj5CKRfd1g_1776969876
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89fe39655f7so65108866d6.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776969876; x=1777574676; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rwoZNNTL5329w5yaw9Bt+INVcYE01TamiRtKB1mMfd8=;
 b=ewsM/s40thV8TXyZrbf2VP4cmQh6OtHHqF2v46cuk/M4qMWa4pfqg6DMJxxTCuvE1k
 rPSRt4rxb3oOAL4m9g3ORjiOPP65jcDM4vC50Bq86EwJzT/b+LYU++G/UN2MIJq/RZWo
 5IvwlklJnMc2DoN4Cv1XRc2yKdw224t8S+geOKNqBoW1MwlqP2+0Ud0s0NQUr9lgEDAb
 mauix2hJsTVoZJ6jr+Qg2RFNfvKRGak4J8zqCd/0w6Rxe9IB2GEUb5eLLAmZYno2LMsN
 ThIX+P9ubbV9osSTIUajooiCcGyYLsy758tWEPSNrBS+g4ClL6wBv5DxhsUADvPtoktF
 Yuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776969876; x=1777574676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwoZNNTL5329w5yaw9Bt+INVcYE01TamiRtKB1mMfd8=;
 b=S/eyMlUyPxELEywAoXNI+SF61qTq4S2E1G+EqgrftNW3GNhBXm2aIwrNaIOkTu9FlO
 BBV5lvXMk1tindDbSRtbyMlG/XeVNU6AdXUXBrFUCPv3cSI8+iKTSrm+1prE0UVMmSFo
 hTd3JBuc1jnQi761YntLpeG/Uifarh2oYQFt/69pE+ApbOXUl97MVujQPn4DMfVgzLew
 zRoJLQ1DwmoWHM2g7XJ7M2UGqMs9zW6OvBBs42WtUZQjetdek7Kipzs8J6L2L1sINP2p
 MhzRC8aPeV09Rl/S2gpLoOGr1bp9o2iTjBjqCQipYYkcbqq3KdT9L2FJeiYL+OAidIP2
 DR0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qEqQMuLuYXHJYTzm1HuCHJ7FfItVi7iow8y8+rFco0ol7qVIkl9lQGInvS88hY0IkV+1z1aofRala@nongnu.org
X-Gm-Message-State: AOJu0YyVCMD3RmU2lt0MJfBAJFkoxMG1YAMRddX9eGkiSTUqpYbWUsmi
 Evp56Jhg7Fj0URtHQPHweOOFiM82s5CcqBcNGCc20ymfreXpbsfsb3MzgUG3HRFRsYz9WQw5NOG
 jAbbj+b/TUYBqLU5CNxFOKryd3538UghhdsBcpUTxNnmZeQChRKijJCZ5rmDCEkgu
X-Gm-Gg: AeBDieuNDqzMX4FOxPw18AaAQHaySMXcGw2hKmf/mCSiYKO0An1lJeLyhJh5NWZMnpp
 zlg7/4m89w89C0W/rz4Rb22RIXU1uiCZXuLMerth8383Grq4rFNz/k38DcjUuRq+TxzavaWqT3G
 gT1u8JmbTxU/icy/+5e3W/JWAfJIYthB4AIUw9m65p6MxbQQ4Y2j1VS8SSgPHYs+mapD6Q7ZEtU
 yXnFaf7wWzc0Zi8OWb7Y9r9m+/x3ayB6BYkyhdetmpLdssnT1OdBrgSR4KrknOqpJ+QOMa4WAgm
 mzZ4tIfQk0MV0UMVNfqlT1EJbSUWEWu233yFgsFGHtUZeb6pZ7G4OGRkj1Tm3mOUt5IVCFwJfSg
 NfAgi3beDTtfN2oGe4U4a5oaO/XSgsP78IekI2izXqvswPXzEEKuHSszkXg==
X-Received: by 2002:a05:6214:398f:b0:89e:d062:47c with SMTP id
 6a1803df08f44-8b0287aebf5mr365646276d6.32.1776969875647; 
 Thu, 23 Apr 2026 11:44:35 -0700 (PDT)
X-Received: by 2002:a05:6214:398f:b0:89e:d062:47c with SMTP id
 6a1803df08f44-8b0287aebf5mr365645886d6.32.1776969875089; 
 Thu, 23 Apr 2026 11:44:35 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac42b3bsm158932726d6.5.2026.04.23.11.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 11:44:34 -0700 (PDT)
Date: Thu, 23 Apr 2026 14:44:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] migration/multifd: fix channel count TOCTOU race on
 cancel and retry
Message-ID: <aepokJ2N1w7fA2Ye@x1.local>
References: <20260422161202.34150-1-viking4@gmail.com>
 <20260422161202.34150-2-viking4@gmail.com> <87o6jaeig8.fsf@suse.de>
 <aepFf11lBgdXK6CB@x1.local> <87ik9hee95.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ik9hee95.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 23, 2026 at 03:13:42PM -0300, Fabiano Rosas wrote:
> Looking again at this argument I put (too many variables), I notice we
> also have multifd_send_state->channels_ready and

channels_ready seems to be special?  In busy systems I think it should
normally always be less than the number of threads on sender side, because
some of them will be busy.

> multifd_recv_state->count, both of which should contain the right number

This one is used so far to just count how many channels are established on
dest side.  Logically after setup phase it can be gone.  It's just not hurt
to be available until cleanups.

> of channels after multifd_send_setup() and migration_start_incoming(),
> respectively. Maybe we could unify all of this into a single semaphore
> used in both sides and take the semaphore count as number of
> channels. @Peter, do you think it's worth it?

My memory is reading counter from a sem isn't always reliable.  I always
only use sem as thread-safety purpose primitives.

So if I was correct on channels_ready above, then it may not apply on the
idea to merge.  We're essentially trying to save one 8B for ->count.. and
it can only be gone after it's finished its use (IOW, we still need it to
work before recv side setup).

Just leave them as-is?

-- 
Peter Xu



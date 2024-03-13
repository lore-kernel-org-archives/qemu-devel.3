Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922A8C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 17:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkSGj-0002Vs-J4; Wed, 13 Mar 2024 13:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rkSGh-0002RN-9a
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 13:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rkSGe-0004e4-Cl
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 13:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710350390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FvFqmJowF+xbYcG23Pa1IXjsAsfx/5HqCWt+Tio9V4A=;
 b=Fn0sS/XIHk+NSlU0SS9AFe3xG+fl363mKLM336UpWE5GAjz9U2LWIjw36iuvGJJ/Ri1RDF
 CXxD4O2lZI5yZGmnuylaWn3F7nXAV/Ke4zdXx7c3yncS/WZCBANzbVvLE9Yh6KLgcSxDmV
 i4bcWmRhR72ygaBVs3d4c2eqAgTJxjk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-i75A9pkRMumCMK3wGcmzCQ-1; Wed, 13 Mar 2024 13:19:48 -0400
X-MC-Unique: i75A9pkRMumCMK3wGcmzCQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33e79d3f462so6947f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 10:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710350387; x=1710955187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FvFqmJowF+xbYcG23Pa1IXjsAsfx/5HqCWt+Tio9V4A=;
 b=BJz6iLykk1KKjiqAjEQiE5EFsoOMpba2Yaj/Z+HoeIJ6rfGxgSCeEZ609RhASkX3J1
 cbBlbYBm3ZEUvCpWhy8pd6g0ZNAte3D88woAq93v3t8lca96yNWh0JLojcc/633SuFvj
 KEuh7LPSKGvj/f5l5ZV8tzJxPySFt3BFgGmnNbGLm5YlwMOwx5FBVbAyLLJGnKq7yYJW
 4eHLHydTAdKf7SrK5ffFi9v1HPm+1obtWCNbBtZcHHsAZNoQjyG+/Kc6vmVxV+yQvgkF
 NL+1L9f28kh7A8OIuA29BUjdAY9bShZ+IAXK4yPBeoIc5rQnaBPLDkxfEvqSOMZE/vF2
 1atA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeGjfDfpTmPy9OZMGenOhrb2ORQ/9/IZZ73O78vvd58CXmAbA3JCRrZBgwX6oUDfPUXBltjHlejFNaVOIXaxHdl6pXSBM=
X-Gm-Message-State: AOJu0Yyi9xTxEpzgrW6mmmXmGTaBmNcHL4E+QK00XrxrmNr+Zdt6m5Id
 G0vq0fxreTWw1WqaXtvwHra8nH/kPd6QOChptEtZPn9oSiXK8xrBrKLIwre3V1LsltCuTdMFdM7
 8nTDgh5IsEnGnEz0vQFsMu8f8OhxhVi8inhARKqd4vqQVTDIu8DsYkKHlJTEQ5DzNIjXPciYHhV
 GTBM31lEH58Sm0ePAYIs3DHsPnwGE=
X-Received: by 2002:adf:e6cf:0:b0:33d:c5b5:5796 with SMTP id
 y15-20020adfe6cf000000b0033dc5b55796mr2241012wrm.22.1710350387639; 
 Wed, 13 Mar 2024 10:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSM2Grza5I4H3Kti5+u0SVlJ60ibahU9D7CKsQlygWba6RQu10C+RoM+XEmOsAcQM6PoQei4iMme94cVa9rd0=
X-Received: by 2002:adf:e6cf:0:b0:33d:c5b5:5796 with SMTP id
 y15-20020adfe6cf000000b0033dc5b55796mr2240999wrm.22.1710350387313; Wed, 13
 Mar 2024 10:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240313084935.1412274-1-ppandit@redhat.com>
 <20240313151839.GA545171@fedora>
In-Reply-To: <20240313151839.GA545171@fedora>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 13 Mar 2024 22:49:31 +0530
Message-ID: <CAE8KmOy7Lj1tJ2mNTA3rEOoFEzCW+x1O-NrP+7Xy6hhoedH3EA@mail.gmail.com>
Subject: Re: [PATCH v3] linux-aio: add IO_CMD_FDSYNC command support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 mtosatti@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 13 Mar 2024 at 20:48, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > +extern bool laio_has_fdsync(int);
> Please declare this in include/block/raw-aio.h alongside the other laio APIs.
>
> FDSYNC support should be probed at open() time and the result should be
> stored in a new bool field like s->laio_supports_fdsync. That way the
> cost of laio_has_fdsync() on every flush request is avoided.

* Okay. Here 's' is a BDRVRawState object and file open seems to
happen in the raw_open_common() function? I'll move the
laio_has_fdsync() call there and see how it works.

Thank you.
---
  - Prasad



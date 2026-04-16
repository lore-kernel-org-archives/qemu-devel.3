Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F39CF8A16F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDMPR-00020S-Rq; Thu, 16 Apr 2026 09:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDMPQ-0001zR-62
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 09:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDMPL-00055f-TE
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 09:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776344720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7JsCJPKfXxxtQPXE9OV3XBcMz9VeFWGPz3q4hIelfc=;
 b=LawY1ofrLRzQz5T6ELKysSFjjtgdkYJ78uW9YJuWyedrCrIBFfB/KMWJGY7rSzja1Y0kQw
 AA+aNNOiIV93EWq4IFsCtUJFc0IDRMOxi8ytk64rZbZ1Nn6vUYRA8kR7JJyfyAfCBgOv3O
 ytozeFyCcXtTRq4ld5RQ6FuZyfpxUaU=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-qHkPtQm_NvKZ2j7PhkQ89Q-1; Thu, 16 Apr 2026 09:05:18 -0400
X-MC-Unique: qHkPtQm_NvKZ2j7PhkQ89Q-1
X-Mimecast-MFC-AGG-ID: qHkPtQm_NvKZ2j7PhkQ89Q_1776344717
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c283a1212so8329217c88.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 06:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776344717; x=1776949517; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d7JsCJPKfXxxtQPXE9OV3XBcMz9VeFWGPz3q4hIelfc=;
 b=EVm9LQq4EWuHHINXZUjV5DYI6FCpy+boLWnT7rSV5pnK9WRH7EWNfFBCFm8XNe+W+z
 LgAX81irqXx8yPJLMVIEiwmLc6FXvHELVunGykGWUxVUwEJhMCT/e8GbJrTGsrP03+ou
 70dBdHY2RfCqzjdXt9c1EjXgdSMsKmwkQ/oZaKL/cS0mDwsJcMz/gCHfE51Ypbnmtk8U
 16jXJ67ZLLU8I38jeUQGnzbI/In8gfjgSCZDoAPCu3FNJwEDd7PdGCZmfffWFsQ0LaFl
 EU5gLIilHTz58B8ToNwE+/EX5oyv1DFMTGRrXmnutnPXTR6enFRmOfR07WnDtdsjtciZ
 KsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776344717; x=1776949517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7JsCJPKfXxxtQPXE9OV3XBcMz9VeFWGPz3q4hIelfc=;
 b=iwi4xn99OiBla9K2thCUrNFOmq7C2rGhfdywM8Ca/mjeFdS4hKdcHJXi1U91UbCvNu
 dBn0Y4Cg3Nc0d8FVDO2uf/DoARmnm7kZuBBoIWBIvVTLZzCZDKqPjAVSCCSuC0Ax7UIa
 oEUwWFT9HjLYg14F0lMYfva25FQ29Sg4PcibmjAi94hgdmqAAItrPxbVgVdJ2DymGEtr
 lIssqgvfOIlh1cJSLjQlK7zRbGHUV+IvPPwl+BKpBy6cOzItZih6cVW91xCBSCUjvhj1
 NLiHMkjTIr2NxW33RKxUmr2ecmkFeYdLxO60OLu6RiZF1+AjV46c5eVEZyNgwKW6JPmc
 +mtg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GXjCk66PiLHcjbXnNOs7L2xDiZQixWxB5wB2y34wHvTrG+jmr3R2VxTGjgkba3Qkuha1iJJ2sF345@nongnu.org
X-Gm-Message-State: AOJu0YzBe1I6iYc4rDcVZeAKHpKLjuFx/hINpewij1JbCOiYFgHsSPJH
 mONrBPbjRrB+SAggDl8V1nRFYJWsdCeHynXQykUQIMMeByJVIlHqx51BVrPrEM4TMlXs7eAmbs3
 Pwltsh7IPq9wXQvFcsgtKx+o2Y354zH0//tOUmBAg9su/VYACizyP8qJG
X-Gm-Gg: AeBDies3CZQ/SlLHBy3xZtRS5wkxmbXtKZkybnFbHj9VHJrwOiHUpL7Q8jwiXSWNIb8
 bZiIK6fHfgBDXWqJKM+0q/XRxmow77bEbBTcpBIklekCyjliOOVwz6Awjbo6RbIBW3J/U89N27R
 CIuuIrNzTssdy9vY6jXHQYfq5LH0ji4BlEI46vj5nz6PVUCTOIvW2KgPfD21UV7Jjqy7FQY1e3B
 mIgjf2afwPihFXx74fYWCGdKKIgLJOp61Djxx7ckkAt4hlD1U0JhMdGLl1Pyu4+kqG8GO7WgV9S
 lJzYFDZSE4ajt4TdDgd7rCupWwVAmOdkBorgkVoPX0OZhtVV204UHmBFEyW4fTgwww0bHL/9pxP
 88t2AWEuLTl80qO8OlxisWYyWJQ7yalQziVIycmXla/5XZWcHAq4/9s/lag==
X-Received: by 2002:a05:7022:2581:b0:12b:ec96:c936 with SMTP id
 a92af1059eb24-12c34eab249mr15648221c88.14.1776344716939; 
 Thu, 16 Apr 2026 06:05:16 -0700 (PDT)
X-Received: by 2002:a05:7022:2581:b0:12b:ec96:c936 with SMTP id
 a92af1059eb24-12c34eab249mr15648132c88.14.1776344715968; 
 Thu, 16 Apr 2026 06:05:15 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e25888c19sm19582701cf.7.2026.04.16.06.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:05:15 -0700 (PDT)
Date: Thu, 16 Apr 2026 09:05:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v1] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
Message-ID: <aeDeig7styFZanf2@x1.local>
References: <20260414223718.23965-1-farosas@suse.de> <87zf34xp7k.fsf@suse.de>
 <CAFEAcA8dwXxFodsg6gk473aEWBXynFAwaohrMqY3ca5c4FxzMw@mail.gmail.com>
 <87wly7xfko.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wly7xfko.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

On Thu, Apr 16, 2026 at 09:19:51AM -0300, Fabiano Rosas wrote:
> @Peter Xu, do you agree with leaving this to stable? Given that
> it needs multifd and zero-copy-send to be both set, I'd say it doesn't
> have that large of a user base.

Yes.

-- 
Peter Xu



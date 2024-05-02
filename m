Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC1DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Y9B-0004cx-B4; Thu, 02 May 2024 11:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Y96-0004bs-US
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Y91-0002v1-Mh
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714662886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EJTQqWPOyJ8sDHL5pJBbP32cGnX19o1HvB+FiO+etWQ=;
 b=FeVnWFhWhw36eXupDB2fU+M4HH/vgFwWzNy9vmnOXtgtPvWllxsjGCZZHpeAdDPyXidsOl
 vPFpktkBzGUka0lWv3gYShkOweGm8ivE1PejT/MwMl2Rm6uQd8flWOie7cK0yGJkm9Esnf
 UnM7fEmFYy2p072qoiUYYXHRaUkwBK0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-jIkovUhYO9O4JSuZrADi_Q-1; Thu, 02 May 2024 11:14:44 -0400
X-MC-Unique: jIkovUhYO9O4JSuZrADi_Q-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-437618f53f0so15046941cf.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714662884; x=1715267684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJTQqWPOyJ8sDHL5pJBbP32cGnX19o1HvB+FiO+etWQ=;
 b=bxcA/75ZAG6ibbEmmb8NQQNnUYsJPpTEPavRQLlsbpg62+Yfrxb3DzaZIVtVNqE1SH
 BWTy7AoZwiWMhLVhKCbSr7yt2bXVG5JCwUVX3kAdgONvNS7LyRp/rCRflDN6BEWAgEKx
 yuZefLMbHEJQBQjwxjhM2OxahXPO+RwMjnl/Nw87FxyBnblTWlzD1lLxSOtTo8Nc2Z/A
 rawu7h8I0IfyTdpYdHzAoYCVur1Jk+WN4DcWNrC2GhHtbqishbuoXtW/uI73l8l8hinl
 +Cvhvln8bFdeoK6NpPK/IULUb8GdiylDIsWmgnFLhpm62B17GjxAzDuTa3z3JSsRoA0f
 0DDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsvYe9K8KGi4qmUvXKJs3JF8WWKoSO8pc16Iaarq7eYy7JnYPK4ckzOYOyYNy+SlLFlg8OmgWAmvzrig+yNfAEVBBw7MU=
X-Gm-Message-State: AOJu0YykOrdV/g9xVjGmz271fSagazuYMvrAPVnf+xswDVRNV4S6f2qQ
 sqHKxxQ6wXrJRYG9jaQeRLMSSPVSUJYG4Y4dyE4oa4PzS1QRO1XbnNImz2TPzcto1FHAs/JoqNW
 lqDVQGoA5vcv0bQkOxQosr4zthzmhu13w1VRNGI3IJXYlm8PmEsQO
X-Received: by 2002:a05:622a:1a0a:b0:43a:88bd:c0f3 with SMTP id
 f10-20020a05622a1a0a00b0043a88bdc0f3mr6513166qtb.3.1714662884020; 
 Thu, 02 May 2024 08:14:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO/HFSTpg2dQrO9eiTKSsX6gfYDMlmdUCrXdogqJ47pPaNxPj4cpXT5wXOAtzxVYXGptzHyA==
X-Received: by 2002:a05:622a:1a0a:b0:43a:88bd:c0f3 with SMTP id
 f10-20020a05622a1a0a00b0043a88bdc0f3mr6513106qtb.3.1714662883220; 
 Thu, 02 May 2024 08:14:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ep12-20020a05622a548c00b0043718ece8dfsm559876qtb.12.2024.05.02.08.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:14:42 -0700 (PDT)
Date: Thu, 2 May 2024 11:14:41 -0400
From: Peter Xu <peterx@redhat.com>
To: John Levon <levon@movementarian.org>
Cc: Mattias Nissler <mnissler@rivosinc.com>, stefanha@redhat.com,
 jag.raman@oracle.com, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 0/5] Support message-based DMA in vfio-user server
Message-ID: <ZjOt4dDzNXTtn8Yp@x1n>
References: <20231101131611.775299-1-mnissler@rivosinc.com>
 <ZjOp1X40WuhKo+bl@movementarian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjOp1X40WuhKo+bl@movementarian.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 02, 2024 at 03:57:25PM +0100, John Levon wrote:
> On Wed, Nov 01, 2023 at 06:16:06AM -0700, Mattias Nissler wrote:
> 
> > This series adds basic support for message-based DMA in qemu's vfio-user
> 
> Now qemu 9.0 is out, any reason not to get this series merged?

It looks like all patches are properly reviewed with at least 1 ACK, and it
looks all reasonable and useful to me.

I can send a pull for this one.  I'll hold off until next Monday to wait
for a final round of objections or comments.  I hope everyone is in the loop.

Btw, this is an old version, the target is v8.

https://lore.kernel.org/r/20240304100554.1143763-1-mnissler@rivosinc.com

Thanks,

-- 
Peter Xu



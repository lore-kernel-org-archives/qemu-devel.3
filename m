Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B528AEE6B44
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPow-0006KX-MY; Fri, 06 Feb 2026 12:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1voPou-0006KM-4G
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1voPos-0003HX-Os
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770399637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XdeClNjq9LetIXgeKDx3OeuX8LTmHjrxge8D5Ngd2zo=;
 b=PCxn2DCZSRYPeTWzP+AFCXNL6sQM7wxTS5vrI/WfOtWDiNnLGwkHyLiBuED+IUKLPy7eeD
 5XU0v1/cUi71JUmPIe5qIqmFTHngpfM/MUAt4rU+Rc+CTClAUnOOyUZazUtABgnxlAXQqn
 gHkpi7WxC8cVDOEt535wrWNaCBR+FJo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-9C8B7nYqONiaM8oQSXUp9w-1; Fri, 06 Feb 2026 12:40:36 -0500
X-MC-Unique: 9C8B7nYqONiaM8oQSXUp9w-1
X-Mimecast-MFC-AGG-ID: 9C8B7nYqONiaM8oQSXUp9w_1770399635
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c538971a16so600750885a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770399635; x=1771004435; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XdeClNjq9LetIXgeKDx3OeuX8LTmHjrxge8D5Ngd2zo=;
 b=K8vP9HRje2Vg4Or5dhEfNqpnQoXFmt582dPwjhHWRn87FUvVMcXws5yKKt5SYqVLhI
 9xORKJIcxW3lo/Z5bdcbiKm9fAIrpfWKVZhDCPj2rFq33uHsTtWn55SUhxTbR9TUwMjg
 JsOK3zh14fpsJKfWZVUi1pZtUtBmtyvpUYoGHCGDMKDAQesVQ3oGmkKGOMhkrcVrnYUX
 miLcKSfvbYquyVTcQIXyi76QUeS+dRaUOoUO111hokykSecdJF7oHfl7K9Z+xhy7FTfr
 R6i9fSe6AJxs5ipKeOiokWYMlnwjhuXHhMXnXdGMy8hNswV9MNJP4g0yYghpFgp0jKOj
 6Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770399635; x=1771004435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XdeClNjq9LetIXgeKDx3OeuX8LTmHjrxge8D5Ngd2zo=;
 b=vIO93FFkRqIBDSlqpvPRN/31b529D/000zMJv3EpceqDYPIauKvuMMQjPEQIlUD6AL
 I/4wi2L9t8bD5sNeSMYBVaX3EulDF/MdzO/IghpSymFLrfM8gPYKDvsz+l0/yFIbOTaL
 +yGUY+0903fJSqV2f2Hi9+ZLzALXOQa67X10au1JzbVR3us4a8jML6Mzz7RCKVnLKUpY
 zbtt2h3/skmw7lkZ30672T1+9me+HLchSXaqjazFeMmnPCx3jCkZxVT3Dh2Fo1UzJXzM
 g9eKqHsJzRLiYurD73GQh3Qsq1R4zE2cXqAJ+A6QnToCkPH5yq4dcvrCb+qw3c6W3zXY
 +72w==
X-Gm-Message-State: AOJu0YwOhysnrY22Yw1wO7iPxl/sBX9cPXJ/nVWHvscoF43B/TGj+z0k
 MSwR3BpHoXpgo+CVMU+P0UZHzZwQmrOyea/uqVu2ig4Xhj9PgFBnlmLwNIxB3takfJ031ZnNP7+
 V6fEK0dMwHc84JLOPzL6YgvCLJxrIGu3tOB5k5JbyAqcwq145epQ8xCwM
X-Gm-Gg: AZuq6aKiqoXYg6QqS3nzYTuaYbKoJxiriNzLfrae+rLSoJhRpFDeIS1qkvFWa5m5x6M
 wPpx4p8TEMnjxjBKbxr3qDiIxVGbekj2VcyVM1kpUQS8xZASQ/VKiV8TirTmvE6rRO/k7oKDRaE
 10kBOgnkys6MVTEWi4ckURi8ZU4ESm+JO50qxmnbu9nsfJPfqhcHVx8jFXWweO6kyUY+uImC/zU
 RD0enC4n5IoH2yPpKSXf+hGl5Ygg1fD9jyfotOgWRQB1C/1JWeak3QN0qIFMznOuvZuHBV6SotU
 7vkvQdmngPDsR4l9x6F4k/89V0rvY9w6CGVe2axZBOiM5kjT+zfFrNImQdumAW91sEJx3vASKLS
 OOss=
X-Received: by 2002:a05:620a:270c:b0:8ca:3c67:891d with SMTP id
 af79cd13be357-8caf1accd34mr460554185a.54.1770399635367; 
 Fri, 06 Feb 2026 09:40:35 -0800 (PST)
X-Received: by 2002:a05:620a:270c:b0:8ca:3c67:891d with SMTP id
 af79cd13be357-8caf1accd34mr460551385a.54.1770399634904; 
 Fri, 06 Feb 2026 09:40:34 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf7aedaf7sm191145285a.15.2026.02.06.09.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 09:40:34 -0800 (PST)
Date: Fri, 6 Feb 2026 12:40:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 0/9] qapi: Use visitors for migration parameters
 handling
Message-ID: <aYYnkdCZVUD7NEKu@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <aYUUQ5sAiwR-nvul@x1.local> <877bsqqce3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bsqqce3.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Feb 06, 2026 at 09:34:12AM -0300, Fabiano Rosas wrote:
> Or we make set-parameters always work on top of temporary
> MigrationParameter objects and switch the pointer atomically. Might be a
> good idea regardless.

Currently I recall you mentioned the parameters struct can't be an pointer,
so maybe there's some challenge there on making it atomic.  But yeah, I
know you'll figure things out! :-D

-- 
Peter Xu



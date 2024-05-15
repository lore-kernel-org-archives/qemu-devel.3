Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5CAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HAm-0005rx-RN; Wed, 15 May 2024 12:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s7HAX-0005rI-HH
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s7HAT-0001J3-BD
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715789267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y00VFhqWJNQF+pmKiW1gnxYds4bcdl47ZbEAmoE4lHU=;
 b=MWAAKTBUbgvTtxonaYNM9DPnLD1WMPBJHzbrRz18HsM1hluiJ1a+YHDh4B4TkVTPCgsy5H
 RFY4eAJEb7wuPTB8r1l6R2KNpbXdpd+yeXLxoOdob7Vko2X3ZrgWghg08MUbF77B75gq6z
 s70bEwDep908CJORftxrIRqdr6hdT/I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-HNAfiC9BOaeEC1Qo51i67Q-1; Wed, 15 May 2024 12:07:46 -0400
X-MC-Unique: HNAfiC9BOaeEC1Qo51i67Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2b9de4a4757so260658a91.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715789265; x=1716394065;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y00VFhqWJNQF+pmKiW1gnxYds4bcdl47ZbEAmoE4lHU=;
 b=l7BD3wNyv8OmGEBHtlQilJ4YlFD4TboAdHhHl+/BKOGZ6yJ9s8q8VueL7048gOtYGf
 97hmMiqVa4IRfongThZpq85b1nmRDhPwrWYAS2CGke3wpETHK+7s7B8gLjQRIPZs5/OI
 zSA8w80Xx7AOLxXssW0qRgnkjtIbULDAEE8LGftof+G8ocYpBj/VHkGNRT387A6wG86N
 HmflmAGjCfi3Xql+qIQg0bIhiyUNkz2AFd/KonYMInjLB6zH0lwheSdoImdwVDKzWwdF
 djHs/U1uHFha6NIZGTzPBziy2iZ+jFJtw1N3lZRFYbeqYrfNKsbchF+za/hUKpTw9snW
 +u9w==
X-Gm-Message-State: AOJu0YyDXmFZTxTGU9Zk/K1ubyIuW/729DMkyRa9jemoGXLzkjoEY335
 garLLkkYlFLBkUfFQg8GWPTaVZ0xYIxnLKZPGmA7eQKblHlxFhgVbCxny1eW+ujGP0QbZ4Z7zOC
 j8ukK+0G2YxYhiGbWGuOZz1LKgZ65oZndIggWNvRCJnk4vXFqnBRG
X-Received: by 2002:a17:90a:f10d:b0:2b2:916d:d89b with SMTP id
 98e67ed59e1d1-2b6cb7c7dc7mr15200412a91.0.1715789265091; 
 Wed, 15 May 2024 09:07:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfGl7QBuhQwPQN/ErKvyCDFU401M0tFCAmNQZ67P6BdiEBFW+NZOMbBW0qyGLJXffXYB5R9Q==
X-Received: by 2002:a17:90a:f10d:b0:2b2:916d:d89b with SMTP id
 98e67ed59e1d1-2b6cb7c7dc7mr15200355a91.0.1715789264389; 
 Wed, 15 May 2024 09:07:44 -0700 (PDT)
Received: from x1n ([50.204.89.32]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b67126ad51sm11931271a91.25.2024.05.15.09.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 09:07:43 -0700 (PDT)
Date: Wed, 15 May 2024 10:07:31 -0600
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 0/5] Fix "virtio-gpu: fix scanout migration post-load"
Message-ID: <ZkTdwyxWcTTMwtAp@x1n>
References: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On Wed, May 15, 2024 at 06:15:51PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> The aforementioned patch breaks virtio-gpu device migrations for versions
> pre-9.0/9.0, both forwards and backwards. Versioning of `VMS_STRUCT` is more
> complex than it may initially appear, as evidenced in the problematic commit
> dfcf74fa68c ("virtio-gpu: fix scanout migration post-load").
> 
> v2:
>  - use a manual version field test (instead of the more complex struct variant)
> 
> v3:
>  - introduce machine_check_version()
>  - drop the VMSD version, and use machine version field test

Thanks for trying this out already.

Last time I mentioned this may for the long term because I remember Dan and
Thomas were trying to work on some machine deprecation work, and maybe such
things may collapse with that work (and perhaps easier with that work
landed, too?).  Just to copy them both here so we know where we are now, as
I didn't follow that discussion.  IOW, patch 3/4 may need separate review
from outside migration..

The simpler solution is we stick with the customized field and simple fix
to the issue first, then whenever we have that new helper later we simply
use the new helper to replace the old, alongside we can drop the new field
/ property too as long as it is declared with "x-".  Might be easier to
backport too in this case.  Marc-Andre, what do you think?

Thanks,

-- 
Peter Xu



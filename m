Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03489C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRvEJ-0005wq-F7; Thu, 11 Jul 2024 10:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRvEH-0005tJ-Pm
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRvEF-0003Lj-Rw
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720709822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pSNyp73GmX9Gq/1KPcyC9EzhdSEJsuAvEbc9Y4aVRLw=;
 b=QtsXcFdCvqo3ZYFJOAvofVsDCXKWwV5twg29iyHiV3+r9+NDShBJsevAksGj4C6Zkz8ykv
 Qjk6gmjUdvjVqVbLe+E6r21XFtPQz7lumCGDdCbjGSQ3cHMAgGc4oOxZhdJG2aXfFgrWw6
 ovTg10TWipYp22p/dwoY5xjTTKQXxFg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-CA7wFcS5N8KwtR6sOZiDIw-1; Thu, 11 Jul 2024 10:56:59 -0400
X-MC-Unique: CA7wFcS5N8KwtR6sOZiDIw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-79f069f41efso16543085a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 07:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720709819; x=1721314619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSNyp73GmX9Gq/1KPcyC9EzhdSEJsuAvEbc9Y4aVRLw=;
 b=M4koYsROq1I30jhhAjURzAkb4W+UO5bwaO01fb3dBR4+aQb+cLypaRH1tWYwIA+qLA
 Hc1WkOn91KtQSRy16OoH+D+HdxjS+q9s6mhb7qkSniiJLS7u7yPoBmMjwVzdq7HFkH7k
 CvS3iYDOEsSEnfO+4fhh0NUyLjrLyfdBW2R91pjZqoUdGEa8bvBkhYtgU/bVOCNLU2iA
 /JhfyxvmjGdjnjd6Xg57sqgdW1TUVOL4Ef9QXxbDhcjrl254WP2rdN/6q9DM+QPzC3IU
 Z9vfMaWzB6VWxq++snZccCGeBY2vvQUpZWJJAzz0Ht+W4Lk3N2sD0M7J8cnJemrrhcow
 AFUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgYgo0I4UzVC6hcpqEZ47WYi1rX97f/hRzrPmjPJv+zKRyWoOC2YPFuhDW17DpuflkTRif06fXo7PxsKTM/wZr2lH6J0Y=
X-Gm-Message-State: AOJu0Yy4K0B6n/8vCEeCpW46Nz1DX8KNk/xxDhknWfWPECk/Ae03jg3F
 +Yq4t9febYFB4Q7qd1XWJTQq0vrRPEiN8N9HBA8EYhfwwm7XgzQeSZmDRfDOB7u6knnQLpAtx55
 s4bNa9vjnMT5ctFQMEdlcM+hVNsohQ/eOfR7oHQmSQRP7fQEAYH9t
X-Received: by 2002:a05:620a:458e:b0:79e:fc9c:4bc2 with SMTP id
 af79cd13be357-7a1471c8a6bmr357065485a.4.1720709818948; 
 Thu, 11 Jul 2024 07:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH96ZJC3FDXTzAr0cc+EC+TueC8Cdq/LTSBJFz9urp5wT01Tiu+aOecH8PP4ipyYgdgRXayRQ==
X-Received: by 2002:a05:620a:458e:b0:79e:fc9c:4bc2 with SMTP id
 af79cd13be357-7a1471c8a6bmr357063185a.4.1720709818621; 
 Thu, 11 Jul 2024 07:56:58 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f19028ab0sm298959685a.64.2024.07.11.07.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:56:58 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:56:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Bin Meng <bmeng.cn@gmail.com>,
 Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, devel@lists.libvirt.org,
 Luc Michel <luc.michel@amd.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 06/17] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
Message-ID: <Zo_yuMfEmg0W1msP@x1n>
References: <Zo6iZjc8YpI1_9dW@x1n> <874j8xfc9s.fsf@suse.de>
 <Zo7dcF8OKfH92RlR@x1n> <871q41f2pk.fsf@suse.de>
 <Zo7rCXtap2lWd4IB@x1n> <87ttgxdj1p.fsf@suse.de>
 <Zo8F4Gq4f7SawaDc@x1n> <87plrkdpd7.fsf@suse.de>
 <Zo_n39Vusyy-O_48@x1n> <87h6cwdm4n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6cwdm4n.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 11, 2024 at 11:44:08AM -0300, Fabiano Rosas wrote:
> But of course, that means we cannot claim to support all kinds of
> forward migrations anymore. Only those in the 6 year period.

That "6 years" comes from machine type deprecation period, and migration
compatibility is mostly only attached to machine types, and we only ever
allowed migration with the same machine type.

It means, >6 years migration will never work anyway as soon as we start to
deprecate machine types (irrelevant of any reuse of UNUSED), because the >6
years machine types will simply be gone.. See configuration_post_load(),
where it'll throw an error upfront when machine type mismatched.

-- 
Peter Xu



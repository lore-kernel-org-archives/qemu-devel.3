Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D83DCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSazO-0005RW-Pd; Thu, 28 May 2026 09:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSazN-0005RI-BS
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSazL-0000To-Tl
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779975691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/PYY1+tA+DmBKcketrIi+KRx/LYAe4nCRT3MrjpT2aU=;
 b=Pp/inSj45hWg0figQVzD3Bw90TSaRizGFGjqOfJmKaUxYtQ+Fv1+I+TMvStS+KRkdYS1Xv
 aEhRMlr6dzWo+5wqRNV7Ll3mKsgecMuPvmAsiISNITfTVofpDJOQ6SH0m+e6LGDGNGDgJK
 1AEvxvYWjZdr0f81kSYeUjFNDueJ9aE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-pUpzYhsBN8m2osuks1YycA-1; Thu, 28 May 2026 09:41:29 -0400
X-MC-Unique: pUpzYhsBN8m2osuks1YycA-1
X-Mimecast-MFC-AGG-ID: pUpzYhsBN8m2osuks1YycA_1779975689
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-914b5249bf6so1290412885a.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779975689; x=1780580489; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/PYY1+tA+DmBKcketrIi+KRx/LYAe4nCRT3MrjpT2aU=;
 b=dJ9NNyAYqZiO9Z8iCldELJj9dR+hRbL9vDttk7vLKkkmNt3H4X7BYoy7JFytXfS2OF
 IYQGWj/CtpVJE5tTxpBgRZ2a7F5T8IYJ+L7bmUMvlHO8yasluscfYOkeH407/jwRNbUq
 8hdlCtaaS2QmyIO6aVo0TntuOpjKDweOqF/EjziC1Te/UMX9aNV8LsJc35R2Q36bi2hg
 u4wFVo4J5gH188XfRDoR/iB6t4fJ3rlraiO77UAG0hLZA5KUijKUqLnA1c5MBhEvwbFT
 PZ99KRA9KnV90BXVegm61XJBv/Nis2HoRTeuukq2A3QWfIaVeomF8e4WsBK/5nPpHNb+
 qYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975689; x=1780580489;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/PYY1+tA+DmBKcketrIi+KRx/LYAe4nCRT3MrjpT2aU=;
 b=r1PgifpqJK2nqs8GdH81lrDD2+BE1HHcNjAH9Z3kNb5EP2Fzvo8ZAZfuECZtoqVQQA
 R0+PpdMI7oZpqN4vcq0j8tzaJkb8DDmtJKnrw54LMSQiQPoXEW3Vm8WGu76RrBu0Cp8s
 zetO5eO9X1fT9oQgrxHNxZHxlQ5Ido1F0BObX9rsfv2Xr0XJSC+9mlevqGIYMxf+zrtx
 xYOia/E6m18dkw/QjxFblXmN9WRaZDJsl86sIm9EyumwfqiauW2Jaib9pfcG8jDbY6ZW
 kCQKm8qX1N2FG8wYokIB1MIXiPUowIYMAniqma1/jZ9Rp4a6itrtFk+UeYq3IueDfvMV
 O8hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8SDjCv+AduqyC03r1W1WMyAFau7DSKhZJK6j/r7+15y0RyFinIZSZiPFNKroU1T/bLJGl3GeOM9Plc@nongnu.org
X-Gm-Message-State: AOJu0YyrlgYMIV5nnAJ3ZFTISa2b2xq5xR0q4cRQ3E2BewYvO76IKDpN
 ac7IQhKm/ktBi6sWKY9fiHUyP0aGkP5KpVd9kkDKfA6OnroHn9Kd1IUIHh0Bb6GC/80qzewmALK
 BCt8yptFvPBjbcrItmripHbx7FIvzXsSxzbCa7HD/zDrr6gZZqppZUuoe
X-Gm-Gg: Acq92OFjFpfCjJMOWqZkgCnrI/4AqLthkgkwxL/1PHdjsr355J4tx+5w/84flyZltfw
 JiG58kFvvV4QCZh8rT891xGhGTzLY36R1+gIE4nI4hqA+FvBtmqpxdNPWCm62RaYf0/dpvsFb6A
 GkK1vOuoyjs5fYZO/d9E4Ad5xOjP73HjJKzH7hmuSDJ21kjt16DfNQui9/JMiytcHFPqxOO/6ci
 RTM6dz7oYZPKAqWPfO6qneWoudbV0NWh8GL9QPgdFXPVxOBecExytwjiv6yumaziVaiP6o+n7x8
 xFhwHRxVqDZF2oS1k8kBAnMoWyfByYBOq2FcnJQjYL5+osOQ12nJhloRYtmoeMPNNSsTJbM2vFM
 kZmbNLF0/dyX/5oZREy4teb4vNDIAlWZt24yFfBuO+qA6bC9a9EqqdflpKA==
X-Received: by 2002:a05:620a:179e:b0:914:c48c:4acf with SMTP id
 af79cd13be357-914c48c4d98mr3103722785a.4.1779975688465; 
 Thu, 28 May 2026 06:41:28 -0700 (PDT)
X-Received: by 2002:a05:620a:179e:b0:914:c48c:4acf with SMTP id
 af79cd13be357-914c48c4d98mr3103716985a.4.1779975687903; 
 Thu, 28 May 2026 06:41:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f87d1b66sm828433485a.29.2026.05.28.06.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:41:27 -0700 (PDT)
Date: Thu, 28 May 2026 09:41:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 armbru@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, berrange@redhat.com,
 pbonzini@redhat.com, yc-core@yandex-team.ru,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v16 5/8] virtio-net: support local migration of backend
Message-ID: <ahhGBuom-GTfouRA@x1.local>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
 <20260522120534.77653-6-vsementsov@yandex-team.ru>
 <20260524050632-mutt-send-email-mst@kernel.org>
 <c34e9bba-0e98-4694-870f-5f92f34f1076@yandex-team.ru>
 <ahRgbmVKuonjprB2@x1.local>
 <62045016-a892-43b8-87b1-869ef8d8e9d7@yandex-team.ru>
 <a572dadb-6ea6-48f2-a77c-3a4531dbad49@yandex-team.ru>
 <f84de0fe-8c93-4c3f-ad05-de40410b4697@yandex-team.ru>
 <ahdI7Vl5KraK566D@x1.local>
 <fb47888d-ce33-4380-a477-f17491d6c430@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb47888d-ce33-4380-a477-f17491d6c430@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, May 27, 2026 at 11:38:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 27.05.26 22:41, Peter Xu wrote:
> > Personally I liked part of your proposal.. normally I would rather leave it
> > for later, but then it means we will be stuck with this incoming-fds API.
> 
> I am OK to mark "incoming-fds" as unstable, to simplify future rework,
> if there is a good solution.

Sure, if that's unstable then it's not a concern, I also don't want to
block this series as late.  I'll see if I can prepare some RFC patches this
week or next for this as a general problem.

-- 
Peter Xu



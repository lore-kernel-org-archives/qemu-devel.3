Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9A0C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tveEj-0002Rb-2m; Fri, 21 Mar 2025 11:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tveEg-0002Qy-BY
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tveEd-0000iG-1g
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742570673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A3glv2mPpuvXqyU3d7a5LFU6KSwZeT9nfiFnJqEGRKc=;
 b=NSloIL1x3O9AraraPYCSkPQo+Q61e4afNU/asW9Pc1ENjhIORhPSHocanN5gZoWU0jxsMZ
 0CqmXk0/3dWnRsLAu0F/P6abtoOkPHpIctkuF/vFIWnlANHA3KHYgtAchMopU/hEK1WZ0X
 wPyXIhiaVkhzN05+t40g5lOyULs/Mu0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-xf5eiXKoMXOiDcluPpuQMg-1; Fri, 21 Mar 2025 11:24:28 -0400
X-MC-Unique: xf5eiXKoMXOiDcluPpuQMg-1
X-Mimecast-MFC-AGG-ID: xf5eiXKoMXOiDcluPpuQMg_1742570668
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-47693206d3bso47935951cf.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742570668; x=1743175468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3glv2mPpuvXqyU3d7a5LFU6KSwZeT9nfiFnJqEGRKc=;
 b=hKlyphMNCkr7FqZYrL+Q9PsJY1ygfTrCAi7V2II/cJpc+rsZtF7mVo+ZtPKEmpVAJN
 boahNSIpu58BALW8mjsyARS2fjAWSugO21uyZ1kK9a6czwfcVeZ+dREuhgRB9P9LQn5d
 5W13ZfC9LwP/FXUv/vYBxpL3YO8ZOm8IRetRTVQV6MG9w5Wjvo2xwcYiswMKyqGXIEa2
 /f0M1ERUiK3bss+tPSTBj2ISSGTuhOIwElQ3Z4t1UzDcRlOn/uLyjOZZiN7TD36wdJRw
 PCFbYSgyh3s/Yv+gSZs7eS91fQj/Z+KFcOIJVws4xxcRfN/HFbAjK1Opyxl234E5ys5c
 PI5Q==
X-Gm-Message-State: AOJu0Yw2P+wencgDGSQJxarFyb+MMy+ZlaePf6GvH7fnxsPKwzrgVpiR
 6wWk1Au9/O/zABVD0rm9h3jQsgQtOI9XJ1Clh/XfvDLBl5rAG5mxsT47WZJGeQsjJ/GLSWy7Gci
 OsZcZ4l5NldcgzL1yUrn6QY5n62oLeEIPKM/wGzpVGKCfX3ABl1C6
X-Gm-Gg: ASbGnct79PK0uK6rdrBQsnmNuxIF7Cc3swn+qubXPB8TWF2O+Lv9pJL7ijmkn9mcO0F
 pLTOO0fOJrIyV9gHnMyYFkA5fFcVObtjRLrkG03GhS7F0E19MO7X+HOazyN6Mhayn8sRpgZLAIW
 N4OywULNOct3DWEGPlBY6rlJWt62iqU36TwFt8Sfv0r56EVBw1/KHvHz/Hc+SRtsrzaPsWUmumM
 3vCXG7TZLMymrUROftnG7AdBmPbpdKkdA+Bm+M+HOmA3uiicU287qYSFv6qKJK3Ys+mGkY/gvfP
 PFKmFJg=
X-Received: by 2002:a05:622a:a30e:b0:477:1ee1:23d9 with SMTP id
 d75a77b69052e-4771ee124e0mr44739631cf.20.1742570667942; 
 Fri, 21 Mar 2025 08:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdGMQBeLFdjrYBZpqmynH4mdab/R8jbOiTHtbME47hNB72qCrWa4C4wU7F8eOXlkjPrYltjQ==
X-Received: by 2002:a05:622a:a30e:b0:477:1ee1:23d9 with SMTP id
 d75a77b69052e-4771ee124e0mr44739171cf.20.1742570667449; 
 Fri, 21 Mar 2025 08:24:27 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159a4dsm13076391cf.16.2025.03.21.08.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 08:24:26 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:24:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Manish <manish.mishra@nutanix.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, leobras@redhat.com,
 farosas@suse.de
Subject: Re: [PATCH v3] QIOChannelSocket: Flush zerocopy socket error queue
 on sendmsg failure due to ENOBUF
Message-ID: <Z92EoucdEiQ43BNs@x1.local>
References: <20250317015231.241141-1-manish.mishra@nutanix.com>
 <06c86fe2-3a34-4d74-9ef1-81ac220ecefe@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06c86fe2-3a34-4d74-9ef1-81ac220ecefe@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Mar 21, 2025 at 11:33:31AM +0530, Manish wrote:
> Hi Daniel, Peter,
> 
> Please let me know if this latest patch looks good?
> 
> 
> On 17/03/25 7:22 am, Manish Mishra wrote:
> > We allocate extra metadata SKBs in case of a zerocopy send. This metadata
> > memory is accounted for in the OPTMEM limit. If there is any error while
> > sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
> > queued in the socket error queue. This error queue is freed when userspace
> > reads it.
> > 
> > Usually, if there are continuous failures, we merge the metadata into a single
> > SKB and free another one. As a result, it never exceeds the OPTMEM limit.
> > However, if there is any out-of-order processing or intermittent zerocopy
> > failures, this error chain can grow significantly, exhausting the OPTMEM limit.
> > As a result, all new sendmsg requests fail to allocate any new SKB, leading to
> > an ENOBUF error. Depending on the amount of data queued before the flush
> > (i.e., large live migration iterations), even large OPTMEM limits are prone to
> > failure.
> > 
> > To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
> > we flush the error queue and retry once more.
> > 
> > V2:
> >    1. Removed the dirty_sync_missed_zero_copy migration stat.
> >    2. Made the call to qio_channel_socket_flush_internal() from
> >       qio_channel_socket_writev() non-blocking.
> > 
> > V3:
> >    1. Add the dirty_sync_missed_zero_copy migration stat again.
> > 
> > Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>

I have an old comment which could still apply here:

https://lore.kernel.org/all/Z885hS6QmGOZYj7N@x1.local/

That's on s/zero_copy_flush_pending/zerocopy_flush_once/.

But no need to repost only for that.. that's more or less a nitpick.  It's
unfortunate we need to keep the ABI and the complexity even if the counter
almost means nothing solid..

The change overall looks good here.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu



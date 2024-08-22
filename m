Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662E5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 14:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh8qA-00070f-FZ; Thu, 22 Aug 2024 10:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sh8q1-000702-V6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sh8pz-00082W-9C
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724337047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Lbp0jQmm3CAYmGiQxNSrLcHoz+nbe6jE8W9k1lLcUo=;
 b=BfXODju46JGSZ1ZNQrRUnWm7qh8WwOLA2SwJs/rXmCc+OwfdKJUlc2xiikDMn3+3npwUHA
 mMg86SynvD1dsTlxIqIdvFUCkfDj8UkxsGpq2JDYDl6CINsAbz4VY+HQnj9dLtR66yyBt1
 FdE2NtWQCUiLViLJgyMjfW6k+Ym/F4c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-NiICZizLMdiAZE52oI9uCw-1; Thu, 22 Aug 2024 10:30:45 -0400
X-MC-Unique: NiICZizLMdiAZE52oI9uCw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6bf6c0f0634so10925846d6.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 07:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724337045; x=1724941845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Lbp0jQmm3CAYmGiQxNSrLcHoz+nbe6jE8W9k1lLcUo=;
 b=tVJXKmnKmeGZQtgChSCKJhiSi3LRQ5EWBJNBg3g3HYNoicDwdX/z5LshXkicKNxOUY
 OyqgU6GJIL3X0R6JcxGReqtakrcEf47jewJOX7LeZJa1PSFyBCvlBKg0XghFlfCiw/+s
 zuO6RIhWeCo19DlUiGydRPwFopRSPMdXcT6DMiWgMPTf3TddMz1+8KVC/btUu3Qlyz/+
 Hq6JqKC5PhBdRfEXfT/QG0XeNyIQtLU8dWmJoYMA/ZWt72WA+ZqoxRNWnOcSrOrYlkI8
 gIi2xYWo6DhpBfE5XcJWWMdW+uUH/3x94qy+So+HGeTHRL9ZGv3Xg6xvZrOpxP8SzVlX
 cYow==
X-Gm-Message-State: AOJu0YzHaYwUYQt4jKsYy96c5DaQijKGVxiIXfldEW7zDhiADdax3sZT
 REEo/9BXQFSASl187CdNAUid0xz9GCnDpbFjjElerzGHWkQUii6HdKxZODOZvIbnYkNV3eS1J+p
 iTJTgG+KCsPJ3vhVt6PtwPKHhOh5mqBJICkbDj2usWFOHq+W90hYs
X-Received: by 2002:a05:6214:3286:b0:6bf:8339:95a0 with SMTP id
 6a1803df08f44-6c164704cf2mr24109266d6.9.1724337045312; 
 Thu, 22 Aug 2024 07:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1O8KBBtrQuVaH7A275DyrQYbTCDRcR8mT8Su36Qn2J+S0F/qWY1WkLjFD79H1n2qAJZswGQ==
X-Received: by 2002:a05:6214:3286:b0:6bf:8339:95a0 with SMTP id
 6a1803df08f44-6c164704cf2mr24108866d6.9.1724337044822; 
 Thu, 22 Aug 2024 07:30:44 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d796d9sm8057676d6.71.2024.08.22.07.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 07:30:43 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:30:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 09/14] migration/multifd: Isolate ram pages packet data
Message-ID: <ZsdLkYeoWO1p6YNy@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-10-farosas@suse.de> <ZsZeUpuZuhbD60YZ@x1n>
 <87zfp4y7an.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfp4y7an.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 22, 2024 at 11:13:36AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Aug 01, 2024 at 09:35:11AM -0300, Fabiano Rosas wrote:
> >> @@ -1554,7 +1577,6 @@ static void *multifd_recv_thread(void *opaque)
> >>                  qemu_sem_wait(&p->sem_sync);
> >>              }
> >>          } else {
> >> -            p->total_normal_pages += p->data->size / qemu_target_page_size();
> >
> > Is this line dropped by accident?
> >
> 
> No, this was just used in the tracepoint below. I stopped including this
> information there.

But this will cause socket / file paths not doing the same thing, since
this counter should still be increamented in socket path (and this is the
file path).

Either we keep it the same as before, or.. if we want to drop it, shouldn't
we remove all instead (along with the two variables "total_normal_pages /
total_zero_pages")?

-- 
Peter Xu



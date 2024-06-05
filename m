Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A5EC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErM4-0000KA-W0; Wed, 05 Jun 2024 10:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sErM4-0000Jy-37
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sErM2-00046O-1w
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717596664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PfMbGvgqLy7ZjhTkpdgM02AGgTLk4BVoGLpbO23Gi7w=;
 b=OW3qmlkhfwLNaLUuaQjsKQdktYIhDmzgC0v3+4vQVB7qvEZIuHgr5VHE3roirT8ZrLKY9Q
 bJVP+ngKZ06DczT57CwEQ1j/uzofDd4mGm/CmYoAq6AYh/tnNgWeKQRK6DcaM4wx5e/Qpx
 y2MELAevAwZYsNyK3v1qexU3hKpCUbc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-C6756PEvOGuouismhgZ_Jw-1; Wed, 05 Jun 2024 10:11:01 -0400
X-MC-Unique: C6756PEvOGuouismhgZ_Jw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ad803bc570so18760396d6.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717596661; x=1718201461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfMbGvgqLy7ZjhTkpdgM02AGgTLk4BVoGLpbO23Gi7w=;
 b=vVF6oX9iPoB5WPvmrALzONonIX926Hnz4yEf90+7CXQS+y8wOBYNGeivWlmvdd1VH2
 oDVInCJtcrK7IcgipHS1n5Owm0LLeGkrIeGl+p2SHAUhc7BXKbojgrMyqxKLoBNsLmlw
 /tyz4ivLqGWc7FCGqS9mrhMxMB/UftR8ucp8JkNzR8ReMHcAMclE1xLyL181DMBmUZ/F
 vcxlHSYfvhd6kvZxeeZ4aK/jOip5vjLQ/mRxW2+Id65Rj/mIyRSaE4BJqbBNne6a6vyN
 FvNf8fG2GowW8TVWBwwF9puy1anXTkPrIDQqdfhkC83Ls6sp64bGIgl7QcmP9r5RlMFF
 QXOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO7NB1jR+KKnovUFoogerk6R8jrVsQ+bp9VgUzfursklZyb9HHRMa/yUequCEaaxXbYGN6T/PPkEP0S4xjp2hRbljQyKU=
X-Gm-Message-State: AOJu0YyaFkZ2EGYXqpCrb01b4iZW9GZ7TvP5awd8OWOeSS6TsvE4xyVH
 9ljJ+4MvH2KuPoa9le+a0lxu/pQawfvO7LJcy+hP+ze3sFRw79ctBEQpHCTcd2MpgU2AdrFhFZ6
 MhIK59T9tEx0ALtE/+TADTEFc4bnykguphNL6ll2ID8mdKbH6CTKq
X-Received: by 2002:a05:6214:29cd:b0:699:2d88:744f with SMTP id
 6a1803df08f44-6b030a9e2b5mr26498726d6.4.1717596660935; 
 Wed, 05 Jun 2024 07:11:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLHKafRDSOptG+JSx5VoTUoHgpyTOsiZvbZfgv8hRWLSiuOh/YelrMZTILKdEwtlDQGhoGCw==
X-Received: by 2002:a05:6214:29cd:b0:699:2d88:744f with SMTP id
 6a1803df08f44-6b030a9e2b5mr26498156d6.4.1717596660173; 
 Wed, 05 Jun 2024 07:11:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff23e258asm59631941cf.45.2024.06.05.07.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:10:59 -0700 (PDT)
Date: Wed, 5 Jun 2024 10:10:57 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Michael Galaxy <mgalaxy@akamai.com>, Zheng Chuan <zhengchuan@huawei.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZmBx8UDDmO-C1Oqu@x1n>
References: <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n>
 <7e902e4e576a4e199e36d28f99bd55e5@huawei.com>
 <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com>
 <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <cd93922f-cf58-4a42-854d-0b39c6941905@akamai.com>
 <Zl-x_Az8i4jOwitt@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zl-x_Az8i4jOwitt@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hey, Dave!

On Wed, Jun 05, 2024 at 12:31:56AM +0000, Dr. David Alan Gilbert wrote:
> * Michael Galaxy (mgalaxy@akamai.com) wrote:
> > One thing to keep in mind here (despite me not having any hardware to test)
> > was that one of the original goals here
> > in the RDMA implementation was not simply raw throughput nor raw latency,
> > but a lack of CPU utilization in kernel
> > space due to the offload. While it is entirely possible that newer hardware
> > w/ TCP might compete, the significant
> > reductions in CPU usage in the TCP/IP stack were a big win at the time.
> > 
> > Just something to consider while you're doing the testing........
> 
> I just noticed this thread; some random notes from a somewhat
> fragmented memory of this:
> 
>   a) Long long ago, I also tried rsocket; 
>       https://lists.gnu.org/archive/html/qemu-devel/2015-01/msg02040.html
>      as I remember the library was quite flaky at the time.

Hmm interesting.  There also looks like a thread doing rpoll().

Btw, not sure whether you noticed, but there's the series posted for the
latest rsocket conversion here:

https://lore.kernel.org/r/1717503252-51884-1-git-send-email-arei.gonglei@huawei.com

I hope Lei and his team has tested >4G mem, otherwise definitely worth
checking.  Lei also mentioned there're rsocket bugs they found in the cover
letter, but not sure what's that about.

> 
>   b) A lot of the complexity in the rdma migration code comes from
>     emulating a stream to carry the migration control data and interleaving
>     that with the actual RAM copy.   I believe the original design used
>     a separate TCP socket for the control data, and just used the RDMA
>     for the data - that should be a lot simpler (but alas was rejected
>     in review early on)
> 
>   c) I can't rememmber the last benchmarks I did; but I think I did
>     manage to beat RDMA with multifd; but yes, multifd does eat host CPU
>     where as RDMA barely uses a whisper.

I think my first impression on this matter came from you on this one. :)

> 
>   d) The 'zero-copy-send' option in migrate may well get some of that
>      CPU time back; but if I remember we were still bottle necked on
>      the receive side. (I can't remember if zero-copy-send worked with
>      multifd?)

Yes, and zero-copy requires multifd for now. I think it's because we didn't
want to complicate the header processings in the migration stream where it
may not be page aligned.

> 
>   e) Someone made a good suggestion (sorry can't remember who) - that the
>      RDMA migration structure was the wrong way around - it should be the
>      destination which initiates an RDMA read, rather than the source
>      doing a write; then things might become a LOT simpler; you just need
>      to send page ranges to the destination and it can pull it.
>      That might work nicely for postcopy.

I'm not sure whether it'll still be a problem if rdma recv side is based on
zero-copy.  It would be a matter of whether atomicity can be guaranteed so
that we don't want the guest vcpus to see a partially copied page during
on-flight DMAs.  UFFDIO_COPY (or friend) is currently the only solution for
that.

Thanks,

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10212C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 20:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEbCb-0007We-7w; Tue, 04 Jun 2024 16:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEbCZ-0007Ug-DU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 16:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEbCX-0004EU-TP
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 16:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717534572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZ6RtXMrNsjNFhwNhH2Pb9+F/Os51ORsGcVAwy753JU=;
 b=XshSo3Jlu21pM8Tc4RMZy0AWpujIRB6ZMxEQ1Gu+moXph/6y+NX37pgv69PG/NV8Tw3JJk
 P28Ct4pY2xbuizX186QG8kgFkuAvAQnZOsWLfL9K4+YXbRJcRdozxyd6jA0Ngk0qOjsH0/
 IFmUNNNaoHkXIZMQ7vj6zdzfO70RhwU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-yg8cpbz2NGeK1rftiGu-Ig-1; Tue, 04 Jun 2024 16:56:11 -0400
X-MC-Unique: yg8cpbz2NGeK1rftiGu-Ig-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6af3d5fd099so6253436d6.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 13:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717534570; x=1718139370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZ6RtXMrNsjNFhwNhH2Pb9+F/Os51ORsGcVAwy753JU=;
 b=X9G2/0E+G7yLnOMlH6yoxlzmbeVS7Yd/l6nAepV58TSc0E4u8OSH4NErQxvBgm9363
 /U8376PvlO/bhFZqH/QKo1HzC4C4fnnXrxoEjwJTvBw3RphIxWhM5bv+uQbtO01QUKnM
 CoxiOFg/GsqSg93QUwaifwe0pirKw/hDviRRoUqJcx0qh9Da4wA1J1UDiqHrkk/k+x/B
 lMbziSao9YWds7ijUW8DH+3gWqC/L3w1sU4p9/5LqPFKp0LZBES2ptf71naZ9sSSi5WW
 lC9hMSKSwTmd4bkw/+WvXe23ciyC3FAMpqTLYXHiCR8WSqksvlPeLmoUEq3mFgow7cSE
 LENw==
X-Gm-Message-State: AOJu0YylNGwUwi9kcnfU52FSiZXQqJECWVFtYCeafHr72ihhDEfU+owd
 c9fzwfHTRHGtvvBlTzM6S4dpX1hB0nsR6N8zMDeH5GfnHDURTOleKD2ZH35PwDRN8mD7TW/+JRd
 oeIXVw/7xHLtwiS0xkYtYzoowEwRmPZ6hriSy7KnxmZ9IQTMESISh
X-Received: by 2002:a05:620a:280c:b0:794:edc7:1565 with SMTP id
 af79cd13be357-79523c0d77dmr47189485a.1.1717534569629; 
 Tue, 04 Jun 2024 13:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/z4g9G1J0YUZG1bK2Q3LYfSh8lZBSvefIi6MU6VwIEgOkvE65o8W5o23R8xMiW2LN2eGkCw==
X-Received: by 2002:a05:620a:280c:b0:794:edc7:1565 with SMTP id
 af79cd13be357-79523c0d77dmr47187285a.1.1717534569076; 
 Tue, 04 Jun 2024 13:56:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f30603bdsm392076785a.93.2024.06.04.13.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 13:56:08 -0700 (PDT)
Date: Tue, 4 Jun 2024 16:56:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to precopy
 file migration
Message-ID: <Zl9_ZiC6-743ZosG@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-19-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, May 23, 2024 at 04:05:48PM -0300, Fabiano Rosas wrote:
> We've recently added support for direct-io with multifd, which brings
> performance benefits, but creates a non-uniform user interface by
> coupling direct-io with the multifd capability. This means that users
> cannot keep the direct-io flag enabled while disabling multifd.
> 
> Libvirt in particular already has support for direct-io and parallel
> migration separately from each other, so it would be a regression to
> now require both options together. It's relatively simple for QEMU to
> add support for direct-io migration without multifd, so let's do this
> in order to keep both options decoupled.
> 
> We cannot simply enable the O_DIRECT flag, however, because not all IO
> performed by the migration thread satisfies the alignment requirements
> of O_DIRECT. There are many small read & writes that add headers and
> synchronization flags to the stream, which at the moment are required
> to always be present.
> 
> Fortunately, due to fixed-ram migration there is a discernible moment
> where only RAM pages are written to the migration file. Enable
> direct-io during that moment.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Is anyone going to consume this?  How's the performance?

It doesn't look super fast to me if we need to enable/disable dio in each
loop.. then it's a matter of whether we should bother, or would it be
easier that we simply require multifd when direct-io=on.

Thanks,

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79813CF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 17:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srLFk-0007JC-SI; Thu, 19 Sep 2024 13:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLFj-0007CD-12
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srLFh-0001KO-8m
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 13:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726768056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOy7L10aN3Kb1lcef7z/81v3p0HZxiBJ/pA0Fpz6iR0=;
 b=d62r1inAsX1o46/uDVm1w803VzCakiXSQZDLSpk6yORWS6aIl0J7kWD5aXhUCHvT47+yin
 TW7oV4zYdExnmh9eB/cKFktifGt6aw5ElInXGZmblGOwb3yc0VBcOGxd/zk8ZZMudBzqZ0
 fCFC+J2rIzDS/MoNPfbA40YdODOO+ks=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-hBsuwXKhO-2pT0IQyQ6pSQ-1; Thu, 19 Sep 2024 13:47:34 -0400
X-MC-Unique: hBsuwXKhO-2pT0IQyQ6pSQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c3580b7cf5so16852886d6.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 10:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726768054; x=1727372854;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOy7L10aN3Kb1lcef7z/81v3p0HZxiBJ/pA0Fpz6iR0=;
 b=gVBVGmVP18zp5/vj3lVouzDkRnjl+a31T/LSGNzFQo7g/ADsvJ6YJC2pLS8yRLXI8P
 OAYnQO4bDA6m6OgpuMB+PXE5arxeoFLbXRZN9ZodjpgoowEPgoX1LCYumXLGyFMofQfW
 BfWY29fNX2KaORiOlOkAEAGytpdWR+0kwkGiRjYoNIpGV1pjl2e40OBf2o8HS9MZaNaU
 shcpSB/9q+8w54wYE6Ai4L963JlEjVBwWM8ZlCM6KYYAwjIczBBwkzo3pchiBRXzFARO
 fYbTfUXmxa609qZjUoWaa4atboipBCLlYWk2ZyNTmtfwzAcES3VbA/X8urmMYUi6kgFt
 yGDw==
X-Gm-Message-State: AOJu0YxKwhW7OQ5WVnRTXygU9I6LNYUN/08AsQThyAcCdXjGFv+j1TJv
 eNkVjn6fj68gyowEYuWOgqvzVkpfH0XkYl5ic97h+KHpcBRlfoFQr5nC3CaipAh8BUBkhFFgmxc
 GWV5D0miZZ2repz4bAjkxZnzOentK51e91R8MWca1quZMQkBQqWE5
X-Received: by 2002:a05:6214:4186:b0:6c3:6556:70a4 with SMTP id
 6a1803df08f44-6c7bc7a29c9mr1332016d6.50.1726768053796; 
 Thu, 19 Sep 2024 10:47:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/GAUOISqgWSJahFXxIMdS8XhwaJEUqttiLbCUum1lym4VSIYhi0ExXZgOB0pV49GTM7gGXw==
X-Received: by 2002:a05:6214:4186:b0:6c3:6556:70a4 with SMTP id
 6a1803df08f44-6c7bc7a29c9mr1331866d6.50.1726768053433; 
 Thu, 19 Sep 2024 10:47:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e586f31sm9516436d6.142.2024.09.19.10.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 10:47:33 -0700 (PDT)
Date: Thu, 19 Sep 2024 13:47:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration/multifd: Ensure packet->ramblock is
 null-terminated
Message-ID: <Zuxjs7ld4f1fGQJe@x1n>
References: <20240919150611.17074-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919150611.17074-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 19, 2024 at 12:06:11PM -0300, Fabiano Rosas wrote:
> Coverity points out that the current usage of strncpy to write the
> ramblock name allows the field to not have an ending '\0' in case
> idstr is already not null-terminated (e.g. if it's larger than 256
> bytes).
> 
> This is currently harmless because the packet->ramblock field is never
> touched again on the source side. The destination side reads only up
> to the field's size from the stream and forces the last byte to be 0.
> 
> We're still open to a programming error in the future in case this
> field is ever passed into a function that expects a null-terminated
> string.
> 
> Change from strncpy to QEMU's pstrcpy, which puts a '\0' at the end of
> the string and doesn't fill the extra space with zeros.
> 
> (there's no spillage between iterations of fill_packet because after
> commit 87bb9e953e ("migration/multifd: Isolate ram pages packet data")
> the packet is always zeroed before filling)
> 
> Resolves: Coverity CID 1560071
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

queued.

-- 
Peter Xu



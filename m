Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF311061B1E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7JbQ-00049m-NR; Mon, 30 Mar 2026 16:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7JbP-00049P-6u
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 16:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7JbN-0007Ck-D9
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 16:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774903967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8PYJsdMMHU/0/flQyOBtNkTFz209yQE2bnZ0HP7aXm8=;
 b=Ke8hwEnYU/YWfC1WACP730AIdxvZkyfLgNmhhR6boFTA2LwbOqpTLiaofJ24HXbHsuvSNT
 wM7rvTRxaqt1qhNCefJuPdf6JDJvWq5u+GtYtsB1Eu3kayGTjP0L/GEj5v25mkUH0283BJ
 dKj6hGlBQr5rD7LsXHBOL2hGhorMRDw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-RmRj4YE6MESQtTsrPUh9BA-1; Mon, 30 Mar 2026 16:52:45 -0400
X-MC-Unique: RmRj4YE6MESQtTsrPUh9BA-1
X-Mimecast-MFC-AGG-ID: RmRj4YE6MESQtTsrPUh9BA_1774903965
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5094ba09affso19032391cf.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774903965; x=1775508765; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8PYJsdMMHU/0/flQyOBtNkTFz209yQE2bnZ0HP7aXm8=;
 b=ZQLl4cyK0f2ZuXUiuYRCqfobgWzZi6/Kt64E74Do7SsqIdMeqDyZWtlJpIK5Qw8WNT
 viWnmdBjKfqrbbPgpf8Ng2wzVgnZ2sWlOKe5qXNQoVohLN695x+goKYVyKcYIZ4Hzc3w
 1mAHUpB5FNLdserl31ruTAhwkn+/BtxkzSDzmA0hjFwtD6wjIPSbonb0NTBytJ0LlPie
 WvOqrvXRHA2GgsBn/Cb3v8j+Qt96Cd7W9E3vo+ELcSKT73kBt1WrVxT5Dsfo5wjoUZtt
 PlwG0Vl9c/JdW0k5ogtDvzxHVaJ5SaEpk+A2M7+nQGQnLuXX/Qdml89T+RPXYMjkQNpp
 oqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903965; x=1775508765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PYJsdMMHU/0/flQyOBtNkTFz209yQE2bnZ0HP7aXm8=;
 b=ND+KQl1ogdpDuv5r40NDNP9UjuuqdSj8jnoaCnn2UqU9TpCxHrQS/HSj00tghUVaWS
 HznP7IrM5xJwVL7CdNAfJvrRD0/uohGhLID0GPq3UPJwdNYVM8jDieGslYqdU2uJWrd7
 OyrFwaNJacTva7UUnA0VSqXzhhNZGFY8vA95Np5jbV+Z53SMuWSs/WkQz0E+2Hw3nRyE
 MM5cKMqFXQ+SsStvjTH4kyO3A3wxS3AqX4Fg4p+Vhp4laJnHbiAZy3Tcs0SfH7EFXAd8
 3UkummhjM0js6f6Ov842pjFyLM++81Fd77M+v6n7E8SpxyNXlAFDhqkJqSnNvTDZIEHW
 eQLg==
X-Gm-Message-State: AOJu0Yzpd5XFZWo/J8AWMt/KqSSUshZyilq8c68nqZ/uOiztsEkHyajI
 +ByIBYt2ZA/kcDIWeWsZfiE9FWppMQNxw7L+4ttYONFwBD+Caa2NRA6a4rLxwfRjeRejemRul5Y
 olfTpUGYzq35aWw+IBYlFfoisIZCeFl267zUgnm9AiDIecu1zqLEp5dSE
X-Gm-Gg: ATEYQzyEJgCka5kV7CYCtCfXgfAieqRXgZl4MM0/sZGaWzyrIjyv37hFF0a7+DKpph+
 7U7gQjo7WUorrWDGWDE6YtkfHYBnUVwl+PXo7IMf8D2rxrwFDmnYq1ohVhuMXcLIUuynxkmgL06
 efdnVMIslts5NHzn88upm7lwYxMongTjVrfCxhRKmOMsREa7SuJjcPTzTpLdxgTrhsK8ZbXl5nY
 PR/HwX7SViA4maYE31c1Mhfm4rDIs9BL/Fds2yirgrCRWD5UJSmTLj+4QTSu3Q0OGFmPpeEqxgh
 R3U/fbkGJSEdvrRTHcU2lxOMEAv1nwRlPq1xR5M2jXr4eOhGHE9utXRw6cYV/gd0N1wrfLH5/RA
 rPzV9XE8eykRN0w==
X-Received: by 2002:ac8:5fc7:0:b0:50b:36af:56a6 with SMTP id
 d75a77b69052e-50ba383ebf5mr202459051cf.15.1774903964671; 
 Mon, 30 Mar 2026 13:52:44 -0700 (PDT)
X-Received: by 2002:ac8:5fc7:0:b0:50b:36af:56a6 with SMTP id
 d75a77b69052e-50ba383ebf5mr202458681cf.15.1774903964207; 
 Mon, 30 Mar 2026 13:52:44 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50bb2e16f78sm72891431cf.22.2026.03.30.13.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:52:43 -0700 (PDT)
Date: Mon, 30 Mar 2026 16:52:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] migration: fix QIOChannelFile leak on error in
 file_connect_outgoing
Message-ID: <acrimq2TDEs6KHuE@x1.local>
References: <20260328121215.159532-1-vikingtc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260328121215.159532-1-vikingtc4@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Mar 28, 2026 at 09:12:14PM +0900, Trieu Huynh wrote:
> Commit 03a680c978 changed g_autoptr(QIOChannelFile) to a plain pointer
> but failed to restore the necessary object_unref() calls on error paths.
> Previously, these were handled implicitly by the g_autoptr cleanup
> mechanism.
> 
> Two error paths currently leak the QIOChannelFile object and its
> underlying file descriptor:
> 
>   1. When ftruncate() fails (e.g., on character or block devices).
>   2. When qio_channel_io_seek() fails after the channel is created.
> 
> In environments that retry migration automatically (e.g., libvirt),
> these FDs accumulate until QEMU hits RLIMIT_NOFILE and fails with
> EMFILE (Too many open files).
> 
> Add the missing object_unref() calls to both error paths to ensure
> resources are properly released.
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>

Good catch.

Reviewed-by: Peter Xu <peterx@redhat.com>

I'm just curious, how did you find it?

-- 
Peter Xu



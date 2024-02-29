Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD65C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 01:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfVBz-0004WS-3L; Wed, 28 Feb 2024 20:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfVBx-0004W0-3a
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 20:26:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfVBv-0002Ii-NT
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 20:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709169990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bJdeK6CktbMIku+mQ8rx6N3uhALzpJcWZAefiUI6Bx8=;
 b=QWeEUTBJ5FS/W63/y108DfKhBNdZzwbLo2CC4Np410eXs+dxH2ZKCVr+WVvfmnl+BCiM5c
 QSFfnVA2XdYSPR9KMF5oAItsIEkHsJ19yGIFaJvElCRMuC7rZAn8kMMxLL5w2bv3Tqg0v/
 QNSs6IeFoKKWnmsXe7JlxdDV/qo61VU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-TD3Fl1QTN0yOEpkoMaHvRA-1; Wed, 28 Feb 2024 20:26:28 -0500
X-MC-Unique: TD3Fl1QTN0yOEpkoMaHvRA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so31527a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 17:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709169988; x=1709774788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJdeK6CktbMIku+mQ8rx6N3uhALzpJcWZAefiUI6Bx8=;
 b=rwnNNGaiVG/eh6zNnq05QorCE82AiwgUXpHc//H6FYywMdfQSZND3Qkhughm2qxyI9
 mlPkprVPI9xbqEhDt9YQUKWPB9rLgOEHTFdU1sQxmY3tC7jyKzaM0wBRBJpsqr9eY+uI
 0ZE90/MI5FkMs1XXsC/WpgXrfOMjJkMhMa3lQXJ5itiGZDJEZ2i4e8hKpgOujsTiiJLe
 Drs86Y/msO7VWS/3E2imPIRKJVj9Ka529i0ygOSKDs8iBqmImKj+upgtejzjCasFusF0
 0KwhPtL6v0AjrcatTzw1btB17ZU31dn6k0LzqCAQmD7GHroUpbp1TZZXgzc1WWmyXiO+
 fc2w==
X-Gm-Message-State: AOJu0YzsTOnLAvM/+dZHRGzg+VMPfzuktoOi5toP7jL7+9AIsIZUyjPp
 Ox5couATR9vfEAr/AhCLIgRKiGxTWCQgfpu/Oy7VnmmAYy8o3SwBm2MRGVoCMtiNtyCVaK3dEem
 i7ddu3mxMHDf+flgbsQeJnLcGadbK43EcRfb6IqjUX7d0WPg5ijB/
X-Received: by 2002:a62:e708:0:b0:6e4:8dda:691 with SMTP id
 s8-20020a62e708000000b006e48dda0691mr872699pfh.3.1709169987768; 
 Wed, 28 Feb 2024 17:26:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8O1fMZeH5L385/QeD+jU4qxzx+JyDSzTZQVl6To2xYwEAJzNlmG7rNA75gKjO1KagY0igNQ==
X-Received: by 2002:a62:e708:0:b0:6e4:8dda:691 with SMTP id
 s8-20020a62e708000000b006e48dda0691mr872685pfh.3.1709169987409; 
 Wed, 28 Feb 2024 17:26:27 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u23-20020aa78497000000b006e5092fb3efsm84209pfn.159.2024.02.28.17.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 17:26:26 -0800 (PST)
Date: Thu, 29 Feb 2024 09:26:20 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 01/23] migration/multifd: Cleanup multifd_recv_sync_main
Message-ID: <Zd_dPBQ_rU1ncuKw@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228152127.18769-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On Wed, Feb 28, 2024 at 12:21:05PM -0300, Fabiano Rosas wrote:
> Some minor cleanups and documentation for multifd_recv_sync_main.
> 
> Use thread_count as done in other parts of the code. Remove p->id from
> the multifd_recv_state sync, since that is global and not tied to a
> channel. Add documentation for the sync steps.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



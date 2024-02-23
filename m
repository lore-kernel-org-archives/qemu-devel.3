Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51B2C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdM3d-0002Pa-OV; Thu, 22 Feb 2024 22:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdM3b-0002NN-R7
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdM3a-00034M-A0
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708658220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Y6TJeuWhRVP2C709Vugfs1VXCYjIX/JUUlak4lV/Xw=;
 b=N++Fn5ZhBME0+/tpmF+rIZtwkDYEoFBuzfFKkkiqPm9vYhKjQ93StljPBJb+/Ycyj3X3/+
 EzAPU3zVjfWjAzgMsKi5zGEMeLLGQUODmG/lI/HHcgJyymmIw0USx9QFulkGKR+EippA/s
 sDO4owGPc9EstgcAZ0WlBf3/kcReA9k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-EaMPtKDBP8Sm9Kahckat8w-1; Thu, 22 Feb 2024 22:16:59 -0500
X-MC-Unique: EaMPtKDBP8Sm9Kahckat8w-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-299565dfd2dso32905a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 19:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708658218; x=1709263018;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Y6TJeuWhRVP2C709Vugfs1VXCYjIX/JUUlak4lV/Xw=;
 b=hCWbMssPhqFDMAL+gAc6QnBN24BHTlPK87E3/5JrNaOVRUY3SI3dimW4qdq1c3O5+Y
 fItrZpquVttxMLW3mJJ39HtE08DnTghUUBgMAC5nTODl1n0KEw4fzHe03hBwU554KQSi
 kG7Ly/d9BlzjGHM/2p7YWfJOZPqMTGFQZfSUnAlnjy60rdOy6E8gJ1xYFXS7NVbohwRZ
 hZlK/0nxMDYgg04cSzqsxPfYU/JaZ/znAh0KtUx5CBVRH7fKkPg1nAhMxUjb9MHBLLlD
 jSb6Y7oPzaha9d34yOhNifUa7UpyQ3NIegXETz7VeDnhE4PSSsoLEdQLqcDtjzxkskCX
 IUdA==
X-Gm-Message-State: AOJu0YySUDhKuZTvEIrW5ZDGyEU8npCiwmoF3+OHWDGwBmi/IAe/Zq90
 /U9kpYr3ZT0K1rUGOLOmeTcyQxp7X0ICQEJVB1nOO8mK9OiGom6mHcGsqU08SMRI0cjgpDs+A2T
 xidqu97oVuG72UhZfvsSVFHlj6i3Yt7pzFVCTnURMvxo/2hQ5jV+y
X-Received: by 2002:a17:902:ce84:b0:1d8:dcd2:661 with SMTP id
 f4-20020a170902ce8400b001d8dcd20661mr734454plg.5.1708658218310; 
 Thu, 22 Feb 2024 19:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWtdvkgQ/S8WJdKlboYqHkgIbLw8FMzbAjpGZcerx0FxFFfYzANGZNZPXIW3JPm4iZ24fmUw==
X-Received: by 2002:a17:902:ce84:b0:1d8:dcd2:661 with SMTP id
 f4-20020a170902ce8400b001d8dcd20661mr734439plg.5.1708658217922; 
 Thu, 22 Feb 2024 19:16:57 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ks16-20020a170903085000b001dbcb39dd7dsm10194271plb.125.2024.02.22.19.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 19:16:57 -0800 (PST)
Date: Fri, 23 Feb 2024 11:16:49 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 05/34] migration/multifd: Release recv sem_sync earlier
Message-ID: <ZdgOIXHMnK-BwsOb@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 07:41:09PM -0300, Fabiano Rosas wrote:
> Now that multifd_recv_terminate_threads() is called only once, release
> the recv side sem_sync earlier like we do for the send side.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9B5C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHtn-00028M-PE; Mon, 17 Jun 2024 15:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJHtX-00020c-K3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:19:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJHtV-0000aw-Kl
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718651996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yCUqyXgeAt3DigB96iTOqSCC+oQHEQcT+0S1sif4ysY=;
 b=ZbdgzGVnbx/6EFJlZk1GSPpm7EmF49RSYp2K9eY9g8LV/WP9f82h1bjewp7bmwFSFxSn/P
 5HSN0bN4JC6KNlW+EeJOlkynjB2QEOK21j/eJGvKstnLIqZF22Dw/OVXqk1YosP2C/bfqN
 ABZ8SwlrrGSvyLJu3tkcGy2ohfRv1XQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-bXejdzKZMSGc1OVU5RF70w-1; Mon, 17 Jun 2024 15:19:54 -0400
X-MC-Unique: bXejdzKZMSGc1OVU5RF70w-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-631fb63c2b4so2233237b3.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 12:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718651994; x=1719256794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCUqyXgeAt3DigB96iTOqSCC+oQHEQcT+0S1sif4ysY=;
 b=EbEhyfNlKxHi8BP4EE26inVZqu6WPEPMKKbhV9dVdVJ618Nc5wMHwCztpGjtqr8Dyx
 t8pfTm9OjhdrcbiqogULDWKatWmW+Rqc4eBTyCcSDaokBYZGV/n3v5SPNjPZpQ5hwq0n
 JDP65GSsNbXbVwBEVAy6yvOea+ZuYqvtDqQndOpeqvsmB2LJabfAXCl1ORNGLSHhOfeR
 1x1bZvCZ+d2aMrm+ZFb5wC7EtDSB4vO/VfrdpcP+gb77SuuPMriPbAyJ8XDq6uQ0n+Qk
 xmmvLUMtcqn6m/1t2w7zXUOxHV1t34BUJVvgSw4DidCsKAnERuHevLggOAMgQnAQOLyy
 z+PA==
X-Gm-Message-State: AOJu0YxjbCZG1JlQz8VzPOXGhVQL/A+wQTNK5iHDoZFMA12Ypkz7l4QV
 qOm3tL6GFpYUqKnmAFOlnFsWR6jNeN3abbOKiTSVjc4PWQi5guEtufnWxj01xxbNBk8xnqEvuY+
 GkMDg/MZdg7HBkvSRSHNNUFB7It9Ot2SY6htsdCuldamn0kXPVsrj
X-Received: by 2002:a05:690c:305:b0:631:52c:7b72 with SMTP id
 00721157ae682-63224718309mr85293737b3.3.1718651993992; 
 Mon, 17 Jun 2024 12:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSD3gplHt8W+7hwBkw7jkV1NP27cpxOkvM+82rX9eEowO2V7SXVziQnqvi8RlTeg4XqAPGqA==
X-Received: by 2002:a05:690c:305:b0:631:52c:7b72 with SMTP id
 00721157ae682-63224718309mr85293437b3.3.1718651993355; 
 Mon, 17 Jun 2024 12:19:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-631183d7d8fsm15412077b3.9.2024.06.17.12.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 12:19:52 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:19:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v3 12/16] migration/multifd: Add direct-io support
Message-ID: <ZnCMVl3F9m9Laazd@x1n>
References: <20240617185731.9725-1-farosas@suse.de>
 <20240617185731.9725-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617185731.9725-13-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Mon, Jun 17, 2024 at 03:57:27PM -0300, Fabiano Rosas wrote:
> When multifd is used along with mapped-ram, we can take benefit of a
> filesystem that supports the O_DIRECT flag and perform direct I/O in
> the multifd threads. This brings a significant performance improvement
> because direct-io writes bypass the page cache which would otherwise
> be thrashed by the multifd data which is unlikely to be needed again
> in a short period of time.
> 
> To be able to use a multifd channel opened with O_DIRECT, we must
> ensure that a certain aligment is used. Filesystems usually require a
> block-size alignment for direct I/O. The way to achieve this is by
> enabling the mapped-ram feature, which already aligns its I/O properly
> (see MAPPED_RAM_FILE_OFFSET_ALIGNMENT at ram.c).
> 
> By setting O_DIRECT on the multifd channels, all writes to the same
> file descriptor need to be aligned as well, even the ones that come
> from outside multifd, such as the QEMUFile I/O from the main migration
> code. This makes it impossible to use the same file descriptor for the
> QEMUFile and for the multifd channels. The various flags and metadata
> written by the main migration code will always be unaligned by virtue
> of their small size. To workaround this issue, we'll require a second
> file descriptor to be used exclusively for direct I/O.
> 
> The second file descriptor can be obtained by QEMU by re-opening the
> migration file (already possible), or by being provided by the user or
> management application (support to be added in future patches).
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



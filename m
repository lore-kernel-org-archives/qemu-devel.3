Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F1EC47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 03:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reRZv-00075V-RE; Sun, 25 Feb 2024 22:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reRZu-000754-2v
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 22:22:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reRZl-0006bh-V4
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 22:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708917764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HLb2yxwgbtIusWvwxRaqPDNT16753Ui76mnFY47u/wE=;
 b=B3mpmNLtjBQ4BzIX/tasp+P/hvrEo121+j0YH3sq1b0PTkwTIVJXosl+YOWooUGVgYes5i
 JrLj4qhLKnZGWNZN/vGnNZd7alnX3C3uIUcVf+0iiIwNnE5xjGDS9xTMjoLpAOm4lPLoQG
 yss2e1yUEUzebKZHwMVOCY5Wha/KVz8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-0favY5x2MD6_zlWHQJ0GqQ-1; Sun, 25 Feb 2024 22:22:43 -0500
X-MC-Unique: 0favY5x2MD6_zlWHQJ0GqQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5ce9b15f4ccso1523230a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 19:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708917762; x=1709522562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLb2yxwgbtIusWvwxRaqPDNT16753Ui76mnFY47u/wE=;
 b=c4A0oSYsfC2FbwMdZQspxmW5cPoerryWl9OWL7iNpfAUnDfd/908yMMNagHxBg8NHU
 wek22gR3AFP0iiZXFRXwnBBrYN9wvwHVnE/PzF8HFEy1nncdHCVNS5v0djplgRHUXosj
 qZlccPmq+5L9oAgISpgLI0K9QRuXdg2bb/gUPWb76M7mcSex+pxw2r5KCnImlg1RDPZe
 pMn3RJ8NNMC/0SjCAfjBt0a3Jh5ANudgyLXsfWau6IrpMVfhPUhMcuwcvag4cJON3nCC
 f6HtuOAiYz68f9VYAT3tyKr75L60u9EJO0DZ/T5b3Iu/HrGjeD1C1ttW0Cpf/RMLtDE1
 yteg==
X-Gm-Message-State: AOJu0YzKF7avCskcwYBGdHhlB0fkTeJwKg9TDhY00q/sE4rhtfqr57Ew
 /R7dG2QTq5M28tuVLomCyWVGjNoq4ZaAU6ByqqUBFyoUjQ4UNXts/Q4PTuytLwfkAP4I53uX0nZ
 oU98iDdo3HDXE9DafUb4zABw2t9wrbGH0xyu2nMsjalzyVXSSeeETqte6pdli8ZY=
X-Received: by 2002:a05:6a00:91:b0:6e4:e7c3:f0c6 with SMTP id
 c17-20020a056a00009100b006e4e7c3f0c6mr7054199pfj.0.1708917762012; 
 Sun, 25 Feb 2024 19:22:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLKUOs00MMUKjBVpAbYECMnzGFnDQmBOIQEpYvWgzllrLcX3TP0rsq7fTIrUK5C65QmWPVDQ==
X-Received: by 2002:a05:6a00:91:b0:6e4:e7c3:f0c6 with SMTP id
 c17-20020a056a00009100b006e4e7c3f0c6mr7054187pfj.0.1708917761709; 
 Sun, 25 Feb 2024 19:22:41 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s36-20020a056a0017a400b006e3e72a4f87sm2965120pfg.0.2024.02.25.19.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 19:22:41 -0800 (PST)
Date: Mon, 26 Feb 2024 11:22:34 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 11/34] migration/ram: Introduce 'fixed-ram' migration
 capability
Message-ID: <ZdwD-tbK0XOgXwSA@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-12-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-12-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Feb 20, 2024 at 07:41:15PM -0300, Fabiano Rosas wrote:
> + Without fixed-ram:                  With fixed-ram:
> +
> + ---------------------               --------------------------------
> + | ramblock 1 header |               | ramblock 1 header            |
> + ---------------------               --------------------------------
> + | ramblock 2 header |               | ramblock 1 fixed-ram header  |
> + ---------------------               --------------------------------
> + | ...               |               | padding to next 1MB boundary |
> + ---------------------               | ...                          |
> + | ramblock n header |               --------------------------------
> + ---------------------               | ramblock 1 pages             |
> + | RAM_SAVE_FLAG_EOS |               | ...                          |
> + ---------------------               --------------------------------
> + | stream of pages   |               | ramblock 2 header            |
> + | (iter 1)          |               --------------------------------
> + | ...               |               | ramblock 2 fixed-ram header  |
> + ---------------------               --------------------------------
> + | RAM_SAVE_FLAG_EOS |               | padding to next 1MB boundary |
> + ---------------------               | ...                          |
> + | stream of pages   |               --------------------------------
> + | (iter 2)          |               | ramblock 2 pages             |
> + | ...               |               | ...                          |
> + ---------------------               --------------------------------
> + | ...               |               | ...                          |
> + ---------------------               --------------------------------
> +                                     | RAM_SAVE_FLAG_EOS            |
> +                                     --------------------------------
> +                                     | ...                          |
> +                                     --------------------------------
> +
> + where:

Super-nit: you can drop the " " otherwise it's put into the quote.

> +  - ramblock header: the generic information for a ramblock, such as
> +    idstr, used_len, etc.
> +
> +  - ramblock fixed-ram header: the information added by this feature:
> +    bitmap of pages written, bitmap size and offset of pages in the
> +    migration file.
> +
> +Restrictions
> +------------
> +
> +Since pages are written to their relative offsets and out of order
> +(due to the memory dirtying patterns), streaming channels such as
> +sockets are not supported. A seekable channel such as a file is
> +required. This can be verified in the QIOChannel by the presence of
> +the QIO_CHANNEL_FEATURE_SEEKABLE.

Would it worth also mention that it only provides fixed offsets to "guest
physical RAM" only?  For example, GPU RAM won't apply as they're migrated
as part of device states, even if also iterable.  IOW, IIUC if there's a
VFIO device (or a few), the fixed-ram migration file will still be unbound
in size, because device can keep flushing stale vRAM to the image..

Maybe that's too specific, I'll leave that to you to decide whether to even
mention it.

-- 
Peter Xu



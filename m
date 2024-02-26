Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9040EC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 04:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reSIJ-0007u9-Qr; Sun, 25 Feb 2024 23:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reSIH-0007ty-PV
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 23:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reSIF-00005i-3q
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 23:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708920521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W8vZaX2tD0Nz2eJ8R9GorLCp/l8hMgQJp0DDHWbxqeM=;
 b=eN9B6T//DzDPxGqLXgJ5HCR/ZQ04A/6ZLxbyiRxhhzIvCx0BNanROp/bzB9pD9tLGt/hyP
 /nLzGEZyC1C2aZzWxFnLAFkBXoLTbp/EzLcBOMUHCIwd9GEEx+FTbwt4IqoKoOGNrMFvCa
 UJ32jR+cMLHJrdrj1weqRZhinILsGMU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-ym7k1277Nk2bmgUhFvz_Fw-1; Sun, 25 Feb 2024 23:08:40 -0500
X-MC-Unique: ym7k1277Nk2bmgUhFvz_Fw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so733017a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 20:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708920216; x=1709525016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8vZaX2tD0Nz2eJ8R9GorLCp/l8hMgQJp0DDHWbxqeM=;
 b=DVIXRbKvQjzogLPyX2e3zByTI3VPuKOdcJGkWFqv+9RvZ6CxoiHNmrPB7TuPt0dzsU
 mD5BOeRRwu7vWTsAsmraOt4WTl71eT1Uzueg9ey7SNSfWRFr4MA1yY2mjfYQTZ9obbAa
 rrEYsWAjUu5GU2jjK8+txygqvDaBRLl0XJIzdHE9Lgi7JIlRrxzzdeXTDZAl3XOntcxV
 zARrNQAMPl4aHUPprCDytqb2Fgr4ppGPcgOlGsJgPuWFDhR9V71IQHEW63qW3TOR5Tof
 xGOU/xi85iminc9TNq1VX4rpXMWO1TBJr5kTfoY/qB5uwoDWVHGw+egRn7s2TcY6LIBy
 91+Q==
X-Gm-Message-State: AOJu0YytenRqAZXXDel67kU+dFbRfVTmIONMXgU/scWHEjHohlTNym+c
 PFm48hV1h1gATEVjzotyhh0aMu1wHQFOo90XXpaZRINA1yKRKi68s3eN7zhivId4NCYZqCWRFSZ
 B/wmzvKmPn+I+jRFQ+fKuxxG1zpuh4VndsU5lNyiTEyLlpDcjbuknndPXmjkj0I4=
X-Received: by 2002:a05:6a20:1595:b0:1a1:3e2:dcc5 with SMTP id
 h21-20020a056a20159500b001a103e2dcc5mr1715pzj.6.1708920216278; 
 Sun, 25 Feb 2024 20:03:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDTKP9AfH67B8/3U4VjEIGGj6g6NfRqKIYfjFKarxDGZ7En9kkX9YtksqMP2XdrR5A2+MeYA==
X-Received: by 2002:a05:6a20:1595:b0:1a1:3e2:dcc5 with SMTP id
 h21-20020a056a20159500b001a103e2dcc5mr1711pzj.6.1708920215983; 
 Sun, 25 Feb 2024 20:03:35 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ld4-20020a056a004f8400b006e535131c52sm274221pfb.146.2024.02.25.20.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 20:03:35 -0800 (PST)
Date: Mon, 26 Feb 2024 12:03:27 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 13/34] migration/ram: Add outgoing 'fixed-ram' migration
Message-ID: <ZdwNj0e5rs_C8CwR@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Feb 20, 2024 at 07:41:17PM -0300, Fabiano Rosas wrote:
> Implement the outgoing migration side for the 'fixed-ram' capability.
> 
> A bitmap is introduced to track which pages have been written in the
> migration file. Pages are written at a fixed location for every
> ramblock. Zero pages are ignored as they'd be zero in the destination
> migration as well.
> 
> The migration stream is altered to put the dirty pages for a ramblock
> after its header instead of having a sequential stream of pages that
> follow the ramblock headers.
> 
> Without fixed-ram (current):        With fixed-ram (new):
> 
>  ---------------------               --------------------------------
>  | ramblock 1 header |               | ramblock 1 header            |
>  ---------------------               --------------------------------
>  | ramblock 2 header |               | ramblock 1 fixed-ram header  |
>  ---------------------               --------------------------------
>  | ...               |               | padding to next 1MB boundary |
>  ---------------------               | ...                          |
>  | ramblock n header |               --------------------------------
>  ---------------------               | ramblock 1 pages             |
>  | RAM_SAVE_FLAG_EOS |               | ...                          |
>  ---------------------               --------------------------------
>  | stream of pages   |               | ramblock 2 header            |
>  | (iter 1)          |               --------------------------------
>  | ...               |               | ramblock 2 fixed-ram header  |
>  ---------------------               --------------------------------
>  | RAM_SAVE_FLAG_EOS |               | padding to next 1MB boundary |
>  ---------------------               | ...                          |
>  | stream of pages   |               --------------------------------
>  | (iter 2)          |               | ramblock 2 pages             |
>  | ...               |               | ...                          |
>  ---------------------               --------------------------------
>  | ...               |               | ...                          |
>  ---------------------               --------------------------------
>                                      | RAM_SAVE_FLAG_EOS            |
>                                      --------------------------------
>                                      | ...                          |
>                                      --------------------------------
> 
> where:
>  - ramblock header: the generic information for a ramblock, such as
>    idstr, used_len, etc.
> 
>  - ramblock fixed-ram header: the new information added by this
>    feature: bitmap of pages written, bitmap size and offset of pages
>    in the migration file.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Still one comment below:

[...]

> @@ -3187,6 +3288,18 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          return ret;
>      }
>  
> +    if (migrate_fixed_ram()) {
> +        ram_save_file_bmap(f);
> +
> +        if (qemu_file_get_error(f)) {
> +            Error *local_err = NULL;
> +            int err = qemu_file_get_error_obj(f, &local_err);
> +
> +            error_reportf_err(local_err, "Failed to write bitmap to file: ");

We always do error report if we set s->error.

Ideally I think we should have Error** passed to the caller and set
s->error there, instead of report here.  But the whole error handling is
still a bit of a mess, so I guess we can do anything on top.

> +            return -err;
> +        }
> +    }

-- 
Peter Xu



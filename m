Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E061EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 18:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1VjB-000611-Ja; Mon, 29 Apr 2024 14:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1VjA-00060H-4C
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1Vj8-0004sd-B8
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 14:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714415264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ANsJ8NjiCyfJ/9VS76/EchKYSkvbCUcf5thfHDsj8Gs=;
 b=htTaRFtbcPVx9NnOmSnCGZyBMaG95rwrfvQJJYMbQhs2N0Rn7/+OMTOnoEdsnA9aOY7uAg
 YmsfJGWfkQqtjdz9ICXTs8bhicP18n8OMTK0hGayG1pHN7pkL2VZUDgqSYVx+VHLN5W4kA
 6VpwgDU2+suyVwMifsedUX3VXKEh4YE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-8DfzN7aRNei3dw-asxeiVQ-1; Mon, 29 Apr 2024 14:27:42 -0400
X-MC-Unique: 8DfzN7aRNei3dw-asxeiVQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-437618fbdbeso1426701cf.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 11:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714415262; x=1715020062;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANsJ8NjiCyfJ/9VS76/EchKYSkvbCUcf5thfHDsj8Gs=;
 b=FrRv7khYXWUIyjplRHyAuLYpMrVz1pVgc7adVhKJpHIj2gnVsxim9cMr4KtDVc/Ow1
 A/ufKpLIEbzjOxjWIqcMqQR0c7gerR9AvTEZQLSl+Pc+dFa/y3GULo65xS7xkAKrZ7Rk
 lVcndGXMD1mCWZsHV6DvZpRXBxK9DhHlFvvvRlMgDD+tws5PnuGCUT8JUA0ZkWqotCzV
 WuzDqte0b9uIRzuftUD9VhuPIju5hPXA09X7K+kMRO+UpxfE8Vk0AErz8byfbCQ87NHW
 5aPqFr8BM0Ac9UyK98eKjgH+VJdatR9P3VHFcnFlsetGEguBuNlAgfo1Kz2vnNiGrDC9
 HoFg==
X-Gm-Message-State: AOJu0Yxx9/OITBsh9xIRTrFBuDuUaI+zaFn4gPTf9Vew198T5Y18ZtIm
 60Zb1TAoTJ27KQBIzWI/dE/YBdfCk41lCuSzrY1p7GeLl3YBfdbStb7OEgRL4wKdN7AsT0FAg8l
 7SheqpMEu3PH9VjpViBOcCyL+9hrhNXAKeQWe9bnAl5vlUhTllY44
X-Received: by 2002:a05:620a:17a0:b0:790:e856:7cc9 with SMTP id
 ay32-20020a05620a17a000b00790e8567cc9mr6819016qkb.1.1714415262040; 
 Mon, 29 Apr 2024 11:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOGLTAuFTTcuz0VwOx2A9bBPGU6Fyr2dcgrJcWeybtyFeIv4zROCFwbCdJsfK+LQVDdgeSEQ==
X-Received: by 2002:a05:620a:17a0:b0:790:e856:7cc9 with SMTP id
 ay32-20020a05620a17a000b00790e8567cc9mr6819000qkb.1.1714415261453; 
 Mon, 29 Apr 2024 11:27:41 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d15-20020a05620a158f00b00790f882fa89sm885280qkk.33.2024.04.29.11.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 11:27:41 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:27:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 devel@lists.libvirt.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 3/6] migration: Remove 'blk/-b' option from migrate
 commands
Message-ID: <Zi_mmpmW4XIKpXmo@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-4-farosas@suse.de> <Zi_CNIYAi6UbxJ0j@x1n>
 <875xw0f5oe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xw0f5oe.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Apr 29, 2024 at 02:18:57PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Apr 26, 2024 at 10:14:05AM -0300, Fabiano Rosas wrote:
> >> @@ -2003,21 +1997,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool resume,
> >>          }
> >>      }
> >>  
> >> -    if (blk) {
> >> -        if (migrate_colo()) {
> >> -            error_setg(errp, "No disk migration is required in COLO mode");
> >> -            return false;
> >> -        }
> >> -        if (migrate_block()) {
> >> -            error_setg(errp, "Command options are incompatible with "
> >> -                       "current migration capabilities");
> >> -            return false;
> >> -        }
> >> -        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, errp)) {
> >> -            return false;
> >> -        }
> >> -        s->must_remove_block_options = true;
> >> -    }
> >> +    s->must_remove_block_options = true;
> >
> > Can we drop this var too?  Perhaps with block_cleanup_parameters()?
> 
> Yes, Markus mentioned it in v1 already. Take a look there. There's
> several other declarations I missed. v3 is coming soon.

Right, noticed that it's removed actually in the next patch.

But iiuc it can already been removed in this patch.  If we want to remove
it in the next, logically we should set must_remove_block_options=false
here, though..  So maybe easier to just drop it here.

-- 
Peter Xu



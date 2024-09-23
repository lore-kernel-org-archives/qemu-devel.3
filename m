Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE786CF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssla5-0007Rp-9w; Mon, 23 Sep 2024 12:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ssla4-0007Qw-3j; Mon, 23 Sep 2024 12:06:32 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ssla2-0007D6-8w; Mon, 23 Sep 2024 12:06:31 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-277f5c7bdecso2294507fac.3; 
 Mon, 23 Sep 2024 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727107589; x=1727712389; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8dZqaUTotHVKh3/PFTOReMnRlTriJZ09BxZGc4g30yQ=;
 b=SW0Fkuj1nCv+t8L1/shPBldLj0v2QNg+7p1iXjqbYShF9NCObIIlonNTPe2qawmgF6
 80/lKwo++y4kv/thhf3n7zKsUqILTJiCeVV+AKKU8cBEEm4CLapBINhaInUPSDmSzQyr
 MIWPD4U43VpEm7dTKQrMMsSr1q6AzZWrA4OHnr/rZ9h+aFNrGxEsEUPKfzq/UfL5bUOG
 sSa29TGa/d3K1HVQnkLT/MwJj4fLIydumD6OtAzj7teimfe4bC3y4GDxfld+Oj5JY8RF
 ti9KuCwWt8h1CFjmhatfV70BdHe4EKUGz8s0NrgsohQawxVbWFY9eOgRKeYR4Yl2Q4KO
 JKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727107589; x=1727712389;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dZqaUTotHVKh3/PFTOReMnRlTriJZ09BxZGc4g30yQ=;
 b=V56wT+6VadJCjRU4r+ruI0E6l0ChWX/OSIb7O3LEtNc+a/0KZOJgB+JFI3sejNBRBX
 N9LXiQ6Fd/Hr8gvRdcirf9NM383P9JrH/da0H546RArXKF5z6+b+QTsisLq6t6gLH2E0
 M5AASWq4K2DqMFTxv+XAORwUd5ghBCNtkthHEcs3tm1IYslfLpvLqYlMrabDe4vQiQmb
 08ugVyTZcY3/YllDnjqX4BH1W4BjVUgdnaPEw2jGDt0NPIzfHr1VPIZOxserL9Zv6o4/
 pXMuxbqa53mbRUubYxx2GTU8ZjaoH5pSloJ6Sbfifvyk9BPoNHXZKvOxpQL1k0B3jpFy
 1zrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXirXokdmvFSSP3qPPI2I3lt0Mp7lqXPHLceN4AIG6SjNaVgxiMV8HBNdEi3Gozwnhd4l4JHV61yemo@nongnu.org
X-Gm-Message-State: AOJu0YxkqAhB5BZMFLIvUqV7JQGgdPfBlV7UATyl3tPjKzhyJI/1K7jy
 oA+8mbPlN+ZN1D/OlD8alq0o+bGI4Iz7ai1mPyPMaJU4pT/HeXCY
X-Google-Smtp-Source: AGHT+IGd4U+YMNWKYBk7e/uNFH7FpZYvaad5oMEY7bptUoNZFDEs1kpgChhYV0mo9BW13vmh4Dkb1w==
X-Received: by 2002:a05:6870:1956:b0:261:f30:fda3 with SMTP id
 586e51a60fabf-2803cf5ed57mr6873420fac.21.1727107588569; 
 Mon, 23 Sep 2024 09:06:28 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-49e6b47a782sm3920468137.30.2024.09.23.09.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 09:06:27 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:06:25 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 edgar.iglesias@amd.com, qemu-block@nongnu.org
Subject: Re: [PATCH v1 1/1] block/file-posix: Avoid maybe-uninitialized warning
Message-ID: <ZvGSAWV6cgFDHgAf@zapote>
References: <20240812144324.116343-1-edgar.iglesias@gmail.com>
 <20240812144324.116343-2-edgar.iglesias@gmail.com>
 <xk2z73avp7eobweubmma4oefeo2siwm2zhzbpecl4y3qv2ohq5@j7oodpli5sij>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xk2z73avp7eobweubmma4oefeo2siwm2zhzbpecl4y3qv2ohq5@j7oodpli5sij>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ping!

On Wed, Aug 14, 2024 at 01:15:55PM -0500, Eric Blake wrote:
> On Mon, Aug 12, 2024 at 04:43:23PM GMT, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > Avoid a maybe-uninitialized warning in raw_refresh_zoned_limits()
> > by initializing zoned.
> > 
> > With GCC 14.1.0:
> > In function ‘raw_refresh_zoned_limits’,
> >     inlined from ‘raw_refresh_limits’ at ../qemu/block/file-posix.c:1522:5:
> > ../qemu/block/file-posix.c:1405:17: error: ‘zoned’ may be used uninitialized [-Werror=maybe-uninitialized]
> >  1405 |     if (ret < 0 || zoned == BLK_Z_NONE) {
> >       |         ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
> > ../qemu/block/file-posix.c:1401:20: note: ‘zoned’ was declared here
> >  1401 |     BlockZoneModel zoned;
> >       |                    ^~~~~
> > cc1: all warnings being treated as errors
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  block/file-posix.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index ff928b5e85..90fa54352c 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1398,7 +1398,7 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
> >                                       Error **errp)
> >  {
> >      BDRVRawState *s = bs->opaque;
> > -    BlockZoneModel zoned;
> > +    BlockZoneModel zoned = BLK_Z_NONE;
> >      int ret;
> >  
> >      ret = get_sysfs_zoned_model(st, &zoned);
> > -- 
> > 2.43.0
> > 
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
> 


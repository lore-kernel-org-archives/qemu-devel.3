Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F50C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPYL-00014S-Vg; Fri, 09 May 2025 11:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDPYJ-000140-Fh
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDPYH-0007Gg-MQ
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746804136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFBhxObaHBYp9ykxq4B/dCIaeJQ4+mKgvskDHyqrG9U=;
 b=ZALw+TZ28hxDBz0FLEof0bPbsXfObDIaFgLkY4qSwIvPY0s6WymQu7z9ATaj8z/dyAwOYA
 SkdiIEMc2frVDzeVx20k03NIEbbsQpGVyy2LKF2RMO7/190LnlGS3Dk1gZJk99+wy4LlQ9
 7ci2z1dMKRxR7o0tYYGODaeK/oFXjlE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-kzWNLP-TPwiGh3bSW_xEGg-1; Fri, 09 May 2025 11:22:14 -0400
X-MC-Unique: kzWNLP-TPwiGh3bSW_xEGg-1
X-Mimecast-MFC-AGG-ID: kzWNLP-TPwiGh3bSW_xEGg_1746804134
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6f541b32bffso55041106d6.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746804134; x=1747408934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFBhxObaHBYp9ykxq4B/dCIaeJQ4+mKgvskDHyqrG9U=;
 b=l9dnzd6yGtEVpShZiDSIk4co4hP1QcAUZY1YOZWrzeju2U9aV9JAz6Jnf00JA4HgRv
 OyzvMobRahZUgWnto/NxwvjPOFeiZeSoksHAzmRwe5g+Oazve1qwtwcuZqMIWjR5/Nyl
 8RYPyqqDA/hg9nVAEoPZ6VTWN4xYrKR5zc9EYj85Pg7TedbOf2+QJksqukq9HE8WxaLe
 wbS8wErjvAvfS9PVz7D21fHADcUzRpSdaLkQBLPNCSfVM2lAsOfZ5vZBAPvBTZ8ocAZZ
 mPmax+b3W7rwFn87KEGTQ9+9qPh/J79pgseUi3Ji+oMp8WPw+jZFygwXouMg4rsim59z
 UQAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/GyhjvoAJ1M3S1lsLm+ofXDs2XPKK8Ot5tvgBvnva5QKvZbXytChE+dOruRmn4wd6aSX8pOWxNVDm@nongnu.org
X-Gm-Message-State: AOJu0YxUNHDJmn2OX4tFBscB33ZR29+HBlMrw3d+NZoiFLeQ1edBrseB
 XevPHFXCkwuMkgDw+2CRq+Adj+eG6cbpe5ewx7VCBC8/B+5XLSPlNm1a4yGqQLnDRLSgO3K1hMc
 UdO7qB8bmUaqB9Oeuv9gSwGwYqcweQ0WUemfHBg4X2Q9AsuFl3Snw
X-Gm-Gg: ASbGncs842oUSbo+v4J7b8OkYQNqcO4IU3lW5zBwFga/eqtG2lZ99dertUhE+W9jUJx
 Ddz72owfqn8oYN2KFMJWujAFkVHy8iJOOacZiXHb6/2p7UhSUzLL7VGSlq1c/S03v8PSCNe9GSo
 XltRNBzP3BrK8P96aa30PlHxoJgEYGG2vY4uJryUv25H7IYjS7k5qqjDSOPLHaaWWQ64Hf+gHDV
 rlWSyqNuS/HRon+V063sT8uGU19TSL5fqxYSoY2M7Aeafi5Tmgd9rqbqgr4sVy8MW2gPzpqRdfM
 Vio=
X-Received: by 2002:ad4:5cc7:0:b0:6d4:238e:35b0 with SMTP id
 6a1803df08f44-6f6e47bd8a3mr57582426d6.17.1746804134214; 
 Fri, 09 May 2025 08:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4UZDkMErPqzrUqJg5yZmZG4TzFkqp9Z2nd5Ggbw9moEsFjGlIDD/3tTwsCvXqtKimfwmMOA==
X-Received: by 2002:ad4:5cc7:0:b0:6d4:238e:35b0 with SMTP id
 6a1803df08f44-6f6e47bd8a3mr57582116d6.17.1746804133794; 
 Fri, 09 May 2025 08:22:13 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e39f4689sm14886836d6.28.2025.05.09.08.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:22:13 -0700 (PDT)
Date: Fri, 9 May 2025 11:22:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joe Komlodi <komlodi@google.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, david@redhat.com, philmd@linaro.org,
 venture@google.com, pefoley@google.com
Subject: Re: [PATCH] system/physmem: Fix UBSan finding in
 address_space_write_rom_internal
Message-ID: <aB4dohpeqnWlmurA@x1.local>
References: <20250505222236.1616628-1-komlodi@google.com>
 <CAFEAcA_65vRzAp1DzcZSDPWG+vX1C6xuh_2afdHqmXVFKZADmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_65vRzAp1DzcZSDPWG+vX1C6xuh_2afdHqmXVFKZADmg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, May 06, 2025 at 02:21:08PM +0100, Peter Maydell wrote:
> On Mon, 5 May 2025 at 23:23, Joe Komlodi <komlodi@google.com> wrote:
> >
> > address_space_write_rom_internal can take in a NULL pointer for ptr if
> > it's only doing cache flushes instead of populating the ROM.
> >
> > However, if building with --enable-ubsan, incrementing buf causes ubsan
> > to go off when doing cache flushes, since it will trigger on pointer
> > arithmetic on a NULL pointer, even if that NULL pointer doesn't get
> > dereferenced.
> >
> > To fix this, we can move the buf incrementing to only be done when
> > writing data to ROM, since that's the only point where it gets
> > dereferenced and should be non-NULL.
> >
> > Found by running:
> > qemu-system-aarch64 \
> > -machine virt \
> > -accel kvm
> >
> > When built with --enable-ubsan.
> >
> > Signed-off-by: Joe Komlodi <komlodi@google.com>
> > ---
> >  system/physmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 16cf557d1a..ccd2b50da3 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -3204,6 +3204,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
> >              case WRITE_DATA:
> >                  memcpy(ram_ptr, buf, l);
> >                  invalidate_and_set_dirty(mr, addr1, l);
> > +                buf += l;
> >                  break;
> 
> very minor, but I think the buf += l would be slightly better
> one line up, next to the memcpy(). That way we keep the
> "copy more data from buf" and "advance buf the corresponding
> amount" next to each other, rather than separating them by
> the set-dirty operation on the MR.
> 
> Anyway
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I'll adjust that when sending a PR.  Thanks!

-- 
Peter Xu



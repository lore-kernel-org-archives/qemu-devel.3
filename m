Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F464C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 18:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgSn3-0002EV-TH; Fri, 07 Feb 2025 13:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSn1-0002Cy-Vt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgSmz-0002bO-MF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 13:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738951756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bx5vHdO5eJaLTzvBLhSK0C6q5C4sbAoLh4AvJEclxGE=;
 b=Slrq19NQdrGFoxczOssl6/5lmIqdhB7JHYqB1JH6T/PGUvZQ21Xv8cLJoVg2C8Vyz/Co15
 McpkpwYkUb5Xpzn52He3J1clVAq4hPpSKYab+E5n636AZEUrBdO3JdM6VEwZ+9Cb2Wti2C
 WbTZjrjVYjyoAavENmPw4uZWY2iNjkA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-J3td0QIBOqGFcnvV08PKmw-1; Fri, 07 Feb 2025 13:09:10 -0500
X-MC-Unique: J3td0QIBOqGFcnvV08PKmw-1
X-Mimecast-MFC-AGG-ID: J3td0QIBOqGFcnvV08PKmw
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b9f0bc7123so467771585a.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 10:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738951750; x=1739556550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bx5vHdO5eJaLTzvBLhSK0C6q5C4sbAoLh4AvJEclxGE=;
 b=qvgAN8ycbMZY0xzxUSktndQlKz2OKH8zBXGRnuW6b+FSI7mgVbLD7w7COWN8N7JF4k
 /8hE5TXPbU748LsPFc8ZuB5MmH4GmtYoo581/X6/vOzBEodmqnsIDbLzIINilIWMGr57
 rpKzpp9ZHjjsgpvW/xZzB0ftz3JyxhBauhqV6czi4lumK3uwHkyDYe6cREcqQkYWjTHf
 rxvp3bzVzTIIW1eXS4DUDIqdftfypSTnSULfRkNBW0/cYgmo6BUrhwK60MRvrn37o404
 obSZF6EcqEEjKO+l7Xc4xt9w74u0tdj+ITAOALI6Ck+elDOap+FjZ00BSN6mUCN8Dz78
 qR2Q==
X-Gm-Message-State: AOJu0YzqdeL+cw+3BWfn3X+bZ9nRiZg1dbMB4YLdizes57JwLrnYo341
 bgiwndihTlCpEYBRjhAETFzRjI0iWxeg1uXb/6J7NnRcujWShZp++VovvIYCDkP6WDk5c63HzTK
 psxyyaZJQDrS6gnl9FH4VST570wWt1Zg6P/lDf38CWS/TUXPybWse
X-Gm-Gg: ASbGncvowc4Ej43LSUC6vacxfl7/13WDtoqsXW5ToGqodhq4n+JQ8iUyocojC0Q3kgm
 8KOkJFmYoLpA8zTnzMfGJa9MVMlEEX/gyiuJ47oTvGT94XgWEQJbFhnZYYF8NMjR+6e6an9D9DA
 Qelps6a/WxyesukhDiCGD8fqpAFH1sDJzrm6tc8xSE4mLNULrIiyZY1Iv6rke7yiT6tlkIGLfDm
 XKjB5k6gTXnOW5zdoh6VGeBvbIvfFe2JwiwWZ/9RYU+onal3rJaXM2O5tu+mIOQ5nQV4bIztYOI
 nkofZdVtolXb3iVRMO8gQ5y+viZphw8NuHP+N04jNjV+RK9Y
X-Received: by 2002:a05:620a:40cf:b0:7b6:d6cb:8b99 with SMTP id
 af79cd13be357-7c047b537c9mr566556785a.0.1738951750432; 
 Fri, 07 Feb 2025 10:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt1dShhQtWgI0uqRLPz1YBFRuIxXyPFnXnMoFHkybnCbJ/yv8uuYT3d+mz4BgMODUQJ7cMRw==
X-Received: by 2002:a05:620a:40cf:b0:7b6:d6cb:8b99 with SMTP id
 af79cd13be357-7c047b537c9mr566554085a.0.1738951750137; 
 Fri, 07 Feb 2025 10:09:10 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041debe1asm220160485a.2.2025.02.07.10.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:09:09 -0800 (PST)
Date: Fri, 7 Feb 2025 13:09:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH v2 1/8] crypto: Allow gracefully ending the TLS session
Message-ID: <Z6ZMRNnjz6swc73L@x1.local>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-2-farosas@suse.de> <Z6ZBLjToT9bRoyhI@x1.local>
 <874j15myfm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874j15myfm.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 07, 2025 at 02:55:57PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Feb 07, 2025 at 11:27:51AM -0300, Fabiano Rosas wrote:
> >> QEMU's TLS session code provides no way to call gnutls_bye() to
> >> terminate a TLS session. Callers of qcrypto_tls_session_read() can
> >> choose to ignore a GNUTLS_E_PREMATURE_TERMINATION error by setting the
> >> gracefulTermination argument.
> >> 
> >> The QIOChannelTLS ignores the premature termination error whenever
> >> shutdown() has already been issued. This is not enough anymore for the
> >> migration code due to changes [1] in the synchronization between
> >> migration source and destination.
> >
> > This sentence seems to say commit [1] changed something on the tls
> > condition, but IMHO fundamentally the issue is multifd recv thread model
> > that relies on blocking readv() rather than request-based (like what src
> > multifd does).
> >
> > Now src uses either shutdown() or close() to kick dest multifd recv threads
> > out from readv().  That has nothing to do with what we do during complete()
> > with those sync messages.. referencing it is ok, but we'll need to
> > reference also the other commit to be clear pre-9.0 can also be prone to
> > this.  To me, it's more important to mention the root cause on the multifd
> > recv thread model, which requires explicit tls terminations.
> >
> 
> I didn't want to go into too much detail in a commit for crypto/. The

You already did so by referencing a multifd commit that changes how
complete() works!

> motivation for *this* patch is just: migration needs it. What about:
> 
>  The QIOChannelTLS ignores the premature termination error whenever
>  shutdown() has already been issued. This was found to be not enough for
>  the migration code because shutdown() might not have been issued before
>  the connection is terminated.

Looks good to me, thanks.

-- 
Peter Xu



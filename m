Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A45606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gg8ji56s;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tWUgBa1E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqoq-0003G2-1u; Tue, 24 Nov 2026 08:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVqon-0003Fc-NT
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVqoj-0000SF-OV
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795527840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0FMTDULG/pucx2dip+XCKFbavpsZyl56W/eDimkin9I=;
 b=Gg8ji56sQ9M2srjUvBfYZf/2qMlqbGXTkSxos9bi9f3SE1Jn9ARYSp6WwJ0Vb4htRZNQfA
 C7c1Gk3+Dq6swmbTyx6i9LWHTrgVKVSnEd58avKX7V2DarfVVX2v8nzmi4bITLTx7vpX2x
 JTy30CzQp/AGUe3yAnIoXqskZ8oMhOo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-fGltIgmYP0aWRFQeH16Ktw-1; Tue, 24 Nov 2026 13:43:58 +0000
X-MC-Unique: fGltIgmYP0aWRFQeH16Ktw-1
X-Mimecast-MFC-AGG-ID: fGltIgmYP0aWRFQeH16Ktw_1795527838
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f37c94ceeso922574585a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795527838; x=1796132638; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0FMTDULG/pucx2dip+XCKFbavpsZyl56W/eDimkin9I=;
 b=tWUgBa1EgFlvqHmfsrMIAVnjj3Jj7CcRLx9ELhBEZ6BJTaUVYaxk5/SnHqurdCaDoG
 s4NNk47SYFwSxrQ0+pMewRkri5PYmgSRI7qDF1MPkEj6neaFp7DuYHs8CfHWcz74GpZU
 9UvVeIuCtfoTMxWfAvliUjCQ8I+MqRhzaQFISq++1qNnkxBx9wYtdrcc38FbOwOGdmUH
 XArsmwE4CLTZvze8f0D9YMKaMfEE88fuvyv+xid4JPF9wb9KThhUurHXvSmUzE40XTSY
 u2a+7R8SYChBEKWiWOj3CWoXIASb4aqHz2r4LibTD/jLoSlNWrlAMpM2D4piFkvVgFtz
 Nlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795527838; x=1796132638;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0FMTDULG/pucx2dip+XCKFbavpsZyl56W/eDimkin9I=;
 b=Xp1jHNfJd678hypajWW+RvBwi6mf1hfIgUhUqLt0J4Yb8rmF38QbEcZVQUfZFpH3VS
 v9vdi9r1S8kIvh4Ke2GPhqFk7t1Udxcm/IVv2M++ubLctfPbSM0yPxehalsmuN84oaKN
 M2JKq13lQDYBI4X0IHMH9ndC6+E9tkMQwl6aUGRjmUnmTnX5TF70iHOr7T0vZIc6go0M
 PKYfbitO0WiYoH2COOm/ZPET8EkhUg4GY7/VzHnW7N3zISPeufdBGa5GcrzcrUe65/UW
 LeqrrJvnEUdg5sAnyY72XQ5ZBWL140CF7A+rLkdp+7UJu7CpXHAe3XlYxSs7yFkDoytW
 J2yQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFg9wD1KS2xqwlqA8v8z4vUDBI9CO47b96FLr0+e6BhHlk4zFyHcmBdtOUvPBk5TA1u/gYrAlXTrYuB@nongnu.org
X-Gm-Message-State: APuU4Z8fvw3fdrKyogucbk6cibLaXMcCGwtJLxlQtEmYG5vFifoHLmNO
 X9RghON+VJ0+nQTn0Vtxm//gG86g84/3M4FYU49pfLEknR0sh4/4aOPkbgchz2gqYfQODeuA2G4
 oGDn3aGfh/YTXl08ik78goBY3qx1b1g/R5F507/ik5RaXDBJWGoPq7YsB
X-Gm-Gg: AZFdTZc16mzZe8cF909ITTQM26qpHp0z51sLYF/yiHjsWTCKbgFQf9YuboOGujmsHw4
 s6F23pz0H0ZJp+nTFaosdFta9Qerl0KHblIgnQZwqaXFh2R/SRTG2AAI7gogIh6mYXFXDDYf9cD
 KVZNcjaLls0HeJsrr2N1TNPKpqokkMYnbbq+gyzIdKWBQvbVSlCbbPWC6E87QEd0gH4DRfJEU/L
 F+n23vgXU0td2k+n+uiaWMkBVWFBQGYFyUt+0Tt/kBH0smdevbkNVsmit7IGioDNDdJI3FB9YaD
 OA5AzTuYiJWrD+C6YV1DsJfaTCvqUhxCWNc48xcTpHeJ5OvpkBioOPPmv1pGLL8PmQvAROvnCvA
 DsUx4Mo5h9eZhVtktmNHHninH1Xi6VI2s54nIxsSnNuCJ
X-Received: by 2002:a05:620a:4409:b0:949:5f22:e849 with SMTP id
 af79cd13be357-949b37208dbmr2607780985a.35.1795527837674; 
 Tue, 24 Nov 2026 05:43:57 -0800 (PST)
X-Received: by 2002:a05:620a:4409:b0:949:5f22:e849 with SMTP id
 af79cd13be357-949b37208dbmr2607776685a.35.1795527837172; 
 Tue, 24 Nov 2026 05:43:57 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb418241sm1023447185a.38.2026.11.24.05.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:43:56 -0800 (PST)
Date: Tue, 24 Nov 2026 08:43:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2] docs: migration: Clarify the security posture
Message-ID: <awWUmfW-p-dbJT3P@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261124130622.2296899-1-farosas@suse.de>
 <CAFEAcA-g2KmgAH52gCTTa7O+xjUWoRuNxfgdKoXTbsmNM7gv6g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-g2KmgAH52gCTTa7O+xjUWoRuNxfgdKoXTbsmNM7gv6g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 01:18:45PM +0000, Peter Maydell wrote:
> On Tue, 24 Nov 2026 at 13:06, Fabiano Rosas <farosas@suse.de> wrote:
> >
> > We have documented[0] the scenarios in which a migration bug is
                      ^^^

> > considered for a security vulnerability but some ambiguity still
> > remains, mostly because of the mention of live migration in the
> > untrusted entities list. Remove that mention and expand the "Security
> > boundary scope" and "Sensitive configurations" sections with migration
> > content.
> >
> > 0 - commit 8b6405a493a ("docs: Add security considerations for migration")
> 
> What's this line ?

My bet is the reference [0] used above.

> 
> >
> > Co-authored-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> > v2:
> > Picked PeterM's version for the "Security boundary scope" part.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



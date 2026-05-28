Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A22CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSSxO-0007ab-FR; Thu, 28 May 2026 01:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSSxI-0007Zz-7v
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:06:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSSxF-0007EG-4e
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779944807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8fGcERcfxHKMm/Fpn6VOXkH2gSc7gYWjAphcS5JNhGM=;
 b=SW2qI7ktQ/208LXDrkKfRq0p+TW2O7vik2sy4lXo30aOI1g0nNP4HnqxWvoX52UT1l0UYR
 7oWhcrMnNO0puhw27upwFZOdruzkrjCusrPr8mQa6s97ZN8hODfMM2PVRRWL2SAE4jdm3D
 eek/RpFpaUJ/lKJ2eZP3qKHggqYm+FQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-8n-q4lYnN9aupl1XiN1T9g-1; Thu, 28 May 2026 01:06:45 -0400
X-MC-Unique: 8n-q4lYnN9aupl1XiN1T9g-1
X-Mimecast-MFC-AGG-ID: 8n-q4lYnN9aupl1XiN1T9g_1779944804
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49041d39887so46018855e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779944804; x=1780549604; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8fGcERcfxHKMm/Fpn6VOXkH2gSc7gYWjAphcS5JNhGM=;
 b=ZF7sB5L54zNqg2bY8kqXzvG6UErMWESrvA+2xq+A7j8EAcS9DPKUIID/0ODbGUci0N
 MChHv8E2Pxp90jwJ37Eodp5ewbYplEt0UID/guHqP4S6KP8bmWx1gGNiv1BDsACMMS2a
 5bulIS1a26QYjmgNLO08E9K+c4LhmvgJKGuOdBrpR0nsoZ49atdomNvaoRvX9h0wnysd
 eQSS/ByZ/LRrTOq9NPZFsVy3nmf7+3ZqwksK7bkjQSXTyDyTueq0FJxA7X1HhXvTM8Ow
 59iGbs2lXCORtGhSNTjFRh16rtkJl5YrxZOq6tfN02Ov9Di3wzo7M8H6sWUG5RQ3LJ0B
 Z3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779944804; x=1780549604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fGcERcfxHKMm/Fpn6VOXkH2gSc7gYWjAphcS5JNhGM=;
 b=VMAy7Ig5oEXfE8+Ivp56m83v/n+M4PsZA8aXDmBr35veFh7gJDq6lyamLZ4G0yuS21
 a/tDhAEbmYe2hybxmD7ZMCgp2Z7MihsQPTzDLohveCRNVUjInJ3Ir7gMHW8+Iok5kfc/
 L3RUBMWx9Bztf2eWC2V7+v4DUN4sv+pPbwnXi7c/UM5HZVKHnXt5mEetVtKH46RKXRa3
 1KkrH1lK+eVZ2jtuemBGwBTUagyxvdWp3/FuuKCdtrrfavxHY8bDl3gnDQ9dFedahfKP
 lf/MKs8cU+aXOoJjuPbitZKEcVJ31RbuWnu/u3WklgLhLqC9RcR5f6nUOeNfXy0yt+Wx
 G/mA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ew6N+S5n9++bJPwTJRM+zPwLZXgCgKCVPlUm3xZGBmnSahctn7Q7ONrFCaxfktBIOSZSBV5XlNS6j@nongnu.org
X-Gm-Message-State: AOJu0Yxz5d0sT7XpMUyuLMOPyZumW75S/WR0+YGsvluVIkyO+Du7Tcgu
 ViqtWQcD8PM8TQXue/SNj9PxkOhpre7HzMpn4HrCPsb4RSihhHL4tpmRgE85QIBYWUKM/dTDJOZ
 F9+fhHenhgp4uNZ1Xpip2TbI+kcdioIKohl/ZU5Rcn5fPQfDjFX5PZFM+
X-Gm-Gg: Acq92OEqZ7z3NpH9MvonCY6JQTqomPT9IYB7XPX4fxoDv2Z7Mz2/M5lyWUz80Or9eRM
 8MWQv1kabpU7ign6N30nLrfGV6xAlg7xJZ9M3xdZdrGX7Bm32GTvCyoH1mGILeWeDA3rmAlPmRE
 xqecg4vEC56Y5f2uFT7+bhEtphewx6ktx8d6C963SAGUgjhIaovFZSSfE4lF3uF3XJrioov4aVo
 q1MCbTTFYIlKPugEBmXAemfSDRWwBSsvur6ztQorvexQ+4dN2lLhouXAiXPqLsNcteUPkAmOFlE
 tkORwPa4j0xV3LU74ODuG+ZTih5GqTM/SVWmAm++75nLmUKZWrAZ/mWRpGxxXQVSBNFhAZXR98q
 VjIrulatjHzVGi7flE+vFbC9FJQ2EvSgtCnjz1zI4fG+RqBIMEQIP9A==
X-Received: by 2002:a05:600c:3e88:b0:490:48b7:c1ff with SMTP id
 5b1f17b1804b1-49048b7c21bmr413266805e9.17.1779944804145; 
 Wed, 27 May 2026 22:06:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3e88:b0:490:48b7:c1ff with SMTP id
 5b1f17b1804b1-49048b7c21bmr413266455e9.17.1779944803707; 
 Wed, 27 May 2026 22:06:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909284a8efsm17556835e9.9.2026.05.27.22.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:06:43 -0700 (PDT)
Date: Thu, 28 May 2026 01:06:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260528010422-mutt-send-email-mst@kernel.org>
References: <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CAKmqyKOsdJYbh8SAvzpv3rpF7TUE68sHR34rDy8sc+d=j1L9vw@mail.gmail.com>
 <CANCZdfp4OQEoOQk5v0B+n8GaOb1a=FiLjLy9jGG9G_AWY79xNA@mail.gmail.com>
 <CAKmqyKM8yQ7mDRv6anW-7QSjKcgwxj-RoVikJWV0xuT+CgJDFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKM8yQ7mDRv6anW-7QSjKcgwxj-RoVikJWV0xuT+CgJDFg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 28, 2026 at 11:59:35AM +1000, Alistair Francis wrote:
> > My worry has been one of testing: how do I test it all? Or do I continue
> > to use the 'just build thousands of packages' as the acid test?
> >
> >>
> >> So maybe we should add something here about don't send large numbers
> >> of "small bug fix" patches. So someone doesn't point an AI at QEMU and
> >> a spec and generate huge numbers of patches, all of which are just
> >> small bug fixes.
> >
> >
> > Wouldn't this concern fall under the general requirement to not send more
> > than a manageable number of patches at a time (like 50)? Or do you think
> > a lower number is warranted?
> 
> I could see someone reading the proposed wording and then sending one
> 20 line patch, then another, then another, then another, then another,
> then another and then more. All while only sending "small patches",
> but the ability to generate a large number.
> 
> It's not clear to me at least from the proposed wording that we should
> discourage that.
> 
> Alistair


Maybe we shouldn't? It's far from trivial to split up functionality even
in 100 line self contained chunks, let alone 20. And reviewing
such small patches is *easy*.


-- 
MST



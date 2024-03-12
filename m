Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FA1C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9Q5-0006O4-Sm; Tue, 12 Mar 2024 17:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk9Q0-0006Nf-70
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk9Px-00078x-B4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710277932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8yZyjIdA/e1H8Jln/jMaSv7+cT+Zz0CK3B5hADnkEk=;
 b=M+2XFVWlbCKDQ1rMkG/3cdvLwC1HDEDZeuBNz3QPTuO01PdIDbsHaEkGf20iu4FVc5llbH
 LFUgeWjo/vTMBfCnXFHd0yFirguT6rqy2eeUMNJRZ5YaJaiQZeqNaJLBtb5Ykp9SVghuoo
 UaCM4U6J6/0QwG8ZfDIo6xi4ZAqI+j0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-UQESWSiiN8St0BtDDuDcrA-1; Tue, 12 Mar 2024 17:12:11 -0400
X-MC-Unique: UQESWSiiN8St0BtDDuDcrA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6818b8cb840so18725956d6.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710277930; x=1710882730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8yZyjIdA/e1H8Jln/jMaSv7+cT+Zz0CK3B5hADnkEk=;
 b=nmoayltDI9GSpvvLqJKRMgcEl30Vx/stTEpzWTt4VJc8hYlEhn0IvBnRbdB0nr+7ot
 ujuYQj8mu640qRe3rWSXchKb2ENsXJGaj7a3AIZ9omFk1yTRWSztdN46T8sbGjUzwO9Y
 PJCYla1QiPIWVtmrcyESYrg4ivfewb5IjRgmilQ63+y7H29R+CZM9RBMje5heUckQiBr
 Bkikpi6So5w+pBV6iELPScNg7ZjD271vZwWvDDHzAJdQFmU9h8eDVqv78Icv+ir8/91T
 Rk2wO7nydExVv8A2qfx7v5Fh3RGJ4VcJAxKYF8RsK7a6YcKhX7wD0T61a6T0a6qx1DqB
 ckBw==
X-Gm-Message-State: AOJu0Ywx4s8Sb1omJqOxAMx199mymaRGSAW/M/Y0nuyBegorjE5K3VPL
 mr6d/Il4bzAFYTOd+TR/TiMX2OXIoiAL8zU2QFLOpXid1pBHVCaFTEKbnweII3DKoPCTr59o2cz
 KfZdNp1RZohnporJ4fDGAEff1vg/ibocWN9uK7ZEWVustpv9JZprmBTmiF+h+
X-Received: by 2002:a05:620a:4690:b0:788:5c48:55b6 with SMTP id
 bq16-20020a05620a469000b007885c4855b6mr12408883qkb.5.1710277930504; 
 Tue, 12 Mar 2024 14:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG12fjBWMTliPSE4PZgwq0jt7Tm8Y46hZU92chSq1wXsc0N78s1pZfqYh24Oo8UI3qszKoKdg==
X-Received: by 2002:a05:620a:4690:b0:788:5c48:55b6 with SMTP id
 bq16-20020a05620a469000b007885c4855b6mr12408864qkb.5.1710277930174; 
 Tue, 12 Mar 2024 14:12:10 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 wi23-20020a05620a571700b007883e882a3esm4038975qkn.100.2024.03.12.14.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 14:12:09 -0700 (PDT)
Date: Tue, 12 Mar 2024 17:12:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, farosas@suse.de
Subject: Re: [PATCH v7 0/8] tests/qtest/migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Message-ID: <ZfDFKHm1Q_bzmGcY@x1n>
References: <20240312202634.63349-1-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312202634.63349-1-het.gala@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On Tue, Mar 12, 2024 at 08:26:26PM +0000, Het Gala wrote:
> With recent migrate QAPI changes, enabling the direct use of the
> 'channels' argument to avoid redundant URI string parsing is achieved.
> 
> To ensure backward compatibility, both 'uri' and 'channels' are kept as
> optional parameters in migration QMP commands. However, they are mutually
> exhaustive, requiring at least one for a successful migration connection.
> This patchset adds qtests to validate 'uri' and 'channels' arguments'
> mututally exhaustive behaviour.
> 
> Additionally, all migration qtests fail to employ 'channel' as the primary
> method for validating migration QAPIs. This patchset also adds test to
> enforce only use of 'channel' argument as the initial entry point for
> migration QAPIs.

queued for 9.1, thanks.

-- 
Peter Xu



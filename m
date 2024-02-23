Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA429C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 03:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdM09-0004k9-7y; Thu, 22 Feb 2024 22:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdM07-0004jt-QJ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:13:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rdM06-0002U9-Hc
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 22:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708658005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a8Tl+UlHUFFT0kd3OBRZ49lkSQlQk/0s+U4D0SEs9Eo=;
 b=ZPBvbrrKVh+5NsweErhmrE5yjw2ie5gXLKr16oEy8d7gVtOOO15GYfxTPR1CuQyFGpS3dy
 iiJFJuhuqTouRdMBFJznOhuNYnIQV7C12QiX/95qusOX3vtBIw6OcVX2jLO9aKi31iwa3q
 2Uw+VocclfJIBEs/xtXn08+fmvAeGi0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-PYHDKltzPUyvIroJahmNxA-1; Thu, 22 Feb 2024 22:13:23 -0500
X-MC-Unique: PYHDKltzPUyvIroJahmNxA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-299565dfd2dso32338a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 19:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708658002; x=1709262802;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8Tl+UlHUFFT0kd3OBRZ49lkSQlQk/0s+U4D0SEs9Eo=;
 b=hVqUOAgDnjm1Dm9l3JE7psJlZbMk1k71mWxmpIdi19DdxAT2N4S+H5GVpYd5/9l4rG
 K9qcqoZpeL0nvjW7viUGumi2hLL301LkyaelsnIIZQF69yihfFVuM0QrjCHtE0R4UCi2
 l0g3gMT5ftOqsqXcsz3XsBDu6nZRK4Xfdfm4gAB7NwA+1ZJmWxBWhA3DgDPSArrGPDTF
 N6Ol9tLEDc7jtflcuNN203iVSpTOCVZA9wYHhpcyH+6tMTqdv2GFm4FbWw9eBvDS13d0
 txpLsiqlyl34Qmr89ukuoBfNYLB1QQ7ZGaA9uFkldYKkrNBjPGiHXLk10hAcMt43IlZ9
 MfAg==
X-Gm-Message-State: AOJu0YwhWKdQN+xeTZHu2B6DimHbdftmchsy0RCFXcs4pc76hgg9XwD+
 qV+7eMseqgrpv9+GaZ+TZTtXdyDxjgj9RwMBileppRUbppvy4ejlspJQ5oMEpoqyIVDevO7lAFk
 3lguKThv4vdiEQbYY8KKlFR1tNe0/UpSXdUtBC563Dn+isPl8fVkC
X-Received: by 2002:a17:902:ce84:b0:1d8:dcd2:661 with SMTP id
 f4-20020a170902ce8400b001d8dcd20661mr728046plg.5.1708658002706; 
 Thu, 22 Feb 2024 19:13:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuASOLFXl64KVndI/cEITduWmLA1UzqgnRpkWW+zisbIl4mDpoKUoEWlMda25apDaIC0kTrQ==
X-Received: by 2002:a17:902:ce84:b0:1d8:dcd2:661 with SMTP id
 f4-20020a170902ce8400b001d8dcd20661mr728034plg.5.1708658002425; 
 Thu, 22 Feb 2024 19:13:22 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 lh4-20020a170903290400b001dbd13852a2sm9943917plb.175.2024.02.22.19.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 19:13:22 -0800 (PST)
Date: Fri, 23 Feb 2024 11:13:12 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 04/34] migration/multifd: Remove p->quit from recv side
Message-ID: <ZdgNSOtOcfVNob3k@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220224138.24759-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 07:41:08PM -0300, Fabiano Rosas wrote:
> Like we did on the sending side, replace the p->quit per-channel flag
> with a global atomic 'exiting' flag.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



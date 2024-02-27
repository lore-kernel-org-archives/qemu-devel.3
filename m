Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8FEC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 04:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reolH-0004oi-SU; Mon, 26 Feb 2024 23:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reolF-0004oP-P3
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 23:08:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reolB-0003jX-Fh
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 23:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709006884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezoJzUFdIlD4+PVZ+kg6TTy+/bJD42qr6N7kdpfqubA=;
 b=dybDoB+JjXKaUqfM4tjYdwLJMjb4/CPm6S8zMV+eupZXuTixOPhq6jM/pWw3w1PH8kflph
 j8Oh3kFOs00iTy5lXwjt/eni3WxRm9tVNZglJXWaMNP7jsEQ054y8MPiUcPG4luo4xpMna
 78aDH5WAJ9qKwp5TYfJdKsTelCFMm4I=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-ZeNUL3qrOzqx6DFiM-YiAg-1; Mon, 26 Feb 2024 23:08:01 -0500
X-MC-Unique: ZeNUL3qrOzqx6DFiM-YiAg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c154f307c6so294623b6e.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 20:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709006880; x=1709611680;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ezoJzUFdIlD4+PVZ+kg6TTy+/bJD42qr6N7kdpfqubA=;
 b=iSnEZUcVfnJDsZqXxo5zwoYeVhGyCcUmYXbm8TvdFMX7EmNalr86Kp0N5gWnTXiW8r
 QaKhWYEvoVpF//IR6ofpzWeFQZJPxM11H2jrA84NiAuuMBn/6anEUUioujMq1b0Gjmbl
 XlAW8K8WDwEl1MjKw8liN14fVXXfsoa7c40HwWy5Ooe/Rq3MFGOW/ldDk81vtrg7IUEY
 kaPzSPbNU/UT+EISWPHS6y/fxeqqhe8OM1zS6p0m5/yBsN6RcGS67joWBRZWTFL8w2wm
 5hh8Bmd83UZhKvST7nrQ3eP+lMYZhprc1RKf47VC6ZBITexfoEM1AmCLXpKXAgfHM1IZ
 N1Vw==
X-Gm-Message-State: AOJu0YzyyP+El88SStTd53ZKGKGbIk+pIUcmjOzN6xODuBMIpVbhnAXU
 Fc+h/mgxKTXpxlNNJHX2KQZMI6UHp8Jpjpq2vWCLgNVGpAvQaTqxVMtU2O0i+38/qWCe7E3FThe
 uL6Kf3RWCU54OY+k0be8nzxgG2pAjQhxEq/AJGkfq0Gm0A4QeI7Mw
X-Received: by 2002:a05:6808:200b:b0:3c1:700a:2354 with SMTP id
 q11-20020a056808200b00b003c1700a2354mr9236541oiw.4.1709006880322; 
 Mon, 26 Feb 2024 20:08:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7GwigPQVfsVNHE2zAtk1j5toHlx2pyuhWEjFNoNpt/Sbe+vrtdvm1VQOHGfomS0koq2HzNg==
X-Received: by 2002:a05:6808:200b:b0:3c1:700a:2354 with SMTP id
 q11-20020a056808200b00b003c1700a2354mr9236528oiw.4.1709006880019; 
 Mon, 26 Feb 2024 20:08:00 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 r25-20020a62e419000000b006da96503d9fsm4826153pfh.109.2024.02.26.20.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 20:07:59 -0800 (PST)
Date: Tue, 27 Feb 2024 12:07:49 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH V4 00/14] allow cpr-reboot for vfio
Message-ID: <Zd1gFV571XK94dg9@x1n>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <c95b3c15-0154-438c-baa0-98f4c539355a@oracle.com>
 <Zdv0BNtJxkd8413g@x1n>
 <02bf2132-ed34-4ecd-841b-5f93eded7ea4@redhat.com>
 <ZdxTVHJ8p4lYRPxo@x1n>
 <0b7b2a2e-efa8-4280-b7cf-dc6bfb6e4bac@oracle.com>
 <23070076-4ccd-4c1f-af53-ffa19e961604@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23070076-4ccd-4c1f-af53-ffa19e961604@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Feb 26, 2024 at 05:08:05PM -0500, Steven Sistare wrote:
> On 2/26/2024 3:21 PM, Steven Sistare wrote:
> > On 2/26/2024 4:01 AM, Peter Xu wrote:
> >> On Mon, Feb 26, 2024 at 09:49:46AM +0100, Cédric Le Goater wrote:
> >>> Go ahead. It will help me for the changes I am doing on error reporting
> >>> for VFIO migration. I will rebase on top.
> >>
> >> Thanks for confirming.  I queued the migration patches then, but leave the
> >> two vfio one for further discussion.
> > 
> > Very good, thanks.  I am always happy to move the ball a few yards closer to
> > the goal line :)
> 
> Peter, beware that patch 3 needs an edit before being queued.
> This hunk snuck in and should be deleted:
> 
> [PATCH V4 03/14] migration: convert to NotifierWithReturn
> diff --git a/roms/seabios-hppa b/roms/seabios-hppa
> index 03774ed..e4eac85 160000
> --- a/roms/seabios-hppa
> +++ b/roms/seabios-hppa
> @@ -1 +1 @@
> -Subproject commit 03774edaad3bfae090ac96ca5450353c641637d1
> +Subproject commit e4eac85880e8677f96d8b9e94de9f2eec9c0751f

I see, I dropped this change in the patch.

https://gitlab.com/peterx/qemu/-/commit/ccea71f8f222593c47670366d7d86554586e596e

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5A3C47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 02:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reQVw-0008FB-CK; Sun, 25 Feb 2024 21:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQVu-0008Cy-B5
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:14:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQVs-0003qG-U3
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708913680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ilj71me9wfhyaZmctS1PgoDwsf2Ceb8ndsQMYPQRVPo=;
 b=Rz+vn2KPCdMeGU8frO1squMW8TRxkvSRBBw+CAdTwshaMrglVubzb8kuONiYKCCPHKJpl/
 n4IWjlc3sbTKb6zksA7O4MVdopglTXSPSaGRhK3kHbzdOnQ0CMPv8cuObcpLxE2t0hRlhv
 b2aAthxeqbILbG99yYKS1j9dAp4uFNE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-39R7oTROPAOt1_laSdKBBA-1; Sun, 25 Feb 2024 21:14:37 -0500
X-MC-Unique: 39R7oTROPAOt1_laSdKBBA-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a04aa185e9so150726eaf.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 18:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708913676; x=1709518476;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ilj71me9wfhyaZmctS1PgoDwsf2Ceb8ndsQMYPQRVPo=;
 b=OnHvqeAmBoL3pWo1Dt8XZtLXuKip3n0W1zlauDtrPz/kIbx14y0+6bPS8QRIrwrQI7
 j2ADlUWXS5NTPDsyAVZMQyHG089V+hHXduNqmUU5t+2fvTy+19cqiH3BFEu/kKi8S0qD
 hJJdxF+iVUktuExKjsJnwHJc7KwXLHgBEBW8OlH/cHwag3wnhMwacMNdLdkxqC5nJ/A5
 QMEhrpRQ01NTuRe8gTwOr4Le2cYoX4pGHhmSz5UjudD6/L2ZrCzJHg2RPYtTS6Bzdf3H
 FYya+8E8mjQPV+Q62Gi6OwjIXFacGjZKMrIHFD5mhc8QmVVP1RU4dDqtd1nVs7VR860q
 MG2A==
X-Gm-Message-State: AOJu0Yzo5NOddyeWWxFYI3pdqh0sejsFE0rs+EgT/Eh4EKRiLwxcOLkL
 5Jc0+vpEu5mALfiPWvLSz4B0UeRa1qqvd2kxDG9BPJdTXHdaKn3q8vPhoirncPWGlLiIN9pWZYb
 WQn70BNg2AeMsBrTRpg3is8LB20sxeC0xQwJM04K/lb2w4Vzviyqt
X-Received: by 2002:a05:6870:f144:b0:21e:ad52:3029 with SMTP id
 l4-20020a056870f14400b0021ead523029mr6224330oac.0.1708913676287; 
 Sun, 25 Feb 2024 18:14:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQVC/ndZx8+GeWZJ3bHCaX4A+qv/wCFQgLwFCfOKrnUpw9AeSPcPx2fMc3Ls+dta2yz+X5UQ==
X-Received: by 2002:a05:6870:f144:b0:21e:ad52:3029 with SMTP id
 l4-20020a056870f14400b0021ead523029mr6224321oac.0.1708913676077; 
 Sun, 25 Feb 2024 18:14:36 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 y17-20020a63ce11000000b005d7994a08dcsm2939461pgf.36.2024.02.25.18.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 18:14:35 -0800 (PST)
Date: Mon, 26 Feb 2024 10:14:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V4 00/14] allow cpr-reboot for vfio
Message-ID: <Zdv0BNtJxkd8413g@x1n>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <c95b3c15-0154-438c-baa0-98f4c539355a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c95b3c15-0154-438c-baa0-98f4c539355a@oracle.com>
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

On Thu, Feb 22, 2024 at 12:33:42PM -0500, Steven Sistare wrote:
> Peter (and David if interested): these patches still need RB:
>   migration: notifier error checking
>   migration: stop vm for cpr
>   migration: update cpr-reboot description
>   migration: options incompatible with cpr

These all look fine to me.

> 
> Alex, these patches still need RB:
>   vfio: register container for cpr
>   vfio: allow cpr-reboot migration if suspended

I'll need to wait for comment from either Alex/Cedric on these.

As I asked in the other thread, afaict crp-reboot keeps changing behavior,
maybe I can merge migration patches first, then keep vfio patches
separately merged / discussed?  I always see cpr-reboot mode experimental
from this regard.  Please consider adding a patch to declare cpr-reboot
mode experimental if that matches your expectation, until all relevant
patches are merged, to make sure the ABI becomes stable.

Thanks,

-- 
Peter Xu



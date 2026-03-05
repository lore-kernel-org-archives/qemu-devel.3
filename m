Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC85AF3D336
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyC5c-0000CJ-EB; Thu, 05 Mar 2026 12:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyC5Y-0008Qh-J8
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyC5W-0003uC-Vg
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772730133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WCx2zXd9UI3yNUIqstamtFkzr9csU9CCFfuDYg8y/h8=;
 b=gCYSxd2qx3A5YmZuDAcpdZO2tzQ+6ntPufA/woZ2E4uaO1I6g8a4LHjsQNtrWP8sd2wAPD
 VnTjmX7jtTxoit39cxkCiUK73Yv/BeJu2Oy8LT/AvtSGnRk69nv0I7JY/1GEepFqoNwaOY
 l4PBFZbIrkyzLEQ4pc1n5noBVKMJ01A=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-aUUCIGa6N9aE3f4In-_v5g-1; Thu, 05 Mar 2026 12:02:11 -0500
X-MC-Unique: aUUCIGa6N9aE3f4In-_v5g-1
X-Mimecast-MFC-AGG-ID: aUUCIGa6N9aE3f4In-_v5g_1772730130
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-679f6f264ceso137181844eaf.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772730130; x=1773334930; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WCx2zXd9UI3yNUIqstamtFkzr9csU9CCFfuDYg8y/h8=;
 b=kNsjU7xGyBxW3zizXSQdqgCvnv27sR0BjwfNkXqSKxTOIA/pXcLCrKynaDpEjLTaqV
 B5mtPaI5hMG+i37f209NrkSdSM6fazZCXttcWf54cyHRGNN9p1/L1fFMAyOCFCeVRxZx
 E1y+2Y0y5t9dN7m5V7+PwTmLUUhR2V684McoFHO9k3WQsQdOxf4HKK+RdfHtyMuhs4NV
 9L72SDixnDf3pGGRXCWvUfA5N0Eo31vdZdAx6sH4um+sF/AAGQuB8sg5iBmiIjDeXhLB
 J7U+HBetMEJVKaeyBfQyzr8CTVjGYINxMBGuVG+Ty33qVkhlbHWMeEwoud1phDiF8AOd
 HcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730130; x=1773334930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WCx2zXd9UI3yNUIqstamtFkzr9csU9CCFfuDYg8y/h8=;
 b=whMIqXdueo4hqu8COnMx1iHsQ0cmAY+2u12+C21EKceYCw9wuvPF714KxJ227Zd4Pj
 TsWVFEk6zhXb0oAO5KbYhpJ0TmC3zf80cjdhao074ySvB0yzrOXGEnTwjj01e6IEOueE
 2LO19ao9yq1zm/jeGSfnR3sEy2DGYySRUYxbzM5brhDwdjejRWU8dYGfnB6s9du6qkT4
 emp9vTGuDi05OVuyKjO+/z79Slp5iObte0XslrgjJp8OdxVEvPfWSBoEkYSpUFNbknI0
 csOfeSvBsiMdPx9SZKvph7cmCq8KivqgieIPVZSpFFeifFVQSu3rzBrfD7EyV+Fd/y/5
 /quQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuevGWF+Pgx6qBZ8xLsfHUZdBXQbWeIIGaxiMvrywioeQ2OxJ6OUg4I0ZS+Gmskm3D81GStBrzEybq@nongnu.org
X-Gm-Message-State: AOJu0YxJmDjO0u4hbY9I9lVOwXrWjRyjzO5fFKuqyfXSQAmkYPdm3zdR
 CkhDPpuWUL+PEwYYto6m7Ya8l/HJd5RQagb+KPxNuIX+QDBltk8yNCAGpa9I0OodPv7nhzscGIF
 1D86Xd8YpapjfHTuTeDSDzLJ5bEoXdG3LaFk1PK3+ng9ryP5ZJmz4NPdo
X-Gm-Gg: ATEYQzxMA3ipcGgmIe9SHhQesLJa3EM2qKBct4MT7/+G2UKJ0hnCHjOpVh3D7vyMUgb
 LtkovVD5XATdhJcuOt/n3eeUEppOFDiVDLXROygK2J1broRmwcoklfCIkDEkjPM6C127frsUrun
 hFtdC/gUHChjQXQ+6+pNldgb1zUDGJ7sHgGGwpulrWH7YOfhYMmhwJq6xYdyANDjrOUeK2TCnMY
 lfCUHBsLhLGpi/X/LRXalvdpnbThn1FeX2HKik6zVkU559mwofwhjFaVp5+h4XeS0tzJYTzpCjE
 2AbE1KXTrFmZ8EkZJInf9RkPDwP3K86XVO/fxTW6J0vNW1ymUkIuqxkVCMBsUzyJXKhuTl2U7UJ
 D63tgUg/kA636lA==
X-Received: by 2002:a05:6820:619:b0:67a:1bf4:eb03 with SMTP id
 006d021491bc7-67b99cbc27cmr222814eaf.45.1772730128784; 
 Thu, 05 Mar 2026 09:02:08 -0800 (PST)
X-Received: by 2002:a05:6820:619:b0:67a:1bf4:eb03 with SMTP id
 006d021491bc7-67b99cbc27cmr222757eaf.45.1772730128105; 
 Thu, 05 Mar 2026 09:02:08 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899fdf30e99sm94801706d6.3.2026.03.05.09.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:02:07 -0800 (PST)
Date: Thu, 5 Mar 2026 12:01:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 13/18] migration: introduce vmstate_load_vmsd() and
 vmstate_save_vmsd()
Message-ID: <aam3BKi5kkszjYAM@x1.local>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-14-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304212303.667141-14-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 05, 2026 at 12:22:57AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Introduce new APIs, returning bool.
> The analysis
> https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/
> shows, that vmstate_load_state() return value actually only
> used to check for success, specific errno values doesn't make
> sense.
> 
> With this commit we introduce new functions with modern bool
> interface, and in following commits we'll update the
> code base to use them, starting from migration/ code, and
> finally we will remove old vmstate_load_state() and
> vmstate_save_state().
> 
> This patch reworks existing functions to new one, so that
> old interfaces are simple wrappers, which will be easy to
> remove later.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



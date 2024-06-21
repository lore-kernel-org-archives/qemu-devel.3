Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2580C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfTG-0001gZ-Q4; Fri, 21 Jun 2024 10:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sKfTE-0001fm-Dx
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sKfTC-0000Fr-Vo
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718980950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GaB1QwEZMEk+G2627RoEiSCiJdca3CsBhMb/Otlq3ME=;
 b=OK9mV19t5NfK/7Bnj/tLGLLBmkIL9Rn6SyUah+sftEyUNEKcBDtUOTAlSFmxRleTtqaTES
 E8q0PUHDwIo50O5lHTmfB/fpsN9Jq16priL/TpgvF6Md1AFZ1yWhw3Y9eQ8wFtZxiHxKpR
 P0+mf14AWTKpaNT5S7HzCvPWgwPQcRQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-sSFOz_zcN22rgwZCCsW_tg-1; Fri, 21 Jun 2024 10:42:28 -0400
X-MC-Unique: sSFOz_zcN22rgwZCCsW_tg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43e2c5354f9so3595801cf.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 07:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718980948; x=1719585748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GaB1QwEZMEk+G2627RoEiSCiJdca3CsBhMb/Otlq3ME=;
 b=iUoUCm0oW97S0FWG81ANBc1xE8rFDmbzq7LbgAtDMX3MdSQmRFswmFZXtkqiIQ5QQZ
 A6FxSaBf0uwNQJUQqXuMM69mTQP4H9WMDdcX/ki3JyQ8oXZ/Z8XBEcZatDSC3DbGtEH1
 sJ3nhW4neNb4FbZn+0S++iSQ4kHsCTK84QTvpLkF3jiNfoLiEKNPYN5sN1Llaz7aiLTe
 WzetA1anuJMxuJdaWbcOpkX2rNxsYSY2B2nwPlM1Cs/DzPzcVXMgn/FfiUa8S5fM77sc
 PWgBg25quJGE9hZJ8SPz7RHN7hlxQmj9Ttj/NJpmUG+z9k0IEBsLnoszxVBTJ65HCskJ
 L3IQ==
X-Gm-Message-State: AOJu0Yw9W7to8skBDhag7vrHCR2NiOPKvOF8agBhqK/FU3a5zIiJrY/Z
 C0E9WmzNaCJG1c92SUWpYUqqQLKarUMSQqXj40QMuzdXUf76k3uax7souCzpOEQKq/NYtFo79gf
 ZWgwmCYflJWTt/K7b1qZwPLDRaMHi4aeVtYfyoj7Dkq33Q2y26vPg
X-Received: by 2002:ad4:5ec8:0:b0:6b2:b56b:c8a5 with SMTP id
 6a1803df08f44-6b501ee9694mr92962836d6.5.1718980948247; 
 Fri, 21 Jun 2024 07:42:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8n6MOdkQFtxq/Mj7nvJ9Sg6KyGhUlOV4/Js4m/HOO9wFqtJcZRq/TK64HX/2QbriMYxL/Zw==
X-Received: by 2002:ad4:5ec8:0:b0:6b2:b56b:c8a5 with SMTP id
 6a1803df08f44-6b501ee9694mr92962496d6.5.1718980947729; 
 Fri, 21 Jun 2024 07:42:27 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ef31182sm9291076d6.95.2024.06.21.07.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 07:42:27 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:42:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 1/7] migration/multifd: Reduce access to p->pages
Message-ID: <ZnWRUbS8q1ptIpvl@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620212111.29319-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 20, 2024 at 06:21:05PM -0300, Fabiano Rosas wrote:
> I'm about to replace the p->pages pointer with an opaque pointer, so
> do a cleanup now to reduce direct accesses to p->page, which makes the
> next diffs cleaner.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



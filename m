Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097A0E81BDE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpU0Q-0001Cw-9M; Mon, 09 Feb 2026 11:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpU0N-0001CZ-Lt
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpU0L-0001qX-UJ
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770654052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlEVlG1GL0W1IRT9/GajYv4XhMBYK+uoSOjt/RlMjLQ=;
 b=efGI8RSnk9HUsh3pjDofc3cb6g8VILloq4Hg3lzOp9lJyGdiHv4s39xTGcC8VdNh6STQub
 erG2XI0hndH0DCY6qVQsHc84w+mazTrLCr+CASvN8jRCyYTvbsZcK2RrgwrSpqdw8AZhDe
 iBBk3XD61i6xBP31GdiOaLztRULKWf0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-jJLovYnlPQWUSJjy-TfXfw-1; Mon, 09 Feb 2026 11:20:51 -0500
X-MC-Unique: jJLovYnlPQWUSJjy-TfXfw-1
X-Mimecast-MFC-AGG-ID: jJLovYnlPQWUSJjy-TfXfw_1770654051
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-896fbdb9968so40719766d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770654050; x=1771258850; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jlEVlG1GL0W1IRT9/GajYv4XhMBYK+uoSOjt/RlMjLQ=;
 b=VhRM1bolgyzJGf5OCljmFxvK6Mkd9lw/h1FKg2zYfYr40CT4jDzxEAijcvA5xWylhp
 nVLLzgIWVowr1i8dRBXNLOnSUI2poxo7Uj0Te1O6ngn8K8ft/jwJDxwyi/m/an081/tV
 +w5RTPJhSTZaJMJpi0vUu3Q9/U3uebFfKO/YEkSDKsErW+uGpHvDd2JoiDYu7Uj8r+Ru
 VxrsneDaVCcmL6BJqj79CyCXSfOEFHlRrz7qqvcTaOHSjUyb60hZHOPOfVRjIbUAMsCY
 3bg3dUSExIO9+mnLbroI3/LbXmRwxFHVLBEcw1x6rzrOR3jCKTT9Hsf8kQrD++m3N4Ty
 OQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770654050; x=1771258850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlEVlG1GL0W1IRT9/GajYv4XhMBYK+uoSOjt/RlMjLQ=;
 b=IHn3g9WVLoGdcUZ9SsBnHWnNx+2JiS36E5gJqfeuIHg6EtS1a5XwRY1oC5EVh0Zi61
 oZwSjGubZfab4R2PkDQPuYflppcdv0MttAgpiKKDHjNAPDM70nCcqEakWmTxtuVRrbqY
 kSbO2XtD/PHQmBflOZkt0UCdWH65/ZjzJEmL+irEKsEH+8RSt1geldlQ6PDo3BimbatN
 Rp4YyKSg6jqaTAT0mNDX7Led0jN8zEWngii8pjzoMR2IC0SLJUt4au+LIE264Fgncuql
 xth5RKQbelwc2z2usu7RPUH7LW5dy23q1YwlOTM3PvHrNMZPD8jjb7c5QOvPUgoaE5fq
 CroQ==
X-Gm-Message-State: AOJu0Ywp1EdmGuCLgnTkyOy/bVq7bKNJOuSW3/gVGm4QJ1TNjho2a2ai
 yBt9KKscd7ySPnhiPUdxlWdQ/Mu5+2G2EvfpmSsDHqCXbF/AAPALgZ+u4HVxPpBybTFuL8++yqM
 SrK0yNKO/ohh1wFsf421+XQHSL+10KiFlV/CvuPCp8b1xu+Oy8KOc0mfh
X-Gm-Gg: AZuq6aK6jfqaKz2i4PvFaod/9txuQk36rLYEELl0ILcAIy/17D+wn7Ah07rtT4cik7q
 RTWK6/MVQ5tJ4NUKE+96JYL/zCdyDPoRtP8ZbqQaXbpiG+kg1aUUkTTZqnm4Idh0vWIQFtmV7XS
 tLljq8c+OoD9Mo5SVg71Vm6kDuTdVK2MRFoCA3hsnNZxQT4atzLDOpeAxg0R23/YDhy25UstDZT
 UiiIVsqtZCsuGX2pMGWMB+g5IVNfpiJj+GDmsQ7io1xxDHa1gwj1FgT4PpMIbhuJ4J4TNEsWHYs
 ZZadZGzoALrfccT0De/VjVcNUh6/quE84dkJUJEYDo1oxOK0mJZ9IwbuxVSpoaXDaKBWJrgR9AN
 Ando=
X-Received: by 2002:ad4:5dcd:0:b0:894:7fe5:f95b with SMTP id
 6a1803df08f44-8953c836cb1mr193342396d6.18.1770654050597; 
 Mon, 09 Feb 2026 08:20:50 -0800 (PST)
X-Received: by 2002:ad4:5dcd:0:b0:894:7fe5:f95b with SMTP id
 6a1803df08f44-8953c836cb1mr193341996d6.18.1770654050145; 
 Mon, 09 Feb 2026 08:20:50 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c056e78sm82109616d6.39.2026.02.09.08.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:20:49 -0800 (PST)
Date: Mon, 9 Feb 2026 11:20:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 08/16] Move ram state receive into
 multifd_ram_state_recv()
Message-ID: <aYoJYJodrXxLN-ZA@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-8-57508b7389f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203-colo_unit_test_multifd-v5-8-57508b7389f6@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Nit: subject can be prefixed with "migration/multifd:".

-- 
Peter Xu



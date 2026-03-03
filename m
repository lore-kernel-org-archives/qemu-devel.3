Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C85EDA680
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRKe-0006aP-VI; Tue, 03 Mar 2026 10:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRKZ-0006Xm-CU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRKX-00025r-St
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fINl9nGFsoWMSUq6r2F9czqSCnC7RXuGEW74JFFBOFA=;
 b=en6yzZTpUU6X6bZ+uyAJowQc/YHv46ihe9M1JNVf6Jd/HzKR8FHkEZETuqZd5wtyvdFLiG
 3WbGi/Px1r2VXJC4PMN3SwRn+NNhKB7UVGeQ8qmOYSpfNBfMGUuEjdVIt9tBQxOq4l6d/c
 dJMBpbcXYNJ60ycXHeFU/zqmq6fRajo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-sWNZDM5bN42KlDJtLchCBw-1; Tue, 03 Mar 2026 10:06:36 -0500
X-MC-Unique: sWNZDM5bN42KlDJtLchCBw-1
X-Mimecast-MFC-AGG-ID: sWNZDM5bN42KlDJtLchCBw_1772550394
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-506b4bdde91so450911971cf.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772550394; x=1773155194; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fINl9nGFsoWMSUq6r2F9czqSCnC7RXuGEW74JFFBOFA=;
 b=sk7SxRSLy3fd4Zqeuwhp0we3Sb0qajbj4UMuda3oNstGEYIfSGX6F0ynlZAiVxwcAg
 upTPZjh4pIathipaaSqvPgpkajQOqZcsy3guu0QNKa5XRknQgwiaJQuOYsJvQPJrCrXB
 K41vrAVtwzUTZrf3r3VW9UjqvQWpkBxBWrDOoXwMh+SQDnHq+Rixv73xkg7ZR6ElfwzU
 tM0UBuNEM+GIXbKj00gaQWpt0hAdQrDO/g0qbsdZIQzGgMkyezC7/XpC2mZzm3VWVBAV
 zjuiNgVQmt2/l5nd9XkS/d9D9hVztnxXjViypouD4rtHFqZYrD6iCdS/nDzNiZh286Qc
 XdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550394; x=1773155194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fINl9nGFsoWMSUq6r2F9czqSCnC7RXuGEW74JFFBOFA=;
 b=ppfdnipwENld4b22DShiwn6s2yJZo1KQhNEDBnILDso1OMx2Um2f6+35hu/9SZVLlZ
 i9NyExOihLC0xrg15LTrPAWTEB+3PinrCd8/AgotBTlF4KNn/yNdcn/K3djM7+OPnaj3
 6K/rXp56Og3fFWdZlKQue2B7LqOx5foOfZkb+lKwDnqqg7KhEnWX8vq6qzYFqbKyokJj
 a1gYiDCErElIBA3X5Xv8YhYlCfEt98LiTYCIF8TL+mMPmhgq8FWUQSaLE7PWKD3TfSvN
 Sc7oBBsr3+GlAnsnlh3aGBR0p4glWpc4tZQiPdekPIjHSRZ+uyG78Nv6tw9SbZ9a7Koa
 Bqmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5E2waHUw4g/s7giKgEjeHnVAN+xMbCOBvXc+uLP7Y9kVS31ZxntAvDr4NZVibHKIx19h3HfRv40T4@nongnu.org
X-Gm-Message-State: AOJu0YzISPgK3+d42t4ii8v+cLv3a3MKkpJbONRTqL83tfr6QTZQN5+f
 F3iHDMMeekm+okBYPSWrZzoUQ+kNIDtcuNQ0Olr2URatvdtbwFqrdJyA6nC/a55uGyuRc/gaQx6
 vOADyoQQjs8F+00xNwAq91x4S/qKCY1m5++Batq6fL71U+zhcaTMHVd7d
X-Gm-Gg: ATEYQzw9dkOhe1i3L6+6h23Yz0w42gs/34jC0POYgtxS6JOhkS9Le3a3crSTAb12Vdk
 L9jB52Koqjb7nFg6iJSzVHcmb8VMj6N3nYK5iUpDqbeTMvYrsRBvUIKgFGt8aEeR+d2xlwWbh7J
 BnnpanPt/7sZP6+c3nKdidOQubIXuXB/M8Eaw3tDkNcKMjU11KkhSkER9o3PwHYAkGOfceL+McT
 xfJ8PGsXq570v91IKNIFUdgbWsU39NttigpmTbxXsZa+MfpTPTQk+zHhRUPXex+bpG/125lO3Az
 C8XtOYRp+y8v+U5omUlHMcUNtD0rxaWg2/VI2xGP2XJwpD/cpjMqAoC5OAXZR7nHg1ZCgBGX5IB
 XQl2Vr/UZuuSIKw==
X-Received: by 2002:ac8:5d4a:0:b0:4f1:83e4:7247 with SMTP id
 d75a77b69052e-507529d622dmr205638151cf.60.1772550394419; 
 Tue, 03 Mar 2026 07:06:34 -0800 (PST)
X-Received: by 2002:ac8:5d4a:0:b0:4f1:83e4:7247 with SMTP id
 d75a77b69052e-507529d622dmr205637511cf.60.1772550393714; 
 Tue, 03 Mar 2026 07:06:33 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50751256df4sm107330921cf.16.2026.03.03.07.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:06:33 -0800 (PST)
Date: Tue, 3 Mar 2026 10:06:21 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 04/16] migration: vmstate_load_state(): add some
 newlines
Message-ID: <aab47e4K4WuEv_rO@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-5-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Sat, Feb 21, 2026 at 12:02:02AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Split logical blocks by newlines, that simplify reading the code.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



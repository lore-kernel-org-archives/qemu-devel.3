Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E44EDA694
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSRy-0003PC-T1; Tue, 03 Mar 2026 11:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSRn-0003Lh-MP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:18:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSRh-0007HE-5r
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772554683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tamLwZDC/4hoR1TgW46bFQcr0yd+gyAHFmTa6yhuVGI=;
 b=E2V5UnVzG6BnvZ+mOVOGQEIg0pNKxZj1RChUvR/0OH0mmdk6pZT49zf4dA7evJ0EH9zWJ/
 zuRj1eN6ageEKGlrB5yRVldg+kpQoS4Jm/OZCAw805mD1O66oCH10wYfaJltDKQH/4C7zE
 hsBJ+Emr9z1TiM/W/TdSFmp2TcrjnQA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-M6VjsMA9MCa8S26rMr7EsA-1; Tue, 03 Mar 2026 11:18:02 -0500
X-MC-Unique: M6VjsMA9MCa8S26rMr7EsA-1
X-Mimecast-MFC-AGG-ID: M6VjsMA9MCa8S26rMr7EsA_1772554681
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cb413d0002so4359967485a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772554681; x=1773159481; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tamLwZDC/4hoR1TgW46bFQcr0yd+gyAHFmTa6yhuVGI=;
 b=Ti8GBkdR/uagjuimMQI//vKGd6CwAT2+ld4cLZg/UkOu39CerMNdWEEuO0o+9jRzwA
 WxDAriGtEjAfB4CLXK3erBU1jNBJDKss8FXufEIIqKJus9A3Jpohkqzybky8Y0QC/RoL
 iRBas5sDmumYlir1MA2/3lojAjTNYCVk0aMRcPyN+HRUigBWULcPwzIAQtsTXELjn2CS
 IWI66Hz9aWNrIZr7JOPzNUzF93kfSQnqwqYJRBHSDguc0OPOPaxgKoSdsEvdBQcxzDN0
 g7hn4Jztr5sFQYKV+eEwELMxTjIwM/MGJAUVpT5gja6X3/aHFLwCbYfhiyuzOGcFStV6
 +leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772554681; x=1773159481;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tamLwZDC/4hoR1TgW46bFQcr0yd+gyAHFmTa6yhuVGI=;
 b=VM2h7KtGQQcxIO1JOOAarrVI2tWSYWzRMoGyiFHBtgu0+R54ubwAWE3wM57Cu0hZxl
 L+hkEhzEw2Eob45iqNIvePDs6Y7wuN3aSM7zhFs8gIw/X9bHsO5bwnoXiO0sh7mpLvnY
 SzwRu5H3aBT/TKQXGEBbE6l0pZceUYGZ9C7+GsR+Ac0LeKgQEsSkLtcwqM+jNOD79ZEK
 EuNgSEOLI5+ku7v8R2gp1IKfH2Ps2yfhB7DV00fbCNJSezTSzFnsMI/SeQU6bYEf9O9D
 hOKlR/bJaZ2i6JIPGwUsvhuCfbgT4qnUOS1BoD9pIV2voyFkWnISAhjSRmlsEePmk4Wc
 CiLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/qs8gyCrYCzDtOeui8rn+2yEyVU6HzH6hCGfNeVdLjznFcuip1rxPawFF4PqEUpb2vB6HlBYFR8SW@nongnu.org
X-Gm-Message-State: AOJu0Yzs9DEhcmClk2GOS475sGTjH84u58ShlZf6ZY4kSVJcgLVoDbtt
 8bKk2yCr3QiBsnzJ1yQwb3lPHajcriXnzBPfAARdEshe6QNyfqXJmK5q6beMg7g5SCJNpPa2EFy
 Vu3H52/80xv3hG0hV7Lg9mwA1QiEqN+rhwfRuQr2d6DA+68penFNuxLvl
X-Gm-Gg: ATEYQzyTskOIikCHOdz2HsijSK+NnenqalOqPf6r3MkWuIgQwq0rM69Df9u3Rrrdikm
 nNC1iSoVkeBkHyiznJUBr1JkdNdL+tTHFlD+NkULeUCCh2T0da2AW3Riq3HH/HuV1AvW2J+OeUX
 k0oQkNxlGIsTC8pdmzp3npM713sSl2Ares03pzgdT+0Sl4FBGw7JgmFgbmSl7YgwxTlcNH9qBcv
 z4YQGC/aNk/GkF5+rGlrCeXZO9/cbea+8+pHX/+LNN+48cYMgQohU6tdsdZ0IGXJ2WKBgk30Lub
 wJJBcCj/3ttslVx6v6US/FMDpwxxYqzAd1LUVyexLSNJcoKab5Qd3KbqU1/VQqs3fwQIes+g4d8
 ot/eNrXnsEo2F+Q==
X-Received: by 2002:a05:620a:28d1:b0:8cb:3fca:2f9 with SMTP id
 af79cd13be357-8cd508e279cmr313143285a.4.1772554681410; 
 Tue, 03 Mar 2026 08:18:01 -0800 (PST)
X-Received: by 2002:a05:620a:28d1:b0:8cb:3fca:2f9 with SMTP id
 af79cd13be357-8cd508e279cmr313138085a.4.1772554680830; 
 Tue, 03 Mar 2026 08:18:00 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf66c515sm1433537085a.11.2026.03.03.08.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 08:18:00 -0800 (PST)
Date: Tue, 3 Mar 2026 11:17:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 11/16] migration: convert vmstate_subsection_save/load
 functions to bool
Message-ID: <aacJrakaT7dHqczA@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-12-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-12-vsementsov@yandex-team.ru>
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

On Sat, Feb 21, 2026 at 12:02:09AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Convert them to bool return value, as preparation to further
> convertion of vmstate_save/load_state().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



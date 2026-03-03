Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2989AEDA693
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSXX-0006Dz-It; Tue, 03 Mar 2026 11:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSXV-0006Dq-3T
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:24:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSXS-0000xI-R2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772555041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zByS73AJjPEP7uUNrVGYsh4UEORAB8SJzv98nYL+XdQ=;
 b=TgOSODzWvAyLnijwIJ8tPwm0oz/wre/j7QyhJ8zrjI4a2ds/eXlt6lFfD58IFFRMtJ66EN
 1itOUKlnqrpyZuBurQZ/vtuxl2iV/AJRfh7gexaU86utLUqdJwap6nkycNyHgwm/2Hc8At
 xbeGchhBMJh6DxUH8YqZFFe/pShLM+8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-10up6XNLNCaIRmKA8X5ySA-1; Tue, 03 Mar 2026 11:23:59 -0500
X-MC-Unique: 10up6XNLNCaIRmKA8X5ySA-1
X-Mimecast-MFC-AGG-ID: 10up6XNLNCaIRmKA8X5ySA_1772555039
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb4a241582so3465924285a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772555039; x=1773159839; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zByS73AJjPEP7uUNrVGYsh4UEORAB8SJzv98nYL+XdQ=;
 b=iGvDjkMUkxZwkrvIRShOKPHM+51KPvpexupPIzD1nLQrEonly5jcBUCvjAUqAvZsYg
 njafdAUXcw4VGTBZ+W+xFyOQij/2WzvEp5WeXI6YAEqHsmLtrZ0q28fGVm+uJFIsUtSP
 9wABcDhkeCSw/BLKglYJKSGwQ3sKJZC4v07oDeaVzwavN3j7ZuU//dWne+HWETdoROfK
 hWLgOQfvxIoRTlxsqIF3HyzCYuoUvVyEo+gq5P+aZcRhOvfRZK3YpZZSbAJEExakyA7i
 VkUSK53uv/AtbAU6sVYu8+ITvmnwg5+ZkP5RAbLPlVgMvTFtewq6asTq9Xh8sCFzg+M2
 v/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772555039; x=1773159839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zByS73AJjPEP7uUNrVGYsh4UEORAB8SJzv98nYL+XdQ=;
 b=Ppx3LwwHjV06L9gQ8U4wx1mtLoXL8MJjAkbnJpVK3vEm3R1lRmIlGlhOEA9h4cU5cz
 TSoVGWEqAFxMCw1LBEDXsZIylfx47SXUF2fgVEK0joyBJfxtmZ73tBzehLLy+0DNMa+d
 S0XzIKVAGb+tqUGHT9fMT16bghWzf5XR3X1JxpYOPjtEod0bkDjUDdryzLfDp3z/Zxo0
 W738aB3UlCL5b3U6zkeNjE0GL6X1dFSmFf1P2Mp0GR2dY+J5iA0f3C2yJ1JeIvdF2yFY
 HzWktoqqdXMltLYKv+HBLZgw3Tfjjo/hKjbqfYpuG13lFof3cH5B+vRBIVfi9ay4LHRU
 T99w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuiczSzqTlr/gC7qGLJLURc5KevKOoTyZcg9PiZyXS59fQz+pXfQ9uJJAd/5eHGmsAZhHId8+XkbRy@nongnu.org
X-Gm-Message-State: AOJu0YzzRuBZMc7P3M/0nsvz7bdfovaIiJmWPL04Pa1WAYhEqduoCQJs
 4NCqc0rUurfwnuNwfkVTFAiyd81YKO9Ij8GLTEhQuEiAKcd7TXZtyqcW1OrcnHPaDpNQJ3tv6Eu
 Z8tkBNBU297EwqitMqEn5Wro1Iqf3q6Bikqf7X9qHqqw2YFw8EfdrnuW9
X-Gm-Gg: ATEYQzxndNYFaoXGHYMHcteLjCSRYSLbQbRiE71lIbRCgiF63/Lq373KKBezjL71p5j
 n+/Q7hNT0aJ84oaB8sqQ5haukjSPTWyas9I9N614HudBkkPCkwDFJcRd1bdkAOnsua99bob3MYw
 PiWtu09G2QroHMVUKimHvLxQa51Y1zpv9IWHYaerdlkrgzfeOhiFoum13l+2AUAMkgkVD1ABgJu
 ctTX88KrCi2lY+Km2tu7QYSvTSXB2QnpGRy+VuPe1Z4x1JlRilEqPoILaeKaHTQ7d9cUBx+lPrB
 WbzKQuJgLVItafgZ/387vZ9h3b94ORUN+qqngq32jK0SPiCCVvCfgRTtzYlntm9QEW+b5FIYkb9
 zUrmFjqylawtSPg==
X-Received: by 2002:a05:620a:4041:b0:8cb:4d18:bb61 with SMTP id
 af79cd13be357-8cbc8e34176mr2139243685a.72.1772555039330; 
 Tue, 03 Mar 2026 08:23:59 -0800 (PST)
X-Received: by 2002:a05:620a:4041:b0:8cb:4d18:bb61 with SMTP id
 af79cd13be357-8cbc8e34176mr2139238085a.72.1772555038833; 
 Tue, 03 Mar 2026 08:23:58 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736cfasm1405368285a.49.2026.03.03.08.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 08:23:58 -0800 (PST)
Date: Tue, 3 Mar 2026 11:23:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 14/16] migration/cpr: move to new migration APIs
Message-ID: <aacLE7CupNZQCmF1@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-15-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-15-vsementsov@yandex-team.ru>
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

On Sat, Feb 21, 2026 at 12:02:12AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



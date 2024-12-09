Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E75E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 21:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKl37-0006C0-93; Mon, 09 Dec 2024 16:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKl30-0006BB-T6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:12:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKl2y-0006kx-UP
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733778724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4pTxJydxQGoF45G+N05avvdN/Ex5zOA5EB6ojhpaG38=;
 b=Nr1sHuIYnhkuNmkAhpLKGYosr5d+hbQ9d/JSRbioKPd7ZoLiuFbz0BXHMIZ2ZDDemB0Szt
 4Y9HOdNf4gTGdDYgUbbU/h4ZUE3FNjZxg1yqUIaEppJaJcRMCqjyND2Rc9mcynyvVuHuP4
 ggZSKUM9eK1M37iA7ZxK2vZb5e+mqnE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-N-Hw6pPgP0qKQCLbM4BRmQ-1; Mon, 09 Dec 2024 16:12:02 -0500
X-MC-Unique: N-Hw6pPgP0qKQCLbM4BRmQ-1
X-Mimecast-MFC-AGG-ID: N-Hw6pPgP0qKQCLbM4BRmQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-467663573daso28387431cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 13:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733778722; x=1734383522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pTxJydxQGoF45G+N05avvdN/Ex5zOA5EB6ojhpaG38=;
 b=EKxOAGtCGmixyeSdrX02DvlfakebM2K+Rm2rCNMklLa4ETilSjWEE5LHQ+UNRtBtEb
 VJbM1mzzvEyvozFT8+Pprz3O6ALIkjqJvuDJ75FqZkTvnjVbtiC6EcZ1i/YJMXaFhHbA
 CIgOmzUhYUJoxTPUMK/6i77dcf1eyI/rlEGU+7vOpBsoo9fAXH9+K70FqwmrdfmsHpu/
 OnnwHB8zALEle3VIawSsmHEYMDILqk27M8XLxh7eTPk51KrZnOPmcAwcoqKpNOpR5Tn5
 ztoZoMUTD3QBUQMTQ1KLa6fDXIikNuBpKQPvBlbuVwYqY/a03GUSi29DIDpgIcd6daVI
 K06w==
X-Gm-Message-State: AOJu0YyYuWGLLp/jQDfxef3fXTdZr6Epq9MhlYIVEo/pQfHqeaQ283hP
 DDl3wGZyYASokjcPX9HudtbHV8pP8iTWnVLV1inH8w+gmkpVPnqgjvLdw7dJWvttx/dYsBwOL5m
 TjptUveFj18KE/5Or38eDidpzor2GOP92S5nHQdaQCB4F0jVsUsjc
X-Gm-Gg: ASbGnctr3LZGXIj/kLHxsLcsKybvenO2nyk2D3sipfNvhwClG2JZnpwRfDfr0UtV/+q
 ocbStsQSkvCEo7i/MsWjKxcGuXWB10J/p1kdOBoOvVv33Rl5z7DmcAAlV0QnvAMmA2C9Pe4IzzM
 6VXxIiEyVepdmal25Mi1oMe/o8JLKoS7ATvAz1b5W9jKwYsj4Nhoji4Hk60FKHikvqmgTyo+zM6
 0zMrAsreZw9ATsy5Z5xgpMpX1XIjs3OOOTOAvZFjyFO5EytKug4RhFkFp3r/Jz+l5epxDOfnw48
 5r4c9o24AdIEoa4=
X-Received: by 2002:a05:622a:4a0a:b0:467:6dd9:c967 with SMTP id
 d75a77b69052e-46772013f70mr28068421cf.49.1733778721934; 
 Mon, 09 Dec 2024 13:12:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsMwZVNXS+BKBb/fvwCCbTWFw1EqQ+yl9koBd39hguGp7BfDV+D62oZo5Za0kV4M8vw5abzA==
X-Received: by 2002:a05:622a:4a0a:b0:467:6dd9:c967 with SMTP id
 d75a77b69052e-46772013f70mr28068111cf.49.1733778721635; 
 Mon, 09 Dec 2024 13:12:01 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296fe9bcsm55095531cf.51.2024.12.09.13.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 13:12:01 -0800 (PST)
Date: Mon, 9 Dec 2024 16:11:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/6] tests/qtest/migration: Do proper cleanup in the
 dirty_limit test
Message-ID: <Z1ddH8YCZnr23CGa@x1n>
References: <20241209204427.17763-1-farosas@suse.de>
 <20241209204427.17763-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209204427.17763-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Dec 09, 2024 at 05:44:22PM -0300, Fabiano Rosas wrote:
> The dirty_limit test does two migrations in a row and is leaking the
> first 'to' instance. Do proper cleanup.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



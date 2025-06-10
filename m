Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D8EC71130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27f-0002YX-DT; Tue, 10 Jun 2025 12:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uP1RL-00071z-Te
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uP1RK-0000LN-Fr
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749571384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rtT0IHU1UsqC6SynSODcmb8WSOW/YHF9wPm6k+JvGCc=;
 b=cgY+CoS1WWdZq70REhcy4d9v0HWxbGSZ0PM1Wjvn3jCYLcn8COh6YtILG4wJBl0cNWqrRu
 4CRL7+D3Zy7iDM+lBDppkDihrI/FoLiHgcWDN6+N1jfhatdXrO6yFkHD6DFnUXlm8z0Jbt
 6YPT36BqbF8/VQhwFX6/iKKNTOBL2Vg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-hk-u2ys9NamT8_DdIOHhUA-1; Tue, 10 Jun 2025 12:03:01 -0400
X-MC-Unique: hk-u2ys9NamT8_DdIOHhUA-1
X-Mimecast-MFC-AGG-ID: hk-u2ys9NamT8_DdIOHhUA_1749571381
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a6e9182fbaso68297211cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 09:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749571381; x=1750176181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtT0IHU1UsqC6SynSODcmb8WSOW/YHF9wPm6k+JvGCc=;
 b=DRFQlvW6WEGTU7Ut5lsynjFowginOPN3alQ/qLRKrJ69acywUYldOeFchSUwOPD243
 tlnZRo2qs4DrWLqWNKyVri0pls+i2vdwLUXxRxKhgfi9oKesUz3fXxGkUsd17a6miH9z
 OFOKGvP9Lw9s/tsQr+Ps7YtbOu7y2lBq+yA9btryxG4rGKMgljTWjHzvPx9+qjLPFiR5
 JKbo2dhJfqxrypOe/LiEcHFtmygug21uUaQ59vicFkdNis1HFahwuH+KZBoKy9Ho7rRQ
 AzyHknqXPytPY8Ex04gnJK+VhHX3a42AGju0fz2eQ9PXlcU4LGecu5UD1DFfrq5tpIRd
 Ve3w==
X-Gm-Message-State: AOJu0YzeCrjbqTpgv4L5xolHki8zr0BBKbNaA1wbLFrWOohAl7OZhMke
 SGyLv24vr+8aHaOB3KQI+x2dxQM8/+p2o2lr4fAGj0bQguHLYuUHUVENIidMJJ3IAFgLQV3uYyu
 NyZf1YlNhBK2RMJ1uoSfmpcWhc/3/Pa/lkQQkedzAWh2CJjrf20GhdGs7
X-Gm-Gg: ASbGnctCYXqaWFowYmyE2prgplQfBPNGdUhAUo9KqGtFRgsuGypfcc+Go0HgKpabBqz
 vB0U6yprAaVvo9KuYYI5E8uqXkWR0TGMJGmzfsmca+wlL/nxUtWX+U/yD/t/l/6P6ZkpCG6uwzh
 mb3utvAaSjUUZ6NEyZ93jSUAilAbqK73llY3yimvopB9g3y2BM3uzs5/CTJVuuaqGZeWG+4z89x
 x/R4alK/ZhbIYs/Hs/N4SmUeizM30mw0UeOBMQu65bxQk80aZslz0h9NIWnQ/GdgJHZ1Cf3Hips
 Iil3CQWbBnr0DQ==
X-Received: by 2002:a05:622a:2303:b0:4a6:f9e3:b08a with SMTP id
 d75a77b69052e-4a708dd2c18mr71796681cf.26.1749571380733; 
 Tue, 10 Jun 2025 09:03:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl++5DIbbNqxYdn2eZCN0IJLKc9soaUXaED6uFceZT4C/KWmXjWHSx7FMluarA0NzvmKpJMQ==
X-Received: by 2002:a05:622a:2303:b0:4a6:f9e3:b08a with SMTP id
 d75a77b69052e-4a708dd2c18mr71796171cf.26.1749571380286; 
 Tue, 10 Jun 2025 09:03:00 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a611150830sm73064281cf.10.2025.06.10.09.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:02:59 -0700 (PDT)
Date: Tue, 10 Jun 2025 12:02:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, steven.sistare@oracle.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v2] migration: Setup pre-listened cpr.sock to remove
 race-condition.
Message-ID: <aEhXMCuztHlUEhqb@x1.local>
References: <20250610150849.326194-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610150849.326194-1-jhkim@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jun 10, 2025 at 10:08:49AM -0500, Jaehoon Kim wrote:
> When the source VM attempts to connect to the destination VM's Unix
> domain socket (cpr.sock) during a cpr-transfer test, race conditions can
> occur if the socket file isn't ready. This can lead to connection
> failures when running tests.
> 
> This patch creates and listens on the socket in advance, and passes the
> pre-listened FD directly. This avoids timing issues and improves the
> reliability of CPR tests.
> 
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>

One quick comment while we can wait for others to look at the details: when
it involves both qemu and tests changes, please consider splitting that
into two patches. The test patch can be prefixed with "tests/migration:".

Thanks,

-- 
Peter Xu



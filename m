Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D299C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 05:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXxKa-0003dq-UP; Thu, 08 Feb 2024 00:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXxKY-0003da-Jd
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 00:52:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXxKX-0005zd-Dh
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 00:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707371531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvulsJn64d1wbsFsA6bd6r6JmkkwYFv13NVT5ic6Ld8=;
 b=Lw3WUhKMBu2sJ2n1ANOz0MWjjdH/U33PduGJj5y3GXFUjN2qAv+k9Em7pt6XePedE7UKLn
 T/Gf1q4t9NMd3Oxh+Nl5xiIBKgPwOHaluW/VolC1/vf4mbHZf2MuIRfwX5Du9XbwHpNLom
 z10/YSKd0Reg0DjsWps0pnDE66YHNR4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-T9QczAtwOjuTSQa63oq4OQ-1; Thu, 08 Feb 2024 00:52:10 -0500
X-MC-Unique: T9QczAtwOjuTSQa63oq4OQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so446541a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 21:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707371529; x=1707976329;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BvulsJn64d1wbsFsA6bd6r6JmkkwYFv13NVT5ic6Ld8=;
 b=RpRuZemv8Juc0I0bw7i6/WgAMAbJKz5fin9ovcssvmVlqmee0kflMz64cJtXLOuawB
 wrLtxP+eLXb2MnJqDrt76ViZFwLjIMTbVfTn4dPEVSiFVNiXfwPJNUSO/6IbyGkmD6Uu
 nieiTkf411qJumJCwhnfb0RVT5vcFyKZmI6Nse5W6NukIAOg46NB1XvSlttgtgn0gvO+
 YfnvVscDcOYjS3lNJJk+aVX35QCKShyZyIeeyw3Ze3ntVI5EuZkngFoh7D8HpPdQZyNd
 mgqWeeIRiGfosvVWNbMkI7RHY1GpbzwXR0Z0O4ZCm32qEGeG90YSldAlpgdJTlR6qje0
 iHSA==
X-Gm-Message-State: AOJu0YwynXlPD699cMoBwrB3q3yP9Owlt2uTye/nn3PYMlolsBbhgu3M
 H1uvwmbTcQiZZGQPlMkFTGPavFUdWdLjmla3cgA/ix27880+x1Au6ldCdhxHzFn8w2IxS/d8jMW
 og0onE+nLHpjxm7ISaGK5BR8bgGPng6YXObzXGw1h2huM6RHtHzMjMZrL/P47
X-Received: by 2002:a05:6a20:3ca1:b0:19e:35a3:78bc with SMTP id
 b33-20020a056a203ca100b0019e35a378bcmr8039581pzj.6.1707371529147; 
 Wed, 07 Feb 2024 21:52:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDdlDS51Y7JiEf/GSnjJxdp4JTffnb1qOnPV7N2Vr7Q4tHkvrgTuO3V75kG+zBZCo7IGtSxA==
X-Received: by 2002:a05:6a20:3ca1:b0:19e:35a3:78bc with SMTP id
 b33-20020a056a203ca100b0019e35a378bcmr8039572pzj.6.1707371528785; 
 Wed, 07 Feb 2024 21:52:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW2cqgD9BCLRmeKRm//ebT5G198rXIAJBynmbffEOH87RJso7b/UgB3PAiepQl1Zkd1kBcYs8r8a/hxjpYuLWuGGYRgB5G1kkXG4Ia8HDAJ5blhQdcK9RzMHM0x
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 h7-20020a17090a604700b00296e2434e7esm496825pjm.53.2024.02.07.21.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 21:52:08 -0800 (PST)
Date: Thu, 8 Feb 2024 13:52:04 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 12/14] migration: Report error when shutdown fails
Message-ID: <ZcRsBD_lA1U2Xt_X@x1n>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-13-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207133347.1115903-13-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 07, 2024 at 02:33:45PM +0100, Cédric Le Goater wrote:
> This will help detect issues regarding I/O channels usage.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F284BCD1288
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 16:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrKWC-0000ny-Lx; Mon, 01 Apr 2024 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrKWA-0000nh-J3
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 12:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrKW8-0005gB-Pq
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 12:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711988895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxudZ/JxZgvslZBIQSlViiIAIYUgLLHXutoerdFGGMg=;
 b=bVPFXtdfftzc4sGu5Vy3PQlc8/hsdMqcncpKm4P2bGkomxeDcz8yXyn5wU7uoZxl12ZyH2
 SC+TWanZLixrOMJGbh3fYWM+H4S3pMbHhzUSfQfqn5Jl1iPT1x+yFe1uzQ16AeQTrBx95B
 /f5c8Tjz3bquKknx8R+e3S+H05TF/OY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-G-o3Dzg-PaSYL7-otHxPZw-1; Mon, 01 Apr 2024 12:28:14 -0400
X-MC-Unique: G-o3Dzg-PaSYL7-otHxPZw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-69152af7760so11398296d6.1
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 09:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711988894; x=1712593694;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qxudZ/JxZgvslZBIQSlViiIAIYUgLLHXutoerdFGGMg=;
 b=UZCLOTASSu44DAVQBxiIPMKZKfy+K+HGnxO2C2qg7t/uCwdBPAIPUBtvvY+yCyPDW8
 P9mMZtrS9TQ8gRi5n7tfLq08YM+vB3TfwcYofU6Eep0hx4ZJXj3ik9pdvVrIR9eYRQi9
 Zep1F1O3dB3i3TRv90lHRBuy4j6J0nEXks03FUy7teA5FFgZ//xYJspOQM+udrQJD8MP
 v5OgKMbzpyhse6A55ji0ZW2UDLXOKaN8JZ6qCZ3hiZgCveMpDypv5N9sXwGgvKgSH4H4
 WaoGzjzUzk/jRbFAdB8oXSgCHOfcEAUQ9PJC8EOJfOZRlWWeDg9fIuJjegdU/r0hnVkT
 7HRg==
X-Gm-Message-State: AOJu0YzqWAkMpzyWS3aN0e01uCACmjnRNboyNa17Ee+PAwkuF3KuOk7I
 Cq7gjvB/EfKYb971WVGxIG9qLB+tZoVBize+IO5i42rIAL6kdVmnsxUS23dpA53ljlG6moI8wWQ
 IMSm94cgbglMgE1t48yUBSi1cSe3UzaQ1C3ou/zufQS/SOhuLZe1h
X-Received: by 2002:a0c:c792:0:b0:699:dfe:6015 with SMTP id
 k18-20020a0cc792000000b006990dfe6015mr1833460qvj.5.1711988893459; 
 Mon, 01 Apr 2024 09:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcJYHzMc44SPLIU/fkyR1SHPAVAKkpyRB47fyYTA6tcRP9HGHxCA96D8FCBEyDGuzex1jJjg==
X-Received: by 2002:a0c:c792:0:b0:699:dfe:6015 with SMTP id
 k18-20020a0cc792000000b006990dfe6015mr1833441qvj.5.1711988892998; 
 Mon, 01 Apr 2024 09:28:12 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 dv13-20020ad44eed000000b0069903c37a36sm1697143qvb.100.2024.04.01.09.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 09:28:12 -0700 (PDT)
Date: Mon, 1 Apr 2024 12:28:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH] migration, docs: mark RDMA migration as deprecated
Message-ID: <Zgrgmu2nVW7SRDrG@x1n>
References: <20240401035947.3310834-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240401035947.3310834-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Apr 01, 2024 at 11:59:47AM +0800, Li Zhijian wrote:
> Except for RDMA migration, other parts of the RDMA subsystem have been
> removed since 9.1.
> 
> Due to the lack of unit tests and CI tests for RDMA migration, int the
> past developing cycles, a few fatal errors were introduced and broke the
> RDMA migration, and these issues[1][2] were not fixed until some time later.
> 
> Modern network cards (TCP/IP) can also provide high bandwidth
> (similar to RDMA) to handle the large amount of data generated during
> migration.
> 
> Issue a warning to inform the end users of the RDMA migration status.
> 
> [1] https://lore.kernel.org/r/20230920090412.726725-1-lizhijian@fujitsu.com
> [2] https://lore.kernel.org/r/CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com
> 
> CC: Peter Xu <peterx@redhat.com>
> CC: Philippe Mathieu-Daudé <philmd@linaro.org>
> CC: Fabiano Rosas <farosas@suse.de>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Daniel P. Berrangé <berrange@redhat.com>
> CC: Yu Zhang <yu.zhang@ionos.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Thanks, Zhijian and everyone.

Acked-by: Peter Xu <peterx@redhat.com>

I'll keep this around for more days for a better exposure, and this will be
included in the 1st 9.1 pull if no objections.

-- 
Peter Xu



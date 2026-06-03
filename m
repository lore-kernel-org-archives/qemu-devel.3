Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A674ECD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUs6A-0007fc-Rm; Wed, 03 Jun 2026 16:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUs66-0007cp-Aa
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUs64-0003t2-BG
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780518110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2VE9RfFrGr3dKzA3Ney43Im7Xhco0+/7Fa1HB+5hOHE=;
 b=HKI9cie6lC7IfC8kRxI6Bc0DCs1hsxcShTnQqRwePzSlVz7x2C7qzF6YIyj248Xe8la1Kk
 6evwqS/YfEbymZCib3G8gYIaLKJAslMS+ug/fLRLRiQvIuTxeDm8LGtrikr5EzBEusGsNE
 mKC2iJhkgunfnZ3aYSj1ErFTmOvmY0o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-hk40jnUNMPSKRC-osl6scw-1; Wed, 03 Jun 2026 16:21:49 -0400
X-MC-Unique: hk40jnUNMPSKRC-osl6scw-1
X-Mimecast-MFC-AGG-ID: hk40jnUNMPSKRC-osl6scw_1780518109
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9156cb14b1cso966985a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780518109; x=1781122909; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2VE9RfFrGr3dKzA3Ney43Im7Xhco0+/7Fa1HB+5hOHE=;
 b=qM/ixhoop8+2CsD64a4HJAsa5pdc0O+JIRJmOlr6VgaBdvoM16vKfqsW65GmyVw1y+
 qxoB52z4pJghN4336J1tKSiUFfZyDWj8Acmu2eDFUiC/E9rIgET+qPA+2ZWHXX+18XNE
 svXBGmr2rUHZT0+B20tqlYHbFRKn8+i075H1HG1nElQDTdy92u513cCHHVKOEOG32ns0
 Rx9wYh5h3KXgc/Noc2dMOdq1BiJZy/jMCkoiP2F4stXb6LkmMlHlA1sLRJsgqNJuX5es
 6Ip8JMgWnWzB+P1g2oBUbn0etG8AxmCjr7RQfrHVAO45vOIVJczdkagZQ7/d71JAkJaD
 kUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780518109; x=1781122909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2VE9RfFrGr3dKzA3Ney43Im7Xhco0+/7Fa1HB+5hOHE=;
 b=lzgOiVWQNf9ppq6MQSstN26n50aeFetY3jMxQC9sTGi1ik1oPmGbeT3P4BWsZQm5p+
 rIlOeo4qS5gj0e1/a5VhkhVmHdrN4lAhV0FsE98Y8KkkoGMPWowNmOWMIDqciM3tRTmd
 bBDEnATIwJdja81bLsB4k1/IRARI0MYNOgrgoJkk4oR5OUvPFW4iZ51tq8Q1k8cXFIxr
 tjlyvn+VJhCYTVm9zYz3UVFvv8q1nLScEvLv/At4Of/9zqakS6AQiYvxboB6mqibSvVE
 emJnrq4ZH8fDVoIWe9lrGXUP/iOLnHG4FPvo3OS9i2G8ZpSsFGUXx+fdPxF3A+gzDczc
 adGQ==
X-Gm-Message-State: AOJu0Yxt0eW2uNYNKNNQRmt1UJ0mBNC2VRzkfZGAIm2rFwCPmLLy59l7
 VN/r9VAj1O2xgSHtE8Dtb256dSfTjvWzIPrONZ6ArRkQ7upm/SGTJrUx1/uOCqWaZuPGnK6fW2S
 C6fuaSavo2egSkKR95bBIjL5kAPyCJPZNOONiwUd2F2DW4AsHhflUvTPT
X-Gm-Gg: Acq92OFgep7UxGVJL9f0Sc4ycR2sKHzcwmdPHYCiopFSuxwnrl8dY57Hth7ZiJsUycr
 LqI80pTrGc2YYLzi6fy+QkIZ004OR5MN2QQpF7KhWHqAuyAroow3iwOrSlIzi/VkPQkkiLPx92X
 61NbS6Ye5XMlzaAVdhFCi+tEfKwFHf/hSBQ2CWnp96MBG2qnSayCH3Fim73RkSKaI68vQiceFSf
 3FW5SWDZxq94v73eCaOmmtSNoBvDxV35E+h/+ZQoNsr98hJpIrsSqOrAlV4fK3BMw9raBMzv4D/
 qv1UVR1tVb7OFow3E4UvVZKKzw+h92fPppDM0J5YdxDnQcXcsSLAqjhR09kyQF5IwrIGUA7zmEh
 fTJoWEBcPOJgs38MvZPvgj+gp3w==
X-Received: by 2002:a05:620a:1d0b:b0:915:8f76:8005 with SMTP id
 af79cd13be357-9158f768440mr654048385a.47.1780518108999; 
 Wed, 03 Jun 2026 13:21:48 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0b:b0:915:8f76:8005 with SMTP id
 af79cd13be357-9158f768440mr654041285a.47.1780518108511; 
 Wed, 03 Jun 2026 13:21:48 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3c2492sm363719685a.34.2026.06.03.13.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:21:46 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:21:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v2 05/13] migration: Rename switchover-ack code to legacy
Message-ID: <aiCM2Y8KCl-7UAYt@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-6-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602092621.382-6-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 02, 2026 at 12:26:13PM +0300, Avihai Horon wrote:
> A new switchover-ack mechanism will be added in the following patches.
> However, the old mechanism must still be kept for backward
> compatibility.
> 
> Rename existing code that will be used only for old switchover-ack
> mechanism as legacy. This will help to distinguish legacy code from new
> code and make it more readable and easier for removal later when no
> longer needed.
> 
> No functional change intended.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



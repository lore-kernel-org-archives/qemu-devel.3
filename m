Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A8ECD11DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 19:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpvc6-0000C7-8i; Thu, 28 Mar 2024 15:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpvc4-0000Bp-LA
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 15:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpvc3-0005b8-6E
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 15:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711654833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BKHy/hFyW/uaPiS5nXJ0gnjNOogWRf7+ypbKTiXK2oM=;
 b=L7Id7qZUMQgZoIANjuD0rIafNJMTaqulzaSviBXscKCvjS+Fsp3fK15SRc/W5SZWZh03/E
 UmuFsyZqg62uWpZysrOQJNDbtO7sWcck1KDhmVzGzZZ11c3VF6KldylTrctpet3KxG4yzM
 zyJqGytbGX6kTIWIsOhtN+94mK0sjIc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-uodSYltlMQ2OUd7oYGfcBQ-1; Thu, 28 Mar 2024 15:40:31 -0400
X-MC-Unique: uodSYltlMQ2OUd7oYGfcBQ-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-610eec93d4cso4838087b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 12:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711654831; x=1712259631;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BKHy/hFyW/uaPiS5nXJ0gnjNOogWRf7+ypbKTiXK2oM=;
 b=cDf1wJ/Q/5dP7ZNBVQCGTD6WcPsoyfpsMjEYotF7xvp6X/ga+UWsgnvszogVvJ7nd3
 hDq4HsZMDXyUYbKv64/0yfIKQB4SILHV8mSGZLdn2KD9k9lhS4RdSZ89uqO6/HqBWuSo
 i02RMT0rUR6yXKTB5bCizxAam62fA46jMZ99NHWpUUE9cNuedDvbVEcJOSUsNnRIL/2S
 7HgB5gM7xjIprUeRYUo3TQBt5DSwcmYNCUc3BsH5XAMGU0hOPjvngJnI5qTI8XWphgyj
 aukYinaCV1GR7V5Gmj4zwP19KwbYb6FvUjFFlzurVPvH15qgnG6+8WfoiKspzQaXudgk
 Zlgg==
X-Gm-Message-State: AOJu0YxDfrwjkJ57pQfm9RqnOAjcq1IJUgJrzCFMF4uG1jTV9uu/Ol9B
 mg7N6JfgzUwUTsWbKgl7FnuXMVEnbVRxRLks7cvmhxqZ4Xi9n2wGln3NWgl2Cn9qSTuplfPX7x/
 7WFp1/plmoArpUeSYy1xUblKjbxpmDU2+oYMNEJKRucwtcJ7FsTy1
X-Received: by 2002:a05:690c:1d:b0:611:280f:5eaf with SMTP id
 bc29-20020a05690c001d00b00611280f5eafmr432260ywb.4.1711654831024; 
 Thu, 28 Mar 2024 12:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX4GPZiJ2Hto0oNfZRrX/DOpy7fuSedaGzGUGjb/vuADVA3Pf1rLrvnjxH0SBO3RIM5mXyMQ==
X-Received: by 2002:a05:690c:1d:b0:611:280f:5eaf with SMTP id
 bc29-20020a05690c001d00b00611280f5eafmr432250ywb.4.1711654830548; 
 Thu, 28 Mar 2024 12:40:30 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 u29-20020a05620a085d00b00789ed16d039sm772658qku.54.2024.03.28.12.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 12:40:30 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:40:27 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 11/19] migration/block: fix -Werror=maybe-uninitialized
 false-positive
Message-ID: <ZgXHq9lUKTFmSdd2@x1n>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328102052.3499331-12-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

On Thu, Mar 28, 2024 at 02:20:44PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../migration/block.c:966:16: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
> 
> Given that "cluster_size" must be <= BLK_MIG_BLOCK_SIZE, the previous
> loop is entered at least once, so 'ret' is assigned a value in all conditions.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



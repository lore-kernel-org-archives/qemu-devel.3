Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E44EC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdoz-0005xG-EX; Tue, 16 Jul 2024 04:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdoq-0005vd-Va
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdop-0005vA-Hc
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721119552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Krdyul4VA/UiDZrhIkdJikqfvDzFJAa4qy86ikDlhyjkyLmqW381cl2dHc8Ej8Zt7VWRZ0
 I01MVYxSICZ3QdUwoGR/4id/Yt4T+0vyVSSSkIBMttQdDrSn9ErMF06dypV8Y7Nnx5bv1e
 EdW4X2352yd++UqKxhj/xBEO4xv9K7A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-FXfT1_KSMLO3o7pZOs5wtw-1; Tue, 16 Jul 2024 04:45:51 -0400
X-MC-Unique: FXfT1_KSMLO3o7pZOs5wtw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36793b39ee5so3513602f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721119550; x=1721724350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=qzLnW4uDfBn+xqp2dmZEK1vSqD5bhRoFUJZUvVvCFqCaP127nA5fNBrDp5YeawmxTJ
 AtQGUEaMkPALBsShsKZuTOCv61JZhBY9N6YtF7YskPyNp6pNcGOOpVw93ZbqbHfPdXy2
 R4oGGXA6i0qRG0KA88zMmfZRhXSxISLpFMQOsC2vRjBP6kjkOsJdkF3ROvBT0gzAHWPI
 BI7XbDPmGsL2wbOh8WouZ1QIoXF3ClOhZpgMNS0qp0mSVTTybvlJREhvBDl9qLTsKl/w
 dWSJlUvkG7dSdsbjihBImOJuNk6EG5AskWBXaDlDNVVd2fUiF/Kk3gmmT36n9m8TzcXL
 y7ZA==
X-Gm-Message-State: AOJu0Yz1gCH5rrjB3sXrWnJFsMOrkzcKq/MmabpTHyiuHTti7vkDffwb
 Y0tdb1OAoA6HnCwhhriEUDuVNDXUNByoznXLZCvJP5plfsk5qaL9evUzgtmVdbgA4o3cuwU64dH
 H0QJRM4fK2KyVbZKPBkeMYW1SyBMadu95jG5DtSoA5I7enjuxKQ/9
X-Received: by 2002:a5d:5885:0:b0:368:12ef:92d0 with SMTP id
 ffacd0b85a97d-36826320e2amr1018015f8f.51.1721119550049; 
 Tue, 16 Jul 2024 01:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWQJFG1PpypiM6DWJuPQ0Q+gJLi2iZBL4UHqgCWJD0j+Y+XpB1pSh/Filmw00IAAtbyfYD5Q==
X-Received: by 2002:a5d:5885:0:b0:368:12ef:92d0 with SMTP id
 ffacd0b85a97d-36826320e2amr1017991f8f.51.1721119549720; 
 Tue, 16 Jul 2024 01:45:49 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3d58sm8413299f8f.6.2024.07.16.01.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 01:45:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>
Subject: Re: [PATCH v4 0/7] util: Introduce qemu_get_runtime_dir()
Date: Tue, 16 Jul 2024 10:45:47 +0200
Message-ID: <20240716084547.185061-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716-run-v4-0-5f7a29631168@daynix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo



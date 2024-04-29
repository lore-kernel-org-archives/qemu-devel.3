Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2024AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WZ4-0006Ft-TZ; Mon, 29 Apr 2024 15:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1WZ3-0006FZ-M7
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1WZ1-0006Q9-Ou
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714418482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2ykcfiwNJhnkyEEUnAXKH8Vt1Xuqg/mS5A9Q7VE6zA=;
 b=V7cjSwKKMAj3IqrQTio99Q9Z2PdDsvhbyF0h1k+0sos8zgkiC2MRDOXAD8IkLIXX1NxV4s
 eJQAUIhGX8449Pxak+56bU4H2FA5g42HVTUz3lkrleZXxS6VTbk6Rxok7CuqAZX9JBY4u7
 rqMm3sqcRMNyekE2SIfU48wap3uyehE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-wScD5bplMhyl4oX0OF8f_g-1; Mon, 29 Apr 2024 15:21:21 -0400
X-MC-Unique: wScD5bplMhyl4oX0OF8f_g-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5acdbfb5b37so1643253eaf.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714418480; x=1715023280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2ykcfiwNJhnkyEEUnAXKH8Vt1Xuqg/mS5A9Q7VE6zA=;
 b=uNbJdZW9+m+5ShgJ026znykUenOMBgqpkCfdgF6PhkuR+eUGRt+1hPxesgqBZXMc/6
 qTE9gmGKJN9DZ/T3Tsww2ApKOe/6E4fs/sEYId/uWQjE8Q2sv+sNa/OYbTv2/TdMbFm6
 2LBFm6h+09VmX5fJeSrPCOVQviBFEOpW+ejI7aSoJaJrztGLTB3xvsIku29hVkebdsD4
 /4Jz931ZzYKRB85q5k7nAon/3Qz05TT5fD//QyuSyAVLVD0pvCEXRCxf7gh2EO/hEs9p
 zkHdag1cDGqHWWVOG47W2K6LEMTuiNplR2VpEtQvBHUM3fiTDUanXLqw97nhkMUjK49d
 ek8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqa+vt5duKFw3lZ6X4K2eix+4vsXvPvKPZuw8kKNxkWOtHKAKS5yAXcb16h31BZTjS+hKOepsinZPp1VAQvsw2bt1VR4M=
X-Gm-Message-State: AOJu0YyYi6JZllk0Iqrtm6QwC5L1dDSaOgINpzVe1baN1Uwif5esbqVt
 BtxRlIHXaLS8GZKX7k6fkTqIcGC2NpKhwXmZILFgUp4hoFIvN/MGZv+1aUE2p6/4QPgoYcr9DtU
 2k6Zz5sd1/9DhFL1Zq+xB2iOQjXDQViAPW1pHM5z+Wq4UYUfvg8Gn
X-Received: by 2002:a4a:a683:0:b0:5aa:3e4f:f01e with SMTP id
 f3-20020a4aa683000000b005aa3e4ff01emr12580220oom.1.1714418479771; 
 Mon, 29 Apr 2024 12:21:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG18tn6Bym6xwLKkGzjS9y3T8iDx/N8WQjYYGNqQ+rM4iJwEGii+IpSxCOzDWrt1Swpwei4Jg==
X-Received: by 2002:a4a:a683:0:b0:5aa:3e4f:f01e with SMTP id
 f3-20020a4aa683000000b005aa3e4ff01emr12580201oom.1.1714418479348; 
 Mon, 29 Apr 2024 12:21:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 bb33-20020a056820162100b005acc9e07626sm5083362oob.44.2024.04.29.12.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 12:21:19 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:21:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v4 1/4] migration: move trace-point from migrate_fd_error
 to migrate_set_error
Message-ID: <Zi_zLNf2CT3J3BUf@x1n>
References: <20240429075541.1959050-1-vsementsov@yandex-team.ru>
 <20240429075541.1959050-2-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429075541.1959050-2-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Mon, Apr 29, 2024 at 10:55:38AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Cover more cases by trace-point.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A42C54798
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 02:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reQSD-0006a5-Hx; Sun, 25 Feb 2024 21:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQSB-0006ZY-DC
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:10:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQSA-0002Vf-3G
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708913449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=82JYdmHKqA8PRow7oSnznBWtehNRLkAxxxQKzaRgvzI=;
 b=CrjKwMrML5ou6254lHsdVQWipHI0/yNNrAB4LAqeu+i6/N+SivLA2k7k+yAAKUi21AAn/z
 GU1zIuUhSMbdEk/4/uBAT8Jn23QMC7czYLjL0XnYw/T8E0VigQvkdy7GP0NZutl+Kthaxv
 /9zjm3sjg/oqAjTHP5AGhKKb1Hx/jLA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-eJzH_JXlPjyNvtVt_4KkWA-1; Sun, 25 Feb 2024 21:10:45 -0500
X-MC-Unique: eJzH_JXlPjyNvtVt_4KkWA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5ce9b15f4ccso1499692a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 18:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708913444; x=1709518244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82JYdmHKqA8PRow7oSnznBWtehNRLkAxxxQKzaRgvzI=;
 b=J9+41S6vDf+EzgzQJIX3l31Ci3PN7brXum+WjGz7l6u9U8BVJRJ+eUhQVtM1f9EOsI
 ZtNrRzL/Pi4IYZ8FVFi2jaxtgJOiKt08VyVjEopB1pQv+EFLdyhY2t6YPG7G0zU0MMVk
 8+upF/kKfSD3L+pEKQhWjFFL4wkzMy62GSjAvtTEZWtUmMWxY4c9BOPnAdP/JSzQ001Y
 Tef1ZSJy1Fjq4mrmUkbyn4WBKEABrTrXxMqM1XZJ5sVJPQPQBuQy2Z683aOl3aPBYlG+
 moYhHUt6ybsRwtMSrHIColpnZ2EJrm9BWyvwKeGoeBuCpjjpZfcDWcGApytxv2K2N+DD
 2LPA==
X-Gm-Message-State: AOJu0YwtHTCOktTbzVkiVxx4YygTryCvoa/+PxcW869qRRbPUIYqJ072
 ww9VwwkK8gVrry9VEquGHIlawZX00XhtmcFVYDpz8PzkvxkpIiz5qfF7kd5zcA8wqKnoxyCBPm9
 IvEy+ER52RjGrtU5lzgJuTamzlUNBttheMNxnpqG6EV6+wRerBHtV
X-Received: by 2002:a05:6a20:9186:b0:1a0:dcfd:feda with SMTP id
 v6-20020a056a20918600b001a0dcfdfedamr8940121pzd.5.1708913444802; 
 Sun, 25 Feb 2024 18:10:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcSUTk7yE1Z2xn56NmIbFsBIdUfWzx3k7RmZn0AAjJ15QHKKxfyoQVNGqG1jJyq9yLVfDPZQ==
X-Received: by 2002:a05:6a20:9186:b0:1a0:dcfd:feda with SMTP id
 v6-20020a056a20918600b001a0dcfdfedamr8940108pzd.5.1708913444495; 
 Sun, 25 Feb 2024 18:10:44 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t6-20020a1709028c8600b001db66f3748fsm2754145plo.182.2024.02.25.18.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 18:10:44 -0800 (PST)
Date: Mon, 26 Feb 2024 10:10:37 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V4 14/14] migration: options incompatible with cpr
Message-ID: <ZdvzHXpVYJTp_eBG@x1n>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-15-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1708622920-68779-15-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Feb 22, 2024 at 09:28:40AM -0800, Steve Sistare wrote:
> Fail the migration request if options are set that are incompatible
> with cpr.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



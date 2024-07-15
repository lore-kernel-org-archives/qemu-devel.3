Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D53FC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 10:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTJOh-00082v-Eq; Mon, 15 Jul 2024 06:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sTJOe-00081q-1F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sTJOc-0002nz-5v
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 06:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721041047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9CmFQNsiKWfKLFe/hMP7/VtPdTWndGTId99ljWXB8EU=;
 b=Zsqsq6A16mRdJus+Nx+IRDA7w3Cxg3F+daIMGrqz+qwJHGb7G6qtLLsh2Wpc2YcWSsSAuE
 qfIMVGE0OZdsyzZLH/aCJhL6NzSwSUnUSxri1C9+YUjEFBTWIgvY6pMsJWNGJcwFA1dq1e
 BxU1xf4wBGbECh8ACYVE5L++L3FtfAg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-rrlO94lOOPmHrtGm-bGO_w-1; Mon, 15 Jul 2024 06:57:25 -0400
X-MC-Unique: rrlO94lOOPmHrtGm-bGO_w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ee847979c4so41027811fa.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 03:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721041044; x=1721645844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9CmFQNsiKWfKLFe/hMP7/VtPdTWndGTId99ljWXB8EU=;
 b=LZLrZPj9F+1LJwDc7vJ6YgdkX1baxvmLPXNZH9H3nyJQ2yfsgTDKL9P+mDf387uylx
 GaxTJFz1PEiORNdjtM0W3wfpbZ50QC9uN4oAl1pxBUiCs39vV5oZM8GTTorYgsR1MbXE
 LyCyOTP8WX+RPy+fdg5f09vDvty4yYUtY62af2TzisGUwMn3gm8rxazQQGPGfyAMoUew
 TtSx/C+/eQJD8b188ob4WU0Z6Yfeg/YHOzmS1UDyNa3eJy+ss2iCN+5ONCe7QH8tOa/Z
 eHQANmcn8unSru9/1db42lcY22f4HeYm/XcPeQZEv/T4IItYJVjGh/Okx/mOFLS2c1RZ
 FRXA==
X-Gm-Message-State: AOJu0YzNsZBPPDA+zmUdtQG6PeQ93cCsSl5dVbpceVPRxeCcQVKR3M/s
 0Nydx6y9xmPTOOxLWMP6XqyStdo7zYhqAmug8kruvqiCX8JagGsNjq6vsAzertzwcY7GL03fy7P
 Gh2HLbjL6hsvKHhW2U4BaEOLYEKHPfiQzTtPaLiGXosTtbFGfXSy8LewDuO9o8c84iteRYldeOI
 ai1aPG19mPkp/eRkWfl59RMklw/m0=
X-Received: by 2002:a2e:2ac3:0:b0:2ec:1708:4db2 with SMTP id
 38308e7fff4ca-2eeb3197a75mr113578901fa.47.1721041044315; 
 Mon, 15 Jul 2024 03:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj5Wvn9qn2iGEb+R9qPgn592a91YgtuBv3WAlQMSG+kYeovbPrtLby3rZ4W5lfkPTR3MX9qxP84HdViqoU5iA=
X-Received: by 2002:a2e:2ac3:0:b0:2ec:1708:4db2 with SMTP id
 38308e7fff4ca-2eeb3197a75mr113578771fa.47.1721041043946; Mon, 15 Jul 2024
 03:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240711131424.181615-1-ppandit@redhat.com>
 <20240711131424.181615-2-ppandit@redhat.com>
 <20240711103910-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240711103910-mutt-send-email-mst@kernel.org>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 15 Jul 2024 16:27:07 +0530
Message-ID: <CAE8KmOysfE-CusNjXmGR-E=RGyHM4mS0eCqrNLYqwkzR=mm38w@mail.gmail.com>
Subject: Re: [PATCH 1/2] vhost-user: add a write-read lock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, 11 Jul 2024 at 20:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> Could you supply a Fixes tag here? What commit introduced the race?

'postcopy_end' message was added by:
  -> https://github.com/qemu/qemu/commit/46343570c06e63b4499f619011df80f91349cd49

Not sure if its race condition also began with it. It is not clear if
the front-end should allow multiple threads to talk to the same
vhost-user device.

Thank you.
---
  - Prasad



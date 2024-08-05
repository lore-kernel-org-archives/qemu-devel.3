Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19DCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saudx-0002Xr-5W; Mon, 05 Aug 2024 06:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1saudv-0002SN-L6
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1saudu-00030x-43
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722852521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q1QOHUERsARlTO0UwyGrm9hG4qoFIsvU40N7npvYiU8=;
 b=acVDpgSuJE+EBgFvZSWcaoyGrijB0T7P/r2bsu4b1W8KN3ROTRpZ7bnxjMhwpeyR1HsYI5
 UwnzO5kOMD+PF/34hEwbhTri1+h2/nUCMMEDR/Owstp5lJMLQVqs8hj+easYEdc6sFrCbo
 JiaUEiKAaX5O62sr0E/nNL+dP2dqueA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-AcxlCKmJOya4IOeUvewoTw-1; Mon, 05 Aug 2024 06:08:39 -0400
X-MC-Unique: AcxlCKmJOya4IOeUvewoTw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-427b7a2052bso102071775e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 03:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722852518; x=1723457318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1QOHUERsARlTO0UwyGrm9hG4qoFIsvU40N7npvYiU8=;
 b=motUNicfDjzGTCuFmyFASwWjMmq8Qu3xQrqBvK2DSRQ0SFz166a5CWZugRNefKV650
 Jyby1DKZKuM8irC233HhZd/TS8JHtUmytv+l1XXZSDzu2E/GuG6MeK8Txa7LktI+ZgSp
 Bn4RXk6x0lffEbCQ9zmvr11Vw4IUYAKHo/Hj5Cz1CQKXcKpl70EuMBVsJhg8rU7uKUsH
 18JlyxJgqGhJ3x/MeM900WNAB5+txQXyOKvdz44ceIBe1TFNigeKaRNwtSQbqfy75mfB
 NxRHQ1TDu/stCsQdu+NzfmQRdzXEmaqsLfZdYjiQOEGJvSp0A0OwG53xI+dKHcocw/uU
 AUpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvDvFAItYNMvCQ1AFALg2Glt3O1q0E+EzhS4EcfQsZNUvHqAs4S4VYOSDqJ4orxscG8zT0GOEXvsYGk9XAt8ZOfMoLt5w=
X-Gm-Message-State: AOJu0YwYTbd/yqNnRn5qdClgSlerCnYTpq4TfwuMqVuAuYugrbjXBGjf
 B4JyF+GjgUCCi7jcMQOt5t+lgYyrZeDfBgGBFPEGPEqJz7oDqcyXyz3F3QrLdraZn9lydac9txY
 86Ihhmkwcw2uX/c2d3232hAF5oXs4ujiBj6pkn7qtpcPAdiUGApCH
X-Received: by 2002:adf:f4c1:0:b0:368:7f53:6b57 with SMTP id
 ffacd0b85a97d-36bbc0ff305mr8706750f8f.18.1722852517737; 
 Mon, 05 Aug 2024 03:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELRTv1nxDzFYRBsD8ArRpDvoqVV5FjSzbR8NU1nNPoph5y2b/0vhdXmUPs1XRpVARcqWcYjg==
X-Received: by 2002:adf:f4c1:0:b0:368:7f53:6b57 with SMTP id
 ffacd0b85a97d-36bbc0ff305mr8706704f8f.18.1722852516844; 
 Mon, 05 Aug 2024 03:08:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:dd95:f049:da1a:7ecb:6d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcd02563sm9409060f8f.0.2024.08.05.03.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 03:08:36 -0700 (PDT)
Date: Mon, 5 Aug 2024 06:08:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240805060544-mutt-send-email-mst@kernel.org>
References: <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com>
 <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
 <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com>
 <20240805032937-mutt-send-email-mst@kernel.org>
 <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
 <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Aug 05, 2024 at 06:37:58PM +0900, Akihiko Odaki wrote:
> If cross-migrate=off, QEMU can still migrate on the same host (checkpoint
> and restart). QEMU can also migrate across hosts if the user ensures they
> are on the same platform.

What is so special about checkpoint/restart? I guess we hope that
downgrades are uncommon, but they are possible...
-- 
MST



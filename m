Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BB9CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 15:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs2pH-0001qJ-Ji; Wed, 03 Apr 2024 11:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rs2pF-0001pl-4T
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:46:57 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1rs2pD-0000H4-Lu
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:46:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e0edd0340fso58735965ad.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712159214; x=1712764014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utX2Y7jibJkdREk10IdxiDljTEv2Ini99Izv6ZjFPFE=;
 b=OO8VDH/lzBTz2GShTIlHYGql/Ey3Lnj++ZIAlbgtMpq3EgFEQIGuPGKhBqkYxMmdg/
 E0y+lLt8NDbTUVm665m5pB4Lp1Mt5socgCN2Ia2j/g2MSzcVwTQ3EHjB15GoGFLsK+bh
 Uctc2+jJ087g/6hzyX8CIcppCRWVUcP5cdCdim/d+CFhiJcQfxB0MKdDaHdEBfW7Gxfm
 5GkMn1KaHhRT3HnmAAD9HVIptOjZYIcwoiQ+rGBCUauRYTz4+V9+0xuPqhDn/r++8QGY
 6GPxgr8iZs45lASGL8s2AnYAhnbpHKUzrwnBEhpFwxhWSftUxPX6ZKk1Qds++x/DbeCC
 DSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712159214; x=1712764014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=utX2Y7jibJkdREk10IdxiDljTEv2Ini99Izv6ZjFPFE=;
 b=IP6221OZOE/Hto8Zfq+MFYFcdtDR47uGiooKaGOa03GCeW5lJlK9sE53ry1VANtaTd
 UJBXu5LMZyK4Jwj8muIrtWgK15H9v+XIqe8gI07b33Hb5Af94lCsLAbC39hRy0e4+B8Y
 KHEHNzIVQeePZirULa0AvwbHGK10T+2QYkteZP3/h8+E6pSxqx+L0A61tjXv/ZW3ndU2
 Wh7T++lF3dY6CuDjaLZk/wWzlA3e+3nd0vR0WCs2xfLWJ9K6jKOM4nTjZHbrdaErXIkR
 OIYDgRzdCp+ft3XcRmd4yVC7Ry1NFNUuQP5ejGI/3T2WTjCRXw8/t650vafVwlFGCSrq
 b29A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqHOJZEP/pWEXCr3ZqJ+t682iTF7gss3lAQwqRHfIT0w6vSfoEIIYsCwNHPl5pf2b8i2QD522t9bAmBzMUlqi95KrrCYg=
X-Gm-Message-State: AOJu0Yx5VDN2tqgWkT0w1h8nFUA+s4YzreJuarKzrrQQdnlAjjfo7vrR
 TaY6rb0U0dmgy4YfJ8GpcJtKK4/HaRTeqJKNWvdoejoDdZogu2WW
X-Google-Smtp-Source: AGHT+IF5Swc1RmSE9x2iUW2dTMAq2bl3Lk3/H2Ofw2ZURu+m93KiqTh37xdhHbBue5QtlFowNXRBzw==
X-Received: by 2002:a17:902:d4d1:b0:1e2:a31e:5e14 with SMTP id
 o17-20020a170902d4d100b001e2a31e5e14mr383341plg.13.1712159214067; 
 Wed, 03 Apr 2024 08:46:54 -0700 (PDT)
Received: from localhost.localdomain (c-24-7-119-110.hsd1.ca.comcast.net.
 [24.7.119.110]) by smtp.gmail.com with ESMTPSA id
 h13-20020a170902680d00b001e27462b97fsm3610884plk.293.2024.04.03.08.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 08:46:53 -0700 (PDT)
From: Justinien Bouron <justinien.bouron@gmail.com>
To: armbru@redhat.com
Cc: berrange@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 justinien.bouron@gmail.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] input-linux: Add option to not grab a device upon
 guest startup
Date: Wed,  3 Apr 2024 08:45:39 -0700
Message-ID: <20240403154539.10256-1-justinien.bouron@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <87edbmk59j.fsf@pond.sub.org>
References: <87edbmk59j.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=justinien.bouron@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
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

> Again, QAPI schema

Pardon my ignorance, but are you writing this because there is a problem with
the QAPI schema changes that I would need to fix and re-submit?
Or is it just here to indicate that you've reviewed the change made to the
schema?

Regards,
Justinien Bouron


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1D2CD8CAE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrXB-0000c2-DX; Tue, 09 Jun 2026 04:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wWrX7-0000b8-8e
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wWrX5-0003QA-Ql
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780992598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsUoHlDOBU2cQoU8ZoCoAhLpS2AllN21eGMIWotZzUk=;
 b=P11UzIEZjF0EVH/t8vDSbew19g/1owWbbS0Q9hHixbYlWQ5b8JHTrr73fqhsiX9kjNtF+m
 i4DF3tk4zp2TIe/6Y39vyvLMiiUOtaNxaXlHkGIW2GpyAr62/bmhEGU38Ot27dT3kAzf5a
 iIYLEBW2s8LZCxfPWHiMNGhjOdjOjCM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-cQPzgzOUNUqxbJ3SlWq4GA-1; Tue, 09 Jun 2026 04:09:56 -0400
X-MC-Unique: cQPzgzOUNUqxbJ3SlWq4GA-1
X-Mimecast-MFC-AGG-ID: cQPzgzOUNUqxbJ3SlWq4GA_1780992595
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45eecec7667so3665126f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 01:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780992595; x=1781597395; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fsUoHlDOBU2cQoU8ZoCoAhLpS2AllN21eGMIWotZzUk=;
 b=J/p8T/nru9fyBw4/hYy+7hS4nh7F9ZOn2L8MTnjn74/SKRcFDfENW20xVsS2enza3X
 LXIq8LVz52O/BpDdFNBkM7XHgWzlZtlFuMjJ3zx9flGjwB+Slg30XlZR4kjLFDgXEAJj
 L9TpNix3rDr1R10O2bTKyfFR9I+TElr/QW/Qjnqpj3muWHCYzQH8mWR16ZnX69OQv1SD
 peuo3uyfvUVLit/K4YcuMktnH5bVWJQuJIsyE0H4F0eXEzbItCIzI4EVBFw9Xz1hLF+7
 kzIvP//zgqwQOGFxGlo90DbEXJD9GHsE+yBrrwBdWn7OA4JRiwfWOIRgPlFT1LqSc6on
 uA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780992595; x=1781597395;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fsUoHlDOBU2cQoU8ZoCoAhLpS2AllN21eGMIWotZzUk=;
 b=DUx8blTouqAon7GX7NoedeusS3NGWpzbm533+kWc3i+CFYFyYOF31ljghM7tWAAFfB
 OVOuyy/AuIY48RjzgJHGNnO9ljnY3c7SJ5ln7qH0AqRo4NUlaNS85yBrM/33KCoels1+
 xOzdfhyKUqNbUEUZ1Dl5xZL1aCCPyfd+80gJiIt9dnsiHYk65tCme4Bfw9/FoykkX3O0
 p8hAW74sYnH4tcnwNbibKqqwQU5J6X9plYKDvxPIXw74OL8MlfMWtE7CAV5IQfSuzGwE
 wqC02qcO/3dGQ1m8yp6qylQyE8LyT8RcFSKJEF+cZvLVyzClOCuG1DE77kJadXRdo4Us
 V/FA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oNoFNUTW526aRgimo3q2YcqlW+ZUC6LL8Y0UJ1IC+lembnRQI8hpjdCDrFLMNTDAow4pQAAfdD+6E@nongnu.org
X-Gm-Message-State: AOJu0YzxO5JvHs3dmv4RrsEFp9ZPaL4O/PvdXYnHD1U/nxQKxKoCyv52
 cVS6BtLDJfDnCwW6VpwjfFyaEizCaCJf88D71Bjyt/CsRiPr/p+IabGYavrIkxLEKZQzCGjah+O
 +lyptPmjUiF+ktFY8wFvsUz+P7MlCTmStYh4NYguHbLSDkURXlWboXrHn
X-Gm-Gg: Acq92OFwtUSR1k/eOcu8u1kAuWtP6zMHniUUX/d/G58YVqMaSBlFTLSlaWbEie7WGHO
 OJB/c8UlYYZeeY8YbP6liXvHKVSCsILC0KrAPLXHinD0dAB3rBRQ5Tv8iOZL2AqYpwPaRpWZq7B
 IKJBh4fDBnEegdj63kAwfMAw8aCKCwnGXUThxPtBT9WXkILYr5V0YIc2sQr+pF48VvH0G3If6rl
 ZAW9FVYkXfDZXW6OTipkESKW/A1Y917qG99rgzIdYyhqTyiHBGEBDdSmNOs5TzGkrRGjHTnEsfE
 04D0hSjEyZ0SvRiCKvTvHgq2dRwgwnBDZDqWpM8DiSa7qTG0TTH69KW86QRb2gjs+QYk8EBxmkZ
 LANNOdo+b6ihqMzyqZGkRLV3L/fOTmotUsBrHD69Ok4nYzFyOzoBYdQ==
X-Received: by 2002:a05:600d:8444:20b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-490c6c20071mr153795055e9.3.1780992594714; 
 Tue, 09 Jun 2026 01:09:54 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:20b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-490c6c20071mr153794375e9.3.1780992594210; 
 Tue, 09 Jun 2026 01:09:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d5d2b4sm302754095e9.2.2026.06.09.01.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 01:09:53 -0700 (PDT)
Date: Tue, 9 Jun 2026 04:09:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v6 00/12] virtio-console: notify about the terminal size
Message-ID: <20260609040710-mutt-send-email-mst@kernel.org>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <cc0b8cce5bf5763ace058270e9d80fb84873dbd7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc0b8cce5bf5763ace058270e9d80fb84873dbd7.camel@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 09, 2026 at 10:02:40AM +0200, Maximilian Immanuel Brandtner wrote:
> What's the status of this series? It seems to me to have somewhat
> stalled, because of the virtio resize event discrepancy that has been
> adressed by backporting the relevant patch. At this point it's been
> almost 6 months since any changes have been made to this patch-set,
> even though at this point it would have to be refactored to address
> changes that have been made to QEMU since. Has progress on this patch-
> set just stalled or are there any remaining concerns about the
> implementation of this patch-set I'm unaware of?
> 
> Kind regards,
> Max Brandtner

Whom are you asking?
There were comments on patches 7 and 8 and Filip seems to have indicated
he intends to address them, and even posted diffs.
So now, I expect v7 with that.

-- 
MST



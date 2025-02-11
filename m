Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABA9C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thyr5-0000ul-Aq; Tue, 11 Feb 2025 17:35:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thyr0-0000uP-4w
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thyqv-0000dw-Tz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739313331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZAkk5RMdk0LCd6U3Evsbc4u3ZHW3jTYk1O47DAw+zwc=;
 b=iDHmq2+CVNV/dQrCb+WcROaeeNds2YXIm+nGxH237c0iY9THS7zMb3ZrjDVxMuzhFuKrrL
 GXrm/KwQtQtiZEiHJANOPD3u1qolxRNF5WIAV2UlxOWZz1oV8yvvCOTm5EkHvPu7nHKXtZ
 LO5BPT8vq7vq3gufLyqzNWZj0f073Ho=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-Hd6J-IjZO_2jDnW5Fi4BFQ-1; Tue, 11 Feb 2025 17:35:28 -0500
X-MC-Unique: Hd6J-IjZO_2jDnW5Fi4BFQ-1
X-Mimecast-MFC-AGG-ID: Hd6J-IjZO_2jDnW5Fi4BFQ_1739313328
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3ef3847424aso6702913b6e.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739313328; x=1739918128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAkk5RMdk0LCd6U3Evsbc4u3ZHW3jTYk1O47DAw+zwc=;
 b=XAp7SJY0fzhI31QoBPBEALUJyIPssXGBKUPQHr2rvDEFZZYf6JvWilfu6lWlVkjEq+
 wuaFQr+BXYLotMPFtE1OZedZg7rzKwUKfvpX94LvtGp4q9IwwbZLL98DHmoBdpH2Y2U0
 AOO5t26GgfiHHJTwU9lwQoAMJVTZ9Pp8FE2vZK4uIxkbR5mJa5GM0dILlbG05MpZWIV0
 0ZGJAcKk4ED504KMsBs7xYzlS0r1ZhiuQNPo8jpbnLcwjnKe2BXR+jONNdKbvBTRMH49
 6du24KP8CMobXuqgDpV8q0w15Czmu2m3uVlMonEvQlJHnppmgxnXWg4xope4UyplEEzo
 hJUA==
X-Gm-Message-State: AOJu0YzNh2/WPLfXGFEUxIBSsresQl22cUsiXb+Op6UHVY/0IqiLRiSo
 wdClwHkpjFkqzuxxKJE/QhY1g7GLWpAXi6QPcDU7y0gwmnvbLHOlZIYeGMMN0JB6O1l23GhTn/6
 2mH4eZzrQSb10vAupNL01FnZ0GsTWJo2N25LF6MRh6OOZHajZ2Vqe
X-Gm-Gg: ASbGncuQt/8XjXQfiz0ZpKqSWxmZ1BP1lpX1Hp+7HlDpvdKfsVWuI6M9f5cV8Ifit2L
 dj6IMruf7GhX2AtXeV5rkahv+imYSKPu+sr6StZaR8JdYI0O8wkOjOi1U5iVAKtOp0wMuAKK+0r
 G+MNJI5ptkUcZWRezwRcJzv8o9CR5ogYlQdfv24Cr4Ku1xNOhuMe18lgvy68rRjuGSzzG2aLftg
 75cBzFYhl16vdk1A+bZky6IPVKfsbiwG+0elJFC6YZ17SzS+5PQ1L/JMpY=
X-Received: by 2002:a05:6808:3a05:b0:3f3:ca68:57fd with SMTP id
 5614622812f47-3f3cd5cbb97mr1162592b6e.9.1739313328224; 
 Tue, 11 Feb 2025 14:35:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG2YMLZ2kiGuA2L7IlTzH5md53qY/iZ3RavTZnbY3WROeTroxo6cXye3rp3uM8/7DPyXrsaQ==
X-Received: by 2002:a05:6808:3a05:b0:3f3:ca68:57fd with SMTP id
 5614622812f47-3f3cd5cbb97mr1162574b6e.9.1739313327932; 
 Tue, 11 Feb 2025 14:35:27 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f3c26174adsm1322798b6e.35.2025.02.11.14.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:35:26 -0800 (PST)
Date: Tue, 11 Feb 2025 17:35:23 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: Re: [PATCH v3 0/7] physmem: teach cpu_memory_rw_debug() to write to
 more memory regions
Message-ID: <Z6vQq9nzzCI0JE8c@x1.local>
References: <20250210084648.33798-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210084648.33798-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 10, 2025 at 09:46:41AM +0100, David Hildenbrand wrote:
> This is a follow-up to [1], implementing it by avoiding the use of
> address_space_write_rom() in cpu_memory_rw_debug() completely, and
> teaching address_space_write() about debug access instead, the can also
> write to ROM.
> 
> The goal is to let GDB via cpu_memory_rw_debug() to also properly write to
> MMIO device regions, not just RAM/ROM.
> 
> It's worth noting that other users of address_space_write_rom() are
> left unchanged. Maybe hw/core/loader.c and friends could now be converted
> to to a debug access via address_space_write() instead?
> 
> Survives a basic gitlab CI build/check.
> 
> [1] https://lore.kernel.org/all/20241220195923.314208-1-git@zabka.it/
> 
> v2 -> v3:
> * Rebased, only a minor conflict in the last patch.
> 
> v1 -> v2:
>  * Split up "physmem: disallow direct access to RAM DEVICE in
>    address_space_write_rom()" into 4 patches

queued.

-- 
Peter Xu



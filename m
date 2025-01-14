Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D377FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkkM-0001te-EA; Tue, 14 Jan 2025 12:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXkkI-0001gy-4A
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:30:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXkkF-0007w3-VW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736875825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OBuhSBtGtaneIM1HVaxAHHUOtKyPKIADpNw1MuCMcog=;
 b=P4g4k6Fc6f6Nz6xMITPA/S9mIvyZAEuo4KhcWurEnOXJ/HmoHO2NyBzxrpvsmRgqzpcF8M
 hlsKMvjCIH3eYgXettKM1SpflIA0anz/uMFponjBfgZJUSOksk76+/+atG1aFwr806WeYZ
 WVukOT61xH75Quk7lousE9ltrVe+mSo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-82BKWFejOOOouHBEJ9L5Rg-1; Tue, 14 Jan 2025 12:30:24 -0500
X-MC-Unique: 82BKWFejOOOouHBEJ9L5Rg-1
X-Mimecast-MFC-AGG-ID: 82BKWFejOOOouHBEJ9L5Rg
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2162259a5dcso165297415ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 09:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736875823; x=1737480623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBuhSBtGtaneIM1HVaxAHHUOtKyPKIADpNw1MuCMcog=;
 b=eULukd5GFyL7J8uqSgSqRAziCeU5eHG3coNHv7uL3M17yK6IJO0C0XzZL80mDzU+be
 0fPQJ2eoaCwT20QVOQLFb+20jvkSYUjymFVIUZ31/HJre/On8/yYSpqvv0PfGRs7/d9z
 WM+Dz3dxz9s2VDO00A3aW8K14/yYmaYmJbUwNkUE8M1BDmaRnrNubQtDVORRpHvc7bmy
 UVln9GxuQsmuqWw7gOJwRLO6NWrBkIfNemMZzFYDj++0mXckUXkWkkZexwTxMEE35sPG
 xbuUszVh8L5LD8ikPt52Tg0YyCDLUbSgrgrpNhrzTrMqO2tjK0Tw5SHSaD+fMlTZaTa3
 bqsw==
X-Gm-Message-State: AOJu0YwT4HaFRWg32u7iXB3UkVwPEB7+Z3uFxA1OyOmDpYnMgT+j/b/N
 nPfZsRjxJ5CZuUVysNskqu8bbgc7vgqGvHpuM+KrklAxHv9TSJh36uW49cyR10sTWjH1ItJnn1E
 DNluWyvXHh/Ly5Fzx1ktEYozwdvVJQxcOB5ljsCti7+mavFOrMioO
X-Gm-Gg: ASbGncs62zEacZ8mZHyzMWKGwhDLJEhMKueTZiT+pIsQXbnFXgB4IGfAYZs7H9tA8Mw
 f4MEyiDKVsdmudtAuDgsdy+Ngn1NIjNjZV/zJmB0Lb4G1hxhz3sImqlvc03uGZ42t8IqQ0JsXly
 3tVo/t9imCDuzi8LAvHotz9SY3bg+kshrFNAn69UduTQTKF0zbBwzoszKxewQ0wv1hKT1pSb4eU
 BBEXg+rmAdhYcYGKakCoxuNA2H8ixfy+Zd4DcYqnesOwfnVaVEdX3x60s5aMtLo7jM8ZCHSC5bE
 YP2fXbok26CA3rVvRA==
X-Received: by 2002:a17:902:f685:b0:216:7761:cc36 with SMTP id
 d9443c01a7336-21a83fe4b6fmr419463085ad.43.1736875823169; 
 Tue, 14 Jan 2025 09:30:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE08dAfkZfYF4x4+7R5aF8phfCzHZDzCweFqjqyeAzmBlZC6rXTDrceAi9DM0RRVwabdioEKg==
X-Received: by 2002:a17:902:f685:b0:216:7761:cc36 with SMTP id
 d9443c01a7336-21a83fe4b6fmr419462765ad.43.1736875822872; 
 Tue, 14 Jan 2025 09:30:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f12eaadsm69993425ad.70.2025.01.14.09.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 09:30:22 -0800 (PST)
Date: Tue, 14 Jan 2025 12:30:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V6 03/24] physmem: qemu_ram_alloc_from_fd extensions
Message-ID: <Z4afKuHgwtLamFez@x1n>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
 <1736875434-106563-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1736875434-106563-4-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 14, 2025 at 09:23:33AM -0800, Steve Sistare wrote:
> Extend qemu_ram_alloc_from_fd to support resizable ram, and define
> qemu_ram_resize_cb to clean up the API.
> 
> Add a grow parameter to extend the file if necessary.  However, if
> grow is false, a zero-sized file is always extended.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



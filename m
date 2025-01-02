Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAFAE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 06:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTEHg-0002Qr-2c; Thu, 02 Jan 2025 01:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tTEHd-0002QI-GM
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 01:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tTEHc-0004mi-22
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 01:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735797730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=y/MDtJqzGHbU8xNbzoBXw0lox0XnyQItPpjBdQOrGTM=;
 b=IczXIh8wYAt6SIVVlXwYzi8NceDPVPEtSnQn3OHFbKw5UM15tADM5vMe4HeqqOZd7CV2WI
 /XOEqIu/X4lSfemswfOR4yr7tIoC902v4tWH0s7PDViD0a9xRBRP6xZ+CDM6S5MhxC37SP
 ZA6uPQ6gm9p/DKEvvV585MmGtaEOsc4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-fYprjmzUNRav6klsD2Htog-1; Thu, 02 Jan 2025 01:02:06 -0500
X-MC-Unique: fYprjmzUNRav6klsD2Htog-1
X-Mimecast-MFC-AGG-ID: fYprjmzUNRav6klsD2Htog
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa68fd5393cso342131166b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2025 22:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735797725; x=1736402525;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y/MDtJqzGHbU8xNbzoBXw0lox0XnyQItPpjBdQOrGTM=;
 b=alCkICykRI6nQyokUhhEi3n9Tqie0VL3Y5Q+qIgdYBV6iMswjXMCKttkckqGGaxP9k
 F/W+2h0aODDzLo58ucE2XmFzz7X0BN5Vm6Y2Upj54j8zwzk4gS5J42rxpevgSuijoBF4
 QwXppKMVaxzV+JP5cxzptf3UiVP+VnmbLG9pt0Mxi4uotKWBKx57F/DhtDhdBMVhfdlV
 99I67RGh0WFM7OKG8eMfuCS9qsP2r1yziF76HcuMzzt6ZEf0ZI8Ahs0XOXskKiImHZMB
 5rYsGG6INfS1VydCMMWI73xvYk8kLRpoGdGOu9ITyF7Y7sV/JeTtvzWTjOgnHAvWLs7m
 DeRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNFchodTxe7BG5x5m+pueR1i3jaixKtpTP39Xf7DhoJSGfv6Eftty/mPnp3+Gux7wQkCddeWMecQZj@nongnu.org
X-Gm-Message-State: AOJu0YwDGARJXweZvRpfSMqI0/N9hX/gNPlNk2VrrCQenG6hBOUm2uXP
 N7CqKfkPvuL37qSOXlv6YE/w2H4w27ZakC8iE0ilSkh+1iUzccSOq5CIf+1sjKf3v5ssjR0twVA
 aWh8anMFckG3giUKcICMiO8MGMRzzWFHDY7P27vgMZdGwzpL2kIqzeq42IWTG8eeJaDkCq28M8m
 QxUZt3pO3AYm130GygcZNvQx+5upjttgNi93M=
X-Gm-Gg: ASbGnct8MlnhKwIDZ2D8nNl4IJvPAJNTkIy9ire87vd7HApUOIO6RTQLz45n7mvW8T2
 wMknezwUjeN2VbhUKlDJJJLoswYEaDIXjzE3yeA==
X-Received: by 2002:a17:906:f596:b0:aa6:88a2:cfbd with SMTP id
 a640c23a62f3a-aac346918fcmr3338667166b.22.1735797725137; 
 Wed, 01 Jan 2025 22:02:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI3sHCibKy+RUFLscioFqDWlJPVZcDYdNNuhYoJbUKlnKccxlPZHjPxNcf6jtzSjA51piv42+UbCtFUnHbF2k=
X-Received: by 2002:a17:906:f596:b0:aa6:88a2:cfbd with SMTP id
 a640c23a62f3a-aac346918fcmr3338666166b.22.1735797724795; Wed, 01 Jan 2025
 22:02:04 -0800 (PST)
MIME-Version: 1.0
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 2 Jan 2025 11:31:53 +0530
Message-ID: <CAK3XEhNkhJmHDWwJinbDd31OnXUWAPoqPS5TuykqEUyiu=Gz5w@mail.gmail.com>
Subject: DMA interface support for libqos/fw_cfg.c
To: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hi Markus:
Currently this library can only be used to read fw_cfg files from
QEMU. It can not be used to write to fw_cfg files since it does not
support the DMA interface. Is it possible to add DMA interface support
to this libraries so that we may use it to write tests that write to
fw_cfg files?
I wish I had time to implement this myself but I am too starapped at
this moment.

Thanks
Ani



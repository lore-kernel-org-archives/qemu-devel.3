Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A83CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqWBp-0000eO-Lg; Mon, 25 Aug 2025 08:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1uqWBV-0000Vq-Os
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1uqWBM-0002Df-Vs
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756124405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=4FsNLiGPQGJswkGU7iRyvMtLwZs9hkA1RyGtWRXQz7U=;
 b=HJgjYDimZO7qEeTVJpCSkaoxKNAyZ4PwcC/qJUQ5Fl67pgOi051BY8t0eveOc7CPOWxIie
 noxDQaw5HxLd6442UnEK+Hkc2r8f0GY1KyJspbhdIgjEVy/dmZ9LO6jwDQMR62tqrzdyM3
 H9+SVHPjssSQaNDxGYYKXlIDeiRjJos=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398--vvlliXlO72p_rFfmCXT4A-1; Mon, 25 Aug 2025 08:18:04 -0400
X-MC-Unique: -vvlliXlO72p_rFfmCXT4A-1
X-Mimecast-MFC-AGG-ID: -vvlliXlO72p_rFfmCXT4A_1756124283
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b109bc103bso101158511cf.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 05:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756124283; x=1756729083;
 h=to:subject:message-id:date:mime-version:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4FsNLiGPQGJswkGU7iRyvMtLwZs9hkA1RyGtWRXQz7U=;
 b=d1109972/7UvRPa/ptYj/SYAkMRM56wl44NPThoUI6ZK/MsU4Ug1ZKUBwlQoWlBsUg
 N8laRa5eoBeT08pqd07oiowAdp2fCNJUWpgfhkEVI0QLKzTczAdn9vPOsJ/EaWuIK/jg
 Kygl9yGplV8FBtPha3WAFiWZyDJpeKv5YH3KDZfjNhiLbvIPKF0KH/jCMy4ycsdvnjbb
 g0a9XEnU63PHuUbCiRGrth/NaOdXiuJAvUfSI4WDgXfwe+s/FshYxAJ6JIiw9YjvsKt3
 JUF5cs314Uc3AXkQ1Ksrix1syvPRUWXnywMHzq+ShEHKlI9dAnArVgmHvRL4M19mFbQI
 5KXg==
X-Gm-Message-State: AOJu0Yx9Zkf4LFpsNdujjej+UUL2QWXKgbx2TckldrMPUirTOSLFCdey
 lyuVBBmQ1RcssnkSMTMlAioWhiUXs+YBHvOC+XrYumCz7/FNeZxn3POdp17NOPmpAO/xcC/hDxD
 0elAF2NGZNGTI913kHW4O2gXwR7A6CFO+UuJu+rEy3spicCaYfdmbA5p8/tsOsRjeJ7mOGwyBcO
 tN/YXtmuF9oqUGszvdQ3TfZl4ppdMIWY7Le/BJZSM=
X-Gm-Gg: ASbGncs9CDj35uLYQYuwx7KMisaya/nvPBakkxvq2PsZQdqaZJCfPKdZLN4uYtO3mis
 JSDz5rKVWZS1iUA/eQnDjUVm3bKhmSEXU0/tzetCVicsPNpROqPeqSwDcNg8YM98dDcptw/snee
 ICeqEdayLa5BnIxMm/WyJINw==
X-Received: by 2002:a05:622a:316:b0:4b0:883b:f024 with SMTP id
 d75a77b69052e-4b2aab00f23mr134620091cf.55.1756124283045; 
 Mon, 25 Aug 2025 05:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUFnfUAXa3s/a2gws6yKbLKfL1NbVUniCzI3GM5rNA7yG+/EsszHtFtYKhql14qmQBM95Rto4g5bAawLqgU1o=
X-Received: by 2002:a05:622a:316:b0:4b0:883b:f024 with SMTP id
 d75a77b69052e-4b2aab00f23mr134618401cf.55.1756124280830; Mon, 25 Aug 2025
 05:18:00 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Aug 2025 07:17:58 -0500
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Aug 2025 07:17:58 -0500
From: Andrea Bolognani <abologna@redhat.com>
MIME-Version: 1.0
Date: Mon, 25 Aug 2025 07:17:58 -0500
X-Gm-Features: Ac12FXwmdMd5dgshJLmY5NKbBugiGTODA3-OHG-jD9Ecm-YXyo7DHK3exthbrUM
Message-ID: <CABJz62PiQ9ipaJqr+X6AQvTJWZdAug5--4LOXa0i95DZkorNHw@mail.gmail.com>
Subject: PGP keysigning at KVM Forum 2025
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

last year in Brno, a handful of people had decent luck gathering PGP
signatures by performing impromptu verification during casual hallway
chats.

Of course that was only possible because both parties had come to the
conference prepared, specifically carrying with them printouts of
their key's information in addition to their government IDs.

I suggest that we encourage more of that at this year's conference.

If you are attending KVM Forum and are interested in strenghtening
the PGP web of trust, prepare little paper slips with your key's
details on them ahead of time and bring them to the conference; then,
while you're chatting with another attendee, ask whether they'd be
interested in exchanging signatures.

Please speak up if you think there's any reason to discourage this
practice or to avoid encouraging it.

Happy signing :)

-- 
Andrea Bolognani / Red Hat / Virtualization



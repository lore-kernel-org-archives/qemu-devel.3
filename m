Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCA8C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxY0l-00015B-U3; Thu, 18 Apr 2024 16:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshua.r.marshall.1991@gmail.com>)
 id 1rxY0Z-0000q8-8I
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:05:24 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshua.r.marshall.1991@gmail.com>)
 id 1rxY0X-0005sJ-Jb
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:05:22 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-343c7fae6e4so1110456f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713470719; x=1714075519; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/mzb4x9C96/d14zS50N+csAacKB4KAQSPY/9pNKvTGg=;
 b=PiOEf28HB+tDJojNjcBJKYjmK59/Q2px/KVe3nXLbZzSaNbY6F29nlG5X/BQ3rPFMM
 aT2ckn4xtVGXpz+MzTfOPNkSRDnjjbATNPWMMRGDUjz95g2Obhbg0QyxrbD/4tz2hi/Y
 K4b3t6dZ+Key0EFmmRXkkIYZYLweSuTmqjoCeAEVny3YYRddJMp9tO1Xjwi5vmsrGzeE
 Drq1nfwLKFJnXJQxPHh0DCs7WBXAEx2yBd7sQVYWiHhchyosrqRuCSjEfiC8qUxSnjCH
 HxI0HlxYpHYYfJoEjfRDVIcCO9qQAUwa7tDZWrrHbskc8l2rMG7sV0+3UT55HLnTQtZT
 S+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713470719; x=1714075519;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/mzb4x9C96/d14zS50N+csAacKB4KAQSPY/9pNKvTGg=;
 b=dQsJy47UbHYSLTLXaWLNEznmZURYB0VbO776jpUFYoW/OR+Fl8C/RK6Y6czvBkwq+l
 zbYuUC7r3ISoOfSePpNBSGOFGytPlcDuMAZq1XANiRrF55Hut65LbZY+rsW+3dn6ItaM
 iUCA4301INjs2wDXJTJVH0KJo05EIwsb+IB9kWls4lUmj/x3LnutcYKDSbHQ5kPMB5it
 IZMQowxDs3zdiWkiT6eoXbF37rvumUSURw8Vz4Ru/eHdvyuCUTTRJ9eDjWLPjjY1CyL7
 yhiVRHmhDdfQCIw38kRHctEAega546Oi/Q3yp6w0bE6Xcxxegask3dxIGSK49vXfjN79
 hKDQ==
X-Gm-Message-State: AOJu0Yyi/LpjDHcGY3LPtAL2j+2Mh3/f4m1Xyq/Cr6v2LeK5Lvte8CnG
 RnE3pUSFhB9Jat3yOtnZjIQbXWVoCgjU55YNhiJWRzot68UwyUcMbROTV6iNTalnAh1mZE9dG2t
 iKNVomUfs7ISAEwiPTNkCkpxXp2SRnecT
X-Google-Smtp-Source: AGHT+IHyL9s1yh96ZrT+gu2kICte2yD6aUG0UIi3x8kM6HIs2THiDoKpSSqH0OdT+dE+2WEqzDfeWoICSvkBukhzqbY=
X-Received: by 2002:a5d:5583:0:b0:346:f79c:3256 with SMTP id
 i3-20020a5d5583000000b00346f79c3256mr2269644wrv.7.1713470718915; Thu, 18 Apr
 2024 13:05:18 -0700 (PDT)
MIME-Version: 1.0
From: Josh Marshall <joshua.r.marshall.1991@gmail.com>
Date: Thu, 18 Apr 2024 16:05:07 -0400
Message-ID: <CAFkJGRfmMJC0u-TG_PeOKrXuhGpqFBQ_Gh_TLLM7c0ge9kuLZA@mail.gmail.com>
Subject: [RFC] linux-newbie thread on dev setup using Qemu
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=joshua.r.marshall.1991@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hello all,

I started a thread a thread at
https://lore.kernel.org/linux-newbie/CAFkJGRcg+ThJ-xUve0=WorChW=-6PreLHXeM8YwtwzwpkHTu8g@mail.gmail.com/T/#m563ab52dd2bfe7ac8d85f838f866a1a9d1a6d0a9
.  It is using Qemu, but both Linux and Qemu and rather complex pieces
of software.  I was wondering if someone could chime in and tell if
there would be any better ways to use Qemu in this situation or make
Linux and Qemu work better together since the kernel is being compiled
for such a specific situation.


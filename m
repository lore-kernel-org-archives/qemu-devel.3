Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A712CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3DfU-0005ib-41; Mon, 29 Sep 2025 09:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v3DfR-0005iG-Jj
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:11:49 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1v3Df9-0003M1-DC
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 09:11:49 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b556b3501easo3947189a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759151482; x=1759756282; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wKqIVcaOIwXOqs+v2o6f+SX+vQEEnDCOGNMzxwHOdRI=;
 b=O4SXTzoN18k7PLRvk7arDa/Ttdh64wkA18DvUv8sx3wT2A1DE27CNJgOYEfqJhRglR
 s4cbXypM03XXfVaRuv2VtW78jnXdiekSpk+xtIvpQvg4JbJ+0fHlz5eqaHnhMPw0ObQd
 0ZH9EF2tuPHwHdm6v+J+7zvuSuBKQOqXaBTcN8LMN6uK5eJ34mWiAbONZiRYhuO8Xp1g
 mz1Cfhxos8EOznnfun+Y8b/wPJZJ7NBAjsuoRSht1D2Gi7JiLjNl4laCMVcIki2w+WO4
 KY47Wt0WE20cDqBfVpEmIok/Q6miyuoU/bJ6N/rMeFVlhSDs1uJl6sZ9WS94Nkwm94IB
 tPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759151482; x=1759756282;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wKqIVcaOIwXOqs+v2o6f+SX+vQEEnDCOGNMzxwHOdRI=;
 b=SNHVL0qAcHfOq5yDllrQ7r+bfxYLgIyYlRMyWqf9Ipl/IKAusJY+s+cyO4ADKk5BVg
 AI/nRu4RqeuJ+LAWUa+Mhnl7jkmxubbhuBKW973ufWWtShJkYIbQ9DNRME1hNXeq+ZDJ
 nNAGvXWSb7HIrgGeMpIF+pbrSVcJUINXr7w73WN39VDcT+jbkj8c74KgE6MJ3397yazO
 XxR8Yr8CsJrywObVOv1ccPCe6JOvYV1e2EGDOEoSxOaexikoFyDOhR9UR91AsqjZ7RO/
 9yoPEpvAV6OW07k5j+A2TeTqJ2DeJ/GA/PtTjyTZc25635JbpeOiDyXoajr68oaqxbMQ
 xmFA==
X-Gm-Message-State: AOJu0YyvCveoyl2p4PZdZnbq3D8Eae0SzTATt0WSFXDUuLQmZ93jhF2W
 V26gJdFH6aCdcwLqe6PBwRY9Ef8JWLjST4q5tUCPqcrz90Tkp1a0hdN8a6xc9am64ZDMfhSNQj4
 VVVvzzZ7sSYT0rD8nqZq+Vl0qOGS41kp8b3ks
X-Gm-Gg: ASbGnctCS10Etv98URxbt8ZqL4pZmqOyWbCXI7m5LMsGsv1UKyM1XLgOqdqJRcRvADk
 5uK4uXT+LLSWQqVQE7j8oQ3CydcXtLsvLYRIt0tjWVFFB5sDI41/8dWkv9xcRWT/6ZSm+Uqi46A
 grxnGdnD53loH7OhlyLlFwcoOVsA4OQiULCwOhxIkushmXMevaVVc2PVawUiypSbrX1FJsOnvAo
 9VnDnAfcepgfyuliKz5fSiGF6FtWjMcqdKucw==
X-Google-Smtp-Source: AGHT+IF9f+4s6waqgs1lhBahRYCKOlXEQ0e1P15jiDhP+007WVX1R0i/yIBvxsh3FDxqAH7KBrtpTETXMBo62xSvZXM=
X-Received: by 2002:a17:902:d0c9:b0:24c:da3b:7376 with SMTP id
 d9443c01a7336-27ed49fb299mr132052155ad.26.1759151481673; Mon, 29 Sep 2025
 06:11:21 -0700 (PDT)
MIME-Version: 1.0
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Mon, 29 Sep 2025 22:11:09 +0900
X-Gm-Features: AS18NWCtHRwwMOy1koujLitD0o0XEzxE6TkkzOQeeCB-wu3W5ClCMGFDItE-5FI
Message-ID: <CAEDrbUb+MGXU6k7ZHL4ik-VK8hoS8KVQwmCe6cHNjHis-YySUg@mail.gmail.com>
Subject: Reqeust for a QEMU Wiki account
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002be081063ff05f52"
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000002be081063ff05f52
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm interested in contributing to the QEMU Wiki, especially topics related
to the Wasm host. Could I request an account with edit access for the Wiki?

Regards,
Kohei Tokunaga

--0000000000002be081063ff05f52
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Hi,<br><br>I&#39;m interested in contributing to the QEMU Wiki, especially topics related<br>to the Wasm host. Could I request an account with edit access for the Wiki?<br><br>Regards,<br>Kohei Tokunaga</div>

--0000000000002be081063ff05f52--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D51ACF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 11:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svEjP-0005Lr-Fu; Mon, 30 Sep 2024 07:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1svEjF-0005F3-8v
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1svEjD-0005WH-Ka
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727696280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JdRMYr8KF9EUHDcsR1vUd8aWcojqB4cWyzwQvYzjZVA=;
 b=dCYutw4wnPb0vPZyngjcBA/BfnZzQMD4DZbivnjwdYtHzjbeNuKz6A3Scb8mt8jwAYaA19
 xnqEw8Ip/HW9XXq8GyXkLhppVCd1qkA80mfKLM+0Fsw0FhzSWXCXTE2rt9s5Imj0OrtQ1P
 As+C0uyyVyx0Gp5m4tlRvS35OyWnnIg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-pUlbFl5mPaS83XthATHOww-1; Mon, 30 Sep 2024 07:36:25 -0400
X-MC-Unique: pUlbFl5mPaS83XthATHOww-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42ca8037d9aso28037175e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 04:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727696184; x=1728300984;
 h=user-agent:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JdRMYr8KF9EUHDcsR1vUd8aWcojqB4cWyzwQvYzjZVA=;
 b=DlW8XBPtWQOGXutwByEF6461gBD5cvbwAmE/lrzDGTACB48z+NXz0MJtNAiZ7kZaGy
 uRx83JEeQwW0Y4RWiCSJBmfEu8ZxtG0Stext/xYCpw6LXPRjEyGbcv6ZNIfNTAJCZZlt
 SsI4c28RA1SlFHCjzSxco1oLlUEXOu61jOxfc/ocOwPgKhmAIUHxnNtTpcq6EmZFBGYe
 e1DWhkKHX1x9CfndCzwf2L8FDuiGYGeJLvTkh+0rsPK9MhGh7JFuIKd4CFq8qiVDh9wK
 TvGJHN9P2fDQmlwAog1+bMXRgrt2EXYBGedlMCJ5+yFEHx6JLoouSsDim1AZTedqHNK0
 Oj5Q==
X-Gm-Message-State: AOJu0Yx26Fc3RTZMW68gGINZS3QdMes28f3Kibrybnve4nb3m5TldEBy
 ZLAlVUSPFttIRNhUWfKgKa9Yy/v8/CgSzJn1ns8j+9j1OlSB5qR24MfMhT5L2NLBPuixuGZOwjw
 p3WHlkhrDSyXrgD09xSMsopl06XMRczIcZ7xuAhCxCLp9CbaE+9tt/I3SNnwmgskTrzGZx9x102
 +DwNUtHD2JeMY2LP/+mJy9J0jzyIu0jKLY8dEr
X-Received: by 2002:a05:600c:1c26:b0:42b:892d:54c0 with SMTP id
 5b1f17b1804b1-42f58432f2dmr82322115e9.12.1727696184022; 
 Mon, 30 Sep 2024 04:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd5bgEYZ8tGcK3Az2DsDkZvWojQXXmUaLlIl+jySZCiT+hGPNqcrp0FT1RSlf1tiLMqi7SBQ==
X-Received: by 2002:a05:600c:1c26:b0:42b:892d:54c0 with SMTP id
 5b1f17b1804b1-42f58432f2dmr82321365e9.12.1727696182372; 
 Mon, 30 Sep 2024 04:36:22 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e645fsm8780329f8f.59.2024.09.30.04.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 04:36:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Sep 2024 13:36:21 +0200
Message-Id: <D4JL6KP1Z58Q.1P5U7QZQU7AKP@redhat.com>
Cc: <pbonzini@redhat.com>
Subject: Convert an error_report to tracepoint 
From: "Anthony Harivel" <aharivel@redhat.com>
To: <qemu-devel@nongnu.org>
User-Agent: aerc/0.18.2-67-g7f69618ac1fd
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,=20

There is an error_report() in target/i386/kvm/vmsr_energy.c that would=20
benefit for being a tracepoint because this is not actually an "error"=20
as per se, but more a notification that could be used for debugging, and=20
it is quite verbose.

Could someone give me some pointer on how I could manage that so I can=20
send a patch to rectify this ?

Thanks,
Anthony




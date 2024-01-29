Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C595DC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUY90-00026h-Q9; Mon, 29 Jan 2024 15:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUY8z-00026X-OS
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 15:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUY8x-0007su-Ud
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 15:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706559730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmFsBHzXC8KTVW4aHALRtdAHgLyU0UpYQb1wDjJe2YA=;
 b=Pl0oynB7Ybgs9TGL7UNNyo8DL7ml1MoRMWg2hLXql6zce58srQi5E/kli2IgaSXVx0WxkL
 JIJj9lZRkjNmQWvESqCfa2l4O/bO5en/yUkly6qAwLxXg9Nadv0mU4LDCnuKS5jnxn6LnT
 RLx5QGmIUT9akPl+PnrX57Awl4YLelI=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-OMw3Gom8OU6nbsCzxn8NmA-1; Mon, 29 Jan 2024 15:22:08 -0500
X-MC-Unique: OMw3Gom8OU6nbsCzxn8NmA-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7cce403dfc1so1220364241.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 12:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706559728; x=1707164528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmFsBHzXC8KTVW4aHALRtdAHgLyU0UpYQb1wDjJe2YA=;
 b=efFG1SH8vmjf3vV/gfP5I71cDxoynBvrAwxtY4OQeYxQvvEMw5HPE2+yvINSH1iuE8
 P4FM7gYa+D+2q95iRSzn2hF+rb1KHHPDSKhe9BXg+V/nCGipx5k0SKDN7FoU7f25VOnR
 jllKPBR4MawvohU4syvf6sf/y6n+bUHsDBUBizhcyItDGB7f4JEqDLuFQCz4x9Mo1P16
 r9CtNdj5Sp0qBH6YJCBSO+pMe6n3uh2+CBq3LbVvfRFzHKepy4pvPABF/xGY+/awMe93
 AVkwGArpUkp7YUriL3Gr707SKZBpTCgANdR0kpWsshEPauUTKLuOpzg7+kEP+ugJkY7a
 8rRQ==
X-Gm-Message-State: AOJu0YxvLB+tS7dXEHTSSByvmY6Eg62LAVEp4B03AcUNaf4kghg5WpGF
 pRGNkE2Comy0f0QwwwGmzbivZ5+r3CGBGKe5Pee/u5hgMe5lcBLv/Kqj14JojByuyc6jaHqTwgF
 ZM0LU1s42zyoNL+NzfpMHiAirNYgyfVl7F8sNUjKItjw2Hd5V0YYjcOMWfR/kXvfDbAi5fSblz7
 w3VM8vxD0ghy57xWetiWZ4XeFBbCs=
X-Received: by 2002:a67:fd8c:0:b0:46b:160d:564b with SMTP id
 k12-20020a67fd8c000000b0046b160d564bmr1855895vsq.28.1706559727947; 
 Mon, 29 Jan 2024 12:22:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaJ/Uueg995AvmK0+J9ySLXqSPVFVUZ2GFiST7jWY2mzErx+SSdH2m3cfCWSEErMldX9lKteEmsOjD1nTAzY4=
X-Received: by 2002:a67:fd8c:0:b0:46b:160d:564b with SMTP id
 k12-20020a67fd8c000000b0046b160d564bmr1855886vsq.28.1706559727685; Mon, 29
 Jan 2024 12:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-3-aharivel@redhat.com>
 <Zbf0Fbhmg0tvMbxK@redhat.com>
 <CABgObfaRGL8eOs6NRBjEMjTa_7UGyAn+Pic2GP=XbE+Qg-oBCQ@mail.gmail.com>
 <ZbgAb3m6-rwUFxOO@redhat.com> <ZbgCUpVTYg9VU4b-@redhat.com>
In-Reply-To: <ZbgCUpVTYg9VU4b-@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Jan 2024 21:21:55 +0100
Message-ID: <CABgObfa0YS3WteeCo1GSmORg6zbKJzPMk4h7vmOBdfrCV_=tHg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] tools: build qemu-vmsr-helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, mtosatti@redhat.com,
 qemu-devel@nongnu.org, vchundur@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 29, 2024 at 8:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> Looking again, the TID is never used after being checked. QEMU sends
> the TID, but the helper never does anything with this information
> except to check the TID belongs the PID.  Why are we sending the TID ?

Doh! sched_getaffinity's first argument should be the tid. (As an
aside, sched_getaffinity does not need CAP_SYS_NICE to read the
affinity of another user's thread).

Paolo



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6D8C36002
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 02:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1bwK-0005ap-9v; Sun, 06 Apr 2025 22:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u1bwI-0005aI-DP
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 22:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u1bwD-00079m-Hs
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 22:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743991812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVuajaTbrz0lsY2sjqYprYPtWsMQHd946UcPkbQTmT0=;
 b=PmlUXsqP9tjvNuj5JG+PjRdRvqL9V/mGqWlf8icYX+Ly8vUjLt+feqNndsH4a/+ipnqE1D
 uRWFjZO/9/HiheN75474TTxVf7hpXUoXspbrq7hgpo8c4InAKCnl/+XvqAkELOSPF8Xzqu
 BC1Vs+GWInb98h7Qg6adhTgtZ0p3OSo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-sM84u-GoPNeRYCZ3xRc0kQ-1; Sun, 06 Apr 2025 22:10:10 -0400
X-MC-Unique: sM84u-GoPNeRYCZ3xRc0kQ-1
X-Mimecast-MFC-AGG-ID: sM84u-GoPNeRYCZ3xRc0kQ_1743991810
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff8a2c7912so3042523a91.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 19:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743991809; x=1744596609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVuajaTbrz0lsY2sjqYprYPtWsMQHd946UcPkbQTmT0=;
 b=wZ8YO/u9xbSokPXjaN5iSiWm38hJC3qoVBp233KViPik2ZZ9MOMWuOjvVhZaiHqFX/
 mDV2A8SBLlBozc4val5Ofhp2q7n/yJamwegya3Urn8S8SmCWSeDL7O3YP3DCh4oSVDB6
 FNtVejalxBkafPng7tRMMlH8Wbz1Z/xDcaL5MQnI4kCDbDvUQAUZ10W1seSz+iEPnStG
 n0Cum+qFGFdcvl8pCO/b02yBSBFnWs8quTCxG/Aw0Qf0nwrZdz+txN3OWQk0n3IOuATW
 HEBlUC3DpYdMlPWehxhh1fGB/Xd4oFgLRhuwNC3zrB3RAW+RL9fhYz/jf0B1oNyn4bzM
 33HQ==
X-Gm-Message-State: AOJu0YwW9Bm9ZtFBIySG8UyCptQs0d5EZFhIVETbHQ1UcwClRxRlhTLN
 hChgP4QMspkkJ/LdkrR5eOy1M0JX9kVJE2Ku7CLzSXja0aXHVhfJn74WcTzUwQuj5f3KsTSawA6
 Zf0RkvcJ/yRD7Ab+ZHescNcDX9HLOZK9utz8CxZozeBJ8NbfqW6jHBcBFdARbrjG4H025eO2sHq
 zzaIeol2Ssf+2V6qFzU5dM8zwqyq8j+P/Tg5ts1/Yg
X-Gm-Gg: ASbGncuCe/cmsHkTXB6+kwL6M6RaIJWb1BP0YAHpfc1aJBlns7CCxfI+C57jak0jTUW
 bYr/iE3ByZ70ynavMUR1D8HezMfC9jJtj1bNckJbvPaa+Br1OZOKgJPiG9/DAqsPSe/bARA==
X-Received: by 2002:a17:90b:2dcc:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-306a4e76fb7mr16939987a91.8.1743991808340; 
 Sun, 06 Apr 2025 19:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6J8OQpFNNkx46PafBTAArHRe+mN5TQW9tFBzHfKxbdCvpCBGhKgJQmLtvUWDxhMyGSZEFpLIkqStdpTq9gqg=
X-Received: by 2002:a17:90b:2dcc:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-306a4e76fb7mr16939956a91.8.1743991807919; Sun, 06 Apr 2025
 19:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250404151835.328368-1-adamhet@scaleway.com>
In-Reply-To: <20250404151835.328368-1-adamhet@scaleway.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Apr 2025 10:09:56 +0800
X-Gm-Features: ATxdqUE7zYXi4JZsh8A3syiQG92rFlGKNmP7z8UMBxtpWR70x5sf0wzJRZiBLsk
Message-ID: <CACGkMEun5HXgcXia8Bur3WVZtU3-KHUiO_X1FuwSDBb=fbjiHQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "virtio-net: Copy received header to buffer"
To: Antoine Damhet <adamhet@scaleway.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Apr 4, 2025 at 11:19=E2=80=AFPM Antoine Damhet <adamhet@scaleway.co=
m> wrote:
>
> This reverts commit 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce.
>
> The goal was to remove the need to patch the (const) input buffer
> with a recomputed UDP checksum by copying headers to a RW region and
> inject the checksum there. The patch computed the checksum only from the
> header fields (missing the rest of the payload) producing an invalid one
> and making guests fail to acquire a DHCP lease.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



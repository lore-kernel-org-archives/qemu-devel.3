Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59569C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 01:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru0ZT-0003iK-TN; Mon, 08 Apr 2024 21:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ru0ZS-0003i9-J8
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 21:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ru0ZR-0002zW-02
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 21:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712627203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBGljJWvGfiJmcv1NYxhnpKObL+8iQ9pK0qHfslD7EQ=;
 b=ebr6UqcYP4z+4eaDDRrlZRm0+mQzAkgUbxq08xpOEM3vQ+5moTMVuO2UkekU6slhu4Nbfd
 7y8OBe3EzrwyThBv7RPzpiXTupIyORBF1iGvMJ9dfhFMIFtXYwhrPlo55mn1QL/WTFNypV
 KY4sl4OqkOymCnEatfd4UbDOTfEjWJI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-aOhyIZ3YPcKpj3j_bb3z3w-1; Mon, 08 Apr 2024 21:46:42 -0400
X-MC-Unique: aOhyIZ3YPcKpj3j_bb3z3w-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1e46bce2455so7175765ad.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 18:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712627201; x=1713232001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBGljJWvGfiJmcv1NYxhnpKObL+8iQ9pK0qHfslD7EQ=;
 b=EeeMND/m/akiU0k3TeZmIIypQ/FdEe0sJTy9hWTIrVSPrPfisEgx93dqcBRUlv5iM1
 37iwVocQjK4StwUyc6fVL6z8zEsqcCRuUorPNr/r1piWxM1LRY6KxaePV5IcryL0J5X7
 totatHDDzZ5zUm7nMSYtMz/c1/hPRZOoVMNa5wweu2XV6aCYeC4RTPVyysVQzBkvp7tQ
 9tE3US9oaMyYEKlCgEKQViADDsocI/xGvGszZ5IXG0ewHAD6/AB3EYbNrnGs+gfWtPVk
 0gcJWVFGbZ25JGOdkNMfnhrthCg671HCOAAmpUCOF8L9fEt6J5AI0EThuQ6q2jO9tmPy
 PQpA==
X-Gm-Message-State: AOJu0YwBrVcJGJ8MQnPYRl/2on/LnbXCubvqlvaXoH7hmAli5vsIE5LT
 vKhS5ENrjbOInzYYf4i2hswrJQRdqYW8gx7Y/A0iGzvV+8uxotP9VnM73f8ZON7zgaUXhi1BMwW
 xOpH+inUdC1oG0fjABIT4Hfsgz6z6MY6kI/uApKHnFqSXL2n2TiPTr0ZPubURr8kwjwRHIT2Z0u
 r9MGSMJrI5IOYU3rfEf5i+4Ml/rNs=
X-Received: by 2002:a17:902:b94a:b0:1e3:e1e8:bb5 with SMTP id
 h10-20020a170902b94a00b001e3e1e80bb5mr5106531pls.28.1712627201069; 
 Mon, 08 Apr 2024 18:46:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD56UXXUnZpYw//q8EwhTMtJSZUiv9hxxVm/HzZmPsM1GDR5R3DsGPYIwePmuJrCMdqMZNKBB3Q0vrlUCnyqg=
X-Received: by 2002:a17:902:b94a:b0:1e3:e1e8:bb5 with SMTP id
 h10-20020a170902b94a00b001e3e1e80bb5mr5106523pls.28.1712627200777; Mon, 08
 Apr 2024 18:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <df6b6b465753e754a19459e8cd61416548f89a42.1712569644.git.mst@redhat.com>
In-Reply-To: <df6b6b465753e754a19459e8cd61416548f89a42.1712569644.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Apr 2024 09:46:29 +0800
Message-ID: <CACGkMEtGcn25MT73xczHtXzcYDZwFO1W1TEqcM-gsFEy81Htbg@mail.gmail.com>
Subject: Re: [PATCH] Revert "hw/virtio: Add support for VDPA network
 simulation devices"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 8, 2024 at 5:47=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> This reverts commit cd341fd1ffded978b2aa0b5309b00be7c42e347c.
>
> The patch adds non-upstream code in
> include/standard-headers/linux/virtio_pci.h
> which would make maintainance harder.
>
> Revert for now.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



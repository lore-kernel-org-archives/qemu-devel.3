Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1179C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEA8G-00058m-Ey; Mon, 03 Jun 2024 12:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEA8A-0004zd-6l
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEA86-0007Yp-UA
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717430508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TKkVZTxzls9uJK95gb97w0xocQQsfZfvM7Sxhp61SAU=;
 b=TP5Ej7N/HxvAQOfdaWSLQ/Y85XjlSi4GA8K91NirxpuKVzFBH2HWBGoZvcAiTHAqKdNVcn
 +RwgkFkbclNjG7hboPDEmQ9GQQ0zcHJC4EltzDOffKsaYJJbnS7eKMyAAXJRhNTIm/02BG
 zAG/Hvo9WdltyLs8n4X3KilVHQ2fO5U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-TNnM_2e4NmSapIM2FkWmXw-1; Mon, 03 Jun 2024 12:01:47 -0400
X-MC-Unique: TNnM_2e4NmSapIM2FkWmXw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52b91217fcfso14438e87.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 09:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717430505; x=1718035305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKkVZTxzls9uJK95gb97w0xocQQsfZfvM7Sxhp61SAU=;
 b=D1tlKOLVO8YHLmULrqwEexJEBAgjop3vTeLXgRkXgnkjwrc6gD+qI+Uxq2oJOHobvS
 CRz+wow2GhhjYSHmeB+RiBXFGFUk3R5ObIgLWIdj7xq6Eis5dmwDNd5dPswbDMJPbVQZ
 3+bG+RB6O5DLVB94gG72ENBXVbQkVwaqLNyts6UgH+32kRudCH2avxqpL6vUIj60nLEp
 skXnJ0u95GboXEo9GiveAjRNAF+9nhbxeCGENx2kq+Mi1xgFmwOLVwWE1JRdTPdgeV9Q
 pz/75yVN2QZme8SYXRaaFHVcd5EA0l1k+OyZKhry+uFdNDqVqf1yEh+Ofh3e4HL/MafS
 ywEQ==
X-Gm-Message-State: AOJu0YwZk245clotjlu3MHYpm4T1rtyppVCmskTwZtxKNVQmFZe+tC00
 OOeeTAU8wY4EX0XH8pnhpBEutLjGCJWABQO2WJkaP7KjEiVnrYKG78zz/Rb50HR05e36kxhCVfM
 OlrSuo+XGxL6pO0sRAvTKQIYZaXfW0Nrt+JtDgEs9Z6nzUQ5qGJAejj/BRMRe7G8IaZNhApPmgq
 VVo3i0T0DcqJKCwN2daPww3XyHxuQ=
X-Received: by 2002:a2e:a7ce:0:b0:2ea:b908:d840 with SMTP id
 38308e7fff4ca-2eab908d9e2mr10877311fa.29.1717430505555; 
 Mon, 03 Jun 2024 09:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1VzgKQysQjyCOrzlLwTl8QPEkYAcdIEUjLe1tdcg110zLYWnMXHvJeeD/mervQNP29mRGLyW7f+gvQBAPj4E=
X-Received: by 2002:a2e:a7ce:0:b0:2ea:b908:d840 with SMTP id
 38308e7fff4ca-2eab908d9e2mr10877071fa.29.1717430505139; Mon, 03 Jun 2024
 09:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240603131141.834241-1-pbonzini@redhat.com>
 <20240603131141.834241-4-pbonzini@redhat.com>
 <874jaam30g.fsf@redhat.com>
In-Reply-To: <874jaam30g.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Jun 2024 18:01:33 +0200
Message-ID: <CABgObfaROVKsGD1sLk=ry4PSRzBbEHe9GZzew7F6Pqf6QLBDwQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] linux-headers: Update to current kvm/next
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, 
 Pankaj Gupta <pankaj.gupta@amd.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jun 3, 2024 at 5:58=E2=80=AFPM Cornelia Huck <cohuck@redhat.com> wr=
ote:
> Hm, I'm not sure updating to kvm/next is a good idea ("current kvm/next"
> does not mean anything without a commit hash anyway.) I think we should
> only update to something that's in Linus' tree already... how stable is
> kvm/next?

It is stable, things are only applied there once UAPI is set. Even
rebasing is very rare.

The problem here is that if (as is the case for 6.11) the merge window
only opens once QEMU is in freeze, waiting for it would delay merging
the QEMU side by 4 months. In this case, the patches barely missed
6.10.

Paolo



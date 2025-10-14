Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B78ACCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 04:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Whn-0000Ys-Sk; Tue, 14 Oct 2025 00:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1v8Whl-0000YU-Gg
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1v8Whi-0007l0-NG
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760416323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7I0H3lV1EDYWRQx8k6s1s3HFk/i0C1brNu+ZGYobk8=;
 b=DOd7Iu7I9N/XFrkuDjntey0KHr3AvrupR3uzcleviISJS+bshgr9Y89BkCL5eC80OcOss4
 3vxHQNL9R2P3LGrQUo59fK1dE1yUlS7Pukj9UZOPGp/wb72eM24I9HCT6ItvCRty7hGFUc
 XbwYlxlsrEaiG6D/sPE8NRtNwDMcUZI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-d4WFpUcoNoC0eE1vhAjLSQ-1; Tue, 14 Oct 2025 00:32:01 -0400
X-MC-Unique: d4WFpUcoNoC0eE1vhAjLSQ-1
X-Mimecast-MFC-AGG-ID: d4WFpUcoNoC0eE1vhAjLSQ_1760416320
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3352a336ee1so18786472a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 21:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760416320; x=1761021120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X7I0H3lV1EDYWRQx8k6s1s3HFk/i0C1brNu+ZGYobk8=;
 b=vFSe+ksffY3J+YYZ3O8KNUgTSL900T3Y47SZ/7NlN246fvLwuHM44dBV45wPO5VpK6
 UW1+bxPFA9bn81UZXmmCFZDd06zyLeQwtjS45E3unuDklamqgVBaHIF9XfIYBceke4Rp
 NtNV4eu87NgPbjx0VsnLja6Qdq81xQiBAibD7k4cQNg/9BuA9idtT5hoa7zr57I5Fry/
 cv/n7JpmmT8UAq1rE8TcF4nxKaI6xDHyTED7h4dpxluOuMVugvezqu/btFnOaQPrBhmh
 cFYYaBIvfVwuOVftJ+vbOGc9cj5+Sn8qPiT0gKBSG3NGbenQh9V0O026d4f6MO2s1cee
 ZIWA==
X-Gm-Message-State: AOJu0YxPY6Q5bQNgAHgHs6JnfFp6fMqqB+K/f9M4egEyQ8Jpb2zSTk0g
 1vineGpMuwq1QnFgA0AFr84nir/8e40Zpv6H9Bpfj1/gpusnEhCWBs0QzUiiET9PDqNGFBF2Q2k
 gF81omKS7UZ/7I/br18Nxl/FB6qgtTCYX6O6Va7TRHCfUZqymDNeKQKBtFNi1YellowSQutlIcC
 n57yXDxAB4J9PECLfjtJ2w3msKpx3olHc=
X-Gm-Gg: ASbGncu6vOuCnjyjCTlOgzl4eAzBoWL6UuUe731giuDYD4g1bCoa0SoxNdbtU/FGMKY
 FuF4NpnwBh+UXAVg40wFrqWCam77mci0qgLIt/pRkaGdHxNszccBK+9ZXmXlMR7g48sh2IDU+s4
 p0ZTfEC4+KgwH9VuKMiEM+4Q==
X-Received: by 2002:a17:90b:4b87:b0:339:a4ef:c8b4 with SMTP id
 98e67ed59e1d1-33b513861d8mr31274864a91.28.1760416320149; 
 Mon, 13 Oct 2025 21:32:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMG/UtjDk6mXPRoWtIuKGqLk/VAF2D/rxgW26Zbb2ZCodh58DDL559Aowf484HM5qTw8p76W2tTK3ipgX28YE=
X-Received: by 2002:a17:90b:4b87:b0:339:a4ef:c8b4 with SMTP id
 98e67ed59e1d1-33b513861d8mr31274836a91.28.1760416319710; Mon, 13 Oct 2025
 21:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250924-fix-win32-multiple-taps-v3-0-9335df866c14@gmail.com>
 <20250924-fix-win32-multiple-taps-v3-1-9335df866c14@gmail.com>
In-Reply-To: <20250924-fix-win32-multiple-taps-v3-1-9335df866c14@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Oct 2025 12:31:47 +0800
X-Gm-Features: AS18NWDo1l-fMoomA8g7sUw31IHIVdTZ8xK6wMJH70xP5rL4I_61B-bw9zUjy6c
Message-ID: <CACGkMEvqKTYxAZAxJfjOJDStbvFUh-pU3QTzFRaKeO4VaWXyNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tap-win32: cleanup leaked handles on tap close
To: Gal Horowitz <galush.horowitz@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 24, 2025 at 10:50=E2=80=AFPM Gal Horowitz <galush.horowitz@gmai=
l.com> wrote:
>
> Signed-off-by: Gal Horowitz <galush.horowitz@gmail.com>
> ---

Please add a commit log for this and next patch. E.g what is being
fixed and why.

Thanks



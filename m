Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A192C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 17:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuE8o-0003xc-Vz; Mon, 17 Mar 2025 13:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuE8m-0003vE-HN
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuE8f-0000hJ-PY
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 13:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742232030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pAkgqrelAe4YIX3NAm9ZTxDn/cN/Kq4AFcPnu3EncxM=;
 b=Kfxs26maWG3Jonz+LpSZY+kwcScpyG66EOmJotIxPqhgWH/GUUx09f+sxwsgZRhUxROQ6Y
 BgwrzUxlNFqQiQYyxliWr48Kowh6PSqZfEczrCicq92OCbzCR/R2WVQVQUwofyuqxpXluw
 7/su5h7aMoXb/AXGX7uYBsYBibO9Efw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-9Znu15tdMr6_y6WuA3sVZg-1; Mon, 17 Mar 2025 13:20:29 -0400
X-MC-Unique: 9Znu15tdMr6_y6WuA3sVZg-1
X-Mimecast-MFC-AGG-ID: 9Znu15tdMr6_y6WuA3sVZg_1742232028
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so17859665e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 10:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742232028; x=1742836828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pAkgqrelAe4YIX3NAm9ZTxDn/cN/Kq4AFcPnu3EncxM=;
 b=IRIr5BTUmYOV+VcdNrXVGsWYdRno91hNsV160q0ZcpFRMQZdphvUYDRAcRJ8usRiSM
 UXEr3W1DxG/zm/hEQcID1qXOlwY8VmgLv8Xp+elsUE3SJq8r6dtFkKp8NfTbI0Hp19jf
 t/prBYIDolEzPoBOAS9IYyL4U7r3PzG7rW15Lu4H8YztYkGVcpPR8U9iSmrW3huBovlI
 wLmPG+Tcoj1Y5ee37G4cob0HvjjigYWO6xSNjgYlWSgWsd+esVE9sPaqsOAckVnv1X90
 baWsV4Uu9wFPbupMmarDLfBX7AgRKiGAZqhjt3D4n4CeQe+gdW/RGTnsYSt9yuV1T1th
 wjGA==
X-Gm-Message-State: AOJu0YxugknCWgl0HkP/q3GaC2xaUVHBEfgwGC7kyp/InQC6K7OCUPHb
 HvPU8UIGI58ug7bXkgVKIUSgWu3dV7WFeDa2mIsbgYNUDBMOnfr944I1Lstl7v4OrUXZUIC4/eF
 GZ+rHg6dxngA0qsps9NqnwgyIAYZZbMvFQWGytZx1zy2KBdNrPd3t2o1z6nG5B2DORc4PkMcf7x
 hw84kys6O/Zh3nup4c0kd+p2nvCdU=
X-Gm-Gg: ASbGncvNdFw4PySvn0yNM5JDNdBsLxUrrK/Qpts/dHE0ZVMAxCrZFRpkY9/NL44KfeB
 iQP/iz9vmv3Ra8fJRYOdD0+6SpwnXIfEFL/3ujuCz58/vCIuTq70RUlxbbyKuh8hCqnuOsCagqw
 ==
X-Received: by 2002:a5d:5983:0:b0:391:231b:8e0d with SMTP id
 ffacd0b85a97d-3996b499f9amr539219f8f.39.1742232028109; 
 Mon, 17 Mar 2025 10:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe7gKAVPP61hBKnKNkDAes+rayUO1PttJbPDctjksYGid1q7NzLltpkrtGr05bU3OzvI4czoK525pnoo9svmo=
X-Received: by 2002:a5d:5983:0:b0:391:231b:8e0d with SMTP id
 ffacd0b85a97d-3996b499f9amr539195f8f.39.1742232027793; Mon, 17 Mar 2025
 10:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250317151236.536673-1-zhao1.liu@intel.com>
In-Reply-To: <20250317151236.536673-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Mar 2025 18:20:15 +0100
X-Gm-Features: AQ5f1JpXue-MvO9yOQMLIGNJiq_Ly6h2D9fE93JjCgkuem8P4bzX9thSk8Wkpr0
Message-ID: <CABgObfZaGU9C47BemJQubhmwaOiDDPaWVBC=ebAxGvU_NiRU-w@mail.gmail.com>
Subject: Re: [PATCH 00/17] rust/vmstate: Clean up, fix, enhance & test
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 17, 2025 at 3:52=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> Hi,
>
> This series is in preparation for HPET migration support (in particular,
> to support varray and vmstate_validate), and it also cleans up and fixes
> the current vmstate! However, there is still the gap from being a =E2=80=
=98stable=E2=80=99
> vmstate.

Already a great improvement!

I quickly went through things that I was planning to do in a slightly
different way, but overall this is great work.  Give me a day or two
to finish reviewing and testing, most of it can already be applied to
qemu-rust or even to 10.0.

Thanks,

Paolo



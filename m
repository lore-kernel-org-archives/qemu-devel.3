Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAE0C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 01:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFkK2-0003bd-C5; Thu, 15 May 2025 21:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkJr-0003Xn-Q0
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkJq-0004qk-E7
 for qemu-devel@nongnu.org; Thu, 15 May 2025 21:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747360621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFN6EbzLznI5r0ul8FQYTlfcPrdUZ4e/Nv2w5yNt94c=;
 b=VSpOqUtZmIW4Np22wvV03IcMASH5PppRq8+ayW0H8odKCUTTdvd+CAgwDfvVnS2xnnHyPM
 dy5O4ixgi0uDsQraCttg7rtAy+4uKwG28Ys7cM07z3u7vZxqvac7MagGfusGfefw7FCF9i
 hfmSD7BqASBgYBrw+1ApD3ldBG3TspI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-MNap-KpeOSajw61PbTzqJw-1; Thu, 15 May 2025 21:56:57 -0400
X-MC-Unique: MNap-KpeOSajw61PbTzqJw-1
X-Mimecast-MFC-AGG-ID: MNap-KpeOSajw61PbTzqJw_1747360615
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30ad1e374e2so1709279a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 18:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747360615; x=1747965415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFN6EbzLznI5r0ul8FQYTlfcPrdUZ4e/Nv2w5yNt94c=;
 b=tBR5qG1UDkDremB6giQL61D18W9wqcNHYmoBk/DwvCsLHl06JOYlFbxlofuANQxjOU
 WKF1z14d7vxPwtpJULPU8LllbJ7c5GRdEfByZI8dS68dWcaDZvgmR8zc7t+kI9OEEiEz
 5G1aaotsThS/wbZBPpQkl1/TCy9pyjIi0HKC4sc8ehS5anJz9Skbx/YHeinL+fM7RoAr
 j9XUEoY610/guyXiVy5j1i9izxnYesa3SUtXo2L3H6PXL2fVcXDC8lBOwzVnlVkmnQJo
 J4O+fFxSkO/2SqTmRopPIFNoyymStZdAXTY0RyrH/LsRCaZKdzTtpL/iI+HNNhRrFLgb
 7gCA==
X-Gm-Message-State: AOJu0YxojfBDql4OfA9erqJrHIsc7gle6xgfXzEm0fauoVXYVrLLTWlK
 k5tUuDg+P6EtesrB9VSMb5594CJbha8Wn0ZaicP1EzCr9amh8v5ZQZpGItboOG6Jv3PiD8zruIk
 Ii/Ki0t2wG5ewvb7qFpvIiDoHAQhnYMxGVBaohKWK+KKYqzeLOA8J3NOd4jeolNwKpNXe3ZeK8k
 tKcw7htj0ZLF2HZhwZvMPFFXkAffUUubA=
X-Gm-Gg: ASbGncu/z+bZoCXsdrByaYHoBSqL87MVPUhBz0cDUcHY5d9G0CSL1n0mGpqbkzPzapc
 x+9I5IbMMQsSArcF+lkyJN/PryV6bPrlSLqPW+iFJn8Kmz4nQXKdL++k5O258oLyhhNH5Ug==
X-Received: by 2002:a17:90a:ec8c:b0:30c:540b:9ac with SMTP id
 98e67ed59e1d1-30e830ebd3fmr1090191a91.10.1747360615311; 
 Thu, 15 May 2025 18:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTPG7E2OPvSieCpW4Sk7bItOPml4eVBtYR3+K05P3/7d0YFapSy589pX3lnEhpjLl3NHZ0VWMwlwjTCS14AAM=
X-Received: by 2002:a17:90a:ec8c:b0:30c:540b:9ac with SMTP id
 98e67ed59e1d1-30e830ebd3fmr1090166a91.10.1747360614924; Thu, 15 May 2025
 18:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <20250507184647.15580-3-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-3-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 09:56:43 +0800
X-Gm-Features: AX0GCFttWKaVWradk5KgA_KvyVbOMl6XH-4iFJkCVRWSq6KV0q8tclOziou0B98
Message-ID: <CACGkMEtTA16q5YMxXngjBLxN67pupxBW2OSxePbr8ps1yojxvw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] vdpa: reorder vhost_vdpa_set_backend_cap
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com, 
 mst@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com, 
 parav@mellanox.com, sgarzare@redhat.com, si-wei.liu@oracle.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 8, 2025 at 2:48=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> From: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> It will be used directly by vhost_vdpa_init.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



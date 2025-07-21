Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6FDC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udx4X-00028F-E5; Mon, 21 Jul 2025 16:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udx4Q-0001zM-QM
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1udx4N-0003D6-EY
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 16:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753129505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psj6dX1PbrjNIzs2kSnJUiGaWUhvYhSymboxI7TUWB8=;
 b=JmqYXDAfJLRi7/dWuLQiZW3+wSPESniNs0bR7LLNy8o3Iw+jB2AGDiYyfFDUMfPzQO6Vv7
 ziYzqy968IrndLPtmD83KCiLF7oLBVmtczFZR6pQq+GtSyjjRPeb+HQnvuHWMPA6LGXCBe
 VCt3JW0QNv5SKAnbgqeHjTNQAI0hx/A=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-qLWtUCpBOIC2qUslcicvVw-1; Mon, 21 Jul 2025 16:25:03 -0400
X-MC-Unique: qLWtUCpBOIC2qUslcicvVw-1
X-Mimecast-MFC-AGG-ID: qLWtUCpBOIC2qUslcicvVw_1753129503
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b38ec062983so3181243a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 13:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753129503; x=1753734303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psj6dX1PbrjNIzs2kSnJUiGaWUhvYhSymboxI7TUWB8=;
 b=KHxdy4M6pIZMYQRN6VLSWqGMr/WjNC8OtE/qssrlYETRQfajEos17PZywt6YhAfnLX
 iCmndbF4PYtWqEaBcoQtswDr9WYH8YHzeO4tgv9L8nX+GDNCXuw9+pj+te5PrFiGsgRa
 JopJniBdRCaq0azSYPBBDvib2axlYMRxvMRGRCuufXgC9CS0ZkQD/wF3wpqrsBaFEkKo
 t5D28HCdQpemUdlh4s3RRsC0xgHXzuPjkvjQBFzoUJ4fPj8ya8b+fOCtnRsXkBmeAAvW
 QDvpg9IVSegdPHERHOzAHDtxod5qyeH35bpobJH1G0PcVzbhjhwjaRIpi9xgu3HcAuVt
 B/wA==
X-Gm-Message-State: AOJu0YwHjKPVHwBLb4MCSgm7fX4rWQb4klobhqYlHLzxRyIeaDmHCuxX
 TQ/2YyHUkEzPl1MNDJy6e+pqJKxJibLR6j1ac+Hk1SREwb5rsHnXz3lGbSipL/q3YkOsdIjumbu
 RdCV2xNenJ4Uqskd/LqapS4XPuC2jMrvIkQ5lyWOPEG1fiAmN6JlzcUpUnoo9nqZg/525WL6hVf
 JE379Tp28hezNMw+8yrTP+Ey0nmO8ugQc=
X-Gm-Gg: ASbGncsciMQQhhNTYms3F/v3NqWLnF+jugq8OtXEplo7zoDW6jTnbQ1JQsPhMGwpd5j
 l1zWoM4M97RiK4fPCACZqDzHkciL+moHLwI5DTwsytc7EWkJ4ipBFTT76GuifoP7d3cEXMwdwEg
 25xLkmFs6eS/pmq0MJ6YsyBKdngklJogJzC5RL4nO/1ttrrvSbbqcv
X-Received: by 2002:a17:90b:38d0:b0:311:a314:c2dc with SMTP id
 98e67ed59e1d1-31cc25447bamr21949849a91.14.1753129502705; 
 Mon, 21 Jul 2025 13:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiN/y5I+DgPxvg861Nx+6jrxwXheU1O/Hf/fWelt9RsOCTgG62VkaTSYGP7TiriyNNzHfw3hbfnrpCaFinR5I=
X-Received: by 2002:a17:90b:38d0:b0:311:a314:c2dc with SMTP id
 98e67ed59e1d1-31cc25447bamr21949823a91.14.1753129502332; Mon, 21 Jul 2025
 13:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250717115246.3830007-1-armbru@redhat.com>
 <20250717115246.3830007-2-armbru@redhat.com>
In-Reply-To: <20250717115246.3830007-2-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 21 Jul 2025 16:24:48 -0400
X-Gm-Features: Ac12FXx0jjo70MlXuCHHMX3TLgiGXVaKmmtxanbCp2OtF87tx_3QlT-L4y-ht94
Message-ID: <CAFn=p-Zqz3hmNbt+TNzjDStjUueheCgMj=L8E3R_XGeHGSP32w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] qga: Fix guest-network-get-route return value
 documentation
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, michael.roth@amd.com, 
 kkostiuk@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 17, 2025 at 7:52=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Tagged sections are only recognized at the beginning of a paragraph.
> guest-network-get-route's Returns: isn't, and therefore gets rendered
> as ordinary text within its paragraph:
>
>     Retrieve information about route of network. Returns: List of route
>     info of guest.
>
> Since there is no (recognized) Returns: section, the doc generator
> adds
>
>     Return:
>        [GuestNetworkRoute]
>
> Note: only since recent commit 636c96cd77d (qapi: Fix undocumented
> return values by generating something).
>
> Insert the required blank line so that Returns: is recognized.
> Result:
>
>     Retrieve information about route of network.
>
>     Return:
>        [GuestNetworkRoute] -- List of route info of guest.
>
> Fixes: commit 8e326d36dd16 (qga/linux: Add new api 'guest-network-get-rou=
te')
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  qga/qapi-schema.json | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 6d770f7b8e..a569a14b55 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1966,6 +1966,7 @@
>  # @guest-network-get-route:
>  #
>  # Retrieve information about route of network.
> +#
>  # Returns: List of route info of guest.
>  #
>  # Since: 9.1
> --
> 2.49.0
>



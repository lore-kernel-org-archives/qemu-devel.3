Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04B3E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 01:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUyXv-0001A6-Uk; Mon, 06 Jan 2025 20:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tUyXs-00019V-9q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 20:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tUyXq-0003DE-BL
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 20:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736213889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HBUfeUW6/GEDOvf/9UKNi0N2F9Yek+Arua+HJkBvO8=;
 b=INCgs216zOR3V2mksaq/JWW91wc1qwz4kWrp7yu2W4eDXfBqKCmEbz+2Ruvvug8BxMoCvd
 rUBFFvsHrFclV/MSdQe1u4TbSN7saJxM+doPlj2L7FP6EVCwlLc43wkMOTgAS3AS6m5q3i
 mfvC4qzVjrABfzIa8Pxo+I9wGlbDYXg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-8agsM_aaORiq7oGnZ_Q6Tw-1; Mon, 06 Jan 2025 20:38:07 -0500
X-MC-Unique: 8agsM_aaORiq7oGnZ_Q6Tw-1
X-Mimecast-MFC-AGG-ID: 8agsM_aaORiq7oGnZ_Q6Tw
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d0b5036394so6519652a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 17:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736213886; x=1736818686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HBUfeUW6/GEDOvf/9UKNi0N2F9Yek+Arua+HJkBvO8=;
 b=pkPMNeiBXAbMepa8XozcxZR6kSgcthhg/G8ZInwDmRJ5V9m71wRyFsn+s5UwbSCumV
 eO30QYbqo4EvgIwAOSytcu2rFEsw60ZFTePN5uxpKNQGPhTtOR4gDUe0Bmeb8FqBoz3B
 cAh/j6lQm4t4XFGoY44ZvnkT9UIMuELyNSJ/IiHhhe2H5YzV7qczOIdLHPKs8S1RBabr
 bBRVUedXJiQ0KwqOw9QzSTOjV8FQ5jbirXh9UH0RMdOpoGtpLjs8hc0avuxfU4cSnFWj
 B3Af1aLoxZvpd4X/X9I3qvycBcji7UZFziWOu/40Qk7+77O61KX03gPSXd7haxheDjhF
 kDAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCvR3ImLkPZTDcGldTc/fzVq2DdVviOyZw03W9TeN/ni5AIMPX+/GzwHSw5GeggYdnUrS/I06bGUxA@nongnu.org
X-Gm-Message-State: AOJu0YxebyBhLcYSY6EDP7uEcBmjUwv2ZMRks5rGT0THmmdOda86jnSO
 lRHJLMBi516WQukpQPfvaNtsWnw72AfBVuZmQ5jtWmQ2qSHW36HhF44mxJ9RlVwTsfSK8ZrusZx
 qD/dcsuuRG+Hf5no5E1OQ1Z/V3TsStzwpPVtGKKugNFtqS9v4j3EVm/drBQyzDPKUU8dobaQD9g
 +FM1s1GC3AIMYqgwARHf5FA6IGK/w=
X-Gm-Gg: ASbGncv5AYPXPIUCAjehgGNQsFR31YySyn6APa2NGgUIM1N09XZem1hf5kJSer5Jz5h
 FiIYuHE6oGpftY0Axlw9/WoVBnOx7dcd/cM/WgbU=
X-Received: by 2002:a05:6402:40cf:b0:5d0:e570:508d with SMTP id
 4fb4d7f45d1cf-5d81ddfe3b3mr54213761a12.17.1736213886180; 
 Mon, 06 Jan 2025 17:38:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqcRRRzEUvyTzkjOEYu2/MEdRmop+VOXdJye8qao2kymx5NxR2rX7fs5y1XW3kobsqEOn7YyTEeDAnBNwC6DM=
X-Received: by 2002:a05:6402:40cf:b0:5d0:e570:508d with SMTP id
 4fb4d7f45d1cf-5d81ddfe3b3mr54213754a12.17.1736213885857; Mon, 06 Jan 2025
 17:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20250106155737.976977-1-jonah.palmer@oracle.com>
In-Reply-To: <20250106155737.976977-1-jonah.palmer@oracle.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 7 Jan 2025 09:37:29 +0800
X-Gm-Features: AbW1kvYRr4M-a20Na6SQV7G0NaCVNy1Y-lTLNOpkuYIIj-jXSdlxgWpiqAEa4l4
Message-ID: <CAPpAL=x-maHy-KSn0jLwNcQMf-3uLVvu9Ld-Cx1vB6BDi5C34w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Move net backend cleanup to NIC cleanup
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: eperezma@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 dtatulea@nvidia.com, mcoqueli@redhat.com, mst@redhat.com, 
 si-wei.liu@oracle.com, qemu-stable@nongnu.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

I tested this series of patches with virtio-net regression
tests,everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jan 6, 2025 at 11:57=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
> structures if peer nic is present") effectively delayed the backend
> cleanup, allowing the frontend or the guest to access it resources as
> long as the frontend NIC is still visible to the guest.
>
> However it does not clean up the resources until the qemu process is
> over.  This causes an effective leak if the device is deleted with
> device_del, as there is no way to close the vdpa device.  This makes
> impossible to re-add that device to this or other QEMU instances until
> the first instance of QEMU is finished.
>
> Move the cleanup from qemu_cleanup to the NIC deletion.
>
> v3:
> Remove shadowed declaration of NetClientState nc variable in 2/2.
>
> v2:
> Remove NIC peer also at net_cleanup. vhost-user trust all the
> backends are clean before qemu removes char devices.
>
> This is not a requisite introduced by this commit as
> system/runstate.c:qemu_cleanup shows.
>
> Eugenio P=C3=A9rez (2):
>   net: parameterize the removing client from nc list
>   net: move backend cleanup to NIC cleanup
>
>  net/net.c        | 44 ++++++++++++++++++++++++++++++++++----------
>  net/vhost-vdpa.c |  8 --------
>  2 files changed, 34 insertions(+), 18 deletions(-)
>
> --
> 2.43.5
>



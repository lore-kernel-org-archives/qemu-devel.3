Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1286C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 04:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkyng-0001iX-Hc; Fri, 15 Mar 2024 00:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkynf-0001iP-Ij
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 00:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkynd-00031P-NB
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 00:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710475444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48cL7dJWiQicfy5ZVsmlo1tEbADF+OUWknvrIK34cKs=;
 b=XG+EWhMu7JFpVbQneJ1aDPgjoKUsGkCs+3He6+j8mPcj0Uh8Xi04BzJ+UeqoKrXeEna7Iu
 qbRBWIJVEXifs8P50/pK6N9pmnvepyIVFsNRR7tng70tPNIVnFiN0XUCMJ8BTWCieznyx9
 kvFhq5GizjFtHzWXBgQpnCKsa29t27Q=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-ERrGS6ttNX-_BZ7tAw7uXg-1; Fri, 15 Mar 2024 00:04:02 -0400
X-MC-Unique: ERrGS6ttNX-_BZ7tAw7uXg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cfc2041cdfso1330296a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 21:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710475441; x=1711080241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48cL7dJWiQicfy5ZVsmlo1tEbADF+OUWknvrIK34cKs=;
 b=qET01cVq3LeQiOWgdpwC6zBG4sLVWFJuV0DH3qXdT9FGU3cmd1UGTpeF0KgJmAmxrl
 E6HqmhiV9e3UrdiM11tnk6juZkBwxBPB2AuUBKbHyEBXb7qDWUw8fSYVJJzxQW2OBXF9
 ga7z8IL21M5KkLsuOarogpG9XPRtjGzDLcbDGe6ZofQzCFa15ewL49WtrrD9sAkPXQES
 Xr6ir8Nbm0qEnxZpX+U9b034AMFmf/t15deJZBSluTb2uZuW7U+1nAKR6rMBT9IOeAes
 9sPmfLQjetAWF1LKUx7iuhrAVKJM29a37wkZ3kq+6A7zuWbIG7NeDUlhO8gbryYDLQ1t
 OA/w==
X-Gm-Message-State: AOJu0Yz36ihVACw3nTVbiwLdM5YxHs6skrawy7TJYrwf12zxshKWhTOQ
 6CAq/lEdxxdrwlmI6LynDlCSUUY2nShrKbm2T/y/OiFCpfI/GgLtSwSJKjMfXIv9+9dYQHINseI
 L3YLjJawCBj6TVdRTzcgTT3gB4nw4zr/qVxO5kg8DOt7gbzGVZGjPXKpwC/v4VRAPBkhtGpHtmp
 gDzGsbKBtLMEbbCeB+otxX61zzCA74INK5OMAWlSfV
X-Received: by 2002:a05:6a21:7898:b0:1a3:3089:9de5 with SMTP id
 bf24-20020a056a21789800b001a330899de5mr2605352pzc.0.1710475440991; 
 Thu, 14 Mar 2024 21:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGImy8PqHXR6v1tv6qVlPuyTGhg+/Ruh36RITXd871dhZpJDvllY/5ruvIIBp/hJ1E0E+86CMZ7nE9R0RKGI7o=
X-Received: by 2002:a05:6a21:7898:b0:1a3:3089:9de5 with SMTP id
 bf24-20020a056a21789800b001a330899de5mr2605340pzc.0.1710475440694; Thu, 14
 Mar 2024 21:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <1710448055-11709-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1710448055-11709-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Mar 2024 12:03:49 +0800
Message-ID: <CACGkMEukLmTSfuXxSMsZuO_B7o7623x=gmLD5s-xoinEq=dWYQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vhost: Perform memory section dirty scans once per
 iteration
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
 joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Fri, Mar 15, 2024 at 5:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> On setups with one or more virtio-net devices with vhost on,
> dirty tracking iteration increases cost the bigger the number
> amount of queues are set up e.g. on idle guests migration the
> following is observed with virtio-net with vhost=3Don:
>
> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
>
> With high memory rates the symptom is lack of convergence as soon
> as it has a vhost device with a sufficiently high number of queues,
> the sufficient number of vhost devices.
>
> On every migration iteration (every 100msecs) it will redundantly
> query the *shared log* the number of queues configured with vhost
> that exist in the guest. For the virtqueue data, this is necessary,
> but not for the memory sections which are the same. So essentially
> we end up scanning the dirty log too often.
>
> To fix that, select a vhost device responsible for scanning the
> log with regards to memory sections dirty tracking. It is selected
> when we enable the logger (during migration) and cleared when we
> disable the logger. If the vhost logger device goes away for some
> reason, the logger will be re-selected from the rest of vhost
> devices.
>
> After making mem-section logger a singleton instance, constant cost
> of 7%-9% (like the 1 queue report) will be seen, no matter how many
> queues or how many vhost devices are configured:
>
> 48 queues -> 8.71%    [.] vhost_dev_sync_region.isra.13
> 2 devices, 8 queues -> 7.97%   [.] vhost_dev_sync_region.isra.14
>
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>
> ---
> v3 -> v4:
>   - add comment to clarify effect on cache locality and
>     performance
>
> v2 -> v3:
>   - add after-fix benchmark to commit log
>   - rename vhost_log_dev_enabled to vhost_dev_should_log
>   - remove unneeded comparisons for backend_type
>   - use QLIST array instead of single flat list to store vhost
>     logger devices
>   - simplify logger election logic
> ---
>  hw/virtio/vhost.c         | 67 +++++++++++++++++++++++++++++++++++++++++=
+-----
>  include/hw/virtio/vhost.h |  1 +
>  2 files changed, 62 insertions(+), 6 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 612f4db..58522f1 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -45,6 +45,7 @@
>
>  static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>  static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
> +static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
>
>  /* Memslots used by backends that support private memslots (without an f=
d). */
>  static unsigned int used_memslots;
> @@ -149,6 +150,47 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>      }
>  }
>
> +static inline bool vhost_dev_should_log(struct vhost_dev *dev)
> +{
> +    assert(dev->vhost_ops);
> +    assert(dev->vhost_ops->backend_type > VHOST_BACKEND_TYPE_NONE);
> +    assert(dev->vhost_ops->backend_type < VHOST_BACKEND_TYPE_MAX);
> +
> +    return dev =3D=3D QLIST_FIRST(&vhost_log_devs[dev->vhost_ops->backen=
d_type]);

A dumb question, why not simple check

dev->log =3D=3D vhost_log_shm[dev->vhost_ops->backend_type]

?

Thanks



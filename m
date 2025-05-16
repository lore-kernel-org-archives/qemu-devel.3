Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C7FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 02:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFkO1-0001k2-P7; Thu, 15 May 2025 22:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkNy-0001cc-VV
 for qemu-devel@nongnu.org; Thu, 15 May 2025 22:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uFkNx-0005Ah-87
 for qemu-devel@nongnu.org; Thu, 15 May 2025 22:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747360876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJxIvLSp24Zd5NKEleBk7HZt6jzTJ8NEoMpKkxofqTE=;
 b=UZbLBG8wnxntbug13iu/heTtVxeOYcMD4XneVPWZEgAtEvu+40JOEhNVECQuXtAKx2S5GW
 thMC+5vKN8XvJ3gkHfqZU3h8dDYbKSYBxqnP3FObYcV5yMVVETWXhyK1xKrwFC6oVaw8Tc
 8ck3ebhgS/Vz0vdKf/PaNtE6011a7ak=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-8lsSbZm9P0ycygCl-Et-7w-1; Thu, 15 May 2025 22:01:15 -0400
X-MC-Unique: 8lsSbZm9P0ycygCl-Et-7w-1
X-Mimecast-MFC-AGG-ID: 8lsSbZm9P0ycygCl-Et-7w_1747360874
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-30c06465976so1688011a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 19:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747360874; x=1747965674;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJxIvLSp24Zd5NKEleBk7HZt6jzTJ8NEoMpKkxofqTE=;
 b=B6z+zEPDrB7lYWj9ckbUsdQhtJP6Px/eJ0DrHCNaa/RapH+thimcvSwsSNzjoTT112
 ukadj4ovPiOMr6juQQBZSfOnFZFmNceBl3ADiL/6eZQ3EN85NdpAJ15nRZivoWuX+Cz8
 izRM4KUAVwdXfyR+sffghBB1Rs5QAURFBiAOySi0Wu+7QbhJHWOBFVsiESUh5vJSxIWp
 MarJz75w0gbx2Yqa3Lb4kX77LtSeKkkCbIsg0N8WFdXHYeGTw79W6pZlvjoDDYDgSjEn
 1xb2S7Xq6XHX2M9akz8eOW8Dce7vxuX+vZmGDkPipia3gOP8xBxpE7ZllcV/HalKp5H5
 apRA==
X-Gm-Message-State: AOJu0Yzn7ZZk2DbDyUE1NqIdlkvp+0cIGVPD+4bfoB6tmIxNgdCZjZyp
 Cogcc7Qe3t4WDFXorXuj0thDVSVm66ueoHyjAARV4v98Lcb3kIwO9GNQk7EmftGLp+hPJ3RCzCC
 CmJvY02YIlosdYHUlgli5qrwppAbhCtPulsxjq7BCMDz7Q7sMqIVIkbFIaUSsfy3RfJ8qdCPicN
 eSl4gb08e6TGC1QMcISdHb/fAru2jDfm4=
X-Gm-Gg: ASbGncuViBEf8KU3U9SkS8xyjI4Y1cGrWC4hd9crvWTNWOYrCH1len7J89HVyr8f5iN
 DxPJGb8RZKnXbgz9coj/1228ax5W+yvN1HV+kwPnAmYv8NVL5RQycaptGEY9HfvRkqnLWpw==
X-Received: by 2002:a17:90b:3905:b0:2fe:9783:afd3 with SMTP id
 98e67ed59e1d1-30e7d507ddcmr2226919a91.2.1747360873864; 
 Thu, 15 May 2025 19:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ0j0hTPnGs/WrmYWdfCtsxqudyCnS2sy3LUhKYx/unQDOK3WEi7KRO6lWa6MPd3dXlR867ndAPejia+lwm4M=
X-Received: by 2002:a17:90b:3905:b0:2fe:9783:afd3 with SMTP id
 98e67ed59e1d1-30e7d507ddcmr2226886a91.2.1747360873446; Thu, 15 May 2025
 19:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <20250507184647.15580-6-jonah.palmer@oracle.com>
In-Reply-To: <20250507184647.15580-6-jonah.palmer@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 May 2025 10:01:02 +0800
X-Gm-Features: AX0GCFsPToxW7IB5-YWUNSYM93fnhvxb8Iofvbg9595Wv3w-Hynm_woVwCdUS4k
Message-ID: <CACGkMEuZzErLv9Q0s=KoxdN8WJu9kfsxVqdYaEgbnG6ZJcQHpg@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] vdpa: reorder listener assignment
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, peterx@redhat.com, 
 mst@redhat.com, lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com, 
 parav@mellanox.com, sgarzare@redhat.com, si-wei.liu@oracle.com, 
 lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Thu, May 8, 2025 at 2:47=E2=80=AFAM Jonah Palmer <jonah.palmer@oracle.co=
m> wrote:
>
> From: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Since commit f6fe3e333f ("vdpa: move memory listener to
> vhost_vdpa_shared") this piece of code repeatedly assign
> shared->listener members.  This was not a problem as it was not used
> until device start.
>
> However next patches move the listener registration to this
> vhost_vdpa_init function.  When the listener is registered it is added
> to an embedded linked list, so setting its members again will cause
> memory corruption to the linked list node.
>
> Do the right thing and only set it in the first vdpa device.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



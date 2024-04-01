Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7643DCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 07:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrCUr-0001ZR-9t; Mon, 01 Apr 2024 03:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rrCUp-0001Z4-NN
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 03:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rrCUn-0003T4-Bt
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 03:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711958058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGFc0mlQvNlQAQfnLAV5FokRIfCq1trLz/SyuyFpNmE=;
 b=A1dYfcg05ccps0vbNrEnyfjLfvKdj15vwm408C7dOXkjbNvIK9+/Mi5d5TWzt4aw9DAAAF
 8HC8xeyvI2LoTwDaCxhWyaFUuFyRL1BnQHDZcCSyCe5TTGyGdX82xgY1RX8Zo7O/s2ohsD
 k2j0IsWmY8NCGK9yWO1cIrWq0lCYtD4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-dDisKiKsOV2g1SE3TFWr9w-1; Mon, 01 Apr 2024 03:54:17 -0400
X-MC-Unique: dDisKiKsOV2g1SE3TFWr9w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-568a9f3ba97so2662354a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 00:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711958056; x=1712562856;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DGFc0mlQvNlQAQfnLAV5FokRIfCq1trLz/SyuyFpNmE=;
 b=VBItyRSyMnPodZFj/I40AEWPYoViGnadtTedKpyxaWWBAa4uofYo5++w6Dc38N/Ewy
 ttQZsrErvYXX1J+qxURX7fEWA0K+EXGX+0Wq7ODmDI4bZYqEf7WGUMfBuqfCCCTv6IZb
 7JsyHNGYpTOFWVT9BYEKJlGiVkJ8KX28fDeC14rNCEIhsvIxRQG1UpQYti5dOj/U0bXZ
 jyrP9KkXLM/oEB4K8fcukLdK+D8m+uc4AR4+VrdPhgG5tlU6bk8eVQNh1uB33WJ3Rp/N
 va/SN4iHHPAINcTxAQgUEB153ZsckMEYqB05M9KWg7V4h8JFmKJoXDb0BRm/lwfJatAu
 AHEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZvVd2ljRQsas3X5q6i4Xrav+Q8t7lDicYDn+qi7CV6LjZc3iteK1Lbi5PbTenjdJ13GPKps7FvrM31dk77ONwPqnaF5Y=
X-Gm-Message-State: AOJu0YzA60EU5dZXomLvLwd95xJIhnROfROkiTxVvOdK+yZceEnv10T/
 NvmjZZWe6yt6bsj8rEKt2cPjABmaDdWI7VVNiGokKdYHSWhR7vsApR+zcCZ88bEztzP0ucnLtwE
 qjrESvMrPksWE9QGMxRgNga39Mqi6Md9Puvnj1sNJge8H+X0MY23k
X-Received: by 2002:a05:6402:234d:b0:56c:274a:31df with SMTP id
 r13-20020a056402234d00b0056c274a31dfmr6405175eda.5.1711958055712; 
 Mon, 01 Apr 2024 00:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs/Mifx/Yw20Jp9un2Dam5K4H9mrMV25uaW8NdDPejQNzibqFnkoMtUAyGhJnMXqGHEHOhXQ==
X-Received: by 2002:a05:6402:234d:b0:56c:274a:31df with SMTP id
 r13-20020a056402234d00b0056c274a31dfmr6405154eda.5.1711958055209; 
 Mon, 01 Apr 2024 00:54:15 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:9c27:9486:684f:de6:8ab8])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a056402091300b0056c57f169a7sm4640390edz.25.2024.04.01.00.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 00:54:14 -0700 (PDT)
Date: Mon, 1 Apr 2024 03:54:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yajun Wu <yajunw@nvidia.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "fengli@smartx.com" <fengli@smartx.com>,
 "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Parav Pandit <parav@nvidia.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: vhost-user-blk reconnect issue
Message-ID: <20240401035350-mutt-send-email-mst@kernel.org>
References: <DM4PR12MB5168C0DB5E4B8F30B47738F6B6362@DM4PR12MB5168.namprd12.prod.outlook.com>
 <vzwqswsxtiios4mzwab4br2utyrclkfsluwyvyw6r7gqnx55fv@z3rsaj4hs6cz>
 <add17160-7b47-4af0-908c-9c0617720cc2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <add17160-7b47-4af0-908c-9c0617720cc2@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 01, 2024 at 10:08:10AM +0800, Yajun Wu wrote:
> 
> On 3/27/2024 6:47 PM, Stefano Garzarella wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Hi Yajun,
> > 
> > On Mon, Mar 25, 2024 at 10:54:13AM +0000, Yajun Wu wrote:
> > > Hi experts,
> > > 
> > > With latest QEMU (8.2.90), we find two vhost-user-blk backend reconnect
> > > failure scenarios:
> > Do you know if has it ever worked and so it's a regression, or have we
> > always had this problem?
> 
> I am afraid this commit: "71e076a07d (2022-12-01 02:30:13 -0500) hw/virtio:
> generalise CHR_EVENT_CLOSED handling"  caused both failures. Previous hash
> is good.

CC Alex who wrote that commit.

> I suspect the "if (vhost->vdev)" in vhost_user_async_close_bh is the cause,
> previous code doesn't have this check?
> 
> > 
> > Thanks,
> > Stefano
> > 
> > > 1. Disconnect vhost-user-blk backend before guest driver probe vblk device, then reconnect backend after guest driver probe device. QEMU won't send out any vhost messages to restore backend.
> > > This is because vhost->vdev is NULL before guest driver probe vblk device, so vhost_user_blk_disconnect won't be called, s->connected is still true. Next vhost_user_blk_connect will simply return without doing anything.
> > > 
> > > 2. modprobe -r virtio-blk inside VM, then disconnect backend, then reconnect backend, then modprobe virtio-blk. QEMU won't send messages in vhost_dev_init.
> > > This is because rmmod will let qemu call vhost_user_blk_stop, vhost->vdev also become NULL(in vhost_dev_stop), vhost_user_blk_disconnect won't be called. Again s->connected is still true, even chr connect is closed.
> > > 
> > > I think even vhost->vdev is NULL, vhost_user_blk_disconnect should be called when chr connect close?
> > > Hope we can have a fix soon.
> > > 
> > > 
> > > Thanks,
> > > Yajun
> > > 



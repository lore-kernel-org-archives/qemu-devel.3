Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3350C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2TO-0002Pp-NI; Thu, 08 May 2025 10:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uD2TM-0002Og-C8
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uD2TF-000561-2D
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746715411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RhQyym7E+M+PuHm7jn9gZRO7XTTO0/52PxBBUsxFrQY=;
 b=fJNGOmh5oPaPMHByy3SfDYu0wsv5TSQNrTTx0NoNP9pe1n8IiUqiYaZvnHMsZDtKY4Xgvf
 Zh0DJ6sIsoR+raogxLnx2p7pd00pZQZPMYLPprmN2XdyeKW0UEM/AIWldzX/f8LhxIOIEt
 oXkuoOdeh8Rv/5ZM7QHvH5xakziy9rc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-79dJ50GdMhK9nLBaTexBRw-1; Thu, 08 May 2025 10:43:30 -0400
X-MC-Unique: 79dJ50GdMhK9nLBaTexBRw-1
X-Mimecast-MFC-AGG-ID: 79dJ50GdMhK9nLBaTexBRw_1746715409
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so4683735e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 07:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746715409; x=1747320209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhQyym7E+M+PuHm7jn9gZRO7XTTO0/52PxBBUsxFrQY=;
 b=HntrMQ9AQms45GLD5Oc98y1BnkC/s35M0jz8DEuEE8g5UmsO/32PPZUXe3ij96CFnv
 eo29OfiIAs/e0BswG53GKu4hgm0/Bvy/sD3jcmJX5A6GTz9hq/6Rc1PPOUFJk7oDoXl3
 dCwFus0k/liQeCvJMQkpZKRo8tfQ+Ct/hps93L+INDyAY8JsW6fEZQcosF8qY56VTocc
 r3Kr+NfHNo5Urvz31/1zOQJe6NHJbi9z6Qp3Eyw3FvzUyiRJ1hqQ/aerkFc37YMY+Qx/
 nZgMWuTzFNrl3e9xmVRTW8k2d5WhwIu0gef2qSMA95h38IqCk04lPpolEsldqWo7hHUG
 IeQA==
X-Gm-Message-State: AOJu0Yzwl161lmEBmwZUaKf/9n9hsJb37XyiBMNZqWkfioXHKF3MmcH3
 qo6Ksg7N7uiU5j0w5/Y4gAsbclpCSk+NUn2iFW6gcXFwXn+D6tUL8tNd4cQyGDfcWWL4/E6Hs3Y
 fN0MHMyrtP/9UI2CMyNE4Lt/Jok7/dG6YjLvYN073hda+UCt6Fc0A
X-Gm-Gg: ASbGncu2nZEEZ4KshzqGLItPRzxcqadV0YkB9YbAMgugXXxZO0wqozUJOyYn5p3fwZu
 3kpqiqCs6pRzBBjh32U24UImXS49tBX1qWptTa/QZHLz0znteK7vCJbwAmZnY4PtexRqzASawnN
 /b+/pxFiqQRDP2WXLEF43tdog5TFYCF087ktv4IhC6YermuQfWAWFlQSLNFr2JhmgP9FzhSpjV2
 NxJ19WrBuApMXL2mw7HcT6vMrHYfxzKbj2FVz62cQRTdGu/IdLJWzzhwqdQhT1xlE/J/y0dJO8O
 vT+Raw==
X-Received: by 2002:a05:600c:4454:b0:43d:79:ae1b with SMTP id
 5b1f17b1804b1-441d44c363amr66520085e9.14.1746715409042; 
 Thu, 08 May 2025 07:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1pKnly0b4G01Y9Idb0oHOf4VDU29H6vTRJPd7O/AcEw4nBnlVG4NM9jTo3VHE5hmkmPNU3w==
X-Received: by 2002:a05:600c:4454:b0:43d:79:ae1b with SMTP id
 5b1f17b1804b1-441d44c363amr66519895e9.14.1746715408706; 
 Thu, 08 May 2025 07:43:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7dc1sm38918665e9.34.2025.05.08.07.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 07:43:28 -0700 (PDT)
Date: Thu, 8 May 2025 10:43:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH RFC] meson: require int128 type
Message-ID: <20250508104300-mutt-send-email-mst@kernel.org>
References: <8c8f9a7e77e25a87b54335f7c376cb079fe67655.1746706766.git.mst@redhat.com>
 <CAFEAcA-ideWjVhKjK6xTcSFoKPY3C_9BJ0jp-UE-7qCkGGt8FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-ideWjVhKjK6xTcSFoKPY3C_9BJ0jp-UE-7qCkGGt8FQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 08, 2025 at 01:30:25PM +0100, Peter Maydell wrote:
> On Thu, 8 May 2025 at 13:21, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > compilers that QEMU requires support int128
> > (though arithmetic might be more challenging).
> > As virtio wants to use int128 with bitwise opts only,
> > make it simple by failing configure if not there.
> 
> IIRC the problem is not the compiler version but whether
> or not it's targeting a 32-bit host: compilers will
> implement an int128 based on 2 64-bit registers, but
> not one based on 4 32-bit registers. Did you check this
> on all our supported host platforms ?
> 
> (We've deprecated 32-bit host support, but not dropped
> it yet, I think.)
> 
> thanks
> -- PMM

Thanks for the feedback, indeed I did not. Will check some
config.



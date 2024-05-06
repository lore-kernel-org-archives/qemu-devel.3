Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EA1C25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 20:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s44km-00074k-2N; Mon, 06 May 2024 16:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akalenyu@redhat.com>)
 id 1s41sp-0005IZ-0Q
 for qemu-devel@nongnu.org; Mon, 06 May 2024 13:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akalenyu@redhat.com>)
 id 1s41sm-0005qW-PM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 13:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715015526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jEeUqtTrp8MlhrODiBbUE30sdHYt4t4s4dp6Y9nWzTs=;
 b=YwHjE5AYfwKFy3RLzWg6rsxc6f7XN0dyr95jmPRn62cIKssE02oOHS7ruZ+yqwSXD/Jg4u
 /oFykAxwBB6i/LI9sOgn+1sH6QDY1dRDRkdBuL97iRvXUm7INtD8H4iaMMvQFTKeTIELVc
 Z6xAPlzp16LzaEsvMtGZIQAR6szxP28=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-okwNZje0Owy4RUbSU4vt8Q-1; Mon, 06 May 2024 13:10:38 -0400
X-MC-Unique: okwNZje0Owy4RUbSU4vt8Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-51f60b1644cso1926458e87.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 10:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715015437; x=1715620237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jEeUqtTrp8MlhrODiBbUE30sdHYt4t4s4dp6Y9nWzTs=;
 b=dW3H3WnS1Yza7MSaQgyVXwWZKpQRujWVWtWh31vfon3Ng5S9SXv0QLhd+D6hJ5XSVH
 mlk5NnNJ/lGJ8f+ZIuftmmywGzF08ajT9ONFgQSiSRAO7ld1LpiMLlw3mEG3SUrS5Md/
 epcIng5OY462jSdpWm/oCKD16gVEStWZoyoXKUQzlS+jH+PKq7cXINLW8kVfz3aFOK65
 Aumu7c+SezOfJhMyFg9WT2epnFcU8Nu9IjphYlLl9Rmpc+BCH5ti1/upbgUHOVb4CLHo
 8dEC3l55zuD+/YrNZ0rQFOeaigxyjM/9mYhCmhpk+4iMxw5xe7cTN8J7eCKqRlkLFtP7
 KPJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqGqYI4Oe3D08QxuUxgBg+N6uiYQGVgT24Ag7dTMLwj7ly1CAZnUC1i3vViOJqG7dehwtwvjZ0kzibO7EmOnfMPEAJpoM=
X-Gm-Message-State: AOJu0YzWP3+vkDJ/qQzVGA13AaP0CLiP8iyrpWXq3qZ9GQuikgG5JmTo
 9r2Q7TTchfOpUCxQkDUl/v3m9Z7egA0SixsenwJt5Pp3CHOFpghzAEVhCMHcmKCugkvYrie5kLp
 34YmVMFZVHP6KyCQ9CBXHp+sii46rhDdQwDdGl+Yk6ZknrWqKzh2HsChAkg2qaAsVwV72ldUdVC
 h+uR9Zyg1sW5LY5A8jkvTPmuYGZm4=
X-Received: by 2002:a05:6512:2011:b0:51b:7415:655f with SMTP id
 a17-20020a056512201100b0051b7415655fmr8059970lfb.36.1715015437367; 
 Mon, 06 May 2024 10:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVEDFeXhIUvjHG+1D4COTEPOctiVPPuamt0NZzqXRgFWt+fshXyu/TD4lvQh+5GcrF7hLSjNyFOQUY30sbv68=
X-Received: by 2002:a05:6512:2011:b0:51b:7415:655f with SMTP id
 a17-20020a056512201100b0051b7415655fmr8059944lfb.36.1715015436955; Mon, 06
 May 2024 10:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230731154036.GA1258836@fedora> <ZMftO2aPh9YOu5R0@redhat.com>
 <20230731191527.GB1281379@fedora>
In-Reply-To: <20230731191527.GB1281379@fedora>
From: Alex Kalenyuk <akalenyu@redhat.com>
Date: Mon, 6 May 2024 20:10:25 +0300
Message-ID: <CAHahevc5nrUYakDezGmBAn3LPCwvvYREuHdGKXZvaQY-n1Q85A@mail.gmail.com>
Subject: Re: qemu-img cache modes with Linux cgroup v1
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Adam Litke <alitke@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, 
 "Richard W.M. Jones" <rjones@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e78d080617cc25c4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=akalenyu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 May 2024 16:15:37 -0400
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

--000000000000e78d080617cc25c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey, just FYI about tmpfs, during some development on Fedora 39 I noticed
O_DIRECT is now supported on tmpfs (as opposed to our CI which runs Centos
9 Stream).
`qemu-img convert -t none -O raw tests/images/cirros-qcow2.img
/tmp/cirros.raw`
where /tmp is indeed a tmpfs.

I might be missing something so feel free to call that out

On Tue, Aug 1, 2023 at 6:38=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> Hi Daniel,
> I agree with your points.
>
> Stefan
>

--000000000000e78d080617cc25c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey, just FYI about tmpfs, during some development on Fedo=
ra 39 I noticed O_DIRECT is now supported on tmpfs (as opposed to our CI wh=
ich runs Centos 9 Stream).<br>`qemu-img convert -t none -O raw tests/images=
/cirros-qcow2.img /tmp/cirros.raw`<br>where /tmp is indeed a tmpfs.<br><br>=
I might be missing something so feel free to call that out</div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 1, 20=
23 at 6:38=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat=
.com">stefanha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Hi Daniel,<br>
I agree with your points.<br>
<br>
Stefan<br>
</blockquote></div>

--000000000000e78d080617cc25c4--



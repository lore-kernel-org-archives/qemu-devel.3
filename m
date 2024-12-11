Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D53FE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 12:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLM3R-0000HH-Al; Wed, 11 Dec 2024 07:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLM3M-0000Du-22
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 07:42:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLM3H-0000tE-Rf
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 07:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733920970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vq3FrMhMejZKmaw5CP5HgzQ5OYKuGQCtDjPOZpdfK1M=;
 b=Mb70oIxrzHg4rVyYIzAs8PLDudyL+YXhGVGmtS8RdW4VBL8TrIa04NvxhIDFVLctVje5XQ
 SfZqiWcXJJH+4MBlGAbfmfz5Fqn6w/MyoiKKSUweV4iOY5Jk56rt57o7uifHKWKga+h3tM
 ydOeIFaFWT7WUN/s9KubNm8OVnM1ELo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-4lI3YJanO-K6MfTYww2e0Q-1; Wed, 11 Dec 2024 07:42:46 -0500
X-MC-Unique: 4lI3YJanO-K6MfTYww2e0Q-1
X-Mimecast-MFC-AGG-ID: 4lI3YJanO-K6MfTYww2e0Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434f3398326so3372435e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 04:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733920965; x=1734525765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vq3FrMhMejZKmaw5CP5HgzQ5OYKuGQCtDjPOZpdfK1M=;
 b=coC7jZU/W14T7CVL1TW/mW3rMjpTNzGc1rXoBBaHctkbd/1RRyNKJ+RskCnzATDzul
 jdufxg8qxEFEUyZcRiQm351RQtjP10fPnVKH5dpkFlMftW7R8rbGO8v4eJf/v2PI3JiG
 peR35crMOQbM7ED/x5hZUQ3iqo0cfc79+pXA4CFl+D4xNnwt7KIGRvPm9u4k19rVzD1M
 FsY1Mtdq16f6QUwB92nncQVxI0BAEvclT3CVZ0y1uuPN+Gyx5JdCyxUlnQC++isYewxw
 K18hwyqo31pafm6zLosD43nxwhbbiiUy2W06nMiVuRXy7cHVK5qMxQUDshf01OsUA47a
 eLrA==
X-Gm-Message-State: AOJu0YyXUqPNtfdRwSrFH84axisgL90H6YKuz6O5ZO8FR4P9joRg/bX7
 tRq0S46MKR3/tgjjHVFSlUI32iinK69JpS5QlB9PJtulDa9wmaUUbOLpMMJHUW1ZZ1W3QRgLVPj
 9vA7X8oALYHu9sHuwtAVCSkt5g6JOPeZ4DaGGXHTK24rN5LKPO7ND/GjeuHxQvoLdqIthf8sixF
 hBcJlLBqsPgjIlevcKcrZP56CZkso=
X-Gm-Gg: ASbGnct1nqvFprcIIblxPsJWWhwzwQpsBEBLbqQcGXHxiy7OeHU1VXZdI4A2LhnpOsd
 cIP19+NMGFrXwSf8pxpCjMLvdQrgyAaqofNQ=
X-Received: by 2002:a05:600c:4fd5:b0:434:f2af:6e74 with SMTP id
 5b1f17b1804b1-4361cf91555mr19094955e9.15.1733920965050; 
 Wed, 11 Dec 2024 04:42:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLHRHmiBix5MBINE66d82uaNYd/BF+Fo550d7SIVpIwbpzZBw/ew9YpMiagOun/XntGkGTevs/pi553viM+h0=
X-Received: by 2002:a05:600c:4fd5:b0:434:f2af:6e74 with SMTP id
 5b1f17b1804b1-4361cf91555mr19094755e9.15.1733920964733; Wed, 11 Dec 2024
 04:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-14-pbonzini@redhat.com>
 <Z1hpT6F9jVlj2+ba@intel.com>
In-Reply-To: <Z1hpT6F9jVlj2+ba@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Dec 2024 13:42:32 +0100
Message-ID: <CABgObfYa1HZoRs+RVSxax02jAcMb86P3VM-fJa0KHHTTiDTuYw@mail.gmail.com>
Subject: Re: [PATCH 13/26] rust: qom: automatically use Drop trait to
 implement instance_finalize
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Junjie Mao <junjie.mao@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Dec 10, 2024 at 4:58=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
> Great idea. It nicely balances the differences between Rust and C QOM
> conventions.

Except it does not work. :(  Suppose you have

       pub struct MySuperclass {
           parent: DeviceState,
           field: Box<MyData>,
           ...
       }

       impl Drop for MySuperclass {
           ...
       }

       pub struct MySubclass {
           parent: MySuperclass,
           ...
       }

When instance_finalize is called for MySubclass, it will walk the
struct's list of fields and call the drop method for MySuperclass.
Then, object_deinit recurses to the superclass and calls the same drop
method again.  This will cause double-freeing of the Box<MyData>, or
more in general double-dropping.

What's happening here is that QOM wants to control the drop order of
MySuperclass and MySubclass's fields.  To do so, the parent field must
be marked ManuallyDrop<>, which is quite ugly.  Perhaps we can add a
wrapper type ParentField<> that is specific to QOM.  This hides the
implementation detail of *what* is special about the ParentField, and
it will also be easy to check for in the #[derive(Object)] macro.
Maybe in the future it will even make sense to have special functions
implemented on ParentField, I don't know...

Paolo



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EEDC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w0f-0007JI-1B; Mon, 06 May 2024 06:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1s3w0e-0007J3-61
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:55:52 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1s3w0c-0007xR-QK
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:55:51 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5aa3f0fcd46so1064161eaf.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714992949; x=1715597749; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8x7evLdYHjFcOTxyom4WqBRye+UczFTZ1xMqk94Hpfk=;
 b=JKy6JBsS5oFSfgOYRrn+e4r920Fi8hTRAr9kgRYmtSYXmpD441rA0L04N2iySv3IMI
 qnMKYJlxoKO70KLC6F01eOoNRfzsK4l38GeCqpkKcJmqEGPArCfOs810bhgBx8s5SejB
 1kMdYXEhRN7JKLJdddSWHhKNIMp8ZEZwuQbCtM9RMAvLnA3gshBkaHO9orPYTYg9drhf
 gocmhHnJp3pOvD9DM9El+1Bz9gpO0lgLORM2ZXQ1vIMEQd8KG5E2aWw0IPav9oBIl+Ji
 f4fUrCMlB+USDQFg/BHaT+U2PYnHZrIeCgSEA1Yxhg5hjbmvSSKrQirSkLXkSt3wmBBb
 OZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714992949; x=1715597749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8x7evLdYHjFcOTxyom4WqBRye+UczFTZ1xMqk94Hpfk=;
 b=vzCbsUqVxOUK6CSjim+eSchznA4/Ev/LVR6mYAi22CAo148kw5JmFAV+fihavvTc2v
 JumwizUMFRnLB8K6lz/ALMHV6hcyRJQvXGNhfN9imN93a66LEDM312DDm5+suE0Arqa1
 KQLWWGuJA8WZwUuEXsWaV5JoFwDJ4KYNRuZuroQVreB5H9I8PR5lrZT4Au+3M7CdfgAp
 3mTHsloNTOtDo5xIzy6Zy4SGa4UMPXEROgfgJ99xvRbfwwqzun+Va45bx4ReWpo8ZRdP
 4sJLb59XMTjPprljWYExKWgeA5AYVMUvCa7bVIPsycMx03FVo4LlsIctpeGuJJNWQRr6
 IizA==
X-Gm-Message-State: AOJu0YwNXYZd6hLsNEuaeEEKz7/xTeGihDo49+s+AE1vF+sKg84JCzpr
 7QSmvMqSsDkFJ1S8XXhctfyJQIJiiMiGSbG2b0sJKP4Z3hklI7x2K8QRB+V7whCdTzIEasgTXFu
 94RXn+i0pkXwbZOnVI0hxBR5doKs=
X-Google-Smtp-Source: AGHT+IFgclCKKAkZyD8iP6uyyDKVz4W4cPsUjTmTz61pe9r89jQRRTO2cMN3ipTLLmKdYNGtmNJOxGreZdn22eWtETE=
X-Received: by 2002:a4a:5487:0:b0:5ac:5c7c:e628 with SMTP id
 t129-20020a4a5487000000b005ac5c7ce628mr9381981ooa.3.1714992949139; Mon, 06
 May 2024 03:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240506101348.30469-1-pbonzini@redhat.com>
In-Reply-To: <20240506101348.30469-1-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 6 May 2024 06:55:36 -0400
Message-ID: <CAJSP0QXe48mbqfUXikg8fuENtE7dztQS_eDKVUU-DkqZ4xemRg@mail.gmail.com>
Subject: Re: [qemu-web PATCH] blog: KVM Forum 2024 CFP
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The mistakes were mine. Thanks for pointing them out, Thomas!

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>


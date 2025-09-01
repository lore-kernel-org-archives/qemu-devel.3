Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E4CCA1007
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 21:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utC71-0002rR-36; Mon, 01 Sep 2025 17:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1utC6g-0002nF-2R
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 17:30:35 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1utC6d-0000X5-Uf
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 17:30:29 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-61cb9e039d9so9439280a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 14:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756762224; x=1757367024; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VBEON7liFwE3rhrL6f6egG1ZwTxa789aLrtzJ80JnVU=;
 b=cDvl7BeuTzq8mBBa98Dpk/a4YpD9ckEWItHVqNGLCxS1fB2hNF9cfIJxVC+3gjhHSY
 i+3ABf4lakzZC9a1juzhsqPs0STgmUzg45mL90epwRsfgnL8kWRNyFqaGYv0VPfhOSD9
 FFvlSwDI9L11h5PXUVFfiZn46GC+M5wxDtSeWmjY6BqHUsHC2ugnUEEPqIpGAEXPxb5j
 vdQEuKWKU7ddN2tKPIFmEU0I5TRpjBh8tH+LnfHlU/Folm15GGIb2ncSWCKD5H8R0MVb
 bnHuvFjx7GzLEUx6tvatXlqtLvcbvxBLTQU8iZCHTYb7skMZrPK0XyMXMNpu0ap7xhxD
 +1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756762224; x=1757367024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VBEON7liFwE3rhrL6f6egG1ZwTxa789aLrtzJ80JnVU=;
 b=MCldOZgw1/ZldxKsWqvazZ29ReHXAK7/oGzfkQVThRCxb+AEoc9To23xrwtMXouKvu
 pEV69t91ytAhoBPrevAr2PqXi1ufN1yq9SpLE3FU0JdWlprpP5tnpYSuCL4l5BiXKaeR
 frGwdQ/QYzRQNcsKT+XjoZyIfoI2oo6zNLUjl7Ex7jtVQm575VQs9Szvfps5itZb6e6I
 saFpWA2SiN0qyUpgjPEemaSloExrCOK0JQV836Dk3oPzqya4KhTBF/Fpbx1/8ggf1OEL
 Pnyid9rFFT8yUX9PTXLS+so+8Isz7qW3xIfAruiKLW8vXUQ42lMNmnUUYtQbc+2IXky0
 Cc8Q==
X-Gm-Message-State: AOJu0YzvWWSsQ2raBGDB7DfnnvrOmjTIFiyHPllvRXlO46oUF0F3IQCp
 GGBxO8JVxhUFiDrI4lrXOZp8pSWl+7Dr012l5JoXAmC25NuFSTg8kBiUxx76d0geZWtWyoizfZn
 yUa4sY3aM6/JjKICblpsytQZRzxCQP9A=
X-Gm-Gg: ASbGncttodOQ8/1FZ2W5sw+VgtlAxo5/EfabmRx8PbY4oylv520XEHliEJv+7g+mfDj
 72IyQvXeooeSFhLMd5who1kBXSv+tozGH/7pxC5B/SjrB6yHYKZSLmkWsekcmsIT9H+bAJlFjMc
 NnkLoKhZErEWhLRiB6r9+cKxR6ysF083EN7lCHuBetH/MgQmHq//8j7TDb0YGKEXwXwdkcA6Ckq
 i+yFlZsmRT0ypip
X-Google-Smtp-Source: AGHT+IHSZKSqcH3GPagrKf2kYKksr/j0t9bkCmnAT4RNe1xeZEc1gsyUcgPbZpU1ua4m3n6OnBTPZ9z5phhP4hXevdY=
X-Received: by 2002:a05:6402:2547:b0:61d:249a:43fe with SMTP id
 4fb4d7f45d1cf-61d26d9c38cmr9429993a12.24.1756762224007; Mon, 01 Sep 2025
 14:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABJz62PiQ9ipaJqr+X6AQvTJWZdAug5--4LOXa0i95DZkorNHw@mail.gmail.com>
In-Reply-To: <CABJz62PiQ9ipaJqr+X6AQvTJWZdAug5--4LOXa0i95DZkorNHw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 1 Sep 2025 17:30:11 -0400
X-Gm-Features: Ac12FXwYP2ewfmvK3MvG5q9qgBGH9LnTHlYqts8j777sgts_vLrGebx9P_FcmYY
Message-ID: <CAJSP0QW7DMpW9=dPXZmB219cbFVm7nUnuGtqNXCeazT-TTC1TQ@mail.gmail.com>
Subject: Re: PGP keysigning at KVM Forum 2025
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
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

Thanks for the reminder, Andrea! I will come prepared and am happy to sign keys.

Stefan


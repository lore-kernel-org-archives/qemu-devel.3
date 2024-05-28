Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D284C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 01:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBlCr-000644-EE; Mon, 27 May 2024 21:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sBlCm-00061U-25; Mon, 27 May 2024 21:00:45 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sBlCk-0004eU-H3; Mon, 27 May 2024 21:00:43 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3738690172eso1565205ab.1; 
 Mon, 27 May 2024 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716858040; x=1717462840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tI9I6u1VQya1iy09UqPXi4TC8EcIba/kIaOodkYl1tE=;
 b=jQd5pYUWmGnSxKMOQfp3qt4867eTwoTZ+aBAtJrlmLZ8Do+hoRP/NQwAej0vtsEj3a
 O+3Zsl0vKOa0CK68rmsiQGbTFYrC4o+Zvvq4+3z2xitg32NO/mdkV1QvweOMKVnB2gGn
 Q+0Wy3PJSg+uj1Y/GtiyUTyGtzqRzEYpHJ7STwASo2r+Nvxn1XZdh9OI0EjW2QsAk0mw
 iqlxsHlNzt4ZiPjQhhJDwYHvMUzQQpkiPAAVN6dcoN7KI4STnMAoryyVY7kBlJ+hYtGc
 RZ7+RjhQC0Lj24ltZEb/7X5QrdEo8XfTSjd3jCwSrtZlW974OW3Fbp3atbCJEcZG8DVS
 z3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716858040; x=1717462840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tI9I6u1VQya1iy09UqPXi4TC8EcIba/kIaOodkYl1tE=;
 b=jRj93yH0w7XjlF9VcFipcYzmaNv11STWMvrYoaxSdUQJpksE6SgnXrTcx+spAKCM5o
 jSEXRgm2nDcHx1Ljo2wEPiRnZffrzXQxa0quFBhkI1XzQVdkgpMMgHFdkVurgn2WgkvE
 6CFF8iCwfw26p3y1k94L4GqdErdUMVtQ+UH8OoaOTk8CsMXoHZImcdAzA3Cma78CMtqD
 RKflwYzVu5dU3axpZvXEl+rXRs4C5xeKHTbK03zavnK4F0RaZ1tbo5n3k61UHvzAgfo1
 VinKhdXTb67n1yBkE3UsYSVTkiAf1U5FEFWnNVcOg6RLVTxxZAPJn2nJ50zDyrMOuBSO
 CjFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHKyhc5QPTipjJdd0qy6gajJ6HFg0tNJrf+Uls5SIKboyhzdde7Oi01BBG89I1i0L10z4B8AUWSvfbQyCGPuuFDv302Lk=
X-Gm-Message-State: AOJu0YzqQxq7vV5QFGQiL3NrOt9cBzYyBmAoIZRS8fRwcZHspFvrcs3x
 oxX2CYqHUaEJJHB9qWMzwWQBNpSjvEKMHzQ/Xqa/3J2toFiPxB85CSF+hQ==
X-Google-Smtp-Source: AGHT+IG6zyPmYt+cHX9prq6E2+NKaDlI6+gySCFSe0bs5RFYcdb5ms01hwEjklHb3dHDHcrbs/vBZw==
X-Received: by 2002:a05:6e02:1567:b0:374:62d1:1472 with SMTP id
 e9e14a558f8ab-37462d1175fmr15454335ab.2.1716858040249; 
 Mon, 27 May 2024 18:00:40 -0700 (PDT)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6822092a66dsm5581437a12.8.2024.05.27.18.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 18:00:39 -0700 (PDT)
Message-ID: <dd406b1d-94d2-4b4e-8053-07d8237994df@gmail.com>
Date: Tue, 28 May 2024 10:00:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ufs: Add support MCQ of UFSHCI 4.0
To: Minwoo Im <minwoo.im@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, gost.dev@samsung.com,
 Jeuk Kim <jeuk20.kim@samsung.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240521110544.258772-1-minwoo.im@samsung.com>
 <CGME20240521111643epcas2p4ab1c2610d26878c405288e9006bc4f92@epcas2p4.samsung.com>
 <20240521110544.258772-3-minwoo.im@samsung.com>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20240521110544.258772-3-minwoo.im@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Thanks for your contribution!

There are only two minor comments.

Please check it and send patch v2.


Thank you!

On 5/21/2024 8:05 PM, Minwoo Im wrote:
> @@ -1288,12 +1717,21 @@ static void ufs_exit(PCIDevice *pci_dev)
>           ufs_clear_req(&u->req_list[i]);
>       }
>       g_free(u->req_list);
> +
> +    for (int i = 0; i < ARRAY_SIZE(u->sq); i++) {
> +        ufs_mcq_delete_sq(u, i);

Isn't it possible that trace_ufs_err_mcq_delete_cq_not_exists is printed 
even in a normal shutdown situation?

If true, please fix it so that the ufs_err log is not printed in normal 
situation.

> +    }
> +    for (int i = 0; i < ARRAY_SIZE(u->cq); i++) {
> +        ufs_mcq_delete_cq(u, i);
> +    }
>   }
>   
>   static Property ufs_props[] = {
>       DEFINE_PROP_STRING("serial", UfsHc, params.serial),
>       DEFINE_PROP_UINT8("nutrs", UfsHc, params.nutrs, 32),
>       DEFINE_PROP_UINT8("nutmrs", UfsHc, params.nutmrs, 8),
> +    DEFINE_PROP_BOOL("mcq", UfsHc, params.mcq, false),
> +    DEFINE_PROP_UINT8("mcq-maxq", UfsHc, params.mcq_maxq, 1),
Please change this value to a value greater than or equal to 2.


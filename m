Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9452FC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYUv-0000tV-1j; Tue, 06 Feb 2024 22:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXYUt-0000t5-Bt
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:21:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXYUr-0007PL-5K
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707276072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I8P++wokhLYvdZnN/0j1AcWSUh+yIkQj0FrsycXaoRs=;
 b=X6ZY/dY3+65Y8LG9iPwPwZVxEFk7kcvAr++UEETcJCf6fbFXTWQqSGEdVlqoaIHGJxoPtY
 9Ku60alaJnYGmicnx3REjxWkTWWIVSZq0e/H9OquvER0RvvbEDVDh4sC1tbn+uQ3CzCJFf
 IUOo2CJHYjxd+xENofDupAMq2tBOrkk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-fd40ZFCvM4as53-aSBHzIg-1; Tue, 06 Feb 2024 22:21:10 -0500
X-MC-Unique: fd40ZFCvM4as53-aSBHzIg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3bfde273841so96556b6e.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 19:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707276070; x=1707880870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8P++wokhLYvdZnN/0j1AcWSUh+yIkQj0FrsycXaoRs=;
 b=krG7Pys6kcPEq+yL2TxbsgPNHSWno1KIqbOGbzpBkx8eGDqnOjETqLWdX2N/uiC9HY
 1LGt9vHUJf2yoC19lUXXkPFVAO1Z2zbOE/YPLFdS7mg3Ll1Rv3Y+xdTnODnrkS4rMiEH
 JuY3tcH8jgMJSb9Fre8esmOMCvQAKyDW4q2/7hWMpaqB9sexwissrBhbVIGrwlsccgYx
 XmGMWInao2ER/ajC9mqiDhJR8yu6NWyGpQ6Ejle1PpKJ39gc9ADIUapxMtBmAbRIZKq7
 DT1e+T9Ewe8T5Ww2uhCSUokvq1ojBKJ7OSW3tq2PV0sV6L/1ODis9VK/MQ0f5Vd0lcGc
 mzQw==
X-Gm-Message-State: AOJu0Yxqe2P88OF24ELOSBxopyET+wuQyUa09Wdl56uwRQkckH8C7biX
 2P05T4C2Kq5NO8Yxpah5mn0hCrNMj376W51vdlAy7ymiCYm0zugsk3IPA48O9Eks8ptiu9kqvLr
 H+a2U+3pbZRHmCKPrC1+qdSKU2D5GGYvtJcpf19vHmdu9x8PIYphI
X-Received: by 2002:a05:6358:7e14:b0:176:6149:5558 with SMTP id
 o20-20020a0563587e1400b0017661495558mr5181214rwm.1.1707276069905; 
 Tue, 06 Feb 2024 19:21:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4S9NyeSb+igFQt271znTb1Wh5TdtzYTWr6wMlhGWEwxkk6Fo2zR69At7FtXkIAW0P2P+sFQ==
X-Received: by 2002:a05:6358:7e14:b0:176:6149:5558 with SMTP id
 o20-20020a0563587e1400b0017661495558mr5181181rwm.1.1707276069584; 
 Tue, 06 Feb 2024 19:21:09 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXd704DDHmrD4JbygLyd4INq2k9t/vcZxfIdWA+7tuNmc78EmyuXxRgqJg1DPmNth3kwJqugCnxhAw4RipBejjT6ko86qSXJN4lvvyayAmF+MdQHXp9qyrhKRq79wOa8PTX2M8KU+fEj7wFl7DjsPrClFqk5/UGwgvAHnYPRDaeaTviVtVRykTFsJD9uSLAiK7KYKUGyEMWK2NKOp9r4a2pA9dQAmdDmcUaIaW57S5sHggwrgZDTQ8ojpU1PJG8YXQsUbsiy782RvsTJsXW0XFAeD5AAaOI5nSTLLjhzD58fPg14y74XHSPvxgG69/vdIRyLlc+hql2zmiMFzEZ2E5SK1mHNX1MLPQS3eYgYFotWIJVmlCthPDP0cvUaYj1AA6AeC/kLibClKKZQpbxJp1rdOahjPXCUQlq1mmzK415OJ2gp1p9soqdzzIP9soeuOc2YD3OnysuhIJ7xiCj08BMkSVmfHQ2Oqdd9lJqIoFtrzCt4ACIcRlStDZfpgepIlorRsS2nPGSIXWJfWezJw9w/l/5NFLRlxTFv9JscqKAFhwSQayKQQAYYuQJHqFX5d4BSsXW+gV1VHzJ3G2i83q+aT4fk5izB3Mr6H6/hyL+FbdvI7GCd5UToF7TQ0YaqJPZfWbdBV26TlLcb+IfMTJ81xr1o9oR1Tkl1UuHwnZCQs9bKdvrkBWyBLmgFsZ2bVypEa8P3ncYsxI98jUtAFH5MR+G8qCdvxnniyA8hfXuzmMngW433oXm+pKizwxMwyU4QXrp4smpydXlYQpJgik=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t19-20020a056a0021d300b006e04eff6323sm268732pfj.53.2024.02.06.19.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 19:21:09 -0800 (PST)
Date: Wed, 7 Feb 2024 11:20:57 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, berrange@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, fan.ni@samsung.com,
 farosas@suse.de, hreitz@redhat.com, jasowang@redhat.com,
 jiri@resnulli.us, jonathan.cameron@huawei.com, kkostiuk@redhat.com,
 kraxel@redhat.com, kwolf@redhat.com, lukasstraub2@web.de,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org,
 pizhenwei@bytedance.com, qemu-block@nongnu.org,
 stefanb@linux.ibm.com, wangyanan55@huawei.com
Subject: Re: [PATCH 00/15] qapi: Require member documentation (with loophole)
Message-ID: <ZcL3GfIZj-GSLX-W@x1n>
References: <20240205074709.3613229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205074709.3613229-1-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 05, 2024 at 08:46:54AM +0100, Markus Armbruster wrote:
>     qapi/migration.json
> 	MigrateSetParameters 1

It's tls-authz.  I'll send a patch for this one.

Thanks,

-- 
Peter Xu



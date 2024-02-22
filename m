Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE908C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 16:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCMm-0003xI-S3; Thu, 22 Feb 2024 11:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rdCMk-0003wz-Sd
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:56:11 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rdCMj-0005O8-Ec
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 11:56:10 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e46e07ff07so3020589b3a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708620968; x=1709225768; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YPbA6TpI1b5Y1eRi4qIE3WJTJORdzGj63jllScn37vE=;
 b=Mgr7C/3vkzN9rfNLAxeXrl7mOuVs13MEe7tp2MUjNZT8wpiyY0evpyivA4kWgKr1xV
 Xd7Cf+DbvnKlahGbxbuY092mZKAYXDqcPUBBWvRICkruFLmI0Fk/C7qUdm4lskk3ryR1
 WwjNzk3OYXEPkdFqaF7zSIxpubKvLwFvi6p0Fp9SqZYQAu4DFVLZfIA3D4hs5+P6ZF7E
 ur/QZlzijw6We+oEJ472jpn3ukFBgTdxbEt5fCjIPW0/IOREqCXMsB4WPWeWOdn6eq2y
 W+LTiDJwSofoOIh07BZ1iOYFCY1aOXTaX40yeIj9kgbb3vO+1ijyJQ34QXejX3vSzD1/
 9y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708620968; x=1709225768;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPbA6TpI1b5Y1eRi4qIE3WJTJORdzGj63jllScn37vE=;
 b=QqePpcEqN4YrgmJCF9ZfUHWe/fAm16BYwDe+/xlLckE9WXPsNzOd8r+lcVlapsQF9j
 gMd/dBY9hPu+ZLo0van1sreADtaatA+npP5Isvlg0yLhPf/TQ7+uR9XqqUQdx9TSKkvG
 2/NukZ6pLMMcviN3tMty/rZUuGMwhzfXfG3nl9/oQZdpZmBbk6KIbHunkoPKFKXcIoaJ
 W9bGdjyPAi6tHxq7hsVs4uW2kGrKOUOTeRcvOpfCrfyRcwkVoThwNBaSs09jjkTj1yBJ
 Kv1/ZpIn1OPV2CjsaAbOXxPL+EKaIP5tUylucwrmEZaEHPI7IDF6I6jE7h4OuGy/RDTY
 1nLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhoeF4H4DhMBzbONs5csTfIdMjGT4qcCxYEYmfnHnsy4N5HYtLr3ssW17QzJknFLLuKzX6DBAoSxsGogZrfaDyDCf3pkM=
X-Gm-Message-State: AOJu0YwuZOa+7iOTWrzy7uPBfSIctO+hCnXdO1y0TffbQ2hTkYodG8rl
 UgkBXQgoyaTCBFWNqxBMRByd7ckPB1YCDzoAKtzayuHkJkG8d+WP
X-Google-Smtp-Source: AGHT+IEv7YEBfHb3hssf0AOzxXGHxCT8otNmE4GpADhY5zDL7NEkPiFEJ5yzs7z4H0LKY7sMxrxNSg==
X-Received: by 2002:a62:e10d:0:b0:6e2:9ff2:19b1 with SMTP id
 q13-20020a62e10d000000b006e29ff219b1mr13800579pfh.13.1708620967919; 
 Thu, 22 Feb 2024 08:56:07 -0800 (PST)
Received: from debian ([2601:641:300:14de:f32d:6b5:d03a:44f])
 by smtp.gmail.com with ESMTPSA id
 a6-20020aa780c6000000b006e04ca18c2bsm11159868pfn.196.2024.02.22.08.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 08:56:07 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 22 Feb 2024 08:56:04 -0800
To: Wonjae Lee <wj28.lee@samsung.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
 Jim Harris <jim.harris@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 06/10] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <Zdd8pHzj38BsJwsL@debian>
References: <20240221182020.1086096-7-nifan.cxl@gmail.com>
 <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <CGME20240221182137epcas2p276d22514caaa9412d0119ded6f9a63d4@epcms2p3>
 <20240222092252epcms2p389f3b87b6ee63cf6a0e95aaf8968970d@epcms2p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222092252epcms2p389f3b87b6ee63cf6a0e95aaf8968970d@epcms2p3>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42c.google.com
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

On Thu, Feb 22, 2024 at 06:22:52PM +0900, Wonjae Lee wrote:
> On Wed, Feb 21, 2024 at 10:15:59AM -0800, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> >
> > Add (file/memory backed) host backend, all the dynamic capacity regions
> > will share a single, large enough host backend. Set up address space for
> > DC regions to support read/write operations to dynamic capacity for DCD.
> >
> > With the change, following supports are added:
> > 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
> >    memory backend for dynamic capacity. Currently, all dc regions share one
> >    one host backend.
> 
> Hello, I know that it's too minor comment, but 'one' was used twice.
Good catch. Thanks.

Fan
> 
> Thanks,
> Wonjae


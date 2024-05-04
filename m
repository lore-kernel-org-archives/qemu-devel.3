Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F790C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 07:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s39dH-0003UI-Hk; Sat, 04 May 2024 03:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.muzzammilashraf@gmail.com>)
 id 1s39d1-0003J6-W4
 for qemu-devel@nongnu.org; Sat, 04 May 2024 03:16:17 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.muzzammilashraf@gmail.com>)
 id 1s39cy-00033G-09
 for qemu-devel@nongnu.org; Sat, 04 May 2024 03:16:14 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6a0b68733f5so4628266d6.1
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 00:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714806970; x=1715411770; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PK1p+1qJWoz1ucMyF4Cail2LteQAnBZaq0CXnpWo6ac=;
 b=QzQGAEStCibTJFz8aTZZ6/PqNEHPGAkIU4ECsN9YN1UWfDDamSwMg6DUTvkdllIrq9
 6stU1nwxZerd2orTwkLAexMxrwQ/wqBzCrOcgW5sAod3hgBdL6h0WRzZU4/InWJAtz0I
 ah9uySoyWH3cjoSUgKbC0PPM2MUXP5FhTGJs9V4SvQfjAV3KazmSI98F7Wm1HyRpijen
 n4epdlter2XsoIiuCcNQ0Q4u0sssTs2p6E9PkagRGg2KmrlxpSqil6PkhC2hr3XHMl4f
 ES6mW26QLQkSZZ6tI4rrKwfyFRESVe+iWJ7BykBDyhB3VzdrzTq3aWfwLkNJO6TziVlM
 MKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714806970; x=1715411770;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PK1p+1qJWoz1ucMyF4Cail2LteQAnBZaq0CXnpWo6ac=;
 b=ofeaYd4VTRYhoEo0m/6fmx3EaWJXGNMSs9IQbSLDYfZIJI2ENwjcrBBEbWLTsYrnqQ
 schZkyCw2Ije8bASqVvXYHEHccdN+EpAZYVgrmv+7GykgQKwUoVHulhqDE9YZj6tgAUm
 w10qcMsOVlKLaYDTbqjKkXxxDwVNL2rQ+D7Wxnn0XQWxe39EvQ4kE8dh24GV0tjH2Qyn
 IF6vKCbz6haflaScdvuSIpBHcQeXPHMiF6pR8X3PSp0D/WyogfrWtsdBeKExYi37qSiP
 fLbckiUdiJUQi6iaYPYf9GIIZRqLyPKMHCqlG5QCrW0Y11fTimtQ8R7TRny8KrwQumEy
 b8Mw==
X-Gm-Message-State: AOJu0YzMdThR8MhHHQsmfruxXYeSX0c2HyKYP3XxVWY1luuHuGtcIoge
 +QJG7YR8BhN0CiI0OxcPPzOU7H8sLA/LrSh8tyCbaJwAnIq9GEK2dIVTZUsvBjpxXkpwnmcuTfY
 7kOQn+wRpdBUIkKxLYmdDUQbyuUsf8fnz
X-Google-Smtp-Source: AGHT+IFWHVBnjmcKOOuSUL2C1zavr02T9u3z4zbj4LjpU5gk4kYJEDJ2Wkgu2YAXa2o4P4MpB5GrVK3QTYK+2+Jah14=
X-Received: by 2002:ad4:5f45:0:b0:6a0:a7a9:4ad4 with SMTP id
 p5-20020ad45f45000000b006a0a7a94ad4mr6300351qvg.7.1714806969850; Sat, 04 May
 2024 00:16:09 -0700 (PDT)
MIME-Version: 1.0
From: Muzammil Ashraf <m.muzzammilashraf@gmail.com>
Date: Sat, 4 May 2024 12:15:59 +0500
Message-ID: <CAJHePoZ=+vJt_8CC3eYN5kjfUcqQMRjnzM+xEfoBswq8-8JWfQ@mail.gmail.com>
Subject: PCIE Memory Information
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=m.muzzammilashraf@gmail.com; helo=mail-qv1-xf31.google.com
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

Hi All,

I am debugging a PCI subsystem. I saw callbacks registered here to
catch the pcie config read/write request at hw/pci/pci_host.c:201. How
can I make my subregion to overlap this area and How to receive those
pcie config read/write requests to my callbacks?


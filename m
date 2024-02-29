Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52776C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 19:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rflgF-0001Fz-RB; Thu, 29 Feb 2024 14:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rflgE-0001Fh-38
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:02:54 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1rflgC-0004qg-Fk
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:02:53 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc1ff697f9so12096345ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 11:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709233370; x=1709838170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwLlySPUaqwhZmFU87DIJhjN3TgYNa8Nxvp5HLuPyAc=;
 b=YqOIY+v4grOnieDUuthppKwdZXKp+V9LCTWFI6s9g7ibOr0Z7WAMaZfTVNcnaYDJ+8
 26mgka00sFGGM2AFRDKZYLJcsd7v3TgvotaEziuAZGDrOCM6OWwBcf1Mrsc8/HA+wLUs
 PYKkeqBllUyenb5elOjEy7oVagljdSq91CbguLOFp0X3zUjVa5TGD37sjJMhZb6xCArI
 6HnfYIk91dHqYh3U7RPxLv8TN8SBEjudq98M5cIoFtxIcM/QYj8obdOeweolzmNtw6aE
 F+vmblJz+PZj/p6gsmNlGtAsgxuSjQaB/Q3gpGCxiKDpdPR75TSh24A1CWg5S1A154rT
 m+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709233370; x=1709838170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwLlySPUaqwhZmFU87DIJhjN3TgYNa8Nxvp5HLuPyAc=;
 b=uTx8jnVsTGO3ILKHeuKAXHNEIFaYb8in2hZ/Dmrf4YChoLkEDw7bPdLTH03rcHbDZl
 u3ZncaUSYC8zbWJPJ2TmP/RSsqCTvJDG4PdSz2bPMqkgSRx7lqgFDZcdD7uChDR/iaY3
 HZpklcAVaLK97UReZ6cvekDbZ8G7Ip+9mvcIzydA7xkFKuiq2oM4ObjfnkV4rrj9txqB
 lHsRBElYr2uXTpb8iH2EQ3A7xMzoNTnVHEcw+TxFdf33H2ye+nWELQqHXm0wj4YExWYl
 m4OUtzJLv/5TGRNrlDUn9JB6P7q5tN6XJ6hh1O0kcs5mpKz6ujsakf0w+CrBF0SFkOI4
 zDpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIcTbSyOtJkGans8o8uOneKBBNplIR14L9qyO8ad4EeAmzuyDXzBFRAnSI8AdX+zryBvE/LAyBjYwtaeLQqCTLWZJOZV8=
X-Gm-Message-State: AOJu0YyVhRYg5dVgegTnI6OXyjn1xF0C6AHmAxorEU3R4mAN0KyMgXuo
 GdZLQjo5T7lvWgy1VcCKj/kAthLvV4RYMfodLHnXxUjUronHERGMq8OXSdC4DmI=
X-Google-Smtp-Source: AGHT+IGZeTBSskbRNPPZU1n9Di3yKLdbcque9deNPoYGFKo8uG+o9i5dyQ8SvB28yZr71GQvIyY1Xg==
X-Received: by 2002:a17:902:e74d:b0:1dc:b531:82c with SMTP id
 p13-20020a170902e74d00b001dcb531082cmr3257194plf.52.1709233370526; 
 Thu, 29 Feb 2024 11:02:50 -0800 (PST)
Received: from valdaarhun.localnet ([223.233.80.13])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a170902684400b001db337d53ddsm1868244pln.56.2024.02.29.11.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 11:02:50 -0800 (PST)
From: Sahil <icegambit91@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: eperezma@redhat.com, qemu-devel@nongnu.org
Subject: Re: Intention to work on GSoC project
Date: Fri, 01 Mar 2024 00:32:46 +0530
Message-ID: <2315192.ElGaqSPkdT@valdaarhun>
In-Reply-To: <CAGxU2F4jx5m5_ijNoWZpVK_MepvtDBY8L70-dSZmRUPmTskCNw@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun>
 <CAGxU2F4jx5m5_ijNoWZpVK_MepvtDBY8L70-dSZmRUPmTskCNw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

Thank you for your reply.

On Thursday, February 29, 2024 2:02:25 PM IST you wrote:
> [...]
> The first project is for sure related with migration. While vhost-user
> memory isolation is not really related to migration, but both are
> related to virtio devices.
> [...]
> Yeah, "bite-size" issues should be better to understand how to
> contribute to QEMU. Feel free to work on any issue, doing the work
> or helping to complete old patches.

Got it. In that case it'll be best to complete the bite-sized task related to
virtio [1]. A patch [2] had been long ago but it hasn't been completed yet.
I'll work on getting it merged.

I have already started reading the documentation on the migration subsystem
and the hands-on blogs in the project description. That will help me get started
with the first project.

> Feel free to reach us if you have more questions on the projects.

Yes, I'll definitely do that.

Thanks,
Sahil

[1] https://gitlab.com/qemu-project/qemu/-/issues/230
[2] https://patchwork.kernel.org/project/qemu-devel/patch/20220414112902.41390-1-codeguy.moteen@gmail.com/




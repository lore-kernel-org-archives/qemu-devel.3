Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA79C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 21:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsTjO-0000Uu-7L; Wed, 12 Mar 2025 17:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1tsTjL-0000UH-VU
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 17:35:12 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1tsTjK-0003sW-7V
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 17:35:11 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-47681dba807so25291cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741815308; x=1742420108; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V6+oJZHR1yLtFnEShy2vlq1+KUr0dCZUURfv4LrRYg4=;
 b=jUURYeIrs7LesLka5zL22NCkdF1r5DUMs9W2xh1cP0VltbUVyiQtoA0Rc979rqnOPR
 0ywGfMhcMpOTzi9CKO4w0D6o7RFL/NfXYPDsXFaUs4Mb5yLf22qujabyaZSasccKQHtR
 4b15Bjf1kRnHU4OFTfP7pd/Z0pod8C8V41fAkkgvFshEmjFeSI0VtOW2SOIxHlzPhsNZ
 ySapgzpm4catxOqcRGX3izvql5AGyxeXvZ41qi3Fh5R6S2dDZmjhMe3CCtX5/0mVSXRO
 UEsXDdADPNQDU/qVdlLwUc/+XWpM1OI5knA0NH4VHNRQ7dcRsHOq/9VbYLTfJTx8xqof
 2/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741815308; x=1742420108;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V6+oJZHR1yLtFnEShy2vlq1+KUr0dCZUURfv4LrRYg4=;
 b=NFfRKy8TCNyDJiPrY5WlO4X76uJNZzp7ivOJpNwERKVlJdJDpiu3RLOcxcPqfcCvy+
 Iwzsi452/EC9FXl4yb94vDz1h5PrtftdFB65tm4SGMWTDCSZZED44lXWJIrt1+iviNMq
 GeYw1/+kH/DeMaG1LjKlroPCKvF+pMYPuzp8/au0C4RMYT2qr9afiw+dpEyQ4e68RRsk
 4mo1yh+M7ORJnUKltQMZYDGkN1lfYrxT30JuXp5LTYtG/Fs0mhqdQVOrjYQPbde3tjCE
 lg9x7kdqvd2E0ud/rKBSsDD1bSfdIk3CvvKDW/vwBiXC+anR8ZGAoX9yTqNd24AabC0/
 pUeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUVMBGIjj44+z/goc7IfAm1F6Srhu2szFqZPGBbRmvdPp1eXhwLmP7j2v2yCY2b3vU38AGCQIUfMIh@nongnu.org
X-Gm-Message-State: AOJu0Yyf2bm0lcnb/wIRwU/PlE1vOqZYOb6c8RPEAvvmCX3sIyRtuq9k
 dpLcxlEASZhGfih52jMx+f8qaTMLTSeIVbYUZxVHItsLbKAzuQAOOVbr5DwQVvjj/6lOXokvGGh
 o8DUs+/LJVgft6EI9qHCAylJzvDhsuDOIHbGO
X-Gm-Gg: ASbGncvgqsqRhPNDBSSZqK0PqOXUvNOwEXHiQbf7YJFAS4XWyXJuYu80ZocdAVEVI2E
 NIF6FkWn2kWfn79wVq7SWSH/XFC7/mS1K2J7FL+8S7yLtoMH3ES4w4LbF0D4m4YbGiIVoVdi/on
 ZPPR2QNJ55+++JFIDVRUcbk1BFYVsUWLpivJ4DQ8MCVbyBRvo9UcOEmf8=
X-Google-Smtp-Source: AGHT+IEkCf+vRqMmCU1fSKxW8Ipi+3AJdaatJk0u6Vch3E/ieZFDyz1UB0FJ0owimxKwayAqGBTNeM3kx6R76IXhzxw=
X-Received: by 2002:a05:622a:1a89:b0:472:538:b795 with SMTP id
 d75a77b69052e-476b9318984mr825471cf.22.1741815307585; Wed, 12 Mar 2025
 14:35:07 -0700 (PDT)
MIME-Version: 1.0
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 12 Mar 2025 14:34:56 -0700
X-Gm-Features: AQ5f1JpDmfVtUWdc6wvtQp4IDYirhJlGDK7BcTbS9D_1L9Y23uIPw-jne1gz7is
Message-ID: <CA+QoejVvkwakAs-76i-gaYd6b0RHKGMpw3+4UL9krZDrxbmWBw@mail.gmail.com>
Subject: Q35 PCI Device BAR Space Question
To: mst@redhat.com
Cc: marcel.apfelbaum@gmail.com, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hello,

I was recently trying to boot up a q35 machine with some custom PCIe
Devices that require 4Gb of BAR Space, and ran into an issue where I
cannot declare the BAR Space of a device to be above 512Mb or the q35
machine will not boot correctly. This is true even if I try to
increase the BAR space of the PCIe Root Port, so it's not an issue
with my device specifically, it seems to be more overarching.

Is this a known limitation of the q35 machine? Is there a way I can
get around this to declare the devices properly?

Thank you!
Nabih Estefan


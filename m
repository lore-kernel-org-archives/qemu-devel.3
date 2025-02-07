Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35B8C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPVf-0003Q5-1O; Fri, 07 Feb 2025 09:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tgPVd-0003PO-KX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:39:09 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tgPVb-0004GO-K0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738939143; x=1739543943; i=deller@gmx.de;
 bh=2Rwxgp3DAHHPSt3875K8z/0HNFOFogd2soTYokRtJiA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RFy1WVHKTahdbnjctGHAp9cX550ucm9pqfyJuM1Hh7vX4O6Xu1p6vewF67/qe50r
 6ek6YrN6Gcgy0eZW0nT8+YM+cHB7FMXqfsa6x8ekcp95bVF/A7zMaQX1TpoKTkF2e
 y1o5aRJ6b2M/CNkC2FuUebDYpGpDxg4L1E210ZTsgoximd++HDwWOne6rFxCeuhyC
 5gE+UTVCEMaaXidF6Se6WNrVjJ/6BzywrGiGK2wWxAuRQ/n1F5yIiI9SSmUTA6zK+
 1CuXFGlfVY+slET/LIgugcDGFDgaQbh1z5HZpxau8WPip6r51AWfdKd1mS/7E24C5
 N316nSNnbswIMeO/SQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.6]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVHU-1u0GmF389I-00XGO9; Fri, 07
 Feb 2025 15:39:03 +0100
Message-ID: <74d703f3-b2c4-416a-805f-61859a5a4e70@gmx.de>
Date: Fri, 7 Feb 2025 15:39:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:16PpA3h1wDyHHAe1mJ4dAlDfbDvZCK2wlUPHSjtusr/uETOcSrv
 Id5XcJoMgXl45tYkULss+pU+ZJXauztYtB6YKSrl+bKaEfZ3nq1Y+laddmJOlVmm+5zav85
 /kASC/V/Uwk/7cfEjAFTBBfs8ERo5SEvdATf2duPNnJXXy3zSvm2MYGxrVD0cfRqMhtu8s5
 zaV1j5PWAuEDWrLTEXTTQ==
UI-OutboundReport: notjunk:1;M01:P0:8sbFesJeyww=;yO8W/aOK3TZyDEAMh/8f8OjoGau
 BIdyG6gq11icYhCoOVIrbgYRwsEfsN0BKp11hbqlj+zpUV1xytXtzrZjuc5e5tS6PfOi+mKql
 eDDay8mh+5AVfndWmjMUzIhE+nor28uk58sQSGIPxmyVK6KFYXPs56+tREX23TVuKYN+CoYCr
 zSpdKxq7hZcwMKyM/xQ0lGmA3aBpOzV8zLMb7gm7xYaprk7nakZeBAlDvIrzLwHjld7JbyJl4
 dej8UuK6jJkXl8A4XtbkGZ5xhUYeVBt7QZHd/cj8SdxniKLZ/5zT/6NRDSDjfSuB6a5beokoi
 rlmnHI3OtzdProocT/5OTQP+l3r2cgh3R/2X4Qx+Ed8kpfNi5huPAWBVmxJmf3VcdXWcla/Oi
 KhvlBX1/hYyWX/lYSnmXvD2QDmt2h+9rJ3ivJiuogSBmyeZzoN8ZdJn2udC/mdGYszAQGqwan
 jgU0y8xeiihUpyd2W2Z2Abcqz1SpE6jiG8+8acJsIKQC0FlG247j6RdITAYQ5ZvZKFW1oBLT8
 NnYOXfbpANrIqJZjY9ae1bw2XxV4P/g0hFQ0lC56J+VVyO7zKphOvnkBOojtwDldwXrtpn964
 LdsFK3oXx7OQBhsMrC3xR/sClv3jCQQ+bsfHXUCiiH1MHNAi+YyqvWhlMgek+v9qIWEzERCQE
 KCU0yAUESQyXrWJ/F+Ok4hOuJvCwj927loKDRCQyw0pkRBpvHOjyov6DWMDHOlF1Ff7BJfyVw
 Sx4V2QFv+pS+a4g4U0pK25js39iSdW8iPlj31E64dyOhbtBzpFerBzjd/au2z/pz/XNOY0Xuq
 yyEW2bGyUxAUFSQEHtAoHjguf4B6AaxUHGVL6dwieho7hHFsgaaqfrkyQZTKxuuq4ly+K4sCu
 H9BGkHshabTcwe5np97XOOG8wWy6ODyqqcsPnlQLP8HyYMilbzcw1qHBMSeP5a7iESWSCwK5v
 X754deHf+jHeyph2aq56kcOE8T7V8ld76l+9IZDAq4FAkUEfihaSPolwZf7UorWRXooVuBLZl
 /pTYhzHtgfhnjDjbzUh/2BDpzbknPJGNwR62ssQJH9b6Y5Wg+chOB6JaOSHY7MkLHFjuZZX8X
 wTUpg3C/lqOFgMlexH2GGR7GbM48inSKh8hwFIk/sVKY1Yg5gBf7aFqddinu8v871g+gVF+ne
 Aiqc/2+Ffd8gsEHOI7sg4UUUW7EW/mMjoTQGcomGQvYjjO8B4r33XEVqw+WBrNRyUqMCnbQCn
 iPdqkG5FgSQ8PtfwwVWj6TfCvvAXnt2FZF4KwIn97QdYRADMf4JExiaHNBzGk0Uud451/OhKG
 SiUol6oEnf1S9sUZSfGvAu6kU16lpBFBQRvBiisIgcwFuAfCCbIk5wmX6pJj5nf4xYwhl1akQ
 xnAYO3SE8bEGjn82MZR+3ac6wzgcvlGMMsmCPCtmTF2G5LMOeQhSsUhleR
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Stefan,

On 1/28/25 17:16, Stefan Hajnoczi wrote:
> How to propose your idea
> ------------------------------
> Reply to this email with the following project idea template filled in:

Would something like this be acceptable?


=== Develop a driver to emulate an existing network-, scsi- or graphic-card in software ===

'''Summary:''' Develop a driver for Qemu to emulate an old network-, SCSI- or graphic card in software

Qemu allows to emulate a lot of physical machines. Beside widely used
x86 machines as used with KVM, this includes historic machines
based on PowerPC, Alpha or HP PA-RISC CPUs too.
To allow to emulate additional specific historic machine models,
drivers to emulate specific hardware like network-, SCSI- or graphic
cards need to be developed.
This project is about to develop such a driver for the historic
HP PA-RISC architecture, e.g. for the "LASI" network card, or
a driver to emulate a "classic" first-generation NCR 710 SCSI controller.

'''Links:'''
* https://parisc.docs.kernel.org/en/latest/technical_documentation.html
* existing Linux kernel drivers

'''Details:'''
* Skill level: advanced
* Language: C


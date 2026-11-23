Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029F606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iXbQBMfx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVSEo-0003EI-UC; Mon, 23 Nov 2026 06:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSEm-0003Dr-M2
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:29:32 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSEl-0001jj-2n
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:29:32 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67db6d4054eso3447754d50.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 03:29:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795433370; cv=none;
 d=google.com; s=arc-20260327;
 b=XWTwTCg04QUW+LyEPHZ2FSKDVgbzvVAr3j6Qf2em2JPdb6LsPseaS1fWaTQAElW8bu
 I7pwfox5uHDCTMnTm4DucrNWJXTWcRNlkHtwlsCgqvbQlXg+hJEokjI54xuMwHgQFVHf
 YLRNjqcX2GbnHct6M1gCr/z3LWspaJPKpP2aS8jJKggQCggQaofzFOCZAsfrACxC8FTg
 ue+/nZg4vfZcaHoiu+SD1xvThNRTd25OYh/jb06xohFAl6wVe28oOjBgTIR+e7uqHdGG
 PREHpUDFlNmz++XFD9yquTHI9piymd1qURA2m2LxXzvUPm/P8JKttOfYU6eBcKX+1dRM
 wJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3RdOi4wLqZTBwfgnNypVHtyRHSmC50Q3tV7RvKHQy60=;
 fh=nIsHTR/B6mc98C187SbmJh4x+ZkzMioxCZFk0oB2Ftk=;
 b=dWbqTwFkTo4Nq/8wjGpxlxo4OC/UwA+dZJB7jR1Aw5XqoWnfGtoqgGoy+Jq1qqGwar
 IZLJfsy3gNYI2Zlk38lW/iMdYxT9GOiCzN2YKyJaDp6WVM+Y29lj92rFsY5EsCeALXQi
 JeINKXyGyMZH6t/mzU+hBWLQYbl4HQvsJePPzCII2o5ibB83qFzvMNy+1iDMUMkLOfXp
 pB5f5wHnktlImEX1jaYF8y5SJCTVsD6vz4ca0JyNWi5iq2s/bRJnSxDYhHBIecoDNtrT
 y40w70E1qzAXKh+BcVJ5OtRy6+Z+oYmsNOuQtA/SislmDOYgKmiDRs7E7PE7SVPdmUSe
 3uIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795433370; x=1796038170; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3RdOi4wLqZTBwfgnNypVHtyRHSmC50Q3tV7RvKHQy60=;
 b=iXbQBMfxYuY8ln+qsgw8/L492XuLxmZOmPrC6+kdmkFhuVGPc/1OHIrS1uIP7uln14
 nUAqywI/dZRo11QmKwbNLFJKKQaqksnjhzvk9AoWf3x2rilyP9aOrjF9o2dSOnFW5V5e
 UNq0ERNqasQCplmVACCj93zHlAM2cyaxS6Q7tJ/dkSmX0D7zPn0eYU4WHlzM4gwRUtGX
 FfVcKWfi+me8StIO3bCk4cRt1Rxg8z/D42f8/0MWsOrsajXb5ycnAh9t8cZBS2yv7n6a
 4HwbCWaLdjjfEPH3UpCKen7C+KSDr7zEa19Nal0uI9gvmRyeyHwcvqd+gAHWE4eRwGNH
 /Avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795433370; x=1796038170;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3RdOi4wLqZTBwfgnNypVHtyRHSmC50Q3tV7RvKHQy60=;
 b=CzSJR/KJnzik1v8xBfoJcmVpxRGvYugidhU5o2+1f5X7QVw78qgXL5wj4XUKjPK8ag
 X1oJS5Jz/n9QqhWzPIrCXBd4E43xtked5W6yjHVNHs5xkD9Waz2Dv0I4IGogbmxYGrB8
 OhpgCs80hr86K0yzKTJ45YnjiOghpbZnFQw3aYMWQt+rjW3O2EnRF4z/TziuvHMcjz0Z
 MQDtJysWrfb9rSBd9lFHt2WpGBzx+B/+tJwccFrqg08at/dNbR+OceV1KatFp+xLEMWc
 FbyyBL2zaSMjX5KHYhcD+cCvRfarHQYvopNFVoqxOHQQBY0tuZ8EYp4e0mmn5XoYKpeB
 17nA==
X-Gm-Message-State: APuU4Z8H3lWrng7WquDHYLsp1YNfNcV5FtUC5sQ21rWc6UutRtrMuBY/
 +aMIUyngG8I5t7+YMDMTJXrGiau6/Ug/mw35R1qSMxq4TCmOwKAMUEHu+hesV1tLsUDX3/j97ID
 PmU5yuyVkJVDK6tfoGaX8dlUPbScL6i01mM2DMAk2IA==
X-Gm-Gg: AZFdTZeQqG0FDfO3HfJbnV94gKvOEOfxbI2ICvp/3L+jyjFRf8QDINZvm9YSJLy3mT5
 WKUMXm8JSGYQwvykKMvyC9IYi4WObuPHUVr3R21hkBDb162k+De09TPfe+7bmobDAOYUwpSbc+E
 Zww/2N8wYHSPwoZhfAGIaV84R03JfHr97iJe+T8wE3zNrvklmATty1CGvAjm7kXATdLfeWPsR1P
 llYD3uNwrIsoV14/TecCWssLaF7IjMSXrVp+p9ubNwamDb1vQLg6vA8WV8S5/ByYE4AQFs9fBPE
 SFvjb+DkKgN11TbP9cSXf7wK14NX3WHqlvifsUcCnz27FJYmrcov0GZHIwRvCcq8cQe4dOM/R7z
 5+SMEHvlCxSSEErCsX8OtMcT+lMiWyO0TZoPuHFqHM1V8cCSu28L0t9xSGhdAdPBfCYzT4L/Cx2
 oh/N4mQrQKwAVEwFjiKXiRgqGFSPJ8YQaa0fh9EdjPh58=
X-Received: by 2002:a05:690e:1247:b0:67d:ebad:8ca2 with SMTP id
 956f58d0204a3-67df4410cabmr3993514d50.53.1795433369558; Mon, 23 Nov 2026
 03:29:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114132350.1456994-1-peter.maydell@linaro.org>
 <dcdd8f95-024f-46b8-ad1c-42b7c8a047d5@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <dcdd8f95-024f-46b8-ad1c-42b7c8a047d5@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 11:29:17 +0000
X-Gm-Features: Aa3M54rYqepVcl9zQWl7apkrlUHu9_Q-6J_WLs9UBLQiDJCmKKKUHoXc0B_-HGQ
Message-ID: <CAFEAcA8KK2=pm7oFOzqBxn+26HYNPTEHf6Wfjxu=xnotNMgWcA@mail.gmail.com>
Subject: Re: [PATCH v2 for-11.2 0/2] net/checksum.c: Fix errors in dealing
 with IP header length
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 at 06:28, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/11/14 22:23, Peter Maydell wrote:
> > The main point of this patchset is patch 1, which fixes a bug where a
> > crafted packet whose header fields claimed a header length smaller
> > than its total length could cause us to set ip_len to a negative
> > value, which then (because of a signed vs unsigned comparison where
> > ip_len gets promoted to unsigned) makes it through range checks so
> > that we checksum 64K of data off the end of the packet buffer and then
> > write the two byte checksum also potentially off the end of the packet
> > buffer.
> >
> > This is CVE-2026-127233. The code is used by at least xen-nic,
> > virtio-net and the COLO filter rewriter, as well as various
> > out-of-security-scope devices, though it's not clear whether the bug
> > is exploitable in all those scenarios.
> >
> > Patch 2 fixes something noted by one of the reporters in passing,
> > which is that we don't account for IP options in figuring out the
> > offset of the TCP or UDP header in the packet, which means that we
> > will write the checksum to the wrong place. This is just incorrect
> > behaviour, not a security issue.
> >
> > v1->v2 changes:
> >   * use 'size_t' for length argument, and drop assert(length >= 0)
> >   * use 'unsigned int' for mac_hdr_len, ip_len, ip_hdr_len
> >   * use 'void *' for ip_payload, and drop casts
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (2):
> >    net/checksum.c: Correct handling of IP header length
> >    net/checksum: Correct handling of checksums when IP options present
> >
> >   include/net/checksum.h |  2 +-
> >   net/checksum.c         | 46 ++++++++++++++++++++++++++++++------------
> >   2 files changed, 34 insertions(+), 14 deletions(-)
> >
>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Thanks for the review. I've applied this to target-arm.next as
I expect to send a pullreq out today.

thanks
-- PMM


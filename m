Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27E1EDF15B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 13:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqstg-00081v-K1; Fri, 13 Feb 2026 08:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqstf-00081f-Lm
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 08:07:47 -0500
Received: from sender4-pp-g122.zoho.com ([136.143.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqstd-0001h6-Ey
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 08:07:47 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1770988051; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=P9ZWrHnW1T+qycZQMpbvxxMG1R/w6/d82qeXY+OZUutgwibZZrGCDT7p1VfsKrwPOjcJfqa6/O/pXgBO+R5GK7HW/vda8m+avLe2c1xmTVvd0PSCbHxndK+QIWAZbMJdHgrMfZZ3E9YdAAvtT0xGvvhf57HCUKGLPyQCLYITGZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770988051;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BzcHuxXSlVCCDlOd5H9r5pmv819HDy4wD4n4TYjZENU=; 
 b=iSx2ij5T92q8R45ft/JRcDDvygGZumnYjZF9wJ73DQ09ocC5Br65ZW+numy/zg0/3y0VLgZ4gIvvRN5JXOCPoyexjcQM2busv2yAYnk0f+o5lgZBgxJyXyy8b1uN4QBb+AH+rh6L83SxZ/OpJqE4vqC3qy+QKKB53J+aucOq7zA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770988051; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=BzcHuxXSlVCCDlOd5H9r5pmv819HDy4wD4n4TYjZENU=;
 b=hmh+U0f74F5P9x7c4hE5+6OcA46Vewqttkba1YyvsrBMCjLp6BIx3RgtvTODUUqU
 yVsLP+PWAkuEonxz8tfCSO4OglfcjQRgqAYz/q0fWuI18biEz3Y5jXsDe9yHRBhAgrK
 mzsSFe/mU5sHymYQRDy8gJcDn8QMnlSbOg5DKnxo=
Received: by mx.zohomail.com with SMTPS id 1770988048950870.0447570321581;
 Fri, 13 Feb 2026 05:07:28 -0800 (PST)
Message-ID: <c5f46ee3-f1fc-44d4-8388-47a55f45eee8@collabora.com>
Date: Fri, 13 Feb 2026 16:07:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: "Michael S. Tsirkin" <mst@redhat.com>, Joelle van Dyne <j@getutm.app>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
 <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
 <68223045-effa-4319-817b-1a31f227c081@collabora.com>
 <20260212020117-mutt-send-email-mst@kernel.org>
 <f6d75a31-a72c-48da-a195-0a74b75b8596@collabora.com>
 <CA+E+eSCu93wwd_7EZ3ekjDj+URoNT+3YBJvPARfwB3xnj04EQQ@mail.gmail.com>
 <20260212190108-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260212190108-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.122;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-g122.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/13/26 03:01, Michael S. Tsirkin wrote:
> On Thu, Feb 12, 2026 at 03:57:04PM -0800, Joelle van Dyne wrote:
>>> Joelle, are you aware of this problem with the version that got applied
>>> to the qemu/staging tree? If yes, could you please send patch fixing it?
>> Unfortunately, this means that the patch should not have been back
>> ported. It is possible that the crash which this patch was addressing
>> was introduced as a result of changes elsewhere. For example
>> https://lore.kernel.org/all/20250924-use-v4-0-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp/
>> changed some internal mechanics of finalize. I didn't raise any
>> objection to the back port because it seemed like the original code
>> where the object was its own parent was wrong but I guess it was
>> working fine somehow. I think in the meantime the best course of
>> action is to revert the patch in the stable branches.
> 
> wait a sec the crash is on stable? not master?

Joelle, please clarify which QEMU version has the problem you're fixing
and how to reproduce it.

I only tested latest staging branch so far. There was a report in the
past about potentially wrong mem region refcounting, but it was reported
for a very unstable WIP code and I couldn't reproduce the problem. We
can always revert patch and try again later if you're short on time.

-- 
Best regards,
Dmitry


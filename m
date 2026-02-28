Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7ACFD0046
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 22:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwT5a-0000Ry-GC; Sat, 28 Feb 2026 17:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vwT5Y-0000Ro-E4
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:47:08 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vwT5W-0003T2-Ph
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 17:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772318822; x=1772923622; i=deller@gmx.de;
 bh=MBIAjNI5vxHBpOOWEz20DPcdcBKbAqRty2LT1CqjFF0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=N9FCZGUIJagXXII8SoeyhazioOqnEflNI0Dw010qyFYSSi73qc8xARVtvwnHP00T
 iAnoYrjqxgiTrKIJM4qTjtkRZ4u/FvC3QFjhOgCfZIqGaunLmaY6Z9DGCOQabIV91
 tcwxx61Tn4fXxVkX6DNh13DMDHoV+XdsTAoCa88QtteQObLQd+UiYl9RWA+R9NeIF
 BiwzBC0L/LTQzVLeh98E4ymge1AHUAbW8fLOKnBGrW3g/xK3oVgqtSusG7jtFcnNk
 59p5E+sbB7VDKBvsb6dgungK72OUzjAG8hOysNkSaFvl+QrNAtxrEJ3oyn4JFa887
 rXe+AmLeeBzCT94/1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wGs-1vzmTS0Ev6-009HoA; Sat, 28
 Feb 2026 23:47:02 +0100
Message-ID: <a3587955-7ad2-42d7-8354-4e6c4c03e721@gmx.de>
Date: Sat, 28 Feb 2026 23:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING] [PATCH v2] linux-user/strace: fix printing of file offsets
To: =?UTF-8?Q?Jean-Christian_C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, jean-christian.cirstea@tuta.com
References: <20251226173521.1957025-1-jean.christian.cirstea@gmail.com>
 <20260228194450.211977-1-jean.christian.cirstea@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260228194450.211977-1-jean.christian.cirstea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GPyQ3JD/YK6qqRbgLM+Wp51qoF8T14fmwftZCug636nO2p8ImRt
 g5vbvRFla4dATsM+Ce/7ptD9DeW+g5iaZmlW14RrR0sf2bhtVxeJwoFsyeQYOhsq7dZrBo2
 XDY+40TZQmeZvy4PjOy+Z3t5PDDvYKjjMzQ7OwvGxkLeAKK7X4FbK5d883Cq2CDW/C+jr0j
 qE6WHWOPtC++uJRUWdTvQ==
UI-OutboundReport: notjunk:1;M01:P0:9+j9ppfsl2U=;cSt5SVBS5s8Cw7OM1U1tbIRJ89Q
 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
 CE5HG6g0=
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/28/26 20:44, Jean-Christian C=C3=8ERSTEA wrote:
> Any outstanding issues?

No, seems ok.
You may add:
Reviewed-by: Helge Deller <deller@gmx.de>

Helge


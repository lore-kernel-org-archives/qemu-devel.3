Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B20CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZuim-0007p1-Nt; Wed, 17 Jun 2026 14:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZuil-0007n9-HN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:10:39 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wZuij-0005LE-TP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 14:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781719834; x=1782324634; i=deller@gmx.de;
 bh=qnKVXHB+QlHbYmP9iV/7wmdNamv/TvBaOCIeAXFtAi8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sZYRhVgPhubIR66HlOarvWyFwg4Wso+fapwUJ2/+HXQTYFWLXJCzgzzgnXBE8o7C
 eTX8Y1eaSbU4i29YnYuHjsHm0+I6E16BzoIzlkjvvl/D8XaMrpk51dpYuFbXzYFfg
 DNrLdI5jnZLoVez17ndiUNSq8lUiJnF9xr99MyBhZL1TikMEd9ecr/8LfTf91kp7T
 8I9ZFakqhlx865XVdMfGnq7mlJqFys+zhDqbrZt+anhahc7TfVAw92OKshbLQ0LyC
 m/0qi8IQwQE9jrVLRLc+RJHKof76TKhyNXmB8rGXbbuH3ffhuQKEyGTyN+dr/pImA
 kbGMNVP+2Mpvfm++DQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1xEOQY3348-00wsGp; Wed, 17
 Jun 2026 20:10:34 +0200
Message-ID: <42adf326-585b-4756-bd35-f8e6f4cbc587@gmx.de>
Date: Wed, 17 Jun 2026 20:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] common-user: Move selfmap from util
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
 <20260616212055.334466-10-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260616212055.334466-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ADP/a1JPf95CuZCsd6NaDzsMnPvr9JvuTZfCbV3qfxRyKIJfm4q
 9tt+xxtXY52cbqz+vzdaMCpciaQmVezokkyw7o2xl4PeXyHaLtS1zFhUJ3PvdBsJYvksfHk
 htuqd7GQQqXappY4iMGXkaARDhKi46gpFTfxhRlKeqhjViBm4qT8O/zTaGjehtxl79Js/bh
 G8ffrZx278r2cOzo5WOTQ==
UI-OutboundReport: notjunk:1;M01:P0:5ZTVDpqubns=;M5E8UIaSEmmIKYi144QqQ3+FznF
 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
 01a7WvhgnhEJtL7HBRu0mUq4L08=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/16/26 23:20, Richard Henderson wrote:
> This interface is only used for user-only.  It's more usefully
> placed within common-user than util.  Temporarily add stub
> implementation for bsd-user.
>=20
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de



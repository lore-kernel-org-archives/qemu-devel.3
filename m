Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFD7CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 13:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRrRN-0007Yi-6f; Tue, 26 May 2026 09:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wRr3S-0006jt-4s
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:38:42 -0400
Received: from msg-1.mailo.com ([213.182.54.11] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wRr3Q-0003l4-0a
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1779798356; bh=/rfsnntbBxbotWvwlsRPzpxq1es7VPommdDLOkyrhpk=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=cblFF/CnCdk/KxjhvhbVbNWcxboqJVMdQQd73AP3L0d4FHUdisXeLlYcqmjv4eFy7
 4k2dRX1nOuTuvzH1hJARisNgeg4cz/Fv7yWiDFNQnVfCCsu6AUYs2/o2xOFaEupTal
 qTvaEdHQHLAvltE+TB8yI/LCpX3PDckrE74WUfzg=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Tue, 26 May 2026 14:25:55 +0200 (CEST)
X-EA-Auth: 0LOA4nhPQg3u6V6kEW+1sVLgoYy3hR00VxoH6n5zkf9+j78MY0wMV+Ga7xPyaiZ/ciWvitBkVnGxp2W4KVWHhdrRvfS3IvAg
Message-ID: <47872d99-e170-446c-bda6-6fa84c0e725d@mailo.com>
Date: Tue, 26 May 2026 14:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update PhilMD's email address
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260526122137.64378-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Content-Language: en-US
In-Reply-To: <20260526122137.64378-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.11; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 26 May 2026 09:02:56 -0400
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

On 26/5/26 14:21, Philippe Mathieu-Daudé wrote:
> philmd@linaro.org will stop working starting 2026-06-01,
> use my personal email instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20260519173014.98967-1-philmd@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 58 ++++++++++++++++++++++++++---------------------------
>   .mailmap    |  6 +++---
>   2 files changed, 32 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>



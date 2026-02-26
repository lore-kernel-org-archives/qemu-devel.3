Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A4FFC5937
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 12:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvaAE-000711-JD; Thu, 26 Feb 2026 07:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1vvaAA-00070m-Vn; Thu, 26 Feb 2026 07:08:14 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1vvaA5-0006da-Sp; Thu, 26 Feb 2026 07:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1772107673; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=bR8G0iV4dVxDSeil5apNl6hh7xw/Go5tZG6N3h2Y1dE=;
 b=Wxvl+GqN6QxUuqJbXDiZmVC44bPC/N0+dkfcv+Fp3nNTIXYMjVDUk7YJRegevWAPkLAsDaRAG85pfq1KAeOqe1C/4XcsbrqopexizzMY0qeMgFho6M9sA1e7eeoy4pgVi1M1+XLaWubn/BAlKa1YU4BZLRLBpIMalxXKTaXBCMk=
Received: from 30.166.64.213(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WzrE4oG_1772107362 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 26 Feb 2026 20:02:43 +0800
Content-Type: multipart/alternative;
 boundary="------------exbw03042EnOj0mvyvXykwGu"
Message-ID: <a2c4fbb4-7d94-4fa7-ad01-48bf04160462@linux.alibaba.com>
Date: Thu, 26 Feb 2026 20:02:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for RISC-V TCG CPUs
To: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260226102008.146928-1-chao.liu.zevorn@gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260226102008.146928-1-chao.liu.zevorn@gmail.com>
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -164
X-Spam_score: -16.5
X-Spam_bar: ----------------
X-Spam_report: (-16.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

This is a multi-part message in MIME format.
--------------exbw03042EnOj0mvyvXykwGu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/26/26 6:20 PM, Chao Liu wrote:
> Add myself as a reviewer for RISC-V TCG CPU related code to better
> participate in patch review.
>
> Signed-off-by: Chao Liu<chao.liu.zevorn@gmail.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 233d2a5e71..4923715c9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -333,6 +333,7 @@ M: Alistair Francis<alistair.francis@wdc.com>
>   R: Weiwei Li<liwei1518@gmail.com>
>   R: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
>   R: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> +R: Chao Liu<chao.liu.zevorn@gmail.com>

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>   L:qemu-riscv@nongnu.org
>   S: Supported
>   F: configs/targets/riscv*
--------------exbw03042EnOj0mvyvXykwGu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <br>
  <body>
    <br>
    <div class="moz-cite-prefix">On 2/26/26 6:20 PM, Chao Liu wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260226102008.146928-1-chao.liu.zevorn@gmail.com">
      <pre wrap="" class="moz-quote-pre">Add myself as a reviewer for RISC-V TCG CPU related code to better
participate in patch review.

Signed-off-by: Chao Liu <a class="moz-txt-link-rfc2396E" href="mailto:chao.liu.zevorn@gmail.com">&lt;chao.liu.zevorn@gmail.com&gt;</a>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 233d2a5e71..4923715c9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -333,6 +333,7 @@ M: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>
 R: Weiwei Li <a class="moz-txt-link-rfc2396E" href="mailto:liwei1518@gmail.com">&lt;liwei1518@gmail.com&gt;</a>
 R: Daniel Henrique Barboza <a class="moz-txt-link-rfc2396E" href="mailto:dbarboza@ventanamicro.com">&lt;dbarboza@ventanamicro.com&gt;</a>
 R: Liu Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
+R: Chao Liu <a class="moz-txt-link-rfc2396E" href="mailto:chao.liu.zevorn@gmail.com">&lt;chao.liu.zevorn@gmail.com&gt;</a></pre>
    </blockquote>
    <p>Reviewed-by: <span style="white-space: pre-wrap">LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a></span></p>
    <p><span style="white-space: pre-wrap">Zhiwei</span></p>
    <blockquote type="cite"
      cite="mid:20260226102008.146928-1-chao.liu.zevorn@gmail.com">
      <pre wrap="" class="moz-quote-pre">
 L: <a class="moz-txt-link-abbreviated" href="mailto:qemu-riscv@nongnu.org">qemu-riscv@nongnu.org</a>
 S: Supported
 F: configs/targets/riscv*
</pre>
    </blockquote>
  </body>
</html>

--------------exbw03042EnOj0mvyvXykwGu--


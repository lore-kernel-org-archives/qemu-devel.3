Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8F9EE01F1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 00:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soBT3-0007MJ-8c; Tue, 10 Sep 2024 20:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1soBT1-0007Lh-Bk
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 20:44:19 -0400
Received: from secure.fsr.com ([64.126.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1soBSz-0006PI-Bm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 20:44:19 -0400
Received: from [192.168.254.26] (syn-098-146-201-045.res.spectrum.com
 [98.146.201.45]) (Authenticated sender: chauser)
 by secure.fsr.com (Postfix) with ESMTPSA id 2D1D01F6C28;
 Tue, 10 Sep 2024 17:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pullman.com;
 s=mail1; t=1726015445;
 bh=223a7OX38hJUwDCIyPX3gFWM1VWhI6aku3bu0AcT7M8=;
 h=Date:Subject:To:From;
 b=OGMFtdK8NdtukwNc/DBLplljRGc3FhuyyheWK5iDkMRICJsnNcpJ4punwYWFKkrr4
 IMDtm+FmFmqEUaHdZVDGwLhgvY/JbhAn+sJ0F0nP+wlzp3GvsdYsVf1wXcRYKSmt7E
 oU0o5MI2AEYcD/5AK0aTR2wmEcYnObrVYcQDpgcU=
Message-ID: <78deb99f-8b8d-46a3-9819-ee1e21e489e0@pullman.com>
Date: Tue, 10 Sep 2024 17:44:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] target/sparc: emulate floating point queue when
 raising fp traps
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240909180712.651651-1-richard.henderson@linaro.org>
Content-Language: en-GB
From: Carl Hauser <chauser@pullman.com>
In-Reply-To: <20240909180712.651651-1-richard.henderson@linaro.org>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=64.126.132.23; envelope-from=chauser@pullman.com;
 helo=secure.fsr.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 MIME_HTML_ONLY=0.1, SPF_HELO_PASS=-0.001,
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

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 9/9/24 11:07, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240909180712.651651-1-richard.henderson@linaro.org">
      <pre class="moz-quote-pre" wrap="">Changes for v5:
  - Fix stdfq advance_pc.

r~

Carl Hauser (2):
  target/sparc: Add FQ and FSR.QNE
  target/sparc: Populate sparc32 FQ when raising fp exception

Richard Henderson (3):
  target/sparc: Add FSR_QNE to tb_flags
  target/sparc: Implement STDFQ
  target/sparc: Add gen_trap_if_nofpu_fpexception

 target/sparc/cpu.h          |  30 ++++++++-
 target/sparc/fop_helper.c   |   4 ++
 target/sparc/int32_helper.c |  40 ++++++-----
 target/sparc/machine.c      |  25 +++++++
 target/sparc/translate.c    | 128 ++++++++++++++++++++++++++----------
 target/sparc/insns.decode   |   2 +-
 6 files changed, 178 insertions(+), 51 deletions(-)

</pre>
    </blockquote>
    <p>I did very basic tests that IEEE exceptions are raised
      successfully and the quad precision instructions are emulated. <br>
    </p>
    <p>Tested-by: Carl Hauser <a class="moz-txt-link-rfc2396E"
        href="mailto:chauser@pullman.com">&lt;chauser@pullman.com&gt;</a></p>
    <p><br>
    </p>
  </body>
</html>


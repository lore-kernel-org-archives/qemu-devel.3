Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500C6C88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WBL-0004qy-99; Tue, 15 Sep 2026 12:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6WBJ-0004qn-Ck
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:38:53 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6WBG-0005Kt-BQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:38:52 -0400
Content-Type: multipart/alternative;
 boundary="------------pNJiyodtNu2UPmTUzKn2Uu0j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1789490326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjVv3/LDqS6F0bKzXLWt0G/Dt/DqRGk47m6yfE2q/yc=;
 b=aJky3KqR2MpW0yhbgkrj5NBYzB+FJRxIF0lj3WHwQnfxFGmMqIAhu/GsNMKe0whzROWyrB
 bEarrTm/2AEsMRSKnvq5alqQ5WorS0IvCi73VRfUrhNsQy5lDq0WhwVNWX0A6qb9bQ+Ay9
 6kZaxVOr3syPxqup78Z/Y0kfjxyz4as=
Message-ID: <4a4f47f0-5128-498f-8103-47de6907aea0@swemel.ru>
Date: Tue, 15 Sep 2026 19:38:46 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] hw/display/tcx: use memmove instead of memcpy for
 overlapping blit memory regions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, mst@redhat.com,
 stefanha@redhat.com, kwolf@redhat.com, marcandre.lureau@redhat.com,
 mark.cave-ayland@ilande.co.uk
References: <da75d0f0-d98e-4e27-ac6c-c575a2d382ff@swemel.ru>
 <aqly4GgJs7XSn3-D@redhat.com>
Content-Language: en-US, ru-RU
From: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
In-Reply-To: <aqly4GgJs7XSn3-D@redhat.com>
Received-SPF: pass client-ip=95.143.211.150; envelope-from=zorin@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------pNJiyodtNu2UPmTUzKn2Uu0j
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This is our tag. Okay, in the future I'll remove the "garbage" (anything 
that doesn't relate to the original).

15.09.2026 19:31, Daniel P. Berrangé пишет:
> I'm guessing it is a tag you're using for tracking issues, but
> if so, it should be removed before sending commits upstream.

--------------pNJiyodtNu2UPmTUzKn2Uu0j
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="lRu31" dir="ltr"><span class="HwtZe" lang="en"><span
          class="jCAhz ChMk0b"><span class="ryNqvb">This is our tag.</span></span>
        <span class="jCAhz ChMk0b"><span class="ryNqvb">Okay, in the
            future I'll remove the "garbage" (anything that doesn't
            relate to the original).</span></span></span><span
        class="ZSCsVd"></span>
      <div class="OvtS8d"></div>
    </div>
    <br>
    <div class="moz-cite-prefix">15.09.2026 19:31, Daniel P. Berrangé
      пишет:<br>
    </div>
    <blockquote type="cite" cite="mid:aqly4GgJs7XSn3-D@redhat.com">
      <pre class="moz-quote-pre" wrap="">I'm guessing it is a tag you're using for tracking issues, but
if so, it should be removed before sending commits upstream.
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------pNJiyodtNu2UPmTUzKn2Uu0j--


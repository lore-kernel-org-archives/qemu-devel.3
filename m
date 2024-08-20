Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DF2C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 16:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgSBs-0006wT-R3; Tue, 20 Aug 2024 12:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sgSBp-0006vN-Ep
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:58:37 -0400
Received: from secure.fsr.com ([64.126.132.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chauser@pullman.com>)
 id 1sgSBk-0006Cl-Fr
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 12:58:37 -0400
Received: from [192.168.254.26] (syn-098-146-201-045.res.spectrum.com
 [98.146.201.45]) (Authenticated sender: chauser)
 by secure.fsr.com (Postfix) with ESMTPSA id CA2BBBD0C2;
 Tue, 20 Aug 2024 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pullman.com;
 s=mail1; t=1724173108;
 bh=iHDSJ15lM7vjupwwLeMXA20+bAvFY5dftE/2Nf4IbgI=;
 h=Date:Subject:To:From;
 b=HU/mfpwqX9kPgFtKELJMU+Md1xKeJDwefTVbaY7G0jF0jCUxERmJbXiurIGFtv1RV
 mA5B9R/bmlDOpQsjfA/YqkCK/HMC/Nxd8IKG5eGt8Jk5DdketDyZOIMmL5ZFtMzL97
 /pqvLf3caILmDQa+ZNgsExkl5RrAnacIoJp30cOo=
Message-ID: <d3a12dd9-182d-4c97-955b-197f100b1feb@pullman.com>
Date: Tue, 20 Aug 2024 09:58:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char: suppress sunmouse events with no changes
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <cb338cdc-d09d-4513-ba16-5ff3f792bbfe@pullman.com>
 <d8bbf72d-29e5-465b-a8aa-508ed2960631@linaro.org>
Content-Language: en-GB
From: Carl Hauser <chauser@pullman.com>
In-Reply-To: <d8bbf72d-29e5-465b-a8aa-508ed2960631@linaro.org>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.126.132.23; envelope-from=chauser@pullman.com;
 helo=secure.fsr.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 MIME_HTML_ONLY=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
    <p>Yes, just equality, no masking needed. Boneheaded.</p>
    <p>I think I could figure out how to do the state migration if
      that's the direction you want to go.</p>
    <p>I don't think I could do the migration to
      qemu_input_handler_register, especially as I would think that the
      keyboard should be done at the same time.</p>
    <p>I'll wait on a V2 patch with the equality fix for a decision
      about migration/vs new style.<br>
    </p>
    <p>-- Carl<br>
    </p>
    <div class="moz-cite-prefix">On 8/20/24 00:34, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:d8bbf72d-29e5-465b-a8aa-508ed2960631@linaro.org">On
      8/20/24 09:18, Carl Hauser wrote:
      <br>
      <blockquote type="cite">@@ -959,6 +960,15 @@ static void
        sunmouse_event(void *opaque,
        <br>
              int ch;
        <br>
        <br>
              trace_escc_sunmouse_event(dx, dy, buttons_state);
        <br>
        +
        <br>
        +    /* Don't send duplicate events without motion */
        <br>
        +    if (dx == 0 &amp;&amp;
        <br>
        +        dy == 0 &amp;&amp;
        <br>
        +        (s-&gt;sunmouse_prev_state ^ buttons_state) == 0) {
        <br>
      </blockquote>
      <br>
      Were you intending to mask vs MOUSE_EVENT_*BUTTON?
      <br>
      Otherwise this is just plain equality.
      <br>
      <br>
      <blockquote type="cite">diff --git a/include/hw/char/escc.h
        b/include/hw/char/escc.h
        <br>
        index 5669a5b811..bc5ba4f564 100644
        <br>
        --- a/include/hw/char/escc.h
        <br>
        +++ b/include/hw/char/escc.h
        <br>
        @@ -46,6 +46,7 @@ typedef struct ESCCChannelState {
        <br>
              uint8_t rx, tx;
        <br>
              QemuInputHandlerState *hs;
        <br>
              char *sunkbd_layout;
        <br>
        +    int sunmouse_prev_state;
        <br>
      </blockquote>
      <br>
      This adds new state that must be migrated.
      <br>
      <br>
      While the patch is relatively simple, I do wonder if this code
      could be improved by converting away from the legacy mouse
      interface to qemu_input_handler_register. Especially if that might
      help avoid needing to add migration state that isn't "really" part
      of the device.
      <br>
      <br>
      Mark?
      <br>
      <br>
      <br>
      r~
      <br>
      <br>
    </blockquote>
  </body>
</html>


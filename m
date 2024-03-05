Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38115C54E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSet-0003mo-6Z; Tue, 05 Mar 2024 06:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rhSel-0003PV-De
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:08:24 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rhSej-0003Gl-Go
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:08:22 -0500
Received: (qmail 25980 invoked by uid 484); 5 Mar 2024 11:08:18 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.991909 secs); 05 Mar 2024 11:08:18 -0000
Received: from nedpc1.intern.lauterbach.com (HELO [10.2.11.92])
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <alex.bennee@linaro.org>; 5 Mar 2024 11:08:15 -0000
Content-Type: multipart/alternative;
 boundary="------------SC0dOEIOZzVLx0h9FDs0lUsD"
Message-ID: <10df7ccb-80d1-4567-a7a5-7a29b1c88e4e@lauterbach.com>
Date: Tue, 5 Mar 2024 12:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/18] mcdstub: system and core queries added
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian Boenig <christian.boenig@lauterbach.com>
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
 <20231220162555.19545-12-nicolas.eder@lauterbach.com>
 <87plwf8fvi.fsf@draig.linaro.org>
From: "nicolas.eder@lauterbach.com" <nicolas.eder@lauterbach.com>
In-Reply-To: <87plwf8fvi.fsf@draig.linaro.org>
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------SC0dOEIOZzVLx0h9FDs0lUsD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 29/02/2024 16:11, Alex Bennée wrote:
> Hopefully the code can be more generic now and avoid having to re-parse
> generated xml.

I adapted my code to the recent register-related changes. There is still 
some arm-specific code, but thanks to gdb_get_register_list() and 
gdb_read_register() I could completely omit the XML parsing.

--------------SC0dOEIOZzVLx0h9FDs0lUsD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 29/02/2024 16:11, Alex Bennée wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87plwf8fvi.fsf@draig.linaro.org">
      <pre>Hopefully the code can be more generic now and avoid having to re-parse
generated xml.</pre>
    </blockquote>
    <p>I adapted my code to the recent register-related changes. There
      is still some arm-specific code, but thanks to
      gdb_get_register_list() and gdb_read_register() I could completely
      omit the XML parsing.<br>
    </p>
  </body>
</html>

--------------SC0dOEIOZzVLx0h9FDs0lUsD--


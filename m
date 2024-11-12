Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B44D42B82
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 13:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArDf-0000c9-SN; Tue, 12 Nov 2024 08:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tArDV-0000bE-Hl
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tArDT-0002cW-1g
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731419158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6mtJ1GNESwSYjCUk7/pfoTAkCNIunNZRJDvMPqmOLp0=;
 b=IQ0gYMDRGP+l1Zu0rSNtR5ngF2iCmUukMIQmWS+DKTMb4egDkEujptWHsLRESG0dopfgog
 jxBW43Fgv/N299wdm3SnlFwgu/02H//n/j7I6rxmFO+/7JzeM4kMigREUR16T4htPW0+zI
 u5fxRCbD5Tah2rqSINx+Le5mU4jM330=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-OhyQUa_KM9yTyppHbqhTkQ-1; Tue, 12 Nov 2024 08:45:54 -0500
X-MC-Unique: OhyQUa_KM9yTyppHbqhTkQ-1
X-Mimecast-MFC-AGG-ID: OhyQUa_KM9yTyppHbqhTkQ
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b14fc05206so692429285a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 05:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419154; x=1732023954;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mtJ1GNESwSYjCUk7/pfoTAkCNIunNZRJDvMPqmOLp0=;
 b=NXfOg5ikydyEDnUHV65rxEVt60LLc94sJcKqOKsQXH+D2M0H5MnxW/5nxRY2rUiCUS
 5CL2jFtPzJ3okOZx2HjYEfMve3LgmPckfNSDiqlHkDDwwwQBXRdWfL8I8Ol4a57lC5TV
 uQg6wk7tb8vAxqc/bu38ZW4yzbnwy6lLjFq4I0SgkfvBrUR9swpfKtdPyo86LDdObAAm
 O+DhbPGEdULfHNMTrZKk4NkqNFxw5uu8l6in98bY+gyHnRW+aCiOPIEQlSo2wGiLXUzo
 hv4j2tGPs9YetLR6sNWmnQsK/ZgNp4di7DdW6rxRjsIhzrdp8cbRP/7wQqOnsU0U+LNy
 BOrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbhqSNbp+IbC2ybuM8mLGTGiWknF4Z2okkD3Wi3vGU2UPIqtKWWBCu6WJh7AcVuWDvT95jNKVG1IFr@nongnu.org
X-Gm-Message-State: AOJu0YwehVw8Xcwq0FvSWYQYeaQsBLek9UBoy2gRmoqiO7hUZpoAvBXB
 vfUdSk8FGzBbU7DZUgok4VtlyUFN6A3bdJrWfvnqjedv2/DWliuLVsej9qB+uLfA4DFulHuNaBr
 yThoGF/8Pky01kjMP6yu0ETPDmcCaChptMhyGak/fqdahJSTP7RKv
X-Received: by 2002:a05:620a:4041:b0:7b1:49cf:6460 with SMTP id
 af79cd13be357-7b331f2ed00mr2234623485a.59.1731419154419; 
 Tue, 12 Nov 2024 05:45:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIPJdtHXXG9h6Nd7bffuYvhtIyrZrRl7hgi7adZd35oBkKVQI6NQngOCZCf225pUYh6OzdAw==
X-Received: by 2002:a05:620a:4041:b0:7b1:49cf:6460 with SMTP id
 af79cd13be357-7b331f2ed00mr2234618785a.59.1731419153889; 
 Tue, 12 Nov 2024 05:45:53 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-115.web.vodafone.de.
 [109.42.49.115]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac2da65sm593243685a.13.2024.11.12.05.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:45:53 -0800 (PST)
Message-ID: <519d031b-ed11-4fed-b25b-e73dc28a9e9b@redhat.com>
Date: Tue, 12 Nov 2024 14:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] tests/functional: Introduce _console_read()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241112130246.970281-1-clg@redhat.com>
 <20241112130246.970281-2-clg@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241112130246.970281-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/11/2024 14.02, Cédric Le Goater wrote:
> Interaction with the console has been a problem in our avocado
> tests. In some cases, the expected string does not match in the
> output, causing the test to fail with a timeout. These were worked
> around by sleeping before reading the console and even with SSH
> connections in some places.
> 
> To fix, process the console output char by char and not with
> readline. This routine was largely inspired by console_wait() in
> tests/vm/basevm.py.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/qemu_test/cmd.py | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index cbabb1ceed3c..5bca29d1d721 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -12,6 +12,7 @@
>   # later.  See the COPYING file in the top-level directory.
>   
>   import logging
> +import re
>   import os
>   import os.path
>   import subprocess
> @@ -78,6 +79,23 @@ def run_cmd(args):
>   def is_readable_executable_file(path):
>       return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>   
> +def _console_read(vm, expect):
> +    console_logger = logging.getLogger('console')
> +    output = ""
> +    while True:
> +        data = vm.console_socket.recv(1)
> +        if not data:
> +            break
> +        output += data.decode("latin1")
> +        if expect in output:
> +            break
> +        if "\r" in output or "\n" in output:
> +            lines = re.split("[\r\n]", output)
> +            if lines[0]:
> +                console_logger.debug(lines[0])
> +            output = lines.pop()
> +    return output
> +
>   def _console_interaction(test, success_message, failure_message,
>                            send_string, keep_sending=False, vm=None):
>       assert not keep_sending or send_string
> @@ -98,12 +116,12 @@ def _console_interaction(test, success_message, failure_message,
>               continue
>   
>           try:
> -            msg = console.readline().decode().strip()
> +            msg = _console_read(vm, success_message)
>           except UnicodeDecodeError:
>               msg = None
>           if not msg:
>               continue
> -        console_logger.debug(msg)
> +        console_logger.debug('found "%s"', msg)

Sorry for being picky (yay, bike shed painting!), but it's a little bit hard 
to distinguish these "found" markers in the console.log from the lines that 
just contain the normal output.

Maybe we could use some funky unicode character instead? For example:

         console_logger.debug('🔎 %s', msg)

or:

         console_logger.debug('✅ %s', msg)

?

Or maybe just indent the normal lines, i.e. in the _console_read() function
you could do this instead:

        console_logger.debug('      %s', lines[0])

so that the "found" string is more visually separated?

Or maybe even combine the two approaches?

  Thanks,
   Thomas



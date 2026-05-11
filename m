Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9D4CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMO1T-0005hY-1b; Mon, 11 May 2026 06:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMO1R-0005hN-LT
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:38:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMO1P-0006V6-VP
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:38:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so37421565e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778495878; x=1779100678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ck8f98L72hDFetAfly7qzyHYi3YozppaLyDUGNh5+cU=;
 b=w3QvsgrD/9Jp9ca2zJueZaZXhKbISPjQMQg6CQvuuccxnJUc62zDkrruMSa42TRblK
 XUn+/ei2jkM4NKyrK04kvvzAfjXdnMnSxs00lJ0dnhC5/2Dm6HDcbisaAhx29p5pg50e
 iIdcvJnSEOW5FwecdYjcp1PzJmr+DIRf3z1w/QjnHwM3brvCLfTJ0ZRFw9S9siABxex2
 nG82k2OeT2tBrJqnRQMRZ5xellr2hlrA699JFe+1jVTeXDq7mt4UHeT6/KWByobg1k/9
 75HERpMGxkYFgjXG8+u8GPs72jmav0RH/+DAGtgc/W2+VCbCIegxbZb9x+w+YVqWIf3g
 A/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778495878; x=1779100678;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ck8f98L72hDFetAfly7qzyHYi3YozppaLyDUGNh5+cU=;
 b=leMNXzZ0aq9cLDMoUuNdqWYxYcT5c+pcZIXVoMqIiVz/lDPuCtUJB/GWhc6Eb4aVCp
 0hupFTbrlG1maVTeYdvWgR8SscpchzBmLxHnohHbe2vNNvmlWTeN3vlXFwA1GQBYLi7N
 sG+Umua6n3Z23mQBL6q+IiERAjxZV6FNDtzcto0HV14JDFS8gPgF7kNKIZrqDttT7E8b
 Dfff5v74EODdFqyRXpWATlVPZ+UiRxmvT0N5g8irhmZ7dYZzz5d8cMvsh1TGHpO4zCMC
 wtkGR06QTor3mirM6qNqsx98TBatU6mS/4nrGHd74V2M4kPLB4TrCmb84AR4LS2pKPtb
 L67w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MD4pYWNOxLLVaglPy9YsJcqr3ePnZa1i6jF4fEd2Hq9gVTMOptZ/o3YvJz/aV8YFeVNhyDS1lVs8Z@nongnu.org
X-Gm-Message-State: AOJu0Yxs2SF+GKHc+xNmT1qLp6qf+LVdBgJF5ehkHhO/y5sKGC/+0kai
 wxRe1fJIc7U25cwPrOo3+Uvad+5l6eLCfR80w6tv3UZWualetE4lDte33eKtnTVJabc=
X-Gm-Gg: Acq92OFhcenrj+iZL1VZwtnoYWoXDG5/N6NKY5VLlmJUGgp+LZCA5LOHyxPYRUXwoNZ
 RnTfc+IRB9kOkuJH1Xc/Rp+qJTMPgWSQIHhInSvJvLcEu/8lHgfd6yFCRkUlAl19lDLh5pzQeq1
 IZl8VPYx7RLs92zqTUyhxwV6bVhFLwjGZSYL51IBVMfMv09Bkqm9Riy2X0Sv3f1o9lKuc0Ql3y+
 9+nsSH3LjSDClBB7mYJBmf6g5VWrCk+2z3rZ4Hta2U08wFTZZNny4Zf2y+5U9Z8BBy7SFQ+ynWR
 OeNF8B4QQHaDxjpgHOB9kpSARUF2hJqExP9ZQl7SHOR/h1/3UQHtQcXgEhV2ZZzQ5wdcssPXdzG
 V8JWAg/grNQyvArMFcIEHSQAaWY9ciCsMGT7ffn6OBK6yCKX4KTxVq8bEZzsWK/bKqtIyF4FCrZ
 G9SIaxBi5+hVB8WkQo5Fu90lNtm/JZNXZ3ktypqGbbgpt/WuokH7dd25OvENwF+8xUFA==
X-Received: by 2002:a05:600c:c107:b0:48a:52d4:888c with SMTP id
 5b1f17b1804b1-48e51e0bb23mr273870855e9.3.1778495878205; 
 Mon, 11 May 2026 03:37:58 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e701e957asm178413615e9.6.2026.05.11.03.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:37:57 -0700 (PDT)
Message-ID: <6e03fe79-2071-444f-880c-332c53539978@linaro.org>
Date: Mon, 11 May 2026 12:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] qom: validate ID format when creating objects
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-3-berrange@redhat.com>
 <b3acf8bc-7ac1-4b4d-b7a4-4848b58ec51d@linaro.org>
In-Reply-To: <b3acf8bc-7ac1-4b4d-b7a4-4848b58ec51d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/5/26 12:35, Philippe Mathieu-Daudé wrote:
> On 8/5/26 13:24, Daniel P. Berrangé wrote:
>> The object_new_with_props/propv methods failed to validate the ID string
>> format, thus diverging from user_creatable_add_type.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   qom/object.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index 9c391071fb..62d2f0486a 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -24,6 +24,8 @@
>>   #include "qapi/forward-visitor.h"
>>   #include "qapi/qapi-builtin-visit.h"
>>   #include "qobject/qjson.h"
>> +#include "qemu/id.h"
>> +#include "qapi/qmp/qerror.h"
>>   #include "trace.h"
>>   /* TODO: replace QObject with a simpler visitor to avoid a dependency
>> @@ -764,6 +766,13 @@ Object *object_new_with_propv(const char *typename,
>>       ObjectClass *klass;
>>       UserCreatable *uc;
>> +    if (id != NULL && !id_wellformed(id)) {
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an 
>> identifier");
>> +        error_append_hint(errp, "Identifiers consist of letters, 
>> digits, "
>> +                          "'-', '.', '_', starting with a letter.\n");
>> +        return NULL;
>> +    }
> 
> Use a common object_identifier_is_well_formed() helper?

I see the last patch of this series remove the duplication, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



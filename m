Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1719C83F09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 07:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZlTS-0007Eh-25; Thu, 10 Jul 2025 03:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZlTQ-00079w-J0
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 03:13:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZlTH-0005KK-BT
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 03:13:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b49ffbb31bso370061f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752131609; x=1752736409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=awQJ8AMH0C+KzLU+F7utuVOEZo+aAwZYzEuWJ5By7Q8=;
 b=NMkIiIKty7EKFufZ4Gp8p55142zVUuLqJ3TYnTeVOp7MFtHE0MNrC3EuXuEHoENl6/
 TrUY/1AqnMuvf+lwRTJaliRcFx4z6Wpb9j03cj9L73BGofQxftydCZ5RJvyX6VHhYYg5
 WEweuHOiw9w+j2tjhm3onGsLgoXXeqxyNRTpcwyre1439DjFjAyY5pueH3X0Zzli74vF
 MFUqEjHPfy+XQZQBDluwwwx/mdUZbmVI8KlmqeS4+7qbRFfG75+2bZjYDEP3qsPOC8Dc
 a3BnOq9/wKFFojzXpaSW5GX9a61j1AQZ8ijjuk1spnKNuqcoNkpHlLeAVnXsxGpWRZn8
 YFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752131609; x=1752736409;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=awQJ8AMH0C+KzLU+F7utuVOEZo+aAwZYzEuWJ5By7Q8=;
 b=wUwOArdKFkWlEXWlSi9RinUZj3J50SGlNLahGI/bFXIh/j2Zo7mEoV5EqetaNCovoS
 XXPKVpm/CySBUzyCsDZzvDf/A8dGo4I/QXxuRqZ8FjrSy2U6YerDGG+LHJ6ds5QsP5Pw
 zGs1F0PijiYXWq93bauwlslb4RVbyPgXssXhWI5UJ5SAgJbJbJQyJbNe561t5Drqveeq
 mWzxLEtCewA8BpT7q78pfmLTScqEAH5K54XnWPPmVklrYP1akcdin9rhMcakG6GzsCO5
 BbpJvmfepM2I2AcuiXPi0AJCNbyVOoM1asylaPtKPVgLEE/wS/HKMJAzACwmmtQOJhoC
 xx3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE7/eomfmbrYOKSSqaoKwGzaolLEs9rykxjtEUcjcV8Aob7XhDzO3xOz7y+IcyoCA3Q0EUWMYJ8Sa9@nongnu.org
X-Gm-Message-State: AOJu0Yw66/n3nXrt88E1wRhbnWzsKSTSy5yZnwn9CJbNR1un9JdQEBBa
 nDbUOtQpgeGcCfkVHHSESEKnsgRROxNCW/jJ+tCtg6y6cxV/7zwZk1645aOHK56uFWg=
X-Gm-Gg: ASbGncvZLTkfOqb6jQ1g/XFoqZsAHN9jvFw5f9DjheCDtvkwvZvxFXdBtSimtZtciNQ
 AgfkMWDSE2B4AwPrtLJ/Iqqnt+3f/kB3KtvAKhgabcHZWfRFeYfmd0IBK2oIAwil4JiuomhMSue
 TAX1PLgtXiiUG7Wwnzd8eDycfGurFZVjsmQzcFQxbH0Vnfxp3G7pXFlRJt3kXkTckbKNByiaySC
 XDKj2ZjayopD3c4hckynuKN/OCAgc5hCrMI3bwhyC6duxnXuZFG9TdmQmZa/zFvx+sSVspq5fV4
 qUekSEZFsHlrw1+t65o5svpzdZt6tSyzmUey1lPx+L3MKBZSeDRgajM8t4hcVgSh101NEhAdvtC
 Bc5kDu8fCidtPWF6EMb/dG2+I32I5HqSVprMARM+U9R62J3VGbwI9a8GyJw==
X-Google-Smtp-Source: AGHT+IG4396nXIh830EIDdW+3ayNW4IG7Iv9/MnoxHUt61RhKYTag5Rqxi18dX0kvD3mbUBQLwOuHw==
X-Received: by 2002:a05:6000:40cf:b0:3a3:63d3:369a with SMTP id
 ffacd0b85a97d-3b5e450ba8amr4322096f8f.25.1752131608592; 
 Thu, 10 Jul 2025 00:13:28 -0700 (PDT)
Received: from [10.132.103.213] (150.red-88-28-29.dynamicip.rima-tde.net.
 [88.28.29.150]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd537d07sm10411595e9.25.2025.07.10.00.13.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 00:13:27 -0700 (PDT)
Message-ID: <557f877a-f2e4-4c89-8b77-ae89a19486df@linaro.org>
Date: Thu, 10 Jul 2025 09:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] qom: qom-list-getv
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <1751995472-211897-1-git-send-email-steven.sistare@oracle.com>
 <1751995472-211897-2-git-send-email-steven.sistare@oracle.com>
 <44e6c0e9-927f-492d-9a2a-c26f2509e409@linaro.org>
Content-Language: en-US
In-Reply-To: <44e6c0e9-927f-492d-9a2a-c26f2509e409@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/7/25 23:54, Philippe Mathieu-Daudé wrote:
> On 8/7/25 19:24, Steve Sistare wrote:
>> Define the qom-list-getv command, which fetches all the properties and
>> values for a list of paths.  This is faster than qom-tree-get when
>> fetching a subset of the QOM tree.  See qom.json for details.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   qapi/qom.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++ 
>> ++++++
>>   qom/qom-qmp-cmds.c | 53 ++++++++++++++++++++++++++++++++++++++++++++ 
>> +++++++++
>>   2 files changed, 103 insertions(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and:

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



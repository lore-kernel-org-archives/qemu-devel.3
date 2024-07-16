Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92597C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbxE-0001cC-1y; Tue, 16 Jul 2024 02:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTbxB-0001Ue-UU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:46:26 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTbxA-0006oX-A2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:46:25 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-79f0e7faafcso388579385a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721112383; x=1721717183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFY05EHBNnl/nE8BkwEPaEzQLibDujt1klfTquQnq8s=;
 b=D/XGAoiuLtTqB6L75Z7NvIVJPRRBeuNFcogV9z5DUfNqKfWWR4W7uhsobTyLSdDwPa
 pAqRsUN0pZsDBWbsHo8cAB62SpU/lT/2owO4TEHCqoNgY/1tHrcnFPMLdd+cxYLoFO5C
 bGZJ8hB+QUtlzyZBm4E7Qz2g2fU+OqmWchDMQSh7ZR6fF4rY1JdOOAFKRS6+DWj7hDcr
 o+2GCKEJsuDpK0zRW+XmXl0pQXyyLzX5NJrpHtLq4TxNlAp+2qG6hHyWvCP8P7xPSvlT
 xPdJSENbZ4q8rFPMFrSKuEtizcbBan9Eost03c0rrijrgb72LwpRZTp3gTtrFbhjvIRh
 DSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721112383; x=1721717183;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tFY05EHBNnl/nE8BkwEPaEzQLibDujt1klfTquQnq8s=;
 b=TgtaJPNBb4vnjpMdwSD4SmrGrH0NyB5bP6li0Gzgq3BDPTNE69UgUHx9BZEOnNRpw4
 456JqANBwgthBJo2fjUNCyB4vKuiinteGuWOP+sOjtcOl+MS8XpUV4O/XVefCuw7JCRv
 +vuGHgP8vbTMv4fmS2TJkcmstur/68VVdrZx6d+TGHk1ktg7XYq7yrkr9axUS0USd3sj
 +Tocyct2nsA1LrUuPSRx6tq+btkCgOCUWUE1eAIx9ynwVnziBwFe99SwRGUzhoix2OfN
 w2Y1Gx0YcHg6Jn2cnJRJHaRTVgX/k/K7VeO2A7Yb2k6wNkP0TjCXIOCovTwcXk014+II
 qPGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSZl16bUd7fHrXRhaKIwKIdkDL8rPTVTuhPo8fpQ0xP01S8RFmrCdsjf3CItWCsSxPCeJFnzI07QpJS/0J3miiF4zgbSA=
X-Gm-Message-State: AOJu0YzJ8PpqBHjMg/5j5ocrCoaWGWQxiYWcuB75zN0sGcWik0BAqTaV
 qfM3nn5jTRq1/qz5uJsAnqb4ZUR1ppSSok5ze6ALJ1hBsUiGuJvwrGNOXs9xLtQ=
X-Google-Smtp-Source: AGHT+IGMIjHby855Cg7rvMEF0d88q5Koz6iE7idYc+opUa6ZYlgOJw8Bgacro8+vWZsogL+7tgyxyA==
X-Received: by 2002:a05:620a:24d2:b0:79d:5565:5120 with SMTP id
 af79cd13be357-7a17b6da07amr151327185a.34.1721112383083; 
 Mon, 15 Jul 2024 23:46:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160c6f5efsm266243785a.107.2024.07.15.23.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 23:46:22 -0700 (PDT)
Message-ID: <bcbd4622-ba30-4210-91c0-321406bd1f1a@linaro.org>
Date: Tue, 16 Jul 2024 08:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] esp.c: remove transfer size check from DMA DATA IN and
 DATA OUT transfers
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, fam@euphon.net
References: <20240713224249.468084-1-mark.cave-ayland@ilande.co.uk>
 <1408e396-b597-4481-b537-e7b53976d5d1@linaro.org>
 <de7fe2e4-a590-4fe0-801c-b7998927c570@ilande.co.uk>
Content-Language: en-US
Cc: Thomas Huth <thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <de7fe2e4-a590-4fe0-801c-b7998927c570@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x732.google.com
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

On 16/7/24 00:01, Mark Cave-Ayland wrote:
> On 15/07/2024 07:48, Philippe Mathieu-Daudé wrote:
> 
>> On 14/7/24 00:42, Mark Cave-Ayland wrote:
>>> The transfer size check was originally added to prevent consecutive 
>>> DMA TI
>>> commands from causing an assert() due to an existing SCSI request 
>>> being in
>>> progress, but since the last set of updates
>>
>> [*]
>>
>>> this is no longer required.
>>>
>>> Remove the transfer size check from DMA DATA IN and DATA OUT 
>>> transfers so
>>> that issuing a DMA TI command when there is no data left to transfer 
>>> does
>>> not cause an assert() due to an existing SCSI request being in progress.
>>>
>>
>> [*] See commits f3ace75be8..78d68f312a
>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2415
>>> ---
>>>   hw/scsi/esp.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Queued adding [*], thanks.
> 
> Awesome, thanks Phil!

I'm getting dubious timeout on the msys2 build on the SPARC target:
https://gitlab.com/philmd/qemu/-/jobs/7347774958

qemu:qtest+qtest-sparc / qtest-sparc/qom-test time out (After 900.0 seconds)
   1/151 qemu:qtest+qtest-sparc / qtest-sparc/qom-test 
TIMEOUT        900.38s   exit status 1
qemu:qtest+qtest-sparc / qtest-sparc/device-introspect-test time out 
(After 720.0 seconds)
   2/151 qemu:qtest+qtest-sparc / qtest-sparc/device-introspect-test 
TIMEOUT        720.23s   exit status 1
qemu:qtest+qtest-sparc / qtest-sparc/prom-env-test time out (After 360.0 
seconds)
   4/151 qemu:qtest+qtest-sparc / qtest-sparc/prom-env-test 
TIMEOUT        360.17s   exit status 1

Not sure this patch is the culprit, but since only SPARC is affected,
likely. I'll retest without this patch.

Regards,

Phil.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546CEEB3629
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx7R9-0000iN-6D; Mon, 02 Mar 2026 12:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx7R5-0000fx-OI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:52:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx7R4-0004SY-9U
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772473920;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDl7xgq+gBoH2IKSqL3C47Rc8PQTT6uJPJJTixwtt9I=;
 b=QrXoSUaa0XNBb0KYXQEjyUQCzqCntYiuEgEiBrK1KYCdFhxuPnMR4DfTAp0bTqfk3vcRtH
 BA8zltzfWhpcck8zT2VBmeOSi26laii2xrBAZBsgo+7PeDpCVECZcolk8TPE8NVvdJODFe
 0DJfZYCjLSmA7Ho3dpEhJQYtqbBbNzQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-0XPRBIdoOB6qbNBUQtNxGg-1; Mon, 02 Mar 2026 12:51:59 -0500
X-MC-Unique: 0XPRBIdoOB6qbNBUQtNxGg-1
X-Mimecast-MFC-AGG-ID: 0XPRBIdoOB6qbNBUQtNxGg_1772473918
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43993fea282so5066515f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 09:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772473918; x=1773078718;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDl7xgq+gBoH2IKSqL3C47Rc8PQTT6uJPJJTixwtt9I=;
 b=rsR6+8Dfcm0KeBVkSETCTWJUFNwIFgD9KAKffhtOzBtWaj3aj84I7ycGd+Uis+QH/F
 fDwfzOWwYDWak/R1/YtDktT5522QUXqULcd7Svtco8GKLktg6JhWqFxtPG7C79eLHwf2
 7fz8HbCvqIGpc66UsTj5wBV8HMMWo1nPI65wXyXVXRsWSjn12EcJe6jyTDKWMlpviW0S
 tkehMcuX0KXv05zc1wNZTIBjQL9KdeeDsp1wzZJpv0MuBjW3dfhqBmDvndjS1RpcnjSD
 49AqRoLPdta9NHLcLWChkgXJQMaLwtlrDzI9wqvLy7WuikkBtQAWqxFLqMrY5ALopsZM
 9hhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBwYBigULjNeSfXDXjwbB0lv8r+B1m4e1CYzgYD55Yg8FhywUTak47+vxzqe6Q+AKCC9WVBDmEPwmq@nongnu.org
X-Gm-Message-State: AOJu0Yz1TV67D8vLPbs5uGvLO3zxVoSeB3KXDlWTaPHo2Ix9gRODwLZE
 zji/bJlnN70Cm9M7AmeP5RjR80iRgypDlozCF/VI2OxUwdE6C9KRou/q9TjZOs8fXbrB8e5TPbP
 DWuQ0da6uAyYtiFfsBO/eZbrx+jH+TYAE22ZLAk7bxRffcOS7Iykq7vGM
X-Gm-Gg: ATEYQzzePD+qzR5VQmTReF0k6kYwnxfO97CSXtrt94Jt99+prS1LtgGvn9arA7p7+Un
 vXqPQYtqgSFdED54vusvNikgYlFAbYtYvMkKV2j+/H+G8d2aPQetFCr1PE1sCEsQs3z0H45EX/3
 ylPi1uljriXGCBmLjpne6nqU4ZMrrk9rW0gFIKk+iaxxLYvyxbmtjHrqPUumpvZ3g0Vs+3BF/66
 qvzn7S7QMG1cJjBMuy2mX6xKorC8dgywl6WiScW2LQzDosR8NBviBEQGEHhTSPID6SnxzZQzy6O
 5b5LXjaBkpQKmC2bwK8ZO4L8g0Uf7G9+Tk0ALW0thqSRPokDlKynkQQVyE2D1irODFhH9Jqppf3
 KNm/+O6he/gR93CRMCNYA4QoJR2m2e7yBCte+y20RtXv7nvmpfcMNhCEpiLL2YzXGKPsNXg==
X-Received: by 2002:a05:6000:1248:b0:439:a95b:3c44 with SMTP id
 ffacd0b85a97d-439a95b3e60mr10013509f8f.30.1772473917945; 
 Mon, 02 Mar 2026 09:51:57 -0800 (PST)
X-Received: by 2002:a05:6000:1248:b0:439:a95b:3c44 with SMTP id
 ffacd0b85a97d-439a95b3e60mr10013475f8f.30.1772473917460; 
 Mon, 02 Mar 2026 09:51:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c67sm30450502f8f.32.2026.03.02.09.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:51:57 -0800 (PST)
Message-ID: <11bf3187-7875-4894-9769-e2bd78fbd629@redhat.com>
Date: Mon, 2 Mar 2026 18:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 19/31] hw/arm/smmuv3: Fix CFGI_CD handling when stage-1
 is unsupported
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Mostafa Saleh <smostafa@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101733.2995020-1-tangtao1634@phytium.com.cn>
 <aaGu5v0To65M5LkB@google.com>
 <585be3ce-d5f3-455a-a7fb-3181920cfc60@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <585be3ce-d5f3-455a-a7fb-3181920cfc60@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/1/26 1:33 PM, Tao Tang wrote:
>
> Hi Mostafa,
>
> On 2026/2/27 PM10:49, Mostafa Saleh wrote:
>> On Sat, Feb 21, 2026 at 06:17:33PM +0800, Tao Tang wrote:
>>> Add a STAGE1_SUPPORTED check in the CMD_CFGI_CD and CMD_CFGI_CD_ALL path
>>> and return CERROR_ILL when stage-1 translation is not implemented,
>>> matching the architecture requirement (IHI 0070G.b, page 176).
>>>
>>> Fixes: 32cfd7f39e08 ("hw/arm/smmuv3: Cache/invalidate config data")
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> This is a separate fix, it can be sent standalone to make this series
>> smaller, similarly the first patch.
>
>
> For #1, #2 and #19 commit (this one), since I’m not fully sure about
> the expected process here, should I resend these already Reviewed-by
> fixes as standalone patch respectively right now,  and try to get them
> merged first?
>
>
>> Also the "Fixes" comment is not accurate, that was probably broken from
>> the stage-2 implementation which was added later.
>
>
> I'll remove "Fixes" when resending this commit.
>
Better to keep it after fixing it ;-)

Eric
>
>
>> Reviewed-by: Mostafa Saleh <smostafa@google.com>
>>
>> Thanks,
>> Mostafa
>
>
> Thanks for your review.
>
> Tao
>
>
>



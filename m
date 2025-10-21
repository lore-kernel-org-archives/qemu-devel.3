Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8F0CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB9DN-00033p-B1; Tue, 21 Oct 2025 06:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB9DK-00033J-Lk
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:03:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB9DI-0003VB-KK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 06:03:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso57068225e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761041010; x=1761645810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1axWyVGRyg48iv/Z+Xv2C7Pd7jYANzGPekLkLE+A/xc=;
 b=ohAIdmRPbotTYF5Xp6PBuE3ynRvH31HY1lrl+unm2OoIk/MtnNMw8EDvsRlM4JSbvh
 u/pA8gW+giPd6563VaWbBMXI1st6a8kfGqBkWAYbyb3PD/49Dr6uo1bCVcdGh80hVHc0
 VRp4N4ckmhWLc2LBDabzCC2NuFGI9I/f9aWi/EAR5cckcGid0axeHukblfxoAvzVMo1+
 /kApnJpocnS716IOvbhHnJIwfQ8lcKCsmDGV8K4BcnbGNhE3nAvYL6nHhbv7jRpDZsaT
 4bUQ16F35EYUA86mVisWVmwfB9vr8IhABZ1HGBXx7cQ8i2+7VHjBUJ30KvyezM0xRIlA
 Imgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761041010; x=1761645810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1axWyVGRyg48iv/Z+Xv2C7Pd7jYANzGPekLkLE+A/xc=;
 b=LGVs5OcLSvocbqo3R1e5FE7W4GKdkZ+NwLnf6SasDDkZbhv095TkPYtyRUMTvdqfEG
 NkC+z47hsftZfCKPW9wbwbdAtE1ZdHWS/EpFRiRVgVwJZRwz4RByA0+0ej7cHDdKSXFL
 Pt8M/aWPNxDvTgAjZRu7ILihh2R8b0xqaSVgxlrB9KcfGMakGjClhbEadux2IwRxX1Yz
 nNP6whbbqxNe6ooJUpaukqsV/t/hXU3TXnwSFuNhvlIH1YNkErqN1zTA+9kDJLxCLfG2
 YISpG5Nq2zrf4IXmEzB8Z2ZGO6z1z0hs8N2lHSqv1nIubJNWc79tw52EnCnZuKbXgy1I
 USMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1L8IOh1qFoQfr7/kY37cxFGfxCmNOb+mNMvcK5cijgn6CNm4McxJIqkU873SkxufDPGMOhq0nIWFb@nongnu.org
X-Gm-Message-State: AOJu0Yz7OR2MfaQPEDt3Y0zvhfbA/CQCCxQGsAc8+WmVst6CEr1aBaXw
 TAjmIdGQGau7IojkcrN/qR9Ar26s4MdyYnVOL9fBik11/5mn3AI2BBgrXJ5NNkT0bXQ=
X-Gm-Gg: ASbGncuKF84asBeKKv8PdFda/mSX/1txZiEEZ24jfCIixn1rRW1u13r1Pk6QIq+nFXt
 5Dus3oMcXPoHEAtiEhdqlgFCOGX75OBFYeR+5F9Aj8F569fmltnQOg8tX29q/pC6qxGq0xe3Dvp
 c7hSNdXFuuwKPprKIma1EAyyE2isSBVslo27oHA4HWiUyiUcuCzVkrvQqKe7JB7f6Yrg84o/ck6
 S+8Pogdw2vlTj+vsAE8VNeyL9zIeT+9kOSsvoLw/G+QRrTWUKFNW8L9Lyd5uhtppkPOqjfPGFbg
 SRBJ0KZaGLtEFtDsjyJcbRm2Ubzrcj3EiNJqJTQlxmBS4miQq1mO+H5CWkgrIWMXrXKFciGr+8z
 tz5oE18wMO8NGQufA2mHlSYfS+S47pN867nYpJkEDAX/YTj6b/Bw5wrhYWfFIocx0IDRXCK6Y1n
 NpE23emPr/0AHZJsQM5jmkZ98mQkSuypc2NqL+DUVl7Ebf3A6QvmqPgQ==
X-Google-Smtp-Source: AGHT+IEcqcAIb20xxq9m2joks9fak4yt1Uh6cr7KwLHC68Wf0NcFKa/aRL8/eYva7NiWs9aFiawwJg==
X-Received: by 2002:a05:600c:548c:b0:46d:5189:3583 with SMTP id
 5b1f17b1804b1-471177bad0dmr114203045e9.0.1761041010166; 
 Tue, 21 Oct 2025 03:03:30 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496c14a26sm13327635e9.4.2025.10.21.03.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 03:03:29 -0700 (PDT)
Message-ID: <82acf617-9585-4750-8bed-c32dbe651574@linaro.org>
Date: Tue, 21 Oct 2025 12:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/43] audio: rename AudioState -> AudioBE
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-35-marcandre.lureau@redhat.com>
 <1bd34160-d034-465b-a1ac-0e734ed40484@redhat.com>
 <d26b8838-c4a9-443f-a651-f46901a40865@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d26b8838-c4a9-443f-a651-f46901a40865@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 21/10/25 11:40, Paolo Bonzini wrote:
> On 10/21/25 11:30, Paolo Bonzini wrote:
>> On 10/21/25 11:03, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Naming is hard. But in general in QEMU, a host "backend" is the term
>>> used to fullfill the request made by the device "frontend".
>>>
>>> Note that "audiodev" is the corresponding QAPI type name (or 
>>> configuration).
>>
>> BE and FE aren't used in existing code though.  Looking at current use:
>>
>> - BlockDriverState*/BlockBackend*
>>
>> - Chardev*/CharBackend
>>
>> - NetClientState*/NICState*
>>
>> ... it's actually quite common for the *frontend* to have a pointer or 
>> object of type FooBackend; that would give Audiodev* and AudioBackend*.
> 
> Hmm, I have to correct myself.
> 
> QEMUSoundCard's name field is basically unused, and QEMUSoundCard should 
> be just an Audiodev*.  There's no need for a separate AudioFE struct.

AudioBackend is still a better name than AudioBE though.

